Return-Path: <linux-kernel+bounces-45398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DBC842FB2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BF75B247F3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 22:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014CF78673;
	Tue, 30 Jan 2024 22:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NVmpFzgS"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8F478670
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 22:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706653828; cv=none; b=iNsa25vYWzoLertpqGXnDSsQOiSAUd//ICe2PuGBOCcoHg+ydsdtNjuErK9Vy2tiCaLIdgEUcSO3lfW1XNAF1QywFywQH+t/Sy/lKFvlMUB1SUaBLDMpi/hngvDRo5LhKC0BHcjQjrPtGBZzreM/NrOL09uzwo+Gb+RJvS+7rAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706653828; c=relaxed/simple;
	bh=prXItL6I4SWZhdCCRg7GcchHoExrps0/zZ36uxyxJys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=RTZWsnekognjBaZlXxAgBcV2OwjbRf/fYA5RkhVZ/de65a0Sz+sfuYPwTxfa/aUs6QSb8s6dpSF0Vkw1B6HHbID2VnvL6Bv6oSDgQxmYJB/1N+gF3DzcPzftARddm/CrZS4MF1mszE07GIZ02cEXnTYMqlCsawIEL+kx9+wyoVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=NVmpFzgS; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240130223023euoutp028500696f0f2c8eaff70f777df1a9f072~vQJwzKyMd1153511535euoutp02B
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 22:30:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240130223023euoutp028500696f0f2c8eaff70f777df1a9f072~vQJwzKyMd1153511535euoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1706653823;
	bh=eCV+9A37oioyP0aKX+8sFtKZrg0hTroSnZvVtofBoDk=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=NVmpFzgSa9A1AGt/HARFt7MpMOG2+t/JcDFC+NHhIPXDMv5i1yx871D3CNaZDe3fy
	 piV0hWQbKvBYTTe0110URedAx6GJRfCyz4fUVK5FMAQ2LI10QXJ/0G13KY12lPr0MI
	 gJUaZCjQi99s8nva5rUBox7uarFTm5RQLrM2MO1Q=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240130223022eucas1p265fe285e0188a05ef1a6bd8e591f695f~vQJwGNKwB1125411254eucas1p27;
	Tue, 30 Jan 2024 22:30:22 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 16.59.09539.E7879B56; Tue, 30
	Jan 2024 22:30:22 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240130223021eucas1p1172b060d53847b8b77f6455d6257528e~vQJvXQZQW0313203132eucas1p1b;
	Tue, 30 Jan 2024 22:30:21 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240130223021eusmtrp22c96177dd10d2305194d978f48ec6aa4~vQJvWu8Tm0417604176eusmtrp2P;
	Tue, 30 Jan 2024 22:30:21 +0000 (GMT)
X-AuditID: cbfec7f2-52bff70000002543-8c-65b9787eec74
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 02.1A.09146.D7879B56; Tue, 30
	Jan 2024 22:30:21 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240130223021eusmtip276d4324e5242be0039df7efb6021d209~vQJu4Ez7_3027530275eusmtip2G;
	Tue, 30 Jan 2024 22:30:21 +0000 (GMT)
Message-ID: <91eacde0-df99-4d5c-a980-91046f66e612@samsung.com>
Date: Tue, 30 Jan 2024 23:30:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/10] workqueue: Implement system-wide nr_active
 enforcement for unbound workqueues
