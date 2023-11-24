Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 292E47F781C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 16:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345881AbjKXPtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 10:49:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbjKXPtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 10:49:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789C619A5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 07:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700840951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JmYkwjrZaJaOu3DPvilrXKnxuy6wNFKJN/6bdGUy1gs=;
        b=JW/wwArsKiROtyeFykAG8UH8YAy8Z0WZ4q2962bFstKXgqrZN+agtzi9mHt6vsDVxONUb4
        vEB0873pv1lUcW8EDTn3f2B7JnpPHVNhOqDXnvXM2mK/hRMQQzt6FewlwIR2Ib7KkdI0uU
        3rHzIABBgk4vNH6NvxlxD9P8rlFTq4g=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-6aS7nwhqP2mpk9nLam6log-1; Fri, 24 Nov 2023 10:49:08 -0500
X-MC-Unique: 6aS7nwhqP2mpk9nLam6log-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a043b44aec3so43240366b.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 07:49:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700840947; x=1701445747;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JmYkwjrZaJaOu3DPvilrXKnxuy6wNFKJN/6bdGUy1gs=;
        b=Q15wKBa58Y+gNF24ahzUmZ6lGV6xnHA0T6cPLEqKAA4wn5l50gNszlQcsfh32K4qUb
         /GqlZnCfMm+lq9cdIh/0BRtZyjtXTmM+VhM6I6++aOee3Bk1i1u+Mwq6/JViEDwsA/jh
         L873Uzk0Ax1Do7ZzXf2Y3VnxFKd0t4/RdaTvHRf+xoxAXWkU05LGYjNGBtbMJkTKBEeW
         Clal9qYXBXo+8CbJSP1pFgFgFm3NhHL4KAWJe+v2KQ9bbSEGQmva0k5vC/o6Evd2L8e7
         N5nQD8u7fmG2Qe1Y3JmnS1aHrcbQPmGdjgmfV5wl6F4nxlX+RZLbz5GhgOTZ1UGu90re
         87WQ==
X-Gm-Message-State: AOJu0YwT7gCJ4AphL56NIGhKdj5c1HuhViwb5QFFhEy5jI/E9eYTD63g
        IY/FbY2Xn9MmxHaJ4lRIPuu8Si/JWURusbitD39fjAgHWiwtSAWPYnmNBU7VvE7uwO+RZzvV1A5
        K+3qYodxvGk30dO8ML/4yZcHd
X-Received: by 2002:a17:906:a40b:b0:9c4:4b20:44a5 with SMTP id l11-20020a170906a40b00b009c44b2044a5mr2467426ejz.4.1700840947229;
        Fri, 24 Nov 2023 07:49:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEzU7sedoUm9/hMpec1nsRFKG9QYHWspiwTp8W0AN+aMWC6P4eqkr9yAjzgR5V4Txo37RHZPQ==
X-Received: by 2002:a17:906:a40b:b0:9c4:4b20:44a5 with SMTP id l11-20020a170906a40b00b009c44b2044a5mr2467414ejz.4.1700840946782;
        Fri, 24 Nov 2023 07:49:06 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-241-213.dyn.eolo.it. [146.241.241.213])
        by smtp.gmail.com with ESMTPSA id e25-20020a170906045900b009e655c77a53sm2196512eja.132.2023.11.24.07.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 07:49:06 -0800 (PST)
Message-ID: <1a4a0b4c013b254d92f8c1d7c4e88e145a5be4a3.camel@redhat.com>
Subject: Re: [PATCH 3/4 net] qca_spi: Fix ethtool -G iface tx behavior
From:   Paolo Abeni <pabeni@redhat.com>
To:     Stefan Wahren <wahrenst@gmx.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 24 Nov 2023 16:49:04 +0100
In-Reply-To: <0d1cf97c-abbe-4a7a-a634-312caa882fad@gmx.net>
References: <20231121163004.21232-1-wahrenst@gmx.net>
         <20231121163004.21232-4-wahrenst@gmx.net>
         <ea0087881f20dc154ca08a5b748b853246e2b86f.camel@redhat.com>
         <0d1cf97c-abbe-4a7a-a634-312caa882fad@gmx.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-11-24 at 15:17 +0100, Stefan Wahren wrote:
