Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C685C759F84
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 22:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbjGSUTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 16:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjGSUT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 16:19:26 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ACF31FF1;
        Wed, 19 Jul 2023 13:19:22 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36JFOhPX025943;
        Wed, 19 Jul 2023 20:19:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=/Fz4A0FJfYyPSacR9/FCi93FxvaOZZWteruwoflNKIQ=;
 b=rGgusMhyylFdiD9zIwTbKke67aRlQNZDI3q6tjuafpcNgI4VoswS/HqOqKynqQrHHUdH
 s+VipjEVRjLY+SXRMkDqIlWNxSsSankCsqzt7E6t+NS3flXo4+lZPpOKfM2mfa8c2l14
 o+U9p3NF55JFr5X9dSUPOcjGff7+1GyNdsnGvYOVz2iwP0XrKFevIaad8sJC1D+8eGGq
 QkFkg7EEIQ8ZmAt+TX59Zq/iU1m6uyRYq/orcaxDQjoioD8ddtbtzHcZi2EP/VsIwEeE
 4lwXAhTgjbePzdGF/gvI3pz6grPhtimVb3vr5tiyVQpemHoI6RxW7HxDf65fX2vMDJ0c DQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run770dmr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jul 2023 20:18:59 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36JJMMK3038186;
        Wed, 19 Jul 2023 20:18:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw7dwvu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jul 2023 20:18:58 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36JKIrMi007349;
        Wed, 19 Jul 2023 20:18:58 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3ruhw7dwct-5;
        Wed, 19 Jul 2023 20:18:58 +0000
From:   Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
To:     davem@davemloft.net
Cc:     Liam.Howlett@Oracle.com, akpm@linux-foundation.org,
        david@fries.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, zbr@ioremap.net, brauner@kernel.org,
        johannes@sipsolutions.net, ecree.xilinx@gmail.com, leon@kernel.org,
        keescook@chromium.org, socketcan@hartkopp.net, petrm@nvidia.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        anjali.k.kulkarni@oracle.com
Subject: [PATCH net-next v10 4/6] connector/cn_proc: Performance improvements
Date:   Wed, 19 Jul 2023 13:18:19 -0700
Message-ID: <20230719201821.495037-5-anjali.k.kulkarni@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230719201821.495037-1-anjali.k.kulkarni@oracle.com>
References: <20230719201821.495037-1-anjali.k.kulkarni@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_14,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307190183
X-Proofpoint-GUID: fsEwraUTyjbgfegkvnp4KjkgI7XnJwpO
X-Proofpoint-ORIG-GUID: fsEwraUTyjbgfegkvnp4KjkgI7XnJwpO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the capability to filter messages sent by the proc
connector on the event type supplied in the message from the client
to the connector. The client can register to listen for an event type
given in struct proc_input.

This event based filteting will greatly enhance performance - handling
8K exits takes about 70ms, whereas 8K-forks + 8K-exits takes about 150ms
& handling 8K-forks + 8K-exits + 8K-execs takes 200ms. There are currently
9 different types of events, and we need to listen to all of them. Also,
measuring the time using pidfds for monitoring 8K process exits took
much longer - 200ms, as compared to 70ms using only exit notifications of
proc connector.

We also add a new event type - PROC_EVENT_NONZERO_EXIT, which is
only sent by kernel to a listening application when any process exiting,
has a non-zero exit status. This will help the clients like Oracle DB,
where a monitoring process wants notfications for non-zero process exits
so it can cleanup after them.

This kind of a new event could also be useful to other applications like
Google's lmkd daemon, which needs a killed process's exit notification.

The patch takes care that existing clients using old mechanism of not
sending the event type work without any changes.

cn_filter function checks to see if the event type being notified via
proc connector matches the event type requested by client, before
sending(matches) or dropping(does not match) a packet.

Signed-off-by: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 drivers/connector/cn_proc.c  | 62 ++++++++++++++++++++++++++++++++----
 include/uapi/linux/cn_proc.h | 19 +++++++++++
 2 files changed, 75 insertions(+), 6 deletions(-)

diff --git a/drivers/connector/cn_proc.c b/drivers/connector/cn_proc.c
index 1ba288ed2bf7..dfc84d44f804 100644
--- a/drivers/connector/cn_proc.c
+++ b/drivers/connector/cn_proc.c
@@ -50,21 +50,45 @@ static DEFINE_PER_CPU(struct local_event, local_event) = {
 
 static int cn_filter(struct sock *dsk, struct sk_buff *skb, void *data)
 {
+	__u32 what, exit_code, *ptr;
 	enum proc_cn_mcast_op mc_op;
+	uintptr_t val;
 
-	if (!dsk)
+	if (!dsk || !data)
 		return 0;
 
+	ptr = (__u32 *)data;
+	what = *ptr++;
+	exit_code = *ptr;
+	val = ((struct proc_input *)(dsk->sk_user_data))->event_type;
 	mc_op = ((struct proc_input *)(dsk->sk_user_data))->mcast_op;
 
 	if (mc_op == PROC_CN_MCAST_IGNORE)
 		return 1;
 
-	return 0;
+	if ((__u32)val == PROC_EVENT_ALL)
+		return 0;
+
+	/*
+	 * Drop packet if we have to report only non-zero exit status
+	 * (PROC_EVENT_NONZERO_EXIT) and exit status is 0
+	 */
+	if (((__u32)val & PROC_EVENT_NONZERO_EXIT) &&
+	    (what == PROC_EVENT_EXIT)) {
+		if (exit_code)
+			return 0;
+	}
+
+	if ((__u32)val & what)
+		return 0;
+
+	return 1;
 }
 
 static inline void send_msg(struct cn_msg *msg)
 {
+	__u32 filter_data[2];
+
 	local_lock(&local_event.lock);
 
 	msg->seq = __this_cpu_inc_return(local_event.count) - 1;
@@ -76,8 +100,16 @@ static inline void send_msg(struct cn_msg *msg)
 	 *
 	 * If cn_netlink_send() fails, the data is not sent.
 	 */
+	filter_data[0] = ((struct proc_event *)msg->data)->what;
+	if (filter_data[0] == PROC_EVENT_EXIT) {
+		filter_data[1] =
+		((struct proc_event *)msg->data)->event_data.exit.exit_code;
+	} else {
+		filter_data[1] = 0;
+	}
+
 	cn_netlink_send_mult(msg, msg->len, 0, CN_IDX_PROC, GFP_NOWAIT,
-			     cn_filter, NULL);
+			     cn_filter, (void *)filter_data);
 
 	local_unlock(&local_event.lock);
 }
