Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12FC77EAF17
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 12:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbjKNLaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 06:30:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232993AbjKNL3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 06:29:21 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CD6D6B;
        Tue, 14 Nov 2023 03:29:00 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id E88FC60011;
        Tue, 14 Nov 2023 11:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699961339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=10SiBN/4Fj+hMV2c6j8AN3pqV9PZiveL87TjssWFLBw=;
        b=kX5BXEuakP80zkXB1Wo+QuoL8r+kM1cW+aefIK98bBhvLJMSosQHavmDq3e09P4HllWxNb
        4TRSSYMKpKf4FP5WEEtmSX9zfBFpijdKI8pTuVIkyaBThZEZ0FmU9h4j/ms6NhyiuKQJTc
        +nKVdDMD/G9P+W0XnNavlY5QLlaPiQxADQFaLIGHWUILied92JsK8LfUBs5tRsZRZgN4Pf
        2hSuEo8QXL4CMCGX9mI+HDCjPDGQHeL8c1gb25TXFtnDdxWqjyXC4894MeHWxvEcTB4h1U
        liJ/1geR+j5bLD153qeiB73bJRKh6mX+6U80y8EymPrIrwFIvf19wboU5aPOvQ==
From:   Kory Maincent <kory.maincent@bootlin.com>
Date:   Tue, 14 Nov 2023 12:28:35 +0100
Subject: [PATCH net-next v7 07/16] net_tstamp: Add TIMESTAMPING SOFTWARE
 and HARDWARE mask
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-feature_ptp_netnext-v7-7-472e77951e40@bootlin.com>
References: <20231114-feature_ptp_netnext-v7-0-472e77951e40@bootlin.com>
In-Reply-To: <20231114-feature_ptp_netnext-v7-0-472e77951e40@bootlin.com>
To:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Radu Pirea <radu-nicolae.pirea@oss.nxp.com>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: kory.maincent@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Timestamping software or hardware flags are often used as a group,
therefore adding these masks will easier future use.

I did not use SOF_TIMESTAMPING_SYS_HARDWARE flag as it is deprecated and
not use at all.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 include/uapi/linux/net_tstamp.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/uapi/linux/net_tstamp.h b/include/uapi/linux/net_tstamp.h
index a2c66b3d7f0f..df8091998c8d 100644
--- a/include/uapi/linux/net_tstamp.h
+++ b/include/uapi/linux/net_tstamp.h
@@ -48,6 +48,14 @@ enum {
 					 SOF_TIMESTAMPING_TX_SCHED | \
 					 SOF_TIMESTAMPING_TX_ACK)
 
+#define SOF_TIMESTAMPING_SOFTWARE_MASK	(SOF_TIMESTAMPING_RX_SOFTWARE | \
+					 SOF_TIMESTAMPING_TX_SOFTWARE | \
+					 SOF_TIMESTAMPING_SOFTWARE)
+
+#define SOF_TIMESTAMPING_HARDWARE_MASK	(SOF_TIMESTAMPING_RX_HARDWARE | \
+					 SOF_TIMESTAMPING_TX_HARDWARE | \
+					 SOF_TIMESTAMPING_RAW_HARDWARE)
+
 /**
  * struct so_timestamping - SO_TIMESTAMPING parameter
  *

-- 
2.25.1

