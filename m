Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A26E57BA19D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239740AbjJEOoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237723AbjJEOjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:39:31 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C394682AA;
        Thu,  5 Oct 2023 07:09:57 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3958iXo9021614;
        Thu, 5 Oct 2023 10:25:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : to : cc; s=qcppdkim1;
 bh=dgsTEkp5dxBBiibtI+NN4jXrDyzUiOrp/oOT7qCE/RY=;
 b=a7oKul7Ngx5oN8dMTSaTPjTLmvr1pOMlcDmvBVX9Up5wDADa0F+lpFQ/5ojSeLkwycTi
 lqsSb4Uyyp3DatMOPll6P5RgsFEVNZsTXaXb9TlLEp9KjY3Kt3pUSF3ktLlybueZR6Bt
 A3V4Ebrz1JvnosJGipVdE8uIKoHWO4zmzwFFXOCl6bVOiUKN0KCMgzNsIFDZ57eotdqR
 F9ccgxSlaQajZQmwaLnAhsuugvtgrQCaDC8tDajgZCxUAhihV0c/gRa42ZJn6rq5sEUq
 VioQeU6qmAtzaRNWAcBbJiIa8dUItX782za1oxbjP3R2E52F7gjFPJb/1CineRXsMvsQ rQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3thfkh1am8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Oct 2023 10:25:41 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 395APe5d010538
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 5 Oct 2023 10:25:40 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Thu, 5 Oct 2023 03:25:36 -0700
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date:   Thu, 5 Oct 2023 15:55:20 +0530
Subject: [PATCH] bus: mhi: host: Add tracing support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231005-ftrace_support-v1-1-23a2f394fa49@quicinc.com>
X-B4-Tracking: v=1; b=H4sIABGPHmUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDAwNT3bSSosTk1Pji0oKC/KISXTMLM8sUE0NTM0NjSyWgpoKi1LTMCrC
 B0bG1tQBr0hP9YAAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696501536; l=11450;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=yTAqsJ/UgbjLCaHzkvSnNS4nU3QvAyrqRHqdgatzRGw=;
 b=VupV+3OnSCQ7/IQwy1fq+UIwncNaEKOVB3wvXoAZSwR5bcm5Yh9Mrhl3LrkZmmYpHBB0Khwrj
 hZ45xyYNrzwC6xHcsIThZuWhkkmvkuC1iyHyee9f4WUbHzEkCteJPST
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JQualHk-c_4l9RNLbAzLwdipPZCQPoKK
X-Proofpoint-ORIG-GUID: JQualHk-c_4l9RNLbAzLwdipPZCQPoKK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-05_07,2023-10-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1011 spamscore=0
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310050081
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change adds ftrace support for following:
1. mhi_intvec_threaded_handler
2. mhi_process_data_event_ring
3. mhi_process_ctrl_ev_ring
4. mhi_gen_tre
5. mhi_update_channel_state
6. mhi_tryset_pm_state
7. mhi_pm_st_worker

Usage:
	echo 1 > /sys/kernel/debug/tracing/events/mhi_host/enable
	cat /sys/kernel/debug/tracing/trace

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 MAINTAINERS                     |   1 +
 drivers/bus/mhi/host/init.c     |   3 +
 drivers/bus/mhi/host/internal.h |   1 +
 drivers/bus/mhi/host/main.c     |  27 ++++--
 drivers/bus/mhi/host/pm.c       |   7 +-
 include/trace/events/mhi_host.h | 207 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 234 insertions(+), 12 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 35977b269d5e..4339c668a6ab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13862,6 +13862,7 @@ F:	Documentation/mhi/
 F:	drivers/bus/mhi/
 F:	drivers/pci/endpoint/functions/pci-epf-mhi.c
 F:	include/linux/mhi.h
+F:	include/trace/events/mhi_host.h
 
 MICROBLAZE ARCHITECTURE
 M:	Michal Simek <monstr@monstr.eu>
diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
index f78aefd2d7a3..3afa90a204fd 100644
--- a/drivers/bus/mhi/host/init.c
+++ b/drivers/bus/mhi/host/init.c
@@ -20,6 +20,9 @@
 #include <linux/wait.h>
 #include "internal.h"
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/mhi_host.h>
+
 static DEFINE_IDA(mhi_controller_ida);
 
 const char * const mhi_ee_str[MHI_EE_MAX] = {
diff --git a/drivers/bus/mhi/host/internal.h b/drivers/bus/mhi/host/internal.h
index 2e139e76de4c..a80a317a59a9 100644
--- a/drivers/bus/mhi/host/internal.h
+++ b/drivers/bus/mhi/host/internal.h
@@ -7,6 +7,7 @@
 #ifndef _MHI_INT_H
 #define _MHI_INT_H
 
+#include <trace/events/mhi_host.h>
 #include "../common.h"
 
 extern struct bus_type mhi_bus_type;
diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
index dcf627b36e82..499590437e9b 100644
--- a/drivers/bus/mhi/host/main.c
+++ b/drivers/bus/mhi/host/main.c
@@ -491,11 +491,10 @@ irqreturn_t mhi_intvec_threaded_handler(int irq_number, void *priv)
 
 	state = mhi_get_mhi_state(mhi_cntrl);
 	ee = mhi_get_exec_env(mhi_cntrl);
-	dev_dbg(dev, "local ee: %s state: %s device ee: %s state: %s\n",
-		TO_MHI_EXEC_STR(mhi_cntrl->ee),
-		mhi_state_str(mhi_cntrl->dev_state),
-		TO_MHI_EXEC_STR(ee), mhi_state_str(state));
 
+	trace_mhi_intvec_threaded_handler(mhi_cntrl->mhi_dev->name, TO_MHI_EXEC_STR(mhi_cntrl->ee),
+					  mhi_state_str(mhi_cntrl->dev_state),
+					  TO_MHI_EXEC_STR(ee), mhi_state_str(state));
 	if (state == MHI_STATE_SYS_ERR) {
 		dev_dbg(dev, "System error detected\n");
 		pm_state = mhi_tryset_pm_state(mhi_cntrl,
@@ -832,6 +831,11 @@ int mhi_process_ctrl_ev_ring(struct mhi_controller *mhi_cntrl,
 	while (dev_rp != local_rp) {
 		enum mhi_pkt_type type = MHI_TRE_GET_EV_TYPE(local_rp);
 
+		trace_mhi_process_ctrl_ev_ring(mhi_cntrl->mhi_dev->name, (u64)(local_rp),
+					       local_rp->ptr, local_rp->dword[0],
+					       local_rp->dword[1],
+					       mhi_state_str(MHI_TRE_GET_EV_STATE(local_rp)));
+
 		switch (type) {
 		case MHI_PKT_TYPE_BW_REQ_EVENT:
 		{
@@ -997,6 +1001,9 @@ int mhi_process_data_event_ring(struct mhi_controller *mhi_cntrl,
 	while (dev_rp != local_rp && event_quota > 0) {
 		enum mhi_pkt_type type = MHI_TRE_GET_EV_TYPE(local_rp);
 
+		trace_mhi_process_data_event_ring(mhi_cntrl->mhi_dev->name, local_rp->ptr,
+						  local_rp->dword[0], local_rp->dword[1]);
+
 		chan = MHI_TRE_GET_EV_CHID(local_rp);
 
 		WARN_ON(chan >= mhi_cntrl->max_chan);
@@ -1235,6 +1242,8 @@ int mhi_gen_tre(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan,
 	mhi_tre->dword[0] = MHI_TRE_DATA_DWORD0(info->len);
 	mhi_tre->dword[1] = MHI_TRE_DATA_DWORD1(bei, eot, eob, chain);
 
+	trace_mhi_gen_tre(mhi_cntrl->mhi_dev->name, mhi_chan->chan, (u64)(mhi_tre),
+			  mhi_tre->ptr, mhi_tre->dword[0], mhi_tre->dword[1]);
 	/* increment WP */
 	mhi_add_ring_element(mhi_cntrl, tre_ring);
 	mhi_add_ring_element(mhi_cntrl, buf_ring);
@@ -1327,9 +1336,8 @@ static int mhi_update_channel_state(struct mhi_controller *mhi_cntrl,
 	enum mhi_cmd_type cmd = MHI_CMD_NOP;
 	int ret;
 
-	dev_dbg(dev, "%d: Updating channel state to: %s\n", mhi_chan->chan,
-		TO_CH_STATE_TYPE_STR(to_state));
-
+	trace_mhi_update_channel_state_start(mhi_cntrl->mhi_dev->name, mhi_chan->chan,
+					     TO_CH_STATE_TYPE_STR(to_state));
 	switch (to_state) {
 	case MHI_CH_STATE_TYPE_RESET:
 		write_lock_irq(&mhi_chan->lock);
@@ -1396,9 +1404,8 @@ static int mhi_update_channel_state(struct mhi_controller *mhi_cntrl,
 		write_unlock_irq(&mhi_chan->lock);
 	}
 
-	dev_dbg(dev, "%d: Channel state change to %s successful\n",
-		mhi_chan->chan, TO_CH_STATE_TYPE_STR(to_state));
-
+	trace_mhi_update_channel_state_end(mhi_cntrl->mhi_dev->name, mhi_chan->chan,
+					   TO_CH_STATE_TYPE_STR(to_state));
 exit_channel_update:
 	mhi_cntrl->runtime_put(mhi_cntrl);
 	mhi_device_put(mhi_cntrl->mhi_dev);
diff --git a/drivers/bus/mhi/host/pm.c b/drivers/bus/mhi/host/pm.c
index 8a4362d75fc4..1a0ccb8ff115 100644
--- a/drivers/bus/mhi/host/pm.c
+++ b/drivers/bus/mhi/host/pm.c
@@ -123,6 +123,8 @@ enum mhi_pm_state __must_check mhi_tryset_pm_state(struct mhi_controller *mhi_cn
 	if (unlikely(!(dev_state_transitions[index].to_states & state)))
 		return cur_state;
 
+	trace_mhi_tryset_pm_state(mhi_cntrl->mhi_dev->name, to_mhi_pm_state_str(state));
+
 	mhi_cntrl->pm_state = state;
 	return mhi_cntrl->pm_state;
 }
@@ -761,8 +763,9 @@ void mhi_pm_st_worker(struct work_struct *work)
 
 	list_for_each_entry_safe(itr, tmp, &head, node) {
 		list_del(&itr->node);
-		dev_dbg(dev, "Handling state transition: %s\n",
-			TO_DEV_STATE_TRANS_STR(itr->state));
+
+		trace_mhi_pm_st_worker(mhi_cntrl->mhi_dev->name,
+				       TO_DEV_STATE_TRANS_STR(itr->state));
 
 		switch (itr->state) {
 		case DEV_ST_TRANSITION_PBL:
diff --git a/include/trace/events/mhi_host.h b/include/trace/events/mhi_host.h
new file mode 100644
index 000000000000..bcb2f12bc1bb
--- /dev/null
+++ b/include/trace/events/mhi_host.h
@@ -0,0 +1,207 @@
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
+
+TRACE_EVENT(mhi_gen_tre,
+
+	TP_PROTO(const char *name, int ch_num, u64 wp, u64 tre_ptr, int dword0, int dword1),
+
+	TP_ARGS(name, ch_num, wp, tre_ptr, dword0, dword1),
+
+	TP_STRUCT__entry(
+		__string(name, name)
+		__field(int, ch_num)
+		__field(u64, wp)
+		__field(u64, tre_ptr)
+		__field(int, dword0)
+		__field(int, dword1)
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
+TRACE_EVENT(mhi_intvec_threaded_handler,
+
+	TP_PROTO(const char *name, const char *local_ee, const char *state, const char *dev_ee,
+		 const char *dev_state),
+
+	TP_ARGS(name, local_ee, state, dev_ee, dev_state),
+
+	TP_STRUCT__entry(
+		__string(name, name)
+		__string(local_ee, local_ee)
+		__string(state, state)
+		__string(dev_ee, dev_ee)
+		__string(dev_state, dev_state)
+	),
+
+	TP_fast_assign(
+		__assign_str(name, name);
+		__assign_str(local_ee, local_ee);
+		__assign_str(state, state);
+		__assign_str(dev_ee, dev_ee);
+		__assign_str(dev_state, dev_state);
+	),
+
+	TP_printk("%s: local ee: %s state: %s device ee: %s state: %s\n",
+		  __get_str(name), __get_str(local_ee), __get_str(state), __get_str(dev_ee),
+		  __get_str(dev_state))
+);
+
+TRACE_EVENT(mhi_tryset_pm_state,
+
+	TP_PROTO(const char *name, const char *pm_state),
+
+	TP_ARGS(name, pm_state),
+
+	TP_STRUCT__entry(
+		__string(name, name)
+		__string(pm_state, pm_state)
+	),
+
+	TP_fast_assign(
+		__assign_str(name, name);
+		__assign_str(pm_state, pm_state);
+	),
+
+	TP_printk("%s: PM state: %s\n", __get_str(name), __get_str(pm_state))
+);
+
+TRACE_EVENT(mhi_process_data_event_ring,
+
+	TP_PROTO(const char *name, u64 ptr, int dword0, int dword1),
+
+	TP_ARGS(name, ptr, dword0, dword1),
+
+	TP_STRUCT__entry(
+		__string(name, name)
+		__field(u64, ptr)
+		__field(int, dword0)
+		__field(int, dword1)
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
+	TP_PROTO(const char *name, u64 rp, u64 ptr, int dword0, int dword1, const char *state),
+
+	TP_ARGS(name, rp, ptr, dword0, dword1, state),
+
+	TP_STRUCT__entry(
+		__string(name, name)
+		__field(u64, rp)
+		__field(u64, ptr)
+		__field(int, dword0)
+		__field(int, dword1)
+		__string(state, state)
+	),
+
+	TP_fast_assign(
+		__assign_str(name, name);
+		__entry->rp = rp;
+		__entry->ptr = ptr;
+		__entry->dword0 = dword0;
+		__entry->dword1 = dword1;
+		__assign_str(state, state);
+	),
+
+	TP_printk("%s: RP:0x%llx Processing Event:0x%llx 0x%08x 0x%08x state:%s\n",
+		  __get_str(name), __entry->rp, __entry->ptr, __entry->dword0,
+		  __entry->dword1, __get_str(state))
+);
+
+TRACE_EVENT(mhi_update_channel_state_start,
+
+	TP_PROTO(const char *name, int ch_num, const char *state),
+
+	TP_ARGS(name, ch_num, state),
+
+	TP_STRUCT__entry(
+		__string(name, name)
+		__field(int, ch_num)
+		__string(state, state)
+	),
+
+	TP_fast_assign(
+		__assign_str(name, name);
+		__entry->ch_num = ch_num;
+		__assign_str(state, state);
+	),
+
+	TP_printk("%s: ch%d: Updating state to: %s\n",
+		  __get_str(name), __entry->ch_num,  __get_str(state))
+);
+
+TRACE_EVENT(mhi_update_channel_state_end,
+
+	TP_PROTO(const char *name, int ch_num, const char *state),
+
+	TP_ARGS(name, ch_num, state),
+
+	TP_STRUCT__entry(
+		__string(name, name)
+		__field(int, ch_num)
+		__string(state, state)
+	),
+
+	TP_fast_assign(
+		__assign_str(name, name);
+		__entry->ch_num = ch_num;
+		__assign_str(state, state);
+	),
+
+	TP_printk("%s: ch%d: Updated state to: %s\n",
+		  __get_str(name), __entry->ch_num,  __get_str(state))
+);
+
+TRACE_EVENT(mhi_pm_st_worker,
+
+	TP_PROTO(const char *name, const char *state),
+
+	TP_ARGS(name, state),
+
+	TP_STRUCT__entry(
+		__string(name, name)
+		__string(state, state)
+	),
+
+	TP_fast_assign(
+		__assign_str(name, name);
+		__assign_str(state, state);
+	),
+
+	TP_printk("%s: Handling state transition: %s\n", __get_str(name), __get_str(state))
+);
+
+#endif
+#include <trace/define_trace.h>

---
base-commit: 3006adf3be79cde4d14b1800b963b82b6e5572e0
change-id: 20231005-ftrace_support-6869d4156139

Best regards,
-- 
Krishna chaitanya chundru <quic_krichai@quicinc.com>

