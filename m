Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67F580EEE5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 15:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376835AbjLLOfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 09:35:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376824AbjLLOfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 09:35:10 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14711D2;
        Tue, 12 Dec 2023 06:35:15 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 671FA40002;
        Tue, 12 Dec 2023 14:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1702391714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GBWTn8LXNbd78TZRhT4dRoIz0TuUjj3QIG9fJVpBvLQ=;
        b=MyvQn4BcB78oeufQV//qG/iisqZ/a2BIX2ud8BCiSvDCB2Ur0EiMEc2r7w77Ey1f/9iUHx
        YiZjcUMMRzbK9mEs/ATZi1Qa4IWoCOhZYXTUrtKEOWfcQ6vc69A/rxuYm0RTiqssOdTX3b
        rhjn/VC62FSfyRbhBT7Q08Xh4yd96Qvw+zjWmsGKiiHErJrHN5QiGeHQW6hFAonCJUK8qw
        J0hnCZosfWP3JlwtUE1GrLTxm+GnpnQhreZqM5tYP5KXFidFsaqi88aKvfwXfgxpPfCd3j
        P5jW/fltdTN8oKhB4VuzsSyQEQ8q4sn7HbAjFFrsdZEhUa7BJypfQvxNVVATKQ==
Date:   Tue, 12 Dec 2023 15:35:12 +0100
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phy: skip LED triggers on PHYs on SFP modules
Message-ID: <20231212153512.67a7a35b@device.home>
In-Reply-To: <102a9dce38bdf00215735d04cd4704458273ad9c.1702339354.git.daniel@makrotopia.org>
References: <102a9dce38bdf00215735d04cd4704458273ad9c.1702339354.git.daniel@makrotopia.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel

On Tue, 12 Dec 2023 00:05:35 +0000
Daniel Golle <daniel@makrotopia.org> wrote:

> Calling led_trigger_register() when attaching a PHY located on an SFP
> module potentially (and practically) leads into a deadlock.
> Fix this by not calling led_trigger_register() for PHYs localted on SFP
> modules as such modules actually never got any LEDs.

While I don't have a fix for this issue, I think your justification
isn't good. This isn't about having LEDs on the module or not, but
rather the PHY triggering LED events for LEDS that can be located
somewhere else on the system (like the front pannel of a switch).

So I think it would be wiser to avoid the deadlock with a proper
analysis of what the locking scheme does. Maybe Andrew or Russell
have a better vision of what's going-on here, I tried to dive into
it but it doesn't look straightfoward to me :(

Maxime

