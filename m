Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C844783A50
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 09:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbjHVHHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 03:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjHVHHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 03:07:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C389130;
        Tue, 22 Aug 2023 00:07:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8B6E64244;
        Tue, 22 Aug 2023 07:07:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1D55C433C8;
        Tue, 22 Aug 2023 07:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692688065;
        bh=d7xbpsQutE/31GLl4hB/Q4ABnnr1PfLlY7OsceIn+zM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NdhbNII6nUMZKsIFq4qeXlqiEpIjGqdASMrzWamLsOrQryVdbEm/QJwtB3stP9mQJ
         9oZ/5yE8XLY2e7tERRhVXaF6XibplLcBURaCEyMMw/3kDOUshPMn/zkKtYop/fk5Pg
         4O+jL77Y1RKE4EQMMYEb8bw7gW08+rsLjeNW8MKbCdKBJEVL2VOy7BF2Z1A8rccAE5
         H6FgYXH4s8KDs6kF9qeXoUzQFjS9tnVQE4XtKxmMBEBE264Dafp86nSy3AApTdmPOy
         eNKAtYvwWSFxo43maiTIMRgY+1yD9G93Ed3B81geIBtKXdnYREEStW3vgft96okARm
         AqjD//LPfo2Aw==
Date:   Tue, 22 Aug 2023 08:07:37 +0100
From:   Lee Jones <lee@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>,
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
Subject: Re: (subset) [PATCH v6 06/10 RESEND] power: supply: rt5033_charger:
 Add cable detection and USB OTG supply
Message-ID: <20230822070737.GP1380343@google.com>
References: <cover.1684182964.git.jahau@rocketmail.com>
 <223b440ab6831f2e7302d2c49b2cfd7779d5effd.1684182964.git.jahau@rocketmail.com>
 <169226510772.947223.494995318945916008.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <169226510772.947223.494995318945916008.b4-ty@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Aug 2023, Lee Jones wrote:

> On Mon, 15 May 2023 22:57:15 +0200, Jakob Hauser wrote:
> > Implement cable detection by extcon and handle the driver according to the
> > connector type.
> > 
> > There are basically three types of action: "set_charging", "set_otg" and
> > "set_disconnect".
> > 
> > A forth helper function to "unset_otg" was added because this is used in both
> > "set_charging" and "set_disconnect". In the first case it covers the rather
> > rare event that someone changes from OTG to charging without disconnect. In
> > the second case, when disconnecting, the values are set back to the ones from
> > initialization to return into a defined state.
> > 
> > [...]
> 
> Applied, thanks!
> 
> [06/10] power: supply: rt5033_charger: Add cable detection and USB OTG supply
>         commit: c1af6bcc8583b0a1083338cd26c2090d0bcb0810

Multiple fixes now follow this patch, so I am unapplying it.

Sebastian, would you mind collecting it up please?

-- 
Lee Jones [李琼斯]
