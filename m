Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B53BC7671E5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 18:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233010AbjG1Qfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 12:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233128AbjG1Qfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 12:35:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C741A4497
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 09:35:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63F736218C
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 16:35:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71D2BC433C8;
        Fri, 28 Jul 2023 16:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690562118;
        bh=DoVwk5cw4lHeorzGw8TinHHfK83bjvPZo1PlOG1eoZA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=iBVanlnsFj/wWIQupGmfXwv38rePffMDw9duJTNhoGjp/yiz18q6e5BcufHfGtgh2
         2N244UZ2chau5lMu7XQ8jTAC1s2cYly8XbF8Zy9GTnEvmF73kZE9YcC9SUSvc2jtA+
         pzosk9DlCMwjOnksou7E8IpSWQsuyw5LGDwlwjtFA8jGZcb8QgJzClc4f1pXeZ4dwh
         5gYtUGQBb7lx+mPpvBYh2AET5Qyn5GzER6N+3M5l6uI8PzeYzO+C+Z/40xX6Rcinz+
         cymDQ7AcaoZ7CwOBUv4eP/wZVrmAJuY/sguf7a806Ct9ZClvJiqffRQ7KrXS5X6TB7
         n9JGg+2gV6D4w==
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Justin Stitt <justinstitt@google.com>
Cc:     alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
In-Reply-To: <20230727-sound-soc-fsl-v1-1-4fc0ed7e0366@google.com>
References: <20230727-sound-soc-fsl-v1-1-4fc0ed7e0366@google.com>
Subject: Re: [PATCH] ASoC: fsl_micfil: refactor deprecated strncpy
Message-Id: <169056211617.208880.10400351966983316793.b4-ty@kernel.org>
Date:   Fri, 28 Jul 2023 17:35:16 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jul 2023 22:26:41 +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> A suitable replacement is `strscpy` [2] due to the fact that it
> guarantees NUL-termination on its destination buffer argument which is
> _not_ always the case for `strncpy`!
> 
> In this case, though, there was great care taken to ensure that the
> destination buffer would be NUL-terminated through the use of `len - 1`
> ensuring that the previously zero-initialized buffer would not overwrite
> the last NUL byte. This means that there's no bug here.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_micfil: refactor deprecated strncpy
      commit: 7eb10bfbbae6025cb7b4bba3db0c1281eac05862

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

