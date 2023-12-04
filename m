Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2A680391E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 16:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234763AbjLDPrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 10:47:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbjLDPrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 10:47:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B9DC1
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 07:47:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0298C433C8;
        Mon,  4 Dec 2023 15:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701704838;
        bh=Bi0EF5oXT4+t4j1Amj/0GO9G1Yr34yBAmoGJx5pBhVY=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=meJzE08AKAc7RHyEYNWcJwrRKMDBYeh2Jv6wi1vUMS30f1wt5DT9au9vq72AfYiWf
         CVJZm4+K15Tju6BJtbNmS1j74ftqCTueGkF066F0Z053ukgUWRJ7FcyWIVjDjVgbzI
         H/uip5GCNECzmI6D+oTpa9+Y1C6d+mRvc545UYO1ER6vgwgL0UNSbhLGDwL+5xxoyD
         AaJgmymYfmmd6jvl0nli11iaexy2gLLW0NKCNEWMsc1iYuPvqb759AJwEGWWznQ5X/
         2ymO+qcWLxdF4h3qnLebmrF/7IDw1gkEGt4digZIklLOr02vFxGFY69m+Ptam+gezf
         E6tl3sdNCsF2Q==
From:   Mark Brown <broonie@kernel.org>
To:     linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nam Cao <namcao@linutronix.de>
In-Reply-To: <cover.1701274975.git.namcao@linutronix.de>
References: <cover.1701274975.git.namcao@linutronix.de>
Subject: Re: [PATCH v2 0/2] spi: spl022: fix sleeping in interrupt context
Message-Id: <170170483664.64566.7462447970982303814.b4-ty@kernel.org>
Date:   Mon, 04 Dec 2023 15:47:16 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2023 17:31:54 +0100, Nam Cao wrote:
> While running the spl022, I got the following warning:
> BUG: sleeping function called from invalid context at drivers/spi/spi.c:1428
> 
> This is because between spi transfers, spi_transfer_delay_exec() (who
> may sleep if the delay is >10us) is called in interrupt context. This is
> a problem for anyone who runs this driver and need more than 10us delay.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: introduce SPI_TRANS_FAIL_IO for error reporting
      commit: 39cefd85098d12439586824c39f8e1948fac186d
[2/2] spi: spl022: switch to use default spi_transfer_one_message()
      commit: 9b2ef250b31d46f7ef522bd1bd84942f998bb3f9

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

