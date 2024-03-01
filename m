Return-Path: <linux-kernel+bounces-87835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 280C586D9A3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 03:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D85AD283D76
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 02:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8383B3A8D6;
	Fri,  1 Mar 2024 02:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="I5tqTcN/"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E3A37705;
	Fri,  1 Mar 2024 02:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709259642; cv=none; b=nDLfkwx22NU1bkWuGrDHJE3vx3j/ImxHBIDt3AQgh7c33QMcZsGUQZ98cap2OWTC6e/kYR2kSjvvxX2S/DnUlnzxMO4iAedNDZXsYkAzLmklhNWsIidUqVO9jPUDakbkGnyapwUDdCtkkHE8d9hxFF20FhDiMwgwRZ2rcQLIlc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709259642; c=relaxed/simple;
	bh=TLnRq8HiU1POsQUZmMNxjoiSReV6/pX4N053Dacpxg4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HUTntDSwBehK1RcibR+tINu/I05pxODpxXOH30/f3Op0RLrhpdXt/mBjR07qfkm/nBB4eNAJ7r/1pnBXVAmCQBNJwlUNVIc2yc+GmBsf6QeIquokZjX7azJ3/FJJdAZ0ySRhT3cwv1hDnfMbFLgcyjVty06VEkKTCySgeU+hC3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=I5tqTcN/; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=vntvjbo5LKelHNLhuZc1kd/hRhea0DDqk8MBG/GQ51s=;
	b=I5tqTcN/6ue5jKtUPRT2aP6bpCc0askXC/8TamOgTO7VjuyOmRp4ucxx1mzS5F
	ObK+Od2t0k3U4NIjOaOR5ukXJqkfDJektBR3D59rtP9zzLEOWGx3A8Pt5wle/9Ms
	u3jA0VDbNfnjJOQSmPCRDaQ9z2S8vuS+7JBRGK0uMWxBs=
Received: from tian-ThinkPad-X390.. (unknown [111.48.58.12])
	by gzga-smtp-mta-g2-0 (Coremail) with SMTP id _____wDXX_g1O+Fl5445BQ--.250S2;
	Fri, 01 Mar 2024 10:19:35 +0800 (CST)
From: Yaxiong Tian <13327272236@163.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	keescook@chromium.org,
	tianyaxiong@kylinos.cn,
	xiongxin@kylinos.cn,
	rppt@kernel.org
Cc: tony.luck@intel.com,
	gpiccoli@igalia.com,
	songshuaishuai@tinylab.org,
	wangkefeng.wang@huawei.com,
	akpm@linux-foundation.org,
	ardb@kernel.org,
	david@redhat.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2] arm64: hibernate: Fix level3 translation fault in swsusp_save()
Date: Fri,  1 Mar 2024 10:19:24 +0800
Message-Id: <20240301021924.33210-1-13327272236@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZeBRfxQ8WTEVzpfL@kernel.org>
References: <ZeBRfxQ8WTEVzpfL@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXX_g1O+Fl5445BQ--.250S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxtFy8uFWrWr48XF43Cr1kAFb_yoW7CFyrpF
	WUGr1kGr4xCF1jyr4UAFy5uw1kWw4qvanxJr1UJwn7AF1UCw15Xr45Kry7tFyDtw4fJFs7
	trWDKw40yF1DGaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jtYFAUUUUU=
X-CM-SenderInfo: jprtjjaxsxjjitw6il2tof0z/1tbiYRuUJWV4HUtyXgAAss

From: Yaxiong Tian <tianyaxiong@kylinos.cn>

On ARM64 machines using UEFI, if can_set_direct_map() return false by
setting some CONFIGS in kernel build or grub,such as
NO CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT、NO CONFIG_KFENCE
NO CONFIG_RODATA_FULL_DEFAULT_ENABLED.Also with setting rodata=off、
debug_pagealloc=off in grub and NO CONFIG_KFENCE.
swsusp_save() will fail due to can't finding the map table under the 
nomap memory.such as:

