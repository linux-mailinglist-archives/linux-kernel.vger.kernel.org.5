Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1BE78125F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 19:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354920AbjHRRwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 13:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379094AbjHRRvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 13:51:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E4126A8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 10:51:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACAB565812
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 17:51:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F886C433CD;
        Fri, 18 Aug 2023 17:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692381106;
        bh=iLvN5LUFc3qzwimwDQQmeQYT6TSxJS88Gz7h4Iz66/A=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=pOokOidFvAk3Pz6im4cQ5KDv3GlICSkoGkuXTlsRn2/Q5hOgU+3plZGnQIJ+vR6Wm
         702mNoxaR0/dwxU4Kp8n4Q25QakrrFw3S1wzQYd7SMZfifDahmMjSyG1dJS0Nkpa3+
         LHkZn47TI67o/HjgIDpN2bT2iSBbfCKoV/877C/Ud1YRhAqTMWf5WPspFBXk9L5YvS
         RcrewrbSEhbz8mmVN1KQgIDRlonulEGCfQmLLE3LYqBWqvanj7bGd/VuvPl939/f17
         tUCOmkvD3DxcPUcoLIpMDIokJdkm1IdGfq6A+qO1mQpfEskkHKKMBjiHDeqivELXBr
         l5WDTJVGULs4A==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org,
        Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>
In-Reply-To: <20230818080314.32991-1-alpernebiyasak@gmail.com>
References: <20230818080314.32991-1-alpernebiyasak@gmail.com>
Subject: Re: [PATCH] ASoC: amd: acp: Add kcontrols and widgets per-codec in
 common code
Message-Id: <169238110424.55727.14056670602872102489.b4-ty@kernel.org>
Date:   Fri, 18 Aug 2023 18:51:44 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Aug 2023 11:03:14 +0300, Alper Nebi Yasak wrote:
> Commit 7ac3404c2e21 ("ASoC: amd: acp: Map missing jack kcontrols") adds
> card kcontrols and DAPM widgets corresponding to jacks for Headphone and
> Headset Mic. But these were already being added in acp-legacy-mach.c and
> acp-sof-mach.c, so this causes a probe error:
> 
>   sof_mach rt5682s-hs-rt1019: control 2:0:0:Headphone Jack Switch:0 is already present
>   sof_mach rt5682s-hs-rt1019: ASoC: Failed to add Headphone Jack Switch: -16
>   sof_mach rt5682s-hs-rt1019: devm_snd_soc_register_card(sof-rt5682s-hs-rt1019) failed: -16
>   sof_mach: probe of rt5682s-hs-rt1019 failed with error -16
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: acp: Add kcontrols and widgets per-codec in common code
      commit: 919a4a941863c539e982d34903e93d9777316f7d

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

