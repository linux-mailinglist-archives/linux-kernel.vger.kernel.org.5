Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F4C7D10BB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 15:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377376AbjJTNp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 09:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377372AbjJTNpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 09:45:53 -0400
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C387E1BF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 06:45:50 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-692-GTqKNN5rMLCOyLdXtv-uwQ-1; Fri, 20 Oct 2023 09:45:34 -0400
X-MC-Unique: GTqKNN5rMLCOyLdXtv-uwQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 97F11102020A;
        Fri, 20 Oct 2023 13:45:29 +0000 (UTC)
Received: from hog (unknown [10.39.192.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DEF032026D4C;
        Fri, 20 Oct 2023 13:45:27 +0000 (UTC)
Date:   Fri, 20 Oct 2023 15:45:26 +0200
From:   Sabrina Dubroca <sd@queasysnail.net>
To:     "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, andrew@lunn.ch, hkallweit1@gmail.com,
        linux@armlinux.org.uk, richardcochran@gmail.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        sebastian.tobuschat@oss.nxp.com
Subject: Re: [PATCH net-next v7 3/7] net: macsec: revert the MAC address if
 mdo_upd_secy fails
Message-ID: <ZTKEdvpNl-gwGpk6@hog>
References: <20231019120209.290480-1-radu-nicolae.pirea@oss.nxp.com>
 <20231019120209.290480-4-radu-nicolae.pirea@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231019120209.290480-4-radu-nicolae.pirea@oss.nxp.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2023-10-19, 15:02:05 +0300, Radu Pirea (NXP OSS) wrote:
>  	/* If h/w offloading is available, propagate to the device */
> -	if (macsec_is_offloaded(macsec)) {
> +	if (offloaded) {
>  		const struct macsec_ops *ops;
>  		struct macsec_context ctx;
>  
>  		ops = macsec_get_ops(macsec, &ctx);
> -		if (ops) {
> -			ctx.secy = &macsec->secy;
> -			macsec_offload(ops->mdo_upd_secy, &ctx);
> +		if (!ops) {
> +			err = -EINVAL;

For consistency with other places where macsec_get_ops fails, this
should probably be -EOPNOTSUPP.

I'm not opposed to this change, but I'm not sure how it's related to
the missing rollback issue. Can you explain that a bit?

> +			goto restore_old_addr;
>  		}
> +
> +		ctx.secy = &macsec->secy;
> +		err = macsec_offload(ops->mdo_upd_secy, &ctx);
> +		if (err)
> +			goto restore_old_addr;
>  	}
>  
>  	return 0;
> +
> +restore_old_addr:
> +	if (dev->flags & IFF_UP) {
> +		int err;

[This bit confused me quite a bit, seeing the declaration and the
"return err" out of this block]

> +		err = macsec_dev_uc_update(dev, old_addr);
> +		if (err)
> +			return err;

If we can avoid it, we should try to have a rollback path without any
possible failures, otherwise we'll leave things in a broken state (in
this case, telling the user that the MAC address change failed, but
leaving the new address set on the macsec device).

Paolo suggested to postpone the dev_uc_del until after the offload
code, so we'd end up with something like this [completely untested]:


	if (dev->flags & IFF_UP) {
		err = dev_uc_add(real_dev, addr->sa_data);
		if (err < 0)
			return err;
	}

	ether_addr_copy(old_addr, dev->dev_addr);
	eth_hw_addr_set(dev, addr->sa_data);

	/* If h/w offloading is available, propagate to the device */
	if (macsec_is_offloaded(macsec)) {
		// ...
	}

	if (dev->flags & IFF_UP)
		dev_uc_del(real_dev, old_addr);

	return 0;

restore_old_addr:
	if (dev->flags & IFF_UP)
		dev_uc_del(real_dev, addr->sa_data);

	eth_hw_addr_set(dev, old_addr);

	return err;


Install both UC addresses, then remove the one we don't need.


-- 
Sabrina

