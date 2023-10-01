Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42FEE7B4782
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 15:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234974AbjJANAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 09:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjJANAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 09:00:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231D0A7
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 06:00:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8CFCDC433C9;
        Sun,  1 Oct 2023 13:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696165228;
        bh=KE32febKGb47tLpnvfPISs6CgPJyT2Z3jvLI18b/CZE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Cb6N9le8JIVKWgDdKmhaJat4dEl3HSDKhi2nW1LRvFb8Tt9vUbNkxFOCD11at5p6m
         Q/Qf9zsCWCLVy/zKl3WEVIuV3uD/X7i2IoQfBa6/ikbt5gzyJpsioQlchb1q8yw8RR
         E5JXts2uCQ2OvG1F8qseOihpHVyUgh6zPvkA0qa6GPk/XG73ZQuQ2wrUXmi8rsyoHQ
         pjDQL77APMR76tXt4LDBi+yQC2fGkA8YXRHGzqpi1QdZTKxj0g/z6oaQFI5IOG+6gI
         4UGLlZciSf9Yo0gnVv55CKbNFrawshLoAHLM+SeGrL8dMZ2XhezxBToIzJvAobiphg
         NkNJbkiuFjukg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 77625E29AFE;
        Sun,  1 Oct 2023 13:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: stmmac: platform: fix the incorrect parameter
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169616522848.29918.13585341326782756004.git-patchwork-notify@kernel.org>
Date:   Sun, 01 Oct 2023 13:00:28 +0000
References: <20230921062443.1251292-1-xiaoning.wang@nxp.com>
In-Reply-To: <20230921062443.1251292-1-xiaoning.wang@nxp.com>
To:     Clark Wang <xiaoning.wang@nxp.com>
Cc:     alexandre.torgue@foss.st.com, joabreu@synopsys.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, mcoquelin.stm32@gmail.com,
        bartosz.golaszewski@linaro.org, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 21 Sep 2023 14:24:43 +0800 you wrote:
> The second parameter of stmmac_pltfr_init() needs the pointer of
> "struct plat_stmmacenet_data". So, correct the parameter typo when calling the
> function.
> 
> Otherwise, it may cause this alignment exception when doing suspend/resume.
> [   49.067201] CPU1 is up
> [   49.135258] Internal error: SP/PC alignment exception: 000000008a000000 [#1] PREEMPT SMP
> [   49.143346] Modules linked in: soc_imx9 crct10dif_ce polyval_ce nvmem_imx_ocotp_fsb_s400 polyval_generic layerscape_edac_mod snd_soc_fsl_asoc_card snd_soc_imx_audmux snd_soc_imx_card snd_soc_wm8962 el_enclave snd_soc_fsl_micfil rtc_pcf2127 rtc_pcf2131 flexcan can_dev snd_soc_fsl_xcvr snd_soc_fsl_sai imx8_media_dev(C) snd_soc_fsl_utils fuse
> [   49.173393] CPU: 0 PID: 565 Comm: sh Tainted: G         C         6.5.0-rc4-next-20230804-05047-g5781a6249dae #677
> [   49.183721] Hardware name: NXP i.MX93 11X11 EVK board (DT)
> [   49.189190] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [   49.196140] pc : 0x80800052
> [   49.198931] lr : stmmac_pltfr_resume+0x34/0x50
> [   49.203368] sp : ffff800082f8bab0
> [   49.206670] x29: ffff800082f8bab0 x28: ffff0000047d0ec0 x27: ffff80008186c170
> [   49.213794] x26: 0000000b5e4ff1ba x25: ffff800081e5fa74 x24: 0000000000000010
> [   49.220918] x23: ffff800081fe0000 x22: 0000000000000000 x21: 0000000000000000
> [   49.228042] x20: ffff0000001b4010 x19: ffff0000001b4010 x18: 0000000000000006
> [   49.235166] x17: ffff7ffffe007000 x16: ffff800080000000 x15: 0000000000000000
> [   49.242290] x14: 00000000000000fc x13: 0000000000000000 x12: 0000000000000000
> [   49.249414] x11: 0000000000000001 x10: 0000000000000a60 x9 : ffff800082f8b8c0
> [   49.256538] x8 : 0000000000000008 x7 : 0000000000000001 x6 : 000000005f54a200
> [   49.263662] x5 : 0000000001000000 x4 : ffff800081b93680 x3 : ffff800081519be0
> [   49.270786] x2 : 0000000080800052 x1 : 0000000000000000 x0 : ffff0000001b4000
> [   49.277911] Call trace:
> [   49.280346]  0x80800052
> [   49.282781]  platform_pm_resume+0x2c/0x68
> [   49.286785]  dpm_run_callback.constprop.0+0x74/0x134
> [   49.291742]  device_resume+0x88/0x194
> [   49.295391]  dpm_resume+0x10c/0x230
> [   49.298866]  dpm_resume_end+0x18/0x30
> [   49.302515]  suspend_devices_and_enter+0x2b8/0x624
> [   49.307299]  pm_suspend+0x1fc/0x348
> [   49.310774]  state_store+0x80/0x104
> [   49.314258]  kobj_attr_store+0x18/0x2c
> [   49.318002]  sysfs_kf_write+0x44/0x54
> [   49.321659]  kernfs_fop_write_iter+0x120/0x1ec
> [   49.326088]  vfs_write+0x1bc/0x300
> [   49.329485]  ksys_write+0x70/0x104
> [   49.332874]  __arm64_sys_write+0x1c/0x28
> [   49.336783]  invoke_syscall+0x48/0x114
> [   49.340527]  el0_svc_common.constprop.0+0xc4/0xe4
> [   49.345224]  do_el0_svc+0x38/0x98
> [   49.348526]  el0_svc+0x2c/0x84
> [   49.351568]  el0t_64_sync_handler+0x100/0x12c
> [   49.355910]  el0t_64_sync+0x190/0x194
> [   49.359567] Code: ???????? ???????? ???????? ???????? (????????)
> [   49.365644] ---[ end trace 0000000000000000 ]---
> 
> [...]

Here is the summary with links:
  - [net] net: stmmac: platform: fix the incorrect parameter
    https://git.kernel.org/netdev/net/c/6b09edc1b317

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


