Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE502759132
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 11:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjGSJJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 05:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjGSJJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 05:09:27 -0400
Received: from mail.helmholz.de (mail.helmholz.de [217.6.86.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5770519B4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 02:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=helmholz.de
        ; s=dkim1; h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date
        :Subject:CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=gyEGvssOzYguh+Kro8HHxNoiB63QqOxNwkcV9tfP/0o=; b=NKCJHBO8Wd/LPkElLlhk85v2Rl
        2aJTSyKPZlakEp70YGUSY58Pmiqe/B1K1PNNa/h0isvDBBdCqw2cNQLyNtXCvFxjA4oCGHL0STtRi
        DuUxGkMSm7K2P0GrTVNjUSWthNAs0SNipCUZYv2NT4vGZJiIRMx/55Khi64ngSnpuY8d5vAUlCFgp
        mRC62VAZeNlDsKQXPYkfMv56dc+uMP83WvQm5BR18sVVzwrdjy9eV0kLQKW5+qXEomsjg7fXOiylH
        V6Yc11q+4aMXr81nl8AUWpSMq7bHNQIO7cm7fKCbNLsU27PgurUajBnev5ONRYsZIZDOpXRX4Gkuo
        0uj+nWnw==;
Received: from [192.168.1.4] (port=15819 helo=SH-EX2013.helmholz.local)
        by mail.helmholz.de with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
        (Exim 4.96)
        (envelope-from <Ante.Knezic@helmholz.de>)
        id 1qM3B3-0000wP-25;
        Wed, 19 Jul 2023 11:08:57 +0200
Received: from linuxdev.helmholz.local (192.168.6.7) by
 SH-EX2013.helmholz.local (192.168.1.4) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Wed, 19 Jul 2023 11:08:57 +0200
From:   Ante Knezic <ante.knezic@helmholz.de>
To:     <olteanv@gmail.com>
CC:     <andrew@lunn.ch>, <ante.knezic@helmholz.de>, <davem@davemloft.net>,
        <edumazet@google.com>, <f.fainelli@gmail.com>, <kuba@kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2] net: dsa: mv88e6xxx: Add erratum 3.14 for 88E6390X and 88E6190X
Date:   Wed, 19 Jul 2023 11:08:53 +0200
Message-ID: <20230719090853.21509-1-ante.knezic@helmholz.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20230718155621.3jenfn7rqtgouny7@skbuf>
References: <20230718155621.3jenfn7rqtgouny7@skbuf>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.6.7]
X-ClientProxiedBy: SH-EX2013.helmholz.local (192.168.1.4) To
 SH-EX2013.helmholz.local (192.168.1.4)
X-EXCLAIMER-MD-CONFIG: 2ae5875c-d7e5-4d7e-baa3-654d37918933
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> It needs to be implemented exactly as posted here? After mv88e6390_serdes_power()
> is called on any port/lane, mv88e6390x_serdes_erratum_3_14() needs to run
> for all lanes? That might be a problem.

Actually, I tested applying erratum only on requested lane in pcs_post_config and
it seems to work out fine, so we might use something like:

static int mv88e6390_erratum_3_14(struct mv88e639x_pcs *mpcs)
{
	int err;

	/* 88e6190x and 88e6390x errata 3.14:
	 * After chip reset, SERDES reconfiguration or SERDES core
	 * Software Reset, the SERDES lanes may not be properly aligned
	 * resulting in CRC errors
	 */

	err = mdiodev_c45_write(&mpcs->mdio, MDIO_MMD_PHYXS,
					 0xf054, 0x400C);
	if (err)
	        return err;

	err = mdiodev_c45_write(&mpcs->mdio, MDIO_MMD_PHYXS,
				 0xf054, 0x4000);
	if (err)
	        return err;

	return 0;
}

> Do we know if the register writes are disruptive for the ports which are
> already up and running?

I was not able to see any issues when appling the errata for already active
and running ports.
