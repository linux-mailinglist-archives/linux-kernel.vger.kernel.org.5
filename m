Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2D27E8822
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 03:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345362AbjKKCP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 21:15:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjKKCPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 21:15:54 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A423C0C;
        Fri, 10 Nov 2023 18:15:50 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AB1ZKQD010029;
        Sat, 11 Nov 2023 02:15:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : to : cc; s=qcppdkim1;
 bh=V5vmmfFRfMOjr/pwgxiEu1F1p2ZqSvUhcEkulhxITVw=;
 b=JXGpSIl2tMk9q9bTytndU7MR2N+rlAvzWg+Vp4hPFqx764Oc/jDzGTlqDNuiNcJkGCm8
 z7k++l93on0uVJHDasUXVgGiViMXFgrmhkBwmlqPi1jE3GeUiLoYp465O+Z2AieZPRWu
 TKfeGK4ZEGmZmCUZAAMzhNMHbX9MW7wS1dyvjIisN/ZKauVxRwhpxIY33iW+H/Qtoyl2
 jSVmz34s4NV9afkz9+E4CZG26wlYmYf+Jg7FeMn688yC/F3w4nDjQVuZTrPZY1K6ks0m
 cQlgoiXS3o85vyDaU89ayYBmu02eVnTPYBRSr6i2dJckLsycg/8qHPAQ3dbp+gTumxVh bA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u93r0ktwx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 11 Nov 2023 02:15:42 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AB2Fguv026520
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 11 Nov 2023 02:15:42 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Fri, 10 Nov 2023 18:15:38 -0800
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date:   Sat, 11 Nov 2023 07:44:41 +0530
Subject: [PATCH v3] bus: mhi: host: Add tracing support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231111-ftrace_support-v3-1-f358d2911a74@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAJLjTmUC/3XMQQ6CMBCF4auQrq3ptNBQV97DGFPLVGYhYAuNh
 nB3CyuNcfm/5H0zixgIIzsUMwuYKFLf5VC7grnWdjfk1ORmUkgFQlTcj8E6vMRpGPowcl1r05R
 QaVCG5dMQ0NNzA0/n3C3FsQ+vzU+wrn+pBBy4VFZ6ZUpvS3N8TOSoc3vX39mKJfkBgPoBZAY01
 kY5FCCu1TewLMsb+fqVV+8AAAA=
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <mhi@lists.linux.dev>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <quic_vbadigan@quicinc.com>,
        <quic_ramkri@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_parass@quicinc.com>,
        "Krishna chaitanya chundru" <quic_krichai@quicinc.com>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1699668938; l=12394;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=iEU0SaMPKeYKHiWHmaA9fg8H+hgn9YL8UTuW/DJ/+sk=;
 b=FRQW3+ag7IDa2m8qYhGSUJUNQUGsGM39lBV395JXK55jyEI9Y6F0YRTTnPiAfnrlndG+8TDE5
 llSm3uONf8CB1g8u0HEZKsC0cANpVQHEiBlshNT0PFFewYLvZ5CUTx5
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ZqyOZdiV7oG5SOfRLpzaFBx8bvRfRnFP
X-Proofpoint-ORIG-GUID: ZqyOZdiV7oG5SOfRLpzaFBx8bvRfRnFP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_21,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 clxscore=1011 impostorscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311110016
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change adds ftrace support for following functions which
helps in debugging the issues when there is Channel state & MHI
state change and also when we receive data and control events:
1. mhi_intvec_mhi_states
2. mhi_process_data_event_ring
3. mhi_process_ctrl_ev_ring
4. mhi_gen_tre
5. mhi_update_channel_state
6. mhi_tryset_pm_state
7. mhi_pm_st_worker

