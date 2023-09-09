Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413367992FF
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 02:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241496AbjIIAG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 20:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbjIIAG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 20:06:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D1B133;
        Fri,  8 Sep 2023 17:06:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C883C433C7;
        Sat,  9 Sep 2023 00:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694217982;
        bh=poS1zC35Ou/Eox389O+3kfe0qq35tr84EXWEkWfw4t8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=H7TpepoHQXgtTAWLHdiOh2jg9Ru/6aWmR3xB0V/FEtXn+7gm7h6+vUeVmgspIZl8V
         be3+XTBaOO1LzjsJHRPHrffUsJDL0n08V1eggRLhl83qLfQfGxx+AmLsA2q+aXpSKX
         G25FJgRwy5tPNJTjhBSUmJhRA1HD/PjyQxYwW9Ns1Hp5XYbETB4b5iJdR4OPU4tJph
         QsXB3LyWPSmcERUnpLFezFlaCaE5t0xFMrXlgL7hrGR8BmSXwTJfoNE/zJVzBsDJ16
         LnLT0ti4uah/6RLQ8fMR6Td9iBZFK4dIlSkORNwP5+/LV0WRXmhieRRv/feZCwF9km
         /ctQR3brRbT6A==
Message-ID: <de9c4d5ea85da5614563bee7d3368459.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <79a79ec5-3691-43d2-ca3e-478a94f85e2d@tuxon.dev>
References: <20230727053156.13587-1-claudiu.beznea@tuxon.dev> <20230727053156.13587-4-claudiu.beznea@tuxon.dev> <412f9209637e6eb861cd07e1d6dbc346.sboyd@kernel.org> <79a79ec5-3691-43d2-ca3e-478a94f85e2d@tuxon.dev>
Subject: Re: [PATCH 03/42] clk: at91: sam9x60: switch to parent_hw and parent_data
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, varshini.rajendran@microchip.com
To:     alexandre.belloni@bootlin.com,
        claudiu beznea <claudiu.beznea@tuxon.dev>, mripard@kernel.org,
        mturquette@baylibre.com, nicolas.ferre@microchip.com
Date:   Fri, 08 Sep 2023 17:06:18 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I missed this series in my review queue.

Quoting claudiu beznea (2023-08-01 21:24:54)
> On 29.07.2023 06:28, Stephen Boyd wrote:
> > Quoting Claudiu Beznea (2023-07-26 22:31:17)
> >> @@ -177,31 +178,34 @@ static const struct {
> >> -       td_slck_name =3D of_clk_get_parent_name(np, i);
> >> -
> >> -       i =3D of_property_match_string(np, "clock-names", "md_slck");
> >> -       if (i < 0)
> >> +       td_slck_hw =3D __clk_get_hw(clk);
> >=20
> > Don't introduce more usage of __clk_get_hw(). The index for "td_slck"
> > should be known, and it can be used as the index member in struct
> > clk_parent_data.  This allows the clk framework to lazily find the
> > parent, instead of requiring the parent to be registered before this
> > code runs. It also reduces the usage of __clk_get_hw().
>=20
> If I'll do this I will have to also change the approach that has been done
> for SAMA7G5 (already integrated in v6.5-rc1, maybe I had to let it more on
> the mailing list before taking into the tree) for all the clock drivers
> (basically instead of parent_hws I will have to provide parent_data to AT=
91
> clock registration APIs AFAICT). No issue with that... just telling...

Ok. Please do that.

>=20
> The reason I did it with parent_hws + __clk_get_hw() on PMC parents in
> SAMA7G5 is that SAMA7G5 PLL parent rate need to be known from the
> registration to setup properly the PLL. Otherwise PLL will not lock if not
> properly setup. For this I got the parent_hw for PLL parent to retrieve i=
ts
> rate and thus I chose at that time to also get the clk_hw for the other
> parents of PMC just to have the same approach on all parents (and it look=
ed
> to me that code will be simpler).

You can use the regular clk_get() APIs for that if you're trying to
enforce a "this clk must be registered first" sort of thing. If the
clk_get() call fails, then the driver can probe defer, etc. But don't
turn around and take that clk and call __clk_get_hw() on it to express
the parent relationship. Instead, let the parent matching take place
through the normal means. The goal is to get rid of __clk_get_hw() at
some point.
