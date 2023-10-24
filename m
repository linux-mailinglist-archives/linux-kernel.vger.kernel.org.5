Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE5F7D45B8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 04:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbjJXCvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 22:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbjJXCvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 22:51:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170BE10A;
        Mon, 23 Oct 2023 19:50:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DB15C433C7;
        Tue, 24 Oct 2023 02:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698115858;
        bh=ECr5ZJxdFFyYc11ubfZSs54qOOUCIcaZ7LR/5g5OzUQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=cgw613z2rQFqTj8u9QjDMQCOA5in+b3q/5FTcamjTg/UCWbpCYzFcYJeclK5mcg0l
         EC1v98hT6UHw0SND4LyCUlSXqrF3xSvbNR0aBUb3VBZrrnt6R8bRsVhcXtVAt8aIMB
         XkwzaFBzoyA3g2KR1p4IoXReFjsbWIsG8/+o0x0QDGt1lrw1CTLb+hVX8s8VUy+ry8
         G3b4Dsy7m7Do6fVYAW3SyBRldrBKWeIi2guxxwAeDLNprBW3IblGgJPEpslE9bViBY
         IgvhdCWPupt0vLMgNZi/MsKpUXu0Hnw2Bi8OHWj8Ab2mLOOWA+Z4wTLF6MiXydtW6z
         3FcO/gsUKC2mA==
Message-ID: <c67485276711555b1081ad5e2748230f.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230915-ep93xx-v4-4-a1d779dcec10@maquefel.me>
References: <20230915-ep93xx-v4-0-a1d779dcec10@maquefel.me> <20230915-ep93xx-v4-4-a1d779dcec10@maquefel.me>
Subject: Re: [PATCH v4 04/42] clk: ep93xx: add DT support for Cirrus EP93xx
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Nikita Shubin via B4 Relay 
        <devnull+nikita.shubin.maquefel.me@kernel.org>,
        nikita.shubin@maquefel.me
Date:   Mon, 23 Oct 2023 19:50:56 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nikita Shubin via B4 Relay (2023-09-15 01:10:46)
> diff --git a/drivers/clk/clk-ep93xx.c b/drivers/clk/clk-ep93xx.c
> new file mode 100644
> index 000000000000..e8d3bd595255
> --- /dev/null
> +++ b/drivers/clk/clk-ep93xx.c
> @@ -0,0 +1,753 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Clock control for Cirrus EP93xx chips.
[...]
> +#define EP93XX_SYSCON_KEYTCHCLKDIV_KEN 15
> +#define EP93XX_SYSCON_KEYTCHCLKDIV_KDIV        0
> +#define EP93XX_SYSCON_CHIPID           0x94
> +#define EP93XX_SYSCON_CHIPID_ID                0x9213
> +
> +static const char adc_divisors[] =3D { 16, 4 };
> +static const char sclk_divisors[] =3D { 2, 4 };
> +static const char lrclk_divisors[] =3D { 32, 64, 128 };
> +
> +static const struct clk_parent_data ep93xx_clk_parents[] =3D {
> +       { .fw_name =3D "xtali", .name =3D "xtali" },

Drop name. And please drop fw_name too and set .index to 0 explicitly.

> +       { .index =3D -1, .name =3D "pll1" },
> +       { .index =3D -1, .name =3D "pll2" },

These two should come from DT via index as well. The binding should be
changed to list the pll. In the previous review you mentioned the SoC
driver was populating these. The answer is yes that you should be
providing an OF clk provider (and updating the binding) to provide those
clks to this device node. Otherwise it won't be possible to describe the
connection besides with the name fallback method, which is not desired.

> +};
> +
