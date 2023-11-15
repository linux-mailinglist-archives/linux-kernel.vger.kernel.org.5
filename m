Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95C1E7ECA47
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 19:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjKOSLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 13:11:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjKOSLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 13:11:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AED0189
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 10:11:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8C6DC433C8;
        Wed, 15 Nov 2023 18:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700071869;
        bh=SKHJUnjpmtws/NFQEUU8h0axwxdCJ+qDn5qwpISmjaE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B3tI/qlm/C+qfBnlLtg6SZPP5DLP4rSGWgurWELIrMiG19l7q++pccC9aWKHgj8cS
         Hdfyy4MNLvo0XObCme76nhVjlJI4vE2KKy/ayieP2kyOUEDyB/W/NibM+FcqRqAeMO
         HdfiWKJbbNwJsPVlUN+P3kA8s/VKjWAdEi69F43a+7ILUC3KvH8FdLwixJYVzqnRH9
         RSTNQrMDaXIkLjwAY7JMUVvkbJXIU7XDbdfus7fgw2FKeo7KmWaSGk3UqBIsr5dO46
         LtlXDsb/K+FtJ/uvoYy4OEhpEQm8FVvTbVnGM6TzuE6HU9v6KmctbFqU3OOTX1qbCV
         d31m/mDaf/QmA==
Date:   Wed, 15 Nov 2023 18:11:03 +0000
From:   Simon Horman <horms@kernel.org>
To:     Romain Gantois <romain.gantois@bootlin.com>
Cc:     davem@davemloft.net, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>,
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
Subject: Re: [PATCH net-next v3 3/8] net: qualcomm: ipqess: introduce the
 Qualcomm IPQESS driver
Message-ID: <20231115181103.GX74656@kernel.org>
References: <20231114105600.1012056-1-romain.gantois@bootlin.com>
 <20231114105600.1012056-4-romain.gantois@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114105600.1012056-4-romain.gantois@bootlin.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2023 at 11:55:53AM +0100, Romain Gantois wrote:
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

Hi Romain,

some minor feedback from my side.

> diff --git a/drivers/net/ethernet/qualcomm/ipqess/ipqess_switch.c b/drivers/net/ethernet/qualcomm/ipqess/ipqess_switch.c

...

> +static int ipqess_switch_probe(struct platform_device *pdev)
> +{

...

> +	for_each_available_child_of_node(ports, port_np) {
> +		ret = ipqess_port_register(sw, port_np);
> +		if (ret) {
> +			pr_err("Failed to register ipqess port! error %d\n", ret);

Coccinelle warns that a call to of_node_put() is needed here.

> +			goto out_ports;
> +		}
> +	}

...

> +static int
> +ipqess_switch_remove(struct platform_device *pdev)
> +{
> +	struct ipqess_switch *sw = platform_get_drvdata(pdev);
> +	struct qca8k_priv *priv = sw->priv;

Here sw is dereferenced...

> +	struct ipqess_port *port = NULL;
> +	int i;
> +
> +	if (!sw)
> +		return 0;

... but here the code guards against sw being NULL.
This seems inconsistent.

As flagged by Smatch.

...
