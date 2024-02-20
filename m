Return-Path: <linux-kernel+bounces-72243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE3385B116
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 04:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F296B1C23D23
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 03:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97DDD41C66;
	Tue, 20 Feb 2024 03:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gSpg7uwO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C539937149
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 03:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708398321; cv=none; b=fgTBx6N0+c4kdOFXUFahGoVmNGMstq95+3DVa5mOsSjcM0Km1ZJvPyaMRu/+kHpx9ZGa04Tl2b+59CVJw9RT+u7TrijgEw2cpuaquHodE04NE3sTl6w27f1fSJe7axYExieiuivs7uFghtVExlqv9IK01xfSiB3obRW+cN4ltAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708398321; c=relaxed/simple;
	bh=+tfAXhVtTC6pq1OPn+yGAci7jdJF3j4hCVF062HVva0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=pXgesiZ2P9LtfALTwPxPRlsPWwrFmtcliDuV2qkP9CdLP61fKppcPt0VWVxwb1kXyz8t7TYBHijBEPmIff/vXgP8YZj1bZc+1UURzO9Sggu0zRCXCaqlmNb1kRWVt767tbDTjKHWWFMPh/PCAOA2OI+aQUhjaMoqHTOMmSjYMF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gSpg7uwO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABA17C433F1;
	Tue, 20 Feb 2024 03:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1708398321;
	bh=+tfAXhVtTC6pq1OPn+yGAci7jdJF3j4hCVF062HVva0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gSpg7uwOorEiTlSFPMn3bmd8RFy5X0sV6DprT3cF9kcqvlRe5BoKC7zSftTxXS0BT
	 rEqkikktHOQCA9EWHU32J4ukeENAu8eVkqc/sypeyVaC7rweKUTkPp1mpXP6A6UwWj
	 uOQC9DW7y16TPsp1bCzorFMxCPlTIW5TXck3cqQc=
Date: Mon, 19 Feb 2024 19:05:20 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Byungchul Park <byungchul@sk.com>
Cc: "Huang, Ying" <ying.huang@intel.com>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, kernel_team@skhynix.com
Subject: Re: [PATCH v4] sched/numa, mm: do not try to migrate memory to
 memoryless nodes
Message-Id: <20240219190520.b5e373273ec743aacbad263b@linux-foundation.org>
In-Reply-To: <20240220015343.GD65758@system.software.com>
References: <20240219041920.1183-1-byungchul@sk.com>
	<87o7ccrghz.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<20240219174508.bc6256248a163c3ab9a58369@linux-foundation.org>
	<20240220015343.GD65758@system.software.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Feb 2024 10:53:43 +0900 Byungchul Park <byungchul@sk.com> wrote:

> > > IIUC, you will use patch as fix to the issue in
> > > 
> > > https://lore.kernel.org/lkml/20240216111502.79759-1-byungchul@sk.com/
> > > 
> > > If so, we need the Fixes: tag to make it land in -stable properly.
> > 
> > Yes, this changelog is missing rather a lot of important information.
> 
> This is not the root cause fix any more but just optimization.

It would have been helpful to have told us this in the changelog :(

> That's
> why I didn't add Fixes: tag and cc stable@vger.kernel.org in here.
> 
> Instead, I added Fixes: tag and cc'ed stable@vger.kernel.org in the real
> fix patch. check the following link please:
> 
> https://lore.kernel.org/lkml/20240216111502.79759-1-byungchul@sk.com/

But doesn't this patch "sched/numa, mm: do not try to migrate memory to
memoryless nodes" also fix the bug?  Do we truly need both?

