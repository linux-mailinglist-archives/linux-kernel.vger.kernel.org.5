Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC5F7AF6D0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 01:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjIZXnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 19:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232607AbjIZXlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 19:41:01 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0928F1730;
        Tue, 26 Sep 2023 15:54:06 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9a648f9d8e3so1298070866b.1;
        Tue, 26 Sep 2023 15:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695768844; x=1696373644; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dQJAscD2wySe2863Xyr7yQaPfi/ox1Xy3HuPTVjHqlk=;
        b=Z2oUMMQE67f/LxI/iDM+IZ8WFlMHZ9/IsdkdnrQPbXEP9XOYqz7J8nrYJ5jLpqbUfs
         0+FKex7tjH2IApkmYIsoQ3lLxR/AVq1RIYnyKefV1qc7gi0mgHJRNrDTlxVXSui4MIbP
         G7PXRMQCLem5KhwHN/E3XX+41Cl8tB9v9SfZm0CGeHxNpo79ICgviMDCyhIXUDKLZ59y
         rW8z/yuDCb/V2VZIWmJtZQ0tQeesoyupmIIJJBQZlzCk2a4ARYaBNtcfBzRneUxrJVQr
         03MG8QhWFR+Ajdc3hTEg8pY3VMP69Wfg7C3LocxLqvT7WD/eo0Ps1ibLCXZYti094ecf
         WUng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695768844; x=1696373644;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dQJAscD2wySe2863Xyr7yQaPfi/ox1Xy3HuPTVjHqlk=;
        b=qZLYWJktxRfqatimo1LCCveGqMHmItVpXpKbZN67Wr5bMiNEo6NP75G00pmcvkItpc
         LfGNw0Ai3kbHg2eBlq6aOcmmsl4ot+bU6pM26c5OmABbTULONrn2ptd3jfatNzDiEf3X
         voYyuFaUf3J4/ZCEFJfL4Iscdm/AlwZELi5eqQhFc3tERFvvyHXs5NOZ+CtLNpeacbCv
         VjmUJAP/wuXCNyrAalNjbHVJ8fZJz9aBZcfzSDwunT2l4OLrjhRpEIaIEAeoy3r87fo/
         c3SswndbqivvDWm8AWLEq+2FX9d8GYOGLUZkrd0qQDdpK6bEecICxlEJVfeF0d8OfKcK
         zEhw==
X-Gm-Message-State: AOJu0Yy79NDIlUN4YTUSE064g1A/fdJhPwF3uOFjuh9vQ/xmnD1BOnG2
        uyO3yA+EK8QqENGHl19AU4U=
X-Google-Smtp-Source: AGHT+IHzPqsLAeIFR4XUFAfgX5/zMyG8+qwdjdcB/+MI6r96c0IBGBg4kB4736oEP2j7G/oCo5u4UQ==
X-Received: by 2002:a17:907:7703:b0:9ae:701a:6efa with SMTP id kw3-20020a170907770300b009ae701a6efamr79673ejc.69.1695768844013;
        Tue, 26 Sep 2023 15:54:04 -0700 (PDT)
Received: from skbuf ([188.25.161.12])
        by smtp.gmail.com with ESMTPSA id s14-20020a170906bc4e00b009937dbabbd5sm8347424ejv.220.2023.09.26.15.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 15:54:03 -0700 (PDT)
Date:   Wed, 27 Sep 2023 01:54:01 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Tristram.Ha@microchip.com, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net,
        Woojung Huh <woojung.huh@microchip.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 net-next 0/5] net: dsa: hsr: Enable HSR HW offloading
 for KSZ9477
Message-ID: <20230926225401.bganxwmtrgkiz2di@skbuf>
References: <20230922133108.2090612-1-lukma@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922133108.2090612-1-lukma@denx.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 03:31:03PM +0200, Lukasz Majewski wrote:
> This patch series provides support for HSR HW offloading in KSZ9477
> switch IC.
> 
> To test this feature:
> ip link add name hsr0 type hsr slave1 lan1 slave2 lan2 supervision 45 version 1
> ip link set dev lan1 up
> ip link set dev lan2 up
> ip a add 192.168.0.1/24 dev hsr0
> ip link set dev hsr0 up
> 
> To remove HSR network device:
> ip link del hsr0
> 
> To test if one can adjust MAC address:
> ip link set lan2 address 00:01:02:AA:BB:CC
> 
> It is also possible to create another HSR interface, but it will
> only support HSR is software - e.g.
> ip link add name hsr1 type hsr slave1 lan3 slave2 lan4 supervision 45 version 1
> 
> Test HW:
> Two KSZ9477-EVB boards with HSR ports set to "Port1" and "Port2".
> 
> Performance SW used:
> nuttcp -S --nofork
> nuttcp -vv -T 60 -r 192.168.0.2
> nuttcp -vv -T 60 -t 192.168.0.2
> 
> Code: v6.6.0-rc2+ Linux net-next repository
> SHA1: 5a1b322cb0b7d0d33a2d13462294dc0f46911172
> 
> Tested HSR v0 and v1
> Results:
> With KSZ9477 offloading support added: RX: 100 Mbps TX: 98 Mbps
> With no offloading 		       RX: 63 Mbps  TX: 63 Mbps

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Thanks!
