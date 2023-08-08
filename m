Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA7C773F36
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbjHHQoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232443AbjHHQni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:43:38 -0400
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F4C59C8
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:55:49 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-248-5m0yJHpmNG2Itb77j3EMGw-1; Tue, 08 Aug 2023 11:22:14 -0400
X-MC-Unique: 5m0yJHpmNG2Itb77j3EMGw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7EC3E3815EF1;
        Tue,  8 Aug 2023 15:22:13 +0000 (UTC)
Received: from hog (unknown [10.45.224.100])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5BB9540BC780;
        Tue,  8 Aug 2023 15:22:12 +0000 (UTC)
Date:   Tue, 8 Aug 2023 17:22:11 +0200
From:   Sabrina Dubroca <sd@queasysnail.net>
To:     "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: macsec: use TX SCI as MAC address
Message-ID: <ZNJdo6bow7uK8bTn@hog>
References: <20230808141429.220830-1-radu-nicolae.pirea@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230808141429.220830-1-radu-nicolae.pirea@oss.nxp.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2023-08-08, 17:14:29 +0300, Radu Pirea (NXP OSS) wrote:
> According to IEEE 802.1AE the SCI comprises the MAC address and the port
> identifier.

I don't think the SCI needs to be composed of the actual device's MAC
address. 8.2.1 says that the MAC address *can* be used to compose the
SCI, but doesn't mandate it.

If you want the SCI to match the device's MAC address, why not use
IFLA_MACSEC_PORT instead?

> If a new MACsec interface is created with a specific TX SCI, use that
> SCI to set the MAC address of the new interface.
> 
> Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
> ---
>  drivers/net/macsec.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
> index 984dfa5d6c11..6db69daf880d 100644
> --- a/drivers/net/macsec.c
> +++ b/drivers/net/macsec.c
> @@ -4103,12 +4103,14 @@ static int macsec_newlink(struct net *net, struct net_device *dev,
>  	/* need to be already registered so that ->init has run and
>  	 * the MAC addr is set
>  	 */
> -	if (data && data[IFLA_MACSEC_SCI])
> +	if (data && data[IFLA_MACSEC_SCI]) {
>  		sci = nla_get_sci(data[IFLA_MACSEC_SCI]);
> -	else if (data && data[IFLA_MACSEC_PORT])
> +		eth_hw_addr_set(dev, (u8 *)&sci);
> +	} else if (data && data[IFLA_MACSEC_PORT]) {
>  		sci = dev_to_sci(dev, nla_get_be16(data[IFLA_MACSEC_PORT]));
> -	else
> +	} else {
>  		sci = dev_to_sci(dev, MACSEC_PORT_ES);
> +	}
>  
>  	if (rx_handler && sci_exists(real_dev, sci)) {
>  		err = -EBUSY;
> -- 
> 2.34.1
> 

-- 
Sabrina

