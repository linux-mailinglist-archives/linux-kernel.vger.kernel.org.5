Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03AC792738
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235704AbjIEQC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354740AbjIEN51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 09:57:27 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46951197;
        Tue,  5 Sep 2023 06:57:24 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99c3c8adb27so385085666b.1;
        Tue, 05 Sep 2023 06:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693922243; x=1694527043; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AbqRVHgQYQHhHZOk6eeSls+sEH+8z1toioax1pRSrQA=;
        b=TgU27uf+DwLJLsSEgKST8+Z6yx8ttbmFZBx45RSGGKQJCkydlYk/yBk4pmarFFvdBV
         75llmKmmbLZY4308Xj34P1nEjaUlNfRfFz+dIM2fJJRV7hJWDheDuvl+z8sb3x4ioYhC
         Uo3qrw7sny2r2RcyKH6hwhJyWAWk/euTieQ7xQaEW7iXAlK9BvArx/HEOj2xe8hV6QRJ
         2Yv0lv2oE5KDNKyEeLghZ6ker1SILjnhBUS1OyjNf8fBn8QHi1Ln5PNLWPTwQNSpGgO8
         ID8Qjp1ICTDbI2sTN28jrYHzNpbV2E2WnBM8kzxDXKVMl3xiTKFu23Y2D6bAnraKQ3pO
         uuOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693922243; x=1694527043;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AbqRVHgQYQHhHZOk6eeSls+sEH+8z1toioax1pRSrQA=;
        b=Tc0dlz7gHW8BKsVA9zW/B8iZT508ayWHYLUvg/gxOC5pZmhB8ghVWNyWDPfoHfX0wf
         6Z1uD2NuFIVu6mFcujmpU6NQ9I7HOM8UCQP/mhCFdsgz2rgbHtVoircFLv5JIImIByLt
         TXC0tij/tSe1z/u7bQFcqyKubRokvzGJQqXvK8XhUFFhtWoeZ6guGdlV/lHOM1nKmCR9
         t/hh7KPyiV/ChxA8eDCjumgsETmh6r+mo+EdzUMc8UZ3o1Xc9i29drejyvsCOPBFswJo
         scgTvybyxgJC+KKEZqGWjf+0+YY6oFqCa6acpPHqFfgxYbRnBKArF/HOFU/rOFu83+kJ
         JDqw==
X-Gm-Message-State: AOJu0YxoL3UywGtY7lID7NQ+ePYGIDNkyf7TB4cYAzahpvs4SGjk/ioc
        2LRyUd1lHpO/GKN24T6RM8A=
X-Google-Smtp-Source: AGHT+IFUkfcraBHHjcQBhvbodWnNWOfSRc1PyhGLkQIHdxnC7JN5ddNxJpAQCPbpjEuB58MvQmJtPw==
X-Received: by 2002:a17:907:7611:b0:9a5:ebfd:79a3 with SMTP id jx17-20020a170907761100b009a5ebfd79a3mr10419926ejc.29.1693922242624;
        Tue, 05 Sep 2023 06:57:22 -0700 (PDT)
Received: from skbuf ([188.26.57.165])
        by smtp.gmail.com with ESMTPSA id p27-20020a17090635db00b00991d54db2acsm7594293ejb.44.2023.09.05.06.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 06:57:22 -0700 (PDT)
Date:   Tue, 5 Sep 2023 16:57:19 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew@lunn.ch>,
        davem@davemloft.net, Paolo Abeni <pabeni@redhat.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Tristram.Ha@microchip.com, Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>, UNGLinuxDriver@microchip.com,
        George McCollister <george.mccollister@gmail.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 RFC 4/4] net: dsa: hsr: Provide generic HSR
 ksz_hsr_{join|leave} functions
Message-ID: <20230905135719.yycwfgonlt244gvx@skbuf>
References: <20230904120209.741207-1-lukma@denx.de>
 <20230904120209.741207-1-lukma@denx.de>
 <20230904120209.741207-5-lukma@denx.de>
 <20230904120209.741207-5-lukma@denx.de>
 <20230905104725.zy3lwbxjhqhqyzdj@skbuf>
 <20230905132351.2e129d53@wsk>
 <20230905120501.tvkrrzcneq4fdzqa@skbuf>
 <20230905154744.648c1a8b@wsk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905154744.648c1a8b@wsk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 03:47:44PM +0200, Lukasz Majewski wrote:
> > > Moreover, for me it seems more natural, that we only allow full HSR
> > > support for 2 ports or none. Please be aware, that HSR supposed to
> > > support only 2 ports, and having only one working is not
> > > recommended by vendor.  
> > 
> > And where is it enforced that full HSR offload is only applied to 2
> > ports or none?
> 
> In the ksz_jsr_join() at ksz_common.c -> we exit from this function
> when !partner.

And what about 4 or 6 ports being placed as members of 2 or 3 HSR devices?
How does the !partner condition help there?

> > Results:
> > With KSZ9477 offloading support added: RX: 100 Mbps TX: 98 Mbps
> > With no offloading                     RX: 63 Mbps  TX: 63 Mbps
> > 
> > What was the setup for the "no offloading" case?
> > 
> 
> I used two boards. I've used the same kernel with and without HSR
> offloading patches.
> 
> Cables were connected to port1 and port2 on each board. Non HSR network
> was connected to port3.
> 
> > (a) kernel did not contain the offloading patch set
> > 
> 
> Yes.

Ok, then it would be good to check that your patch set does not break
something that used to work (software HSR - easiest to check with a
second pair of ports, but if not possible, it can also be emulated by
returning -EOPNOTSUPP in .port_hsr_join on an artificial other condition).

> > (b) the testing was on hsr1, in the situation below:
> > 
> > ip link add name hsr0 type hsr slave1 lan1 slave2 lan2 supervision 45
> > version 1 # offloaded ip link add name hsr1 type hsr slave1 lan3
> > slave2 lan4 supervision 45 version 1 # unoffloaded
> 
> I did not setup two hsr devices on the same board. I've used two boards
> with hsr0 setup on each.

Ok, but can you?

> > (d) in some other way (please detail)
> > 
> > I was specifically asking about situation (b).
> 
> I did not tested the hsr0, hsr1 as my (real) use case is with KSZ9477
> having only 3 ports available for connection (port 1,2,3).

ksz_chip_data :: port_cnt is set to 7 for KSZ9477. I guess that the
limitation of having only 3 user ports for testing is specific to your
board, and not to the entire switch as may be seen on other boards,
correct?

It doesn't mean that the "single HSR device" restriction shouldn't be
enforced.
