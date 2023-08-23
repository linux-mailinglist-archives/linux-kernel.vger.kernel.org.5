Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB46E785D33
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 18:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237555AbjHWQ0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 12:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237562AbjHWQ0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 12:26:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F170810D2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 09:26:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C40D625CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 16:26:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E64DC433CB;
        Wed, 23 Aug 2023 16:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692807987;
        bh=/LkJgfupVFpt632Mz933PLJZ5tfycTZOgNLrJ7ORzfQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ZaPeVXdAFgGNOMa0XzJEJL1TckG07teK2plhNb++TYdzCisVcTd2rXZ7jbfV+N4rm
         Ao/T4HcPN+4q4/GsskdLRHz7xVe1N6C7jsd2Sm5V3hnz85Zfn9NufofWugnb0frnuy
         MDi+Ut8Q7Fe3WLZY3znSJsguge9zGLzeb9KUUUw8eU8N/9bfjAStiLb02GO6Fz+9dr
         JSWm/Bw++a9iQKDzfsoBWxD5ly1/aKeOHYLg7/O7HY7oLfdkelvHuxWoHo7sy67h6f
         dGQL/uwqbP3Nlt9voV7C2ZiT8q4QpFt+V9xxaQPa3TNU2b++RpAh+NpBw+8w1YBdw4
         +pELbNIBKCwCA==
From:   Mark Brown <broonie@kernel.org>
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc:     alsa-devel@alsa-project.org, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        Mastan Katragadda <Mastan.Katragadda@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS" 
        <sound-open-firmware@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
In-Reply-To: <20230823073340.2829821-1-Vijendar.Mukunda@amd.com>
References: <20230823073340.2829821-1-Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH 1/7] ASoC: SOF: amd: remove unused sha dma interrupt
 code
Message-Id: <169280798403.53791.13433879724804047736.b4-ty@kernel.org>
Date:   Wed, 23 Aug 2023 17:26:24 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Aug 2023 13:03:33 +0530, Vijendar Mukunda wrote:
> During initial development time for RN platform, when SHA
> dma gets completed, SHA DMA engine used to raise the ACP interrupt.
> In ACP interrupt handler, SHA DMA interrupt got handled.
> Currently SHA DMA compleition is verified by checking
> transfer count using read poll time out logic.
> Remove unused SHA dma interrupt handling code.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/7] ASoC: SOF: amd: remove unused sha dma interrupt code
      commit: aa836152420af94d014ddd677a5f95544abef4f6
[2/7] ASoC: SOF: amd: enable ACP external global interrupt
      commit: 0a1428141f638fc6fba863de40f0dc7ea91a1d47
[3/7] ASoC: SOF: amd: add module parameter for firmware debug
      commit: 60eb816ed850b33f5410b1223c5d4d935a6ceb79
[4/7] ASoC: SOF: amd: remove redundant clock mux selection register write
      commit: f3b2f8b7158026e7a0ab67f5e36c195cdb4c1bf8
[5/7] ASoC: SOF: amd: add conditional check for acp_clkmux_sel register
      commit: 0d9e4cf5b66e0ffca3d8cf8e9a111d4793877afe
[6/7] ASoC: SOF: amd: clear panic mask status when panic occurs
      commit: 3d02e1c439b4140215b624d423aa3c7554b17a5a
[7/7] ASoC: SOF: amd: clear dsp to host interrupt status
      commit: 38592ae6dc9f84b7a994c43de2136b8115ca30f6

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

