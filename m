Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 189A8774C84
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 23:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbjHHVKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 17:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235936AbjHHVKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 17:10:22 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC368936;
        Tue,  8 Aug 2023 13:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=kugZc95gGx+gT4+czXKHKOoAY3GLr6Xku/WMAGPw3Fk=; b=qksDPq++8sAH+kPljwpqHKKOfm
        8hVaowMT091tsZwRUs4vx+9cnNbDYHgiiq4thEEL8FkfsLgyjM9X62rP7qMiFV+UQ7dEKsU30VZi7
        XkcdSzHRaOQRdNodZ54QDgC89ldeNENuoFT4DZgYQZnd3nobOcDPxpkrwkNLbPPWUzHU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qTTj5-003WBH-1N; Tue, 08 Aug 2023 22:54:47 +0200
Date:   Tue, 8 Aug 2023 22:54:47 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     "Hawkins, Nick" <nick.hawkins@hpe.com>
Cc:     "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "simon.horman@corigine.com" <simon.horman@corigine.com>,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/5] net: hpe: Add GXP UMAC Driver
Message-ID: <06d1bc6a-0584-4d62-a2f4-61a42f236b3c@lunn.ch>
References: <20230802201824.3683-1-nick.hawkins@hpe.com>
 <20230802201824.3683-5-nick.hawkins@hpe.com>
 <fb656c31-ecc3-408a-a719-cba65a6aa984@lunn.ch>
 <933D6861-A193-4145-9533-A7EE8E6DD32F@hpe.com>
 <61c541c9-be30-4a43-aa85-53816d5848f9@lunn.ch>
 <DB60B268-85DA-43A2-A20F-52D684473348@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB60B268-85DA-43A2-A20F-52D684473348@hpe.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 08:39:39PM +0000, Hawkins, Nick wrote:
> Hi Andrew,
> 
> Thank you for your feedback, I have several follow up questions:
> 
> > So what you call a PHY is probably a PCS. Please look at the API used
> > in driver/net/pcs/. The real PHYs are external.
> 
> I doubled checked the internal PHY is considered a PHY, but I believe
> I can represent it as a PCS.

Is there proper documentation somewhere? register set? Is there
registers to kick off Base1000X/SGMII auto-neg? Somewhere to get the
results of the auto-neg? Since this is Base1000X/SGMII you want to
know if the link between it and the external PHY has established. And
if there is not an external PHY, but an SFP, this auto neg is with the
link peer, not the PHY. If it follows 802.3 clause 37, there should
already be a lot of helper code for you. Is this is licensed core?

> To confirm: I believe you are suggesting that
> we create a driver here for the handling of the internal PHY but not the
> external PHY?

The patches seem to suggest your board has an external Marvell PHY. So
i would expect it to use drivers/net/phy/marvell.c. Other boards,
using other PHYs, would use other PHY drivers.

> If so would it be leveraging the MDIO driver already created in this
> patchset? Or perhaps would it be replacing it for the internal PHY?

Many of the PCS drivers in driver/net/pcs are MDIO devices, so yes, it
would be layered on top of it.

      Andrew
