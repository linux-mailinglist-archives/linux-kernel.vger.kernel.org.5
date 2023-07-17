Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 406217564D9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 15:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbjGQN0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 09:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbjGQN0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 09:26:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53024172D;
        Mon, 17 Jul 2023 06:25:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA40A6115A;
        Mon, 17 Jul 2023 13:24:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1806C433C8;
        Mon, 17 Jul 2023 13:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689600268;
        bh=buEyDtOD+tAaVWRktB28z7fW6D13J5yAHEKQhMLZQu4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L61XKSSxsznWwcDppB67UBRbXxw5UM0mEsoBltz2n5auT1pzJoo8sPFXI80yNg8eQ
         w0UlFS0z4UQNQNSUlF3vFWKacZp8xkn30u2kOlQ/xnGN1hf6z7Y8hvURby/TGNnhwP
         XP5sgBvpBukoqJoJphBnmewpOnhOW4zY8mlOT27EfRvVHOVXT8esXI4fiu/ky/67hY
         LJvAUReEu1iMKiggSpZxoWsTmkbHecl63tQBNF9QOyVfHOCIg5njyJSrzvX203jmOz
         2gxwXoFfwfGxaKx6wcZlDnE8q9rqQ4cPkB0HAg1qpr4+wcqejc0vTOtJ2tmOoBp5KF
         wyHeyFIieC5tg==
Date:   Mon, 17 Jul 2023 06:24:26 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Cc:     linux-stable <stable@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        lkft-triage@lists.linaro.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Anders Roxell <anders.roxell@linaro.org>
Subject: Re: stable-rc 6.1: x86: clang build failed -
 block/blk-cgroup.c:1237:6: error: variable 'ret' is used uninitialized
 whenever 'if' condition is true
Message-ID: <20230717132426.GA2561862@dev-arch.thelio-3990X>
References: <CA+G9fYs5n6aobE04YZy3Qy1ZMhAvH6-uQRqidgFmSoei91iW8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYs5n6aobE04YZy3Qy1ZMhAvH6-uQRqidgFmSoei91iW8g@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 12:55:42AM +0530, Naresh Kamboju wrote:
> Linux stable-rc 6.1 build failed x86 and i386 with clang.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> Build log:
> -----------
> block/blk-cgroup.c:1237:6: error: variable 'ret' is used uninitialized
> whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
>         if (init_blkcg_llists(blkcg))
>             ^~~~~~~~~~~~~~~~~~~~~~~~
> block/blk-cgroup.c:1287:9: note: uninitialized use occurs here
>         return ret;
>                ^~~
> block/blk-cgroup.c:1237:2: note: remove the 'if' if its condition is
> always false
>         if (init_blkcg_llists(blkcg))
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> block/blk-cgroup.c:1222:33: note: initialize the variable 'ret' to
> silence this warning
>         struct cgroup_subsys_state *ret;
>                                        ^
>                                         = NULL
> 1 error generated.
> 
> Links,
>  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y-sanity/build/v6.1.38-599-g5071846d06ef/testrun/18327562/suite/build/test/clang-lkftconfig/history/
>  - https://storage.tuxsuite.com/public/linaro/lkft/builds/2SfFoWj9NmKWHRijR0hcoXGjLhr/
> 
>  tuxmake \
>  --runtime podman --target-arch x86_64 \
>  --toolchain clang-16 \
>  --kconfig https://storage.tuxsuite.com/public/linaro/lkft/builds/2SfFoWj9NmKWHRijR0hcoXGjLhr/config
> \
>  LLVM=1 LLVM_IAS=1
> 

It looks like 6.1 needs commit b5a9adcbd5dc ("blk-cgroup: Return -ENOMEM
directly in blkcg_css_alloc() error path") if it wants to take commit
3b8cc6298724 ("blk-cgroup: Optimize blkcg_rstat_flush()").

Cheers,
Nathan
