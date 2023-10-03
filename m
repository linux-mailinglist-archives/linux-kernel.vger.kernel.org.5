Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E56857B6B0B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 16:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238471AbjJCOHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 10:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238043AbjJCOHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 10:07:11 -0400
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28899AB
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 07:07:07 -0700 (PDT)
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 393Bv3Pq029740;
        Tue, 3 Oct 2023 16:06:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        selector1; bh=2vVG68qKGR1o1X2zz9Zf7c8pKOPt5h+j39QeCuRRJQE=; b=La
        I0P+Cp9m6qw9gfpF2XijY85bHT3FO7Lz2eG/qfyKGVLrfhpdliqDexpO6r6sjU6z
        MkM7PLOW37KrrBhKowE8g8IotAqV94bT5yufGLkExvqLtCSM4HGLcJxsZFKLHVpv
        0xm8dod75wZX3mafvicYmq8Qwi2/ji1nC6gHYfjGP8qLOz4y4SieHjgVP3Z2bCTa
        NK2VaEtPOD3GRvVV6RdHYT76C4619Xmdh3xCIz/D3wnu/smwSpG8oR81yIOXUGof
        is5/vI9ZkBb+4nqxHAg8jfB47oGVcT/2mIMrBNa5BHLOSprnpAjbc11Ni0evIlP9
        DuVRXtcowIDM3f3BNqZQ==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3texmj2bsa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Oct 2023 16:06:49 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8235E10005C;
        Tue,  3 Oct 2023 16:06:48 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7A1062634F9;
        Tue,  3 Oct 2023 16:06:48 +0200 (CEST)
Received: from localhost (10.201.20.20) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 3 Oct
 2023 16:06:48 +0200
From:   Etienne Carriere <etienne.carriere@foss.st.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <op-tee@lists.trustedfirmware.org>,
        Jerome Forissier <jerome.forissier@linaro.org>,
        Etienne Carriere <etienne.carriere@foss.st.com>
Subject: [PATCH v10 2/4] tee: system session
Date:   Tue, 3 Oct 2023 16:06:35 +0200
Message-ID: <20231003140637.31346-3-etienne.carriere@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231003140637.31346-1-etienne.carriere@foss.st.com>
References: <20231003140637.31346-1-etienne.carriere@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.20]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-03_11,2023-10-02_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds kernel client API function tee_client_system_session() for a client
to request a system service entry in TEE context.

This feature is needed to prevent a system deadlock when several TEE
client applications invoke TEE, consuming all TEE thread contexts
available in the secure world. The deadlock can happen in the OP-TEE
driver for example if all these TEE threads issue an RPC call from TEE
to Linux OS to access an eMMC RPMB partition (TEE secure storage) which
device clock or regulator controller is accessed through an OP-TEE SCMI
services. In that case, Linux SCMI driver must reach OP-TEE SCMI service
without waiting until one of the consumed TEE threads is freed.

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Etienne Carriere <etienne.carriere@foss.st.com>
---
Changes since v9:
- Updated my e-mail address.

No change since v8
No change since v7

Changes since v6:
- Fixed commit message from review comments.
- Applied Sumit's R-b tag.

No change since v5

Changes since v4:
- Changes extracted from "[PATCH v4 1/2] tee: system invocation" and
  revised with Jens contribution to cover only definition of tee driver
  new API function tee_client_system_session() for kernel clients to
  register their session as a system session.
- Commit message rephrased, including header line changed from
  "tee: system invocation" to "tee: system session" has the feature
  relates to system attributes of tee sessions.

Changes since v3:
- Fixed new SMC funcIDs to reserved/unreserve OP-TEE thread contexts:
  minor renaming + define as fastcall funcIDs.
- Moved system_ctx_count from generic struct tee_context to optee's
  private struct optee_context_data. This changes optee smc_abi.c
  to release reserved thread contexts when the optee device is released.
- Fixed inline description comments.

No change since v2

Change since v1
- Addressed comment on Linux client to claim reservation on TEE context.
  This brings 2 new operations from client to TEE to request and release
  system thread contexts: 2 new tee_drv.h API functions, 2 new ops
  functions in struct tee_driver_ops. The OP-TEE implement shall implement
  2 new fastcall SMC funcIDs.
- Fixed typos in commit message.
---
 drivers/tee/tee_core.c  |  8 ++++++++
 include/linux/tee_drv.h | 16 ++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index 0eb342de0b00..91932835d0f7 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -1170,6 +1170,14 @@ int tee_client_close_session(struct tee_context *ctx, u32 session)
 }
 EXPORT_SYMBOL_GPL(tee_client_close_session);
 
+int tee_client_system_session(struct tee_context *ctx, u32 session)
+{
+	if (!ctx->teedev->desc->ops->system_session)
+		return -EINVAL;
+	return ctx->teedev->desc->ops->system_session(ctx, session);
+}
+EXPORT_SYMBOL_GPL(tee_client_system_session);
+
 int tee_client_invoke_func(struct tee_context *ctx,
 			   struct tee_ioctl_invoke_arg *arg,
 			   struct tee_param *param)
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index 17eb1c5205d3..911ddf92dcee 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -84,6 +84,7 @@ struct tee_param {
  * @release:		release this open file
  * @open_session:	open a new session
  * @close_session:	close a session
+ * @system_session:	declare session as a system session
  * @invoke_func:	invoke a trusted function
  * @cancel_req:		request cancel of an ongoing invoke or open
  * @supp_recv:		called for supplicant to get a command
@@ -100,6 +101,7 @@ struct tee_driver_ops {
 			    struct tee_ioctl_open_session_arg *arg,
 			    struct tee_param *param);
 	int (*close_session)(struct tee_context *ctx, u32 session);
+	int (*system_session)(struct tee_context *ctx, u32 session);
 	int (*invoke_func)(struct tee_context *ctx,
 			   struct tee_ioctl_invoke_arg *arg,
 			   struct tee_param *param);
@@ -429,6 +431,20 @@ int tee_client_open_session(struct tee_context *ctx,
  */
 int tee_client_close_session(struct tee_context *ctx, u32 session);
 
+/**
+ * tee_client_system_session() - Declare session as a system session
+ * @ctx:	TEE Context
+ * @session:	Session id
+ *
+ * This function requests TEE to provision an entry context ready to use for
+ * that session only. The provisioned entry context is used for command
+ * invocation and session closure, not for command cancelling requests.
+ * TEE releases the provisioned context upon session closure.
+ *
+ * Return < 0 on error else 0 if an entry context has been provisioned.
+ */
+int tee_client_system_session(struct tee_context *ctx, u32 session);
+
 /**
  * tee_client_invoke_func() - Invoke a function in a Trusted Application
  * @ctx:	TEE Context
-- 
2.25.1

