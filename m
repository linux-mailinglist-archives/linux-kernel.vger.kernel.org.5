Return-Path: <linux-kernel+bounces-131571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A990F89899E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E7CB1F2BEF7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1A312C819;
	Thu,  4 Apr 2024 14:08:52 +0000 (UTC)
Received: from mailscanner05.zoner.fi (mailscanner05.zoner.fi [5.44.246.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4404312B14B
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 14:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.44.246.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712239732; cv=none; b=UAnN91287xtJ4WM+SdonfBZSgxyFbNzdAkbqRZ95JhHxrepYShBymOFZg7WZA4wfruhex2P1lCuHBKtYVgUpDIvC92ETYCPPl54UNO3UMri/RzLxxYsYrSqPxAnnHLFZx+/8hDWpahCCU4zCPfXOwgKxvkPgk/h6KdVLvHZHQ/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712239732; c=relaxed/simple;
	bh=M6DblwVE8DiuDynQ1JBmK+7fzA81IsqT2VdwDG2Puho=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JlxbLZIlt+EpKCW2gokPF3KeWolz3GPN35UocuYZmiAWnjjx7/dWC2xJ5a15LkCyjawwbpIzXItjy+wx7do+1K7GudJZ119XDtfgSYylXVqp630Sfr96Uv+dxmLgIs8MaOBALYMliXStzzYcgdLVMvkPqNGYJ2hXKoh6ijKc+TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tukaani.org; spf=pass smtp.mailfrom=tukaani.org; arc=none smtp.client-ip=5.44.246.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tukaani.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tukaani.org
Received: from www25.zoner.fi (www25.zoner.fi [84.34.147.45])
	by mailscanner05.zoner.fi (Postfix) with ESMTPS id CBA03212D6;
	Thu,  4 Apr 2024 17:01:18 +0300 (EEST)
Received: from mail.zoner.fi ([84.34.147.244])
	by www25.zoner.fi with esmtp (Exim 4.96.1-7-g79877b70e)
	(envelope-from <lasse.collin@tukaani.org>)
	id 1rsNeY-00084X-2E;
	Thu, 04 Apr 2024 17:01:18 +0300
Date: Thu, 4 Apr 2024 17:01:03 +0300
From: Lasse Collin <lasse.collin@tukaani.org>
To: <angel.lkml@16bits.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jubin Zhong
 <zhongjubin@huawei.com>, linux-kernel@vger.kernel.org,
 vegard.nossum@oracle.com
Subject: Re: [PATCH 11/11] xz: Adjust arch-specific options for better
 kernel compression
Message-ID: <20240404170103.1bc382b3@kaneli>
In-Reply-To: <20240403225903.0773746d@kaneli>
References: <20240320183846.19475-1-lasse.collin@tukaani.org>
	<20240320183846.19475-12-lasse.collin@tukaani.org>
	<27db456edeb6f72e7e229c2333c5d8449718c26e.camel@16bits.net>
	<20240403225903.0773746d@kaneli>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On 2024-04-03 Lasse Collin wrote:
> On 2024-03-31 angel.lkml@16bits.net wrote:
> > So, in the spirit of keeping a fair amount of paranoia, and since it
> > doesn't do any harm, any such code should be failproofed to ensure
> > it can only import the expected shell variables with the right
> > format[3]:
> >
> >  eval "$($XZ --robot --version | grep
> > '^\(XZ\|LIBLZMA\)_VERSION=[0-9]*$')" || exit  
> 
> I would rather get rid of eval. I committed the following to the
> upstream repository:
> 
> XZ_VERSION=$($XZ --robot --version | sed -n 's/^XZ_VERSION=//p') ||
> exit

Both my new version and the suggested eval+grep version have error
detection issues:

  - With the eval+grep version, if there are no matches, eval gets an
    empty string as an argument in which case eval's exit status is
    zero and "exit" won't be run. Exit status from $XZ is ignored.
    XZ_VERSION won't be set or it might be inherited from the
    environment.

  - With $XZ ... | sed ..., the exit status of $XZ is ignored. sed
    will exit with 0 and thus "exit" won't be run even if $XZ fails.

Upstream I changed to this:

XZ_VERSION=$($XZ --robot --version) || exit
XZ_VERSION=$(printf '%s\n' "$XZ_VERSION" | sed -n 's/^XZ_VERSION=//p')

If output from $XZ is weird, XZ_VERSION might still become weird too.
But the way the variable is used later should at worst result in
"integer expression expected" error message.

I think the above is a good enough balance for a shell script like
this.

-- 
Lasse Collin

