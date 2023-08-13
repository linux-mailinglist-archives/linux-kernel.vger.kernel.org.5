Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 888C377A805
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 17:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbjHMPxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 11:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbjHMPwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 11:52:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5455C1FE1;
        Sun, 13 Aug 2023 08:52:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D33E2632EC;
        Sun, 13 Aug 2023 15:51:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21D8DC433CD;
        Sun, 13 Aug 2023 15:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691941915;
        bh=a4tKwIlk6BKXx45kX+IE0Y64HFfOz13SuOgrUcmq/VI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=USMw1uV8v2KxqIUjGezqlKqNup+xvgUxZ0vv2r823PLDy+0Md9LwaQ6HC5m1UZF57
         /9qdpqFzVGXZ78eCIYpBixEgLxW+Xf+b/mBYA6Rw7NHH+nn7I9VTbDRaeMY5NbqPhf
         BP7oUs6nt5TASo22M3OA0dLkCN+Xk3X0T2h+8e8m533R0y9VzfhRZTNz4Bi9pu5dbh
         bPHmZxnPUcSLVCEbE75Ysdr0zTc0m8DWIaDyDDPUc+iZw5pYhZfyuXlV6fy0LwdEH9
         oyG47rGAb9LljOazw20jRgzJiM1nXPAFhqY4ICOKm/VmbeuF4YCA/Z2GMRlbWcTFVf
         XUHNdXf3Gx3OA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kristian Angelov <kristiana2000@abv.bg>,
        "Luke D . Jones" <luke@ljones.dev>,
        Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>, corentin.chary@gmail.com,
        markgross@kernel.org, acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 40/54] platform/x86: asus-wmi: Fix setting RGB mode on some TUF laptops
Date:   Sun, 13 Aug 2023 11:49:19 -0400
Message-Id: <20230813154934.1067569-40-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230813154934.1067569-1-sashal@kernel.org>
References: <20230813154934.1067569-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.10
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
index 1038dfdcdd325..8bef66a2f0ce7 100644
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

