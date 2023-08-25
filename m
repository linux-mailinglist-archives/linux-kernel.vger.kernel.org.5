Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8E27888D0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 15:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245151AbjHYNl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 09:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244094AbjHYNln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 09:41:43 -0400
Received: from us-smtp-delivery-44.mimecast.com (unknown [207.211.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACC51FDE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 06:41:41 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-639-lU_r3n3AMNuETnu5Wd0C8A-1; Fri, 25 Aug 2023 09:41:22 -0400
X-MC-Unique: lU_r3n3AMNuETnu5Wd0C8A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5D0F38D40A0;
        Fri, 25 Aug 2023 13:41:21 +0000 (UTC)
Received: from hog (unknown [10.39.192.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A8DA3140E950;
        Fri, 25 Aug 2023 13:41:19 +0000 (UTC)
Date:   Fri, 25 Aug 2023 15:41:18 +0200
From:   Sabrina Dubroca <sd@queasysnail.net>
To:     "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com,
        sebastian.tobuschat@nxp.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next v2 4/5] net: phy: nxp-c45-tja11xx: add MACsec
 statistics
Message-ID: <ZOivfv6H60faLvCi@hog>
References: <20230824091615.191379-1-radu-nicolae.pirea@oss.nxp.com>
 <20230824091615.191379-5-radu-nicolae.pirea@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230824091615.191379-5-radu-nicolae.pirea@oss.nxp.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2023-08-24, 12:16:14 +0300, Radu Pirea (NXP OSS) wrote:
> @@ -1323,8 +1469,10 @@ static int nxp_c45_mdo_del_txsa(struct macsec_context *ctx)
>  
>  	nxp_c45_select_secy(phydev, phy_secy->secy_id);
>  
> -	if (tx_sa->is_enabled)
> +	if (tx_sa->is_enabled) {
>  		nxp_c45_update_key_status(phydev, tx_sa);
> +		nxp_c45_tx_sa_stats_clear(phydev, tx_sa);

If the TXSA was already disabled (via mdo_upd_txsa), don't you need to
clear the stats as well?

[...]
> +static int nxp_c45_mdo_get_tx_sc_stats(struct macsec_context *ctx)
> +{
[...]
> +	nxp_c45_macsec_read(phydev, MACSEC_OOE1HS, &reg);
> +	stat = (u64)reg << 32;
> +	nxp_c45_macsec_read(phydev, MACSEC_OOE2HS, &reg);
> +	stat |= reg;
> +	if (ctx->secy->tx_sc.encrypt)
> +		tx_sc_stats->OutOctetsEncrypted = stat;
> +	else
> +		tx_sc_stats->OutOctetsEncrypted = 0;
> +
> +	if (ctx->secy->protect_frames)
> +		tx_sc_stats->OutOctetsProtected = stat;
> +	else
> +		tx_sc_stats->OutOctetsProtected = 0;

This doesn't look consistent with macsec_count_tx
(drivers/net/macsec.c).

-- 
Sabrina

