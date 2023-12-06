Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECCD480737B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 16:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442522AbjLFPOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 10:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379249AbjLFPOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 10:14:04 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8490D62;
        Wed,  6 Dec 2023 07:14:10 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-a1a496a73ceso123330666b.2;
        Wed, 06 Dec 2023 07:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701875649; x=1702480449; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a83R07oS+INQ3myN3O4+icnOpm8uIwZadLNuNVFfdVM=;
        b=Ij4BOyWwrl7sh40mewst8pwpP5fwmlo7tBgE2Wxv1yIqMDfDD2YPvjYFOdYAFdgsTb
         h23OrX/NpHaYSverZ9Xu5JJoIjfB/HXVqaSyJOXTrPoY9hqqRydDU/igYqOJajg7rNJ/
         ErvkGs3A9a6TAS8Wz8AnojsKP1V7kxt/kyzLfog5Bh11TCJG6K60dqfJ69ROKLFV1yBt
         ljUB9RhXBq6oRz7qYa2JVzZX21Ltgc23XhZ3jgXB7YVPVRPyz258etN7D2RiENBdU3cO
         QhkAbG+cNxFIpM56BA/C1R2TtrQe7ulvIC5QJsfWnZyZ4F/0eUHXF+YZdMPUQxzJm0WE
         z4rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701875649; x=1702480449;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a83R07oS+INQ3myN3O4+icnOpm8uIwZadLNuNVFfdVM=;
        b=V4UKzA0mUUkD6VVlXwbXQIQrclBsmvGfoTagLgEl7JoCRawjaQA23mhqyBaHpPMCf+
         TIU1QBVW37WtvvV94hlMs1ZM+L+10/Q/MlaD38yXRXXebnLPHj8NXZYh+L1EgUWaf+Lo
         3yRLyrbR/HFlpOGDGdgmAdRF2wFzOpl3aSHROh+Z5JyV62kW7yFmqw8CW9RHgWkNA8Pi
         JHxGuJS4/+KFmVtV2TXxx5FDXGS4/ZuFBFAuiSSopVghEZsrqfaM5CHJKdfqLJYBIbFm
         PyKLSK32ByZv5W7O/JiWvK9fCIMT3z8fOjn9l0cwx49MvUxwOrBn6qNhBLRzknLMLPvy
         CRpQ==
X-Gm-Message-State: AOJu0YyPb235Tfbd/h6Ty8hW+tZdQxinJ4rv139tLeC2YbUweKiZEWtv
        8owLgCy84ftCEozcNFQypt4=
X-Google-Smtp-Source: AGHT+IGz9bNU02Gx1n56NJmqtRZSx7SY4N5m/lQPWBpwNuTo7J4Xxd5pzbHVc4j1AVcwi3FLtt0O6Q==
X-Received: by 2002:a17:906:97:b0:a19:a19b:78d6 with SMTP id 23-20020a170906009700b00a19a19b78d6mr728296ejc.153.1701875648876;
        Wed, 06 Dec 2023 07:14:08 -0800 (PST)
Received: from skbuf ([188.27.185.68])
        by smtp.gmail.com with ESMTPSA id bl17-20020a170906c25100b00a1ce98016b6sm43962ejb.97.2023.12.06.07.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 07:14:08 -0800 (PST)
Date:   Wed, 6 Dec 2023 17:14:06 +0200
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Woojung Huh <woojung.huh@microchip.com>,
        Arun Ramadoss <arun.ramadoss@microchip.com>,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next v1 3/3] net: dsa: microchip: Fix PHY loopback
 configuration for KSZ8794 and KSZ8873
Message-ID: <20231206151406.75eglqtsrrb4vegf@skbuf>
References: <20231121152426.4188456-1-o.rempel@pengutronix.de>
 <20231121152426.4188456-3-o.rempel@pengutronix.de>
 <35045f6ef6a5b274063186c065a8215088b94cd5.camel@redhat.com>
 <20231206085520.GA1293736@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206085520.GA1293736@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 09:55:20AM +0100, Oleksij Rempel wrote:
> On Thu, Nov 23, 2023 at 11:52:57AM +0100, Paolo Abeni wrote:
> > Hi,
> > 
> > On Tue, 2023-11-21 at 16:24 +0100, Oleksij Rempel wrote:
> > > Correct the PHY loopback bit handling in the ksz8_w_phy_bmcr and
> > > ksz8_r_phy_bmcr functions for KSZ8794 and KSZ8873 variants in the ksz8795
> > > driver. Previously, the code erroneously used Bit 7 of port register 0xD
> > > for both chip variants, which is actually for LED configuration. This
> > > update ensures the correct registers and bits are used for the PHY
> > > loopback feature:
> > > 
> > > - For KSZ8794: Use 0xF / Bit 7.
> > > - For KSZ8873: Use 0xD / Bit 0.
> > > 
> > > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > 
> > This looks like a bugfix, so possibly worth a Fixes tag? Given the
> > dependency on the previous refactor, I think we can take it via net-
> > next.
> > 
> > @Andrew, Florian, Vladimir: do you have any specific preference here?
> 
> I do not think any one cares about supporting this switch variant in
> stable :)
> 
> Regards,
> Oleksij

Sorry, this simply fell through the cracks.

How is PHY loopback even supposed to be triggered? User space flips
NETIF_F_LOOPBACK on the netdev, driver ndo_set_features() catches it and
calls phy_loopback() and this calls into phylib's phydev->drv->set_loopback()
or the generic genphy_loopback()?

I don't see DSA implementing ndo_set_features(), nor offering NETIF_F_LOOPBACK.
The PHY is integrated, so DSA is the only relevant netdev driver. Is
there any other way to test this functionality?

If not, I think it's a case of "tree falling in the woods and nobody
hearing it". Not "stable" material. But it definitely has nothing to do
with not caring about the switch variant.

If my analysis is correct, then I actually have a suggestion for you,
Oleksij. Using the F word ("fix") can work against you, if you don't
have enough proof that you're really fixing something which has a user
visible impact. So either do a thorough analysis of the impact in the
commit message, or don't use the F word.
