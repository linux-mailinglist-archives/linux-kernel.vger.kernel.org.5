Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2201078EC20
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 13:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343567AbjHaLgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 07:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbjHaLgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 07:36:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7FECFE
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 04:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693481718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=La0/Hh+TRze+Vb0q9LsgA7s23V5L37y71l1wEuOHLns=;
        b=NaRLwIzupXBJ/p3+axo3UHVMQ64aMrYlfeyPJCYHEr8klypnXGAuNd/7gdtnCJBNBz4fXK
        a80nSU6a6ajN31g/vaBVeLtMgBpDushL74DrHTgBZK3fCFDLhJ1ImdhJHUzb47xJ8YhKWG
        WqxClBS0NdiZnNNvTKUkViCb62xTONw=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-GekwheLjPH6s-qWYX8piYg-1; Thu, 31 Aug 2023 07:35:17 -0400
X-MC-Unique: GekwheLjPH6s-qWYX8piYg-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2b9cca3c395so2753981fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 04:35:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693481715; x=1694086515;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=La0/Hh+TRze+Vb0q9LsgA7s23V5L37y71l1wEuOHLns=;
        b=ljm976yb42inlz0myL4yU2XgBfFWT78XO/xgN9zPK4jiXJvnVdyq8ynEqLhbCQJFpM
         kanQIs5XSUQTFS9EDYANWkV/hcLDdtTNOnewGnWSqhbx+axjBnRTbayWZKaEjn3Swpab
         4Cubam24vPF9O6oQqSIbT8zCO+BuJw722nz0xmx/ZHMn9b8K8iPVRtaDNYKqQfrf0Obs
         eAHcKxtrBBJWVweRMjvRTRsXfBnSa3XVOkq4Bp03FItyi/Uu+p/cqBTPTtUsd+bAFUF5
         75liw4MY9DFFPSsc7UTikXQhb1wIp55RmvrwYw+9oRr1x7FlJfm6AqAGaerxDMs5sGPH
         BSEQ==
X-Gm-Message-State: AOJu0YzmpCUNlwSJrA5D3sJ7iSsu3u28KZ7g93JSDFTqggbDFWn1X7f6
        XAPpP6PTBqLFLSdP/5UDDAZNinPjmjQSZq3rDdYd2kWK5lCTSgFUruMu3JnUS3Ja3trLRuerko/
        SHV+td/iFGn7nf21zGq0WMqUs
X-Received: by 2002:a05:651c:1256:b0:2b9:54bd:caed with SMTP id h22-20020a05651c125600b002b954bdcaedmr3544624ljh.1.1693481715596;
        Thu, 31 Aug 2023 04:35:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEy3FYJX5luMRBPc3d0+cP01B48hkyJoTaRTZEr1XfwDPFrLtu3gar1njfVMOw9Y1lh+onO3g==
X-Received: by 2002:a05:651c:1256:b0:2b9:54bd:caed with SMTP id h22-20020a05651c125600b002b954bdcaedmr3544605ljh.1.1693481715252;
        Thu, 31 Aug 2023 04:35:15 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-255-219.dyn.eolo.it. [146.241.255.219])
        by smtp.gmail.com with ESMTPSA id a25-20020a1709064a5900b009a2202bfce5sm655485ejv.118.2023.08.31.04.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 04:35:14 -0700 (PDT)
Message-ID: <b6aa2a338c2a2db597415e073819a5fe6d0187a9.camel@redhat.com>
Subject: Re: [PATCH v2 0/4] net: dsa: hsr: Enable HSR HW offloading for
 KSZ9477
From:   Paolo Abeni <pabeni@redhat.com>
To:     Lukasz Majewski <lukma@denx.de>,
        Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net,
        Woojung Huh <woojung.huh@microchip.com>,
        Vladimir Oltean <olteanv@gmail.com>
Cc:     Tristram.Ha@microchip.com, Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>, UNGLinuxDriver@microchip.com,
        George McCollister <george.mccollister@gmail.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 31 Aug 2023 13:35:13 +0200
In-Reply-To: <20230831111827.548118-1-lukma@denx.de>
References: <20230831111827.548118-1-lukma@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-08-31 at 13:18 +0200, Lukasz Majewski wrote:
> This patch series provides support for HSR HW offloading in KSZ9477
> switch IC.
>=20
> To test this feature:
> ip link add name hsr0 type hsr slave1 lan1 slave2 lan2 supervision 45 ver=
sion 1
> ifconfig lan1 up;ifconfig lan2 up
> ifconfig hsr0 192.168.0.1 up
>=20
> To remove HSR network device:
> ip link del hsr0
>=20
> Test HW:
> Two KSZ9477-EVB boards with HSR ports set to "Port1" and "Port2".
>=20
> Performance SW used:
> nuttcp -S --nofork
> nuttcp -vv -T 60 -r 192.168.0.2
> nuttcp -vv -T 60 -t 192.168.0.2
>=20
> Code: v6.5-rc7 Linux repository
> Tested HSR v0 and v1
> Results:
> With KSZ9477 offloading support added: RX: 100 Mbps TX: 98 Mbps
> With no offloading 		       RX: 63 Mbps  TX: 63 Mbps
>=20
>=20
> Lukasz Majewski (4):
>   net: dsa: Extend the ksz_device structure to hold info about HSR ports
>   net: dsa: Extend ksz9477 TAG setup to support HSR frames duplication
>   net: dsa: hsr: Enable in KSZ9477 switch HW HSR offloading
>   net: dsa: hsr: Provide generic HSR ksz_hsr_{join|leave} functions
>=20
>  drivers/net/dsa/microchip/ksz9477.c    | 96 ++++++++++++++++++++++++++
>  drivers/net/dsa/microchip/ksz9477.h    |  4 ++
>  drivers/net/dsa/microchip/ksz_common.c | 81 ++++++++++++++++++++++
>  drivers/net/dsa/microchip/ksz_common.h |  3 +
>  include/linux/dsa/ksz_common.h         |  1 +
>  net/dsa/tag_ksz.c                      |  5 ++
>  6 files changed, 190 insertions(+)
>=20
I'm sorry, it looks like I was not clear previously.
---
## Form letter - net-next-closed

The merge window for v6.6 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We are currently accepting bug fixes only.

Please repost when net-next reopens after Sept 11th.

RFC patches sent for review only are obviously welcome at any time.

See:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#develop=
ment-cycle
--=20
pw-bot: defer

