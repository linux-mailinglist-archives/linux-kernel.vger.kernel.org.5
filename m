Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C22F79B9C4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358290AbjIKWIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237112AbjIKMBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 08:01:04 -0400
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DB862CDD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 05:00:59 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-68-1Uit29QxP06mGdnbklrkUw-1; Mon, 11 Sep 2023 08:00:55 -0400
X-MC-Unique: 1Uit29QxP06mGdnbklrkUw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2CE518F8752;
        Mon, 11 Sep 2023 12:00:54 +0000 (UTC)
Received: from hog (unknown [10.39.192.47])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8CBCE4402E;
        Mon, 11 Sep 2023 12:00:52 +0000 (UTC)
Date:   Mon, 11 Sep 2023 14:00:51 +0200
From:   Sabrina Dubroca <sd@queasysnail.net>
To:     "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com,
        sebastian.tobuschat@nxp.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next v3 5/6] net: phy: nxp-c45-tja11xx: add MACsec
 statistics
Message-ID: <ZP8Bc0KLTthSiKD-@hog>
References: <20230906160134.311993-1-radu-nicolae.pirea@oss.nxp.com>
 <20230906160134.311993-6-radu-nicolae.pirea@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230906160134.311993-6-radu-nicolae.pirea@oss.nxp.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2023-09-06, 19:01:33 +0300, Radu Pirea (NXP OSS) wrote:
> +static int nxp_c45_mdo_get_dev_stats(struct macsec_context *ctx)
> +{
> +	struct phy_device *phydev = ctx->phydev;
> +	struct nxp_c45_phy *priv = phydev->priv;
> +	struct macsec_dev_stats  *dev_stats;
> +	struct nxp_c45_secy *phy_secy;
> +	u32 reg = 0;
> +
> +	phy_secy = nxp_c45_find_secy(&priv->macsec->secy_list, ctx->secy->sci);
> +	if (IS_ERR(phy_secy))
> +		return PTR_ERR(phy_secy);
> +
> +	dev_stats = ctx->stats.dev_stats;
> +	nxp_c45_select_secy(phydev, phy_secy->secy_id);
> +
> +	nxp_c45_macsec_read(phydev, MACSEC_OPUS, &reg);
> +	dev_stats->OutPktsUntagged = reg;

Can you read directly into OutPktsUntagged? It would make the code a
little bit more readable.

It's a bit unfortunate that all those stats read turn into 2 (or 4 for
the 64b counters) reads. If the HW's value can be incremented while
we're reading it we'll see an inconsistent value :(


> +	nxp_c45_macsec_read(phydev, MACSEC_OPTLS, &reg);
> +	dev_stats->OutPktsTooLong = reg;
> +	nxp_c45_macsec_read(phydev, MACSEC_INPBTS, &reg);
> +	dev_stats->InPktsBadTag = reg;
> +
> +	nxp_c45_macsec_read(phydev, MACSEC_INPWTS, &reg);
> +	if (phy_secy->secy->validate_frames == MACSEC_VALIDATE_STRICT)
> +		dev_stats->InPktsNoTag += reg;
> +	else
> +		dev_stats->InPktsUntagged += reg;
> +
> +	nxp_c45_macsec_read(phydev, MACSEC_IPSNFS, &reg);
> +	if (phy_secy->secy->validate_frames == MACSEC_VALIDATE_STRICT)
> +		dev_stats->InPktsNoSCI += reg;
> +	else
> +		dev_stats->InPktsUnknownSCI += reg;
> +
> +	/* Always 0. */
> +	dev_stats->InPktsOverrun = 0;
> +
> +	return 0;
> +}
> +
> +static int nxp_c45_mdo_get_tx_sc_stats(struct macsec_context *ctx)
> +{
> +	struct phy_device *phydev = ctx->phydev;
> +	struct nxp_c45_phy *priv = phydev->priv;
> +	struct macsec_tx_sa_stats tx_sa_stats;
> +	struct macsec_tx_sc_stats *stats;
> +	struct nxp_c45_secy *phy_secy;
> +	struct nxp_c45_sa *pos, *tmp;
> +	u32 reg = 0;
> +
> +	phy_secy = nxp_c45_find_secy(&priv->macsec->secy_list, ctx->secy->sci);
> +	if (IS_ERR(phy_secy))
> +		return PTR_ERR(phy_secy);
> +
> +	stats = ctx->stats.tx_sc_stats;
> +	nxp_c45_select_secy(phydev, phy_secy->secy_id);
> +
> +	nxp_c45_macsec_read(phydev, MACSEC_OOE1HS, &reg);
> +	stats->OutOctetsEncrypted = (u64)reg << 32;
> +	nxp_c45_macsec_read(phydev, MACSEC_OOE2HS, &reg);
> +	stats->OutOctetsEncrypted |= reg;

Since you have a few 64b HW counters, I'd suggest a helper:

stats->OutOctetsEncrypted = nxp_c45_macsec_read64(phydev, MACSEC_OOE1HS, MACSEC_OOE2HS);


Or (more consistent with the 32b reads):

nxp_c45_macsec_read64(phydev, MACSEC_OOE1HS, MACSEC_OOE2HS, &stats->OutOctetsEncrypted);


-- 
Sabrina

