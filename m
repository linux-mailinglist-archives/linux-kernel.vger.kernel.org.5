Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13CA57627D6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 02:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjGZAoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 20:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjGZAoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 20:44:54 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DDC1BFB;
        Tue, 25 Jul 2023 17:44:53 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-98df3dea907so948001166b.3;
        Tue, 25 Jul 2023 17:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690332291; x=1690937091;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qM+o2x0Q9td2BAJ6ErJnDWRLqW6HpDY4XZZK/xV7DJk=;
        b=VvinILAje6hRqPdaqfbQf9bzhtnpCg24gtbeWFXmRnQogQ08NnWKzGNQLwtVODnM3H
         s/CSC99woI9rU0OcTEWhcFNcTdeNDZublWp3rQhqaOy6DZImFMRVMO8bau9wVLdeBQ8p
         Adzi0Icn91S17dWMtr7qxo0VBOadTPN54U84MB4h2bOBdLtD8CkgXbR7z7jqPn8pDhIO
         4fpHVu1K1fif0CTD+oaqgvyN3eUkQ5jqt5UfFy676Yf9S/DV6UXUeRkbtxukVasa3+JN
         O+XtEUktRjEoJzU8G3Y8IuLTiHdgfn6+ntZepGiDNWzPHDurB3AOEyBnW9t9j665XxXp
         XVfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690332291; x=1690937091;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qM+o2x0Q9td2BAJ6ErJnDWRLqW6HpDY4XZZK/xV7DJk=;
        b=D1utsuttQWYPyYlx7Na7+NCi0DiW7OINCQ+iYVnA4p3MqS4+AuTxNTebYiD26lHPe6
         Z+g8ClgrrOEzRUebRQnkmp7K/iYXmV7ZvnDqe7IVu/2u0HkKST/r0jTx3hdNq9rGaBcR
         S8Na2KGChogp2uF7fH4tbX3qQdo8LHuBaW8DREm0PEAw5EwFRwp/b7rrFwa7rlZAOTKN
         UktwtjsGbd+byX+fVThHrrKieJ4Uo+YiEOUzStaUqhadEwEEFwxu34t4MUWWchTXRtzS
         QDbk6nlEuB4voPUZdWFcH6CL1VpCNHGjD2ZNR3/tJPhkV//h3O05YpTw33bMY2nC6O4g
         Y8Yw==
X-Gm-Message-State: ABy/qLb0JvKtL6KM9GEdw/0SG7LkKnIAmJjT3e2995zb8H/HmUpHNECg
        4run84cE2VUqNhTyxEHjBiw=
X-Google-Smtp-Source: APBJJlHlPfzZ6qbC7dkc0DtHVZlVOnNjAEeLA5C4h9N570Z0BOO6mVhWMJOa4FO1xoP29KyrUNp38g==
X-Received: by 2002:a17:906:224e:b0:993:ec0b:1a24 with SMTP id 14-20020a170906224e00b00993ec0b1a24mr357232ejr.7.1690332291380;
        Tue, 25 Jul 2023 17:44:51 -0700 (PDT)
Received: from skbuf ([188.25.175.105])
        by smtp.gmail.com with ESMTPSA id b11-20020a170906150b00b009786ae9ed50sm8849308ejd.194.2023.07.25.17.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 17:44:51 -0700 (PDT)
Date:   Wed, 26 Jul 2023 03:44:48 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Arun Ramadoss <arun.ramadoss@microchip.com>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
        Petr Machata <petrm@nvidia.com>
Subject: Re: [PATCH net-next v2 1/1] net: dsa: microchip: Add partial ACL
 support for ksz9477 switches
Message-ID: <20230726004448.yctikq3kipyehd7v@skbuf>
References: <20230721140224.1465766-1-o.rempel@pengutronix.de>
 <20230721140224.1465766-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721140224.1465766-1-o.rempel@pengutronix.de>
 <20230721140224.1465766-1-o.rempel@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 04:02:24PM +0200, Oleksij Rempel wrote:
> This patch adds partial Access Control List (ACL) support for the
> ksz9477 family of switches. ACLs enable filtering of incoming layer 2
> MAC, layer 3 IP, and layer 4 TCP/UDP packets on each port. They provide
> additional capabilities for filtering routed network protocols and can
> take precedence over other forwarding functions.
> 
> ACLs can filter ingress traffic based on header fields such as
> source/destination MAC address, EtherType, IPv4 address, IPv4 protocol,
> UDP/TCP ports, and TCP flags. The ACL is an ordered list of up to 16
> access control rules programmed into the ACL Table. Each entry specifies
> a set of matching conditions and action rules for controlling packet
> forwarding and priority.
> 
> The ACL also implements a count function, generating an interrupt
> instead of a forwarding action. It can be used as a watchdog timer or an
> event counter. The ACL consists of three parts: matching rules, action
> rules, and processing entries. Multiple match conditions can be either
> AND'ed or OR'ed together.
> 
> This patch introduces support for a subset of the available ACL
> functionality, specifically layer 2 matching and prioritization of
> matched packets. For example:
> 
> tc qdisc add dev lan2 clsact
> tc filter add dev lan2 ingress protocol 0x88f7 flower action skbedit prio 7
> 
> tc qdisc add dev lan1 clsact
> tc filter add dev lan1 ingress protocol 0x88f7 flower action skbedit prio 7
> 
> The hardware offloading implementation was benchmarked against a
> configuration without hardware offloading. This latter setup relied on a
> software-based Linux bridge. No noticeable differences were observed
> between the two configurations. Here is an example of software-based
> test:
> 
> ip l s dev enu1u1 up
> ip l s dev enu1u2 up
> ip l s dev enu1u4 up
> ethtool -A enu1u1 autoneg off rx off tx off
> ethtool -A enu1u2 autoneg off rx off tx off
> ethtool -A enu1u4 autoneg off rx off tx off
> ip l a name br0 type bridge
> ip l s dev br0 up
> ip l s enu1u1 master br0
> ip l s enu1u2 master br0
> ip l s enu1u4 master br0
> 
> tc qdisc add dev enu1u1 root handle 1:  ets strict 4 priomap 3 3 2 2 1 1 0 0
> tc qdisc add dev enu1u4 root handle 1:  ets strict 4 priomap 3 3 2 2 1 1 0 0
> tc qdisc add dev enu1u2 root handle 1:  ets strict 4 priomap 3 3 2 2 1 1 0 0
> 
> tc qdisc add dev enu1u1 clsact
> tc filter add dev enu1u1 ingress protocol 0x0800  flower action skbedit prio 7
> 
> tc qdisc add dev enu1u4 clsact
> tc filter add dev enu1u4 ingress protocol 0x0800  flower action skbedit prio 0
> 
> On a system attached to the port enu1u2 I run two iperf3 server
> instances:
> iperf3 -s -p 5210 &
> iperf3 -s -p 5211 &
> 
> On systems attached to enu1u4 and enu1u1 I run:
> iperf3 -u -c  172.17.0.1 -p 5210 -b100M  -l1472 -t100
> and
> iperf3 -u -c  172.17.0.1 -p 5211 -b100M  -l1472 -t100
> 
> As a result, IP traffic on port enu1u1 will be prioritized and take
> precedence over IP traffic on port enu1u4
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---

Sorry for the delay. I will review this patch (and other pending DSA
patches) tomorrow.