Where ever we added trace events removing debug messages.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
Changes in v3:
- move trace header file from include/trace/events to drivers/bus/mhi/host/ so that
- we can include driver header files.
- Use macros directly in the trace events as suggested Jeffrey Hugo.
- Reorder the structure in the events as suggested by steve to avoid holes in the buffer.
- removed the mhi_to_physical function as this can give security issues.
- removed macros to define strings as we can get those from driver headers.
- Link to v2: https://lore.kernel.org/r/20231013-ftrace_support-v2-1-6e893ce010b5@quicinc.com

Changes in v2:
- Passing the raw state into the trace event and using  __print_symbolic() as suggested by bjorn.
- Change mhi_pm_st_worker to mhi_pm_st_transition as suggested by bjorn.
- Fixed the kernel test rebot issues.
- Link to v1: https://lore.kernel.org/r/20231005-ftrace_support-v1-1-23a2f394fa49@quicinc.com
---
 drivers/bus/mhi/host/init.c     |   3 +
 drivers/bus/mhi/host/internal.h |   1 +
 drivers/bus/mhi/host/main.c     |  24 +++--
 drivers/bus/mhi/host/pm.c       |   6 +-
 drivers/bus/mhi/host/trace.h    | 224 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 245 insertions(+), 13 deletions(-)

diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
index f78aefd2d7a3..6acb85f4c5f8 100644
--- a/drivers/bus/mhi/host/init.c
+++ b/drivers/bus/mhi/host/init.c
@@ -20,6 +20,9 @@
 #include <linux/wait.h>
 #include "internal.h"
 
