Return-Path: <linux-kernel+bounces-10844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A5381DCE6
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 23:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90DF5281D05
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 22:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC7C10787;
	Sun, 24 Dec 2023 22:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jb62IJA1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BF2101D0;
	Sun, 24 Dec 2023 22:43:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59514C433C8;
	Sun, 24 Dec 2023 22:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703457808;
	bh=lJIHpByo7amVZ6jFjM6x1BS87wyLanlh8lKnsEytyIM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Jb62IJA1KR1iTJaBr7AbpJuaXxlfiJyWbt16mhxBHCmSWSoMdiB1DEUCEjHaFwOSJ
	 lTzZxr3TKVaHAnDggSKf/XJiWwYXgaYW2U21gzXGZuFSA8gsSBk5G1QGKxOwELM1Zg
	 1M3NtZosyT9887P2cOqcKZPlFxiy7U/yogbb52PLJ1IGbL2CsUrkQf+DoucLVwEKcQ
	 P6xuEnfnjJrQKszvBbPq84SZhrRymmiYyFewLYW5ATrAVzNQjTdgt0jR1tcxtnjxLr
	 uRpC5rCt/HExpUp6SrcExr/8yBcQ6tkK0iYMPqkNS3NgVbMU+1II6mdVSbe/T0cOsn
	 QS6aHWI4/6XRw==
Date: Sun, 24 Dec 2023 16:43:26 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ethan Zhao <haifeng.zhao@linux.intel.com>
Cc: bhelgaas@google.com, baolu.lu@linux.intel.com, dwmw2@infradead.org,
	will@kernel.org, robin.murphy@arm.com, lukas@wunner.de,
	linux-pci@vger.kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v6 2/4] iommu/vt-d: don's issue devTLB flush request
 when device is disconnected
Message-ID: <20231224224326.GA1412095@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231224050657.182022-3-haifeng.zhao@linux.intel.com>

On Sun, Dec 24, 2023 at 12:06:55AM -0500, Ethan Zhao wrote:
> For those endpoint devices connect to system via hotplug capable ports,
> users could request a warm reset to the device by flapping device's link
> through setting the slot's link control register, as pciehpt_ist() DLLSC
> interrupt sequence response, pciehp will unload the device driver and
> then power it off. thus cause an IOMMU devTLB flush request for device to
> be sent and a long time completion/timeout waiting in interrupt context.

s/don's/don't/ (in subject)
s/pciehpt_ist/pciehp_ist/

IIUC you are referring to a specific PCIe transaction, so unless
there's another spec that defines "devTLB flush request", please use
the actual PCIe transaction name ("ATS Invalidate Request") as Lukas
suggested.

There's no point in using an informal name that we assume "all
iommu/PCIe guys could understand."  It's better to use a term that
anybody can find by searching the spec.

