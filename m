Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B762C75D0C4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 19:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbjGURlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 13:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjGURlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 13:41:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A8630E3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 10:41:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BA7961CC7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 17:41:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A3A8C433C8;
        Fri, 21 Jul 2023 17:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689961276;
        bh=BWBwuKB6vj2J9nDq33aoGvQFcBzxuUoRkTa9PWqpsaM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=mHb8aBh/eT8/8EV9VMng21t/5kL24Qw9Q/sh1xGYX/C0TtIf9g2lzKLNOME1GkXwK
         EYDFP6GUa3a/4v8HmmzAcMSfXyIZ+y2KovHUFwEiueKAjHWyFb0g8klT1tLofo8ejZ
         bPFKcdWLnTewLF2GqJlxo+wPvB3mfbQlROLv/zYJkGTbwTlyEqNk0wTzmwDDn7Y6xa
         YZm/EKXbYa+cD9Qdl+rcHFlnAZyM6jzZRYDCbRjzl9QiP6bhTlHc3MuXQpFyNfzMCJ
         zcacreo5iT/waZ85XCpNcRPoeY8/iYqXukVTwgtoPfYUj4VXRN5264Tykh2XCcG0PP
         WoqczmjZF9EtA==
From:   Mark Brown <broonie@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20230719-regcache-async-rbtree-v1-1-b03d30cf1daf@kernel.org>
References: <20230719-regcache-async-rbtree-v1-1-b03d30cf1daf@kernel.org>
Subject: Re: [PATCH] regcache: Push async I/O request down into the rbtree
 cache
Message-Id: <168996127502.147835.89756829909209379.b4-ty@kernel.org>
Date:   Fri, 21 Jul 2023 18:41:15 +0100
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

On Wed, 19 Jul 2023 00:30:40 +0100, Mark Brown wrote:
> Currently the regcache core unconditionally enables async I/O for all cache
> types, causing problems for the maple tree cache which dynamically allocates
> the buffers used to write registers to the device since async requires the
> buffers to be kept around until the I/O has been completed.
> 
> This use of async I/O is mainly for the rbtree cache which stores data in
> a format directly usable for regmap_raw_write(), though there is a special
> case for single register writes which would also have allowed it to be used
> with the flat cache. It is a bit of a landmine for other caches since it
> implicitly converts sync operations to async, and with modern hardware it
> is not clear that async I/O is actually a performance win as shown by the
> performance work David Jander did with SPI. In multi core systems the cost
> of managing concurrency ends up swamping the performance benefit and almost
> all modern systems are multi core.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regcache: Push async I/O request down into the rbtree cache
      commit: b460a52257b1f5299ca70b7d1bb32442d3ce7bf6

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

