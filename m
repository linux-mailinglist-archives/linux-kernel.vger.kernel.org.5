Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A189877F370
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 11:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349660AbjHQJd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 05:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349708AbjHQJdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 05:33:01 -0400
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED6C30DD
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 02:32:58 -0700 (PDT)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20230817093255b1b5fa34f2e171a4fe
        for <linux-kernel@vger.kernel.org>;
        Thu, 17 Aug 2023 11:32:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=a1286gW/ZcWy5VZLsQ78SHAH1XDGNN4Go7TopmdAXNo=;
 b=Ot1RidT9cWPzqmfRx350eDBn2eY0vohqkXGRSIrL/njo+yOWo2va3FyvkJXupC/zQ1uz7x
 p4QZIFaJq+hZFGX5OeR0aorBepWoF3tszCZSsqlB63GSo9lEVGt7PFoMIxbRo4RCg5ubBkUM
 lmH3rlXwmWNW9w7Qew/vLEFmN0jNM=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH v6 1/9] tty: n_gsm: add restart flag to DLC specific ioctl config
Date:   Thu, 17 Aug 2023 11:32:23 +0200
Message-Id: <20230817093231.2317-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Starke <daniel.starke@siemens.com>

Currently, changing the parameters of a DLCI gives no direct control to the
user whether this should trigger a channel reset or not. The decision is
solely made by the driver based on the assumption which parameter changes
are compatible or not. Therefore, the user has no means to perform an
automatic channel reset after parameter configuration for non-conflicting
changes.

Add the parameter 'flags' to 'gsm_dlci_config' to force a channel reset
after ioctl setting regardless of whether the changes made require this or
not by setting this to 'GSM_FL_RESTART'.

Note that 'GSM_FL_RESTART' is currently the only allow flag to allow
additions here.

Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c         |  4 ++++
 include/uapi/linux/gsmmux.h | 15 ++++++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

v5 -> v6:
No changes.

Link: https://lore.kernel.org/all/20230517155704.5701-1-daniel.starke@siemens.com/

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 42759500b79e..a4268515920e 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2532,6 +2532,8 @@ static int gsm_dlci_config(struct gsm_dlci *dlci, struct gsm_dlci_config *dc, in
 		return -EINVAL;
 	if (dc->k > 7)
 		return -EINVAL;
+	if (dc->flags & ~GSM_FL_RESTART)   /* allow future extensions */
+		return -EINVAL;
 
 	/*
 	 * See what is needed for reconfiguration
@@ -2546,6 +2548,8 @@ static int gsm_dlci_config(struct gsm_dlci *dlci, struct gsm_dlci_config *dc, in
 	/* Requires care */
 	if (dc->priority != dlci->prio)
 		need_restart = true;
+	if (dc->flags & GSM_FL_RESTART)
+		need_restart = true;
 
 	if ((open && gsm->wait_config) || need_restart)
 		need_open = true;
diff --git a/include/uapi/linux/gsmmux.h b/include/uapi/linux/gsmmux.h
index eb67884e5f38..e56e2d7ea6eb 100644
--- a/include/uapi/linux/gsmmux.h
+++ b/include/uapi/linux/gsmmux.h
@@ -2,10 +2,22 @@
 #ifndef _LINUX_GSMMUX_H
 #define _LINUX_GSMMUX_H
 
+#include <linux/const.h>
 #include <linux/if.h>
 #include <linux/ioctl.h>
 #include <linux/types.h>
 
+/*
+ * flags definition for n_gsm
+ *
+ * Used by:
+ * struct gsm_dlci_config.flags
+ */
+/* Forces a DLCI reset if set. Otherwise, a DLCI reset is only done if
+ * incompatible settings were provided. Always cleared on retrieval.
+ */
+#define GSM_FL_RESTART	_BITUL(0)
+
 struct gsm_config
 {
 	unsigned int adaption;
@@ -58,7 +70,8 @@ struct gsm_dlci_config {
 	__u32 priority;		/* Priority (0 for default value) */
 	__u32 i;		/* Frame type (1 = UIH, 2 = UI) */
 	__u32 k;		/* Window size (0 for default value) */
-	__u32 reserved[8];	/* For future use, must be initialized to zero */
+	__u32 flags;		/* DLCI specific flags. */
+	__u32 reserved[7];	/* For future use, must be initialized to zero */
 };
 
 #define GSMIOC_GETCONF_DLCI	_IOWR('G', 7, struct gsm_dlci_config)
-- 
2.34.1

