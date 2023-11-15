Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 768757DB56E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 09:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbjJ3Ism (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 04:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbjJ3Isb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 04:48:31 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C3EB4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 01:48:26 -0700 (PDT)
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39U8ajPV024493;
        Mon, 30 Oct 2023 09:48:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        selector1; bh=pisPpuL+r0miZ1VlLpPyZjR1oSJA68ADYsx5hmqSr5Y=; b=Tn
        Rdy+LcQs6yjHPFOy19Xpj7AWpW2iAt8cbzbhkes1CXB/F2LN6SGe/87tuWK9ohbb
        j/qQLc9/0BnkaoM2uudBKhY8lZxSxm3WS7yNMo6FhfimluJvgjRIr1SzJkcXzHR8
        65gQtedpQ4MsHBP+tu2jEVjoZb5auEks5xiwOPlXldmHd4Spx1fY5x/jxZxuZob1
        2dB6UtMesZbKMsEsc5NYEwY+RZHnYUhyGhHaatyP3dbSM80xAW2kSDSr7+lErBFq
        rGeUzbFlb+rj+6b5yv75jWFsN6gxXk3IFjG0e02VZEH5ZHlHh8O//MBjN740A1Sn
        /dT3fMz7IfxfKnbYkq8w==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3u1bv0m2jm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 09:48:15 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 39ABF10005C;
        Mon, 30 Oct 2023 09:48:15 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 32015218614;
        Mon, 30 Oct 2023 09:48:15 +0100 (CET)
Received: from localhost (10.201.20.20) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 30 Oct
 2023 09:48:14 +0100
From:   Etienne Carriere <etienne.carriere@foss.st.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Jerome Forissier <jerome.forissier@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <op-tee@lists.trustedfirmware.org>,
        Etienne Carriere <etienne.carriere@foss.st.com>
Subject: [PATCH v12 1/4] tee: optee: system call property
Date:   Mon, 30 Oct 2023 09:48:09 +0100
Message-ID: <20231030084812.905549-2-etienne.carriere@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231030084812.905549-1-etienne.carriere@foss.st.com>
References: <20231030084812.905549-1-etienne.carriere@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.20]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_06,2023-10-27_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds an argument to do_call_with_arg() handler to tell whether the call
is a system call or nor. This change always sets this info to false
hence no functional change.

This change prepares management of system invocation proposed in a later
change.

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Etienne Carriere <etienne.carriere@foss.st.com>
---
Changes since v11:
- Fixed missing inline description comments for the argument added to
  both optee_ffa_do_call_with_arg() and optee_smc_do_call_with_arg().
  The issue was kindly reported by kernel test robot:
  https://lore.kernel.org/lkml/202310192021.fvb6JDOY-lkp@intel.com/

No change since v10

Changes since v9:
- Applied Sumit R-b tag:
  https://lore.kernel.org/lkml/CAFA6WYMwWFRUo719wHHsjaAUOSdo4cMa8gdHBMWidP4vC4z31g@mail.gmail.com/
- Updated my e-mail address.

No change since v8
No change since v7

Changes since v6:
- Squashed a part of patch v6 3/4 changes into this patch v7 1/4
  related to adding boolean system thread attribute into optee
  driver call queue and SMC/FF-A ABIs API functions.
- Removed local variable sys_thread set to constant false value
  and use false straight as function argument instead.
- Comment on struct optee_session::use_sys_thread being read with
  optee mutex locked is not addressed as still under discussion.

No changes since v5

