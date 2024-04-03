Return-Path: <linux-kernel+bounces-130530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28443897979
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA1981F272F1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27311155A29;
	Wed,  3 Apr 2024 19:59:16 +0000 (UTC)
Received: from mailscanner01.zoner.fi (mailscanner01.zoner.fi [84.34.166.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE961553A1
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 19:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.34.166.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712174355; cv=none; b=WFJR/eS024rUnR0ZTJjSJj3Q1QqCmitOOsOY7hhrQ+uMtwDKMgMaDOEeHM6N+MYh+DOFEJttQDP3PgZke8EPum7SvED4PnrnfA+vzoBR8Ka3M1XQ7wC1N1IYACsFlPGaqUeWS9ReytyysTmnHWvMMZGM160PsR5VOMWAnWbBwwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712174355; c=relaxed/simple;
	bh=KR9CdPgMOf6FrLUtHF73U+GXxBqurEfaGjwrIK7zXhc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DQ4bqg9o4fS4ZhPFuRhUEBAiLuw2tCgXoYcJ0teZRQeLjKndmqvB72GJrMAD6bZKVLannYUqH/Z0dHH3EGlKdmKqv4aRS6w1vPwUtKLNdBu5VSTVP2ysBzYzOR47BW/6/exea/U7SkCXLe+9/XoBY/Yy5W4XZT9FyyMcYMA6KMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tukaani.org; spf=pass smtp.mailfrom=tukaani.org; arc=none smtp.client-ip=84.34.166.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tukaani.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tukaani.org
Received: from www25.zoner.fi (www25.zoner.fi [84.34.147.45])
	by mailscanner01.zoner.fi (Postfix) with ESMTPS id A88F342E21;
	Wed,  3 Apr 2024 22:59:04 +0300 (EEST)
Received: from mail.zoner.fi ([84.34.147.244])
	by www25.zoner.fi with esmtp (Exim 4.96.1-7-g79877b70e)
	(envelope-from <lasse.collin@tukaani.org>)
	id 1rs6lE-0006L7-1i;
	Wed, 03 Apr 2024 22:59:04 +0300
Date: Wed, 3 Apr 2024 22:59:03 +0300
From: Lasse Collin <lasse.collin@tukaani.org>
To: <angel.lkml@16bits.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jubin Zhong
 <zhongjubin@huawei.com>, linux-kernel@vger.kernel.org,
 vegard.nossum@oracle.com
Subject: Re: [PATCH 11/11] xz: Adjust arch-specific options for better
 kernel compression
Message-ID: <20240403225903.0773746d@kaneli>
In-Reply-To: <27db456edeb6f72e7e229c2333c5d8449718c26e.camel@16bits.net>
References: <20240320183846.19475-1-lasse.collin@tukaani.org>
	<20240320183846.19475-12-lasse.collin@tukaani.org>
	<27db456edeb6f72e7e229c2333c5d8449718c26e.camel@16bits.net>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On 2024-03-31 angel.lkml@16bits.net wrote:
> Under the light of the recent xz backdoor, I should note that this
> patch (patch 11) does:
> 
> > +# Set XZ_VERSION (and LIBLZMA_VERSION). This is needed to disable
> > features +# that aren't available in old XZ Utils versions.
> > +eval "$($XZ --robot --version)" || exit

The eval method has been on the xz man page for a very long time but I
agree that due to the recent events the above method is not ideal.

It can break also if XZ_OPT or XZ_DEFAULTS contains something that they
usually shouldn't. For example, XZ_OPT=--help would make the above eval
method run the output of $XZ --help.

> So, in the spirit of keeping a fair amount of paranoia, and since it
> doesn't do any harm, any such code should be failproofed to ensure it
> can only import the expected shell variables with the right format[3]:
>
>  eval "$($XZ --robot --version | grep '^\(XZ\|LIBLZMA\)_VERSION=[0-9]*$')" || exit

I would rather get rid of eval. I committed the following to the
upstream repository:

XZ_VERSION=$($XZ --robot --version | sed -n 's/^XZ_VERSION=//p') || exit

Thanks!

-- 
Lasse Collin

