Return-Path: <linux-kernel+bounces-123473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB42B890927
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61388283169
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208FB136E10;
	Thu, 28 Mar 2024 19:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m2il9thC"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04CF5FBA7
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 19:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711653884; cv=none; b=tjjwsqyP0X8cdLBlT64kc1UWvdA6fKcYjqPb5p2gtBvWfU23cYNs5aMJl061Qtu1ahQPLB0bIERJBajcbpDxuy/k7WfKg0SmCTYSDnu2JH55hgGp2lafbD6QmBOnFQ5DwD5eGcqBqoym7/u9n1o3twW47y2/9ZFEruhlD/rAU3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711653884; c=relaxed/simple;
	bh=6XZG890/2rbWhb+ptRtYtPnG3MltngGBZbjMg4Pwsqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Isc/orwvFhyBPsKfJi08UfZ6/vAjHUD+VntDJbR40NIyjrDoBy3goCNZSXhRAl015yyWiMSDKhG/ONMBP9dkVDr7MpcmyXH6S01IL1SAIFCx4KS9vYch7TszzF9zmCxSHnRvqKRGG10qVRFmNz4tHVutiFkohZiu8nm6qtN7dwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m2il9thC; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 28 Mar 2024 15:24:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711653879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9m7kxahkpOfFeAppA/MMdv3HWeGeBpfeH3QIkwZrNkM=;
	b=m2il9thCRTKZ8stq4jpdCpEaq3OwikSMrJtYMV+72gTc058M+1PwAFvIrCoszbJ+fy+KJU
	K6rFI1eMkpzFAq6UxFVhHH5CHlbdHcdYHU6iejVcrvQxJr27MDCbiXoH+quam4IUmx6jx6
	uCqiYYuf8PMX5e3gBLgHdFsiVe4+Ho0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, jack@suse.cz, 
	bfoster@redhat.com, tj@kernel.org, dsterba@suse.com, mjguzik@gmail.com, 
	dhowells@redhat.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] Improve visibility of writeback
Message-ID: <qyzaompqkxwdquqtofmqghvpi4m3twkrawn26rxs56aw4n2j3o@kt32f47dkjtu>
References: <20240327155751.3536-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327155751.3536-1-shikemeng@huaweicloud.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Mar 27, 2024 at 11:57:45PM +0800, Kemeng Shi wrote:
> v1->v2:
> -Send cleanup to wq_monitor.py separately.
> -Add patch to avoid use after free of bdi.
> -Rename wb_calc_cg_thresh to cgwb_calc_thresh as Tejun suggested.
> -Use rcu walk to avoid use after free.
> -Add debug output to each related patches.
> 
> This series tries to improve visilibity of writeback. Patch 1 make
> /sys/kernel/debug/bdi/xxx/stats show writeback info of whole bdi
> instead of only writeback info in root cgroup. Patch 2 add a new
> debug file /sys/kernel/debug/bdi/xxx/wb_stats to show per wb writeback
> info. Patch 4 add wb_monitor.py to monitor basic writeback info
> of running system, more info could be added on demand. Rest patches
> are some random cleanups. More details can be found in respective
> patches. Thanks!
> This series is on top of patchset [1].
> 
> [1] https://lore.kernel.org/lkml/20240123183332.876854-1-shikemeng@huaweicloud.com/T/#mc6455784a63d0f8aa1a2f5aff325abcdf9336b76

Not bad

I've been trying to improve our ability to debug latency issues - stalls
of all sorts. While you're looking at all this code, do you think you
could find some places to collect useful latency numbers?

fs/bcachefs/time_stats.c has some code that's going to be moving out to
lib/ at some point, after I switch it to MAD; if you could hook that up
as well to a few points we could see at a glance if there are stalls
happening in the writeback path.

> 
> Following domain hierarchy is tested:
>                 global domain (320G)
>                 /                 \
>         cgroup domain1(10G)     cgroup domain2(10G)
>                 |                 |
> bdi            wb1               wb2
> 
> /* all writeback info of bdi is successfully collected */
> # cat /sys/kernel/debug/bdi/252:16/stats:
> BdiWriteback:              448 kB
> BdiReclaimable:        1303904 kB
> BdiDirtyThresh:      189914124 kB
> DirtyThresh:         195337564 kB
> BackgroundThresh:     32516508 kB
> BdiDirtied:            3591392 kB
> BdiWritten:            2287488 kB
> BdiWriteBandwidth:      322248 kBps
> b_dirty:                     0
> b_io:                        0
> b_more_io:                   2
> b_dirty_time:                0
> bdi_list:                    1
> state:                       1
> 
> /* per wb writeback info is collected */
> # cat /sys/kernel/debug/bdi/252:16/wb_stats:
> cat wb_stats
> WbCgIno:                    1
> WbWriteback:                0 kB
> WbReclaimable:              0 kB
> WbDirtyThresh:              0 kB
> WbDirtied:                  0 kB
> WbWritten:                  0 kB
> WbWriteBandwidth:      102400 kBps
> b_dirty:                    0
> b_io:                       0
> b_more_io:                  0
> b_dirty_time:               0
> state:                      1
> WbCgIno:                 4284
> WbWriteback:              448 kB
> WbReclaimable:         818944 kB
> WbDirtyThresh:        3096524 kB
> WbDirtied:            2266880 kB
> WbWritten:            1447936 kB
> WbWriteBandwidth:      214036 kBps
> b_dirty:                    0
> b_io:                       0
> b_more_io:                  1
> b_dirty_time:               0
> state:                      5
> WbCgIno:                 4325
> WbWriteback:              224 kB
> WbReclaimable:         819392 kB
> WbDirtyThresh:        2920088 kB
> WbDirtied:            2551808 kB
> WbWritten:            1732416 kB
> WbWriteBandwidth:      201832 kBps
> b_dirty:                    0
> b_io:                       0
> b_more_io:                  1
> b_dirty_time:               0
> state:                      5
> 
> /* monitor writeback info */
> # ./wb_monitor.py 252:16 -c
>                   writeback  reclaimable   dirtied   written    avg_bw
> 252:16_1                  0            0         0         0    102400
> 252:16_4284             672       820064   9230368   8410304    685612
> 252:16_4325             896       819840  10491264   9671648    652348
> 252:16                 1568      1639904  19721632  18081952   1440360
> 
> 
>                   writeback  reclaimable   dirtied   written    avg_bw
> 252:16_1                  0            0         0         0    102400
> 252:16_4284             672       820064   9230368   8410304    685612
> 252:16_4325             896       819840  10491264   9671648    652348
> 252:16                 1568      1639904  19721632  18081952   1440360
> ...
> 
> Kemeng Shi (6):
>   writeback: protect race between bdi release and bdi_debug_stats_show
>   writeback: collect stats of all wb of bdi in bdi_debug_stats_show
>   writeback: support retrieving per group debug writeback stats of bdi
>   writeback: add wb_monitor.py script to monitor writeback info on bdi
>   writeback: rename nr_reclaimable to nr_dirty in balance_dirty_pages
>   writeback: define GDTC_INIT_NO_WB to null
> 
>  include/linux/writeback.h     |   1 +
>  mm/backing-dev.c              | 203 ++++++++++++++++++++++++++++++----
>  mm/page-writeback.c           |  31 ++++--
>  tools/writeback/wb_monitor.py | 172 ++++++++++++++++++++++++++++
>  4 files changed, 378 insertions(+), 29 deletions(-)
>  create mode 100644 tools/writeback/wb_monitor.py
> 
> -- 
> 2.30.0
> 

