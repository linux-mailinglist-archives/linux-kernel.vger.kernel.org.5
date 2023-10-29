Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA117DAED8
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 23:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjJ2Wuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 18:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjJ2Wuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 18:50:52 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE82C5;
        Sun, 29 Oct 2023 15:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=mItQr9Lnr2C07koQ7ptJcY2nYrj1Tv7N3viIjaS79mo=; b=O4z6s+bSQrfPzDDmeay9WJaB3d
        6DyWIwTIhL7JZOJeso/nzNcfcqgwCRchXJOb28e+/nsHaW9AG4w2iw0aYs/b//6B7COSqtYePpmZE
        ejpmJpVx3mLK0a39nksWbIFKIj6n6mS3qFBR1PKPntGjDw4R8tVaHA3jZWq87tDvjXtE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qxEbw-000T7f-KV; Sun, 29 Oct 2023 23:50:24 +0100
Date:   Sun, 29 Oct 2023 23:50:24 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Samin Guo <samin.guo@starfivetech.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v2 11/12] riscv: dts: starfive: visionfive-v1: Enable
 gmac and setup phy
Message-ID: <e837e707-5b01-4b7b-8362-0dc62883fdba@lunn.ch>
References: <20231029042712.520010-1-cristian.ciocaltea@collabora.com>
 <20231029042712.520010-12-cristian.ciocaltea@collabora.com>
 <f379a507-c3c1-4872-9e4f-f521b86f44d4@lunn.ch>
 <f05839c0-7a78-4616-bedc-6a876b7f4bb3@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f05839c0-7a78-4616-bedc-6a876b7f4bb3@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 12:41:23AM +0200, Cristian Ciocaltea wrote:
> On 10/29/23 20:45, Andrew Lunn wrote:
> > On Sun, Oct 29, 2023 at 06:27:11AM +0200, Cristian Ciocaltea wrote:
> >> The StarFive VisionFive V1 SBC has a Motorcomm YT8521 PHY supporting
> >> RGMII-ID, but requires manual adjustment of the RX internal delay to
> >> work properly.
> >>
> >> The default RX delay provided by the driver is 1.95 ns, which proves to
> >> be too high. Applying a 50% reduction seems to mitigate the issue.
> > 
> > I'm not so happy this cannot be explained. You are potentially heading
> > into horrible backwards compatibility problems with old DT blobs and
> > new kernels once this is explained and fixed.
> 
> It seems the visionfive-v2 board also required setting some delays, but
> unfortunately no details were provided:
> 
> 0104340a67b1 ("riscv: dts: starfive: visionfive 2: Add configuration of
> mac and phy")

That board also uses a YT8531 PHY. Its possible this is somehow to do
with the PHY. Which is why testing with the Microchip PHY is
important. That should answer the question is it a SoC or a PHY
problem.

	Andrew
