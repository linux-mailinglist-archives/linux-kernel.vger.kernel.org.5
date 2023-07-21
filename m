Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D16875CA6D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 16:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjGUOpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 10:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbjGUOoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 10:44:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FEB930C8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 07:44:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9DC761CD9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 14:44:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36715C433C9;
        Fri, 21 Jul 2023 14:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689950692;
        bh=6VlL8dRLHkXG8pOxpNRrMSsd3pniIRJ7W2uas+vIsrc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=f9aR/UFx6jO8nqYUhnL6wX7m4p4PA/5JvV/79cDv4BwAL1knJaM5OTOerRU8kuMw6
         5tkseyzFAJl8Lain0LtWQZtEOKRV27oSrDdMaharohjpY+cS9x6s4l2e/heijNcUxU
         GerG7FF5dNGwEFHFWuVDXM+/yPqif83GlrpeKIJ+vFbJXnH084Mgso2oHCWVAQj7ap
         T5cFeSK9il+GvYOBVUCjkuudibA1p5vQIiJ/hmV+IHWMYihLQe+WsvqHw2dsDyz1BX
         p3FHtFFtPsM83dkDsNcUqmcX7OeDe1hEr2z0GAcM3oAZ5r7sBzHDmL2sS3T4pAoNp6
         rzW036GfNcZUA==
From:   Mark Brown <broonie@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@linaro.org>
In-Reply-To: <20230720172021.2617326-1-linux@roeck-us.net>
References: <20230720172021.2617326-1-linux@roeck-us.net>
Subject: Re: [PATCH] regmap: maple: Use alloc_flags for memory allocations
Message-Id: <168995069092.110300.10620055785391584092.b4-ty@kernel.org>
Date:   Fri, 21 Jul 2023 15:44:50 +0100
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

On Thu, 20 Jul 2023 10:20:21 -0700, Guenter Roeck wrote:
> REGCACHE_MAPLE needs to allocate memory for regmap operations.
> This results in lockdep splats if used with fast_io since fast_io uses
> spinlocks for locking.
> 
> BUG: sleeping function called from invalid context at include/linux/sched/mm.h:306
> in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 167, name: kunit_try_catch
> preempt_count: 1, expected: 0
> 1 lock held by kunit_try_catch/167:
>  #0: 838e9c10 (regmap_kunit:86:(config)->lock){....}-{2:2}, at: regmap_lock_spinlock+0x14/0x1c
> irq event stamp: 146
> hardirqs last  enabled at (145): [<8078bfa8>] crng_make_state+0x1a0/0x294
> hardirqs last disabled at (146): [<80c5f62c>] _raw_spin_lock_irqsave+0x7c/0x80
> softirqs last  enabled at (0): [<80110cc4>] copy_process+0x810/0x216c
> softirqs last disabled at (0): [<00000000>] 0x0
> CPU: 0 PID: 167 Comm: kunit_try_catch Tainted: G                 N 6.5.0-rc1-00028-gc4be22597a36-dirty #6
> Hardware name: Generic DT based system
>  unwind_backtrace from show_stack+0x18/0x1c
>  show_stack from dump_stack_lvl+0x38/0x5c
>  dump_stack_lvl from __might_resched+0x188/0x2d0
>  __might_resched from __kmem_cache_alloc_node+0x1f4/0x258
>  __kmem_cache_alloc_node from __kmalloc+0x48/0x170
>  __kmalloc from regcache_maple_write+0x194/0x248
>  regcache_maple_write from _regmap_write+0x88/0x140
>  _regmap_write from regmap_write+0x44/0x68
>  regmap_write from basic_read_write+0x8c/0x27c
>  basic_read_write from kunit_generic_run_threadfn_adapter+0x1c/0x28
>  kunit_generic_run_threadfn_adapter from kthread+0xf8/0x120
>  kthread from ret_from_fork+0x14/0x3c
> Exception stack(0x881a5fb0 to 0x881a5ff8)
> 5fa0:                                     00000000 00000000 00000000 00000000
> 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: maple: Use alloc_flags for memory allocations
      commit: b0393e1fe40e962574613a5cdc4a470d6c1de023

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

