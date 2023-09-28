Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 816507B1C73
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 14:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232512AbjI1Mat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 08:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbjI1Mam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 08:30:42 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F250519F;
        Thu, 28 Sep 2023 05:30:39 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c12fc235fbso149514121fa.0;
        Thu, 28 Sep 2023 05:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695904238; x=1696509038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yp1yNMJhm0Xmlti2S7KpcZZ4ydY0GaIDDg/yGsmahK4=;
        b=F6P6Y2hZpn8LhiWBUIDZ4N0kqPsAUIRWpsKBeCuEWuEFbjuGEMi48RcdK0L+T0md91
         YjUD1+6Qtm/ApPtWuqVqxfTD4TWyQOFHceAyPEGDB2cUO2Afs2vis1LEquHJI9Wu3/gk
         MCDC1PmgM0toyKeyWG3Z9xEGJ0/EuIKS7dLVlEmOprQW4MDastv70ctgXGQKE+eVpyJ3
         6E2pqAtsOylPqEAisILTguCNX4qo2asfsZUi95/we8UfdbARvdi/Mx7YQ6qKvua1MCvJ
         6K+NkczFZxrWwxkwNVfNiLqBhQW1XAYO/SW43Jvg+IyCpXPbhpYYygRz6mr/FpJJmYGB
         RnYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695904238; x=1696509038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yp1yNMJhm0Xmlti2S7KpcZZ4ydY0GaIDDg/yGsmahK4=;
        b=COKljX0xTFzt/gteWlAZu2JnN9ggQBSiWNedueCypzcCZoomqSBvoGd9Qcj3XIedsu
         h/VX0P7ivcb7zmCds4XnbIt70p1ZbGg/SOnqc3DMZwgtZhrAtATLdE7lDuwy5Be/RL2Z
         FvpjKynqePzlOspaF4P4Ka1BTVu3FmrMP4JC2B4c47wiqPmOjsClGe7Y7OBSsWhnypkK
         9rdX1vva+yNWO5W3nGUdvBR7tk3hmEBd3TvOgL+AJEd4andr+5rRUzDb8sXBTd4Im9fr
         yx3hH1WtsgRgguelliQYzKvv8FIjkWwdPakMCMcKjujDqDiS8fvfOyDsLKLV7ysotxdO
         Wgdw==
X-Gm-Message-State: AOJu0YyDUiWbx684UYkB5ulg2vXQ5xC7MnuuDRInkWsVhtdjCaLDOsxU
        8bhsEBxGFj+xZtQ9u287yCU=
X-Google-Smtp-Source: AGHT+IFCJ5uhFMa9UQBccJQFldcy0wGcJJMreMajDOT+ujV7O+GPfiBD+Y9Nm99019ZGG8zjba2oyA==
X-Received: by 2002:a2e:80ca:0:b0:2bf:f985:7729 with SMTP id r10-20020a2e80ca000000b002bff9857729mr876605ljg.17.1695904238108;
        Thu, 28 Sep 2023 05:30:38 -0700 (PDT)
Received: from PC10319.67 ([82.97.198.254])
        by smtp.googlemail.com with ESMTPSA id x6-20020a2e9c86000000b002ba045496d0sm3588724lji.125.2023.09.28.05.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 05:30:37 -0700 (PDT)
From:   Konstantin Aladyshev <aladyshev22@gmail.com>
Cc:     minyard@acm.org, joel@jms.id.au, andrew@aj.id.au,
        avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        aladyshev22@gmail.com, jk@codeconstruct.com.au,
        matt@codeconstruct.com.au, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        netdev@vger.kernel.org
Subject: [PATCH 2/3] ipmi: Create header with KCS interface defines
Date:   Thu, 28 Sep 2023 15:30:08 +0300
Message-Id: <20230928123009.2913-3-aladyshev22@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230928123009.2913-1-aladyshev22@gmail.com>
References: <20230928123009.2913-1-aladyshev22@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some definitions from the current kcs_bmc_cdev_ipmi driver can be also
utilized by the MTCP KCS binding driver. Move such definitions to the
common header file.

Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com>
---
 drivers/char/ipmi/kcs_bmc_cdev_ipmi.c | 71 +-----------------------
 include/linux/ipmi_kcs.h              | 80 +++++++++++++++++++++++++++
 2 files changed, 81 insertions(+), 70 deletions(-)
 create mode 100644 include/linux/ipmi_kcs.h

