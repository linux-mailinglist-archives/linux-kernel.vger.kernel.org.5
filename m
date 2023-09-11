Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD9E79AFB1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241841AbjIKV5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242663AbjIKQFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 12:05:11 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208271AE;
        Mon, 11 Sep 2023 09:05:06 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9a21b6d105cso587471266b.3;
        Mon, 11 Sep 2023 09:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694448304; x=1695053104; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n6u7WBE0C2GBolYTrm9eS0oWBeCuxRHF6Iy68Vs1pLw=;
        b=bbbFJfqJKO1QgHRKmYELxz9X4//WwTxUxABc88n5/goVD+6GAaMCyyJYYy5xS+iBaf
         fhE45KGUKt5hq41bZVEyUebzLFqr0UHE00d1r+COKeoU1qjpgb+q6tkI4Qyp8z/I2Eru
         Fl7hGDfTEhxkIzkzlnhNwmY+7n+qmF1xZTSzH1eTdTFR+z6QEsLgt/A/42QDHMWBQRcJ
         I09zpI+3R21fUpkd6E1dYI48giJqeKth1mSqnXILAj206AH88uakyLBjI5wdle/WYWnh
         //CSEaMYnKA2Y5qDHt6BI4OF5M5Q1CxNMIC7ETiZzk7m2i0iHHz2j1yl6twxTz4JnUse
         s65Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694448304; x=1695053104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n6u7WBE0C2GBolYTrm9eS0oWBeCuxRHF6Iy68Vs1pLw=;
        b=usyiaUyeyGEqa63Df+kUH91flGmu9nDEtdPBu2uJfLRcE1izqEFBDQmUYp2s0XB9Ne
         t4dIATN4MXDgYlYbnXy+Q2dPdOBI8CiN19/XNsg7DsOLdF5nhpOvq3A96gM+gU88y0j6
         Rxvxi58BIej1zs9WVIaJ45ni00GR+gLRLEJxOgGYSUNNshpxtWNjfByQJAQ3N8UiChXR
         ADwH2Wpx/MSNfnzrGWVlECDb3EqWJcffX4pF1Ev5PNq46W3iy2l+2FBMNSyErAgHrwJn
         F5S9qf+MjD4o8WV9TtJVmFY8xab2G5+rUjzHC6ZwGezefm8IZLSC+yGoNzl58gwUy4zN
         /bWA==
X-Gm-Message-State: AOJu0YxUA+kQjz+GWmFw+2t6XppjOFV8Kc3JHOgESD/nc0JNabk2lj2x
        jw0BuV87N4nbZH282cJy75+bv2lnL0tFSA==
X-Google-Smtp-Source: AGHT+IEgeuFO5IlATMrpoHlg0qKxO7fWdTmPbs4L1udB6qxv6lG+9vyujy+4QgW4aS3c6DFh/lFrNQ==
X-Received: by 2002:a17:906:3192:b0:9a5:cc2b:50f1 with SMTP id 18-20020a170906319200b009a5cc2b50f1mr8608355ejy.67.1694448304269;
        Mon, 11 Sep 2023 09:05:04 -0700 (PDT)
Received: from skbuf ([188.26.56.202])
        by smtp.gmail.com with ESMTPSA id y19-20020a17090668d300b0098884f86e41sm5490193ejr.123.2023.09.11.09.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 09:05:03 -0700 (PDT)
Date:   Mon, 11 Sep 2023 19:05:01 +0300
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
Message-ID: <20230911160501.5vc4nttz6fnww56h@skbuf>
References: <20230906152801.921664-1-lukma@denx.de>
 <20230911165848.0741c03c@wsk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911165848.0741c03c@wsk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 04:58:48PM +0200, Lukasz Majewski wrote:
> Dear Community,
> 
> Are there any comments regarding this new revision of the HSR support
> for KSZ9477 switch?
> 
> Best regards,
> 
> Lukasz Majewski

Yeah, the integration with the DSA master's MAC address is not quite
what I was expecting to see.

See, both the DSA master's MAC address, as well as the HSR device's MAC
address, can be changed at runtime with:

ip link set eth0 address AA:BB:CC:DD:EE:FF # DSA master
ip link set lan1 address AA:BB:CC:DD:EE:FF # indirectly changes the HSR's address too

which is problematic because the hardware does not get updated in that
case, but the address change is not refused either.

Actually, the reason why I haven't yet said anything is because it made
me realize that there is a pre-existing bug in net/dsa/slave.c where we
have this pattern:

	if (!ether_addr_equal(dev->dev_addr, master->dev_addr))
		dev_uc_add(master, dev->dev_addr);

but there is no replay of the dev_uc_add() call when the master->dev_addr
changes. This really results in RX packet loss, as I have tested. I don't
know what is the best way to solve it.

Anyway, programming the MAC address of the DSA master or of the HSR
device to hardware seems to require tracking the NETDEV_CHANGEADDR and
NETDEV_PRE_CHANGEADDR events, even if only to reject those changes.
