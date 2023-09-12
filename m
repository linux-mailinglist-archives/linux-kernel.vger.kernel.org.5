Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1814E79DB3E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 23:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237739AbjILVze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 17:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237689AbjILVzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 17:55:32 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D094E10D3;
        Tue, 12 Sep 2023 14:55:28 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-52eed139ec2so6242249a12.2;
        Tue, 12 Sep 2023 14:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694555727; x=1695160527; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HWrbkSWP+kAtkw67a80zxrFIa3m1f+KFJ7dhwBT/qlA=;
        b=bnn6wSy4ch5BaGb8rZPrHh5/US3uxwEjXm96KlOX5Cltt8b+RZlz0uBU3fklX8wXAD
         RGeq5cuQcps3zqaakzkgXMEJFQemgkJybDGHJwTZIeIR8mECfMVtIl7KQKQGaQzEhQs4
         7M3jE0CyVIOTiy36BP/iziM0HXgY4oxCWCAdZG9+0lMuAEy7rIABms/E9NFqJNMwtglL
         uJuQoNlgb8ExSE6M+gDT1LiuexelBMt9I1zxuSayCgBY43pR7ELONqBNyCQg9WPZqQNm
         8E48El2ij99ikZnhUyf8h474p4E/TOykOFraRsifAype1dZywCbIWdaS1UkPnwEHCpn+
         8ejA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694555727; x=1695160527;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HWrbkSWP+kAtkw67a80zxrFIa3m1f+KFJ7dhwBT/qlA=;
        b=Pb/JKNFlS5Ub/UrcpdJn/MYXbaASRHF+PkROI6dA5Hvd171tKJ32jY/gM1nxt5oRzY
         dJb6+jQZ+z7xUuMuMQoHMdKyHNmJDOEPLsNgPV93M2yeHvLA48/0dzderfNcm9RFPecy
         vTFemoCsNf+cd7g/7gBkxFs/M9OIDW7b1vHlUU8nXBLcIsrqaXSwfHLPI0cmI7hZC8XU
         GRMdmT6DptLWrOC8ODMTOcr+QkHI0WiI4Dz4EEDeV5pin6/QfAGbg9Ybq1JvjEdWdcXU
         xmnIKfc2wzeTGrM9Xt3hv/JEVgJGqCVB80wSFBXnN6wSWeYBl+RBrwD+vMBoLtmv511r
         UN/Q==
X-Gm-Message-State: AOJu0Yzl02CLx+KO5XKPKPbQwxR7+LwToom2XIdrJIt+7Iejd2iot0qM
        3pxSq/tutJ17ELdblALR4YQ=
X-Google-Smtp-Source: AGHT+IEojQmT/R0F2mSzoHiiT2Rph99bNbGnxk23OTYI509L2S5zzsOUuGSMOtwTNcgGnSihIctLwg==
X-Received: by 2002:a05:6402:74f:b0:523:3889:542a with SMTP id p15-20020a056402074f00b005233889542amr721651edy.34.1694555726411;
        Tue, 12 Sep 2023 14:55:26 -0700 (PDT)
Received: from skbuf ([188.25.254.186])
        by smtp.gmail.com with ESMTPSA id f9-20020a056402194900b0052fc0832e08sm397825edz.1.2023.09.12.14.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 14:55:26 -0700 (PDT)
Date:   Wed, 13 Sep 2023 00:55:23 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Tristram.Ha@microchip.com, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net,
        Woojung Huh <woojung.huh@microchip.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com,
        Oleksij Rempel <linux@rempel-privat.de>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [[RFC PATCH v4 net-next] 0/2] net: dsa: hsr: Enable HSR HW
 offloading for KSZ9477
Message-ID: <20230912215523.as4puqamj65dikip@skbuf>
References: <20230912092909.4yj4b2b4xrhzdztu@skbuf>
 <20230906152801.921664-1-lukma@denx.de>
 <20230911165848.0741c03c@wsk>
 <20230911160501.5vc4nttz6fnww56h@skbuf>
 <20230912101748.0ca4eec8@wsk>
 <20230912092909.4yj4b2b4xrhzdztu@skbuf>
 <20230912160326.188e1d13@wsk>
 <20230912160326.188e1d13@wsk>
 <20230912142644.u4sdkveei3e5hwaf@skbuf>
 <20230912170641.5bfc3cfe@wsk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912170641.5bfc3cfe@wsk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 05:06:41PM +0200, Lukasz Majewski wrote:
> Are we debating about some possible impact on patches which were posted
> and (in a near future?) would be reposted?

We are discussing the ways in which a multi-purpose register should be
programmed. Not "the impact on patches" per se, because Oleksij will
have to adapt no matter what you do, but rather the options that remain
available to him, after the first feature that makes use of the
multi-purpose register makes its way to mainline.

> > > Considering the above - the HSR implementation is safe (to the
> > > extend to the whole DSA subsystem current operation). Am I correct?
> > >  
> > 
> > If we exclude the aforementioned bug (which won't be a bug forever),
> > there still exists the case where the MAC address of a DSA user port
> > can be changed. The HSR driver has a NETDEV_CHANGEADDR handler for
> > this as well, and updates its own MAC address to follow the port. If
> > that is allowed to happen after the offload, currently it will break
> > the offload.
> 
> But then we can have struct ksz_device extended with bitmask -
> hw_mac_addr_ports, which could be set to ports (WoL or HSR) when
> REG_MAC_ADDR_0 is written.
> 
> If WoL would like to alter it after it was written by HSR, then the
> error is presented (printed) to the user and we return.
> 
> The same would be with HSR altering the WoL's MAC in-device setup.
> 
> 
> The HSR or WoL can be added without issues (the first one which is
> accepted).
> 
> Then the second feature would need to implement this check.

This is more or less a rehash of what I proposed as option 2, except for
the fact that you suggest a port mask and I suggest a proper refcount_t.
And the reason why I suggest that is to allow the "WoL+HSR on the same
port" to work. With your proposal, both the HSR and WoL code paths would
set the same bit in hw_mac_addr_ports, which would become problematic
when the time comes to unset it. Not so much when every port calls
refcount_inc() per feature. With WoL+HSR on the same port, the MAC
address would have a refcount of 2, and you could call port_hsr_leave()
and that refcount would just drop to 1 instead of letting go.

There are probably hundreds of implementations of this idea in the
kernel, but the one that comes to my mind is ocelot_mirror_get() +
ocelot_mirror_put(). Again, I need to mention that I know that port
mirroring != HSR - I'm just talking about the technique.

There is one more thing that your reply to my observation fails to
address. Even with this refcount thing, you will still need to add code
to dsa_slave_set_mac_address() which notifies the ksz driver, so that
the driver can refuse MAC address changes, which would break the
offloads. Ack?

In principle it sounds like a plan. It just needs to be implemented.
