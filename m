Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C449798633
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 12:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239825AbjIHKyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 06:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235988AbjIHKx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 06:53:59 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215AA11B
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 03:53:54 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-31dca134c83so1794227f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 03:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694170432; x=1694775232; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dx3jOjkUg4FGy/6wKVeSXmy79S1Uj0gNvAvSXrERuGk=;
        b=JPvPziQCxMWMj/yJDeSXRsX7iiMSqZEXndsaGyIMbM5EtWRwyTKLexovNm5uMqQ0OU
         fznXYYvZTnEl5IeFcTBvdMk6X5o/wxI3jt5GKS0BUE+6K+1JXPJc5ick9xL1DYldkETG
         XC5Zs+kwa+4m3tM6dHAh937NOyJ4X6o3i67xgDubM7xtNrhcaAkvqazHtfG0nRToKVOu
         1G2g5DNVVWqu7AlCx/Mf5iJmScfH4EGIlzWNsgBf33KR8958GYbrGcb9trKXt5GEWjih
         agyYT7/fJPRDToF+ZJYThUoMOyh4oP9kNU/okURE7q6hbddmZ4CKYRnLGD1/kkYb66xB
         bHQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694170432; x=1694775232;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dx3jOjkUg4FGy/6wKVeSXmy79S1Uj0gNvAvSXrERuGk=;
        b=pJ+orsnvuRVE/ef9ZCvNP8Zij/JCOcLLHAbM6F7Apt5KXEeCymneDB01OB3A62oCyI
         NHEna/5DcoEQqjMA4jO1S43W/ijEyDD2OUDZ5dQulBh7w6UuVqKitBtmIkmiTzafQgv5
         rl23wW+8lwvtNWclJYvtwOUDd2YHcqSp0dLf/XjSSdlmiM1IL5xQN0199JWTM5HHW+sL
         bP++nOkHaxsb17zTgni7xeX6bGmJ3/AxRnDpsYRKzqjUW7Xm/RQsK/iA7RJGnnSH3QT4
         IrcRUKidaEUc5bSoPnkq3kUdVSHrBIMzgxsLiI3k27egbO5Rjg90mUmgRM+xp2BY8BEK
         IbjA==
X-Gm-Message-State: AOJu0YzVIOar/LjKjPWXUmn7J7Din8RuLfplQCrSwpnFbqaCiIbs6nU5
        3LcBMHl9CnoL7yqY936frDqXwd0GCFcexvqseuBhW94N
X-Google-Smtp-Source: AGHT+IFioS5tUoFvzYcHjlAkpCwG9IQFXv1LdIfKrj46Yy0K+iG5tAD7CqVrlS4lHl+I+wJ1yGdOQg==
X-Received: by 2002:a5d:5001:0:b0:31d:cf59:8d8 with SMTP id e1-20020a5d5001000000b0031dcf5908d8mr1768606wrt.14.1694170432459;
        Fri, 08 Sep 2023 03:53:52 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id b13-20020a5d634d000000b0031c5e9c2ed7sm1772461wrw.92.2023.09.08.03.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 03:53:51 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Fri, 08 Sep 2023 12:53:49 +0200
