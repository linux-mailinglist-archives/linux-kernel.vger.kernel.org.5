Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8067277A1A3
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 20:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjHLSH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 14:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjHLSHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 14:07:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10BFE10F2
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 11:07:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 94E1361D4B
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 18:07:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE47C433C8;
        Sat, 12 Aug 2023 18:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691863677;
        bh=k8+Etv3lthP2zsFFRvqPmbDklJ8wGU5W44zD9LwYLvg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=altZPXoc3wrnKWR2ZISCGj/6yaDR6vwwQanznoUvrOgul8PRSQGaDACmHGfCQ2QPA
         hiPey5DLPSx6tl4BPSlB3U9nW6zI5yOpimu1EE78H8HgezRFAZggAb2jhHn4AZPZ4r
         TbN21nuNuy3rIZk+iq9COUshy6vwwLLpfMU1r0I9GKuwnHL0aGtFJHwG/hTwnMaB+S
         cY13PVW9IAVviT6NO0YmJzOZaPefgM/cgswKSphKY2JgQeCSlrZGLx4sXfh4HOoUP/
         dyvHBB4Jt1UdMpScW5CUYLrBZ9Cx0EmaPIMF9tpPhAea+Rau8h4AkBPjW1PfLlNRoP
         Wgk3jUGGP898Q==
Date:   Sat, 12 Aug 2023 20:07:52 +0200
From:   Simon Horman <horms@kernel.org>
To:     "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com, sd@queasysnail.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next v1 4/5] net: macsec: introduce mdo_insert_tx_tag
Message-ID: <ZNfKeCGf0xZTTum7@vergenet.net>
References: <20230811153249.283984-1-radu-nicolae.pirea@oss.nxp.com>
 <20230811153249.283984-5-radu-nicolae.pirea@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811153249.283984-5-radu-nicolae.pirea@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 06:32:48PM +0300, Radu Pirea (NXP OSS) wrote:
> Offloading MACsec in PHYs requires inserting the SecTAG and the ICV in
> the ethernet frame. This operation will increase the frame size with 32
> bytes. If the frames are sent at line rate, the PHY will not have enough
> room to insert the SecTAG and the ICV.
> 
> To mitigate this scenario, the PHY offer to use require a specific
> ethertype with some padding bytes present in the ethernet frame. This
> ethertype and its associated bytes will be replaced by the SecTAG and ICV.
> 
> Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>

...

> diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c

...

> @@ -4137,6 +4211,11 @@ static int macsec_newlink(struct net *net, struct net_device *dev,
>  			if (err)
>  				goto del_dev;
>  		}
> +
> +		dev->needed_headroom -= MACSEC_NEEDED_HEADROOM;
> +		dev->needed_headroom += ops->needed_headroom;
> +		dev->needed_tailroom -= MACSEC_NEEDED_TAILROOM;
> +		dev->needed_tailroom += ops->needed_tailroom;

Hi Radu,

Just above the beginning of this hunk it is assumed that ops may be NULL.
However, here it is dereferenced unconditionally. Is this safe?

Flagged by Smatch.

>  	}
>  
>  	err = register_macsec_dev(real_dev, dev);
> diff --git a/include/net/macsec.h b/include/net/macsec.h
> index 33dc7f2aa42e..a988249d9608 100644
> --- a/include/net/macsec.h
> +++ b/include/net/macsec.h
> @@ -272,6 +272,7 @@ struct macsec_context {
>  		struct macsec_rx_sa_stats *rx_sa_stats;
>  		struct macsec_dev_stats  *dev_stats;
>  	} stats;
> +	struct sk_buff *skb;

Not strictly related to this patch,
but it would be nice to update the kernel doc for this
structure so that it's fields are documented.

>  };
>  
>  /**
> @@ -302,6 +303,10 @@ struct macsec_ops {
>  	int (*mdo_get_tx_sa_stats)(struct macsec_context *ctx);
>  	int (*mdo_get_rx_sc_stats)(struct macsec_context *ctx);
>  	int (*mdo_get_rx_sa_stats)(struct macsec_context *ctx);
> +	/* Offload tag */
> +	int (*mdo_insert_tx_tag)(struct macsec_context *ctx);
> +	int needed_headroom;
> +	int needed_tailroom;

Ditto.

>  };
>  
>  #if IS_ENABLED(CONFIG_MACSEC)
> -- 
> 2.34.1
> 
> 
