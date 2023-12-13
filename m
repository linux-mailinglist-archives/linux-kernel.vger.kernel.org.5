Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0C78119D9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379414AbjLMQnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:43:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378871AbjLMQnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:43:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00114189
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:43:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F23DC433C8;
        Wed, 13 Dec 2023 16:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702485797;
        bh=Y4wityMNU6LBHUMAjlj0BBIjoaSI0QhZKsDFgQ7pmJM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lR9U58Vg+LkVgGuHADI7IfXco/pwo/wpHAau0NJYGRG2oRSpP3tPb2jxX4DL4q9sP
         P7ad5N3mM4WSmMdUwRjTEroGTePdFnt/6Vr6Y1wP1UOWgCaA9pMWYvloiXL0W3hH6R
         LtddHquHWTb971SACHCbhVcjBduO7gjIxTU6ou3K/11BFCSMiPDeSyme577N5rULG9
         prCubnu+81tc4+GC0WVGacIWCGsugatzjSzPO3ehNhm337cTEq+hdyhm4recK3g/TZ
         B2uuSsZDxHWl9VVmdUg4NO7eMJJus13D5ylcEvu6VOtYenfnj1rf6ifqV6mrLfY2rR
         sFVxedNg2aPqQ==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Hema HK <hemahk@ti.com>
Subject: [PATCH 11/12] usb: phy: twl6030: Remove snprintf() from sysfs call-backs and replace with sysfs_emit()
Date:   Wed, 13 Dec 2023 16:42:40 +0000
Message-ID: <20231213164246.1021885-12-lee@kernel.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231213164246.1021885-1-lee@kernel.org>
References: <20231213164246.1021885-1-lee@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since snprintf() has the documented, but still rather strange trait of
returning the length of the data that *would have been* written to the
array if space were available, rather than the arguably more useful
length of data *actually* written, it is usually considered wise to use
something else instead in order to avoid confusion.

In the case of sysfs call-backs, new wrappers exist that do just that.

Link: https://lwn.net/Articles/69419/
Link: https://github.com/KSPP/linux/issues/105
Cc: Hema HK <hemahk@ti.com>
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/usb/phy/phy-twl6030-usb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/phy/phy-twl6030-usb.c b/drivers/usb/phy/phy-twl6030-usb.c
index c3ce6b1054f1c..da09cff55abce 100644
--- a/drivers/usb/phy/phy-twl6030-usb.c
+++ b/drivers/usb/phy/phy-twl6030-usb.c
@@ -179,16 +179,16 @@ static ssize_t vbus_show(struct device *dev,
 
 	switch (twl->linkstat) {
 	case MUSB_VBUS_VALID:
-	       ret = snprintf(buf, PAGE_SIZE, "vbus\n");
+	       ret = sysfs_emit(buf, "vbus\n");
 	       break;
 	case MUSB_ID_GROUND:
-	       ret = snprintf(buf, PAGE_SIZE, "id\n");
+	       ret = sysfs_emit(buf, "id\n");
 	       break;
 	case MUSB_VBUS_OFF:
-	       ret = snprintf(buf, PAGE_SIZE, "none\n");
+	       ret = sysfs_emit(buf, "none\n");
 	       break;
 	default:
-	       ret = snprintf(buf, PAGE_SIZE, "UNKNOWN\n");
+	       ret = sysfs_emit(buf, "UNKNOWN\n");
 	}
 	spin_unlock_irqrestore(&twl->lock, flags);
 
-- 
2.43.0.472.g3155946c3a-goog