Subject: [PATCH] soc: qcom: add ADSP PDCharger ULOG driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230908-topic-sm8550-upstream-pdcharge-ulog-v1-1-d1b16b02ced2@linaro.org>
X-B4-Tracking: v=1; b=H4sIADz9+mQC/x2NQQqDQAwAvyI5N7BGpW6/UjzImtpAdZdES0H8u
 6HHgWHmAGMVNnhUByh/xSSvDvWtgvQe15lRJmegQE2IocctF0loS991Afdim/K4YJncVrf3T56
 Rak4cKVJ7b8FLRfklv//lOZznBQN8iBJ1AAAA
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7865;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=jTCBmnYNJ4DFHTol6QTLZgHlusJDBbr0AWMK6CSENK4=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBk+v0/wenW1yIZE+MZ/5xRhTR+aI7lPu7mUreZBtbQ
 7tO+Fq2JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZPr9PwAKCRB33NvayMhJ0ZW5D/
 99w7Tn4wzwLr7crve2PobMDFDlARha6XZY0iM/G5PPTY2N6RiulP3BXWB7Lg5qPN6EeaLfrZghw2bl
 QrPWnjhIEan7E9JYPMdmaFo02GJhi3PUCHgeDFEMns6u/VODHKfBuEooUKZlwIxg+ZvhdC3zRtI96k
 KFmkI8vj5YHh12RbyR7jWH6u7W4rFWnWfWbdMOz39EbEJzQ3Y7Je1zZEkSyru2e8grxoEq/OtIXFde
 2grEm/AnrB3PxtuybJxcChzDNi4Am5JNclGUqLghnLLhk+3YuIj/dz/OYLy5w+GE7R3SpD4NzGXttW
 9voNBvg7nmoS3/mxGOfBWs3qFpTccPCQs8CHTlL39zUYdwWs9vGmlJrWBDitxU0zrBSIGgUUNk9DWw
 ME3HeJF92LuI3nW1r4vZax1xWu1KWIy4xzrga9WUdmLBJALToA4lvVWBu4EfqYfMzIIrntaHdRhHT0
 CXg5wd+9kxD0nT9dmnvFF8qfuFyQgOrwChfGbBkMnpuEvEYLDa3vg8Xce8b5U2IWJ+sdTI2dpqU4/r
 iHgOrZ45DosbBHYEFOP5zLSErMBoWiVdNPYSqoGh/wRBRxRrjYXMnkG6yQdm7dkNZ/ECj5PdizquBP
 8EXkKepeVpQglxRkWso53kQbp6ThD9sBOQzOtvzJE6l2QrtS1NWyLDVH+W7w==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qualcomm PMIC PDCharger ULOG driver provides access to logs of
the ADSP firmware PDCharger module in charge of Battery and Power
Delivery on modern systems.

Implement trace events as a simple rpmsg driver with an 1s interval
to retrieve the messages.

The interface allows filtering the messages by subsystem and priority
level, this could be implemented later on.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/soc/qcom/Kconfig               |  12 +++
 drivers/soc/qcom/Makefile              |   1 +
 drivers/soc/qcom/pmic_pdcharger_ulog.c | 166 +++++++++++++++++++++++++++++++++
 drivers/soc/qcom/pmic_pdcharger_ulog.h |  36 +++++++
 4 files changed, 215 insertions(+)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index e597799e8121..5f63df3d5d6f 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -93,6 +93,18 @@ config QCOM_PDR_HELPERS
 	select QCOM_QMI_HELPERS
 	depends on NET
 
+config QCOM_PMIC_PDCHARGER_ULOG
+	tristate "Qualcomm PMIC PDCharger ULOG driver"
+	depends on RPMSG
+	depends on EVENT_TRACING
+	help
+	  The Qualcomm PMIC PDCharger ULOG driver provides access to logs of
+	  the ADSP firmware PDCharger module in charge of Battery and Power
+	  Delivery on modern systems.
+
+	  Say yes here to support PDCharger ULOG event tracing on modern
+	  Qualcomm platforms.
+
 config QCOM_PMIC_GLINK
 	tristate "Qualcomm PMIC GLINK driver"
 	depends on RPMSG
diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index 99114c71092b..44f6efe9a48c 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_QCOM_OCMEM)	+= ocmem.o
 obj-$(CONFIG_QCOM_PDR_HELPERS)	+= pdr_interface.o
 obj-$(CONFIG_QCOM_PMIC_GLINK)	+= pmic_glink.o
 obj-$(CONFIG_QCOM_PMIC_GLINK)	+= pmic_glink_altmode.o
