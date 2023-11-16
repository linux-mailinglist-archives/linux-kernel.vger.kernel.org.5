Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E267EE786
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 20:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345507AbjKPTdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 14:33:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345396AbjKPTdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 14:33:22 -0500
Received: from mail-1.server.selfnet.de (mail-1.server.selfnet.de [141.70.126.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BAF90;
        Thu, 16 Nov 2023 11:33:15 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 64DE1403A1;
        Thu, 16 Nov 2023 20:33:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=selfnet.de; s=selfnet;
        t=1700163191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=C/qgsd93til2nE9EEIPcHiiKgfZ+FbrQSgJ2jg4YdJE=;
        b=AFlZnRYfgjfz/zkTsbsV9QcutZLJLzm1wWse1iyQFLsx8FFlsmmV1FGOG5V6TwNArgYlmi
        +vFwwGZTwgnwkyOHeYUmJzNfy+oMGauTl6FT7MwLUeZRsmA32WM0buGks4bcNIl0q+yH59
        dQtb2m9bWw2ygnSxHgPOwyypMTlkoYegYmvI6T073DkGeChpStYXoFO3MriNWtumNp5OBO
        pVZUk41IL7NV0MgmPULvgyUfMIlQ4R6s1m7SW/g3fYTFsNogRYJ0Nfk5GaUzy/ZM3fuFAO
        J08A+m/12WY06Xfy7rGhYS749MvEwJipqCogu5idpGYPI39FSaV6JZ0fWTGOrw==
From:   Marco von Rosenberg <marcovr@selfnet.de>
To:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Marco von Rosenberg <marcovr@selfnet.de>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2] net: phy: broadcom: Wire suspend/resume for BCM54612E
Date:   Thu, 16 Nov 2023 20:32:31 +0100
Message-ID: <20231116193231.7513-1-marcovr@selfnet.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BCM54612E ethernet PHY supports IDDQ-SR.
Therefore wire-up the suspend and resume callbacks
to point to bcm54xx_suspend() and bcm54xx_resume().

Signed-off-by: Marco von Rosenberg <marcovr@selfnet.de>
---
Changes in v2:
- Changed commit message
- Rebased on commit 3753c18ad5cf

 drivers/net/phy/broadcom.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/phy/broadcom.c b/drivers/net/phy/broadcom.c
index 3a627105675a..312a8bb35d78 100644
--- a/drivers/net/phy/broadcom.c
+++ b/drivers/net/phy/broadcom.c
@@ -1135,6 +1135,8 @@ static struct phy_driver broadcom_drivers[] = {
 	.handle_interrupt = bcm_phy_handle_interrupt,
 	.link_change_notify	= bcm54xx_link_change_notify,
 	.led_brightness_set	= bcm_phy_led_brightness_set,
+	.suspend	= bcm54xx_suspend,
+	.resume		= bcm54xx_resume,
 }, {
 	.phy_id		= PHY_ID_BCM54616S,
 	.phy_id_mask	= 0xfffffff0,
-- 
2.42.0

