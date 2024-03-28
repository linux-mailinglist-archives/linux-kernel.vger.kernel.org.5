Return-Path: <linux-kernel+bounces-122744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 532BE88FC68
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E88CFB23199
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6277BB01;
	Thu, 28 Mar 2024 10:06:30 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8EB5FBA7;
	Thu, 28 Mar 2024 10:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711620390; cv=none; b=GnQVB2JLD7ktMJbuy3UbNpVvyYQf7FJdbtIRxEyhBhMbl7UBWgL3exSC7EuuXwhB5cuvEGqqyvQJEQueyz03Jqfff8nlZo0gnj3dCjtUJT8kj1bTLqPlKb7SzxMp9wxAeSWysYa4+yikvE70PUi5VLn1LkGnIWTFg2yMWRkYG2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711620390; c=relaxed/simple;
	bh=KoV9EWm2WP6vyCwUzJIAVOD/ptSRjz9hScW/LbJkF6c=;
	h=From:Subject:To:CC:Message-ID:Date:MIME-Version:Content-Type; b=Eowvsnf6bf9sQXhQqUzgpUx+hGIwxQBl4Ei7Q5U9cA3i0OVdeAny0GxCjc8YOFSsotrWFmIQBKaTPsr4jjSQJdvkPFB21LlkBsWf0QtESw5Kigij3yqw/drorsdEU+/sckS+ro3fC7+sStGRSnhtV5G7PvuUXjO3g3CzHBp/c9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4V4zdW1KYMz1h4G7;
	Thu, 28 Mar 2024 18:03:43 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id 5FFE31A016C;
	Thu, 28 Mar 2024 18:06:23 +0800 (CST)
Received: from [10.174.185.179] (10.174.185.179) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Mar 2024 18:06:22 +0800
From: Zenghui Yu <yuzenghui@huawei.com>
Subject: [report] WARN_ON_ONCE triggered in for_each_sibling_event()
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>, <will@kernel.org>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>,
	<wanghaibin.wang@huawei.com>, <linux-arm-kernel@lists.infradead.org>
Message-ID: <d4491035-9f9c-d3c2-bd26-a5133d8233fe@huawei.com>
Date: Thu, 28 Mar 2024 18:06:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600007.china.huawei.com (7.193.23.208)

Hi folks,

The following splat is triggered when I execute `perf stat -e
smmuv3_pmcg_100020/config_cache_miss/` on mainline kernel (built with
arm64-defconfig + PROVE_LOCKING).

| ------------[ cut here ]------------
| WARNING: CPU: 36 PID: 72452 at drivers/perf/arm_smmuv3_pmu.c:434 
smmu_pmu_event_init+0x298/0x2b0 [arm_smmuv3_pmu]
| Modules linked in: xt_MASQUERADE iptable_nat xt_addrtype xt_conntrack 
nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c overlay 
ip6table_filter ip6_tables xt_tcpudp iptable_filter ip_tables x_tables 
md_mod arm_smmuv3_pmu hibmc_drm drm_vram_helper drm_ttm_helper ttm 
drm_kms_helper spi_dw_mmio spi_dw fuse drm backlight crct10dif_ce 
onboard_usb_hub xhci_pci xhci_pci_renesas hisi_sec2 hisi_qm uacce 
authenc ipmi_si ipmi_devintf ipmi_msghandler dm_mod br_netfilter bridge 
stp llc nvme nvme_core nbd ipv6
| CPU: 36 PID: 72452 Comm: perf Kdump: loaded Not tainted 
6.9.0-rc1-00061-g8d025e2092e2-dirty #1700
| Hardware name: Huawei TaiShan 2280 V2/BC82AMDDA, BIOS 1.05 09/18/2019
| pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
| pc : smmu_pmu_event_init+0x298/0x2b0 [arm_smmuv3_pmu]
| lr : smmu_pmu_event_init+0x290/0x2b0 [arm_smmuv3_pmu]
| sp : ffff8000c8ce3be0
| x29: ffff8000c8ce3be0 x28: 0000000000000000 x27: ffff8000802a2c1c
| x26: ffff8000c8ce3d70 x25: ffff8000802a2bc8 x24: 0000000000000000
| x23: 0000000000000001 x22: ffff0028045d52b0 x21: ffff002807228168
| x20: 0000000000000002 x19: ffff002807228000 x18: 0000000000000000
| x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
| x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000040
| x11: ffff0020804016d0 x10: ffff0020804016d2 x9 : ffff800083b29b18
| x8 : ffff0020804016f8 x7 : 0000000000000000 x6 : ffff0020804018c0
| x5 : ffff0020804016d0 x4 : ffff80007bf07a58 x3 : 0000000000000002
| x2 : ffff802f5db37000 x1 : 0000000000000000 x0 : 0000000000000000
| Call trace:
|  smmu_pmu_event_init+0x298/0x2b0 [arm_smmuv3_pmu]
|  perf_try_init_event+0x54/0x140|  perf_event_alloc+0x3e4/0x1080
|  __do_sys_perf_event_open+0x178/0xfa8
|  __arm64_sys_perf_event_open+0x28/0x34
|  invoke_syscall+0x48/0x114
|  el0_svc_common.constprop.0+0x40/0xe0
|  do_el0_svc+0x1c/0x28
|  el0_svc+0x4c/0x11c
|  el0t_64_sync_handler+0xc0/0xc4
|  el0t_64_sync+0x190/0x194
| irq event stamp: 174338
| hardirqs last  enabled at (174337): [<ffff800080357774>] 
___slab_alloc+0x3bc/0xf38
| hardirqs last disabled at (174338): [<ffff8000812a7ee0>] el1_dbg+0x24/0x8c
| softirqs last  enabled at (174292): [<ffff8000800185bc>] 
fpsimd_restore_current_state+0x34/0xc4
| softirqs last disabled at (174290): [<ffff80008001858c>] 
fpsimd_restore_current_state+0x4/0xc4
| ---[ end trace 0000000000000000 ]---

Note that this is not specific to the arm_smmuv3_pmu driver as I can
also reproduce it with some HiSilicon uncore PMU events (e.g., executing
`perf stat -e hisi_sccl1_ddrc0/flux_rd/`).

For your convenience, the assertion was added by commit f3c0eba28704
("perf: Add a few assertions").

Post it out for visibility, not sure if there are already similar
reports on the list though. Please have a look.

Thanks,
Zenghui

