Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955F57FED5C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 11:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345090AbjK3KzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 05:55:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345084AbjK3KzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 05:55:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C299510F4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 02:55:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E26CFC433CA;
        Thu, 30 Nov 2023 10:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701341713;
        bh=5UqF6R+sWlvabSQcifcTgrUGPsaALtx849UaV5ZfAKQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EOBnh8dQw28r6W0KPBw5vHS0NSBkkMQADsIb+Ve3s5U/7V/iBgkdOyaSMTt6ijwzj
         6Ov39DhGrVN/xtHRUygR0xpAkRjnXxyWBY4uBB/iS+11vAe2+40UEvgD8xqgcUzd+e
         HM/otnXIKQTW5mBIvxY9MjH7704FN4JMwb67INriEKjmFuVF0dlyXiPKRxABvydoB4
         b1H8w4EnGqE2tD/rrI2SfwQLzNCEORoKyOFeo+dTDhdcx0/aqwFc1tgMmqXbygHXo2
         EVo7qW7D7BGO2ZoO34GganL2z0nMzryMQU+WdCfCGr9+UQcU4eZdUgJhCTkivgPOl/
         h9e2lzRBWT6Gg==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Matthieu CASTET <castet.matthieu@free.fr>,
        Stanislaw Gruszka <stf_xl@wp.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Damien Bergamini <damien.bergamini@free.fr>,
        linux-usb@vger.kernel.org
Subject: [PATCH 1/5] usb: atm: Remove snprintf() from sysfs call-backs and replace with sysfs_emit()
Date:   Thu, 30 Nov 2023 10:54:35 +0000
Message-ID: <20231130105459.3208986-2-lee@kernel.org>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
In-Reply-To: <20231130105459.3208986-1-lee@kernel.org>
References: <20231130105459.3208986-1-lee@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

This patch replaces the 2 uses of snprintf() found in the sysfs .show()
call-backs with the new sysfs_emit() helpers.  Whist we're at it, let's
replace the sprintf()s as well.  For no other reason than consistency.

Link: https://lwn.net/Articles/69419/
Link: https://github.com/KSPP/linux/issues/105
Cc: Matthieu CASTET <castet.matthieu@free.fr>
Cc: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Damien Bergamini <damien.bergamini@free.fr>
Cc: linux-usb@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/usb/atm/ueagle-atm.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/atm/ueagle-atm.c b/drivers/usb/atm/ueagle-atm.c
index 5812f7ea7f902..8d5580d8d20a8 100644
--- a/drivers/usb/atm/ueagle-atm.c
+++ b/drivers/usb/atm/ueagle-atm.c
@@ -2252,7 +2252,7 @@ static ssize_t stat_status_show(struct device *dev, struct device_attribute *att
 	sc = dev_to_uea(dev);
 	if (!sc)
 		goto out;
-	ret = snprintf(buf, 10, "%08x\n", sc->stats.phy.state);
+	ret = sysfs_emit(buf, "%08x\n", sc->stats.phy.state);
 out:
 	mutex_unlock(&uea_mutex);
 	return ret;
@@ -2318,19 +2318,19 @@ static ssize_t stat_human_status_show(struct device *dev,
 
 	switch (modem_state) {
 	case 0:
-		ret = sprintf(buf, "Modem is booting\n");
+		ret = sysfs_emit(buf, "Modem is booting\n");
 		break;
 	case 1:
-		ret = sprintf(buf, "Modem is initializing\n");
+		ret = sysfs_emit(buf, "Modem is initializing\n");
 		break;
 	case 2:
-		ret = sprintf(buf, "Modem is operational\n");
+		ret = sysfs_emit(buf, "Modem is operational\n");
 		break;
 	case 3:
-		ret = sprintf(buf, "Modem synchronization failed\n");
+		ret = sysfs_emit(buf, "Modem synchronization failed\n");
 		break;
 	default:
-		ret = sprintf(buf, "Modem state is unknown\n");
+		ret = sysfs_emit(buf, "Modem state is unknown\n");
 		break;
 	}
 out:
@@ -2364,7 +2364,7 @@ static ssize_t stat_delin_show(struct device *dev, struct device_attribute *attr
 			delin = "LOSS";
 	}
 
-	ret = sprintf(buf, "%s\n", delin);
+	ret = sysfs_emit(buf, "%s\n", delin);
 out:
 	mutex_unlock(&uea_mutex);
 	return ret;
@@ -2384,7 +2384,7 @@ static ssize_t stat_##name##_show(struct device *dev,		\
 	sc = dev_to_uea(dev);					\
 	if (!sc)						\
 		goto out;					\
-	ret = snprintf(buf, 10, "%08x\n", sc->stats.phy.name);	\
+	ret = sysfs_emit(buf, "%08x\n", sc->stats.phy.name);	\
 	if (reset)						\
 		sc->stats.phy.name = 0;				\
 out:								\
-- 
2.43.0.rc1.413.gea7ed67945-goog

