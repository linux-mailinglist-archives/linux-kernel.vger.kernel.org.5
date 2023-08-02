Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1557976CBDA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 13:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234084AbjHBLg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 07:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233373AbjHBLg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 07:36:56 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF90FC0;
        Wed,  2 Aug 2023 04:36:54 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 372AP73a014557;
        Wed, 2 Aug 2023 10:25:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Nd3nbox1Yp5gXbnSKAJVBiFHsEl6v4P7EXBVF39CE1Q=;
 b=VcTKI77M71cVVpVPjz6o/Z+XiOol3FJAkLJ8dN0swMC+k8LXO2RqUCj4PAr0SJ7wufvK
 i3X0Ik2+A+8Iuc47+SpHXJjmh0nNmF+y/VIYKX3NJq93pBpTaNvVUhWmn8OgDJPcps+K
 lCBXnVuBcshhaJxSH1aqLovVOq8LywKFAUczDlr9ObRicrjrrq8eCLNDg59trryq3UpX
 icm0yLfUxisJAHs1HvE1on6ROVZL8UgbsSFga3UypxsNjtTxl6rXmArfPS7wT7QmnGbr
 7Dy/H9ATmKkXAU2IaS6o9tLKFn7pIG9UO64PIXXAG0heMUXoDviNh3Yq6TVTzdvjrxBk VA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s7nc700g0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Aug 2023 10:25:48 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 372APEVG014880;
        Wed, 2 Aug 2023 10:25:48 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s7nc700ek-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Aug 2023 10:25:48 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37280rLK006066;
        Wed, 2 Aug 2023 09:33:20 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3s5d3skrmq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Aug 2023 09:33:20 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3729XGXt61276658
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Aug 2023 09:33:16 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD21120040;
        Wed,  2 Aug 2023 09:33:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C88F20043;
        Wed,  2 Aug 2023 09:33:16 +0000 (GMT)
Received: from dilbert5.fritz.box (unknown [9.171.33.230])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  2 Aug 2023 09:33:15 +0000 (GMT)
From:   Gerd Bayer <gbayer@linux.ibm.com>
To:     Wenjia Zhang <wenjia@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>,
        Tony Lu <tonylu@linux.alibaba.com>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Karsten Graul <kgraul@linux.ibm.com>,
        "D . Wythe" <alibuda@linux.alibaba.com>,
        Wen Gu <guwen@linux.alibaba.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net 2/2] net/smc: Use correct buffer sizes when switching between TCP and SMC
