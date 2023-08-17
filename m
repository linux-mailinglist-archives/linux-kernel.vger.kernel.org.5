Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC1477FD14
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 19:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354028AbjHQRfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 13:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354085AbjHQRfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 13:35:36 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56BF30DC;
        Thu, 17 Aug 2023 10:35:34 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99c1c66876aso1060600066b.2;
        Thu, 17 Aug 2023 10:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692293733; x=1692898533;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ly1rBfcLX7OrWy82WU0OE8udrVilyauzH8m2SrfU1Tw=;
        b=MVYi/BIprTpRXf3fBxlNDFlBkS/OTr8XhykRnrFfSsTxr2eMI4ylqhW1sKye9S7GSB
         OHtCUa4JZec+blrkfpFKEKDGEkZXHabkV63cbmT3PwwgeQvJSCH//l6evQqo6gCgzaYy
         4rpPOY8eW3cfj/6NdgMEXjppQXBagn5rUAhK4omv/S/UkHzYbsg1rtQ/Vishw//bkV95
         t7KuhJJa1ZFuahB6FR+nHJu9pEzJqR3UpSiwzKDDrorgYUH/ipBRmPxeUerl8sXCREbd
         mE7NGRRWa5S12RIdYXZxFpTZp107B2grYEncDiV8GJe5EbfPHDXQgGMjbDr2dzXRloSl
         HyOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692293733; x=1692898533;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ly1rBfcLX7OrWy82WU0OE8udrVilyauzH8m2SrfU1Tw=;
        b=V381rrBKL+UpK8ZwKrPvZwsLMZ1GFRqypWTjmA+XuasnX2PDf6AlDuid/ALS16qc0V
         Jk35kgWK/1ip9uLoKSnLY1VqSbWvRvzM+ZzSXz4GLmc6K2Y6SSWDgkrRpETDNPKBXR+G
         Xt88ONGae/WnPn4HqUDYSJ8awPbxGbG6fArhKRntK6UxKb6bDyllcgs9HIR7gt5S3YZA
         GpgTo1KUxpaHdS2QqMr6SijxH7H5bf4qIbxWNRE94gZlL5FVWSIwbIOIpCYmaF2WddFy
         zAoY+nvcKLvWg4Vkg03EniMOd1WdXocEDrnBqbw0178ZTqQfe9DJaL+VlQ1g8F3T6jdw
         QUJw==
X-Gm-Message-State: AOJu0YxgFbDmLiq/800Ege3rSCKFmdTycp4qy1sJj0mOIt/iB9Lr1nwu
        wP9Ui/EjIlJ/BvHrhkzwBQrQG5k/ap3jXg==
X-Google-Smtp-Source: AGHT+IEhq8x7+uoxGjDn8gqXpggDfNvAt3Eq3w1306epMeQC2oI3coOCrBh0UFT/RbGxxlBzbj1jcw==
X-Received: by 2002:a17:906:189:b0:99c:f47a:2354 with SMTP id 9-20020a170906018900b0099cf47a2354mr75240ejb.70.1692293732949;
        Thu, 17 Aug 2023 10:35:32 -0700 (PDT)
Received: from skbuf ([188.25.231.206])
        by smtp.gmail.com with ESMTPSA id u16-20020a170906125000b0098e16f8c198sm7727eja.18.2023.08.17.10.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 10:35:32 -0700 (PDT)
Date:   Thu, 17 Aug 2023 20:35:29 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Alexis =?utf-8?Q?Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc:     =?utf-8?Q?Cl=C3=A9ment?= Leger <clement@clement-leger.fr>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH net-next v5 2/3] net: dsa: rzn1-a5psw: add support for
 .port_bridge_flags
Message-ID: <20230817173529.mmic4a7g5cgswnbf@skbuf>
References: <20230810093651.102509-1-alexis.lothore@bootlin.com>
 <20230810093651.102509-3-alexis.lothore@bootlin.com>
 <20230811100307.ocqkijjj5f6hi3q2@skbuf>
 <252cdb0b-3630-9e29-45a6-ea0474f0d983@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <252cdb0b-3630-9e29-45a6-ea0474f0d983@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexis,

On Fri, Aug 11, 2023 at 04:42:18PM +0200, Alexis Lothoré wrote:
> > These 3 port masks will only do what you expect while the bridge has
> > vlan_filtering=0, correct? When vlan_filtering=1, packets classified to
> > a VLAN which don't hit any FDB entry will be always flooded to all ports
> > in that VLAN, correct?
> 
> After thoroughly reading the A5PSW doc again, I feel that this sentence is not
> exactly true. If I refer to section 4.5.3.9, paragraph 3.c:
> 
> The VLAN table is used for both, VLAN domain verification [...] as well as VLAN
> resolution. Once the frame has passed any VLAN domain verification (i.e. will
> not be discarded by the verification function already), the forwarding
> resolution applies.
> [...]
> - If the destination MAC address (Unicast or Multicast) is not found in the MAC
> address table, or if the destination address is the Broadcast address, the frame
> is forwarded according to the following rules:
>   - The destination port mask is loaded from the respective register
> U/M/BCAST_DEFAULT_MASK depending on unicast, multicast or broadcast. Then the
> following filtering on this mask applies.
>     - If the frame carries a VLAN tag, the VLAN resolution table is searched for
> a matching VLAN ID and the frame is sent only to ports that are associated with
> the VLAN ID.
>     - If the frame carries a VLAN tag and the VLAN ID does not match any entry
> in the VLAN Resolution Table, or the frame does not carry a VLAN tag, the frame
> is forwarded to all ports that are enabled by the default mask.
>     - If it cannot be associated with any VLAN group and if the default group
> has been set to all zero, the frame is discarded.
> [...]
> 
> I understand from the second bullet that even when vlan filtering is enabled
> (which occurs as first step), the first flooding filter (used in second step,
> resolution) remains the flooding masks from unicast/multicast/broadcast default
> mask registers. The vlan resolution is then applied over it as a second filter,
> and only make the flooding more "restrictive", it does not bypass it (so if a
> port is in the vlan which VID is in an incoming packet but the port is not also
> defined in the U/M/B default mask, incoming packet won't be flooded to it).

Thanks for the clarification. In this case, the code is fine. I must have left
with the wrong impression from the previous discussion with Clément.
