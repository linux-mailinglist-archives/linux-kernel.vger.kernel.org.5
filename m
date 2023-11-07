Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 486FE7E45FB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 17:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235660AbjKGQ2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 11:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235589AbjKGQ23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 11:28:29 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E065A275
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 08:07:23 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-5bcf83a8f6cso4402623a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 08:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699373243; x=1699978043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ax3rw5j93gR8kifbRCXEEtxtkHqwBSo8uAJ32Orsuu0=;
        b=icgR7qEEvtIeLmIpYyRB8YxMPm4aKXb7Von6dTvL55L8aF5/uOd/Fuu459UhjeX5RW
         GqHmSvmOm/RCdDtu2Jnl7cBaMuhRX5PlMZfynfvHi0aRMiq7BOo18WhBr5g3dPQmYhBH
         eJXlsQVq7DtZPJdgw24S5nmfVKFsurYQgOwl0U1DWQy85TDkMrqUCyFfQ3RxIUzj/MPa
         HGxiMp6eqE2Ml+fk8DkrxvlWm/faHhfAnSSHJqJNVGnKA1em/6ZXzXkkuJw1QLmDM60k
         L2vhhXo5tLtt9sRhlkuYQO4MFHC5KzKX8ymxWdZHFm0RpjOL8Xqh5gwQ4DruDZOkOoOR
         mlPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699373243; x=1699978043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ax3rw5j93gR8kifbRCXEEtxtkHqwBSo8uAJ32Orsuu0=;
        b=A6OhJLQY9Pt1I5QF5JAbNlYNHvBRO/tzp1jQh07uWqZT+Y28DCQEB7Rq0HDUuERr19
         +F20Kcz4hzhM18cRZvA4QmnIbGLgT4mEFQcrqZ90BNJEJT0s+4laPyvH0aQD4oj65jbp
         bgv+OFV+IJf9BGgCoSen3QQAm8Wt8OGJNmJI/gwOtlYBqHKpM43JKGmMdNWRi9CPo+QH
         nkg5d48xi8Kwiw36ayS6BoMPu+CvbVEkbJXwYduUZNKeMOPIMLBNopJGNg6kyxuyWufa
         I41LF1DeegXxZUbs8cCRDrHe48KkcXbhTd0P4joqHnyWl+A87Lqup4wP2T9qu20q45gj
         YsWA==
X-Gm-Message-State: AOJu0Yxr2Az6NfTSAJgCeNe2v65fxd2rWHonPFJrn6xlvQaI4zoxrv+x
        /mw8FAzAJ+h68csNspz9fSlItGEU9p3cvQ5DPhQ=
X-Google-Smtp-Source: AGHT+IHLnOK+WdwAxlJLVVAapbuBd56AtLS/B597Q980YSWOYjRVJKamoPDFGv5VgAPCV+I97Q11lQ==
X-Received: by 2002:a17:90b:4ac8:b0:281:b51:a06d with SMTP id mh8-20020a17090b4ac800b002810b51a06dmr4631049pjb.33.1699373242616;
        Tue, 07 Nov 2023 08:07:22 -0800 (PST)
Received: from rayden.urgonet (h-217-31-164-171.A175.priv.bahnhof.se. [217.31.164.171])
        by smtp.gmail.com with ESMTPSA id o3-20020a17090ab88300b002775281b9easm13437pjr.50.2023.11.07.08.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 08:07:22 -0800 (PST)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Jerome Forissier <jerome.forissier@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Olivier Deprez <Olivier.Deprez@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v2 2/2] optee: ffa_abi: add asynchronous notifications
Date:   Tue,  7 Nov 2023 17:06:57 +0100
Message-Id: <20231107160657.3798803-3-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107160657.3798803-1-jens.wiklander@linaro.org>
References: <20231107160657.3798803-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds support for asynchronous notifications from OP-TEE in secure world
when communicating via FF-A. In principle from OP-TEE and kernel driver
point of view this works in the same way as for the SMC ABI based
implementation.

The OP-TEE FF-A ABI is expanded in OPTEE_FFA_EXCHANGE_CAPABILITIES with
the capability OPTEE_FFA_SEC_CAP_ASYNC_NOTIF to indicate that OP-TEE
supports asynchronous notifications. OPTEE_FFA_ENABLE_ASYNC_NOTIF is
also added to tell that the driver has successfully initialized these
notifications.

Notification capability is negotiated while the driver is initialized.
If both sides supports these notifications then they are enabled.

The notification concept in this driver is merged with the FF-A concept,
the lower 64 values are reserved for FF-A as asynchronous notifications
while the synchronous notifications use the higher values.

So a FF-A notification has to be allocated for each discrete
asynchronous notification value needed. Only one asynchronous
notification value is used at the moment, the "do bottom half"
notification.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/tee/optee/ffa_abi.c       | 93 ++++++++++++++++++++++++++++++-
 drivers/tee/optee/optee_ffa.h     | 28 ++++++++--
 drivers/tee/optee/optee_private.h |  4 +-
 3 files changed, 117 insertions(+), 8 deletions(-)

diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
index 0828240f27e6..60823b41b9ad 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (c) 2021, Linaro Limited
+ * Copyright (c) 2021, 2023 Linaro Limited
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
@@ -692,7 +692,8 @@ static bool optee_ffa_api_is_compatbile(struct ffa_device *ffa_dev,
 static bool optee_ffa_exchange_caps(struct ffa_device *ffa_dev,
 				    const struct ffa_ops *ops,
 				    u32 *sec_caps,
-				    unsigned int *rpc_param_count)
+				    unsigned int *rpc_param_count,
+				    unsigned int *max_notif_value)
 {
 	struct ffa_send_direct_data data = { OPTEE_FFA_EXCHANGE_CAPABILITIES };
 	int rc;
@@ -709,10 +710,39 @@ static bool optee_ffa_exchange_caps(struct ffa_device *ffa_dev,
 
 	*rpc_param_count = (u8)data.data1;
 	*sec_caps = data.data2;
+	if (data.data3)
+		*max_notif_value = data.data3;
+	else
+		*max_notif_value = OPTEE_DEFAULT_MAX_NOTIF_VALUE;
 
 	return true;
 }
 
+static void notif_callback(int notify_id, void *cb_data)
+{
+	struct optee *optee = cb_data;
+
+	if (notify_id == optee->ffa.bottom_half_value)
+		optee_do_bottom_half(optee->ctx);
+	else
+		optee_notif_send(optee, notify_id);
+}
+
+static int enable_async_notif(struct optee *optee)
+{
+	struct ffa_device *ffa_dev = optee->ffa.ffa_dev;
+	struct ffa_send_direct_data data = {
+		.data0 = OPTEE_FFA_ENABLE_ASYNC_NOTIF,
+		.data1 = optee->ffa.bottom_half_value,
+	};
+	int rc;
+
+	rc = ffa_dev->ops->msg_ops->sync_send_receive(ffa_dev, &data);
+	if (rc)
+		return rc;
+	return data.data0;
+}
+
 static void optee_ffa_get_version(struct tee_device *teedev,
 				  struct tee_ioctl_version_data *vers)
 {
@@ -775,7 +805,11 @@ static const struct optee_ops optee_ffa_ops = {
 static void optee_ffa_remove(struct ffa_device *ffa_dev)
 {
 	struct optee *optee = ffa_dev_get_drvdata(ffa_dev);
+	u32 bottom_half_id = optee->ffa.bottom_half_value;
 
+	if (bottom_half_id != U32_MAX)
+		ffa_dev->ops->notifier_ops->notify_relinquish(ffa_dev,
+							      bottom_half_id);
 	optee_remove_common(optee);
 
 	mutex_destroy(&optee->ffa.mutex);
@@ -784,9 +818,51 @@ static void optee_ffa_remove(struct ffa_device *ffa_dev)
 	kfree(optee);
 }
 
+static int optee_ffa_async_notif_init(struct ffa_device *ffa_dev,
+				      struct optee *optee)
+{
+	bool is_per_vcpu = false;
+	u32 notif_id = 0;
+	int rc;
+
+	while (true) {
+		rc = ffa_dev->ops->notifier_ops->notify_request(ffa_dev,
+								is_per_vcpu,
+								notif_callback,
+								optee,
+								notif_id);
+		if (!rc)
+			break;
+		/*
+		 * -EACCES means that the notification ID was
+		 * already bound, try the next one as long as we
+		 * haven't reached the max. Any other error is a
+		 * permanent error, so skip asynchronous
+		 * notifications in that case.
+		 */
+		if (rc != -EACCES)
+			return rc;
+		notif_id++;
+		if (notif_id >= OPTEE_FFA_MAX_ASYNC_NOTIF_VALUE)
+			return rc;
+	}
+	optee->ffa.bottom_half_value = notif_id;
+
+	rc = enable_async_notif(optee);
+	if (rc < 0) {
+		ffa_dev->ops->notifier_ops->notify_relinquish(ffa_dev,
+							      notif_id);
+		optee->ffa.bottom_half_value = U32_MAX;
+	}
+
+	return rc;
+}
+
 static int optee_ffa_probe(struct ffa_device *ffa_dev)
 {
+	const struct ffa_notifier_ops *notif_ops;
 	const struct ffa_ops *ffa_ops;
+	unsigned int max_notif_value;
 	unsigned int rpc_param_count;
 	struct tee_shm_pool *pool;
 	struct tee_device *teedev;
@@ -797,12 +873,13 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 	int rc;
 
 	ffa_ops = ffa_dev->ops;
+	notif_ops = ffa_ops->notifier_ops;
 
 	if (!optee_ffa_api_is_compatbile(ffa_dev, ffa_ops))
 		return -EINVAL;
 
 	if (!optee_ffa_exchange_caps(ffa_dev, ffa_ops, &sec_caps,
-				     &rpc_param_count))
+				     &rpc_param_count, &max_notif_value))
 		return -EINVAL;
 	if (sec_caps & OPTEE_FFA_SEC_CAP_ARG_OFFSET)
 		arg_cache_flags |= OPTEE_SHM_ARG_SHARED;
@@ -820,6 +897,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 
 	optee->ops = &optee_ffa_ops;
 	optee->ffa.ffa_dev = ffa_dev;
+	optee->ffa.bottom_half_value = U32_MAX;
 	optee->rpc_param_count = rpc_param_count;
 
 	teedev = tee_device_alloc(&optee_ffa_clnt_desc, NULL, optee->pool,
@@ -864,6 +942,12 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 	rc = optee_notif_init(optee, OPTEE_DEFAULT_MAX_NOTIF_VALUE);
 	if (rc)
 		goto err_close_ctx;
+	if (sec_caps & OPTEE_FFA_SEC_CAP_ASYNC_NOTIF) {
+		rc = optee_ffa_async_notif_init(ffa_dev, optee);
+		if (rc < 0)
+			pr_err("Failed to initialize async notifications: %d",
+			       rc);
+	}
 
 	rc = optee_enumerate_devices(PTA_CMD_GET_DEVICES);
 	if (rc)
@@ -874,6 +958,9 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 
 err_unregister_devices:
 	optee_unregister_devices();
+	if (optee->ffa.bottom_half_value != U32_MAX)
+		notif_ops->notify_relinquish(ffa_dev,
+					     optee->ffa.bottom_half_value);
 	optee_notif_uninit(optee);
 err_close_ctx:
 	teedev_close_context(ctx);
diff --git a/drivers/tee/optee/optee_ffa.h b/drivers/tee/optee/optee_ffa.h
index 97266243deaa..5db779dc00de 100644
--- a/drivers/tee/optee/optee_ffa.h
+++ b/drivers/tee/optee/optee_ffa.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: BSD-2-Clause */
 /*
- * Copyright (c) 2019-2021, Linaro Limited
+ * Copyright (c) 2019-2021, 2023 Linaro Limited
  */
 
 /*
@@ -73,7 +73,7 @@
  *
  * Call register usage:
  * w3:    Service ID, OPTEE_FFA_EXCHANGE_CAPABILITIES
- * w4-w7: Note used (MBZ)
+ * w4-w7: Not used (MBZ)
  *
  * Return register usage:
  * w3:    Error code, 0 on success
@@ -82,14 +82,16 @@
  *                   OPTEE_FFA_YIELDING_CALL_WITH_ARG.
  *        Bit[31:8]: Reserved (MBZ)
  * w5:	  Bitfield of secure world capabilities OPTEE_FFA_SEC_CAP_* below,
- *	  unused bits MBZ.
- * w6-w7: Not used (MBZ)
+ * w6:	  The maximum secure world notification number
+ * w7:	  Not used (MBZ)
  */
 /*
  * Secure world supports giving an offset into the argument shared memory
  * object, see also OPTEE_FFA_YIELDING_CALL_WITH_ARG
  */
 #define OPTEE_FFA_SEC_CAP_ARG_OFFSET	BIT(0)
+/* OP-TEE supports asynchronous notification via FF-A */
+#define OPTEE_FFA_SEC_CAP_ASYNC_NOTIF	BIT(1)
 
 #define OPTEE_FFA_EXCHANGE_CAPABILITIES OPTEE_FFA_BLOCKING_CALL(2)
 
@@ -108,6 +110,24 @@
  */
 #define OPTEE_FFA_UNREGISTER_SHM	OPTEE_FFA_BLOCKING_CALL(3)
 
+/*
+ * Inform OP-TEE that the normal world is able to receive asynchronous
+ * notifications.
+ *
+ * Call register usage:
+ * w3:    Service ID, OPTEE_FFA_ENABLE_ASYNC_NOTIF
+ * w4:	  Notification value to request bottom half processing, should be
+ *	  less than OPTEE_FFA_MAX_ASYNC_NOTIF_VALUE.
+ * w5-w7: Not used (MBZ)
+ *
+ * Return register usage:
+ * w3:    Error code, 0 on success
+ * w4-w7: Note used (MBZ)
+ */
+#define OPTEE_FFA_ENABLE_ASYNC_NOTIF	OPTEE_FFA_BLOCKING_CALL(5)
+
+#define OPTEE_FFA_MAX_ASYNC_NOTIF_VALUE 64
+
 /*
  * Call with struct optee_msg_arg as argument in the supplied shared memory
  * with a zero internal offset and normal cached memory attributes.
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
index 2165bd11e6ac..91f4ec45e388 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -129,12 +129,14 @@ struct optee_smc {
  * struct optee_ffa_data -  FFA communication struct
  * @ffa_dev		FFA device, contains the destination id, the id of
  *			OP-TEE in secure world
- * @ffa_ops		FFA operations
+ * @bottom_half_value	Notification ID used for bottom half signalling or
+ *			U32_MAX if unused
  * @mutex		Serializes access to @global_ids
  * @global_ids		FF-A shared memory global handle translation
  */
 struct optee_ffa {
 	struct ffa_device *ffa_dev;
+	u32 bottom_half_value;
 	/* Serializes access to @global_ids */
 	struct mutex mutex;
 	struct rhashtable global_ids;
-- 
2.34.1

