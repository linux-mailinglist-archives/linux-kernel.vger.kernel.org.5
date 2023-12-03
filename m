Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E852802639
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 19:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbjLCS14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 13:27:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCS1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 13:27:55 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916D0DA;
        Sun,  3 Dec 2023 10:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=aUsCV91m+ELnDOdxn1WVTWBKESnXzZXP6DrkbKRjeQU=; b=QeeGOpDx7ryX2s5ZuB47X2qVPF
        DMPV8+OekwGPChpfgiR/z6+9HoIsyslc6j3DBIRaqSg+88VFF7vU0Ox/Qx2P8WhFhiXsR59DB+0ia
        EcbjN9TOMwXt1oaDpHP73VbLUzB0YqGH37OuLtE015WinkvtOf5NNMUJzsxxNMWHPqeU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1r9rC0-001uMK-Gg; Sun, 03 Dec 2023 19:27:48 +0100
Date:   Sun, 3 Dec 2023 19:27:48 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Kory Maincent <kory.maincent@bootlin.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russ.weight@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
        Dent Project <dentproject@linuxfoundation.org>
Subject: Re: [PATCH net-next v2 2/8] ethtool: Expand Ethernet Power Equipment
 with c33 (PoE) alongside PoDL
Message-ID: <44c873f6-66fa-48bb-bc51-9ef20a772cea@lunn.ch>
References: <20231201-feature_poe-v2-0-56d8cac607fa@bootlin.com>
 <20231201-feature_poe-v2-2-56d8cac607fa@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201-feature_poe-v2-2-56d8cac607fa@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +++ b/Documentation/networking/pse-pd/introduction.rst
> @@ -0,0 +1,73 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +Power Sourcing Equipment (PSE) in IEEE 802.3 Standard
> +=====================================================
> +
> +Overview
> +--------
> +
> +Power Sourcing Equipment (PSE) is essential in networks for delivering power
> +along with data over Ethernet cables. It usually refers to devices like
> +switches and hubs that supply power to Powered Devices (PDs) such as IP
> +cameras, VoIP phones, and wireless access points.
> +
> +PSE vs. PoDL PSE
> +----------------
> +
> +PSE in the IEEE 802.3 standard generally refers to equipment that provides
> +power alongside data over Ethernet cables, typically associated with Power over
> +Ethernet (PoE).
> +
> +PoDL PSE, or Power over Data Lines PSE, specifically denotes PSEs operating
> +with single balanced twisted-pair PHYs, as per Clause 104 of IEEE 802.3. PoDL
> +is significant in contexts like automotive and industrial controls where power
> +and data delivery over a single pair is advantageous.
> +
> +IEEE 802.3-2018 Addendums and Related Clauses
> +----------------------------------------------
> +
> +Key addenda to the IEEE 802.3-2018 standard relevant to power delivery over
> +Ethernet are as follows:
> +
> +- **802.3af (Approved in 2003-06-12)**: Known as PoE in the market, detailed in
> +  Clause 33, delivering up to 15.4W of power.
> +- **802.3at (Approved in 2009-09-11)**: Marketed as PoE+, enhancing PoE as
> +  covered in Clause 33, increasing power delivery to up to 30W.
> +- **802.3bt (Approved in 2018-09-27)**: Known as 4PPoE in the market, outlined
> +  in Clause 33. Type 3 delivers up to 60W, and Type 4 up to 100W.
> +- **802.3bu (Approved in 2016-12-07)**: Formerly referred to as PoDL, detailed
> +  in Clause 104. Introduces Classes 0 - 9. Class 9 PoDL PSE delivers up to ~65W
> +
> +Kernel Naming Convention Recommendations
> +----------------------------------------
> +
> +For clarity and consistency within the Linux kernel's networking subsystem, the
> +following naming conventions are recommended:
> +
> +- For general PSE (PoE) code, use "c33_pse" key words. For example:
> +  ``enum ethtool_c33_pse_admin_state c33_admin_control;``.
> +  This aligns with Clause 33, encompassing various PoE forms.
> +
> +- For PoDL PSE - specific code, use "podl_pse". For example:
> +  ``enum ethtool_podl_pse_admin_state podl_admin_control;`` to differentiate
> +  PoDL PSE settings according to Clause 104.
> +
> +Summary of Clause 33: Data Terminal Equipment (DTE) Power via Media Dependent Interface (MDI)
> +-------------------------------------------------------------------------------------------
> +
> +Clause 33 of the IEEE 802.3 standard defines the functional and electrical
> +characteristics of Powered Device (PD) and Power Sourcing Equipment (PSE).
> +These entities enable power delivery using the same generic cabling as for data
> +transmission, integrating power with data communication for devices such as
> +10BASE-T, 100BASE-TX, or 1000BASE-T.
> +
> +Summary of Clause 104: Power over Data Lines (PoDL) of Single Balanced Twisted-Pair Ethernet
> +-------------------------------------------------------------------------------------------
> +
> +Clause 104 of the IEEE 802.3 standard delineates the functional and electrical
> +characteristics of PoDL Powered Devices (PDs) and PoDL Power Sourcing Equipment
> +(PSEs). These are designed for use with single balanced twisted-pair Ethernet
> +Physical Layers. In this clause, 'PSE' refers specifically to PoDL PSE, and
> +'PD' to PoDL PD. The key intent is to provide devices with a unified interface
> +for both data and the power required to process this data over a single
> +balanced twisted-pair Ethernet connection.

This is a nice summary of the different standard and naming. Thanks
for adding this.

The c33 prefix is not ideal in terms of 'marketing', but we now have a
clear structure for how these two different schemes are
same/different.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
