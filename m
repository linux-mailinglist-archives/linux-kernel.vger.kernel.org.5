Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50DB27C8FFA
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 00:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbjJMWBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 18:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjJMWBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 18:01:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5FCB7;
        Fri, 13 Oct 2023 15:01:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC245C433C7;
        Fri, 13 Oct 2023 22:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697234476;
        bh=eN7+8Uo6JxL07H1+Tga+pr6b8+j6RjcgOEu8xBzIYig=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=KYvvVIrF5//SG+aOAPpO3yWmmp1TqkuMIlU8WxVNmZDEhYWdtuFm+6kba3N9CE9Cq
         jLFWe4Rhl7nhpLf/wx/PxCClh+kbhGuuIIT+ModtT7r1iAZoqO5OVh1m8GkUoTdreA
         uyfODD467MPyXEHr97OmwdZC3cO3m0xV2bbhUlLXeSVp9CN9o4/Gd2eGIsegyw0m7U
         uvDmAhJSP7k9uEf45oWh5agWBwdIm6/5Ju0ponf+KoPFpNAzKCoONa+U27g+KAyJgd
         MwpfyNG1UXXA1tCMSRQ/t+spLCiEfrKM/5meejxctbynQvm2IphlygNupZ6VHp6VbJ
         Dihkm/p62bC4w==
Message-ID: <2fb931d1aa2190b918d0ddba87579eeb.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1jmswnvub2.fsf@starbuckisacylon.baylibre.com>
References: <20231010062917.3624223-1-xianwei.zhao@amlogic.com> <20231010062917.3624223-5-xianwei.zhao@amlogic.com> <5e0bd4bba88701dd1a7a3e89d18412f0.sboyd@kernel.org> <1jmswnvub2.fsf@starbuckisacylon.baylibre.com>
Subject: Re: [PATCH V2 4/4] clk: meson: c3: add c3 clock peripherals controller driver
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Chuan Liu <chuan.liu@amlogic.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Xianwei Zhao <xianwei.zhao@amlogic.com>,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 13 Oct 2023 15:01:14 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jerome Brunet (2023-10-13 00:38:14)
>=20
> On Thu 12 Oct 2023 at 16:51, Stephen Boyd <sboyd@kernel.org> wrote:
>=20
> > Quoting Xianwei Zhao (2023-10-09 23:29:17)
> >> diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
> >> index 76be4bbd2afb..c8d59d28c8ff 100644
> >> --- a/drivers/clk/meson/Kconfig
> >> +++ b/drivers/clk/meson/Kconfig
> >> @@ -140,6 +140,19 @@ config COMMON_CLK_C3_PLL
> >>           Say Y if you want the board to work, because PLLs are the pa=
rent of most
> >>           peripherals.
> >> =20
> >> +config COMMON_CLK_C3_PERIPHERALS
> >> +       tristate "Amlogic C3 peripherals clock controller"
> >> +       default y
> >
> > Why are these default y? They should depend on something like ARM64 and
> > even then I don't see why we want to enable them by default if we're
> > building the ARM64 kernel.
>=20
> Should indeed depend on ARM64.

Cool.

>=20
> Those are the main clock controllers. Like for other AML SoC families,
> they are necessary to boot the device which is why they use 'default y'
>=20
> Is it a problem ?
>=20
> The whole meson directory depends on ARCH_MESON, so the drivers will go
> away if Amlogic support is removed on ARM64.

No it isn't a problem if the entire section is implicitly depending on
ARCH_MESON.
