Return-Path: <linux-kernel+bounces-24997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C4382C5DB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 20:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20636281E89
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 19:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C6015E94;
	Fri, 12 Jan 2024 19:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="j1gqicPf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD2E14F63
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 19:25:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C58E6C43390;
	Fri, 12 Jan 2024 19:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1705087551;
	bh=zj+wrk3JU3+5ZfvCnM81nr4JfGpcqQFEcx5vMnuF40Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j1gqicPfwW+sqefG8tW1Y9VcYwQbES5rX7TWVmY5AlkUyNYYYqX90KBWlliAONQJs
	 VqHG2D46bPlY9nGlAx6JP1QINnzPrJeiI5vUUMwh84Udom1UxjTxG8jPMZA3T2A+2k
	 UonS7vOhpRtg7zrwf9X/LQ5GKX/dIG/KO6OCJ+Co=
Date: Fri, 12 Jan 2024 11:25:51 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: "Bang Li" <libang.li@antgroup.com>
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, =?UTF-8?Q?"?=
 =?UTF-8?Q?=E6=9C=B1=E8=BE=89(=E8=8C=B6=E6=B0=B4)"?=
 <teawater@antgroup.com>, "Yan Yan(cailing)" <yanyan.yan@antgroup.com>
Subject: Re: [PATCH] mm/compaction: Reduce unnecessary loops
Message-Id: <20240112112551.bbc9d5114fd2c6fb421fed2d@linux-foundation.org>
In-Reply-To: <20240112073524.80724-1-libang.li@antgroup.com>
References: <20240112073524.80724-1-libang.li@antgroup.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Jan 2024 15:35:24 +0800 "Bang Li" <libang.li@antgroup.com> wrote:

> Compaction will be triggered when we write 1 to '/proc/sys/vm/
> compact_memory'. During the execution of the process, when we send
> SIGKILL to terminate the compaction, the process does not exit
> immediately. Instead, it will continue to loop through the remaining
> zones and nodes before exiting.
> 
> in my environment:
> 
> [root]# cat /proc/buddyinfo
> Node 0, zone      DMA      1      1      1      0      2      1      1      0      1      1      3
> Node 0, zone    DMA32   1666   1123    804    625    488    356    321    278    209    178    250
> Node 0, zone   Normal  58852  83160  49983   9812   2287   1229  19604  24471  10346   5219  12205
> [root]# echo 1 > /sys/kernel/debug/tracing/events/compaction/mm_compaction_end/enable
> 
> before the patch:
> 
> [root]# timeout --signal=SIGKILL 0.002 bash -c 'echo 1 > /proc/sys/vm/compact_memory'
> [root]# cat /sys/kernel/debug/tracing/trace_pipe
>            <...>-26494   [014] .....   226.468993: mm_compaction_end: zone_start=0x1 migrate_pfn=0xe00 free_pfn=0xe00 zone_end=0x1000, mode=sync status=complete
>            <...>-26494   [014] .....   226.469718: mm_compaction_end: zone_start=0x1000 migrate_pfn=0x20a80 free_pfn=0xffe00 zone_end=0x100000, mode=sync status=contended
>            <...>-26494   [014] .....   226.469720: mm_compaction_end: zone_start=0x100000 migrate_pfn=0x100000 free_pfn=0x307fe00 zone_end=0x3080000, mode=sync status=contended
> 
> after the patch:
> 
> [root]# timeout --signal=SIGKILL 0.002 bash -c 'echo 1 > /proc/sys/vm/compact_memory'
> [root]# cat /sys/kernel/debug/tracing/trace_pipe
>            <...>-17491   [053] .....   109.005387: mm_compaction_end: zone_start=0x1 migrate_pfn=0xe00 free_pfn=0xe00 zone_end=0x1000, mode=sync status=complete
>            <...>-17491   [053] .....   109.006139: mm_compaction_end: zone_start=0x1000 migrate_pfn=0x22220 free_pfn=0xffe00 zone_end=0x100000, mode=sync status=contended
> 
> Although it exits quickly after receiving the SIGKILL signal, a better
> solution is to terminate the loop early after receiving the SIGKILL
> signal.
> 

What is the use case here?  The requirement?  Why is this change
valuable to anyone?

