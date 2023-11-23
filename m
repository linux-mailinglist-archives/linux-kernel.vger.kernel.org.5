Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0177F60A4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 14:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345586AbjKWNok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 08:44:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345539AbjKWNoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 08:44:38 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7991A8;
        Thu, 23 Nov 2023 05:44:44 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 74C05FF809;
        Thu, 23 Nov 2023 13:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700747083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0SVq2leikZhcuCjNPEWn24EXcg6OrcejWDGU6KH+wxM=;
        b=mvaQaAVeQHUqaxhEpF9xDBXjfaTza5gX4dMJ4I+oveEwmyblCHlO+NLkLLgUkGqO1/nABi
        V7vmvqknl5evqx2MOFldGWYujGyXGsdIvEzCegf447ii9fp7S3RoXdz1ok0gaQGOslqNci
        cCFqr7l1UMvWF4rN/mgyg0S7FLbjEx1afEmEEH6HB3DdXgBcpM6Ws+JVK7bfoATzkBNWdM
        /dA9wIJtkgrA0Icm2nuCzuZS8cvvZ+a2lDo7XLnutYpeYkA2Lf8LhAsu8WX9qDyGC2tgBt
        bD9pwJj+SoYUcjmNZxDG6CpEdUIjbta9IDrsYXTG0trxq+wx7gvZ9W1KW/duYw==
Date:   Thu, 23 Nov 2023 14:44:41 +0100
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Herve Codina <herve.codina@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: Re: [RFC PATCH net-next v2 01/10] net: phy: Introduce ethernet link
 topology representation
Message-ID: <20231123144441.3d73bf51@device.home>
In-Reply-To: <9079c9f5-5531-4c38-b9c9-975ed3d96104@lunn.ch>
References: <20231117162323.626979-1-maxime.chevallier@bootlin.com>
        <20231117162323.626979-2-maxime.chevallier@bootlin.com>
        <9079c9f5-5531-4c38-b9c9-975ed3d96104@lunn.ch>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2023 01:24:47 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

[...]
> 
> > diff --git a/include/linux/link_topology.h b/include/linux/link_topology.h  
> 
> I think this filename is too generic. Maybe phy_link_topology.h, or
> move it into include/net.

Yeah naming again, phy_link_topology would make sense indeed. I know
that Florian suggested phy_devices_list last time, However I'd like
this to be more than just about PHYs, to keep track of ports, mii-muxes
and such. So, phy_link_topology sounds good to me :)

Maxime
