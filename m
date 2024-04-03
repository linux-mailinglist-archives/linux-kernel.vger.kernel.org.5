Return-Path: <linux-kernel+bounces-129454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F00896B05
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7066528CD39
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B1B1350CC;
	Wed,  3 Apr 2024 09:48:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01396EB4B;
	Wed,  3 Apr 2024 09:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712137719; cv=none; b=Z5NGp1vZZ9M+2/d2l/O7rDpoY0ZbH/y3UBPxnLcR1nV71lpwKOL0v/re+5uqaq6OQR5hOwoq3/llm4IT8frW4r0xl/ffZfdeSqQruUkMXxHwDBBHq26SSn58F7c2JSkFy03QKZGu3tN9SJvy/1I+XiFTMDC4XW2E31IPBNf8ZmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712137719; c=relaxed/simple;
	bh=F82JaR9RdyJNFxUkurbYF8bxOODLnktjKcHEfsByIV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n1wU9jWICoAdsW5xHyt47r2vNPorrdzPRMEGgM4RsKHheBq0NWzbBO5i3QoiqB3XAapvrHiOO8WiI8voaD3wigIRKmTkQfOvPt6odDuOyaf2uU8C3V00PYSPW5SbDoXdYUSa4kLWcAGd8nGKDB9iWL/zj+DiWk8DD8KZl1yJPeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 56D49FEC;
	Wed,  3 Apr 2024 02:49:07 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.16.212])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C7D463F7B4;
	Wed,  3 Apr 2024 02:48:33 -0700 (PDT)
Date: Wed, 3 Apr 2024 10:48:27 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Zenghui Yu <yuzenghui@huawei.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	namhyung@kernel.org, will@kernel.org,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	wanghaibin.wang@huawei.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [report] WARN_ON_ONCE triggered in for_each_sibling_event()
Message-ID: <Zg0l642PgQ7T3a8Z@FVFF77S0Q05N>
References: <d4491035-9f9c-d3c2-bd26-a5133d8233fe@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4491035-9f9c-d3c2-bd26-a5133d8233fe@huawei.com>

On Thu, Mar 28, 2024 at 06:06:21PM +0800, Zenghui Yu wrote:
> Hi folks,

Hi Zenghui,

> The following splat is triggered when I execute `perf stat -e
> smmuv3_pmcg_100020/config_cache_miss/` on mainline kernel (built with
> arm64-defconfig + PROVE_LOCKING).
> 
> | ------------[ cut here ]------------
> | WARNING: CPU: 36 PID: 72452 at drivers/perf/arm_smmuv3_pmu.c:434
> smmu_pmu_event_init+0x298/0x2b0 [arm_smmuv3_pmu]
> | Modules linked in: xt_MASQUERADE iptable_nat xt_addrtype xt_conntrack
> nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c overlay
> ip6table_filter ip6_tables xt_tcpudp iptable_filter ip_tables x_tables
> md_mod arm_smmuv3_pmu hibmc_drm drm_vram_helper drm_ttm_helper ttm
> drm_kms_helper spi_dw_mmio spi_dw fuse drm backlight crct10dif_ce
> onboard_usb_hub xhci_pci xhci_pci_renesas hisi_sec2 hisi_qm uacce authenc
> ipmi_si ipmi_devintf ipmi_msghandler dm_mod br_netfilter bridge stp llc nvme
> nvme_core nbd ipv6
> | CPU: 36 PID: 72452 Comm: perf Kdump: loaded Not tainted
> 6.9.0-rc1-00061-g8d025e2092e2-dirty #1700
> | Hardware name: Huawei TaiShan 2280 V2/BC82AMDDA, BIOS 1.05 09/18/2019
> | pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> | pc : smmu_pmu_event_init+0x298/0x2b0 [arm_smmuv3_pmu]
> | lr : smmu_pmu_event_init+0x290/0x2b0 [arm_smmuv3_pmu]
> | sp : ffff8000c8ce3be0
> | x29: ffff8000c8ce3be0 x28: 0000000000000000 x27: ffff8000802a2c1c
> | x26: ffff8000c8ce3d70 x25: ffff8000802a2bc8 x24: 0000000000000000
> | x23: 0000000000000001 x22: ffff0028045d52b0 x21: ffff002807228168
> | x20: 0000000000000002 x19: ffff002807228000 x18: 0000000000000000
> | x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
> | x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000040
> | x11: ffff0020804016d0 x10: ffff0020804016d2 x9 : ffff800083b29b18
> | x8 : ffff0020804016f8 x7 : 0000000000000000 x6 : ffff0020804018c0
> | x5 : ffff0020804016d0 x4 : ffff80007bf07a58 x3 : 0000000000000002
> | x2 : ffff802f5db37000 x1 : 0000000000000000 x0 : 0000000000000000
> | Call trace:
> |  smmu_pmu_event_init+0x298/0x2b0 [arm_smmuv3_pmu]
> |  perf_try_init_event+0x54/0x140|  perf_event_alloc+0x3e4/0x1080
> |  __do_sys_perf_event_open+0x178/0xfa8
> |  __arm64_sys_perf_event_open+0x28/0x34
> |  invoke_syscall+0x48/0x114
> |  el0_svc_common.constprop.0+0x40/0xe0
> |  do_el0_svc+0x1c/0x28
> |  el0_svc+0x4c/0x11c
> |  el0t_64_sync_handler+0xc0/0xc4
> |  el0t_64_sync+0x190/0x194
> | irq event stamp: 174338
> | hardirqs last  enabled at (174337): [<ffff800080357774>]
> ___slab_alloc+0x3bc/0xf38
> | hardirqs last disabled at (174338): [<ffff8000812a7ee0>] el1_dbg+0x24/0x8c
> | softirqs last  enabled at (174292): [<ffff8000800185bc>]
> fpsimd_restore_current_state+0x34/0xc4
> | softirqs last disabled at (174290): [<ffff80008001858c>]
> fpsimd_restore_current_state+0x4/0xc4
> | ---[ end trace 0000000000000000 ]---
> 
> Note that this is not specific to the arm_smmuv3_pmu driver as I can
> also reproduce it with some HiSilicon uncore PMU events (e.g., executing
> `perf stat -e hisi_sccl1_ddrc0/flux_rd/`).
> 
> For your convenience, the assertion was added by commit f3c0eba28704
> ("perf: Add a few assertions").
> 
> Post it out for visibility, not sure if there are already similar
> reports on the list though. Please have a look.

Thanks for the report!

This is indeed a regression caused by commit:

  f3c0eba28704 ("perf: Add a few assertions")

.. and it's concerning that we haven't had a report until now; we're clearly
not testing system/uncore PMUs all that much. :/

I don't want to remove the assertion, since that will catch missed locking that
has been the source of a number of nasty bugs.

I think we have to update all PMU drivers to avoid for_each_sibling_event()
when event == group_leader. That's the established practice in CPU PMU drivers,
and with that done I believe that we can tighten the requirements such that
for_each_sibling_event() can *only* be called for a group leader, which would
catch unintentional misuse in the core code.

Looking around, I see some other (related) problems in group validation in some
PMU drivers, so I'll spin a series to address those in one go. I'll try to get
that out in the next few days.

Mark.

