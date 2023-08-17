Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD33677F3A2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 11:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349743AbjHQJit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 05:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349733AbjHQJie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 05:38:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4E02D6D;
        Thu, 17 Aug 2023 02:38:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9F58664F6;
        Thu, 17 Aug 2023 09:38:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02A1CC433C7;
        Thu, 17 Aug 2023 09:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692265112;
        bh=kC6a0EiwYpF9lpn0LU7BESlVSAFKSEOxeOptrJqkj0s=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=kq1NCd4H7fhVVrycliRsTy3ZA0iFGKDAB/YmhauQaU1RZeP05NyI8aWkzNcQqaUiM
         wRTcFVscHM9YsobBig3QmCHitulpU8ELhA15WWgTwA7rBIjs+2ZSy05+cB42ZrVujH
         B3Ib+2jLP1I2yk2OQs0wuVjYbNLqCYxrXlFz7B9fy7j85eS2wAj/GFaCklgX5N9xhi
         UBMSQPIIQDqTsp+3g8epmsL2O6JkAWcbg0RoDvRzoIYFoliGtUvnXVXxZnWuEhw2Sf
         ptPK36moppZgwVRBcd6UXfhhE4Z+F1BSAK9O8QoT3yC/82lOIcIHexdeDeVhT2LOLv
         RLgXxHAiD8hxQ==
From:   Lee Jones <lee@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jakob Hauser <jahau@rocketmail.com>
Cc:     Beomho Seo <beomho.seo@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Raymond Hackley <raymondhackley@protonmail.com>,
        Pavel Machek <pavel@ucw.cz>, Axel Lin <axel.lin@ingics.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Henrik Grimler <henrik@grimler.se>,
        Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Sebastian Reichel <sebastian.reichel@collabora.com>
In-Reply-To: <223b440ab6831f2e7302d2c49b2cfd7779d5effd.1684182964.git.jahau@rocketmail.com>
References: <cover.1684182964.git.jahau@rocketmail.com>
 <223b440ab6831f2e7302d2c49b2cfd7779d5effd.1684182964.git.jahau@rocketmail.com>
Subject: Re: (subset) [PATCH v6 06/10 RESEND] power: supply:
 rt5033_charger: Add cable detection and USB OTG supply
Message-Id: <169226510772.947223.494995318945916008.b4-ty@kernel.org>
Date:   Thu, 17 Aug 2023 10:38:27 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 May 2023 22:57:15 +0200, Jakob Hauser wrote:
> Implement cable detection by extcon and handle the driver according to the
> connector type.
> 
> There are basically three types of action: "set_charging", "set_otg" and
> "set_disconnect".
> 
> A forth helper function to "unset_otg" was added because this is used in both
> "set_charging" and "set_disconnect". In the first case it covers the rather
> rare event that someone changes from OTG to charging without disconnect. In
> the second case, when disconnecting, the values are set back to the ones from
> initialization to return into a defined state.
> 
> [...]

Applied, thanks!

[06/10] power: supply: rt5033_charger: Add cable detection and USB OTG supply
        commit: c1af6bcc8583b0a1083338cd26c2090d0bcb0810

--
Lee Jones [李琼斯]

