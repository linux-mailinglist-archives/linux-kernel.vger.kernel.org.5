Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A386776CBB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 01:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbjHIXVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 19:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbjHIXVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 19:21:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1F4E5B;
        Wed,  9 Aug 2023 16:21:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3C1164C55;
        Wed,  9 Aug 2023 23:21:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 489BAC433C7;
        Wed,  9 Aug 2023 23:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691623312;
        bh=USqhI4biVjQf9mLtB0Gt5vcC0I3am7Ah63j8X0xD5/c=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=fVQ4RhlTZ1mE48I0JR0BsvFE8xh3saTwun0k7uP9RFr4CYOBrTHbNcZf6teey9EBy
         NMQC0lRTVWC7/ZOjxasN0Gd+XlaW4DucpO0IEvTY7Z7uJaHdp8BvPwwu+kctZkmRtp
         8Wx/P2Gdibgfrjk5m+NNTWRrVLZiCMXAj0T5vd90oGc+GDSgJdtrZRpbo4iJamT1jp
         R0/KB4/NcUy1QhYOsP+DY/QEUWmveJb1kUyzHRrjL3hFrytK7amMNxIC8XthtTm/Nu
         Q5h9udHmF1UkGdglSW+XYjGtYLc/yqt0Dy+XH2zluz26ZhHnMKJI/tkAAzMoiJl4qo
         ceSrI94DH84DA==
Message-ID: <088cc246369820d5a426bc8823c85c8e.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230721-clk-fix-kunit-lockdep-v1-0-32cdba4c8fc1@kernel.org>
References: <20230721-clk-fix-kunit-lockdep-v1-0-32cdba4c8fc1@kernel.org>
Subject: Re: [PATCH 0/2] clk: kunit: Fix the lockdep warnings
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maxime Ripard <mripard@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        kernel test robot <yujie.liu@intel.com>,
        kunit-dev@googlegroups.com
To:     Maxime Ripard <mripard@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Wed, 09 Aug 2023 16:21:50 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+kunit-dev

Quoting Maxime Ripard (2023-07-21 00:09:31)
> Hi,
>=20
> Here's a small series to address the lockdep warning we have when
> running the clk kunit tests with lockdep enabled.
>=20
> For the record, it can be tested with:
>=20
> $ ./tools/testing/kunit/kunit.py run \
>     --kunitconfig=3Ddrivers/clk \
>     --cross_compile aarch64-linux-gnu- --arch arm64 \
>     --kconfig_add CONFIG_DEBUG_KERNEL=3Dy \
>     --kconfig_add CONFIG_PROVE_LOCKING=3Dy
>=20
> Let me know what you think,

Thanks for doing this. I want to roll these helpers into the clk_kunit.c
file that I had created for some other clk tests[1]. That's mostly
because clk.c is already super long and adding kunit code there makes
that problem worse. I'll try to take that patch out of the rest of the
series and then add this series on top and resend.

I don't know what to do about the case where CONFIG_KUNIT=3Dm though. We
have to export clk_prepare_lock/unlock()? I really don't want to do that
even if kunit is enabled (see EXPORT_SYMBOL_IF_KUNIT). Maybe if there
was a GPL version of that, so proprietary modules can't get at kernel
internals on kunit enabled kernels.

But I also like the approach taken here of adding a small stub around
the call to make sure a test is running. Maybe I'll make a kunit
namespaced exported gpl symbol that bails if a test isn't running and
calls the clk_prepare_lock/unlock functions inside clk.c and then move
the rest of the code to clk_kunit.c to get something more strict.

[1] https://lore.kernel.org/all/20230327222159.3509818-9-sboyd@kernel.org/
