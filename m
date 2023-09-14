Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EECB7A0036
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 11:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237117AbjINJgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 05:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237303AbjINJgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 05:36:22 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2773F83;
        Thu, 14 Sep 2023 02:36:17 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 96DEDE0007;
        Thu, 14 Sep 2023 09:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1694684176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5xP+NjQDRwSpB94Yxwb2tOKLdwEhsOpJuGakBvtmxKI=;
        b=JNki3l03CjDlfeHtZf/4+WZHsKLcV1ghiFS6a7ZOiltadCBlIwhxQ7ul1zXNdXZ0dPwqB/
        nzHR2+C8Az/HQUsVJdhthOgIJ1jR39eA89K77TZ/bo9tfYxYdt67onhi2li5kJyq1MxPTA
        i7+zR6lJD2DjPuZlmQt57jeQi6YpbNw7RYnhbD3889nsClROv5OuRHYgFnWj7yn329qQ9C
        N/ZwQmdoayt13OzIVmHD3DE5pRFHt0qa7iCh6HBz64Lg5RIusodyZSa3qrXhaH+S3AXiUv
        xicm/pm9st7Ve/+cLwdQHVW5rIVVTfOX/KqbZNhYxZYaLym3hWBiZ12vJvrtRw==
Date:   Thu, 14 Sep 2023 11:36:13 +0200
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        =?UTF-8?B?Tmljb2zDsg==?= Veronese <nicveronese@gmail.com>,
        thomas.petazzoni@bootlin.com,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [RFC PATCH net-next 6/7] net: ethtool: add a netlink command to
 get PHY information
Message-ID: <20230914113613.54fe125c@fedora>
In-Reply-To: <20230908084606.5707e1b1@kernel.org>
References: <20230907092407.647139-1-maxime.chevallier@bootlin.com>
        <20230907092407.647139-7-maxime.chevallier@bootlin.com>
        <20230908084606.5707e1b1@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jakub,

On Fri, 8 Sep 2023 08:46:06 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Thu,  7 Sep 2023 11:24:04 +0200 Maxime Chevallier wrote:
> >  	ETHTOOL_MSG_PHY_LIST_GET,
> > +	ETHTOOL_MSG_PHY_GET,  
> 
> The distinction between LIST_GET and GET is a bit odd for netlink.
> GET has a do and a dump. The dump is effectively LIST_GET.
> 
> The dump can accept filtering arguments, like ifindex, if you want 
> to narrow down the results, that's perfectly fine (you may need to
> give up some of the built-in ethtool scaffolding, but it shouldn't 
> be all that bad).

I'm currently implementing this, and I was wondering if it could be
worth it to include a pointer to struct phy_device directly in
ethnl_req_info.

This would share the logic for all netlink commands that target a
phy_device :

 - plca
 - pse-pd
 - cabletest
 - other future commands

Do you see this as acceptable ? we would grab the phy_device that
matches the passed phy_index in the request, and if none is specified,
we default to dev->phydev.

Thanks,

Maxime
