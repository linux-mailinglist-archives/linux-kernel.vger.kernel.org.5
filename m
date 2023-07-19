Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F43B75A054
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 23:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjGSVFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 17:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjGSVFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 17:05:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE921BF0;
        Wed, 19 Jul 2023 14:05:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F3F161821;
        Wed, 19 Jul 2023 21:05:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE731C433C7;
        Wed, 19 Jul 2023 21:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689800738;
        bh=SFibgF6YkGBeNXjqj/gtZ7x11MqvMBIJdb+ipYc8qH8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=KDkv3bTYk0DnruWqgU/F8mCH3c6RepJL7G//dYoqowEy8uZeThvyQDsyZBGMbFlXz
         PXh3nFjpoR7aNeOAFMRN+f9A5t6BeRPP/A8CR31g7Hv/GqZmqz4yB9owCSre8nwOH7
         et/awEwRpYGq5DSwZrRlJO5JMS1+TvK4lBNlD0kjYJfolTgvcIaYXrUZTvu99kN7fe
         Rqx/ig760cvAnUVuPHgTpm3bc8Jnwu78zE/SDNc0bN5MN4Cb7feAOJEBpdB6co9uUL
         agGIPPW8c9CEb55navreOWOBWR0mzr4g8/jQeim2mMFM6negG4VF3+U9Yp2sPBKkys
         Y/MpPJHrk+plw==
Message-ID: <0f12361faf464ea6c6d0313d1dc54f90.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230711150812.3562221-1-geert+renesas@glider.be>
References: <20230711150812.3562221-1-geert+renesas@glider.be>
Subject: Re: [PATCH] clk: imx93: Propagate correct error in imx93_clocks_probe()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        kernel test robot <lkp@intel.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
To:     Abel Vesa <abelvesa@kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Fabio Estevam <festevam@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Zhanhao Hu <zero12113@hust.edu.cn>
Date:   Wed, 19 Jul 2023 14:05:35 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Geert Uytterhoeven (2023-07-11 08:08:12)
> smatch reports:
>=20
>     drivers/clk/imx/clk-imx93.c:294 imx93_clocks_probe() error: uninitial=
ized symbol 'base'.
>=20
> Indeed, in case of an error, the wrong (yet uninitialized) variable is
> converted to an error code and returned.
> Fix this by propagating the error code in the correct variable.
>=20
> Fixes: e02ba11b45764705 ("clk: imx93: fix memory leak and missing unwind =
goto in imx93_clocks_probe")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/all/9c2acd81-3ad8-485d-819e-9e4201277831@=
kadam.mountain
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/all/202306161533.4YDmL22b-lkp@intel.com/
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Applied to clk-fixes