@@ -357,12 +389,15 @@ static void cn_proc_ack(int err, int rcvd_seq, int rcvd_ack)
 
 /**
  * cn_proc_mcast_ctl
- * @data: message sent from userspace via the connector
+ * @msg: message sent from userspace via the connector
+ * @nsp: NETLINK_CB of the client's socket buffer
  */
 static void cn_proc_mcast_ctl(struct cn_msg *msg,
 			      struct netlink_skb_parms *nsp)
 {
 	enum proc_cn_mcast_op mc_op = 0, prev_mc_op = 0;
+	struct proc_input *pinput = NULL;
+	enum proc_cn_event ev_type = 0;
 	int err = 0, initial = 0;
 	struct sock *sk = NULL;
 
@@ -381,10 +416,21 @@ static void cn_proc_mcast_ctl(struct cn_msg *msg,
 		goto out;
 	}
 
-	if (msg->len == sizeof(mc_op))
+	if (msg->len == sizeof(*pinput)) {
+		pinput = (struct proc_input *)msg->data;
+		mc_op = pinput->mcast_op;
+		ev_type = pinput->event_type;
+	} else if (msg->len == sizeof(mc_op)) {
 		mc_op = *((enum proc_cn_mcast_op *)msg->data);
-	else
+		ev_type = PROC_EVENT_ALL;
+	} else {
 		return;
+	}
+
+	ev_type = valid_event((enum proc_cn_event)ev_type);
+
+	if (ev_type == PROC_EVENT_NONE)
+		ev_type = PROC_EVENT_ALL;
 
 	if (nsp->sk) {
 		sk = nsp->sk;
@@ -400,6 +446,8 @@ static void cn_proc_mcast_ctl(struct cn_msg *msg,
 			prev_mc_op =
 			((struct proc_input *)(sk->sk_user_data))->mcast_op;
 		}
+		((struct proc_input *)(sk->sk_user_data))->event_type =
+			ev_type;
 		((struct proc_input *)(sk->sk_user_data))->mcast_op = mc_op;
 	}
 
@@ -411,6 +459,8 @@ static void cn_proc_mcast_ctl(struct cn_msg *msg,
 	case PROC_CN_MCAST_IGNORE:
 		if (!initial && (prev_mc_op != PROC_CN_MCAST_IGNORE))
 			atomic_dec(&proc_event_num_listeners);
+		((struct proc_input *)(sk->sk_user_data))->event_type =
+			PROC_EVENT_NONE;
 		break;
 	default:
 		err = EINVAL;
diff --git a/include/uapi/linux/cn_proc.h b/include/uapi/linux/cn_proc.h
index 6a06fb424313..f2afb7cc4926 100644
--- a/include/uapi/linux/cn_proc.h
+++ b/include/uapi/linux/cn_proc.h
@@ -30,6 +30,15 @@ enum proc_cn_mcast_op {
 	PROC_CN_MCAST_IGNORE = 2
 };
 
+#define PROC_EVENT_ALL (PROC_EVENT_FORK | PROC_EVENT_EXEC | PROC_EVENT_UID |  \
+			PROC_EVENT_GID | PROC_EVENT_SID | PROC_EVENT_PTRACE | \
+			PROC_EVENT_COMM | PROC_EVENT_NONZERO_EXIT |           \
+			PROC_EVENT_COREDUMP | PROC_EVENT_EXIT)
+
+/*
+ * If you add an entry in proc_cn_event, make sure you add it in
+ * PROC_EVENT_ALL above as well.
+ */
 enum proc_cn_event {
 	/* Use successive bits so the enums can be used to record
 	 * sets of events as well
@@ -45,15 +54,25 @@ enum proc_cn_event {
 	/* "next" should be 0x00000400 */
 	/* "last" is the last process event: exit,
 	 * while "next to last" is coredumping event
+	 * before that is report only if process dies
+	 * with non-zero exit status
 	 */
+	PROC_EVENT_NONZERO_EXIT = 0x20000000,
 	PROC_EVENT_COREDUMP = 0x40000000,
 	PROC_EVENT_EXIT = 0x80000000
 };
 
 struct proc_input {
 	enum proc_cn_mcast_op mcast_op;
+	enum proc_cn_event event_type;
 };
 
+static inline enum proc_cn_event valid_event(enum proc_cn_event ev_type)
+{
+	ev_type &= PROC_EVENT_ALL;
+	return ev_type;
+}
+
 /*
  * From the user's point of view, the process
  * ID is the thread group ID and thread ID is the internal
-- 
2.41.0

