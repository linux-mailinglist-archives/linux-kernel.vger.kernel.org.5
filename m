Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D077F5DE8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 12:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345072AbjKWLh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 06:37:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345034AbjKWLhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 06:37:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF459F
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 03:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700739449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cNU0lJ4bqwRQlxt9Wpe1IHAIeheCW8RuRwLK6Qt/j8Q=;
        b=NqE0TNiYDkk5iBKFDXEDLXB63RjgeK5cgSCpKFNa447zj5GT2YJD0Yz8DlKhFoZW+KDXsR
        jb3RGwYVKXIkDkDsrgUmPctRijR914GABTAyDGGWuSK1p/7N0f7aP5icVtvm+h52zcwn7H
        tEOB2y4DCw3m1JOEMHtF09+L4O7PB14=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-3Hom0jNnO5Kj0NUzJ6FadQ-1; Thu, 23 Nov 2023 06:37:25 -0500
X-MC-Unique: 3Hom0jNnO5Kj0NUzJ6FadQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a02225ee165so14883266b.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 03:37:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700739443; x=1701344243;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cNU0lJ4bqwRQlxt9Wpe1IHAIeheCW8RuRwLK6Qt/j8Q=;
        b=LDYo2aU9zvVMxDLWWwhkCoSZXbSfs5mMBcw1Ws2C1AmIh7ChdJgo4QKa+iZHDd2UyJ
         E7dUBa173a7fXc9t89DaW9l+IZxymhcbIAPP34jGjKMsApWjgulR49ct9WVzCCBHNe/R
         fTB3bXWC7ai1I7Jn0N9XhfP2kqDqEgqiZ6at5TowlKR1JAXR6bQ0OBZF+pHu6f4Ho+tY
         QgUhQINHzsuryDBOqD1ROp6etuqQd7Eg9DlowILfa7bovhXWflqEY6O4G/KwCw8anGsm
         0AuZhrNbbjcFLuWcPuquMHrodBEsb5z7e2q9uhaMmo7RNnKY0gEWBbyVaG8eZ5SSX5Xj
         urXA==
X-Gm-Message-State: AOJu0YxszFXnXXYOErOeNdpLq0BivaEylJt+HSz/+hEyYb9T/GhseyIP
        1VDjyiUwMnuJbP3UkCmPcBJLsRJZsp6d+vVdEFJ4BetU3+KAaHhFD3zSp/pOTW7I6MEGatgdsY2
        szlWSdZVVKKSgZ5GU47lfOsp7
X-Received: by 2002:a17:906:cb:b0:a02:a2fb:543 with SMTP id 11-20020a17090600cb00b00a02a2fb0543mr3401949eji.7.1700739443546;
        Thu, 23 Nov 2023 03:37:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH/qhXeu1lxpefrtiQ6p1bXy+gUpUMSWogFKiIjUP9coMkMwyY1B5XPnDJWqosDbagW70xJxA==
X-Received: by 2002:a17:906:cb:b0:a02:a2fb:543 with SMTP id 11-20020a17090600cb00b00a02a2fb0543mr3401937eji.7.1700739443239;
        Thu, 23 Nov 2023 03:37:23 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-241-213.dyn.eolo.it. [146.241.241.213])
        by smtp.gmail.com with ESMTPSA id jx19-20020a170906ca5300b009fc9fab9178sm669800ejb.125.2023.11.23.03.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 03:37:22 -0800 (PST)
Message-ID: <a24433f86e39cbb45a9606621e01446e7ad6fa53.camel@redhat.com>
Subject: Re: [PATCH 2/4 net] qca_spi: Fix SPI IRQ handling
From:   Paolo Abeni <pabeni@redhat.com>
To:     Stefan Wahren <wahrenst@gmx.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 23 Nov 2023 12:37:21 +0100
In-Reply-To: <20231121163004.21232-3-wahrenst@gmx.net>
References: <20231121163004.21232-1-wahrenst@gmx.net>
         <20231121163004.21232-3-wahrenst@gmx.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-11-21 at 17:30 +0100, Stefan Wahren wrote:
> The functions qcaspi_netdev_open/close are responsible of request &
> free of the SPI interrupt, which wasn't the best choice. Currently
> it's possible to trigger a double free of the interrupt by calling
> qcaspi_netdev_close() after qcaspi_netdev_open() has failed.
> So let us split IRQ allocation & enabling, so we can take advantage
> of a device managed IRQ and also fix the issue.
>=20
> Fixes: 291ab06ecf67 ("net: qualcomm: new Ethernet over SPI driver for QCA=
7000")
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>

The change makes sense, but the changelog is confusing.=C2=A0

qcaspi_netdev_close() and qcaspi_netdev_open() are invoked only via
ndo_open and ndo_close(), right? So qcaspi_netdev_close() will never be
invoked qcaspi_netdev_open(), failure - that is when IFF_UP is not set.

Cheers,

Paolo

