Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6FD78728E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 16:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241860AbjHXOzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 10:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241895AbjHXOyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 10:54:47 -0400
Received: from us-smtp-delivery-44.mimecast.com (unknown [207.211.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5929319AD
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 07:54:45 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-435-q68lpTtWO1akSMByFYQSCA-1; Thu, 24 Aug 2023 10:54:26 -0400
X-MC-Unique: q68lpTtWO1akSMByFYQSCA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0D7791C08986;
        Thu, 24 Aug 2023 14:54:25 +0000 (UTC)
Received: from hog (unknown [10.39.192.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6EFA1492C18;
        Thu, 24 Aug 2023 14:54:23 +0000 (UTC)
Date:   Thu, 24 Aug 2023 16:54:22 +0200
From:   Sabrina Dubroca <sd@queasysnail.net>
To:     "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com,
        sebastian.tobuschat@nxp.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next v2 2/5] net: macsec: introduce mdo_insert_tx_tag
Message-ID: <ZOduuY6cfXbgv_L3@hog>
References: <20230824091615.191379-1-radu-nicolae.pirea@oss.nxp.com>
 <20230824091615.191379-3-radu-nicolae.pirea@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230824091615.191379-3-radu-nicolae.pirea@oss.nxp.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2023-08-24, 12:16:12 +0300, Radu Pirea (NXP OSS) wrote:
> Offloading MACsec in PHYs requires inserting the SecTAG and the ICV in
> the ethernet frame. This operation will increase the frame size with up
> to 32 bytes. If the frames are sent at line rate, the PHY will not have
> enough room to insert the SecTAG and the ICV.
> 
> Some PHYs use a hardware buffer to store a number of ethernet frames and,
> if it fills up, a pause frame is sent to the MAC to control the flow.
> This HW implementation does not need any modification in the stack.
> 
> Other PHYs might offer to use a specific ethertype with some padding
> bytes present in the ethernet frame. This ethertype and its associated
> bytes will be replaced by the SecTAG and ICV.
> 
> mdo_insert_tx_tag allows the PHY drivers to add any specific tag in the
> skb.

Please add a per-patch changelog between versions. For example:

v2:
 - add doc for the new fields in macsec_ops
 - add insert_tx_tag to macsec_dev
 - use unsigned int for macsec_ops.needed_{head,tail}room
[etc]

> Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
> ---
>  drivers/net/macsec.c | 96 +++++++++++++++++++++++++++++++++++++++++++-
>  include/net/macsec.h | 10 +++++
>  2 files changed, 105 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
> index ae60817ec5c2..5541aaced61f 100644
> --- a/drivers/net/macsec.c
> +++ b/drivers/net/macsec.c
> @@ -93,6 +93,7 @@ struct pcpu_secy_stats {
>   * @secys: linked list of SecY's on the underlying device
>   * @gro_cells: pointer to the Generic Receive Offload cell
>   * @offload: status of offloading on the MACsec device
> + * @insert_tx_tag: insert tx tag if true

(probably a bit nitpicky)
Maybe briefly mention something about offloading and why devices might
needed that tag? Otherwise this doc feels a bit like it's there just
to make a checker happy, it doesn't say anything that "bool
insert_tx_tag" doesn't already tell us.

Maybe something like:
"when offloading, device requires to insert an additional tag"

>   */
>  struct macsec_dev {
>  	struct macsec_secy secy;
> @@ -102,6 +103,7 @@ struct macsec_dev {
>  	struct list_head secys;
>  	struct gro_cells gro_cells;
>  	enum macsec_offload offload;
> +	bool insert_tx_tag;
>  };
>  
>  /**
> @@ -2582,6 +2584,33 @@ static bool macsec_is_configured(struct macsec_dev *macsec)
>  	return false;
>  }
>  
> +static bool macsec_can_insert_tx_tag(struct macsec_dev *macsec,

It feels more like a "needs" than a "can" situation to me. The device
needs this tag inserted in order to fully work.

> +				     const struct macsec_ops *ops)
> +{
> +	return macsec->offload == MACSEC_OFFLOAD_PHY &&
> +		ops->mdo_insert_tx_tag;
> +}
> +
> +static void macsec_adjust_room(struct net_device *dev,
> +			       const struct macsec_ops *ops)
> +{
> +	struct macsec_dev *macsec = macsec = macsec_priv(dev);

duplicate "macsec = macsec = ..."

> +
> +	if (macsec_is_offloaded(macsec)) {

Shouldn't that whole adjustment (in both directions) depend on
->insert_tx_tag?

> +		dev->needed_headroom -= MACSEC_NEEDED_HEADROOM;
> +		dev->needed_headroom += ops->needed_headroom;

I would compute "diff = ops->needed_headroom - MACSEC_NEEDED_HEADROOM"
at the start and then we can simply do "+= diff" or "-= diff" (and
same for tailroom).

> +		dev->needed_tailroom -= MACSEC_NEEDED_TAILROOM;
> +		dev->needed_tailroom += ops->needed_tailroom;
> +
> +		return;
> +	}

nit: else instead of the early return would make things more
symmetrical.

> +
> +	dev->needed_headroom -= ops->needed_headroom;
> +	dev->needed_headroom += MACSEC_NEEDED_HEADROOM;
> +	dev->needed_tailroom -= ops->needed_tailroom;
> +	dev->needed_tailroom += MACSEC_NEEDED_TAILROOM;
> +}
> +
>  static int macsec_update_offload(struct net_device *dev, enum macsec_offload offload)
>  {
>  	enum macsec_offload prev_offload;
> @@ -2619,9 +2648,15 @@ static int macsec_update_offload(struct net_device *dev, enum macsec_offload off
>  	ctx.secy = &macsec->secy;
>  	ret = offload == MACSEC_OFFLOAD_OFF ? macsec_offload(ops->mdo_del_secy, &ctx)
>  					    : macsec_offload(ops->mdo_add_secy, &ctx);
> -	if (ret)
> +	if (ret) {
>  		macsec->offload = prev_offload;
> +		goto out;

I would prefer a direct return right here instead of this goto.

> +	}
> +
> +	macsec_adjust_room(dev, ops);
> +	macsec->insert_tx_tag = macsec_can_insert_tx_tag(macsec, ops);
>  
> +out:
>  	return ret;
>  }
>  
> @@ -3378,6 +3413,55 @@ static struct genl_family macsec_fam __ro_after_init = {
>  	.resv_start_op	= MACSEC_CMD_UPD_OFFLOAD + 1,
>  };
>  
> +static struct sk_buff *insert_tx_tag(struct sk_buff *skb,
> +				     struct net_device *dev)
> +{
> +	struct macsec_dev *macsec = macsec_priv(dev);
> +	const struct macsec_ops *ops;
> +	struct phy_device *phydev;
> +	struct macsec_context ctx;
> +	int err;
> +
> +	if (!macsec->insert_tx_tag)
> +		return skb;

I think it would look a bit nicer if this test was moved out, before
calling insert_tx_tag(). Then if we call insert_tx_tag(), we know we
have to insert it.

> +	ops = macsec_get_ops(macsec, &ctx);
> +	phydev = macsec->real_dev->phydev;
> +

[...]
> @@ -4125,6 +4216,9 @@ static int macsec_newlink(struct net *net, struct net_device *dev,
>  			err = macsec_offload(ops->mdo_add_secy, &ctx);
>  			if (err)
>  				goto del_dev;
> +
> +			macsec_adjust_room(dev, ops);
> +			macsec->insert_tx_tag = macsec_can_insert_tx_tag(macsec, ops);
>  		}
>  	}
>  
> diff --git a/include/net/macsec.h b/include/net/macsec.h
> index 76f024727bb4..9577921897f9 100644
> --- a/include/net/macsec.h
> +++ b/include/net/macsec.h
> @@ -312,6 +312,11 @@ struct macsec_context {
>   * @mdo_get_tx_sa_stats: called when TX SA stats are read
>   * @mdo_get_rx_sc_stats: called when RX SC stats are read
>   * @mdo_get_rx_sa_stats: called when RX SA stats are read
> + * @mdo_insert_tx_tag: called to insert the TX offload tag
> + * @needed_headroom: number of bytes reserved at the beginning of the sk_buff
> + *	for the TX Tag
> + * @needed_tailroom: number of bytes reserved at the end of the sk_buff for the
> + *	TX Tag

It would be nice to use a consistent name (either "TX offload tag" or
"TX tag") and case in those 3 descriptions (slight preference for
"tag" over "Tag" on my side).

I'd also add ", to be filled by mdo_insert_tx_tag" (not sure whether
that needs to be @mdo_insert_tx_tag or just mdo_insert_tx_tag) to the
needed_headroom/needed_tailroom descriptions, just to be really clear.

-- 
Sabrina

