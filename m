Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5085A79279D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239225AbjIEQHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354255AbjIEKWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 06:22:49 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A611AB;
        Tue,  5 Sep 2023 03:22:43 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-99c1d03e124so323051166b.2;
        Tue, 05 Sep 2023 03:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693909362; x=1694514162; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OAZ9jRe0bzAzd6VhG2nCrvonILXtr+sxGi5FjeeHfTA=;
        b=d4EKutAZafHvZi+ds5DVcldWFK1eaq2LOaCWMBb2Mi+r8159G3Er7wA5+RxsSQMk0C
         u+uej6DMjadhW208pISpcE41F3VhHS2uwwt8jO38Dx8aKbQir3I8nbwNeBzU4aH74lgI
         RgyT09IplaZnndvhhzmaTqdHASmhdmowywD+9DIJvzFRgih75BAfk1OBpl4DEko9K/qM
         1wJ9OPQmHO3djrKqPW8f8b4o34gZq12Pfsw11+y/j59/On1rUS6g6u7oSnQMy3s2t/E4
         75w1uOiHOlrV0vhd7dmtf+dnvK5tx7W9RkeHXBNv3YcPmbeDn+APaY7WvhFSf++Xcc7k
         gDrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693909362; x=1694514162;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OAZ9jRe0bzAzd6VhG2nCrvonILXtr+sxGi5FjeeHfTA=;
        b=FQAlyjLzlxFJQLmRNggd8FRJ30pOpasPFPV5+634a8c4BQmFXHOeQecVd3gRSRIgmr
         JxPK0Sy0DTcTg/kOn05Gh4ys+mYpetVUZHlm0hhQlLIAAD2+ngqvWVEY21UYUsiJucrZ
         iRDlDmOnWBZzAtY0qbjXtCwfLw519Q6qtffme0VxyTyopac2l5eO6i+m4fW1Tw9WhGUI
         xm2T2atC/cmg+0UAEQ39WoshWKtRjVM7r+ft8E2ZWW6brnShd+0gj8D0Uc91AB9kIx8+
         l0L5oFH0YoFQk+3xQAE/LN0vqVgj4NSHejFnYfhQ/QMRoMWPABEHKK0nWXD+8pCDOrpF
         l6UA==
X-Gm-Message-State: AOJu0YwOWy3CHKp2MXDSGUh8ipm+yibzsw1FN4FnX9IqWRDS5m7i0nBI
        vJr5FUYvQ/kDUjP5LqDlhGw=
X-Google-Smtp-Source: AGHT+IET9073GaNYuPveg/+7AZNtR5MZ5kiO9Cb1gts1cAcPYc/CWRlrpfRllzGw2MLnKt6Xv3CO+A==
X-Received: by 2002:a17:907:762b:b0:9a1:e8c0:7e30 with SMTP id jy11-20020a170907762b00b009a1e8c07e30mr8401825ejc.7.1693909361991;
        Tue, 05 Sep 2023 03:22:41 -0700 (PDT)
Received: from skbuf ([188.26.57.165])
        by smtp.gmail.com with ESMTPSA id s14-20020a17090699ce00b0099bccb03eadsm7297200ejn.205.2023.09.05.03.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 03:22:41 -0700 (PDT)
Date:   Tue, 5 Sep 2023 13:22:39 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew@lunn.ch>,
        davem@davemloft.net, Paolo Abeni <pabeni@redhat.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Tristram.Ha@microchip.com, Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>, UNGLinuxDriver@microchip.com,
        George McCollister <george.mccollister@gmail.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 RFC 2/4] net: dsa: Extend ksz9477 TAG setup to support
 HSR frames duplication
Message-ID: <20230905102239.mkufbzxwrvuatlrb@skbuf>
References: <20230904120209.741207-1-lukma@denx.de>
 <20230904120209.741207-3-lukma@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230904120209.741207-3-lukma@denx.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2023 at 02:02:07PM +0200, Lukasz Majewski wrote:
