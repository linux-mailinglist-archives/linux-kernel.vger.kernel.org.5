Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E357D76EA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 23:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbjJYVkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 17:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjJYVke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 17:40:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B1B132;
        Wed, 25 Oct 2023 14:40:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F36DC433C7;
        Wed, 25 Oct 2023 21:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698270032;
        bh=ObgKYH0fS2mj/mvGmpx0d95XPn9BwP7C8YrKDWzCovk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=OeJhxYPboBK9ff7+ZjAslTD2fIqdeh0FrTxfSIPime7vzUJU/fooEUtZSFrjba7m1
         2kV+6SB9OXWRiwWJId/Ufw8gFs7dSeo4T9a8IoB/FKWTv4f7r8V3Pf/q+ggoD6l7xG
         /lDRH8qUW7a0/9ALY0UYkKK/mCqCrgO5wfYuETCef92QYbtd9pSjUWOYDUEAncfSrd
         yraO/WFH1lJC1TYbeasVWZrfjTKy5bYbOHoc1NwRNwnRjgbftW9WB9iUwDX9/0ZEsh
         4fb+bFJrq4WNZZmiD8meyc90OC1TPxTaxt355RZH+l7+sZnzGaNiVXkNR8ZpWViiPT
         IFFTM3zuxWGlA==
Message-ID: <dc96dc36c6df1d3bfa3006298e353f39.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231025194849.4esjw4w2trgalp55@mercury.elektranox.org>
References: <20231018070144.8512-1-zhangqing@rock-chips.com> <b0af9e04bafb07e8a73e8f242a4ff556.sboyd@kernel.org> <20231025194849.4esjw4w2trgalp55@mercury.elektranox.org>
Subject: Re: [PATCH v4 0/4] rockchip: add GATE_LINK
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     conor+dt@kernel.org, heiko@sntech.de, kever.yang@rock-chips.com,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        robh+dt@kernel.org, zhangqing@rock-chips.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, huangtao@rock-chips.com,
        andy.yan@rock-chips.com
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Date:   Wed, 25 Oct 2023 14:40:30 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sebastian Reichel (2023-10-25 12:48:49)
> Hello Stephen,
>=20
> On Mon, Oct 23, 2023 at 06:47:17PM -0700, Stephen Boyd wrote:
> > Quoting Elaine Zhang (2023-10-18 00:01:40)
> > > Recent Rockchip SoCs have a new hardware block called Native Interface
> > > Unit (NIU), which gates clocks to devices behind them. These effectiv=
ely
> > > need two parent clocks.
> > > Use GATE_LINK to handle this.
> >=20
> > Why can't pm clks be used here? The qcom clk driver has been doing that
> > for some time now.=20
> >=20
> >  $ git grep pm_clk_add -- drivers/clk/qcom/
>=20
> Maybe I'm mistaken, but as far as I can tell this is adding the
> dependency on controller level and only works because Qualcomm
> has multiple separate clock controllers. In the Rockchip design
> there is only one platform device.
>=20
> Note, that the original downstream code from Rockchip actually used
> pm_clk infrastructure by moving these clocks to separate platform
> devices. I changed this when upstreaming the code, since that leaks
> into DT and from DT point of view there should be only one clock
> controller.
>=20

Why can't the rockchip driver bind to a single device node and make
sub-devices for each clk domain and register clks for those? Maybe it
can use the auxiliary driver infrastructure to do that?
