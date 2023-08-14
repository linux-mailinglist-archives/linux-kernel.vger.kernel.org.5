Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA1477BF8C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 20:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjHNSHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 14:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjHNSHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 14:07:10 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25546E5F
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 11:07:09 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d6ce0c4489bso974206276.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 11:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692036428; x=1692641228;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ILL3/wme+Xj3iELICcc/rzQVuKV1rDXNge6KvsnjpQU=;
        b=byqR1Ww+0r/eXw/qhFsThHdhUozBD7vXDz8QBlKVU7ODMahemj/tryCgsp4E4moyVo
         Y6WIvCu4UBQCyYP5mYnIz14yhVEqF0KWZo78E+i/dl/n9UFjqYadCSAb3JQTWyuXtDvT
         4UJd1fX5GS4LxUOCNLGiW26cx5vZ9VE9JB4mVqHFhkCZn5wP8QNDqPLg11wcW+C04Jz3
         +rcvEt4yROAK69LcpGxkVyx+x5gT0zv8M+aMV5dZ4uUnSekygISfLbwjVe+6MzvzbUfG
         F4m09HWA7nxzK5jOFjK4r6EXvYW1uUC8pipTpQCpkwumrAI+6q7TQSgAzntNvfUSGgth
         qBDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692036428; x=1692641228;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ILL3/wme+Xj3iELICcc/rzQVuKV1rDXNge6KvsnjpQU=;
        b=XMBrmVuisjemnCz9t8upCG+72qhxaSiMOeOl0hBRRLzl33AvoQPtN8KIY2jYVSzaTH
         YxA+47h01TnU+7HTqkx54t0eF3JIReS3udn1HXpmLJThQLTQRYPh1U/UfPV6WpPg8n7h
         pWSzak3jbIgCofVeTW9BMpj5a159K2i2zZZo8wEozeFWC46NMhMgShRCq66Mx9ANyIWR
         HnZCen5xpd5aqrxycqQGhEiarFq/K/Pj7nqoh7XL/Nj0qCtQycpTdtxA1hEOphukSXpy
         UKYxgis3SX1SVU9jXpbrhXCAnxVu5enod5oQEb1+3KykFDGXwIpjXbToQFTAvGj3xqyp
         U9fQ==
X-Gm-Message-State: AOJu0Yy3o1rDq6nqdZMfUg5YvuYT2NIIQ9jmwRYwScj6n3VMHZrktZh2
        X0LgeUghuJ9aUJAxUnp7YITtBIhfj/FNQ88=
X-Google-Smtp-Source: AGHT+IFPcHmzG6KqaH70vqmY/Q2yqgXqnRgdvqHi7Ao2JTUETR1j90+egJ02S9qBGbxPNcRQs1E46IszPQ13uZA=
X-Received: from rdbabiera.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:18a8])
 (user=rdbabiera job=sendgmr) by 2002:a25:d4d5:0:b0:d0f:bcfe:bc74 with SMTP id
 m204-20020a25d4d5000000b00d0fbcfebc74mr138892ybf.9.1692036428382; Mon, 14 Aug
 2023 11:07:08 -0700 (PDT)
Date:   Mon, 14 Aug 2023 18:05:59 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
Message-ID: <20230814180559.923475-1-rdbabiera@google.com>
Subject: [PATCH v4] usb: typec: bus: verify partner exists in typec_altmode_attention
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
        autolearn=ham autolearn_force=no version=3.4.6
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

Verify the presence of a device's altmode partner before sending
the Attention message to the Alt Mode driver.

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
Changes since v2:
* Changed tcpm_log message to accurately reflect error
* Revised commit message
---
Changes since v3:
* Fixed nits
---
 drivers/usb/typec/bus.c           | 12 ++++++++++--
 drivers/usb/typec/tcpm/tcpm.c     |  3 ++-
 include/linux/usb/typec_altmode.h |  2 +-
 3 files changed, 13 insertions(+), 4 deletions(-)

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
index 5a7d8cc04628..77fe16190766 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -1877,7 +1877,8 @@ static void tcpm_handle_vdm_request(struct tcpm_port *port,
 			}
 			break;
 		case ADEV_ATTENTION:
-			typec_altmode_attention(adev, p[1]);
+			if (typec_altmode_attention(adev, p[1]))
+				tcpm_log(port, "typec_altmode_attention no port partner altmode");
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
2.41.0.694.ge786442a9b-goog

