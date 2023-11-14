Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 442457EADEC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 11:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbjKNKY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 05:24:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKNKYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 05:24:25 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA8DA4;
        Tue, 14 Nov 2023 02:24:20 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1A9C6E0005;
        Tue, 14 Nov 2023 10:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699957459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=11+SRT2Yqvxj1MFVo31Y03QxSQnCCjvkU5YB6iZYBtI=;
        b=E8dMz5UuD2lj0LLQYeJJpLEDkpZmuzM2FQUWE+hYssTXZDC1e5dfN9TD/pLdxgsD6vfjwk
        uaJ+hbrKRFasxa9KH2o2tCI3f9O4hKmoGrj1S5VZbOGrmq3JZ4na2WWBvgKYFFvPp6QkJ4
        Vq3Tk9VYJ6pMfb8cGbhkCxGusGR1LJl1A7jgvCmbCAxm0qBOI3wbnINJP54MCdl+V7FeLz
        JEb5Viy2Fovl1nqQwubXYcLbE1SESMwCK5rPrcwO5WgdZC/0PTcwJ0pKk8QxEq1AodP00J
        sF4axrpwFRsFx8dRkOz/0mEWXFINY0FwvDkcCh2/SXA/NYm8atmmRGnqLCbBMg==
Date:   Tue, 14 Nov 2023 11:24:10 +0100
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Romain Gantois <romain.gantois@bootlin.com>
Cc:     davem@davemloft.net, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Robert Marko <robert.marko@sartura.hr>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH net-next v2 3/8] net: qualcomm: ipqess: introduce the
 Qualcomm IPQESS driver
Message-ID: <20231114112410.61e25aa7@windsurf>
In-Reply-To: <20231114090743.865453-4-romain.gantois@bootlin.com>
References: <20231114090743.865453-1-romain.gantois@bootlin.com>
        <20231114090743.865453-4-romain.gantois@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: thomas.petazzoni@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, 14 Nov 2023 10:07:29 +0100
Romain Gantois <romain.gantois@bootlin.com> wrote:

> The Qualcomm IPQ4019 Ethernet Switch Subsystem for the IPQ4019 chip
> includes an internal Ethernet switch based on the QCA8K IP.
> 
> The CPU-to-switch port data plane depends on the IPQESS EDMA Controller,
> a simple 1G Ethernet controller. It is connected to the switch through an
> internal link, and doesn't expose directly any external interface.
> 
> The EDMA controller has 16 RX and TX queues, with a very basic RSS fanout
> configured at init time.
> 
> Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
> ---
>  MAINTAINERS                                   |    7 +
>  drivers/net/dsa/qca/qca8k-common.c            |  119 +-

I don't think the changes to this file should be in this patch, they
should most likely be in PATCH 2/8. Could you double check this?

>  include/linux/dsa/qca8k.h                     |   47 +-

Ditto.

Thomas
-- 
Thomas Petazzoni, co-owner and CEO, Bootlin
Embedded Linux and Kernel engineering and training
https://bootlin.com