> The KSZ9477 has support for HSR (High-Availability Seamless Redundancy).
> One of its offloading (i.e. performed in the switch IC hardware) features
> is to duplicate received frame to both HSR aware switch ports.
> 
> To achieve this goal - the tail TAG needs to be modified. To be more
> specific, both ports must be marked as destination (egress) ones.
> 
> Moreover, according to AN3474 application note, the lookup bit (10)
> should not be set in the tail tag.
> 
> Last but not least - the NETIF_F_HW_HSR_DUP flag indicates that the device
> supports HSR and assures (in HSR core code) that frame is sent only once
> from HOST to switch with tail tag indicating both ports.
> 
> Information about bits to be set in tag is provided via KSZ generic
> ksz_hsr_get_ports() function.
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
> Changes for v2:
> - Use ksz_hsr_get_ports() to obtain the bits values corresponding to
>   HSR aware ports
> 
> Changes for v3:
> - None
> ---
>  drivers/net/dsa/microchip/ksz_common.c | 12 ++++++++++++
>  include/linux/dsa/ksz_common.h         |  1 +
>  net/dsa/tag_ksz.c                      |  5 +++++
>  3 files changed, 18 insertions(+)
> 
> diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
> index d9d843efd111..579fde54d1e1 100644
> --- a/drivers/net/dsa/microchip/ksz_common.c
> +++ b/drivers/net/dsa/microchip/ksz_common.c
> @@ -3421,6 +3421,18 @@ static int ksz_setup_tc(struct dsa_switch *ds, int port,
>  	}
>  }
>  
> +u16 ksz_hsr_get_ports(struct dsa_switch *ds)
> +{
> +	struct ksz_device *dev = ds->priv;
> +
> +	switch (dev->chip_id) {
> +	case KSZ9477_CHIP_ID:
> +		return dev->hsr_ports;
> +	}
> +
> +	return 0;
> +}

When CONFIG_NET_DSA_MICROCHIP_KSZ_COMMON=m:

ld.lld: error: undefined symbol: ksz_hsr_get_ports
referenced by tag_ksz.c:298 (/opt/net-next/output-arm64-clang/../net/dsa/tag_ksz.c:298)
              net/dsa/tag_ksz.o:(ksz9477_xmit) in archive vmlinux.a

But before you rush to add EXPORT_SYMBOL_GPL(ksz_hsr_get_ports), be aware
that due to DSA's design, tag_ksz.ko and ksz_common.ko cannot have any
symbol dependency on each other, and if you do that, you will break
module auto-loading. More information here, there were also patches that
removed those dependencies for other tagger/switch driver pairs:
https://lore.kernel.org/netdev/20210908220834.d7gmtnwrorhharna@skbuf/

Not to mention that there are other problems with the "dev->hsr_ports"
concept. For example, having a hsr0 over lan0 and lan1, and a hsr1 over
lan2 and lan3, would set dev->hsr_ports to GENMASK(3, 0). But you want
an xmit coming from hsr0 to get sent only to GENMASK(1, 0), and an xmit
from hsr1 only to GENMASK(3, 2).

In this particular case, the best option seems to be to delete ksz_hsr_get_ports().

> +
>  static const struct dsa_switch_ops ksz_switch_ops = {
>  	.get_tag_protocol	= ksz_get_tag_protocol,
>  	.connect_tag_protocol   = ksz_connect_tag_protocol,
> diff --git a/include/linux/dsa/ksz_common.h b/include/linux/dsa/ksz_common.h
> index 576a99ca698d..fa3d9b0f3a72 100644
> --- a/include/linux/dsa/ksz_common.h
> +++ b/include/linux/dsa/ksz_common.h
> @@ -50,4 +50,5 @@ ksz_tagger_data(struct dsa_switch *ds)
>  	return ds->tagger_data;
>  }
>  
> +u16 ksz_hsr_get_ports(struct dsa_switch *ds);
>  #endif /* _NET_DSA_KSZ_COMMON_H_ */
> diff --git a/net/dsa/tag_ksz.c b/net/dsa/tag_ksz.c
> index ea100bd25939..903db95c37ee 100644
> --- a/net/dsa/tag_ksz.c
> +++ b/net/dsa/tag_ksz.c
> @@ -293,6 +293,11 @@ static struct sk_buff *ksz9477_xmit(struct sk_buff *skb,
>  	if (is_link_local_ether_addr(hdr->h_dest))
>  		val |= KSZ9477_TAIL_TAG_OVERRIDE;
>  
> +	if (dev->features & NETIF_F_HW_HSR_DUP) {
> +		val &= ~KSZ9477_TAIL_TAG_LOOKUP;

No need to unset a bit which was never set.

> +		val |= ksz_hsr_get_ports(dp->ds);
> +	}

Would this work instead?

	struct net_device *hsr_dev = dp->hsr_dev;
	struct dsa_port *other_dp;

	dsa_hsr_foreach_port(other_dp, dp->ds, hsr_dev)
		val |= BIT(other_dp->index);

> +
>  	*tag = cpu_to_be16(val);
>  
>  	return ksz_defer_xmit(dp, skb);
> -- 
> 2.20.1
> 