> That would cause following continuous hard lockup warning and system hang
> 
> [ 4211.433662] pcieport 0000:17:01.0: pciehp: Slot(108): Link Down
> [ 4211.433664] pcieport 0000:17:01.0: pciehp: Slot(108): Card not present
> [ 4223.822591] NMI watchdog: Watchdog detected hard LOCKUP on cpu 144
> [ 4223.822622] CPU: 144 PID: 1422 Comm: irq/57-pciehp Kdump: loaded Tainted: G S
>          OE    kernel version xxxx
> [ 4223.822623] Hardware name: vendorname xxxx 666-106,
> BIOS 01.01.02.03.01 05/15/2023
> [ 4223.822623] RIP: 0010:qi_submit_sync+0x2c0/0x490
> [ 4223.822624] Code: 48 be 00 00 00 00 00 08 00 00 49 85 74 24 20 0f 95 c1 48 8b
>  57 10 83 c1 04 83 3c 1a 03 0f 84 a2 01 00 00 49 8b 04 24 8b 70 34 <40> f6 c6 1
> 0 74 17 49 8b 04 24 8b 80 80 00 00 00 89 c2 d3 fa 41 39
> [ 4223.822624] RSP: 0018:ffffc4f074f0bbb8 EFLAGS: 00000093
> [ 4223.822625] RAX: ffffc4f040059000 RBX: 0000000000000014 RCX: 0000000000000005
> [ 4223.822625] RDX: ffff9f3841315800 RSI: 0000000000000000 RDI: ffff9f38401a8340
> [ 4223.822625] RBP: ffff9f38401a8340 R08: ffffc4f074f0bc00 R09: 0000000000000000
> [ 4223.822626] R10: 0000000000000010 R11: 0000000000000018 R12: ffff9f384005e200
> [ 4223.822626] R13: 0000000000000004 R14: 0000000000000046 R15: 0000000000000004
> [ 4223.822626] FS:  0000000000000000(0000) GS:ffffa237ae400000(0000)
> knlGS:0000000000000000
> [ 4223.822627] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 4223.822627] CR2: 00007ffe86515d80 CR3: 000002fd3000a001 CR4: 0000000000770ee0
> [ 4223.822627] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 4223.822628] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
> [ 4223.822628] PKRU: 55555554
> [ 4223.822628] Call Trace:
> [ 4223.822628]  qi_flush_dev_iotlb+0xb1/0xd0
> [ 4223.822628]  __dmar_remove_one_dev_info+0x224/0x250
> [ 4223.822629]  dmar_remove_one_dev_info+0x3e/0x50
> [ 4223.822629]  intel_iommu_release_device+0x1f/0x30
> [ 4223.822629]  iommu_release_device+0x33/0x60
> [ 4223.822629]  iommu_bus_notifier+0x7f/0x90
> [ 4223.822630]  blocking_notifier_call_chain+0x60/0x90
> [ 4223.822630]  device_del+0x2e5/0x420
> [ 4223.822630]  pci_remove_bus_device+0x70/0x110
> [ 4223.822630]  pciehp_unconfigure_device+0x7c/0x130
> [ 4223.822631]  pciehp_disable_slot+0x6b/0x100
> [ 4223.822631]  pciehp_handle_presence_or_link_change+0xd8/0x320
> [ 4223.822631]  pciehp_ist+0x176/0x180
> [ 4223.822631]  ? irq_finalize_oneshot.part.50+0x110/0x110
> [ 4223.822632]  irq_thread_fn+0x19/0x50
> [ 4223.822632]  irq_thread+0x104/0x190
> [ 4223.822632]  ? irq_forced_thread_fn+0x90/0x90
> [ 4223.822632]  ? irq_thread_check_affinity+0xe0/0xe0
> [ 4223.822633]  kthread+0x114/0x130
> [ 4223.822633]  ? __kthread_cancel_work+0x40/0x40
> [ 4223.822633]  ret_from_fork+0x1f/0x30
> [ 4223.822633] Kernel panic - not syncing: Hard LOCKUP
> [ 4223.822634] CPU: 144 PID: 1422 Comm: irq/57-pciehp Kdump: loaded Tainted: G S
>          OE     kernel version xxxx
> [ 4223.822634] Hardware name: vendorname xxxx 666-106,
> BIOS 01.01.02.03.01 05/15/2023
> [ 4223.822634] Call Trace:
> [ 4223.822634]  <NMI>
> [ 4223.822635]  dump_stack+0x6d/0x88
> [ 4223.822635]  panic+0x101/0x2d0
> [ 4223.822635]  ? ret_from_fork+0x11/0x30
> [ 4223.822635]  nmi_panic.cold.14+0xc/0xc
> [ 4223.822636]  watchdog_overflow_callback.cold.8+0x6d/0x81
> [ 4223.822636]  __perf_event_overflow+0x4f/0xf0
> [ 4223.822636]  handle_pmi_common+0x1ef/0x290
> [ 4223.822636]  ? __set_pte_vaddr+0x28/0x40
> [ 4223.822637]  ? flush_tlb_one_kernel+0xa/0x20
> [ 4223.822637]  ? __native_set_fixmap+0x24/0x30
> [ 4223.822637]  ? ghes_copy_tofrom_phys+0x70/0x100
> [ 4223.822637]  ? __ghes_peek_estatus.isra.16+0x49/0xa0
> [ 4223.822637]  intel_pmu_handle_irq+0xba/0x2b0
> [ 4223.822638]  perf_event_nmi_handler+0x24/0x40
> [ 4223.822638]  nmi_handle+0x4d/0xf0
> [ 4223.822638]  default_do_nmi+0x49/0x100
> [ 4223.822638]  exc_nmi+0x134/0x180
> [ 4223.822639]  end_repeat_nmi+0x16/0x67
> [ 4223.822639] RIP: 0010:qi_submit_sync+0x2c0/0x490
> [ 4223.822639] Code: 48 be 00 00 00 00 00 08 00 00 49 85 74 24 20 0f 95 c1 48 8b
>  57 10 83 c1 04 83 3c 1a 03 0f 84 a2 01 00 00 49 8b 04 24 8b 70 34 <40> f6 c6 10
>  74 17 49 8b 04 24 8b 80 80 00 00 00 89 c2 d3 fa 41 39
> [ 4223.822640] RSP: 0018:ffffc4f074f0bbb8 EFLAGS: 00000093
> [ 4223.822640] RAX: ffffc4f040059000 RBX: 0000000000000014 RCX: 0000000000000005
> [ 4223.822640] RDX: ffff9f3841315800 RSI: 0000000000000000 RDI: ffff9f38401a8340
> [ 4223.822641] RBP: ffff9f38401a8340 R08: ffffc4f074f0bc00 R09: 0000000000000000
> [ 4223.822641] R10: 0000000000000010 R11: 0000000000000018 R12: ffff9f384005e200
> [ 4223.822641] R13: 0000000000000004 R14: 0000000000000046 R15: 0000000000000004
> [ 4223.822641]  ? qi_submit_sync+0x2c0/0x490
> [ 4223.822642]  ? qi_submit_sync+0x2c0/0x490
> [ 4223.822642]  </NMI>
> [ 4223.822642]  qi_flush_dev_iotlb+0xb1/0xd0
> [ 4223.822642]  __dmar_remove_one_dev_info+0x224/0x250
> [ 4223.822643]  dmar_remove_one_dev_info+0x3e/0x50
> [ 4223.822643]  intel_iommu_release_device+0x1f/0x30
> [ 4223.822643]  iommu_release_device+0x33/0x60
> [ 4223.822643]  iommu_bus_notifier+0x7f/0x90
> [ 4223.822644]  blocking_notifier_call_chain+0x60/0x90
> [ 4223.822644]  device_del+0x2e5/0x420
> [ 4223.822644]  pci_remove_bus_device+0x70/0x110
> [ 4223.822644]  pciehp_unconfigure_device+0x7c/0x130
> [ 4223.822644]  pciehp_disable_slot+0x6b/0x100
> [ 4223.822645]  pciehp_handle_presence_or_link_change+0xd8/0x320
> [ 4223.822645]  pciehp_ist+0x176/0x180
> [ 4223.822645]  ? irq_finalize_oneshot.part.50+0x110/0x110
> [ 4223.822645]  irq_thread_fn+0x19/0x50
> [ 4223.822646]  irq_thread+0x104/0x190
> [ 4223.822646]  ? irq_forced_thread_fn+0x90/0x90
> [ 4223.822646]  ? irq_thread_check_affinity+0xe0/0xe0
> [ 4223.822646]  kthread+0x114/0x130
> [ 4223.822647]  ? __kthread_cancel_work+0x40/0x40
> [ 4223.822647]  ret_from_fork+0x1f/0x30
> [ 4223.822647] Kernel Offset: 0x6400000 from 0xffffffff81000000 (relocation
> range: 0xffffffff80000000-0xffffffffbfffffff)

