Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF89C7A9E5D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbjIUUA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbjIUT7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:59:55 -0400
Received: from us-smtp-delivery-44.mimecast.com (unknown [207.211.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A4937BE0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:24:58 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-314-OaVbmCMZP7yeyxSGinlawg-1; Thu, 21 Sep 2023 11:11:45 -0400
X-MC-Unique: OaVbmCMZP7yeyxSGinlawg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4978018172CA;
        Thu, 21 Sep 2023 15:11:44 +0000 (UTC)
Received: from hog (unknown [10.39.192.47])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 935BF492C37;
        Thu, 21 Sep 2023 15:11:42 +0000 (UTC)
Date:   Thu, 21 Sep 2023 17:11:41 +0200
From:   Sabrina Dubroca <sd@queasysnail.net>
To:     "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com,
        sebastian.tobuschat@oss.nxp.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 3/7] net: macsec: indicate next pn update
 when offloading
Message-ID: <ZQxdLZJa0EpnxpCl@hog>
References: <20230920092237.121033-1-radu-nicolae.pirea@oss.nxp.com>
 <20230920092237.121033-4-radu-nicolae.pirea@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230920092237.121033-4-radu-nicolae.pirea@oss.nxp.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_VALIDITY_RPBL,RDNS_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2023-09-20, 12:22:33 +0300, Radu Pirea (NXP OSS) wrote:
> Indicate next PN update using update_pn flag in macsec_context.
> Offloaded MACsec implementations does not know whether or not the
> MACSEC_SA_ATTR_PN attribute was passed for an SA update and assume
> that next PN should always updated, but this is not always true.

This should probably go through net so that we can fix some drivers
that are currently doing the wrong thing. octeontx2 should be
fixable. atlantic looks like it would reset the PN to whatever was
read during the last dump, and it's unclear if that can be fixed
(AFAIU set_egress_sa_record writes the whole config at once).  mscc
doesn't seem to modify the PN (even if requested -- should it should
reject the update), and mlx5 doesn't allow PN update (by storing the
initial value of next_pn on SA creation).

> diff --git a/include/net/macsec.h b/include/net/macsec.h
> index ecae5eeb021a..42072fdcc183 100644
> --- a/include/net/macsec.h
> +++ b/include/net/macsec.h
> @@ -254,6 +254,7 @@ struct macsec_secy {
>   * @offload: MACsec offload status
>   * @secy: pointer to a MACsec SecY
>   * @rx_sc: pointer to a RX SC
> + * @update_pn: this flag indicates updating the next PN when updating the SA

nit: "this flag indicates" is not very useful, thus:

@update_pn: when updating the SA, update the next PN

>   * @assoc_num: association number of the target SA
>   * @key: key of the target SA
>   * @rx_sa: pointer to an RX SA if a RX SA is added/updated/removed
> @@ -274,6 +275,7 @@ struct macsec_context {
>  	struct macsec_secy *secy;
>  	struct macsec_rx_sc *rx_sc;
>  	struct {
> +		bool update_pn;
>  		unsigned char assoc_num;
>  		u8 key[MACSEC_MAX_KEY_LEN];
>  		union {
> -- 
> 2.34.1
> 

-- 
Sabrina