> Am 23.11.23 um 12:51 schrieb Paolo Abeni:
> > On Tue, 2023-11-21 at 17:30 +0100, Stefan Wahren wrote:
> > > After calling ethtool -g it was not possible to adjust the TX ring si=
ze
> > > again.
> > Could you please report the exact command sequence that will fail?
> ethtool -g eth1
> ethtool -G eth1 tx 8
> >=20
> >=20
> > > The reason for this is that the readonly setting rx_pending get
> > > initialized and after that the range check in qcaspi_set_ringparam()
> > > fails regardless of the provided parameter. Since there is no adjusta=
ble
> > > RX ring at all, drop it from qcaspi_get_ringparam().
> > > Fixes: 291ab06ecf67 ("net: qualcomm: new Ethernet over SPI driver for=
 QCA7000")
> > > Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> > > ---
> > >   drivers/net/ethernet/qualcomm/qca_debug.c | 2 --
> > >   1 file changed, 2 deletions(-)
> > >=20
> > > diff --git a/drivers/net/ethernet/qualcomm/qca_debug.c b/drivers/net/=
ethernet/qualcomm/qca_debug.c
> > > index 6f2fa2a42770..613eb688cba2 100644
> > > --- a/drivers/net/ethernet/qualcomm/qca_debug.c
> > > +++ b/drivers/net/ethernet/qualcomm/qca_debug.c
> > > @@ -252,9 +252,7 @@ qcaspi_get_ringparam(struct net_device *dev, stru=
ct ethtool_ringparam *ring,
> > >   {
> > >   	struct qcaspi *qca =3D netdev_priv(dev);
> > >=20
> > > -	ring->rx_max_pending =3D 4;
> > >   	ring->tx_max_pending =3D TX_RING_MAX_LEN;
> > > -	ring->rx_pending =3D 4;
> > >   	ring->tx_pending =3D qca->txr.count;
> > >   }
> > I think it's preferable update qcaspi_set_ringparam() to complete
> > successfully when the provided arguments don't change the rx_pending
> > default (4)
>=20
> Sorry, i didn't get. The whole point is that there is no RX ring at all,
> just a TX ring.=C2=A0
> During the time of writing this driver, i was under the
> assumption that the driver needs to provide a rx_pending in
> qcaspi_get_ringparam even this is no RX ring. The number 4 represent the
> maximum of 4 packets which can be received at once. But it's not a ring.

Even if the H/W in charge of receiving and storing the incoming packet
is not exactly a ring but some fixed-size structure, I think it would
be better to avoid changing the exposed defaults given they are not
actually changed by this patch and they represent the current status
IMHO quite accurately.

The change I suggested is something alike the following (note that you
could possibly define a macro with a helpful name instead of the raw
number '4')

Cheers,

Paolo
---
diff --git a/drivers/net/ethernet/qualcomm/qca_debug.c b/drivers/net/ethern=
et/qualcomm/qca_debug.c
index 6f2fa2a42770..05c5450bff79 100644
--- a/drivers/net/ethernet/qualcomm/qca_debug.c
+++ b/drivers/net/ethernet/qualcomm/qca_debug.c
@@ -266,7 +266,7 @@ qcaspi_set_ringparam(struct net_device *dev, struct eth=
tool_ringparam *ring,
        const struct net_device_ops *ops =3D dev->netdev_ops;
        struct qcaspi *qca =3D netdev_priv(dev);
=20
-       if ((ring->rx_pending) ||
+       if ((ring->rx_pending !=3D 4) ||
            (ring->rx_mini_pending) ||
            (ring->rx_jumbo_pending))
                return -EINVAL;

