Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDFD774B95
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234058AbjHHUum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235083AbjHHUu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:50:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CECDF1CA56
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 13:32:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6711662C88
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 20:32:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D474C433C9;
        Tue,  8 Aug 2023 20:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691526766;
        bh=ml8jDgUG2KwsqhNQBURf1IbWBkdHXDt+I7v9LKUEo3k=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Je6zQFJUmgtb/KUhwwLqn3dU8EsvFxXdv8Jx9vwP9NujqK7rNlVkk8wWQ8BTFlQix
         4Dbp2r/K/uhJBK/GyiRYDhrOBdk4ed5QSuYwqiv3SY/3OVtHR3FAP64XCv4Q0JvUKC
         ZFhrFeZuVZH0uSl+GG/Ywp056W9to41drxEP9ebGECHjYU4J2D8G6Aq5Zf5g6/SdLn
         B/pe6m7OEOrhfWDi1vMZfbhdO1Uov400U7Zb0EQl203RXR7C20Wm3Dciq06NhYSbpc
         vkwZHfhJF9Zpe6oCO087sGnrQE111QpP9H4IjN6olMsTwVMHycDkhvcS6tI2e7nid1
         y8nFSc1Z/CkIQ==
From:   Mark Brown <broonie@kernel.org>
To:     Weidong Wang <wangweidong.a@awinic.com>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230808125703.1611325-1-arnd@kernel.org>
References: <20230808125703.1611325-1-arnd@kernel.org>
Subject: Re: [PATCH] ASoC: codecs: aw88261: avoid uninitialized variable
 warning
Message-Id: <169152676489.192712.6832901777571090965.b4-ty@kernel.org>
Date:   Tue, 08 Aug 2023 21:32:44 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Aug 2023 14:56:54 +0200, Arnd Bergmann wrote:
> aw88261_reg_update() returns an unintialized error code in the
> success path:
> 
> sound/soc/codecs/aw88261.c:651:7: error: variable 'ret' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
>                 if (aw_dev->prof_cur != aw_dev->prof_index) {
>                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> sound/soc/codecs/aw88261.c:660:9: note: uninitialized use occurs here
>         return ret;
>                ^~~
> sound/soc/codecs/aw88261.c:651:3: note: remove the 'if' if its condition is always true
>                 if (aw_dev->prof_cur != aw_dev->prof_index) {
>                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: aw88261: avoid uninitialized variable warning
      commit: 87b56172431bc2e8c497d2f10ee8245313167bd9

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