Content-Language: en-US
To: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-kernel@vger.kernel.org, Naohiro.Aota@wdc.com, kernel-team@meta.com
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <ZbfrEx9nnkr0FnZE@slm.duckdns.org>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEKsWRmVeSWpSXmKPExsWy7djP87p1FTtTDebfVbaYunY3k8W+i2vY
	LC7vmsNmMfH4ZlaLX8uPMjqweuycdZfdY9OqTjaPcxcrPD5vkvNoP9DNFMAaxWWTkpqTWZZa
	pG+XwJXxq82zoMWt4uqe64wNjN8suhg5OSQETCQm/9jF1sXIxSEksIJRovPlXijnC6PExNOT
	2CGcz4wS9369ZoFp+TVlCRNEYjlQy8x/zBDOR0aJry9OsoJU8QrYSRy42QTWwSKgKtGz7hAj
	RFxQ4uTMJ2BxUQF5ifu3ZrCD2MICuRJTd04A62UWEJe49WQ+E4gtIuAqsXTCOqi4j8SEFw/Z
	QGw2AUOJrrddYDangL7Ewn8LmSFq5CWat84GO0hC4ASHxOnN+4EGcQA5LhKfd/pBfCAs8er4
	FnYIW0bi/875TBD17YwSC37fh3ImMEo0PL/FCFFlLXHn3C82kEHMApoS63fpQ4QdJSavOcsK
	MZ9P4sZbQYgb+CQmbZvODBHmlehoE4KoVpOYdXwd3NqDFy4xT2BUmoUUKrOQfD8LyTezEPYu
	YGRZxSieWlqcm55abJiXWq5XnJhbXJqXrpecn7uJEZhsTv87/mkH49xXH/UOMTJxMB5ilOBg
	VhLhXSm3M1WINyWxsiq1KD++qDQntfgQozQHi5I4r2qKfKqQQHpiSWp2ampBahFMlomDU6qB
	qXnFX4byX39ecBpMXvh7992nkiw/Y14vPrZ+IUPu5sIl/9wt/juw2nvUvDBhZnrt5W7Yb7bn
	zk2rjdfevfnyU/LXxvytHzclCHfUBLKpvjrdGfx3561GnozbaQdeCi5fo9qz+tTp47pyLxn9
	daM/OaW8P1gl4t/+Maz0ufK1lin+dxd9kdm45Vmq7TyPFYz+xvYq/KsLwvO13MXfhuZdK0tf
	NJHVj2f6obUV9U9Zy0packXuaoUd7d+iaMT70ahgiepdk58Hmnft/Xup9MjqUwskLZOCoirD
	xVnPxBY6hRw/3jqhSlG86c32OY9CZr3xaVQ8vKdjf+PrjdMbdu9vFq05JpS01Px1J0doX2vf
	UiWW4oxEQy3mouJEAL6tOj6lAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCIsWRmVeSWpSXmKPExsVy+t/xe7q1FTtTDfqadSymrt3NZLHv4ho2
	i8u75rBZTDy+mdXi1/KjjA6sHjtn3WX32LSqk83j3MUKj8+b5DzaD3QzBbBG6dkU5ZeWpCpk
	5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GX8avMsaHGruLrnOmMD
	4zeLLkZODgkBE4lfU5YwdTFycQgJLGWU6Piymw0iISNxcloDK4QtLPHnWhcbRNF7Rokb1+Yw
	giR4BewkDtxsYgGxWQRUJXrWHYKKC0qcnPkELC4qIC9x/9YMdhBbWCBXYurOCWBDmQXEJW49
	mc8EYosIuEosnbAOKu4jMeHFQ7AjhATOMEp07RABsdkEDCW63naBxTkF9CUW/lvIDFFvJtG1
	tYsRwpaXaN46m3kCo9AsJGfMQrJuFpKWWUhaFjCyrGIUSS0tzk3PLTbUK07MLS7NS9dLzs/d
	xAiMrm3Hfm7ewTjv1Ue9Q4xMHIyHGCU4mJVEeFfK7UwV4k1JrKxKLcqPLyrNSS0+xGgKDIuJ
	zFKiyfnA+M4riTc0MzA1NDGzNDC1NDNWEuf1LOhIFBJITyxJzU5NLUgtgulj4uCUamDKD9w0
	p9Ts5w/B1b93Oaczv77xa6bWXrO+KQf3T5m1Ratgr9oLw9D8Q+dmfCmuPGRzVvN+n4iMyr+P
	LTNOsHsryMr0GGb2urVM0LRTWLz87TSW31+qrARDXraVneJV6nWIyHiXKD+veG37K9NHLmFv
	A9t+1dz7zL3Y4ebyky81XK9Nnfpoffy5ye6JO70CY14H7jn/4blK6BaOsMdNCx/fMjY4f8jt
	xespU8RXhUp2T/4oNsO+/Gfxh5VmJTa+nF+Oly/YcfAcf27A7AMzjGXPOGTKMMjPidBa991a
	4heTpm3m3qbmqSx8cvap16rZjzO3H7wWOPUfN8vUmZLeUu9ny0nNzT7pqnXz+LolObvklFiK
	MxINtZiLihMB3YdKIjcDAAA=
