Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 816A277C33D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 00:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233190AbjHNWGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 18:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233110AbjHNWGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 18:06:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908EBD1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 15:06:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2668363E67
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 22:06:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 209FBC433CB;
        Mon, 14 Aug 2023 22:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692050782;
        bh=XUWZEqCzGxUFJrUYiyg/6TZIHaEhgUuZ1vAe2I/92aw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ooMJkEi/zvtsqr4WpNzBqsOPJkkM7S/zb+fulWOj9Sins8wVmn+tC+D9CwCKwSyzG
         HRhy4MIabrhEeZUnbk1RjrdsWjjbTR28npP5ivNr7TR5g/R8Usycabswu4Hzvkryat
         TR9jT+50cSjN/B/3XFezDolz+GrTXmwxUkkh/mxGvSMQ/ghSlPmw3DTlZc+d9JOnG8
         IaOxuTiloN8PYmtpplBzfDmDZhIeB60UGCdE2F3CsHAOuNRsyVCeMIU/uxtfNpE1rj
         D/scP2eWfYpZyYbPGtDh68/wEZJzKLrEMnMWJPKxtY+5PrgeaqT4+jyC0zWVKcxkXy
         uEdMRngXr3zkg==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, Guiting Shen <aarongt.shen@gmail.com>
Cc:     perex@perex.cz, tiwai@suse.com, sboyd@kernel.org,
        mripard@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230813125520.11067-1-aarongt.shen@gmail.com>
References: <20230813125520.11067-1-aarongt.shen@gmail.com>
Subject: Re: [PATCH RESEND] ASoC: tlv320aic32x4: Fix the divide by zero
Message-Id: <169205078084.98708.10884185253435658032.b4-ty@kernel.org>
Date:   Mon, 14 Aug 2023 23:06:20 +0100
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

On Sun, 13 Aug 2023 20:55:20 +0800, Guiting Shen wrote:
> The value of register(NDAC,MDAC,NADC,MADC,BCLKN) maybe zero lead to
> divide by zero in clk_aic32x4_div_recalc_rate().And the rate should be
> divide by 128 if the value was zero in this function according to the
> datasheet.
> 
> Add the macro AIC32X4_DIV_MAX to present the 128 and return 0 if failing
> to read the value of register.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tlv320aic32x4: Fix the divide by zero
      commit: 11e756cc85fac43e2025306ad6aea80114cc7e98

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

