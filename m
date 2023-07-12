Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C481751334
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 00:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbjGLWGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 18:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjGLWGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 18:06:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1006CB0;
        Wed, 12 Jul 2023 15:06:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82F1F6195D;
        Wed, 12 Jul 2023 22:06:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FD4AC433C8;
        Wed, 12 Jul 2023 22:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689199589;
        bh=3LvTkwHC1aXilpylTHfuT9Dd/jYCCcQvi0STTcj3u4Y=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=NbdF1saEXJmhy492uWVuPKrKChNGckdheEAFhSTAsQzFx1+WrcGPDEvfLb3PjcMuz
         X4kYsdx3USScMgN6LmCQgu2Bnkb7ZnfRxG7A1E49+NwBBTCW6NhmDKlH3JQ1h33/pC
         3zIVyQiWD7mntC/nSyTJrU/0KA4wFcyRvm5sHb1OhnsbIRB2Lb1HRXbQL2NuAl0a1x
         vKGGW4RBiI7ZCYmfuFbIurvN+L11MyQ/PIIDGoUS6BNWWaBhbRGsdVh3gA1DyRBK4V
         TA/YKNfMqvMKkqZvagtdmTGRjC10W3JoN389G48dPYkJn034zDrp3sgVyKMabGVQlr
         7xaJAOPh15G1A==
From:   Mark Brown <broonie@kernel.org>
To:     Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Saravana Kannan <saravanak@google.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        "Isaac J. Manjarres" <isaacmanjarres@google.com>
Cc:     Amit Pundir <amit.pundir@linaro.org>,
        John Stultz <jstultz@google.com>, stable@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        kernel-team@android.com,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230711193059.2480971-1-isaacmanjarres@google.com>
References: <20230711193059.2480971-1-isaacmanjarres@google.com>
Subject: Re: [PATCH v1] regmap-irq: Fix out-of-bounds access when
 allocating config buffers
Message-Id: <168919958636.823990.7053808708980391423.b4-ty@kernel.org>
Date:   Wed, 12 Jul 2023 23:06:26 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jul 2023 12:30:58 -0700, Isaac J. Manjarres wrote:
> When allocating the 2D array for handling IRQ type registers in
> regmap_add_irq_chip_fwnode(), the intent is to allocate a matrix
> with num_config_bases rows and num_config_regs columns.
> 
> This is currently handled by allocating a buffer to hold a pointer for
> each row (i.e. num_config_bases). After that, the logic attempts to
> allocate the memory required to hold the register configuration for
> each row. However, instead of doing this allocation for each row
> (i.e. num_config_bases allocations), the logic erroneously does this
> allocation num_config_regs number of times.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap-irq: Fix out-of-bounds access when allocating config buffers
      commit: 963b54df82b6d6206d7def273390bf3f7af558e1

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

