Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8EEC7E0735
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 18:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjKCRNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 13:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjKCRNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 13:13:44 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528B813E;
        Fri,  3 Nov 2023 10:13:41 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-5079f6efd64so2845562e87.2;
        Fri, 03 Nov 2023 10:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699031619; x=1699636419; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h+nD4Pgw2evypVGggTd49EnVE5xcgPJPs+ysRzIDo+E=;
        b=A3+nkL/l8fmcGrlVHMMt4xSOLgv0+wFu6p0LB6mBvgpuomNJ613+zzQ/aFMQlzQS/U
         LwXWlkWUKHY54RQgVFMsoawqw93M8R5FWLu20TxOQrkERnMCTPowa/gIZOaG3blrZoCO
         4svu/C42RHuqLxRCbjzJUkU38uP0QvkIpfqfUJXePIIHO4kqBeDlcn0e+4fv8Eehc6p9
         fxhVz1KfXAAz4eG8Zo+H3iJPkjq1dO7DAfeLIM8JQqZbZGNq7AaAZTWaVF+mfh4Vmmg/
         RSqoeOTOuxoDqabNDmU911GrhX+UbIBG0qf5jdEqkEisfezhLvzLMSeoPc76KS3v8OE4
         NZug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699031619; x=1699636419;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h+nD4Pgw2evypVGggTd49EnVE5xcgPJPs+ysRzIDo+E=;
        b=tKHC/1ZjTwzIPCOMb+Cit+jL3wPQSv2NhJ93uXECB5BHfWOJGRTAd34Zzl71T633DP
         CxUAC3CocPaHmrItKSKKYEaAPRNM2jc0TtitfTdwUe3omABtxP/S9RO7t+LvXIGzVEUp
         l/pGXSOxUqyEKs2FUhsbfP+oYGMTyUQHz7pq/UJwPZVics1X4dP7a2e0f8TvSwB7HL+l
         OA3v45rpRXic6LrET6aUProQzywTJ4dR3LB1li1H7k5fiiKpgD5pyWmOgwUPgrQR13OE
         M9+XdaJkFIxUJY/BIxm9+N2pPFzVYMpZC65eOzHHIYvpJhUW3CunfLLWTSDfPsWs8G5l
         JBlQ==
X-Gm-Message-State: AOJu0YzC4gD44jGX95iBubNH0mjEzdchwCdgcs9fi/iCaet7wWyR3Tnq
        4a7bAZwH+KFxeB/0Jdbk+jkM3UKka5Qxp0+WSLCKmLZTlMoghg==
X-Google-Smtp-Source: AGHT+IF9gJ7v4h4FQjIKegKXOnNZ0zhbuPS6kSAIVuctubyqGAiD1NmF9nl4mTlf750A9JM6HbCmN7fcsRoMltbGimI=
X-Received: by 2002:a05:6512:b9c:b0:509:4814:ed7a with SMTP id
 b28-20020a0565120b9c00b005094814ed7amr5920283lfv.36.1699031619171; Fri, 03
 Nov 2023 10:13:39 -0700 (PDT)
MIME-Version: 1.0
References: <20231030-fix-rtl8366rb-v2-1-e66e1ef7dbd2@linaro.org>
 <20231030141623.ufzhb4ttvxi3ukbj@skbuf> <CACRpkdaN2rTSHXDxwuS4czCzWyUkazY4Fn5vVLYosqF0=qi-Bw@mail.gmail.com>
 <20231030222035.oqos7v7sdq5u6mti@skbuf> <CACRpkdZ4+QrSA0+JCOrx_OZs4gzt1zx1kPK5bdqxp0AHfEQY3g@mail.gmail.com>
 <20231030233334.jcd5dnojruo57hfk@skbuf> <CACRpkdbLTNVJusuCw2hrHDzx5odw8vw8hMWvvvvgEPsAFwB8hg@mail.gmail.com>
 <CAJq09z4+3g7-h5asYPs_3g4e9NbPnxZQK+NxggYXGGxO+oHU1g@mail.gmail.com>
 <CACRpkdZ-M5mSUeVNhdahQRpm+oA1zfFkq6kZEbpp=3sKjdV9jA@mail.gmail.com>
 <CAJq09z6QwLNEc5rEGvE3jujZ-vb+vtUQLS-fkOnrdnYqk5KvxA@mail.gmail.com> <20231102103123.hklqlsbb5kbq53mm@skbuf>
In-Reply-To: <20231102103123.hklqlsbb5kbq53mm@skbuf>
From:   Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date:   Fri, 3 Nov 2023 14:13:27 -0300
Message-ID: <CAJq09z4YOgkTb5YYAyObR-dDihcy1oFh_UQXS+i29EHw0jJxXQ@mail.gmail.com>
Subject: Re: [PATCH net v2] net: dsa: tag_rtl4_a: Bump min packet size
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Hi Luiz,
>
> On Wed, Nov 01, 2023 at 09:35:30AM -0300, Luiz Angelo Daros de Luca wrote:
> > Hi Linus,
> >
> > Sorry but I noticed no issues:
> >
> > From the router:
> >
> > No. Time Source Destination Protocol Length Info
> > 1 0.000000000 192.168.1.1 192.168.1.2 ICMP 1514 Echo (ping) request id=0x0789, seq=23/5888, ttl=64 (reply in 2)
> > 2 0.000040094 192.168.1.2 192.168.1.1 ICMP 1514 Echo (ping) reply id=0x0789, seq=23/5888, ttl=64 (request in 1)
> >
> > From the host:
> >
> > No. Time Source Destination Protocol Length Info
> > 1 0.000000000 192.168.1.2 192.168.1.1 ICMP 1514 Echo (ping) request id=0x0002, seq=8/2048, ttl=64 (reply in 2)
> > 2 0.000391800 192.168.1.1 192.168.1.2 ICMP 1514 Echo (ping) reply id=0x0002, seq=8/2048, ttl=64 (request in 1)
> >
> > If I go over that limit, it fragments the packet as expected.
>
> Could you run the shell command that sweeps over the entire range, fromhere?
> https://lore.kernel.org/netdev/20231030222035.oqos7v7sdq5u6mti@skbuf/

Sure. I might be able to run it on Monday. I'm away from the device
and it might have OOM. It has too little RAM to survive too much time
by itself. However, I doubt it might fail at a specific packet range
as it would hang an interactive SSH session quite easily.

Regards,

Luiz
