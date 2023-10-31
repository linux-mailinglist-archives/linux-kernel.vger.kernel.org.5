Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C227DC3BF
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 02:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjJaBAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 21:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjJaBAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 21:00:16 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27AB2C1;
        Mon, 30 Oct 2023 18:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=dQjReZhnkb4AP5DzfEzONPc2UVwhei3iUP21q72heac=; b=MvQr4gRtP5TUQzFcesFdjRrYme
        5SXVO0QJTaYOP+EGzcQcN2ctQLXVp6Ppzk7tt8Zu7kE70nqeeKNu3DKtWXDCtEMVk4gQSpxPcpb49
        Id365M9q0gSIlDJDxDrF2Cbq6lqo91fLnN0adXfK6zF7kVXekX0xMz9zeE8DKApQ6l8Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qxd6z-000Zkf-Ik; Tue, 31 Oct 2023 02:00:05 +0100
Date:   Tue, 31 Oct 2023 02:00:05 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Ante Knezic <ante.knezic@helmholz.de>, conor+dt@kernel.org,
        o.rempel@pengutronix.de, UNGLinuxDriver@microchip.com,
        davem@davemloft.net, devicetree@vger.kernel.org,
        edumazet@google.com, f.fainelli@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, marex@denx.de,
        netdev@vger.kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
        woojung.huh@microchip.com
Subject: Re: [PATCH net-next v4 2/2] net:dsa:microchip: add property to select
Message-ID: <aad5ac41-3c05-421d-a483-0546b579585c@lunn.ch>
References: <20231024142426.GE3803936@pengutronix.de>
 <20231027063743.28747-1-ante.knezic@helmholz.de>
 <20231030174225.hqhc3afbayi7dmos@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030174225.hqhc3afbayi7dmos@skbuf>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> So, my opinion is that although what Oleksij would like to see is
> admirable, I don't think that the REF_CLK direction is a matter of RMII
> MAC vs PHY role, and thus, we wouldn't need to change "rmii" to "rev-rmii"
> and cause breakage everywhere. It's just that - a matter of REF_CLK
> direction. It's true, though, that this is a generic problem and that
> the generic bindings for RMII that we currently have are under-specified.
> We could try to devise an extended RMII binding which makes it clear for
> both the MAC and the PHY who is responsible to drive this signal. You
> are not attempting that, you are just coming up with yet another
> vendor-specific MAC property which solves a generic problem. I can't say
> I am completely opposed to that, either, which is why I haven't really
> spoken out against it. The PHY maintainers would also have to weigh in,
> and not all of them are CCed here.

I would recommend looking around other PHYs and find a property which
does what you want, and copy it.

We do have all sorts of properties. There are some to enable the
REF_CLK out of the PHY. Some to disable the REF_CLK out, some to
disable it when the link is down, some to indicate what frequency it
should tick at, etc.

If you want to go the extra mile, maybe you can make a summary of all
these properties, and maybe we can produce a guide line for what we
want the properties to be called going forward.

> I am afraid that creating a CCF style binding for REF_CLK will be an
> enormous hammer for a very small nail and will see very limited adoption
> to other drivers, but I might as well be wrong about it. Compatibility
> between RMII MACs and PHYs which may or may not be CCF-ready might also
> be a concern.

I also don't think using the CCF makes too much sense, except for
where the SoC provides the lock, and already has a CCF covering it.

I would also be hesitant to add more dependencies between the MAC and
the PHY. The DT often has circular dependencies and we have had issues
with probing being deferred because the core does not always
understand these circular dependencies.

	   Andrew
