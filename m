Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910147731BA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 23:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjHGV5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 17:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjHGV5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 17:57:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0953094;
        Mon,  7 Aug 2023 14:57:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9AD3E6227C;
        Mon,  7 Aug 2023 21:57:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F283C433C8;
        Mon,  7 Aug 2023 21:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691445454;
        bh=ZBdsSzFVKRY6PmokTMG4ushfFOwsRYYskB/P5mPnNWc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Zvf0yctAVdibWfzojglrSgk/ffqQTc8vzB7IJkrzcfZa7QH0MZn98vW69pVpZkVIR
         nI9PyeW7HU5Nk6/Py7tx3PcwF1ZxIDqPnkgu/XO//NKjxtW3CzP774YZcBZgF4rOvH
         4kPMD4JQIisVzh4aoAEzpec2w/tZgAUqBCx1o9gd/2fCVZTZIixYh2g6TT7uJv9M28
         o/y15aCYTKSeh8AC4/X+aDpB6iEBG6SrWksS+/otxQSmly4nkyMlYnXOuyMREA2QWx
         Pp+omntF00A+zNsHqsTUA7DyHr7YkAD/pqGLRuRv1Q45jfC7y4HrjF5GEQrkkXazdq
         I33L5xUJA5GOQ==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        coolrrsh@gmail.com
Cc:     linux-kernel-mentees@lists.linuxfoundation.org
In-Reply-To: <20230807144942.30317-2-coolrrsh@gmail.com>
References: <20230807144942.30317-1-coolrrsh@gmail.com>
 <20230807144942.30317-2-coolrrsh@gmail.com>
Subject: Re: [PATCH v2] spi: spi-mpc52xx-psc: Fix an unsigned comparison
 that can never be negative
Message-Id: <169144545291.329334.7193582247834857976.b4-ty@kernel.org>
Date:   Mon, 07 Aug 2023 22:57:32 +0100
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

On Mon, 07 Aug 2023 20:19:42 +0530, coolrrsh@gmail.com wrote:
> In struct mpc52xx_psc_spi, the variable 'irq' is declared as an unsigned int.
> The comparison of variable 'irq'  with signed int operand is incorrect. Also,
> the return value from the call to platform_get_irq(pdev,0) is int and it is
> assigned to an unsigned int variable 'irq', thus redeclaring the type of
> variable 'irq' to signed int.
> 
> This fixes warning such as:
> drivers/spi/spi-mpc52xx-psc.c:332:5-13:
> WARNING: Unsigned expression compared with zero: mps -> irq < 0
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-mpc52xx-psc: Fix an unsigned comparison that can never be negative
      commit: 4f5177458ba97734149897c5d4d44f85b8fe0348

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