+#define CREATE_TRACE_POINTS
+#include "trace.h"
+
 static DEFINE_IDA(mhi_controller_ida);
 
 const char * const mhi_ee_str[MHI_EE_MAX] = {
diff --git a/drivers/bus/mhi/host/internal.h b/drivers/bus/mhi/host/internal.h
index 2e139e76de4c..a02a71605907 100644
--- a/drivers/bus/mhi/host/internal.h
+++ b/drivers/bus/mhi/host/internal.h
@@ -7,6 +7,7 @@
 #ifndef _MHI_INT_H
 #define _MHI_INT_H
 
+#include "trace.h"
 #include "../common.h"
 
 extern struct bus_type mhi_bus_type;
diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
index dcf627b36e82..7fe8b2dd9e24 100644
--- a/drivers/bus/mhi/host/main.c
+++ b/drivers/bus/mhi/host/main.c
@@ -491,11 +491,9 @@ irqreturn_t mhi_intvec_threaded_handler(int irq_number, void *priv)
 
 	state = mhi_get_mhi_state(mhi_cntrl);
 	ee = mhi_get_exec_env(mhi_cntrl);
-	dev_dbg(dev, "local ee: %s state: %s device ee: %s state: %s\n",
-		TO_MHI_EXEC_STR(mhi_cntrl->ee),
-		mhi_state_str(mhi_cntrl->dev_state),
-		TO_MHI_EXEC_STR(ee), mhi_state_str(state));
 
+	trace_mhi_intvec_states(mhi_cntrl->mhi_dev->name, mhi_cntrl->ee,
+				mhi_cntrl->dev_state, ee, state);
 	if (state == MHI_STATE_SYS_ERR) {
 		dev_dbg(dev, "System error detected\n");
 		pm_state = mhi_tryset_pm_state(mhi_cntrl,
@@ -832,6 +830,10 @@ int mhi_process_ctrl_ev_ring(struct mhi_controller *mhi_cntrl,
 	while (dev_rp != local_rp) {
 		enum mhi_pkt_type type = MHI_TRE_GET_EV_TYPE(local_rp);
 
+		trace_mhi_process_ctrl_ev_ring(mhi_cntrl->mhi_dev->name, (u64)local_rp,
+					       local_rp->ptr, local_rp->dword[0],
+					       local_rp->dword[1]);
+
 		switch (type) {
 		case MHI_PKT_TYPE_BW_REQ_EVENT:
 		{
@@ -997,6 +999,9 @@ int mhi_process_data_event_ring(struct mhi_controller *mhi_cntrl,
 	while (dev_rp != local_rp && event_quota > 0) {
 		enum mhi_pkt_type type = MHI_TRE_GET_EV_TYPE(local_rp);
 
+		trace_mhi_process_data_event_ring(mhi_cntrl->mhi_dev->name, local_rp->ptr,
+						  local_rp->dword[0], local_rp->dword[1]);
+
 		chan = MHI_TRE_GET_EV_CHID(local_rp);
 
 		WARN_ON(chan >= mhi_cntrl->max_chan);
@@ -1235,6 +1240,8 @@ int mhi_gen_tre(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan,
 	mhi_tre->dword[0] = MHI_TRE_DATA_DWORD0(info->len);
 	mhi_tre->dword[1] = MHI_TRE_DATA_DWORD1(bei, eot, eob, chain);
 
+	trace_mhi_gen_tre(mhi_cntrl->mhi_dev->name, mhi_chan->chan, (u64)mhi_tre,
+			  mhi_tre->ptr, mhi_tre->dword[0], mhi_tre->dword[1]);
 	/* increment WP */
 	mhi_add_ring_element(mhi_cntrl, tre_ring);
 	mhi_add_ring_element(mhi_cntrl, buf_ring);
@@ -1327,9 +1334,8 @@ static int mhi_update_channel_state(struct mhi_controller *mhi_cntrl,
 	enum mhi_cmd_type cmd = MHI_CMD_NOP;
 	int ret;
 
-	dev_dbg(dev, "%d: Updating channel state to: %s\n", mhi_chan->chan,
-		TO_CH_STATE_TYPE_STR(to_state));
-
+	trace_mhi_update_channel_state_start(mhi_cntrl->mhi_dev->name, mhi_chan->chan,
+					     to_state);
 	switch (to_state) {
 	case MHI_CH_STATE_TYPE_RESET:
 		write_lock_irq(&mhi_chan->lock);
@@ -1396,9 +1402,7 @@ static int mhi_update_channel_state(struct mhi_controller *mhi_cntrl,
 		write_unlock_irq(&mhi_chan->lock);
 	}
 
-	dev_dbg(dev, "%d: Channel state change to %s successful\n",
-		mhi_chan->chan, TO_CH_STATE_TYPE_STR(to_state));
-
+	trace_mhi_update_channel_state_end(mhi_cntrl->mhi_dev->name, mhi_chan->chan, to_state);
 exit_channel_update:
 	mhi_cntrl->runtime_put(mhi_cntrl);
 	mhi_device_put(mhi_cntrl->mhi_dev);
diff --git a/drivers/bus/mhi/host/pm.c b/drivers/bus/mhi/host/pm.c
index 8a4362d75fc4..e32afdc92fde 100644
--- a/drivers/bus/mhi/host/pm.c
+++ b/drivers/bus/mhi/host/pm.c
@@ -123,6 +123,7 @@ enum mhi_pm_state __must_check mhi_tryset_pm_state(struct mhi_controller *mhi_cn
 	if (unlikely(!(dev_state_transitions[index].to_states & state)))
 		return cur_state;
 
+	trace_mhi_tryset_pm_state(mhi_cntrl->mhi_dev->name, state);
 	mhi_cntrl->pm_state = state;
 	return mhi_cntrl->pm_state;
 }
@@ -753,7 +754,6 @@ void mhi_pm_st_worker(struct work_struct *work)
 	struct mhi_controller *mhi_cntrl = container_of(work,
 							struct mhi_controller,
 							st_worker);
-	struct device *dev = &mhi_cntrl->mhi_dev->dev;
 
 	spin_lock_irq(&mhi_cntrl->transition_lock);
 	list_splice_tail_init(&mhi_cntrl->transition_list, &head);
@@ -761,8 +761,8 @@ void mhi_pm_st_worker(struct work_struct *work)
 
 	list_for_each_entry_safe(itr, tmp, &head, node) {
 		list_del(&itr->node);
-		dev_dbg(dev, "Handling state transition: %s\n",
-			TO_DEV_STATE_TRANS_STR(itr->state));
+
+		trace_mhi_pm_st_transition(mhi_cntrl->mhi_dev->name, itr->state);
 
 		switch (itr->state) {
 		case DEV_ST_TRANSITION_PBL:
diff --git a/drivers/bus/mhi/host/trace.h b/drivers/bus/mhi/host/trace.h
new file mode 100644
index 000000000000..66d0d96db1d9
--- /dev/null
+++ b/drivers/bus/mhi/host/trace.h
@@ -0,0 +1,224 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM mhi_host
+
+#if !defined(_TRACE_EVENT_MHI_HOST_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_EVENT_MHI_HOST_H
+
+#include <linux/tracepoint.h>
+#include <linux/trace_seq.h>
+#include "../common.h"
+#include "internal.h"
+
+TRACE_EVENT(mhi_gen_tre,
+
+	TP_PROTO(const char *name, int ch_num, u64 wp, __le64 tre_ptr,
+		 __le32 dword0, __le32 dword1),
+
+	TP_ARGS(name, ch_num, wp, tre_ptr, dword0, dword1),
+
+	TP_STRUCT__entry(
+		__string(name, name)
+		__field(int, ch_num)
+		__field(u64, wp)
+		__field(__le64, tre_ptr)
+		__field(__le32, dword0)
+		__field(__le32, dword1)
+	),
+
+	TP_fast_assign(
+		__assign_str(name, name);
+		__entry->ch_num = ch_num;
+		__entry->wp = wp;
+		__entry->tre_ptr = tre_ptr;
+		__entry->dword0 = dword0;
+		__entry->dword1 = dword1;
+	),
+
+	TP_printk("%s: Chan: %d WP: 0x%llx TRE: 0x%llx 0x%08x 0x%08x\n",
+		  __get_str(name), __entry->ch_num, __entry->wp, __entry->tre_ptr,
+		  __entry->dword0, __entry->dword1)
+);
+
+TRACE_EVENT(mhi_intvec_states,
+
+	TP_PROTO(const char *name, int local_ee, int state, int dev_ee, int dev_state),
+
+	TP_ARGS(name, local_ee, state, dev_ee, dev_state),
+
+	TP_STRUCT__entry(
+		__string(name, name)
+		__field(int, local_ee)
+		__field(int, state)
+		__field(int, dev_ee)
+		__field(int, dev_state)
+	),
+
+	TP_fast_assign(
+		__assign_str(name, name);
+		__entry->local_ee = local_ee;
+		__entry->state = state;
+		__entry->dev_ee = dev_ee;
+		__entry->dev_state = dev_state;
+	),
+
+	TP_printk("%s: local ee: %s state: %s device ee: %s state: %s\n",
+		  __get_str(name),
+		  TO_MHI_EXEC_STR(__entry->local_ee),
+		  mhi_state_str(__entry->state),
+		  TO_MHI_EXEC_STR(__entry->dev_ee),
+		  mhi_state_str(__entry->dev_state))
+);
+
+TRACE_EVENT(mhi_tryset_pm_state,
+
+	TP_PROTO(const char *name, int pm_state),
+
+	TP_ARGS(name, pm_state),
+
+	TP_STRUCT__entry(
+		__string(name, name)
+		__field(int, pm_state)
+	),
+
+	TP_fast_assign(
+		__assign_str(name, name);
+		if (pm_state)
+			pm_state = __fls(pm_state);
+		__entry->pm_state = pm_state;
+	),
+
+	TP_printk("%s: PM state: %s\n", __get_str(name),
+		  to_mhi_pm_state_str(__entry->pm_state))
+);
+
+TRACE_EVENT(mhi_process_data_event_ring,
+
+	TP_PROTO(const char *name, __le64 ptr, __le32 dword0, __le32 dword1),
+
+	TP_ARGS(name, ptr, dword0, dword1),
+
+	TP_STRUCT__entry(
+		__field(__le64, ptr)
+		__string(name, name)
+		__field(__le32, dword0)
+		__field(__le32, dword1)
+	),
+
+	TP_fast_assign(
+		__assign_str(name, name);
+		__entry->ptr = ptr;
+		__entry->dword0 = dword0;
+		__entry->dword1 = dword1;
+	),
+
+	TP_printk("%s: Processing Event:0x%llx 0x%08x 0x%08x\n",
+		  __get_str(name), __entry->ptr, __entry->dword0, __entry->dword1)
+);
+
+TRACE_EVENT(mhi_process_ctrl_ev_ring,
+
+	TP_PROTO(const char *name, u64 rp, __le64 ptr, __le32 dword0, __le32 dword1),
+
+	TP_ARGS(name, rp, ptr, dword0, dword1),
+
+	TP_STRUCT__entry(
+		__field(u64, rp)
+		__field(__le64, ptr)
+		__string(name, name)
+		__field(__le32, dword0)
+		__field(__le32, dword1)
+		__field(int, state)
+	),
+
+	TP_fast_assign(
+		__assign_str(name, name);
+		__entry->rp = rp;
+		__entry->ptr = ptr;
+		__entry->dword0 = dword0;
+		__entry->dword1 = dword1;
+		__entry->state = MHI_TRE_GET_EV_STATE(rp);
+	),
+
+	TP_printk("%s: RP:0x%llx Processing Event:0x%llx 0x%08x 0x%08x state:%s\n",
+		  __get_str(name), __entry->rp, __entry->ptr, __entry->dword0,
+		  __entry->dword1, mhi_state_str(__entry->state))
+);
+
+TRACE_EVENT(mhi_update_channel_state_start,
+
+	TP_PROTO(const char *name, int ch_num, int state),
+
+	TP_ARGS(name, ch_num, state),
+
+	TP_STRUCT__entry(
+		__string(name, name)
+		__field(int, ch_num)
+		__field(int, state)
+	),
+
+	TP_fast_assign(
+		__assign_str(name, name);
+		__entry->ch_num = ch_num;
+		__entry->state = state;
+	),
+
+	TP_printk("%s: ch%d: Updating state to: %s\n",
+		  __get_str(name), __entry->ch_num,
+		  TO_CH_STATE_TYPE_STR(__entry->state))
+);
+
+TRACE_EVENT(mhi_update_channel_state_end,
+
+	TP_PROTO(const char *name, int ch_num, int state),
+
+	TP_ARGS(name, ch_num, state),
+
+	TP_STRUCT__entry(
+		__string(name, name)
+		__field(int, ch_num)
+		__field(int, state)
+	),
+
+	TP_fast_assign(
+		__assign_str(name, name);
+		__entry->ch_num = ch_num;
+		__entry->state = state;
+	),
+
+	TP_printk("%s: ch%d: Updated state to: %s\n",
+		  __get_str(name), __entry->ch_num,
+		  TO_CH_STATE_TYPE_STR(__entry->state))
+);
+
+TRACE_EVENT(mhi_pm_st_transition,
+
+	TP_PROTO(const char *name, int state),
+
+	TP_ARGS(name, state),
+
+	TP_STRUCT__entry(
+		__string(name, name)
+		__field(int, state)
+	),
+
+	TP_fast_assign(
+		__assign_str(name, name);
+		__entry->state = state;
+	),
+
+	TP_printk("%s: Handling state transition: %s\n", __get_str(name),
+		  TO_DEV_STATE_TRANS_STR(__entry->state))
+);
+
+#endif
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE trace
+
+#include <trace/define_trace.h>

---
base-commit: 3006adf3be79cde4d14b1800b963b82b6e5572e0
change-id: 20231005-ftrace_support-6869d4156139

Best regards,
-- 
Krishna chaitanya chundru <quic_krichai@quicinc.com>