[   48.532162] Unable to handle kernel paging request at virtual address ffffff8000000000
[   48.532162] Mem abort info:
[   48.532162]   ESR = 0x0000000096000007
[   48.532162]   EC = 0x25: DABT (current EL), IL = 32 bits
[   48.532162]   SET = 0, FnV = 0
[   48.532162]   EA = 0, S1PTW = 0
[   48.532162]   FSC = 0x07: level 3 translation fault
[   48.532162] Data abort info:
[   48.532162]   ISV = 0, ISS = 0x00000007, ISS2 = 0x00000000
[   48.532162]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[   48.532162]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[   48.532162] swapper pgtable: 4k pages, 39-bit VAs, pgdp=00000000eeb0b000
[   48.532162] [ffffff8000000000] pgd=180000217fff9803, p4d=180000217fff9803, pud=180000217fff9803, pmd=180000217fff8803, pte=0000000000000000
[   48.532162] Internal error: Oops: 0000000096000007 [#1] SMP
[   48.532162] Internal error: Oops: 0000000096000007 [#1] SMP
[   48.532162] Modules linked in: xt_multiport ipt_REJECT nf_reject_ipv4 xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c iptable_filter bpfilter rfkill at803x snd_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg dwmac_generic stmmac_platform snd_hda_codec stmmac joydev pcs_xpcs snd_hda_core phylink ppdev lp parport ramoops reed_solomon ip_tables x_tables nls_iso8859_1 vfat multipath linear amdgpu amdxcp drm_exec gpu_sched drm_buddy hid_generic usbhid hid radeon video drm_suballoc_helper drm_ttm_helper ttm i2c_algo_bit drm_display_helper cec drm_kms_helper drm
[   48.532162] CPU: 0 PID: 3663 Comm: systemd-sleep Not tainted 6.6.2+ #76
[   48.532162] Source Version: 4e22ed63a0a48e7a7cff9b98b7806d8d4add7dc0
[   48.532162] Hardware name: Greatwall GW-XXXXXX-XXX/GW-XXXXXX-XXX, BIOS KunLun BIOS V4.0 01/19/2021
[   48.532162] pstate: 600003c5 (nZCv DAIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   48.532162] pc : swsusp_save+0x280/0x538
[   48.532162] lr : swsusp_save+0x280/0x538
[   48.532162] sp : ffffffa034a3fa40
[   48.532162] x29: ffffffa034a3fa40 x28: ffffff8000001000 x27: 0000000000000000
[   48.532162] x26: ffffff8001400000 x25: ffffffc08113e248 x24: 0000000000000000
[   48.532162] x23: 0000000000080000 x22: ffffffc08113e280 x21: 00000000000c69f2
[   48.532162] x20: ffffff8000000000 x19: ffffffc081ae2500 x18: 0000000000000000
[   48.532162] x17: 6666662074736420 x16: 3030303030303030 x15: 3038666666666666
[   48.532162] x14: 0000000000000b69 x13: ffffff9f89088530 x12: 00000000ffffffea
[   48.532162] x11: 00000000ffff7fff x10: 00000000ffff7fff x9 : ffffffc08193f0d0
[   48.532162] x8 : 00000000000bffe8 x7 : c0000000ffff7fff x6 : 0000000000000001
[   48.532162] x5 : ffffffa0fff09dc8 x4 : 0000000000000000 x3 : 0000000000000027
[   48.532162] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 000000000000004e
[   48.532162] Call trace:
[   48.532162]  swsusp_save+0x280/0x538
[   48.532162]  swsusp_arch_suspend+0x148/0x190
[   48.532162]  hibernation_snapshot+0x240/0x39c
[   48.532162]  hibernate+0xc4/0x378
[   48.532162]  state_store+0xf0/0x10c
[   48.532162]  kobj_attr_store+0x14/0x24

This issue can be reproduced in QEMU using UEFI when booting with 
rodata=off、debug_pagealloc=off in grub and NO CONFIG_KFENCE.

This is because in swsusp_save()->copy_data_pages()->page_is_saveable(),
kernel_page_present() presumes that a page is present when can_set_direct_map()
returns false even for NOMAP ranges.So NOMAP pages will saved in after,and then
cause level3 translation fault in this pages.

Since the NOMAP regions are now marked as PageReserved(), pfn walkers
and the rest of core mm will treat them as unusable memory. So this
regions should not saved in hibernation.

This problem may cause by changes to pfn_valid() logic in commit
a7d9f306ba70 ("arm64: drop pfn_valid_within() and simplify pfn_valid()").

So to fix it, we add !pfn_is_map_memory() check in arm64::pfn_is_nosave(). It
make such regisons don't save in hibernation.

Fixes: a7d9f306ba70 ("arm64: drop pfn_valid_within() and simplify pfn_valid()")

Suggested-by: Mike Rapoport <rppt@kernel.org>
Co-developed-by: xiongxin <xiongxin@kylinos.cn>
Signed-off-by: xiongxin <xiongxin@kylinos.cn>
Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>

---
v1->v2: move !pfn_is_map_memory() check from page_is_saveable()
to arm64::pfn_is_nosave(),add opt commit messages.
---
 arch/arm64/kernel/hibernate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index 02870beb271e..d90005de1d26 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -94,7 +94,7 @@ int pfn_is_nosave(unsigned long pfn)
 	unsigned long nosave_end_pfn = sym_to_pfn(&__nosave_end - 1);
 
 	return ((pfn >= nosave_begin_pfn) && (pfn <= nosave_end_pfn)) ||
-		crash_is_nosave(pfn);
+		crash_is_nosave(pfn) || !pfn_is_map_memory(pfn);
 }
 
 void notrace save_processor_state(void)
-- 
2.34.1


