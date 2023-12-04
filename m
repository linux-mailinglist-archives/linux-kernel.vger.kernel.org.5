Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5DD8038D3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 16:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234548AbjLDP3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 10:29:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234215AbjLDP3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 10:29:32 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1A8F0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 07:29:39 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1rAAsl-0007Qm-Ar; Mon, 04 Dec 2023 16:29:15 +0100
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1rAAsi-00DY6m-Q3; Mon, 04 Dec 2023 16:29:12 +0100
Received: from ore by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1rAAsi-005FbI-Mx; Mon, 04 Dec 2023 16:29:12 +0100
Date:   Mon, 4 Dec 2023 16:29:12 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Kory Maincent <kory.maincent@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
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
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
        Dent Project <dentproject@linuxfoundation.org>
Subject: Re: [PATCH net-next v2 4/8] net: ethtool: pse-pd: Expand pse
 commands with the PSE PoE interface
Message-ID: <20231204152912.GF981228@pengutronix.de>
References: <20231201-feature_poe-v2-0-56d8cac607fa@bootlin.com>
 <20231201-feature_poe-v2-4-56d8cac607fa@bootlin.com>
 <e0b143dc-ca7e-4762-bd0b-3acffad0932b@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e0b143dc-ca7e-4762-bd0b-3acffad0932b@lunn.ch>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 03, 2023 at 07:45:18PM +0100, Andrew Lunn wrote:
> > @@ -143,6 +150,43 @@ ethnl_set_pse(struct ethnl_req_info *req_info, struct genl_info *info)
> >  		return -EOPNOTSUPP;
> >  	}
> >  
> > +	if (!tb[ETHTOOL_A_PODL_PSE_ADMIN_CONTROL] &&
> > +	    !tb[ETHTOOL_A_C33_PSE_ADMIN_CONTROL])
> > +		return 0;
> 
> -EINVAL? Is there a real use case for not passing either of them?
> 
> > +
> > +	if (tb[ETHTOOL_A_PODL_PSE_ADMIN_CONTROL] &&
> > +	    !(pse_get_types(phydev->psec) & PSE_PODL)) {
> > +		NL_SET_ERR_MSG_ATTR(info->extack,
> > +				    tb[ETHTOOL_A_PODL_PSE_ADMIN_CONTROL],
> > +				    "setting PSE PoDL admin control not supported");
> > +		return -EOPNOTSUPP;
> > +	}
> > +	if (tb[ETHTOOL_A_C33_PSE_ADMIN_CONTROL] &&
> > +	    !(pse_get_types(phydev->psec) & PSE_C33)) {
> > +		NL_SET_ERR_MSG_ATTR(info->extack,
> > +				    tb[ETHTOOL_A_C33_PSE_ADMIN_CONTROL],
> > +				    "setting PSE PoE admin control not supported");
> 
> This probably should be C33, not PoE?
> 
> I guess it depends on what the user space tools are using. 

The same problem is in the documentation. Mixing different naming
schemes is problematic. Even unmixed this "PoE" is not really suitable for most
use cases. Expanding this abbreviations make it probably more clear:
- PSE PoE - Power Source Equipment Power over Ethernet
- C33 PSE - Clause 33 Power Source Equipment

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
