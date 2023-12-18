Return-Path: <linux-kernel+bounces-3467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C91C816CBF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA7DB2810F3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D041C6B4;
	Mon, 18 Dec 2023 11:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TGLaTVKb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21AA1C698;
	Mon, 18 Dec 2023 11:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BIArvvC003521;
	Mon, 18 Dec 2023 11:40:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	qcppdkim1; bh=qhSUy+6TOTvWGOHRrcWbcV5KaOQ6iVEmTghe6XRp+Lg=; b=TG
	LaTVKb/KVPbaFMXKQ6a+OKqzri/hylahTK5DtWB5wMNVO60nN9C4IwxKM3eA3Zun
	9ki6bCuCcvsd+kuhbjN3aOe8d6EngcJQDnnR0QHecys6h6uWF0QHyHupPUj28M4a
	b3aEXt+kd3GLpBO5XCWMWCAOHu2Fe7Adb3BReTfQYIvmTrUgKTcAsI/eNRFSDupG
	oCAgeuk2thV8REtKHBKzPIibAeTTLqNrwmtxC47Wuj79UDC23RVseYUyX23HpYqr
	QgliLZcYSk6vuW1AVjztrTodgoTcjntwibV8dmlp6ziG3wKPuN+XBoHom5cat916
	H7nUlExdye6CW+43sdfw==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v2mb9g4xy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 11:40:03 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3BIBe0ww004854;
	Mon, 18 Dec 2023 11:40:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3v14ym00ag-2;
	Mon, 18 Dec 2023 11:40:00 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BIBX7pR030023;
	Mon, 18 Dec 2023 11:33:08 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-dikshita-hyd.qualcomm.com [10.213.110.13])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3BIBX6B7029967;
	Mon, 18 Dec 2023 11:33:08 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 347544)
	id 55BF1232E; Mon, 18 Dec 2023 17:03:04 +0530 (+0530)
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
To: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        stanimir.k.varbanov@gmail.com, quic_vgarodia@quicinc.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, bryan.odonoghue@linaro.org
Cc: linux-arm-msm@vger.kernel.org, quic_abhinavk@quicinc.com,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Subject: [PATCH v2 22/34] media: iris: introduce instance states
Date: Mon, 18 Dec 2023 17:02:17 +0530
Message-Id: <1702899149-21321-23-git-send-email-quic_dikshita@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
References: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: X7JjZwzpVHK3NnlkLrxR0-h3_3ESkyBr
X-Proofpoint-GUID: X7JjZwzpVHK3NnlkLrxR0-h3_3ESkyBr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 impostorscore=0 adultscore=0 mlxscore=0 clxscore=1015
 spamscore=0 mlxlogscore=944 phishscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312180084
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Introduce different states for instances. State transitions
are defined, based on which they would be allowed/rejected/ignored.

IRIS_INST_OPEN - video instance is opened.
IRIS_INST_INPUT_STREAMING - stream on is completed on output plane.
IRIS_INST_OUTPUT_STREAMING - stream on is completed on capture
plane.
IRIS_INST_STREAMING - stream on is completed on both output and
capture planes.
IRIS_INST_CLOSE - video instance is closed.
IRIS_INST_ERROR - error state.

                   |
                   v
            -------------
  +---------|    OPEN   |---------  +
  |         -------------           |
  |            ^    ^               |
  |           /      \              |
  |          /        \             |
  |         v          v            |
  |    -----------    -----------   |
  |   |   INPUT         OUTPUT  |   |
  |---| STREAMING     STREAMING |---|
  |    -----------    -----------   |
  |        ^            ^           |
  |         \          /            |
  |          \        /             |
  |           v      v              |
  |         -------------           |
  |--------|  STREAMING |-----------|
  |         -------------           |
  |               |                 |
  |               |                 |
  |               v                 |
  |          -----------            |
  +-------->|   CLOSE   |<----------+
  |          -----------            |
  |               |                 |
  |               |                 |
  |               v                 |
  |          ----------             |
  +-------->|   ERROR  |<-----------+
             ----------

Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
---
 .../platform/qcom/vcodec/iris/iris_instance.h      |  2 +
 .../media/platform/qcom/vcodec/iris/iris_state.c   | 86 ++++++++++++++++++++++
 .../media/platform/qcom/vcodec/iris/iris_state.h   | 22 ++++++
 drivers/media/platform/qcom/vcodec/iris/iris_vb2.c |  3 +
 .../media/platform/qcom/vcodec/iris/iris_vidc.c    |  5 ++
 5 files changed, 118 insertions(+)

diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_instance.h b/drivers/media/platform/qcom/vcodec/iris/iris_instance.h
index 5d4c856..275efa8 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_instance.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_instance.h
@@ -37,6 +37,7 @@
  * @codec: codec type
  * @buffers: structure of buffer info
  * @fw_min_count: minimnum count of buffers needed by fw
