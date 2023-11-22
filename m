Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB677F417A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 10:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235067AbjKVJWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 04:22:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjKVJWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 04:22:23 -0500
X-Greylist: delayed 1845 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 22 Nov 2023 01:22:19 PST
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846509D;
        Wed, 22 Nov 2023 01:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=JRXouuJfULJtmERrHhVMLHylo3BRns26iZLKV3W5G40=; b=pLVyAniQcBnvn7qvivjxA4sSYV
        /YYTATgl7fm7Tqt7TlQdsYOpxszP+cME/agLlQTffNWR8DCW4nhUrXNOnQOfhEL9C61g2NWtgb+3G
        kPEyIq7WNIpW9S+1YNwFBMntL5o6VeAXyhAOCbUI8f+Uo3/3IfuJGr8nDqHiJLELAqciS76quEAi8
        7RkaetF0MDOzhjl7dE3jsvWk4WyI2R3O8bBriuzWJa3brqN/NTAuTSIPyZ248t8tjtQYgxA12Y6zE
        J/Itz6u0Kp1PA8n+ai+8P5ICNFFI9kiKhvMO9kR30OwnC/WYrXst2Ya/zz7oZ+jzTQLYnPyi77q1Q
        3hahTfBg==;
Received: from [167.98.27.226] (helo=rainbowdash)
        by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
        id 1r5ix5-003hg5-ES; Wed, 22 Nov 2023 08:51:20 +0000
Received: from ben by rainbowdash with local (Exim 4.97)
        (envelope-from <ben@rainbowdash>)
        id 1r5ix6-00000000kDE-03Uz;
        Wed, 22 Nov 2023 08:51:20 +0000
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-watchdog@vger.kernel.org
Cc:     linux@roeck-us.net, wim@linux-watchdog.org,
        samin.guo@starfivetech.com, xingyu.wu@starfivetech.com,
        linux-kernel@vger.kernel.org, Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] watchdog: starfive: add lock annotations to fix context imbalances
Date:   Wed, 22 Nov 2023 08:51:18 +0000
Message-Id: <20231122085118.177589-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: srv_ts003@codethink.com
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the necessary __acquires() and __releases() to the functions
that take and release the wdt lock to avoid the following sparse
warnings:

drivers/watchdog/starfive-wdt.c:204:13: warning: context imbalance in 'starfive_wdt_unlock' - wrong count at exit
drivers/watchdog/starfive-wdt.c:212:9: warning: context imbalance in 'starfive_wdt_lock' - unexpected unlock

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/watchdog/starfive-wdt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/watchdog/starfive-wdt.c b/drivers/watchdog/starfive-wdt.c
index 5f501b41faf9..49b38ecc092d 100644
--- a/drivers/watchdog/starfive-wdt.c
+++ b/drivers/watchdog/starfive-wdt.c
@@ -202,12 +202,14 @@ static u32 starfive_wdt_ticks_to_sec(struct starfive_wdt *wdt, u32 ticks)
 
 /* Write unlock-key to unlock. Write other value to lock. */
 static void starfive_wdt_unlock(struct starfive_wdt *wdt)
+	__acquires(&wdt->lock)
 {
 	spin_lock(&wdt->lock);
 	writel(wdt->variant->unlock_key, wdt->base + wdt->variant->unlock);
 }
 
 static void starfive_wdt_lock(struct starfive_wdt *wdt)
+	__releases(&wdt->lock)
 {
 	writel(~wdt->variant->unlock_key, wdt->base + wdt->variant->unlock);
 	spin_unlock(&wdt->lock);
-- 
2.37.2.352.g3c44437643