Date:   Wed,  2 Aug 2023 11:33:13 +0200
Message-ID: <20230802093313.1501605-3-gbayer@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230802093313.1501605-1-gbayer@linux.ibm.com>
References: <20230802093313.1501605-1-gbayer@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MF2qRq3yXebT8YosD3ypu67QDFU5TBBf
X-Proofpoint-ORIG-GUID: 8iDtrv2kcR4Kz9cJ9KTd2R_09fR5xtEP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_05,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 clxscore=1015 mlxlogscore=999 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308020089
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tuning of the effective buffer size through setsockopts was working for
SMC traffic only but not for TCP fall-back connections even before
commit 0227f058aa29 ("net/smc: Unbind r/w buffer size from clcsock and
make them tunable"). That change made it apparent that TCP fall-back
connections would use net.smc.[rw]mem as buffer size instead of
net.ipv4_tcp_[rw]mem.

Amend the code that copies attributes between the (TCP) clcsock and the
SMC socket and adjust buffer sizes appropriately:
- Copy over sk_userlocks so that both sockets agree on whether tuning
  via setsockopt is active.
- When falling back to TCP use sk_sndbuf or sk_rcvbuf as specified with
  setsockopt. Otherwise, use the sysctl value for TCP/IPv4.
- Likewise, use either values from setsockopt or from sysctl for SMC
  (duplicated) on successful SMC connect.

In smc_tcp_listen_work() drop the explicit copy of buffer sizes as that
is taken care of by the attribute copy.

Fixes: 0227f058aa29 ("net/smc: Unbind r/w buffer size from clcsock and make them tunable")
Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
Reviewed-by: Jan Karcher <jaka@linux.ibm.com>

---
 net/smc/af_smc.c | 76 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 54 insertions(+), 22 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 1fcf1e42474a..1c8ed19041d7 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -436,13 +436,63 @@ static int smc_bind(struct socket *sock, struct sockaddr *uaddr,
 	return rc;
 }
 
+/* copy only relevant settings and flags of SOL_SOCKET level from smc to
+ * clc socket (since smc is not called for these options from net/core)
+ */
+
+#define SK_FLAGS_SMC_TO_CLC ((1UL << SOCK_URGINLINE) | \
+			     (1UL << SOCK_KEEPOPEN) | \
+			     (1UL << SOCK_LINGER) | \
+			     (1UL << SOCK_BROADCAST) | \
+			     (1UL << SOCK_TIMESTAMP) | \
+			     (1UL << SOCK_DBG) | \
+			     (1UL << SOCK_RCVTSTAMP) | \
+			     (1UL << SOCK_RCVTSTAMPNS) | \
+			     (1UL << SOCK_LOCALROUTE) | \
+			     (1UL << SOCK_TIMESTAMPING_RX_SOFTWARE) | \
+			     (1UL << SOCK_RXQ_OVFL) | \
+			     (1UL << SOCK_WIFI_STATUS) | \
+			     (1UL << SOCK_NOFCS) | \
+			     (1UL << SOCK_FILTER_LOCKED) | \
+			     (1UL << SOCK_TSTAMP_NEW))
+
+/* if set, use value set by setsockopt() - else use IPv4 or SMC sysctl value */
+static void smc_adjust_sock_bufsizes(struct sock *nsk, struct sock *osk,
+				     unsigned long mask)
+{
+	struct net *nnet;
+
+	nnet = nsk->sk_net.net;
+
+	nsk->sk_userlocks = osk->sk_userlocks;
+
+	if (osk->sk_userlocks & SOCK_SNDBUF_LOCK) {
+		nsk->sk_sndbuf = osk->sk_sndbuf;
+	} else {
+		if (mask == SK_FLAGS_SMC_TO_CLC)
+			WRITE_ONCE(nsk->sk_sndbuf,
+				   READ_ONCE(nnet->ipv4.sysctl_tcp_wmem[1]));
+		else
+			WRITE_ONCE(nsk->sk_sndbuf,
+				   2 * READ_ONCE(nnet->smc.sysctl_wmem));
+	}
+	if (osk->sk_userlocks & SOCK_RCVBUF_LOCK) {
+		nsk->sk_rcvbuf = osk->sk_rcvbuf;
+	} else {
+		if (mask == SK_FLAGS_SMC_TO_CLC)
+			WRITE_ONCE(nsk->sk_rcvbuf,
+				   READ_ONCE(nnet->ipv4.sysctl_tcp_rmem[1]));
+		else
+			WRITE_ONCE(nsk->sk_rcvbuf,
+				   2 * READ_ONCE(nnet->smc.sysctl_rmem));
+	}
+}
+
 static void smc_copy_sock_settings(struct sock *nsk, struct sock *osk,
 				   unsigned long mask)
 {
 	/* options we don't get control via setsockopt for */
 	nsk->sk_type = osk->sk_type;
-	nsk->sk_sndbuf = osk->sk_sndbuf;
-	nsk->sk_rcvbuf = osk->sk_rcvbuf;
 	nsk->sk_sndtimeo = osk->sk_sndtimeo;
 	nsk->sk_rcvtimeo = osk->sk_rcvtimeo;
 	nsk->sk_mark = osk->sk_mark;
@@ -453,26 +503,10 @@ static void smc_copy_sock_settings(struct sock *nsk, struct sock *osk,
 
 	nsk->sk_flags &= ~mask;
 	nsk->sk_flags |= osk->sk_flags & mask;
+
+	smc_adjust_sock_bufsizes(nsk, osk, mask);
 }
 
-#define SK_FLAGS_SMC_TO_CLC ((1UL << SOCK_URGINLINE) | \
-			     (1UL << SOCK_KEEPOPEN) | \
-			     (1UL << SOCK_LINGER) | \
-			     (1UL << SOCK_BROADCAST) | \
-			     (1UL << SOCK_TIMESTAMP) | \
-			     (1UL << SOCK_DBG) | \
-			     (1UL << SOCK_RCVTSTAMP) | \
-			     (1UL << SOCK_RCVTSTAMPNS) | \
-			     (1UL << SOCK_LOCALROUTE) | \
-			     (1UL << SOCK_TIMESTAMPING_RX_SOFTWARE) | \
-			     (1UL << SOCK_RXQ_OVFL) | \
-			     (1UL << SOCK_WIFI_STATUS) | \
-			     (1UL << SOCK_NOFCS) | \
-			     (1UL << SOCK_FILTER_LOCKED) | \
-			     (1UL << SOCK_TSTAMP_NEW))
-/* copy only relevant settings and flags of SOL_SOCKET level from smc to
- * clc socket (since smc is not called for these options from net/core)
- */
 static void smc_copy_sock_settings_to_clc(struct smc_sock *smc)
 {
 	smc_copy_sock_settings(smc->clcsock->sk, &smc->sk, SK_FLAGS_SMC_TO_CLC);
@@ -2479,8 +2513,6 @@ static void smc_tcp_listen_work(struct work_struct *work)
 		sock_hold(lsk); /* sock_put in smc_listen_work */
 		INIT_WORK(&new_smc->smc_listen_work, smc_listen_work);
 		smc_copy_sock_settings_to_smc(new_smc);
-		new_smc->sk.sk_sndbuf = lsmc->sk.sk_sndbuf;
-		new_smc->sk.sk_rcvbuf = lsmc->sk.sk_rcvbuf;
 		sock_hold(&new_smc->sk); /* sock_put in passive closing */
 		if (!queue_work(smc_hs_wq, &new_smc->smc_listen_work))
 			sock_put(&new_smc->sk);
-- 
2.41.0