Changes since v4:
- New change, extracted from PATCH v4 1/2 (tee: system invocation") and
  revised to cover preparatory changes in optee driver for system session
  support with contribution from Jens.
---
 drivers/tee/optee/call.c          | 24 +++++++++++++++++-------
 drivers/tee/optee/core.c          |  5 +++--
 drivers/tee/optee/ffa_abi.c       | 11 +++++++----
 drivers/tee/optee/optee_private.h |  9 ++++++---
 drivers/tee/optee/smc_abi.c       | 16 +++++++++-------
 5 files changed, 42 insertions(+), 23 deletions(-)

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index df5fb5410b72..152ae9bb1785 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -40,7 +40,7 @@ struct optee_shm_arg_entry {
 };
 
 void optee_cq_wait_init(struct optee_call_queue *cq,
-			struct optee_call_waiter *w)
+			struct optee_call_waiter *w, bool sys_thread)
 {
 	/*
 	 * We're preparing to make a call to secure world. In case we can't
@@ -328,7 +328,8 @@ int optee_open_session(struct tee_context *ctx,
 		goto out;
 	}
 
-	if (optee->ops->do_call_with_arg(ctx, shm, offs)) {
+	if (optee->ops->do_call_with_arg(ctx, shm, offs,
+					 sess->use_sys_thread)) {
 		msg_arg->ret = TEEC_ERROR_COMMUNICATION;
 		msg_arg->ret_origin = TEEC_ORIGIN_COMMS;
 	}
@@ -360,7 +361,8 @@ int optee_open_session(struct tee_context *ctx,
 	return rc;
 }
 
-int optee_close_session_helper(struct tee_context *ctx, u32 session)
+int optee_close_session_helper(struct tee_context *ctx, u32 session,
+			       bool system_thread)
 {
 	struct optee *optee = tee_get_drvdata(ctx->teedev);
 	struct optee_shm_arg_entry *entry;
@@ -374,7 +376,7 @@ int optee_close_session_helper(struct tee_context *ctx, u32 session)
 
 	msg_arg->cmd = OPTEE_MSG_CMD_CLOSE_SESSION;
 	msg_arg->session = session;
-	optee->ops->do_call_with_arg(ctx, shm, offs);
+	optee->ops->do_call_with_arg(ctx, shm, offs, system_thread);
 
 	optee_free_msg_arg(ctx, entry, offs);
 
@@ -385,6 +387,7 @@ int optee_close_session(struct tee_context *ctx, u32 session)
 {
 	struct optee_context_data *ctxdata = ctx->data;
 	struct optee_session *sess;
+	bool system_thread;
 
 	/* Check that the session is valid and remove it from the list */
 	mutex_lock(&ctxdata->mutex);
@@ -394,9 +397,10 @@ int optee_close_session(struct tee_context *ctx, u32 session)
 	mutex_unlock(&ctxdata->mutex);
 	if (!sess)
 		return -EINVAL;
+	system_thread = sess->use_sys_thread;
 	kfree(sess);
 
-	return optee_close_session_helper(ctx, session);
+	return optee_close_session_helper(ctx, session, system_thread);
 }
 
 int optee_invoke_func(struct tee_context *ctx, struct tee_ioctl_invoke_arg *arg,
@@ -408,12 +412,15 @@ int optee_invoke_func(struct tee_context *ctx, struct tee_ioctl_invoke_arg *arg,
 	struct optee_msg_arg *msg_arg;
 	struct optee_session *sess;
 	struct tee_shm *shm;
+	bool system_thread;
 	u_int offs;
 	int rc;
 
 	/* Check that the session is valid */
 	mutex_lock(&ctxdata->mutex);
 	sess = find_session(ctxdata, arg->session);
+	if (sess)
+		system_thread = sess->use_sys_thread;
 	mutex_unlock(&ctxdata->mutex);
 	if (!sess)
 		return -EINVAL;
@@ -432,7 +439,7 @@ int optee_invoke_func(struct tee_context *ctx, struct tee_ioctl_invoke_arg *arg,
 	if (rc)
 		goto out;
 
-	if (optee->ops->do_call_with_arg(ctx, shm, offs)) {
+	if (optee->ops->do_call_with_arg(ctx, shm, offs, system_thread)) {
 		msg_arg->ret = TEEC_ERROR_COMMUNICATION;
 		msg_arg->ret_origin = TEEC_ORIGIN_COMMS;
 	}
@@ -457,12 +464,15 @@ int optee_cancel_req(struct tee_context *ctx, u32 cancel_id, u32 session)
 	struct optee_shm_arg_entry *entry;
 	struct optee_msg_arg *msg_arg;
 	struct optee_session *sess;
+	bool system_thread;
 	struct tee_shm *shm;
 	u_int offs;
 
 	/* Check that the session is valid */
 	mutex_lock(&ctxdata->mutex);
 	sess = find_session(ctxdata, session);
+	if (sess)
+		system_thread = sess->use_sys_thread;
 	mutex_unlock(&ctxdata->mutex);
 	if (!sess)
 		return -EINVAL;
@@ -474,7 +484,7 @@ int optee_cancel_req(struct tee_context *ctx, u32 cancel_id, u32 session)
 	msg_arg->cmd = OPTEE_MSG_CMD_CANCEL;
 	msg_arg->session = session;
 	msg_arg->cancel_id = cancel_id;
-	optee->ops->do_call_with_arg(ctx, shm, offs);
+	optee->ops->do_call_with_arg(ctx, shm, offs, system_thread);
 
 	optee_free_msg_arg(ctx, entry, offs);
 	return 0;
diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index 2a258bd3b6b5..d01ca47f7bde 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -129,7 +129,8 @@ int optee_open(struct tee_context *ctx, bool cap_memref_null)
 
 static void optee_release_helper(struct tee_context *ctx,
 				 int (*close_session)(struct tee_context *ctx,
-						      u32 session))
+						      u32 session,
+						      bool system_thread))
 {
 	struct optee_context_data *ctxdata = ctx->data;
 	struct optee_session *sess;
@@ -141,7 +142,7 @@ static void optee_release_helper(struct tee_context *ctx,
 	list_for_each_entry_safe(sess, sess_tmp, &ctxdata->sess_list,
 				 list_node) {
 		list_del(&sess->list_node);
-		close_session(ctx, sess->session_id);
+		close_session(ctx, sess->session_id, sess->use_sys_thread);
 		kfree(sess);
 	}
 	kfree(ctxdata);
diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
index 0828240f27e6..721fd4d24f47 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -528,7 +528,8 @@ static void optee_handle_ffa_rpc(struct tee_context *ctx, struct optee *optee,
 
 static int optee_ffa_yielding_call(struct tee_context *ctx,
 				   struct ffa_send_direct_data *data,
-				   struct optee_msg_arg *rpc_arg)
+				   struct optee_msg_arg *rpc_arg,
+				   bool system_thread)
 {
 	struct optee *optee = tee_get_drvdata(ctx->teedev);
 	struct ffa_device *ffa_dev = optee->ffa.ffa_dev;
@@ -541,7 +542,7 @@ static int optee_ffa_yielding_call(struct tee_context *ctx,
 	int rc;
 
 	/* Initialize waiter */
-	optee_cq_wait_init(&optee->call_queue, &w);
+	optee_cq_wait_init(&optee->call_queue, &w, system_thread);
 	while (true) {
 		rc = msg_ops->sync_send_receive(ffa_dev, data);
 		if (rc)
@@ -604,6 +605,7 @@ static int optee_ffa_yielding_call(struct tee_context *ctx,
  * @ctx:	calling context
  * @shm:	shared memory holding the message to pass to secure world
  * @offs:	offset of the message in @shm
+ * @system_thread: true if caller requests TEE system thread support
  *
  * Does a FF-A call to OP-TEE in secure world and handles eventual resulting
  * Remote Procedure Calls (RPC) from OP-TEE.
@@ -612,7 +614,8 @@ static int optee_ffa_yielding_call(struct tee_context *ctx,
  */
 
 static int optee_ffa_do_call_with_arg(struct tee_context *ctx,
-				      struct tee_shm *shm, u_int offs)
+				      struct tee_shm *shm, u_int offs,
+				      bool system_thread)
 {
 	struct ffa_send_direct_data data = {
 		.data0 = OPTEE_FFA_YIELDING_CALL_WITH_ARG,
@@ -642,7 +645,7 @@ static int optee_ffa_do_call_with_arg(struct tee_context *ctx,
 	if (IS_ERR(rpc_arg))
 		return PTR_ERR(rpc_arg);
 
-	return optee_ffa_yielding_call(ctx, &data, rpc_arg);
+	return optee_ffa_yielding_call(ctx, &data, rpc_arg, system_thread);
 }
 
 /*
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
index 6bb5cae09688..b659a6f521df 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -154,7 +154,8 @@ struct optee;
  */
 struct optee_ops {
 	int (*do_call_with_arg)(struct tee_context *ctx,
-				struct tee_shm *shm_arg, u_int offs);
+				struct tee_shm *shm_arg, u_int offs,
+				bool system_thread);
 	int (*to_msg_param)(struct optee *optee,
 			    struct optee_msg_param *msg_params,
 			    size_t num_params, const struct tee_param *params);
@@ -204,6 +205,7 @@ struct optee {
 struct optee_session {
 	struct list_head list_node;
 	u32 session_id;
+	bool use_sys_thread;
 };
 
 struct optee_context_data {
@@ -250,7 +252,8 @@ int optee_supp_send(struct tee_context *ctx, u32 ret, u32 num_params,
 int optee_open_session(struct tee_context *ctx,
 		       struct tee_ioctl_open_session_arg *arg,
 		       struct tee_param *param);
-int optee_close_session_helper(struct tee_context *ctx, u32 session);
+int optee_close_session_helper(struct tee_context *ctx, u32 session,
+			       bool system_thread);
 int optee_close_session(struct tee_context *ctx, u32 session);
 int optee_invoke_func(struct tee_context *ctx, struct tee_ioctl_invoke_arg *arg,
 		      struct tee_param *param);
@@ -299,7 +302,7 @@ static inline void optee_to_msg_param_value(struct optee_msg_param *mp,
 }
 
 void optee_cq_wait_init(struct optee_call_queue *cq,
-			struct optee_call_waiter *w);
+			struct optee_call_waiter *w, bool sys_thread);
 void optee_cq_wait_for_completion(struct optee_call_queue *cq,
 				  struct optee_call_waiter *w);
 void optee_cq_wait_final(struct optee_call_queue *cq,
diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index d5b28fd35d66..8ae5e1047650 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -283,7 +283,7 @@ static void optee_enable_shm_cache(struct optee *optee)
 	struct optee_call_waiter w;
 
 	/* We need to retry until secure world isn't busy. */
-	optee_cq_wait_init(&optee->call_queue, &w);
+	optee_cq_wait_init(&optee->call_queue, &w, false);
 	while (true) {
 		struct arm_smccc_res res;
 
@@ -308,7 +308,7 @@ static void __optee_disable_shm_cache(struct optee *optee, bool is_mapped)
 	struct optee_call_waiter w;
 
 	/* We need to retry until secure world isn't busy. */
-	optee_cq_wait_init(&optee->call_queue, &w);
+	optee_cq_wait_init(&optee->call_queue, &w, false);
 	while (true) {
 		union {
 			struct arm_smccc_res smccc;
@@ -507,7 +507,7 @@ static int optee_shm_register(struct tee_context *ctx, struct tee_shm *shm,
 	msg_arg->params->u.tmem.buf_ptr = virt_to_phys(pages_list) |
 	  (tee_shm_get_page_offset(shm) & (OPTEE_MSG_NONCONTIG_PAGE_SIZE - 1));
 
-	if (optee->ops->do_call_with_arg(ctx, shm_arg, 0) ||
+	if (optee->ops->do_call_with_arg(ctx, shm_arg, 0, false) ||
 	    msg_arg->ret != TEEC_SUCCESS)
 		rc = -EINVAL;
 
@@ -550,7 +550,7 @@ static int optee_shm_unregister(struct tee_context *ctx, struct tee_shm *shm)
 	msg_arg->params[0].attr = OPTEE_MSG_ATTR_TYPE_RMEM_INPUT;
 	msg_arg->params[0].u.rmem.shm_ref = (unsigned long)shm;
 
-	if (optee->ops->do_call_with_arg(ctx, shm_arg, 0) ||
+	if (optee->ops->do_call_with_arg(ctx, shm_arg, 0, false) ||
 	    msg_arg->ret != TEEC_SUCCESS)
 		rc = -EINVAL;
 out:
@@ -878,6 +878,7 @@ static void optee_handle_rpc(struct tee_context *ctx,
  * @ctx:	calling context
  * @shm:	shared memory holding the message to pass to secure world
  * @offs:	offset of the message in @shm
+ * @system_thread: true if caller requests TEE system thread support
  *
  * Does and SMC to OP-TEE in secure world and handles eventual resulting
  * Remote Procedure Calls (RPC) from OP-TEE.
@@ -885,7 +886,8 @@ static void optee_handle_rpc(struct tee_context *ctx,
  * Returns return code from secure world, 0 is OK
  */
 static int optee_smc_do_call_with_arg(struct tee_context *ctx,
-				      struct tee_shm *shm, u_int offs)
+				      struct tee_shm *shm, u_int offs,
+				      bool system_thread)
 {
 	struct optee *optee = tee_get_drvdata(ctx->teedev);
 	struct optee_call_waiter w;
@@ -926,7 +928,7 @@ static int optee_smc_do_call_with_arg(struct tee_context *ctx,
 		reg_pair_from_64(&param.a1, &param.a2, parg);
 	}
 	/* Initialize waiter */
-	optee_cq_wait_init(&optee->call_queue, &w);
+	optee_cq_wait_init(&optee->call_queue, &w, system_thread);
 	while (true) {
 		struct arm_smccc_res res;
 
@@ -977,7 +979,7 @@ static int simple_call_with_arg(struct tee_context *ctx, u32 cmd)
 		return PTR_ERR(msg_arg);
 
 	msg_arg->cmd = cmd;
-	optee_smc_do_call_with_arg(ctx, shm, offs);
+	optee_smc_do_call_with_arg(ctx, shm, offs, false);
 
 	optee_free_msg_arg(ctx, entry, offs);
 	return 0;
-- 
2.25.1

