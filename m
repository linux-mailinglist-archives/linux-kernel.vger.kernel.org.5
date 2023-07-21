Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632F675D0C8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 19:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjGURlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 13:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjGURlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 13:41:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F60430D7;
        Fri, 21 Jul 2023 10:41:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5A4161D79;
        Fri, 21 Jul 2023 17:41:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC17EC433D9;
        Fri, 21 Jul 2023 17:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689961279;
        bh=zJbBzVrTE3SsczFn1QjsPwMrQ4mbPr921OxBHyUzC6A=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=oKUQHPYeWdW43/QTMiMvPdOo6uPWBGeOeforWpDzmKk8lxb+IfWtJmbg9/gveFr8N
         7bs4jzlyjDPt94VYyRC4otdkmsIh4gpTGM8PLgie+E4dR1Y+07N982rNbB74xQCRwr
         JDnrHq7I3pzVdEkjnVBVwrgaf+PNOAZ4jBBgY+GPVGJUKrOD0Rhb42wnuea48HDdqi
         1A+MtnodZ12iFokySRVDbVLfis5dUOiBRaw2RlU8rbu74054rERmMZqZX8PQthG5wl
         sMN8tkO1Vt9cWPhXbXoFqReG2QjtsIrs7Eb2xIpQvAFKfY37alofci28bhAfhsNWHp
         POej4xcO4Na+g==
From:   Mark Brown <broonie@kernel.org>
To:     Dimitris Papastamos <dp@opensource.wolfsonmicro.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <58f12a07-5f4b-4a8f-ab84-0a42d1908cb9@moroto.mountain>
References: <58f12a07-5f4b-4a8f-ab84-0a42d1908cb9@moroto.mountain>
Subject: Re: [PATCH] regmap: rbtree: Use alloc_flags for memory allocations
Message-Id: <168996127755.147835.6184709116981834512.b4-ty@kernel.org>
Date:   Fri, 21 Jul 2023 18:41:17 +0100
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

On Fri, 21 Jul 2023 17:55:33 +0300, Dan Carpenter wrote:
> The kunit tests discovered a sleeping in atomic bug.  The allocations
> in the regcache-rbtree code should use the map->alloc_flags instead of
> GFP_KERNEL.
> 
> [    5.005510] BUG: sleeping function called from invalid context at include/linux/sched/mm.h:306
> [    5.005960] in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 117, name: kunit_try_catch
> [    5.006219] preempt_count: 1, expected: 0
> [    5.006414] 1 lock held by kunit_try_catch/117:
> [    5.006590]  #0: 833b9010 (regmap_kunit:86:(config)->lock){....}-{2:2}, at: regmap_lock_spinlock+0x14/0x1c
> [    5.007493] irq event stamp: 162
> [    5.007627] hardirqs last  enabled at (161): [<80786738>] crng_make_state+0x1a0/0x294
> [    5.007871] hardirqs last disabled at (162): [<80c531ec>] _raw_spin_lock_irqsave+0x7c/0x80
> [    5.008119] softirqs last  enabled at (0): [<801110ac>] copy_process+0x810/0x2138
> [    5.008356] softirqs last disabled at (0): [<00000000>] 0x0
> [    5.008688] CPU: 0 PID: 117 Comm: kunit_try_catch Tainted: G                 N 6.4.4-rc3-g0e8d2fdfb188 #1
> [    5.009011] Hardware name: Generic DT based system
> [    5.009277]  unwind_backtrace from show_stack+0x18/0x1c
> [    5.009497]  show_stack from dump_stack_lvl+0x38/0x5c
> [    5.009676]  dump_stack_lvl from __might_resched+0x188/0x2d0
> [    5.009860]  __might_resched from __kmem_cache_alloc_node+0x1dc/0x25c
> [    5.010061]  __kmem_cache_alloc_node from kmalloc_trace+0x30/0xc8
> [    5.010254]  kmalloc_trace from regcache_rbtree_write+0x26c/0x468
> [    5.010446]  regcache_rbtree_write from _regmap_write+0x88/0x140
> [    5.010634]  _regmap_write from regmap_write+0x44/0x68
> [    5.010803]  regmap_write from basic_read_write+0x8c/0x270
> [    5.010980]  basic_read_write from kunit_try_run_case+0x48/0xa0
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: rbtree: Use alloc_flags for memory allocations
      commit: 0c8b0bf42c8cef56f7cd9cd876fbb7ece9217064

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

