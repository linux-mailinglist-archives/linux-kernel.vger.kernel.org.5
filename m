Return-Path: <linux-kernel+bounces-151622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0857A8AB137
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0D78285C72
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E37112F5BB;
	Fri, 19 Apr 2024 15:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWTmSMIA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D3612F599;
	Fri, 19 Apr 2024 15:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713538944; cv=none; b=ICmycMjkoQkNdOT9GNHs8UDAkIVxhktusfvvYpT0KDMOhbAsMUl+ktN2nG6MKL7UWw0YuEJRag9XfZuSVV1GG9plhQTwEPxqvj5XB3/oTTjfOvsV4iJcjw4mZ/JorTl3MdUuIxEYak4h9H8FAIBkCTND/o/VAIYPCXX0nJuSHR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713538944; c=relaxed/simple;
	bh=UA06SqKY53ZluOyFgnipAQL6i+7psWEVH9E0CMAEG4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dbxD6ziuFD0Ad612qzq/txBXQJeonvdT8tkYpQd6kyQlCjDG94qYiIhxRU/RwTz4SaJwVBfD7pVk0UKqFuvZVgxL/ZhbHGA51TtJj/seA1kQ1SU5nfQvHK8Epjx5aGMUdI4lBQkD0A3tdcaxXIMcrl05px4TKG/L4QGwdZCWzGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KWTmSMIA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB0A2C072AA;
	Fri, 19 Apr 2024 15:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713538944;
	bh=UA06SqKY53ZluOyFgnipAQL6i+7psWEVH9E0CMAEG4o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KWTmSMIAyQ/fmJBt+lKvpMxwiAysYXpUJ3T6prpJhXUA2rwNICZUJUfFtaLtyvmWQ
	 alxcY5Q/Sy24Cvv7KcvxIL+X3djnPGLhxZS9S6n5ymUWcsbT0uEKtMpe7Xib7kVtMF
	 m8ptSs0i9EF2d2TAruySnOiKPgSIYDIeYeL/exIyUfjtNv3ATLcCXJ5N/e1V/VAFov
	 A50/1kX02IU/CXZRcJshE5zuYNVvjMiTIFZCeuGY8RjQKSnF7+BgvNC9JB3HmxO7mW
	 1+QMCfM/+ksH4uu9X/KDM10hW1LOtCv9cpApfOW5Psz21AaEEiTw1u9+tD+V46kfLU
	 P8AT37Ym1VZ9w==
Date: Fri, 19 Apr 2024 18:01:10 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Yaxiong Tian <tianyaxiong@kylinos.cn>
Cc: catalin.marinas@arm.com, will@kernel.org, keescook@chromium.org,
	tony.luck@intel.com, gpiccoli@igalia.com, akpm@linux-foundation.org,
	ryan.roberts@arm.com, wangkefeng.wang@huawei.com, ardb@kernel.org,
	david@redhat.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	xiongxin <xiongxin@kylinos.cn>
Subject: Re: [PATCH v3] arm64: hibernate: Fix level3 translation fault in
 swsusp_save()
Message-ID: <ZiKHNh0hHIAFT80N@kernel.org>
References: <20240417025248.386622-1-tianyaxiong@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240417025248.386622-1-tianyaxiong@kylinos.cn>

