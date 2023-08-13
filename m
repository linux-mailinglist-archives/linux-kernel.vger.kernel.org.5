Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3286477A8B2
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 18:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbjHMQEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 12:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbjHMQEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 12:04:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0D0E6D;
        Sun, 13 Aug 2023 09:04:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 806D7635DD;
        Sun, 13 Aug 2023 16:03:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C42CC433C7;
        Sun, 13 Aug 2023 16:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691942597;
        bh=nQvAvCGoObOnSxg0rFoBXH0ftGjqypR2Bm32uM1Ya98=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wn5ufq63PnID3eBbr2db6w7eAuD6Opa/ZZF9B7R/nMck/v9asAK6hAzNmpfCffL7/
         o6yAPNfYCvc+eGpBqUBSSYet+YTxr7gAW8cUuTD0gB9nlyS9yvo34rFUxrSw80LNRc
         hKCHp3/Ru2NORmHbu2OlN2SjIFgPX8gJcPEcRYhNmZpeiM96C0kC2JTsiluvCQFylw
         vRZYTV3x1BY3L1m6i3L+o2T+lla6zXmzmX7bp2q2Fhn/17ZJDxmi+gvnPaIOERb82P
         Y/qH8X4ysj9IKuvbcirheM4jD4aJSfkAM35DODkNpINXSRAWFvjh0FFu7xDSJfWaU5
         5JaKr0UTLXkSw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kristian Angelov <kristiana2000@abv.bg>,
        "Luke D . Jones" <luke@ljones.dev>,
        Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>, corentin.chary@gmail.com,
        markgross@kernel.org, acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 35/47] platform/x86: asus-wmi: Fix setting RGB mode on some TUF laptops
Date:   Sun, 13 Aug 2023 11:59:30 -0400
Message-Id: <20230813160006.1073695-35-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230813160006.1073695-1-sashal@kernel.org>
References: <20230813160006.1073695-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.45
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kristian Angelov <kristiana2000@abv.bg>

[ Upstream commit 6a758a3e831ce1a84c9c209ac6dc755f4c8ce77a ]

This patch fixes setting the cmd values to 0xb3 and 0xb4.
This is necessary on some TUF laptops in order to set the RGB mode.

Closes: https://lore.kernel.org/platform-driver-x86/443078148.491022.1677576298133@nm83.abv.bg
Signed-off-by: Kristian Angelov <kristiana2000@abv.bg>
Reviewed-by: Luke D. Jones <luke@ljones.dev>
Link: https://lore.kernel.org/r/ZLlS7o6UdTUBkyqa@wyvern.localdomain
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/asus-wmi.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 02bf286924183..36effe04c6f33 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -738,13 +738,23 @@ static ssize_t kbd_rgb_mode_store(struct device *dev,
 				 struct device_attribute *attr,
 				 const char *buf, size_t count)
 {
-	u32 cmd, mode, r, g,  b,  speed;
+	u32 cmd, mode, r, g, b, speed;
 	int err;
 
 	if (sscanf(buf, "%d %d %d %d %d %d", &cmd, &mode, &r, &g, &b, &speed) != 6)
 		return -EINVAL;
 
-	cmd = !!cmd;
+	/* B3 is set and B4 is save to BIOS */
+	switch (cmd) {
+	case 0:
+		cmd = 0xb3;
+		break;
+	case 1:
+		cmd = 0xb4;
+		break;
+	default:
+		return -EINVAL;
+	}
 
 	/* These are the known usable modes across all TUF/ROG */
 	if (mode >= 12 || mode == 9)
-- 
2.40.1

