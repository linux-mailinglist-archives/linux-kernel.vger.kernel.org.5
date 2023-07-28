Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E167B7671E4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 18:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbjG1Qfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 12:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232988AbjG1Qf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 12:35:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00FA4489
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 09:35:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 849AE62187
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 16:35:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82637C433C7;
        Fri, 28 Jul 2023 16:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690562115;
        bh=xrqCJGqg9GSk7yIgP9HX1dUpZQzOD1ks7daCXe0tR8Y=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=lInnsgVg0s6gCJmt2W7LegK//i6KTblUiWJ9oAi4PZeguVbV82PEAidBzMjYUA6N4
         2VlK1heX36m7f37VLx9OYCNLC6KESeWvI7wvjblJ9AB16pHN3ywYiWNNzR7esDRwT0
         aJAY3QMeR6SwQtb3JweSqf3oSicT5k8kRjdSI9iaPjHFIOvHDV61bPYaMsRYX+O9+H
         J7sZ5qJ5oVxkXcGyOqvb2Oht980wec+uh6qmFpX4zMI8CwEBp/QkMNqAzYwiQJf7Ve
         BvBn1OWiXgGpVsoc4JMd+Agf33X/fZO3yujSMJlpvbTfg8hMPglipA3o8rHpWFkWEl
         RiNH4hcuYHjTw==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Justin Stitt <justinstitt@google.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
In-Reply-To: <20230727-sound-soc-codecs-v1-1-562fa2836bf4@google.com>
References: <20230727-sound-soc-codecs-v1-1-562fa2836bf4@google.com>
Subject: Re: [PATCH] ASoC: 88pm860x: refactor deprecated strncpy
Message-Id: <169056211423.208880.7188858639779288535.b4-ty@kernel.org>
Date:   Fri, 28 Jul 2023 17:35:14 +0100
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

On Thu, 27 Jul 2023 22:46:13 +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> A suitable replacement is `strscpy` [2] due to the fact that it
> guarantees NUL-termination on its destination buffer argument which is
> _not_ always the case for `strncpy`!
> 
> In this case, though, there was care taken to ensure that the
> destination buffer would be NUL-terminated. The destination buffer is
> zero-initialized and each `pm860x->name[i]` has a size of
> `MAX_NAME_LENGTH + 1`. This means that there is unlikely to be a bug
> here.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: 88pm860x: refactor deprecated strncpy
      commit: a9a65b87a5553a4ecabad7093ef6a1088bb71b88

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

