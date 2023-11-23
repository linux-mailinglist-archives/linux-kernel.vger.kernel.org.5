Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB3F7F5CED
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 11:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344819AbjKWKxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 05:53:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235173AbjKWKw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 05:52:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93770D44
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 02:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700736782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IXLK87Gcm11x8erF5WfjVLPG8Viyp7jopv776YPzK/A=;
        b=WHIU/lqrDN2uFO5p8VJrsvGmoJssalBrowd3SDpGfmqXHvIKiJtkf6G3BrnoF6A77iHXVJ
        7lWuQ04qJWBKsExSr29BfXOjWROftee4X96HP5cRvCQlO0cPi0d/5PcjuzPWMZts7Np7qP
        hGPMmOxfqeE9bjLDJtNlb1oYyuj59MU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-WGCulVddNDOudz7RVy5NHQ-1; Thu, 23 Nov 2023 05:53:01 -0500
X-MC-Unique: WGCulVddNDOudz7RVy5NHQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a043b44aec3so12989466b.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 02:53:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700736780; x=1701341580;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IXLK87Gcm11x8erF5WfjVLPG8Viyp7jopv776YPzK/A=;
        b=goiFDlSIVWl89OccxCUwszTRZgzJbOvCwyxifBGYQ0VZ028POGumbgTzANm68/ozGJ
         9oD/gthE5SjvfFZXK4RIICE4N+Va3e9wSR/qaDMm4KRPs3y7/1WOTZH14moNwxEGgMmP
         mWQY1NNZ/elXr1xU4kBW+alf1AfLtWtBup+pTEOGqPVGpY2AzSdJSgaTogFxqjIR+GLl
         a6RJneX/J9o88hLdLHONME4Px/a14YgLFFRuIhi27jqEp9PGMI2hHYphK9Iij9eKIaKI
         uUQyG2c6br/KJyuXI52kTPLMAnlWIUiiyOjKjgj9Mi9oAu00J1OdQ5UTl8OSycLxrq5O
         2P7Q==
X-Gm-Message-State: AOJu0YxnGPT+Ky3/FF8GbVrgO5W1hwolCeZWkhUQImj1ztX60Jmb+rbm
        nMftQsv22R1yUOlM7+AwRHYU21sUyXwhvDUL2Q/Vka/BJ/fXik6ZJRRvLtlHhLizaAtAXmiy7eR
        7w/oDWZIyP1Oe5Lng6Kg3eGHW
X-Received: by 2002:a05:6402:2903:b0:542:1ba5:68a4 with SMTP id ee3-20020a056402290300b005421ba568a4mr3475971edb.1.1700736779875;
        Thu, 23 Nov 2023 02:52:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IERO/BGFULCn5Fi994nJ7tXuKoWwNihWZNkcH2ht0W/yvXlyDrzAOT0VxqvY3IMW2y+Rxph7A==
X-Received: by 2002:a05:6402:2903:b0:542:1ba5:68a4 with SMTP id ee3-20020a056402290300b005421ba568a4mr3475958edb.1.1700736779528;
        Thu, 23 Nov 2023 02:52:59 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-241-213.dyn.eolo.it. [146.241.241.213])
        by smtp.gmail.com with ESMTPSA id k7-20020aa7c047000000b0053de19620b9sm511862edo.2.2023.11.23.02.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 02:52:59 -0800 (PST)
Message-ID: <35045f6ef6a5b274063186c065a8215088b94cd5.camel@redhat.com>
Subject: Re: [PATCH net-next v1 3/3] net: dsa: microchip: Fix PHY loopback
 configuration for KSZ8794 and KSZ8873
From:   Paolo Abeni <pabeni@redhat.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Vladimir Oltean <olteanv@gmail.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Arun Ramadoss <arun.ramadoss@microchip.com>
Cc:     kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, UNGLinuxDriver@microchip.com
Date:   Thu, 23 Nov 2023 11:52:57 +0100
In-Reply-To: <20231121152426.4188456-3-o.rempel@pengutronix.de>
References: <20231121152426.4188456-1-o.rempel@pengutronix.de>
         <20231121152426.4188456-3-o.rempel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 2023-11-21 at 16:24 +0100, Oleksij Rempel wrote:
> Correct the PHY loopback bit handling in the ksz8_w_phy_bmcr and
> ksz8_r_phy_bmcr functions for KSZ8794 and KSZ8873 variants in the ksz8795
> driver. Previously, the code erroneously used Bit 7 of port register 0xD
> for both chip variants, which is actually for LED configuration. This
> update ensures the correct registers and bits are used for the PHY
> loopback feature:
>=20
> - For KSZ8794: Use 0xF / Bit 7.
> - For KSZ8873: Use 0xD / Bit 0.
>=20
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

This looks like a bugfix, so possibly worth a Fixes tag? Given the
dependency on the previous refactor, I think we can take it via net-
next.

@Andrew, Florian, Vladimir: do you have any specific preference here?

Thanks!

Paolo

