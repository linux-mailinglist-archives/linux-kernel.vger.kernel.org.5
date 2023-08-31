Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC0C78E91C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 11:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243388AbjHaJK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 05:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236455AbjHaJK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 05:10:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8521B1A3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 02:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693473006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2BzTE6iveZZSL/qke02UmOFuqyQVPsM06jev1BURIww=;
        b=QeNGPpyFsHIKg3QJ0u486E/J3Dng6bMNtZkXLVM2j/ZZvcZN8yc4J3xMWKF/1x4ET2GkS9
        IlKVCO6nnMVpt4Bd1k3+fGVIlEWdeDPCK/lR4owydCa9n/LhJ2oj7BZhxVh1U4YmnOIQJF
        HRWMzn9UeglQ7uBr9sDuS06etfZB1Ts=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-qt1GGAquNm6sIZj18X1uXw-1; Thu, 31 Aug 2023 05:10:04 -0400
X-MC-Unique: qt1GGAquNm6sIZj18X1uXw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-401d62c2de7so1787555e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 02:10:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693473003; x=1694077803;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2BzTE6iveZZSL/qke02UmOFuqyQVPsM06jev1BURIww=;
        b=Nwvp/IqXJ2z6dSZSFKxYM7MckTsQVGACkvQCcbKJAk5SfWev8GPRfoNXHCt22ylBj0
         E4A9QmiFTYvpRzcKxqaWka27qNLq7F4XpScFW6NFyq4s8N11IMewlsuw5kWwnMPUUaRc
         WgYBtwpFXHfJRwq740A0aORevnC/AK+TcKuAReXnqtuAPLyM1CCal7hyau4IRq0DOGid
         Ac7utKhtNPeyDxC5K+iAVusWbTkr+yy7H3iwziat8Syl9lTFahWKDmLjMCONTpXTmjQi
         3xmQQtR2SkJbqUrc55aeGVlv9i73muuHEnrnb4iJ9/8oV8ksgvCSiQCx8pOT9g0cIrWE
         SLHA==
X-Gm-Message-State: AOJu0Yxni8K3EcAscaV2tK7dWaITBznipZ1zDqwbEaFxLoLesszY9yB7
        38IM8VY4rb+I2D5+7AqHmvQss8Vw7NdPCd5jsTskSwPbvxjotegxrzbB42Ze9NgZk/LrLXpzkvE
        5jtzipv+VWjsIjtlRgyqb06Kc
X-Received: by 2002:a05:600c:1c05:b0:401:c07f:72bd with SMTP id j5-20020a05600c1c0500b00401c07f72bdmr3721343wms.4.1693473003533;
        Thu, 31 Aug 2023 02:10:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBvYLYX1TbgI+F5VAn3QQ+wii4EVihSIxsp63bCsCHtELfSbFvjM4cLcRtcp/CrbrhiMgGcQ==
X-Received: by 2002:a05:600c:1c05:b0:401:c07f:72bd with SMTP id j5-20020a05600c1c0500b00401c07f72bdmr3721323wms.4.1693473003192;
        Thu, 31 Aug 2023 02:10:03 -0700 (PDT)
Received: from gerbillo.redhat.com (host-87-20-178-126.retail.telecomitalia.it. [87.20.178.126])
        by smtp.gmail.com with ESMTPSA id l9-20020a1c7909000000b003fe1c332810sm4527349wme.33.2023.08.31.02.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 02:10:02 -0700 (PDT)
Message-ID: <6b4733f4a5bedd465b7ee5ea435dcdaf12a61321.camel@redhat.com>
Subject: Re: [PATCH 1/4] net: dsa: Extend the dsa_switch structure to hold
 info about HSR ports
From:   Paolo Abeni <pabeni@redhat.com>
To:     Lukasz Majewski <lukma@denx.de>, Tristram.Ha@microchip.com,
        Eric Dumazet <edumazet@google.com>, davem@davemloft.net,
        Woojung Huh <woojung.huh@microchip.com>,
        Vladimir Oltean <olteanv@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>, UNGLinuxDriver@microchip.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 31 Aug 2023 11:10:00 +0200
In-Reply-To: <20230829121132.414335-2-lukma@denx.de>
References: <20230829121132.414335-1-lukma@denx.de>
         <20230829121132.414335-2-lukma@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-08-29 at 14:11 +0200, Lukasz Majewski wrote:
> Information about HSR aware ports in a DSA switch can be helpful when
> one needs tags to be adjusted before the HSR frame is sent.
>=20
> For example - with ksz9477 switch - the TAG needs to be adjusted to have
> both HSR ports marked in tag to allow execution of HW based frame
> duplication.
>=20
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
>  include/net/dsa.h | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/include/net/dsa.h b/include/net/dsa.h
> index d309ee7ed04b..15274afc42bb 100644
> --- a/include/net/dsa.h
> +++ b/include/net/dsa.h
> @@ -470,6 +470,9 @@ struct dsa_switch {
>  	/* Number of switch port queues */
>  	unsigned int		num_tx_queues;
> =20
> +	/* Bitmask indicating ports supporting HSR */
> +	u16                     hsr_ports;
> +
>  	/* Drivers that benefit from having an ID associated with each
>  	 * offloaded LAG should set this to the maximum number of
>  	 * supported IDs. DSA will then maintain a mapping of _at

Out of sheer ignorance, I think this new field does not belong to
dsa_switch, at least not in this form. AFAICS there is no current hard
limitation on the number of ports a DSA switch can handle at the API
level, and this will introduce an hard one.

I think you are better off keeping this field in the KSZ-specific
struct. If you really want to keep it here you should remove the above
limitation somehow (possibly a query op to check if a given port is HSR
aware???)

In any case this series looks like net-next material, does not apply
correctly to net-next and net-next is currently closed. You can share a
new version as RFC or wait for net-next to re-open in ~2w.

Cheers,

Paolo

