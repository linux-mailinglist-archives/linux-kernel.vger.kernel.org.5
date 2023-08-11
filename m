Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56BA3779658
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 19:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236884AbjHKRmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 13:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236865AbjHKRm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 13:42:29 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE938A8;
        Fri, 11 Aug 2023 10:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=XZde7I6ZCr5bOJRRVTdK4m++TLOgYH3d4jly0N/+708=; b=iq39bwOXdnWzTfOxalyj5f8aIF
        NaUeiJ5RPqJ9+go6Zi8QLT+oYbh3UVnyAqHvKIE2mWA2ugPCoYleHYKgMgUKaAxSTyHsp01DEUUCd
        uAISs/9qClSjx8ZI4gVA/5tU6Y41+zS3Tm9XCP8rJAkdNgg41gKhxdUASeu/irAqyh4c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qUW9O-003paE-E4; Fri, 11 Aug 2023 19:42:14 +0200
Date:   Fri, 11 Aug 2023 19:42:14 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Cc:     hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        richardcochran@gmail.com, sd@queasysnail.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next v1 4/5] net: macsec: introduce mdo_insert_tx_tag
Message-ID: <ee545162-7695-4089-804d-64438e1de620@lunn.ch>
References: <20230811153249.283984-1-radu-nicolae.pirea@oss.nxp.com>
 <20230811153249.283984-5-radu-nicolae.pirea@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811153249.283984-5-radu-nicolae.pirea@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

I think this could be worded better, to take into account different
implementations. As far as i understand, some PHYs include a MAC,
which reassembles the frame, and then places the frame into a queue
for processing. After processing, a second MAC does the actual send on
the wire. The queue allows for some number of back to back frames
without having problems. The PHY then uses flow control pause to slow
down the SoC MAC when there is a long burst of line rate frames which
would otherwise overflow the queue.

So:

> If the frames are sent at line rate, the PHY will not have enough
> room to insert the SecTAG and the ICV.

This probably want to clarify that a PHY which does not buffer....

> To mitigate this scenario, the PHY offer to use require a specific

and here you want to say some PHYs offer, since not all PHYs will do
this.

> +	if (macsec->offload == MACSEC_OFFLOAD_OFF) {
> +		dev->needed_headroom -= ops->needed_headroom;
> +		dev->needed_headroom += MACSEC_NEEDED_HEADROOM;
> +		dev->needed_tailroom -= ops->needed_tailroom;
> +		dev->needed_tailroom += MACSEC_NEEDED_TAILROOM;
> +	} else {
> +		dev->needed_headroom -= MACSEC_NEEDED_HEADROOM;
> +		dev->needed_headroom += ops->needed_headroom;
> +		dev->needed_tailroom -= MACSEC_NEEDED_TAILROOM;
> +		dev->needed_tailroom += ops->needed_tailroom;
> +	}

It is not obvious to me what this is doing. Should this actually be in
macsec_dev_init()? My main problem is why there is an else condition?

> +static struct sk_buff *insert_tx_tag(struct sk_buff *skb,
> +				     struct net_device *dev)
> +{
> +	struct macsec_dev *macsec = macsec_priv(dev);
> +	const struct macsec_ops *ops;
> +	struct macsec_context ctx;
> +	int err;
> +
> +	if (!macsec_is_offloaded(macsec))
> +		return ERR_PTR(-EINVAL);

Hasn't this already been checked in macsec_start_xmit()?

> +
> +	ops = macsec_get_ops(macsec, &ctx);
> +	if (!ops)
> +		return ERR_PTR(-EINVAL);
> +
> +	if (!ops->mdo_insert_tx_tag)
> +		return skb;

You are in the hot path here. You don't expect this to change from
frame to frame. So could you evaluate this once and store it
somewhere? Maybe in macsec_dev ?

	Andrew
