Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEEDC779746
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 20:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236057AbjHKSsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 14:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233418AbjHKSsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 14:48:09 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0F730E8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 11:48:08 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d637af9a981so2263718276.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 11:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691779688; x=1692384488;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZJJ8UdAIxIsw1LkzQ8Bf6m1ij6K720NrGCKMd7eniDM=;
        b=oZKX9eh/oR9Kkzl97al4UScWBn7jnrWuhJe5205va1AhljySM2gHSaH1yj7tV/v3T9
         aS1NbtndUEeMUBFsb8BNrkCG3ADshR1Qr/8RHv8SiMeasr711vA+HCF655Bfs+fKp4Ae
         wKCf4xI9ILtCQqA/nd3FZXXl8+KxttPoD8W9TFJM9CQXz6niVgstQCNTBANbR2MPKK7N
         gba7m0SMNqO8IeUG+y7voRqfyMF9IMss5oeEk7ziuFi6rM99EvX/tz4EOaCjJdKMqxof
         3ZmDfA0WaWkSxuU7cGN9n8rPaq3NrupxQwx8VG3MNnq3PBzvFyvI3FlR+75ocnGUDTP+
         QCyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691779688; x=1692384488;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZJJ8UdAIxIsw1LkzQ8Bf6m1ij6K720NrGCKMd7eniDM=;
        b=UW7MfmdNONiti2S4vQm4vHi+MVp8wp/lENxUZpUDNPtDSIw4FAoEbhyNDSbHZ69aur
         QUw2QZ8/S6loe4nH+xDH9peWOF6WVUWr9rrGF5zomj77BbEYn5v0QvUCk4qih/Q0iZkw
         bCl9uV0+s1Xd2qwnpQ2nfQYoYSmy3JCNZLIUOIgbvlR8dXumw54IMVonj+tZbWKfXJ06
         kNKG1EjIP9WF7T2Du3M6DNJj2Fuqk3bzvNqRWxsplKn/cwVAmDgzqOWnyxwLdnKrFfbO
         C4Ku9FGOD/HoTp7EoIT1e7Ggupx2bITlfntn/da89LP5bxvRCGfPn88q7LbyudL7ZFLM
         tVxw==
X-Gm-Message-State: AOJu0Yy9TimuE+GvD6plzrqGtJEc76TVlQRhaDpBvt2U79yDq2i8q0h5
        phrgWKk4tmHcUCNrdAvjPI1OH1euYpfOmKs=
X-Google-Smtp-Source: AGHT+IEnRj3XgadHnPY0JsCnuxHjF2khkZv3Wyf3q91Z5QvsEE5u2YoEPQOSwguVfdhtyYW/HmP8lMT6za6KB+g=
X-Received: from rdbabiera.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:18a8])
 (user=rdbabiera job=sendgmr) by 2002:a25:d153:0:b0:d3f:3186:2296 with SMTP id
 i80-20020a25d153000000b00d3f31862296mr49820ybg.3.1691779687961; Fri, 11 Aug
 2023 11:48:07 -0700 (PDT)
Date:   Fri, 11 Aug 2023 18:47:54 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230811184754.1886458-1-rdbabiera@google.com>
Subject: [PATCH v2] usb: typec: bus: verify partner exists in typec_altmode_attention
From:   RD Babiera <rdbabiera@google.com>
To:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        linux@roeck-us.net
Cc:     badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, RD Babiera <rdbabiera@google.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some usb hubs will negotiate DisplayPort Alt mode with the device
but will then negotiate a data role swap after entering the alt
mode. The data role swap causes the device to unregister all alt
modes, however the usb hub will still send Attention messages
even after failing to reregister the Alt Mode. type_altmode_attention
currently does not verify whether or not a device's altmode partner
exists, which results in a NULL pointer error when dereferencing
the typec_altmode and typec_altmode_ops belonging to the altmode
partner.

This patch verifies the presence of a device's altmode partner
before sending the Attention message to the Alt Mode driver.

Fixes: 8a37d87d72f0 ("usb: typec: Bus type for alternate modes")
Cc: stable@vger.kernel.org
Signed-off-by: RD Babiera <rdbabiera@google.com>
---
Changes since v1:
* Only assigns pdev if altmode partner exists in typec_altmode_attention
* Removed error return in typec_altmode_attention if Alt Mode does
  not implement Attention messages.
* Changed tcpm_log message to indicate that altmode partner does not exist,
  as it only logs in that case.
---
 drivers/usb/typec/bus.c           | 12 ++++++++++--
 drivers/usb/typec/tcpm/tcpm.c     |  5 ++++-
 include/linux/usb/typec_altmode.h |  2 +-
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/bus.c b/drivers/usb/typec/bus.c
index fe5b9a2e61f5..e95ec7e382bb 100644
--- a/drivers/usb/typec/bus.c
+++ b/drivers/usb/typec/bus.c
@@ -183,12 +183,20 @@ EXPORT_SYMBOL_GPL(typec_altmode_exit);
  *
  * Notifies the partner of @adev about Attention command.
  */
-void typec_altmode_attention(struct typec_altmode *adev, u32 vdo)
+int typec_altmode_attention(struct typec_altmode *adev, u32 vdo)
 {
-	struct typec_altmode *pdev = &to_altmode(adev)->partner->adev;
+	struct altmode *partner = to_altmode(adev)->partner;
+	struct typec_altmode *pdev;
+
+	if (!partner)
+		return -ENODEV;
+
+	pdev = &partner->adev;
 
 	if (pdev->ops && pdev->ops->attention)
 		pdev->ops->attention(pdev, vdo);
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(typec_altmode_attention);
 
diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 5a7d8cc04628..b0328e922989 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -1791,6 +1791,7 @@ static void tcpm_handle_vdm_request(struct tcpm_port *port,
 	u32 p[PD_MAX_PAYLOAD];
 	u32 response[8] = { };
 	int i, rlen = 0;
+	int ret;
 
 	for (i = 0; i < cnt; i++)
 		p[i] = le32_to_cpu(payload[i]);
@@ -1877,7 +1878,9 @@ static void tcpm_handle_vdm_request(struct tcpm_port *port,
 			}
 			break;
 		case ADEV_ATTENTION:
-			typec_altmode_attention(adev, p[1]);
+			ret = typec_altmode_attention(adev, p[1]);
+			if (ret)
+				tcpm_log(port, "typec_altmode_attention invalid port partner");
 			break;
 		}
 	}
diff --git a/include/linux/usb/typec_altmode.h b/include/linux/usb/typec_altmode.h
index 350d49012659..28aeef8f9e7b 100644
--- a/include/linux/usb/typec_altmode.h
+++ b/include/linux/usb/typec_altmode.h
@@ -67,7 +67,7 @@ struct typec_altmode_ops {
 
 int typec_altmode_enter(struct typec_altmode *altmode, u32 *vdo);
 int typec_altmode_exit(struct typec_altmode *altmode);
-void typec_altmode_attention(struct typec_altmode *altmode, u32 vdo);
+int typec_altmode_attention(struct typec_altmode *altmode, u32 vdo);
 int typec_altmode_vdm(struct typec_altmode *altmode,
 		      const u32 header, const u32 *vdo, int count);
 int typec_altmode_notify(struct typec_altmode *altmode, unsigned long conf,

base-commit: f176638af476c6d46257cc3303f5c7cf47d5967d
-- 
2.41.0.640.ga95def55d0-goog