On Wed, Apr 17, 2024 at 10:52:48AM +0800, Yaxiong Tian wrote:
> On ARM64 machines using UEFI, if can_set_direct_map() return false by
> setting some CONFIGS in kernel build or grub,such as
> NO CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT、NO CONFIG_KFENCE
> NO CONFIG_RODATA_FULL_DEFAULT_ENABLED.Also with setting rodata=off、
> debug_pagealloc=off in grub and NO CONFIG_KFENCE.
> swsusp_save() will fail due to can't finding the map table under the
> nomap memory.such as:
> 
> [   48.532162] Unable to handle kernel paging request at virtual address ffffff8000000000
> [   48.532162] Mem abort info:
> [   48.532162]   ESR = 0x0000000096000007
> [   48.532162]   EC = 0x25: DABT (current EL), IL = 32 bits
> [   48.532162]   SET = 0, FnV = 0
> [   48.532162]   EA = 0, S1PTW = 0
> [   48.532162]   FSC = 0x07: level 3 translation fault
> [   48.532162] Data abort info:
> [   48.532162]   ISV = 0, ISS = 0x00000007, ISS2 = 0x00000000
> [   48.532162]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> [   48.532162]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [   48.532162] swapper pgtable: 4k pages, 39-bit VAs, pgdp=00000000eeb0b000
> [   48.532162] [ffffff8000000000] pgd=180000217fff9803, p4d=180000217fff9803, pud=180000217fff9803, pmd=180000217fff8803, pte=0000000000000000
> [   48.532162] Internal error: Oops: 0000000096000007 [#1] SMP
> [   48.532162] Internal error: Oops: 0000000096000007 [#1] SMP
> [   48.532162] Modules linked in: xt_multiport ipt_REJECT nf_reject_ipv4 xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c iptable_filter bpfilter rfkill at803x snd_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg dwmac_generic stmmac_platform snd_hda_codec stmmac joydev pcs_xpcs snd_hda_core phylink ppdev lp parport ramoops reed_solomon ip_tables x_tables nls_iso8859_1 vfat multipath linear amdgpu amdxcp drm_exec gpu_sched drm_buddy hid_generic usbhid hid radeon video drm_suballoc_helper drm_ttm_helper ttm i2c_algo_bit drm_display_helper cec drm_kms_helper drm
> [   48.532162] CPU: 0 PID: 3663 Comm: systemd-sleep Not tainted 6.6.2+ #76
> [   48.532162] Source Version: 4e22ed63a0a48e7a7cff9b98b7806d8d4add7dc0
> [   48.532162] Hardware name: Greatwall GW-XXXXXX-XXX/GW-XXXXXX-XXX, BIOS KunLun BIOS V4.0 01/19/2021
> [   48.532162] pstate: 600003c5 (nZCv DAIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [   48.532162] pc : swsusp_save+0x280/0x538
> [   48.532162] lr : swsusp_save+0x280/0x538
> [   48.532162] sp : ffffffa034a3fa40
> [   48.532162] x29: ffffffa034a3fa40 x28: ffffff8000001000 x27: 0000000000000000
> [   48.532162] x26: ffffff8001400000 x25: ffffffc08113e248 x24: 0000000000000000
> [   48.532162] x23: 0000000000080000 x22: ffffffc08113e280 x21: 00000000000c69f2
> [   48.532162] x20: ffffff8000000000 x19: ffffffc081ae2500 x18: 0000000000000000
> [   48.532162] x17: 6666662074736420 x16: 3030303030303030 x15: 3038666666666666
> [   48.532162] x14: 0000000000000b69 x13: ffffff9f89088530 x12: 00000000ffffffea
> [   48.532162] x11: 00000000ffff7fff x10: 00000000ffff7fff x9 : ffffffc08193f0d0
> [   48.532162] x8 : 00000000000bffe8 x7 : c0000000ffff7fff x6 : 0000000000000001
> [   48.532162] x5 : ffffffa0fff09dc8 x4 : 0000000000000000 x3 : 0000000000000027
> [   48.532162] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 000000000000004e
> [   48.532162] Call trace:
> [   48.532162]  swsusp_save+0x280/0x538
> [   48.532162]  swsusp_arch_suspend+0x148/0x190
> [   48.532162]  hibernation_snapshot+0x240/0x39c
> [   48.532162]  hibernate+0xc4/0x378
> [   48.532162]  state_store+0xf0/0x10c
> [   48.532162]  kobj_attr_store+0x14/0x24
> 
> This issue can be reproduced in QEMU using UEFI when booting with
> rodata=off、debug_pagealloc=off in grub and NO CONFIG_KFENCE.
> 
> This is because in swsusp_save()->copy_data_pages()->page_is_saveable(),
> kernel_page_present() presumes that a page is present when can_set_direct_map()
> returns false even for NOMAP ranges.So NOMAP pages will saved in after,and then
> cause level3 translation fault in this pages.
> 
> Since the NOMAP regions are now marked as PageReserved(), pfn walkers
> and the rest of core mm will treat them as unusable memory. So this
> regions should not saved in hibernation.
> 
> This problem may cause by changes to pfn_valid() logic in commit
> a7d9f306ba70 ("arm64: drop pfn_valid_within() and simplify pfn_valid()").
> 
> Reference ohter arch architecture,drop the !can_set_direct_map() condition
> in kernel_page_present().So in page_is_savable(),these page will skiped.
> 
> Fixes: a7d9f306ba70 ("arm64: drop pfn_valid_within() and simplify pfn_valid()")
> 
> Suggested-by: Mike Rapoport <rppt@kernel.org>
> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
> Co-developed-by: xiongxin <xiongxin@kylinos.cn>
> Signed-off-by: xiongxin <xiongxin@kylinos.cn>
> Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  arch/arm64/mm/pageattr.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
> index 0c4e3ecf989d..0e270a1c51e6 100644
> --- a/arch/arm64/mm/pageattr.c
> +++ b/arch/arm64/mm/pageattr.c
> @@ -219,9 +219,6 @@ bool kernel_page_present(struct page *page)
>  	pte_t *ptep;
>  	unsigned long addr = (unsigned long)page_address(page);
>  
> -	if (!can_set_direct_map())
> -		return true;
> -
>  	pgdp = pgd_offset_k(addr);
>  	if (pgd_none(READ_ONCE(*pgdp)))
>  		return false;
> -- 
> 2.34.1
> 

-- 
Sincerely yours,
Mike.

