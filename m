Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7AD766F2F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 16:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234655AbjG1OTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 10:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233183AbjG1OS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 10:18:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A100EBA
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 07:18:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F18562158
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 14:18:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D968CC433C8;
        Fri, 28 Jul 2023 14:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690553937;
        bh=028sEnPvtX6KJGqdYH7eLDL+RNdEypk9K9EaAW1fyow=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B9IC9WwjbbtyOz1EKVQzeM6TUqBOwS045l3T0TAjMV8qfMuGgzfqMj+Bid0Ogw0wI
         sV9GI3jfv34jrUt5El3FDicpfqk35I+n8i8wgjz8KBIYVOOzQXYTQ03D/PymqzzAh7
         CdVJWuMoqOFk9jnugKArhwMeBwxEJ+iYGNgtdtQ8+HtJ946WiIuv7++6BH92//IkSJ
         3te6/ig/kl5Cj2U9ThzZCfIw7HoGFJCL+MddGHjxqvYHamVA7mF5egnZ8Uwxq0oHo/
         F/TxdprnqXeKguFkOBrKq+RyV19AEJ0wPR9rJ1yjAsvn1dWteSU/+KnhFbvLdZfpu6
         Y/GN0x3DZx/hw==
Date:   Fri, 28 Jul 2023 15:18:53 +0100
From:   Will Deacon <will@kernel.org>
To:     Mike Galbraith <efault@gmx.de>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: arm64: perf test 26 rpi4 oops
Message-ID: <20230728141852.GA21718@willie-the-truck>
References: <b39c62d29a431b023e98959578ba87e96af0e030.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b39c62d29a431b023e98959578ba87e96af0e030.camel@gmx.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On Fri, Jul 28, 2023 at 06:06:33AM +0200, Mike Galbraith wrote:
> perf test 26 in virgin master inspired the below.

Ah, so this is the 6.5-based panic message below?

> The oops is not brand new, apparently arriving sometime after 6.1, as
> the stock 6.1.21 Raspian/PiOS kernel does not reproduce but the rpi-
> 6.4.y pi kernel (https://github.com/raspberrypi/linux.git) branch does.
>
> [   65.416656] Unable to handle kernel paging request at virtual address ffffffd080a00000
> [   65.416680] Mem abort info:
> [   65.416685]   ESR = 0x0000000096000007
> [   65.416690]   EC = 0x25: DABT (current EL), IL = 32 bits
> [   65.416696]   SET = 0, FnV = 0
> [   65.416701]   EA = 0, S1PTW = 0
> [   65.416705]   FSC = 0x07: level 3 translation fault
> [   65.416710] Data abort info:
> [   65.416715]   ISV = 0, ISS = 0x00000007, ISS2 = 0x00000000
> [   65.416720]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> [   65.416725]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [   65.416731] swapper pgtable: 4k pages, 39-bit VAs, pgdp=0000000000f51000
> [   65.416737] [ffffffd080a00000] pgd=10000001fffff003, p4d=10000001fffff003, pud=10000001fffff003, pmd=10000001ffffe003, pte=0000000000000000
> [   65.416758] Internal error: Oops: 0000000096000007 [#1] SMP
> [   65.416764] Modules linked in: rfcomm nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables nfnetlink cmac algif_hash aes_arm64 aes_generic algif_skcipher af_alg bnep vc4 brcmfmac_wcc 8021q brcmfmac garp stp llc snd_soc_hdmi_codec drm_display_helper hci_uart drm_dma_helper drm_kms_helper btbcm bluetooth cfg80211 bcm2835_v4l2(C) cec videobuf2_vmalloc snd_soc_core videobuf2_memops bcm2835_mmal_vchiq(C) videobuf2_v4l2 videodev snd_pcm_dmaengine snd_bcm2835(C) v3d snd_pcm videobuf2_common snd_timer sg ecdh_generic ecc drm_shmem_helper mc rfkill snd gpu_sched brcmutil i2c_brcmstb raspberrypi_hwmon pwm_bcm2835 i2c_bcm2835 libaes uio_pdrv_genirq uio nvmem_rmem drm nfsd fuse i2c_dev drm_panel_orientation_quirks backlight ip_tables x_tables ipv6
> [   65.416903] CPU: 0 PID: 1769 Comm: objdump Tainted: G         C         6.5.0.g0a8db05-master #1
> [   65.416909] Hardware name: Raspberry Pi 4 Model B Rev 1.4 (DT)
> [   65.416913] pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [   65.416919] pc : __arch_copy_to_user+0x180/0x240
> [   65.416929] lr : _copy_to_iter+0xe8/0x4d0
> [   65.416936] sp : ffffffc08219b970
> [   65.416939] x29: ffffffc08219b970 x28: ffffffd080a00000 x27: ffffffd081d5cd30
> [   65.416948] x26: 0000000000000000 x25: ffffffd080a00000 x24: 0000000000000000
> [   65.416956] x23: ffffffc08219bd40 x22: ffffffd081c00000 x21: ffffffc08219bd40
> [   65.416964] x20: ffffffd081c005c0 x19: 0000000000000400 x18: 0000000000000000
> [   65.416972] x17: 0000000000000000 x16: 0000000000000000 x15: ffffffd080a00000
> [   65.416980] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
> [   65.416987] x11: 0000008000000000 x10: ffffffd081c005c0 x9 : 0000000000000230
> [   65.416995] x8 : 0000000004000000 x7 : 0000007e08000000 x6 : 000000559ae52840
> [   65.417003] x5 : 000000559ae52c40 x4 : 0000000000000000 x3 : 0000000000000400
> [   65.417010] x2 : 0000000000000380 x1 : ffffffd080a00000 x0 : 000000559ae52840
> [   65.417018] Call trace:
> [   65.417021]  __arch_copy_to_user+0x180/0x240
> [   65.417026]  read_kcore_iter+0x5b4/0x830
> [   65.417035]  proc_reg_read_iter+0x8c/0xe8
> [   65.417042]  vfs_read+0x200/0x2a8
> [   65.417049]  ksys_read+0x70/0x108
> [   65.417054]  __arm64_sys_read+0x24/0x38
> [   65.417060]  invoke_syscall+0x50/0x128
> [   65.417067]  el0_svc_common.constprop.0+0x68/0x120
> [   65.417073]  do_el0_svc+0x40/0xb8
> [   65.417079]  el0_svc+0x30/0x98
> [   65.417086]  el0t_64_sync_handler+0xc0/0xc8
> [   65.417092]  el0t_64_sync+0x190/0x198

Looking at this quickly with Mark, the most likely explanation is that
a bogus kernel address is being passed as the source pointer to
copy_to_user(). On a whim, are you able to revert 4c91c07c93bb ("mm:
vmalloc: convert vread() to vread_iter()") and see if the issue persists? If
not, maybe you can try the commit before?

Otherwise, we'll see if we can reproduce the issue locally.

Cheers,

Will
