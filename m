Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876727E2F09
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 22:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233174AbjKFVgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 16:36:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233129AbjKFVgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 16:36:44 -0500
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFCE0B0;
        Mon,  6 Nov 2023 13:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
        :Date:subject:date:message-id:reply-to;
        bh=7ov3LPWt5cacqUWxywHiXwMNsMacdsSxOeWnnH7Tztg=; b=xWMUkpS3+Dlfxt1MQtFgL3V7y6
        uAr3XoRKR/dt3AeONNvpkwKyldbFYHiBe8NR4C2D0eB5xYElkhti1hHI4n63yxsa1nwySa8xFxQh+
        N9vNIPz1Uxr15Pip85rSeK04n01cqSaafXx4QK59m3vrnHpTUph0ujjUERg2JV/MeByc=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:34416 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1r07Gr-0002ME-K6; Mon, 06 Nov 2023 16:36:34 -0500
Date:   Mon, 6 Nov 2023 16:36:33 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Message-Id: <20231106163633.764707a8140dfe750f875dc3@hugovil.com>
In-Reply-To: <e4884c86-0b8c-4e73-9280-296be98d57b1@linaro.org>
References: <20231106185736.668966-1-hugo@hugovil.com>
        <e4884c86-0b8c-4e73-9280-296be98d57b1@linaro.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH] arm64: dts: imx8mn-var-som-symphony: add vcc supply for
 PCA9534
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Nov 2023 21:39:42 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 06/11/2023 19:57, Hugo Villeneuve wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > The following warning is shown when probing device:
> > 
> >     pca953x 1-0020: supply vcc not found, using dummy regulator
> > 
> > Add fixed 3.3v regulator as vcc supply to silence the warning.
> > 
> 
> This is not really a warning. It's perfectly fine to use dummy
> regulator. Adding such fixed supply has sense in following cases:
> 1. Bindings require the supply,
> 2. This is in fact exactly that supply (verified on schematics).
> 
> Best regards,
> Krzysztof

Hi Krzysztof,
this is case #2, but looking more closely at the carrier board
(symphony) schematics, it is not exactly the "reg_3v3_fixed" supply I
mentioned in the patch, as "reg_3v3_fixed" is located on the SOM and
only powers SOM components.

However, "reg_3v3_fixed", which is an always-on regulator (no software
enable control), is used as the enable input to a mosfet switch (Q2) on
the carrier board to generate the 3.3V (label BASE_PER_3V3 on the
schematics) used by all peripherals on that carrier board.

I guess I could then define a new "always-on" regulator labeled as,
for example, base_per_3v3, and then assign the pca953x vcc-supply
property to it?

Hugo.
