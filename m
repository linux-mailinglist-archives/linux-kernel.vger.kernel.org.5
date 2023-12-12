Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E91C80E7D6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 10:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346042AbjLLJgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 04:36:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbjLLJgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 04:36:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F8FE4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 01:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702373781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ulgkJkr2BclVGQijX69+Fcom9572Ad68+KiNZiUrm/4=;
        b=UjeH5HZ1xjmHSat+vpF/hNmr3l0plQpjbNQKSL5zHeiqzLUhc8XmmynY6hACmxqgmP5NWm
        i2k7FM+bZQLLTlLqGnGdc5hEqrP/ybW9QlM+UFy36QW+Jribnp1bjiTP04/RPibQMfo6tV
        tNFqFHrb6Obh37zKeFaeLWe3JKIL2bw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-bF6hmyS8ONKd8FfeXblpvQ-1; Tue, 12 Dec 2023 04:36:19 -0500
X-MC-Unique: bF6hmyS8ONKd8FfeXblpvQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a1df644f6a8so88629466b.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 01:36:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702373778; x=1702978578;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ulgkJkr2BclVGQijX69+Fcom9572Ad68+KiNZiUrm/4=;
        b=UAJSmzqs0Lqp96udcn/HIvefWuMssD0tJZhqBEaWPOWTOpfs9+kRl6ASCT1hRQ6xXw
         9xF0g778dztWwQ1AdRwNeebsMhKLIZn+MeZ5Hr8gSser7/5H0ZiYqY8VbZl/HXAMU6B3
         yPzGf3iXxq1ZhkLo8SHE2HAXEm4kMZm5c2X5hNWV6ko3t5o6bSSxtlGhJIJdRDijrPQ/
         IQ3Q6mTDlaJGNbq5HGdUO/W+U+nLFV3o/ksjGhDWKHG9y+zalJDQi70fSGrk9UwkAJBL
         c8CtgMoLMrZ0irxZA2x/AnAfQDfp2wKCzDcgQXnQLYZUC9vhFx5AjhJtSkYj5JnEECpX
         unug==
X-Gm-Message-State: AOJu0Yxe1X4XIHxenWPlYTpFxeIfK5ydQLfI/Ot3rWJJ8THjsd/3g0v3
        5S/3vPXjL0LiAlktGAiPrBNY/lbbHwFhKgQ69jguFFsHREq8ja2BjDRb7NVvlHO81O6AfjJMecN
        cmJE0nd0lohiZBgmjL95RpIOY1OLaXVs7
X-Received: by 2002:a17:907:c312:b0:a01:ae7b:d19b with SMTP id tl18-20020a170907c31200b00a01ae7bd19bmr6789060ejc.7.1702373778334;
        Tue, 12 Dec 2023 01:36:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGbuVLhoXZUdea1M2y0EVwc4fJ8d5/0C1C7ra1R7UrRKoLwIRKUzJcxxASM0USMbsrFs/Q4+Q==
X-Received: by 2002:a17:907:c312:b0:a01:ae7b:d19b with SMTP id tl18-20020a170907c31200b00a01ae7bd19bmr6789042ejc.7.1702373777970;
        Tue, 12 Dec 2023 01:36:17 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-249-182.dyn.eolo.it. [146.241.249.182])
        by smtp.gmail.com with ESMTPSA id h7-20020a170906530700b00a1b32663d7csm5987635ejo.102.2023.12.12.01.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 01:36:17 -0800 (PST)
Message-ID: <0d8195d3c1aaec85e74d7ae2bf5b1a5b9c1a0b78.camel@redhat.com>
Subject: Re: [PATCH net-next v14 01/13] rtase: Add pci table supported in
 this module
From:   Paolo Abeni <pabeni@redhat.com>
To:     Justin Lai <justinlai0215@realtek.com>, kuba@kernel.org
Cc:     davem@davemloft.net, edumazet@google.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        andrew@lunn.ch, pkshih@realtek.com, larry.chiu@realtek.com
Date:   Tue, 12 Dec 2023 10:36:16 +0100
In-Reply-To: <20231208094733.1671296-2-justinlai0215@realtek.com>
References: <20231208094733.1671296-1-justinlai0215@realtek.com>
         <20231208094733.1671296-2-justinlai0215@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-12-08 at 17:47 +0800, Justin Lai wrote:
[...]
> +static void rtase_remove_one(struct pci_dev *pdev)
> +{
> +	struct net_device *dev =3D pci_get_drvdata(pdev);
> +	struct rtase_private *tp =3D netdev_priv(dev);
> +	struct rtase_int_vector *ivec;
> +	u32 i;
> +
> +	for (i =3D 0; i < tp->int_nums; i++) {
> +		ivec =3D &tp->int_vector[i];
> +		netif_napi_del(&ivec->napi);
> +	}

You must unregister the netdev before napi_del or you will risk races.

Cheers,

Paolo