X-CMS-MailID: 20240130223021eucas1p1172b060d53847b8b77f6455d6257528e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240130223021eucas1p1172b060d53847b8b77f6455d6257528e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240130223021eucas1p1172b060d53847b8b77f6455d6257528e
References: <20240125170628.2017784-1-tj@kernel.org>
	<20240125170628.2017784-10-tj@kernel.org>
	<CAJhGHyAuoGNmaaDa0p+wiJMprXYVYnVV75PS4+kPy-fsPJVH8w@mail.gmail.com>
	<ZbfrEx9nnkr0FnZE@slm.duckdns.org>
	<CGME20240130223021eucas1p1172b060d53847b8b77f6455d6257528e@eucas1p1.samsung.com>

Dear All,

On 29.01.2024 19:14, Tejun Heo wrote:
> From: Tejun Heo <tj@kernel.org>
> Date: Mon, 29 Jan 2024 08:11:25 -1000
>
> A pool_workqueue (pwq) represents the connection between a workqueue and a
> worker_pool. One of the roles that a pwq plays is enforcement of the
> max_active concurrency limit. Before 636b927eba5b ("workqueue: Make unbound
> workqueues to use per-cpu pool_workqueues"), there was one pwq per each CPU
> for per-cpu workqueues and per each NUMA node for unbound workqueues, which
> was a natural result of per-cpu workqueues being served by per-cpu pools and
> unbound by per-NUMA pools.
>
> In terms of max_active enforcement, this was, while not perfect, workable.
> For per-cpu workqueues, it was fine. For unbound, it wasn't great in that
> NUMA machines would get max_active that's multiplied by the number of nodes
> but didn't cause huge problems because NUMA machines are relatively rare and
> the node count is usually pretty low.
>
> However, cache layouts are more complex now and sharing a worker pool across
> a whole node didn't really work well for unbound workqueues. Thus, a series
> of commits culminating on 8639ecebc9b1 ("workqueue: Make unbound workqueues
> to use per-cpu pool_workqueues") implemented more flexible affinity
> mechanism for unbound workqueues which enables using e.g. last-level-cache
> aligned pools. In the process, 636b927eba5b ("workqueue: Make unbound
> workqueues to use per-cpu pool_workqueues") made unbound workqueues use
> per-cpu pwqs like per-cpu workqueues.
>
> While the change was necessary to enable more flexible affinity scopes, this
> came with the side effect of blowing up the effective max_active for unbound
> workqueues. Before, the effective max_active for unbound workqueues was
> multiplied by the number of nodes. After, by the number of CPUs.
>
> 636b927eba5b ("workqueue: Make unbound workqueues to use per-cpu
> pool_workqueues") claims that this should generally be okay. It is okay for
> users which self-regulates concurrency level which are the vast majority;
> however, there are enough use cases which actually depend on max_active to
> prevent the level of concurrency from going bonkers including several IO
> handling workqueues that can issue a work item for each in-flight IO. With
> targeted benchmarks, the misbehavior can easily be exposed as reported in
> http://lkml.kernel.org/r/dbu6wiwu3sdhmhikb2w6lns7b27gbobfavhjj57kwi2quafgwl@htjcc5oikcr3.
>
> Unfortunately, there is no way to express what these use cases need using
> per-cpu max_active. A CPU may issue most of in-flight IOs, so we don't want
> to set max_active too low but as soon as we increase max_active a bit, we
> can end up with unreasonable number of in-flight work items when many CPUs
> issue IOs at the same time. ie. The acceptable lowest max_active is higher
> than the acceptable highest max_active.
>
> Ideally, max_active for an unbound workqueue should be system-wide so that
> the users can regulate the total level of concurrency regardless of node and
> cache layout. The reasons workqueue hasn't implemented that yet are:
>
> - One max_active enforcement decouples from pool boundaires, chaining
>    execution after a work item finishes requires inter-pool operations which
>    would require lock dancing, which is nasty.
>
> - Sharing a single nr_active count across the whole system can be pretty
>    expensive on NUMA machines.
>
> - Per-pwq enforcement had been more or less okay while we were using
>    per-node pools.
>
> It looks like we no longer can avoid decoupling max_active enforcement from
> pool boundaries. This patch implements system-wide nr_active mechanism with
> the following design characteristics:
>
> - To avoid sharing a single counter across multiple nodes, the configured
>    max_active is split across nodes according to the proportion of each
>    workqueue's online effective CPUs per node. e.g. A node with twice more
>    online effective CPUs will get twice higher portion of max_active.
>
> - Workqueue used to be able to process a chain of interdependent work items
>    which is as long as max_active. We can't do this anymore as max_active is
>    distributed across the nodes. Instead, a new parameter min_active is
>    introduced which determines the minimum level of concurrency within a node
>    regardless of how max_active distribution comes out to be.
>
>    It is set to the smaller of max_active and WQ_DFL_MIN_ACTIVE which is 8.
>    This can lead to higher effective max_weight than configured and also
>    deadlocks if a workqueue was depending on being able to handle chains of
>    interdependent work items that are longer than 8.
>
>    I believe these should be fine given that the number of CPUs in each NUMA
>    node is usually higher than 8 and work item chain longer than 8 is pretty
>    unlikely. However, if these assumptions turn out to be wrong, we'll need
>    to add an interface to adjust min_active.
>
> - Each unbound wq has an array of struct wq_node_nr_active which tracks
>    per-node nr_active. When its pwq wants to run a work item, it has to
>    obtain the matching node's nr_active. If over the node's max_active, the
>    pwq is queued on wq_node_nr_active->pending_pwqs. As work items finish,
>    the completion path round-robins the pending pwqs activating the first
>    inactive work item of each, which involves some pool lock dancing and
>    kicking other pools. It's not the simplest code but doesn't look too bad.
>
> v4: - wq_adjust_max_active() updated to invoke wq_update_node_max_active().
>
>      - wq_adjust_max_active() is now protected by wq->mutex instead of
>        wq_pool_mutex.
>
> v3: - wq_node_max_active() used to calculate per-node max_active on the fly
>        based on system-wide CPU online states. Lai pointed out that this can
>        lead to skewed distributions for workqueues with restricted cpumasks.
>        Update the max_active distribution to use per-workqueue effective
>        online CPU counts instead of system-wide and cache the calculation
>        results in node_nr_active->max.
>
> v2: - wq->min/max_active now uses WRITE/READ_ONCE() as suggested by Lai.
>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reported-by: Naohiro Aota <Naohiro.Aota@wdc.com>
> Link: http://lkml.kernel.org/r/dbu6wiwu3sdhmhikb2w6lns7b27gbobfavhjj57kwi2quafgwl@htjcc5oikcr3
> Fixes: 636b927eba5b ("workqueue: Make unbound workqueues to use per-cpu pool_workqueues")
> Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>

This patch landed in linux-next from 20240130 as commit 5797b1c18919 
("workqueue: Implement system-wide nr_active enforcement for unbound 
workqueues"). Unfortunately it causes the following regression on ARM64 
RK3568 SoC based Odroid-M1 board:

Unable to handle kernel paging request at virtual address ffff0002100296e0
Mem abort info:
   ESR = 0x0000000096000005
   EC = 0x25: DABT (current EL), IL = 32 bits
   SET = 0, FnV = 0
   EA = 0, S1PTW = 0
   FSC = 0x05: level 1 translation fault
Data abort info:
   ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
swapper pgtable: 4k pages, 48-bit VAs, pgdp=000000000255a000
[ffff0002100296e0] pgd=18000001ffff7003, p4d=18000001ffff7003, 
pud=0000000000000000
Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.8.0-rc2-next-20240130+ #14392
Hardware name: Hardkernel ODROID-M1 (DT)
pstate: 600000c9 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : wq_update_node_max_active+0x50/0x1fc
lr : wq_update_node_max_active+0x1f0/0x1fc
..
Call trace:
  wq_update_node_max_active+0x50/0x1fc
  apply_wqattrs_commit+0xf0/0x114
  apply_workqueue_attrs_locked+0x58/0xa0
  alloc_workqueue+0x5ac/0x774
  workqueue_init_early+0x460/0x540
  start_kernel+0x258/0x684
  __primary_switched+0xb8/0xc0
Code: 9100a273 35000d01 53067f00 d0016dc1 (f8607a60)
---[ end trace 0000000000000000 ]---
Kernel panic - not syncing: Attempted to kill the idle task!
---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---

This wasn't trivial to bisect, because next-20240130 suffers from other 
regressions: 
https://lore.kernel.org/all/30ddedc9-0829-4a99-9cb1-39190937981c@samsung.com/ 
but reverting this change and the ones mentioned in that thread fixes 
all the issues observed on top of today's linux-next release. Let me 
know if there is anything I can do to help fixing this issue.

> ---
>   include/linux/workqueue.h |  35 +++-
>   kernel/workqueue.c        | 341 ++++++++++++++++++++++++++++++++++----
>   2 files changed, 341 insertions(+), 35 deletions(-)

 > ...


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