diff --git a/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c b/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c
index bf1001130a6c..f158f676114c 100644
--- a/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c
+++ b/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c
@@ -8,6 +8,7 @@
 #include <linux/errno.h>
 #include <linux/io.h>
 #include <linux/ipmi_bmc.h>
+#include <linux/ipmi_kcs.h>
 #include <linux/kcs_bmc_client.h>
 #include <linux/list.h>
 #include <linux/miscdevice.h>
@@ -19,53 +20,6 @@
 #include <linux/slab.h>
 
 
-/* Different phases of the KCS BMC module.
- *  KCS_PHASE_IDLE:
- *            BMC should not be expecting nor sending any data.
- *  KCS_PHASE_WRITE_START:
- *            BMC is receiving a WRITE_START command from system software.
- *  KCS_PHASE_WRITE_DATA:
- *            BMC is receiving a data byte from system software.
- *  KCS_PHASE_WRITE_END_CMD:
- *            BMC is waiting a last data byte from system software.
- *  KCS_PHASE_WRITE_DONE:
- *            BMC has received the whole request from system software.
- *  KCS_PHASE_WAIT_READ:
- *            BMC is waiting the response from the upper IPMI service.
- *  KCS_PHASE_READ:
- *            BMC is transferring the response to system software.
- *  KCS_PHASE_ABORT_ERROR1:
- *            BMC is waiting error status request from system software.
- *  KCS_PHASE_ABORT_ERROR2:
- *            BMC is waiting for idle status afer error from system software.
- *  KCS_PHASE_ERROR:
- *            BMC has detected a protocol violation at the interface level.
- */
-enum kcs_ipmi_phases {
-	KCS_PHASE_IDLE,
-
-	KCS_PHASE_WRITE_START,
-	KCS_PHASE_WRITE_DATA,
-	KCS_PHASE_WRITE_END_CMD,
-	KCS_PHASE_WRITE_DONE,
-
-	KCS_PHASE_WAIT_READ,
-	KCS_PHASE_READ,
-
-	KCS_PHASE_ABORT_ERROR1,
-	KCS_PHASE_ABORT_ERROR2,
-	KCS_PHASE_ERROR
-};
-
-/* IPMI 2.0 - Table 9-4, KCS Interface Status Codes */
-enum kcs_ipmi_errors {
-	KCS_NO_ERROR                = 0x00,
-	KCS_ABORTED_BY_COMMAND      = 0x01,
-	KCS_ILLEGAL_CONTROL_CODE    = 0x02,
-	KCS_LENGTH_ERROR            = 0x06,
-	KCS_UNSPECIFIED_ERROR       = 0xFF
-};
-
 struct kcs_bmc_ipmi {
 	struct list_head entry;
 
@@ -95,29 +49,6 @@ struct kcs_bmc_ipmi {
 
 #define KCS_MSG_BUFSIZ    1000
 
-#define KCS_ZERO_DATA     0
-
-/* IPMI 2.0 - Table 9-1, KCS Interface Status Register Bits */
-#define KCS_STATUS_STATE(state) (state << 6)
-#define KCS_STATUS_STATE_MASK   GENMASK(7, 6)
-#define KCS_STATUS_CMD_DAT      BIT(3)
-#define KCS_STATUS_SMS_ATN      BIT(2)
-#define KCS_STATUS_IBF          BIT(1)
-#define KCS_STATUS_OBF          BIT(0)
-
-/* IPMI 2.0 - Table 9-2, KCS Interface State Bits */
-enum kcs_states {
-	IDLE_STATE  = 0,
-	READ_STATE  = 1,
-	WRITE_STATE = 2,
-	ERROR_STATE = 3,
-};
-
-/* IPMI 2.0 - Table 9-3, KCS Interface Control Codes */
-#define KCS_CMD_GET_STATUS_ABORT  0x60
-#define KCS_CMD_WRITE_START       0x61
-#define KCS_CMD_WRITE_END         0x62
-#define KCS_CMD_READ_BYTE         0x68
 
 static inline void set_state(struct kcs_bmc_ipmi *priv, u8 state)
 {
diff --git a/include/linux/ipmi_kcs.h b/include/linux/ipmi_kcs.h
new file mode 100644
index 000000000000..30c4b6e4d689
--- /dev/null
+++ b/include/linux/ipmi_kcs.h
@@ -0,0 +1,80 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2015-2018, Intel Corporation.
+ */
+
+#ifndef __IPMI_KCS_H__
+#define __IPMI_KCS_H__
+
+/* Different phases of the KCS BMC module.
+ *  KCS_PHASE_IDLE:
+ *            BMC should not be expecting nor sending any data.
+ *  KCS_PHASE_WRITE_START:
+ *            BMC is receiving a WRITE_START command from system software.
+ *  KCS_PHASE_WRITE_DATA:
+ *            BMC is receiving a data byte from system software.
+ *  KCS_PHASE_WRITE_END_CMD:
+ *            BMC is waiting a last data byte from system software.
+ *  KCS_PHASE_WRITE_DONE:
+ *            BMC has received the whole request from system software.
+ *  KCS_PHASE_WAIT_READ:
+ *            BMC is waiting the response from the upper IPMI service.
+ *  KCS_PHASE_READ:
+ *            BMC is transferring the response to system software.
+ *  KCS_PHASE_ABORT_ERROR1:
+ *            BMC is waiting error status request from system software.
+ *  KCS_PHASE_ABORT_ERROR2:
+ *            BMC is waiting for idle status afer error from system software.
+ *  KCS_PHASE_ERROR:
+ *            BMC has detected a protocol violation at the interface level.
+ */
+enum kcs_ipmi_phases {
+	KCS_PHASE_IDLE,
+
+	KCS_PHASE_WRITE_START,
+	KCS_PHASE_WRITE_DATA,
+	KCS_PHASE_WRITE_END_CMD,
+	KCS_PHASE_WRITE_DONE,
+
+	KCS_PHASE_WAIT_READ,
+	KCS_PHASE_READ,
+
+	KCS_PHASE_ABORT_ERROR1,
+	KCS_PHASE_ABORT_ERROR2,
+	KCS_PHASE_ERROR
+};
+
+/* IPMI 2.0 - Table 9-4, KCS Interface Status Codes */
+enum kcs_ipmi_errors {
+	KCS_NO_ERROR                = 0x00,
+	KCS_ABORTED_BY_COMMAND      = 0x01,
+	KCS_ILLEGAL_CONTROL_CODE    = 0x02,
+	KCS_LENGTH_ERROR            = 0x06,
+	KCS_UNSPECIFIED_ERROR       = 0xFF
+};
+
+#define KCS_ZERO_DATA     0
+
+/* IPMI 2.0 - Table 9-1, KCS Interface Status Register Bits */
+#define KCS_STATUS_STATE(state) (state << 6)
+#define KCS_STATUS_STATE_MASK   GENMASK(7, 6)
+#define KCS_STATUS_CMD_DAT      BIT(3)
+#define KCS_STATUS_SMS_ATN      BIT(2)
+#define KCS_STATUS_IBF          BIT(1)
+#define KCS_STATUS_OBF          BIT(0)
+
+/* IPMI 2.0 - Table 9-2, KCS Interface State Bits */
+enum kcs_states {
+	IDLE_STATE  = 0,
+	READ_STATE  = 1,
+	WRITE_STATE = 2,
+	ERROR_STATE = 3,
+};
+
+/* IPMI 2.0 - Table 9-3, KCS Interface Control Codes */
+#define KCS_CMD_GET_STATUS_ABORT  0x60
+#define KCS_CMD_WRITE_START       0x61
+#define KCS_CMD_WRITE_END         0x62
+#define KCS_CMD_READ_BYTE         0x68
+
+#endif /* __IPMI_KCS_H__ */
-- 
2.25.1

