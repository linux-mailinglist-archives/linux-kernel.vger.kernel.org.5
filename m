Return-Path: <linux-kernel+bounces-81022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A0A866F24
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA0001F2549E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CCC128838;
	Mon, 26 Feb 2024 09:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OEFa3PNl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEA31CD37;
	Mon, 26 Feb 2024 09:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708938908; cv=none; b=tZhRaN3l0+WHeSyTIgDbVNn9YUBdvhVK5nT+GcQgb6AjYw40o19uKVhStK2eLOv7KsNtY8YXWx/wyxGx8KUmxux6/tRrmoo5iLekxPjjCs4nTOhOcSjLAsx8tyTFwhp/apkk9GE8ftkeLqbm98r2FG9Mo9EXvPdacYvoI2cuFp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708938908; c=relaxed/simple;
	bh=icBzWWPMhTbM0D+VTKjVVVPUQSzGPofIgP2e1+sbI4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dMHxfG5Vby+oqzwBUxKWrUsLWeIA3bSyLjJv2PfSeOqXqzfvlYRZ73Exw9BtKeC5ALo/MHmew1uU+N6VAtfWKmzLNkm2ls8Mq9KEOktx2W7rciFeNp1+Gmj9ZjFssSJ2dfOkWA62v0kASpVwZRCq1rkgVwSjG4abc6jFYKD2fA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OEFa3PNl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8856AC433F1;
	Mon, 26 Feb 2024 09:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708938908;
	bh=icBzWWPMhTbM0D+VTKjVVVPUQSzGPofIgP2e1+sbI4k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OEFa3PNl5ppckn9UbfsoIUdeNBKcqnPxAUGlk9sAVeRMNg5VPY9Fmb21oGBfB6uzp
	 FPbl1yxOYcFbYOJv1XPl/cI4X5sbbMQveHqeirKN8cb6Fe2/r8vyjUMNwKqXznFb8G
	 X31wkyjD+Sz2h2rMrS6cVjLkjmF2IRj2qKBI69sUhbHbPcpcC96RmHqQ2hoiSDkPi0
	 qHMeUx4LN2gH3o5nqR5rLeZDAv0gwiAnz0S/pW6QPlaJWVz9HxVm34FMGVgV4DLsf1
	 pHGht4iB0c8dfrpHggPH3qynqxi3jMR9NVj28lmb72+BMQ8CAm8nWVfEtp+zISiuJz
	 HD9T+3NkICQ7Q==
Date: Mon, 26 Feb 2024 11:14:24 +0200
From: Mike Rapoport <rppt@kernel.org>
To: David Hildenbrand <david@redhat.com>,
	Yaxiong Tian <13327272236@163.com>
Cc: rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com,
	keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
	akpm@linux-foundation.org, ardb@kernel.org,
	wangkefeng.wang@huawei.com, catalin.marinas@arm.com,
	will@kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Yaxiong Tian <tianyaxiong@kylinos.cn>,
	xiongxin <xiongxin@kylinos.cn>
Subject: Re: [PATCH] PM: hibernate: Fix level3 translation fault in
 swsusp_save()
Message-ID: <ZdxWcG2XCqBum3_R@kernel.org>
References: <20240226034225.48689-1-13327272236@163.com>
 <8d70939f-ca14-4167-9647-b8f44ddcbb98@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d70939f-ca14-4167-9647-b8f44ddcbb98@redhat.com>

On Mon, Feb 26, 2024 at 09:37:06AM +0100, David Hildenbrand wrote:
> On 26.02.24 04:42, Yaxiong Tian wrote:
> > From: Yaxiong Tian <tianyaxiong@kylinos.cn>
> > 
> > On ARM64 machines using UEFI, if the linear map is not set (can_set_direct_map()
> > return false), swsusp_save() will fail due to can't finding the map table
> > under the nomap memory.such as:

can_set_direct_map() has nothing to do with presence or absence of the
linear map.

Do you mean that kernel_page_present() presumes that a page is present when
can_set_direct_map() returns false even for NOMAP ranges?

