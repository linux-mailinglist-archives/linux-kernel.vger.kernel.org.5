Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA00756FB7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 00:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjGQWWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 18:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjGQWWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 18:22:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C8191
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 15:22:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78F3A612D6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 22:22:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D96EFC433C7;
        Mon, 17 Jul 2023 22:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689632527;
        bh=G6PuoJ2y89UuJ50f9d8W1RSKzpzugu9kBzSMzcHhjGo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=bJMWl/IxppPTp52LeAY0wpE5/uLom43TiRlIpB6vxmzYIuDRPQAOvqF13zlD5bZZw
         J4t3AfKwrdEPjDQWbZhin7qYawUbOJOK+KrgUfP+RaJh5sDHEi2C6f0+CIFLOxsixe
         ZbxATYM5e18lnOgc4uAmmIuACrvh+lClXMIxwWEb2xf6m3lReXFa31GzWEnjrAi/TL
         Avj8NxHrJhFz06l1RhYwEpL6E+BATYITv3nozv5JB/XAYcBSULTqTq/TDqsQjARvT6
         DLST7ILfx65l3cS0HRKpLDECBWfA6Lghh1AcP9L9Csej9sKdV4Xny9RWtua/RQOHr6
         dS++rZkihUMZg==
From:   Mark Brown <broonie@kernel.org>
To:     Martin Fuzzey <martin.fuzzey@flowbird.group>
Cc:     Support Opensource <support.opensource@diasemi.com>,
        Benjamin Bara <benjamin.bara@skidata.com>,
        Adam Ward <DLG-Adam.Ward.opensource@dm.renesas.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230616143736.2946173-1-martin.fuzzey@flowbird.group>
References: <20230616143736.2946173-1-martin.fuzzey@flowbird.group>
Subject: Re: [PATCH] regulator: da9063: fix null pointer deref with partial
 DT config
Message-Id: <168963252661.526438.6586600125565152688.b4-ty@kernel.org>
Date:   Mon, 17 Jul 2023 23:22:06 +0100
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

On Fri, 16 Jun 2023 16:36:28 +0200, Martin Fuzzey wrote:
> When some of the da9063 regulators do not have corresponding DT nodes
> a null pointer dereference occurs on boot:
> 
> [    1.559034] 8<--- cut here ---
> [    1.564014] Unable to handle kernel NULL pointer dereference at virtual address 00000098 when read
> [    1.578055] [00000098] *pgd=00000000
> [    1.593575] Internal error: Oops: 5 [#1] SMP ARM
> [    1.634870] PC is at da9063_regulator_probe+0x35c/0x788
> [    1.647934] LR is at da9063_regulator_probe+0x2e8/0x788
> [    2.073626]  da9063_regulator_probe from platform_probe+0x58/0xb8
> [    2.079759]  platform_probe from really_probe+0xd8/0x3c0
> [    2.085092]  really_probe from __driver_probe_device+0x94/0x1e8
> [    2.091026]  __driver_probe_device from driver_probe_device+0x2c/0xd0
> [    2.097479]  driver_probe_device from __device_attach_driver+0xa4/0x11c
> [    2.104107]  __device_attach_driver from bus_for_each_drv+0x84/0xdc
> [    2.110402]  bus_for_each_drv from __device_attach_async_helper+0xb0/0x110
> [    2.117295]  __device_attach_async_helper from async_run_entry_fn+0x3c/0x158
> [    2.124369]  async_run_entry_fn from process_one_work+0x1d4/0x3e4
> [    2.130485]  process_one_work from worker_thread+0x30/0x520
> [    2.136070]  worker_thread from kthread+0xdc/0xfc
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: da9063: fix null pointer deref with partial DT config
      commit: 98e2dd5f7a8be5cb2501a897e96910393a49f0ff

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

