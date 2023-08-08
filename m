Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7308C77461E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbjHHSxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbjHHSw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:52:59 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F371915790D;
        Tue,  8 Aug 2023 10:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=QkuDXA4j1tGMsv4/ORMgt9CX3zHb9CYX5634imlS4UY=; b=GnxRtNBN9QfTDtlrGsdD6R8saj
        xV1PknLE+Z7yZpqrg/i9TuFRLGbD0aHl1PKQye/yCUOuYHNkCfFcs/U3baUwd2vFSTI86v9XnNXC5
        xcaqPSDA6UMnKbd7JdrzPpwXnuW/GPPkvcOOjj09KQDskJpC2OcfIGOMnBgvZaPOiJig=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qTMSy-003SxZ-Ku; Tue, 08 Aug 2023 15:09:40 +0200
Date:   Tue, 8 Aug 2023 15:09:40 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 0/2] net: stmmac: allow sharing MDIO lines
Message-ID: <05e574e3-688e-49d6-b3e6-80b36bfc5158@lunn.ch>
References: <20230807193102.6374-1-brgl@bgdev.pl>
 <54421791-75fa-4ed3-8432-e21184556cde@lunn.ch>
 <CAMRc=Mc6COaxM6GExHF2M+=v2TBpz87RciAv=9kHr41HkjQhCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=Mc6COaxM6GExHF2M+=v2TBpz87RciAv=9kHr41HkjQhCg@mail.gmail.com>
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Ok so upon some further investigation, the actual culprit is in stmmac
> platform code - it always tries to register an MDIO bus - independent
> of whether there is an actual mdio child node - unless the MAC is
> marked explicitly as having a fixed-link.

If the MDIO bus does exist registering it should not be a problem.
Ideally it should have an internal pull up on its MDIO line, so that
all reads return 0xffff. The phylib core will then determine there are
no devices on it. Not actually registering it because there is no MDIO
node in DT is just an optimisation.

> When I fixed that, MAC1's probe is correctly deferred until MAC0 has
> created the MDIO bus.

Great. That is how it should work.

> Even so, isn't it useful to actually reference the shared MDIO bus in some way?

Why? Linux does not care where the PHY is. There are some SoCs with an
independent MDIO bus masters. They have there own node in DT, there
own driver etc. You can create an MDIO bus from two or three GPIOs and
bit banging, again as an node in DT.  There are Ethernet switches
which can have 11 ports, and 2 MDIO busses, one purely internal and
one external, and the PHYs are scattered over these busses.

All linux needs is a phandle to the PHY, nothing more.

	Andrew
