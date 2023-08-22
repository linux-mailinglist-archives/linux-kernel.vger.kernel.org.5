Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE34D784CD2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 00:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbjHVWYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 18:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjHVWYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 18:24:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303A0CD9;
        Tue, 22 Aug 2023 15:24:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA32161F95;
        Tue, 22 Aug 2023 22:24:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13D3FC433C8;
        Tue, 22 Aug 2023 22:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692743068;
        bh=nTHPJCzQgdGH0VBFK460TfmeqN8vYdTC4qLPavVn1r8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=hpBh6sESDI1fw3f78eeV4iQY3/7gttGnKJxQy73vfUxKgvI9XwjhaVaRwUpmCLxbD
         mszNXbUxVuL1Brqv6GbLaWA2OsznqG26e9o+cRLFhaYb2/NKkDCkZBn6H3IDpBzme7
         T/DV/fOCJPki2tKVnXRsCcKCx7SLaGkwVgs66G/ATBgSYWegBtRABmPmyBMgMGtdzx
         bxBdYo0H++D1ewZl6c/3fWsO9L3uN3fMOMjTu3TMXZASGlNXXzG8g1+Ukmo7x4Awk1
         6+OTT7I7GED/2YEG1IuF/aAiTVsCYa/srWRq0/nqTItZXmsf29AQkF7fBndegHxpMD
         QB5Xvsi8jeiGg==
Message-ID: <37ddd03b5c6f7a32f1733d9b6122d06b.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230805084847.3110586-1-andrej.skvortzov@gmail.com>
References: <20230805084847.3110586-1-andrej.skvortzov@gmail.com>
Subject: Re: [PATCH] clk: fix slab-out-of-bounds error in devm_clk_release
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Andrey Skvortsov <andrej.skvortzov@gmail.com>
To:     Alexandru Ardelean <aardelean@deviqon.com>,
        Andrey Skvortsov <andrej.skvortzov@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Uwe =?utf-8?q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 22 Aug 2023 15:24:25 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andrey Skvortsov (2023-08-05 01:48:47)
> Problem can be reproduces by unloading snd_soc_simple_card, because in
> devm_get_clk_from_child data were allocated as `struct clk`,
> but devm_clk_release expects `struct devm_clk_state`.
>=20
[...]
> Fixes: abae8e57e49a ("clk: generalize devm_clk_get() a bit")
> Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
> ---

Applied to clk-fixes but I removed the state->exit assignment because
that's the default. I also noticed that devm_clk_put() is broken in a
similar way. Sheesh!