+obj-$(CONFIG_QCOM_PMIC_PDCHARGER_ULOG)	+= pmic_pdcharger_ulog.o
 obj-$(CONFIG_QCOM_QMI_HELPERS)	+= qmi_helpers.o
 qmi_helpers-y	+= qmi_encdec.o qmi_interface.o
 obj-$(CONFIG_QCOM_RAMP_CTRL)	+= ramp_controller.o
diff --git a/drivers/soc/qcom/pmic_pdcharger_ulog.c b/drivers/soc/qcom/pmic_pdcharger_ulog.c
new file mode 100644
index 000000000000..f1aaacf05005
--- /dev/null
+++ b/drivers/soc/qcom/pmic_pdcharger_ulog.c
@@ -0,0 +1,166 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2019-2022, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023, Linaro Ltd
+ */
+#include <linux/of_device.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/rpmsg.h>
+#include <linux/slab.h>
+#include <linux/soc/qcom/pdr.h>
+#include <linux/debugfs.h>
+
+#define CREATE_TRACE_POINTS
+#include "pmic_pdcharger_ulog.h"
+
+#define MSG_OWNER_CHG_ULOG		32778
+#define MSG_TYPE_REQ_RESP		1
+
+#define GET_CHG_ULOG_REQ		0x18
+#define SET_CHG_ULOG_PROP_REQ		0x19
+
+#define LOG_DEFAULT_TIME_MS		1000
+
+#define MAX_ULOG_SIZE			8192
+
+struct pmic_pdcharger_ulog_hdr {
+	__le32 owner;
+	__le32 type;
+	__le32 opcode;
+};
+
+struct pmic_pdcharger_ulog {
+	struct rpmsg_device *rpdev;
+	struct delayed_work ulog_work;
+};
+
+struct get_ulog_req_msg {
+	struct pmic_pdcharger_ulog_hdr	hdr;
+	u32				log_size;
+};
+
+struct get_ulog_resp_msg {
+	struct pmic_pdcharger_ulog_hdr	hdr;
+	u8				buf[MAX_ULOG_SIZE];
+};
+
+static int pmic_pdcharger_ulog_write_async(struct pmic_pdcharger_ulog *pg, void *data, size_t len)
+{
+	return rpmsg_send(pg->rpdev->ept, data, len);
+}
+
+static int pmic_pdcharger_ulog_request(struct pmic_pdcharger_ulog *pg)
+{
+	struct get_ulog_req_msg req_msg = {
+		.hdr = {
+			.owner = MSG_OWNER_CHG_ULOG,
+			.type = MSG_TYPE_REQ_RESP,
+			.opcode = GET_CHG_ULOG_REQ
+		},
+		.log_size = MAX_ULOG_SIZE
+	};
+
+	return pmic_pdcharger_ulog_write_async(pg, &req_msg, sizeof(req_msg));
+}
+
+static void pmic_pdcharger_ulog_work(struct work_struct *work)
+{
+	struct pmic_pdcharger_ulog *pg = container_of(work, struct pmic_pdcharger_ulog,
+						      ulog_work.work);
+	int rc;
+
+	rc = pmic_pdcharger_ulog_request(pg);
+	if (rc) {
+		dev_err(&pg->rpdev->dev, "Error requesting ulog, rc=%d\n", rc);
+		return;
+	}
+}
+
+static void pmic_pdcharger_ulog_handle_message(struct pmic_pdcharger_ulog *pg,
+					       struct get_ulog_resp_msg *resp_msg,
+					       size_t len)
+{
+	char *token, *buf = resp_msg->buf;
+
+	if (len != sizeof(*resp_msg)) {
+		dev_err(&pg->rpdev->dev, "Expected data length: %zu, received: %zu\n",
+			sizeof(*resp_msg), len);
+		return;
+	}
+
+	buf[MAX_ULOG_SIZE - 1] = '\0';
+
+	do {
+		token = strsep((char **)&buf, "\n");
+		if (token && strlen(token))
+			trace_pmic_pdcharger_ulog_msg(token);
+	} while (token);
+}
+
+static int pmic_pdcharger_ulog_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
+					      int len, void *priv, u32 addr)
+{
+	struct pmic_pdcharger_ulog *pg = dev_get_drvdata(&rpdev->dev);
+	struct pmic_pdcharger_ulog_hdr *hdr = data;
+	u32 opcode;
+
+	opcode = le32_to_cpu(hdr->opcode);
+
+	switch (opcode) {
+	case GET_CHG_ULOG_REQ:
+		schedule_delayed_work(&pg->ulog_work, msecs_to_jiffies(LOG_DEFAULT_TIME_MS));
+		pmic_pdcharger_ulog_handle_message(pg, data, len);
+		break;
+	default:
+		dev_err(&pg->rpdev->dev, "Unknown opcode %u\n", opcode);
+		break;
+	}
+
+	return 0;
+}
+
+static int pmic_pdcharger_ulog_rpmsg_probe(struct rpmsg_device *rpdev)
+{
+	struct pmic_pdcharger_ulog *pg;
+	struct device *dev = &rpdev->dev;
+
+	pg = devm_kzalloc(dev, sizeof(*pg), GFP_KERNEL);
+	if (!pg)
+		return -ENOMEM;
+
+	pg->rpdev = rpdev;
+	INIT_DELAYED_WORK(&pg->ulog_work, pmic_pdcharger_ulog_work);
+
+	dev_set_drvdata(dev, pg);
+
+	pmic_pdcharger_ulog_request(pg);
+
+	return 0;
+}
+
+static void pmic_pdcharger_ulog_rpmsg_remove(struct rpmsg_device *rpdev)
+{
+	struct pmic_pdcharger_ulog *pg = dev_get_drvdata(&rpdev->dev);
+
+	cancel_delayed_work_sync(&pg->ulog_work);
+}
+
+static const struct rpmsg_device_id pmic_pdcharger_ulog_rpmsg_id_match[] = {
+	{ "PMIC_LOGS_ADSP_APPS" },
+	{}
+};
+
+static struct rpmsg_driver pmic_pdcharger_ulog_rpmsg_driver = {
+	.probe = pmic_pdcharger_ulog_rpmsg_probe,
+	.remove = pmic_pdcharger_ulog_rpmsg_remove,
+	.callback = pmic_pdcharger_ulog_rpmsg_callback,
+	.id_table = pmic_pdcharger_ulog_rpmsg_id_match,
+	.drv  = {
+		.name  = "qcom_pmic_pdcharger_ulog_rpmsg",
+	},
+};
+
+module_rpmsg_driver(pmic_pdcharger_ulog_rpmsg_driver);
+MODULE_DESCRIPTION("Qualcomm PMIC ChargerPD ULOG driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/soc/qcom/pmic_pdcharger_ulog.h b/drivers/soc/qcom/pmic_pdcharger_ulog.h
new file mode 100644
index 000000000000..9d5d9af4fbe4
--- /dev/null
+++ b/drivers/soc/qcom/pmic_pdcharger_ulog.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2023, Linaro Ltd
+ */
+
+#if !defined(_TRACE_PMIC_PDCHARGER_ULOG_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_PMIC_PDCHARGER_ULOG_H
+
+#include <linux/tracepoint.h>
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM pmic_pdcharger_ulog
+
+TRACE_EVENT(pmic_pdcharger_ulog_msg,
+	TP_PROTO(char *msg),
+	TP_ARGS(msg),
+	TP_STRUCT__entry(
+		__string(msg, msg)
+	),
+	TP_fast_assign(
+		__assign_str(msg, msg);
+	),
+	TP_printk("%s", __get_str(msg))
+);
+
+#endif /* _TRACE_PMIC_PDCHARGER_ULOG_H */
+
+/* This part must be outside protection */
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE pmic_pdcharger_ulog
+
+#include <trace/define_trace.h>

---
base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
change-id: 20230908-topic-sm8550-upstream-pdcharge-ulog-21ece9292474

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

