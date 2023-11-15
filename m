Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 227A67EC84D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 17:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjKOQRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 11:17:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjKOQRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 11:17:31 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F7811D;
        Wed, 15 Nov 2023 08:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=wYfs7wiI1xmxaxDt3krpKsC1uJFC6LeNKDzF3hoksPw=; b=RJBerz5CQ0fEajYRmbbpglaxJ7
        NmW7K6ERfzEOx6QoSvrQNuwlb6sCvSxKt4ydd+16TZikAmibK8JzqbmKTUHq/xN/U8lV2VOfCtHHr
        CHFwtxMZzma/4sjfvcuMux1krXshcK0A4SNWlrWH5f5dLMLDBJYSsFqKABbaKv3bKORM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1r3IZq-000GJt-QX; Wed, 15 Nov 2023 17:17:18 +0100
Date:   Wed, 15 Nov 2023 17:17:18 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Luo Jie <quic_luoj@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        hkallweit1@gmail.com, linux@armlinux.org.uk,
        robert.marko@sartura.hr, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com
Subject: Re: [PATCH 7/9] net: mdio: ipq4019: program phy address when "fixup"
 defined
Message-ID: <2cf175d7-d96b-4f51-9dd7-2ce8229ca212@lunn.ch>
References: <20231115032515.4249-1-quic_luoj@quicinc.com>
 <20231115032515.4249-8-quic_luoj@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115032515.4249-8-quic_luoj@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 11:25:13AM +0800, Luo Jie wrote:
> The PHY/PCS MDIO address can be programed when the property
> "fixup" of phy node is defined.
> 
> The qca8084 PHY/PCS address configuration register is accessed
> by MDIO bus with the special MDIO sequence.
> 
> The PHY address configuration register of IPQ5018 is accessed
> by local bus.
> 
> Add the function ipq_mdio_preinit, which should be called before
> the PHY device scanned and registered.

I'm not convinced this belongs in the MDIO bus driver. Its really a
PHY property, so i think all this should be in the PHY driver. If you
specify the PHY ID in the compatible string, you can get the driver
loaded and the probe function called. You can then set the PHY
address.

	Andrew
