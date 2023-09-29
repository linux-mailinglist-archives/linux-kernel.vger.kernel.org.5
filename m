Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A64B7B2CC3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 09:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbjI2HBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 03:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232731AbjI2HA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 03:00:59 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A55F1AA;
        Fri, 29 Sep 2023 00:00:56 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38T6LQpC031501;
        Fri, 29 Sep 2023 07:00:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=CtzVttFFO4WsgPwm00chtznBrZjPBlBPSxDaywJgnjU=;
 b=jMMt/eoCEHO2bvaG6y/COq5FrKiZmfMGgN1UpOO18nvKs72BpMDF+OftJsIVfnjvRpQF
 nVg50IWRuWXpDkEObPdgBXVDHOt6+vsAXahoUD3S3l4aXo5rOEgrkARUTGfGeVDvy3BB
 hbxPCQ8Gg8OE6gWkKbV+BURbZGk5U+soOzItw9XMBr6ZCgvJZysw6Q0SSEqcJrb+Ac1A
 qi4ezQUnArjSE3tJRIdoyS/iCGJVh7wIgoRizMhUHtIEO6OAVhjgMYmg1wCr5CJf9J6B
 UecBcqPuIcS1fBhiSkN1m6NyFZjY0kH3IS/gZFRM3lAOouY4UTRuT2BTPI31lLlMklGR Eg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3td24uaqv4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 07:00:54 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38T70rMe025083
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 07:00:53 GMT
Received: from ekangupt-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Fri, 29 Sep 2023 00:00:50 -0700
From:   Ekansh Gupta <quic_ekangupt@quicinc.com>
To:     <srinivas.kandagatla@linaro.org>, <linux-arm-msm@vger.kernel.org>
CC:     Ekansh Gupta <quic_ekangupt@quicinc.com>,
        <ekangupt@qti.qualcomm.com>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <fastrpc.upstream@qti.qualcomm.com>
Subject: [PATCH v1 2/4] misc: fastrpc: Add polling mode support for fastRPC driver
Date:   Fri, 29 Sep 2023 12:30:28 +0530
Message-ID: <1695970830-12331-3-git-send-email-quic_ekangupt@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1695970830-12331-1-git-send-email-quic_ekangupt@quicinc.com>
References: <1695970830-12331-1-git-send-email-quic_ekangupt@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Tqtj4nlk3P3JxWNwEoPlwACPgPLPC4Az
X-Proofpoint-ORIG-GUID: Tqtj4nlk3P3JxWNwEoPlwACPgPLPC4Az
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_04,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=924 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309290059
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For any remote call to DSP, after sending an invocation message,
fastRPC driver waits for glink response and during this time the
CPU can go into low power modes. Adding a polling mode support
with which fastRPC driver will poll continuously on a memory
after sending a message to remote subsystem which will eliminate
CPU wakeup and scheduling latencies and reduce fastRPC overhead.
With this change, DSP always sends a glink response which will
get ignored if polling mode didn't time out.

Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
---
 drivers/misc/fastrpc.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 3facffd..b5f3734 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -109,6 +109,8 @@
 #define FASTRPC_RSP_VERSION2 2
 /* Early wake up poll completion number received from remoteproc */
 #define FASTRPC_EARLY_WAKEUP_POLL (0xabbccdde)
+/* Poll response number from remote processor for call completion */
+#define FASTRPC_POLL_RESPONSE (0xdecaf)
 /* timeout in us for polling until memory barrier */
 #define FASTRPC_POLL_TIME_MEM_UPDATE (500)
 /* timeout in us for busy polling after early response from remoteproc */
@@ -380,10 +382,14 @@ struct fastrpc_user {
 	struct fastrpc_buf *init_mem;
 
 	u32 profile;
+	/* Threads poll for specified timeout and fall back to glink wait */
+	u32 poll_timeout;
 	int tgid;
 	int pd;
 	bool is_secure_dev;
 	bool sharedcb;
+	/* If set, threads will poll for DSP response instead of glink wait */
+	bool poll_mode;
 	/* Lock for lists */
 	spinlock_t lock;
 	/* lock for allocations */
@@ -1374,6 +1380,11 @@ static int poll_for_remote_response(struct fastrpc_invoke_ctx *ctx, u32 timeout)
 			/* Remote processor sent early response */
 			err = 0;
 			break;
+		} else if (*poll == FASTRPC_POLL_RESPONSE) {
+			err = 0;
+			ctx->is_work_done = true;
+			ctx->retval = 0;
+			break;
 		}
 		if (jj == FASTRPC_POLL_TIME_MEM_UPDATE) {
 			/* Wait for DSP to finish updating poll memory */
@@ -1449,6 +1460,15 @@ static void fastrpc_wait_for_completion(struct fastrpc_invoke_ctx *ctx,
 			if (*ptr_interrupted || ctx->is_work_done)
 				return;
 			break;
+		case POLL_MODE:
+			err = poll_for_remote_response(ctx, ctx->fl->poll_timeout);
+
+			/* If polling timed out, move to normal response state */
+			if (err)
+				ctx->rsp_flags = NORMAL_RESPONSE;
+			else
+				*ptr_interrupted = 0;
+			break;
 		default:
 			*ptr_interrupted = -EBADR;
 			dev_err(ctx->fl->sctx->dev, "unsupported response type:0x%x\n", ctx->rsp_flags);
@@ -2065,6 +2085,32 @@ static int fastrpc_invoke(struct fastrpc_user *fl, char __user *argp)
 	return err;
 }
 
+static int fastrpc_manage_poll_mode(struct fastrpc_user *fl, u32 enable, u32 timeout)
+{
+	const unsigned int MAX_POLL_TIMEOUT_US = 10000;
+
+	if ((fl->cctx->domain_id != CDSP_DOMAIN_ID) || (fl->pd != USER_PD)) {
+		dev_err(&fl->cctx->rpdev->dev, "poll mode only allowed for dynamic CDSP process\n");
+		return -EPERM;
+	}
+	if (timeout > MAX_POLL_TIMEOUT_US) {
+		dev_err(&fl->cctx->rpdev->dev, "poll timeout %u is greater than max allowed value %u\n",
+			timeout, MAX_POLL_TIMEOUT_US);
+		return -EBADMSG;
+	}
+	spin_lock(&fl->lock);
+	if (enable) {
+		fl->poll_mode = true;
+		fl->poll_timeout = timeout;
+	} else {
+		fl->poll_mode = false;
+		fl->poll_timeout = 0;
+	}
+	spin_unlock(&fl->lock);
+	dev_info(&fl->cctx->rpdev->dev, "updated poll mode to %d, timeout %u\n", enable, timeout);
+	return 0;
+}
+
 static int fastrpc_internal_control(struct fastrpc_user *fl,
 					struct fastrpc_internal_control *cp)
 {
@@ -2079,6 +2125,9 @@ static int fastrpc_internal_control(struct fastrpc_user *fl,
 	case FASTRPC_CONTROL_SMMU:
 		fl->sharedcb = cp->smmu.sharedcb;
 		break;
+	case FASTRPC_CONTROL_RPC_POLL:
+		err = fastrpc_manage_poll_mode(fl, cp->lp.enable, cp->lp.latency);
+		break;
 	default:
 		err = -EBADRQC;
 		break;
-- 
2.7.4