> > [   48.532162] Unable to handle kernel paging request at virtual address ffffff8000000000
> > [   48.532162] Mem abort info:
> > [   48.532162]   ESR = 0x0000000096000007
> > [   48.532162]   EC = 0x25: DABT (current EL), IL = 32 bits
> > [   48.532162]   SET = 0, FnV = 0
> > [   48.532162]   EA = 0, S1PTW = 0
> > [   48.532162]   FSC = 0x07: level 3 translation fault
> > [   48.532162] Data abort info:
> > [   48.532162]   ISV = 0, ISS = 0x00000007, ISS2 = 0x00000000
> > [   48.532162]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> > [   48.532162]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> > [   48.532162] swapper pgtable: 4k pages, 39-bit VAs, pgdp=00000000eeb0b000
> > [   48.532162] [ffffff8000000000] pgd=180000217fff9803, p4d=180000217fff9803, pud=180000217fff9803, pmd=180000217fff8803, pte=0000000000000000
> > [   48.532162] Internal error: Oops: 0000000096000007 [#1] SMP
> > [   48.532162] Internal error: Oops: 0000000096000007 [#1] SMP
> > [   48.532162] Modules linked in: xt_multiport ipt_REJECT nf_reject_ipv4 xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c iptable_filter bpfilter rfkill at803x snd_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg dwmac_generic stmmac_platform snd_hda_codec stmmac joydev pcs_xpcs snd_hda_core phylink ppdev lp parport ramoops reed_solomon ip_tables x_tables nls_iso8859_1 vfat multipath linear amdgpu amdxcp drm_exec gpu_sched drm_buddy hid_generic usbhid hid radeon video drm_suballoc_helper drm_ttm_helper ttm i2c_algo_bit drm_display_helper cec drm_kms_helper drm
> > [   48.532162] CPU: 0 PID: 3663 Comm: systemd-sleep Not tainted 6.6.2+ #76
> > [   48.532162] Source Version: 4e22ed63a0a48e7a7cff9b98b7806d8d4add7dc0
> > [   48.532162] Hardware name: Greatwall GW-XXXXXX-XXX/GW-XXXXXX-XXX, BIOS KunLun BIOS V4.0 01/19/2021
> > [   48.532162] pstate: 600003c5 (nZCv DAIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > [   48.532162] pc : swsusp_save+0x280/0x538
> > [   48.532162] lr : swsusp_save+0x280/0x538
> > [   48.532162] sp : ffffffa034a3fa40
> > [   48.532162] x29: ffffffa034a3fa40 x28: ffffff8000001000 x27: 0000000000000000
> > [   48.532162] x26: ffffff8001400000 x25: ffffffc08113e248 x24: 0000000000000000
> > [   48.532162] x23: 0000000000080000 x22: ffffffc08113e280 x21: 00000000000c69f2
> > [   48.532162] x20: ffffff8000000000 x19: ffffffc081ae2500 x18: 0000000000000000
> > [   48.532162] x17: 6666662074736420 x16: 3030303030303030 x15: 3038666666666666
> > [   48.532162] x14: 0000000000000b69 x13: ffffff9f89088530 x12: 00000000ffffffea
> > [   48.532162] x11: 00000000ffff7fff x10: 00000000ffff7fff x9 : ffffffc08193f0d0
> > [   48.532162] x8 : 00000000000bffe8 x7 : c0000000ffff7fff x6 : 0000000000000001
> > [   48.532162] x5 : ffffffa0fff09dc8 x4 : 0000000000000000 x3 : 0000000000000027
> > [   48.532162] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 000000000000004e
> > [   48.532162] Call trace:
> > [   48.532162]  swsusp_save+0x280/0x538
> > [   48.532162]  swsusp_arch_suspend+0x148/0x190
> > [   48.532162]  hibernation_snapshot+0x240/0x39c
> > [   48.532162]  hibernate+0xc4/0x378
> > [   48.532162]  state_store+0xf0/0x10c
> > [   48.532162]  kobj_attr_store+0x14/0x24
> > 
> > QEMU ARM64 using UEFI also has the problem by setting can_set_direct_map()
> > return false.

Huh?
Why would you do that?

> > 
> > Since the NOMAP regions are now marked as PageReserved(), pfn walkers
> > and the rest of core mm will treat them as unusable memory. So this
> > regions should not saved in hibernation.
> > 
> > This problem may cause by changes to pfn_valid() logic in commit
> > a7d9f306ba70 ("arm64: drop pfn_valid_within() and simplify pfn_valid()").
> > 
> > So to fix it, we add pfn_is_map_memory() check in saveable_page(). It
> > make such regisons don't save in hibernation.
> > 
> > Fixes: a7d9f306ba70 ("arm64: drop pfn_valid_within() and simplify pfn_valid()")
> > Co-developed-by: xiongxin <xiongxin@kylinos.cn>
> > Signed-off-by: xiongxin <xiongxin@kylinos.cn>
> > Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
> > ---
> >   kernel/power/snapshot.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> > index 0f12e0a97e43..a06e3b1869d2 100644
> > --- a/kernel/power/snapshot.c
> > +++ b/kernel/power/snapshot.c
> > @@ -1400,7 +1400,7 @@ static struct page *saveable_page(struct zone *zone, unsigned long pfn)
> >   		return NULL;
> >   	if (PageReserved(page)
> > -	    && (!kernel_page_present(page) || pfn_is_nosave(pfn)))
> > +	    && (!kernel_page_present(page) || pfn_is_nosave(pfn) || !pfn_is_map_memory(pfn)))

I think adding the check for !pfn_is_map_memory() to arm64::pfn_is_nosave()
is the best way to fix this.

> >   		return NULL;
> >   	if (page_is_guard(page))
> 
> On top of which tree does this apply?
> 
> All occurrences of pfn_is_map_memory() are in arch/arm64, how does this
> compile on other architectures?
> 
> -- 
> Cheers,
> 
> David / dhildenb
> 

-- 
Sincerely yours,
Mike.

