Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B697F77DF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 16:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345834AbjKXPdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 10:33:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbjKXPdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 10:33:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426E310FB
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 07:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700839989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eRK+vExLgDNmQIkKz5bLbrtvkKYmpG6qoQ5cgKImwFM=;
        b=ITfUEpdu6EInmkv+2dSc92eVJo4d6mf1qfs4jOw9wN952/SH2D/Z/H5i1qkkhPK9hNFaZO
        W1YSWnUOgrRj7t4h+cBUSYdZYaoPUV4/XhTI9q3pHVgtFykTLGQeEOD/XwOTXkSoGVM464
        XGoMqUv8BOIbQQn1tZB3cV9AQu8bILE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-XbYeKowlPiyGnhL2LBJ1fQ-1; Fri, 24 Nov 2023 10:33:08 -0500
X-MC-Unique: XbYeKowlPiyGnhL2LBJ1fQ-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-54848173cf8so216601a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 07:33:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700839987; x=1701444787;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eRK+vExLgDNmQIkKz5bLbrtvkKYmpG6qoQ5cgKImwFM=;
        b=MgD1o4TJ8wUmsC47KYxC4BRxcdQxIhfuGJsS9C5atu+7ASX/zy7J5vCvPtPSY7DbRc
         v6ciP4pC8jhEayQjxT4PqQHJWZ4H+0iQ+1Td2j/FHp+3cfH/5YXdyzP3rqSuRKy8HtDf
         fDCJyo/rvcSQ4ERqOp1sexn8pm8teko8P5crTyTNzTWR9/gRCV6XCOta7+ar218Ky1TF
         JJ6koo/AiqaFMLemz25YbBdm25J2lb3M0/ohlSq+EMsXLBeOz2+NukqJtruVdeU8QpDP
         ooT++67Y2CyCo/tOHPkb8VKhcQelg6kk1/2QhC5QIPQ7b6f/Dajas7Yk/KSKMWvabiCa
         gysA==
X-Gm-Message-State: AOJu0YwwQ32iVmmchTH6kKTs9qI8MeYmF00LjpHfrk+HLNTBLxa1Z23a
        W5B48eRRPJPtKQGHKJQy3z/1FhQqjLcru6FqdVzmgrDD6wERLx/Pg5U/0m3DInCtqaHyVRDE6a1
        tVu1t5+zNBmSvuFn7kAw5RBVx
X-Received: by 2002:a50:ec96:0:b0:543:6222:e37c with SMTP id e22-20020a50ec96000000b005436222e37cmr2170175edr.0.1700839986937;
        Fri, 24 Nov 2023 07:33:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEMQm2y5BRnwFeyXXHsc020p1XoBKA0tSPDi4Pl/fWInC6PUZFDeh/YRiMPUG/d1pjbHHz+rg==
X-Received: by 2002:a50:ec96:0:b0:543:6222:e37c with SMTP id e22-20020a50ec96000000b005436222e37cmr2170168edr.0.1700839986567;
        Fri, 24 Nov 2023 07:33:06 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-241-213.dyn.eolo.it. [146.241.241.213])
        by smtp.gmail.com with ESMTPSA id n3-20020aa7c783000000b0054901c25d50sm1876098eds.14.2023.11.24.07.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 07:33:06 -0800 (PST)
Message-ID: <9e2bba3c98cd24ebf1b6d9fde2e0b9229ad6b99f.camel@redhat.com>
Subject: Re: [PATCH 2/4 net] qca_spi: Fix SPI IRQ handling
From:   Paolo Abeni <pabeni@redhat.com>
To:     Stefan Wahren <wahrenst@gmx.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 24 Nov 2023 16:33:04 +0100
In-Reply-To: <bf3dd03e-a1f2-4586-8f00-7003848016aa@gmx.net>
References: <20231121163004.21232-1-wahrenst@gmx.net>
         <20231121163004.21232-3-wahrenst@gmx.net>
         <a24433f86e39cbb45a9606621e01446e7ad6fa53.camel@redhat.com>
         <bf3dd03e-a1f2-4586-8f00-7003848016aa@gmx.net>
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

On Fri, 2023-11-24 at 15:01 +0100, Stefan Wahren wrote:
> Hi Paolo,
>=20
> Am 23.11.23 um 12:37 schrieb Paolo Abeni:
> > On Tue, 2023-11-21 at 17:30 +0100, Stefan Wahren wrote:
> > > The functions qcaspi_netdev_open/close are responsible of request &
> > > free of the SPI interrupt, which wasn't the best choice. Currently
> > > it's possible to trigger a double free of the interrupt by calling
> > > qcaspi_netdev_close() after qcaspi_netdev_open() has failed.
> > > So let us split IRQ allocation & enabling, so we can take advantage
> > > of a device managed IRQ and also fix the issue.
> > >=20
> > > Fixes: 291ab06ecf67 ("net: qualcomm: new Ethernet over SPI driver for=
 QCA7000")
> > > Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> > The change makes sense, but the changelog is confusing.
> >=20
> > qcaspi_netdev_close() and qcaspi_netdev_open() are invoked only via
> > ndo_open and ndo_close(), right? So qcaspi_netdev_close() will never be
> > invoked qcaspi_netdev_open(), failure - that is when IFF_UP is not set.
> sorry, i missed to mention an important part. This issue is partly
> connected to patch 3.
> Please look at qcaspi_set_ringparam() which also call ndo_close() and
> ndo_open().=C2=A0

Ah, I see it now. IMHO root cause of the problem is there. The ethtool
op should not flip the device state.=C2=A0

A more narrow fix would be to park/unpark the thread inside
set_ringparam() - instead of the whole patch 1 && 2 I suspect.

IMHO the changes in this still make sense - a refactor for net-next.

Cheers,

Paolo

