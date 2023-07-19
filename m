Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01BF0759B0A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 18:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjGSQkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 12:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjGSQkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 12:40:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C112613E
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 09:40:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4CEDB615F9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 16:40:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A9EFC433C8;
        Wed, 19 Jul 2023 16:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689784814;
        bh=hpd4KDlCVbb9UV25Db6X99cNQA41UhTFbnri/UeLO4s=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=gb5p8/FFPdXgyqBN38mcYLDnewxT6m393E4gbTv/WXBaiI2Bwo8PLLRWltYWtZfB4
         0msKE3w9/9B5XBeq/sV0HCGSZZfc9gaE+EMElMGNAGEwNwpin6Ryjju9EUglxw/IYz
         6jsdDYW34QwTZGA4SN7BlK3iCqxg2BmZwu6rwr8gxBqoCkATijX1tX1V+SdGpS026l
         dR+5zHnLz2Xe8enBIxQ6IwrFNg5r9zzeO6UgxFIiswtYkZdrREK5ARTUjrSuw9MLzl
         7sT/sRyNu4pm/WoQxAeyYxU+2pP2EyFJv3JlPtg76CNQ846nqJslMFCwN9y1YeWLZg
         veM4cm+kPbplg==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230719130846.633701-1-arnd@kernel.org>
References: <20230719130846.633701-1-arnd@kernel.org>
Subject: Re: [PATCH] ASoC: amd: acp: fix SND_SOC_AMD_ACP_PCI depdenencies
Message-Id: <168978481190.111081.12971357887459390811.b4-ty@kernel.org>
Date:   Wed, 19 Jul 2023 17:40:11 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jul 2023 15:08:37 +0200, Arnd Bergmann wrote:
> The new PM functions require code that is part of the snd-acp-legacy-common
> module:
> 
> x86_64-linux-ld: sound/soc/amd/acp/acp-pci.o: in function `snd_acp_resume':
> acp-pci.c:(.text+0x23): undefined reference to `acp_init'
> x86_64-linux-ld: acp-pci.c:(.text+0x58): undefined reference to `acp_enable_interrupts'
> x86_64-linux-ld: sound/soc/amd/acp/acp-pci.o: in function `snd_acp_suspend':
> acp-pci.c:(.text+0x89): undefined reference to `acp_deinit'
> x86_64-linux-ld: sound/soc/amd/acp/acp-pci.o: in function `acp_pci_remove':
> acp-pci.c:(.text+0xec): undefined reference to `acp_deinit'
> x86_64-linux-ld: sound/soc/amd/acp/acp-pci.o: in function `acp_pci_probe':
> acp-pci.c:(.text+0x26b): undefined reference to `acp_init'
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: acp: fix SND_SOC_AMD_ACP_PCI depdenencies
      commit: 4edc07fc7fe1a9eec1a4ebc518d2dec222382f43

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