+ * @state: instance state
  */
 
 struct iris_inst {
@@ -60,6 +61,7 @@ struct iris_inst {
 	enum codec_type			codec;
 	struct iris_buffers_info	buffers;
 	u32				fw_min_count;
+	enum iris_inst_state		state;
 };
 
 #endif
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_state.c b/drivers/media/platform/qcom/vcodec/iris/iris_state.c
index 83bbc6b..9bf79a0 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_state.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_state.c
@@ -69,3 +69,89 @@ int iris_change_core_state(struct iris_core *core,
 
 	return ret;
 }
+
+struct iris_inst_state_change_allow {
+	enum iris_inst_state        from;
+	enum iris_inst_state        to;
+	enum state_change           allow;
+};
+
+static enum state_change iris_allow_inst_state_change(struct iris_inst *inst,
+						      enum iris_inst_state req_state)
+{
+	enum state_change allow = STATE_CHANGE_ALLOW;
+	int cnt;
+	static struct iris_inst_state_change_allow state[] = {
+		/* from, to, allow */
+		{IRIS_INST_OPEN,             IRIS_INST_OPEN,               STATE_CHANGE_IGNORE    },
+		{IRIS_INST_OPEN,             IRIS_INST_INPUT_STREAMING,    STATE_CHANGE_ALLOW     },
+		{IRIS_INST_OPEN,             IRIS_INST_OUTPUT_STREAMING,   STATE_CHANGE_ALLOW     },
+		{IRIS_INST_OPEN,             IRIS_INST_STREAMING,          STATE_CHANGE_DISALLOW  },
+		{IRIS_INST_OPEN,             IRIS_INST_CLOSE,              STATE_CHANGE_ALLOW     },
+		{IRIS_INST_OPEN,             IRIS_INST_ERROR,              STATE_CHANGE_ALLOW     },
+
+		{IRIS_INST_INPUT_STREAMING,  IRIS_INST_OPEN,               STATE_CHANGE_ALLOW     },
+		{IRIS_INST_INPUT_STREAMING,  IRIS_INST_INPUT_STREAMING,    STATE_CHANGE_IGNORE    },
+		{IRIS_INST_INPUT_STREAMING,  IRIS_INST_OUTPUT_STREAMING,   STATE_CHANGE_DISALLOW  },
+		{IRIS_INST_INPUT_STREAMING,  IRIS_INST_STREAMING,          STATE_CHANGE_ALLOW     },
+		{IRIS_INST_INPUT_STREAMING,  IRIS_INST_CLOSE,              STATE_CHANGE_ALLOW     },
+		{IRIS_INST_INPUT_STREAMING,  IRIS_INST_ERROR,              STATE_CHANGE_ALLOW     },
+
+		{IRIS_INST_OUTPUT_STREAMING, IRIS_INST_OPEN,               STATE_CHANGE_ALLOW     },
+		{IRIS_INST_OUTPUT_STREAMING, IRIS_INST_INPUT_STREAMING,    STATE_CHANGE_DISALLOW  },
+		{IRIS_INST_OUTPUT_STREAMING, IRIS_INST_OUTPUT_STREAMING,   STATE_CHANGE_IGNORE    },
+		{IRIS_INST_OUTPUT_STREAMING, IRIS_INST_STREAMING,          STATE_CHANGE_ALLOW     },
+		{IRIS_INST_OUTPUT_STREAMING, IRIS_INST_CLOSE,              STATE_CHANGE_ALLOW     },
+		{IRIS_INST_OUTPUT_STREAMING, IRIS_INST_ERROR,              STATE_CHANGE_ALLOW     },
+
+		{IRIS_INST_STREAMING,        IRIS_INST_OPEN,               STATE_CHANGE_DISALLOW  },
+		{IRIS_INST_STREAMING,        IRIS_INST_INPUT_STREAMING,    STATE_CHANGE_ALLOW     },
+		{IRIS_INST_STREAMING,        IRIS_INST_OUTPUT_STREAMING,   STATE_CHANGE_ALLOW     },
+		{IRIS_INST_STREAMING,        IRIS_INST_STREAMING,          STATE_CHANGE_IGNORE    },
+		{IRIS_INST_STREAMING,        IRIS_INST_CLOSE,              STATE_CHANGE_ALLOW     },
+		{IRIS_INST_STREAMING,        IRIS_INST_ERROR,              STATE_CHANGE_ALLOW     },
+
+		{IRIS_INST_CLOSE,            IRIS_INST_OPEN,               STATE_CHANGE_DISALLOW  },
+		{IRIS_INST_CLOSE,            IRIS_INST_INPUT_STREAMING,    STATE_CHANGE_DISALLOW  },
+		{IRIS_INST_CLOSE,            IRIS_INST_OUTPUT_STREAMING,   STATE_CHANGE_DISALLOW  },
+		{IRIS_INST_CLOSE,            IRIS_INST_STREAMING,          STATE_CHANGE_DISALLOW  },
+		{IRIS_INST_CLOSE,            IRIS_INST_CLOSE,              STATE_CHANGE_IGNORE    },
+		{IRIS_INST_CLOSE,            IRIS_INST_ERROR,              STATE_CHANGE_IGNORE    },
+
+		{IRIS_INST_ERROR,            IRIS_INST_OPEN,               STATE_CHANGE_IGNORE    },
+		{IRIS_INST_ERROR,            IRIS_INST_INPUT_STREAMING,    STATE_CHANGE_IGNORE    },
+		{IRIS_INST_ERROR,            IRIS_INST_OUTPUT_STREAMING,   STATE_CHANGE_IGNORE    },
+		{IRIS_INST_ERROR,            IRIS_INST_STREAMING,          STATE_CHANGE_IGNORE    },
+		{IRIS_INST_ERROR,            IRIS_INST_CLOSE,              STATE_CHANGE_IGNORE    },
+		{IRIS_INST_ERROR,            IRIS_INST_ERROR,              STATE_CHANGE_IGNORE    },
+	};
+
+	for (cnt = 0; cnt < ARRAY_SIZE(state); cnt++) {
+		if (state[cnt].from == inst->state && state[cnt].to == req_state) {
+			allow = state[cnt].allow;
+			break;
+		}
+	}
+
+	return allow;
+}
+
+int iris_inst_change_state(struct iris_inst *inst,
+			   enum iris_inst_state request_state)
+{
+	enum state_change allow;
+
+	if (IS_SESSION_ERROR(inst))
+		return 0;
+
+	if (inst->state == request_state)
+		return 0;
+
+	allow = iris_allow_inst_state_change(inst, request_state);
+	if (allow != STATE_CHANGE_ALLOW)
+		return (allow == STATE_CHANGE_DISALLOW ? -EINVAL : 0);
+
+	inst->state = request_state;
+
+	return 0;
+}
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_state.h b/drivers/media/platform/qcom/vcodec/iris/iris_state.h
index ee20842..6db95a1 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_state.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_state.h
@@ -7,6 +7,7 @@
 #define _IRIS_STATE_H_
 
 struct iris_core;
+struct iris_inst;
 
 enum iris_core_state {
 	IRIS_CORE_DEINIT,
@@ -15,8 +16,29 @@ enum iris_core_state {
 	IRIS_CORE_ERROR,
 };
 
+enum iris_inst_state {
+	IRIS_INST_OPEN,
+	IRIS_INST_INPUT_STREAMING,
+	IRIS_INST_OUTPUT_STREAMING,
+	IRIS_INST_STREAMING,
+	IRIS_INST_CLOSE,
+	IRIS_INST_ERROR,
+};
+
+enum state_change {
+	STATE_CHANGE_ALLOW,
+	STATE_CHANGE_DISALLOW,
+	STATE_CHANGE_IGNORE,
+};
+
+#define IS_SESSION_ERROR(inst) \
+((inst)->state == IRIS_INST_ERROR)
+
 bool core_in_valid_state(struct iris_core *core);
 int iris_change_core_state(struct iris_core *core,
 			   enum iris_core_state request_state);
 
+int iris_inst_change_state(struct iris_inst *inst,
+			   enum iris_inst_state request_state);
+
 #endif
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_vb2.c b/drivers/media/platform/qcom/vcodec/iris/iris_vb2.c
index a57b5fb..8f499a9 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_vb2.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_vb2.c
@@ -34,6 +34,9 @@ int iris_vb2_queue_setup(struct vb2_queue *q,
 	else
 		f = inst->fmt_dst;
 
+	if (inst->state == IRIS_INST_STREAMING)
+		return -EINVAL;
+
 	if (*num_planes) {
 		if (*num_planes != f->fmt.pix_mp.num_planes ||
 		    sizes[0] < f->fmt.pix_mp.plane_fmt[0].sizeimage)
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_vidc.c b/drivers/media/platform/qcom/vcodec/iris/iris_vidc.c
index 124333a..68ba75f 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_vidc.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_vidc.c
@@ -168,6 +168,7 @@ int vidc_open(struct file *filp)
 
 	inst->core = core;
 	inst->session_id = hash32_ptr(inst);
+	iris_inst_change_state(inst, IRIS_INST_OPEN);
 	mutex_init(&inst->ctx_q_lock);
 
 	ret = vidc_add_session(inst);
@@ -244,6 +245,7 @@ int vidc_close(struct file *filp)
 	v4l2_ctrl_handler_free(&inst->ctrl_handler);
 	vdec_inst_deinit(inst);
 	close_session(inst);
+	iris_inst_change_state(inst, IRIS_INST_CLOSE);
 	vidc_vb2_queue_deinit(inst);
 	vidc_v4l2_fh_deinit(inst);
 	vidc_remove_session(inst);
@@ -295,6 +297,9 @@ static __poll_t vidc_poll(struct file *filp, struct poll_table_struct *pt)
 	if (!inst)
 		return EPOLLERR;
 
+	if (IS_SESSION_ERROR(inst))
+		return EPOLLERR;
+
 	poll_wait(filp, &inst->fh.wait, pt);
 	poll_wait(filp, &inst->vb2q_src->done_wq, pt);
 	poll_wait(filp, &inst->vb2q_dst->done_wq, pt);
-- 
2.7.4