The timestamps don't help understand the problem, so you could remove
them so they aren't a distraction.

> Fix it by checking the device's error_state in
> devtlb_invalidation_with_pasid() to avoid sending meaningless devTLB flush
> request to link down device that is set to pci_channel_io_perm_failure and
> then powered off in

A pci_dev_is_disconnected() is racy in this context, so this by itself
doesn't look like a complete "fix".

> pciehp_ist()
>    pciehp_handle_presence_or_link_change()
>      pciehp_disable_slot()
>        remove_board()
>          pciehp_unconfigure_device()

There are some interesting steps missing here between
pciehp_unconfigure_device() and devtlb_invalidation_with_pasid().

devtlb_invalidation_with_pasid() is Intel-specific.  ATS Invalidate
Requests are not Intel-specific, so all IOMMU drivers must have to
deal with the case of an ATS Invalidate Request where we never receive
a corresponding ATS Invalidate Completion.  Do other IOMMUs like AMD
and ARM have a similar issue?

> For SAVE_REMOVAL unplug, link is alive when iommu releases devcie and
> issues devTLB invalidate request, wouldn't trigger such issue.
> 
> This patch works for all links of SURPPRISE_REMOVAL unplug operations.

s/devcie/device/

Writing "SAVE_REMOVAL" and "SURPPRISE_REMOVAL" in all caps with an
underscore makes them look like identifiers.  But neither appears in
the kernel source.  Write them as normal English words, e.g., "save
removal" instead (though I suspect you mean "safe removal"?).

s/surpprise/surprise/

It's not completely obvious that a fix that works for the safe removal
case also works for the surprise removal case.  Can you briefly
explain why it does?

> Tested-by: Haorong Ye <yehaorong@bytedance.com>
> Signed-off-by: Ethan Zhao <haifeng.zhao@linux.intel.com>
> ---
>  drivers/iommu/intel/pasid.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> index 74e8e4c17e81..7dbee9931eb6 100644
> --- a/drivers/iommu/intel/pasid.c
> +++ b/drivers/iommu/intel/pasid.c
> @@ -481,6 +481,9 @@ devtlb_invalidation_with_pasid(struct intel_iommu *iommu,
>  	if (!info || !info->ats_enabled)
>  		return;
>  
> +	if (pci_dev_is_disconnected(to_pci_dev(dev)))
> +		return;
> +
>  	sid = info->bus << 8 | info->devfn;
>  	qdep = info->ats_qdep;
>  	pfsid = info->pfsid;

This goes on to call qi_submit_sync(), which contains a restart: loop.
I don't know the programming model there, but it looks possible that 
qi_submit_sync() and qi_check_fault() might not handle the case of an
unreachable device correctly.  There should be a way to exit that
restart: loop in cases where the device doesn't respond at all.

Bjorn

