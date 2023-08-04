Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B715E77082A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 20:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjHDStx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 14:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjHDStu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 14:49:50 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005F0A9;
        Fri,  4 Aug 2023 11:49:48 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 374IeQSe008304;
        Fri, 4 Aug 2023 18:49:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=QJumNZf8haL2fiWHep9UXE3vaxNlE76FhOZSNxlq2Ss=;
 b=ANbYIpTnOZIYASSuJVnerVKIpWksu77L8JOIwfUlqUG64OpBqbc8WdXfmFNFej0QKb0L
 EUk1fgpFzp4O9Zju5mv9kxwVgOtU9I3N7alrYdD0FaLR0SiMFFtZeYAjs/DDoy4brpiL
 fsQNO2iMYMOlxebtYh2cLBYrGK4SDfUgWbRivywosS/oUDotMOLKzPcELRCTopfVTnKU
 kmdTjXWChb29FY+FvVx3s7X9RzsC5vqGmlXTZiatYqFLJHbDVxrFoEpUVY1oTd6iBLA9
 3KeiAW+fZVWW3F3WThrya0nSfGtVaEkSdRg37GHEbmxu27mCGwNGjT9yyvIkmBA1edsn wA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s96h38fdn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Aug 2023 18:49:45 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 374IhWn9017912;
        Fri, 4 Aug 2023 18:49:44 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s96h38f4a-22
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Aug 2023 18:49:42 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 374Frf5Q021566;
        Fri, 4 Aug 2023 16:30:54 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3s8kmcf9m8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Aug 2023 16:30:54 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 374GUpdJ22086290
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Aug 2023 16:30:51 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 377A220043;
        Fri,  4 Aug 2023 16:30:51 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B2C1D20040;
        Fri,  4 Aug 2023 16:30:50 +0000 (GMT)
Received: from dilbert5.boeblingen.de.ibm.com (unknown [9.155.208.153])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  4 Aug 2023 16:30:50 +0000 (GMT)
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
Subject: [PATCH net-next v3 1/2] net/smc: Fix setsockopt and sysctl to specify same buffer size again
Date:   Fri,  4 Aug 2023 18:30:48 +0200
Message-ID: <20230804163049.937185-2-gbayer@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230804163049.937185-1-gbayer@linux.ibm.com>
References: <20230804163049.937185-1-gbayer@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HEvoDMxEPV9oACCZou67D2z2EXCRUp1x
X-Proofpoint-ORIG-GUID: Mrq2V6uAlOrcbET4VEfKX7aevIJk5CVo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-04_18,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308040165
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 0227f058aa29 ("net/smc: Unbind r/w buffer size from clcsock
and make them tunable") introduced the net.smc.rmem and net.smc.wmem
sysctls to specify the size of buffers to be used for SMC type
connections. This created a regression for users that specified the
buffer size via setsockopt() as the effective buffer size was now
doubled.

Re-introduce the division by 2 in the SMC buffer create code and level
this out by duplicating the net.smc.[rw]mem values used for initializing
sk_rcvbuf/sk_sndbuf at socket creation time. This gives users of both
methods (setsockopt or sysctl) the effective buffer size that they
expect.

Initialize net.smc.[rw]mem from its own constant of 64kB, respectively.
Internal performance tests show that this value is a good compromise
between throughput/latency and memory consumption. Also, this decouples
it from any tuning that was done to net.ipv4.tcp_[rw]mem[1] before the
module for SMC protocol was loaded. Check that no more than INT_MAX / 2
is assigned to net.smc.[rw]mem, in order to avoid any overflow condition
when that is doubled for use in sk_sndbuf or sk_rcvbuf.

While at it, drop the confusing sk_buf_size variable from
__smc_buf_create and name "compressed" buffer size variables more
consistently.

Background:

Before the commit mentioned above, SMC's buffer allocator in
__smc_buf_create() always used half of the sockets' sk_rcvbuf/sk_sndbuf
value as initial value to search for appropriate buffers. If the search
resorted to using a bigger buffer when all buffers of the specified
size were busy, the duplicate of the used effective buffer size is
stored back to sk_rcvbuf/sk_sndbuf.

When available, buffers of exactly the size that a user had specified as
input to setsockopt() were used, despite setsockopt()'s documentation in
"man 7 socket" talking of a mandatory duplication:

[...]
       SO_SNDBUF
              Sets  or  gets the maximum socket send buffer in bytes.
              The kernel doubles this value (to allow space for book‐
              keeping  overhead)  when it is set using setsockopt(2),
              and this doubled value is  returned  by  getsockopt(2).
              The     default     value     is     set     by     the
              /proc/sys/net/core/wmem_default file  and  the  maximum
              allowed value is set by the /proc/sys/net/core/wmem_max
              file.  The minimum (doubled) value for this  option  is
              2048.
[...]

Fixes: 0227f058aa29 ("net/smc: Unbind r/w buffer size from clcsock and make them tunable")
Co-developed-by: Jan Karcher <jaka@linux.ibm.com>
Signed-off-by: Jan Karcher <jaka@linux.ibm.com>
Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
Reviewed-by: Tony Lu <tonylu@linux.alibaba.com>
Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
---
 net/smc/af_smc.c     |  4 ++--
 net/smc/smc.h        |  2 +-
 net/smc/smc_clc.c    |  4 ++--
 net/smc/smc_core.c   | 25 ++++++++++++-------------
 net/smc/smc_sysctl.c | 10 ++++++++--
 5 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 0c013d2b5d8f..5b878e523abf 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -378,8 +378,8 @@ static struct sock *smc_sock_alloc(struct net *net, struct socket *sock,
 	sk->sk_state = SMC_INIT;
 	sk->sk_destruct = smc_destruct;
 	sk->sk_protocol = protocol;
-	WRITE_ONCE(sk->sk_sndbuf, READ_ONCE(net->smc.sysctl_wmem));
-	WRITE_ONCE(sk->sk_rcvbuf, READ_ONCE(net->smc.sysctl_rmem));
+	WRITE_ONCE(sk->sk_sndbuf, 2 * READ_ONCE(net->smc.sysctl_wmem));
+	WRITE_ONCE(sk->sk_rcvbuf, 2 * READ_ONCE(net->smc.sysctl_rmem));
 	smc = smc_sk(sk);
 	INIT_WORK(&smc->tcp_listen_work, smc_tcp_listen_work);
 	INIT_WORK(&smc->connect_work, smc_connect_work);
diff --git a/net/smc/smc.h b/net/smc/smc.h
index 2eeea4cdc718..1f2b912c43d1 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -161,7 +161,7 @@ struct smc_connection {
 
 	struct smc_buf_desc	*sndbuf_desc;	/* send buffer descriptor */
 	struct smc_buf_desc	*rmb_desc;	/* RMBE descriptor */
-	int			rmbe_size_short;/* compressed notation */
+	int                     rmbe_size_comp; /* compressed notation */
 	int			rmbe_update_limit;
 						/* lower limit for consumer
 						 * cursor update
diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
index b9b8b07aa702..c90d9e5dda54 100644
--- a/net/smc/smc_clc.c
+++ b/net/smc/smc_clc.c
@@ -1007,7 +1007,7 @@ static int smc_clc_send_confirm_accept(struct smc_sock *smc,
 		clc->d0.gid =
 			conn->lgr->smcd->ops->get_local_gid(conn->lgr->smcd);
 		clc->d0.token = conn->rmb_desc->token;
-		clc->d0.dmbe_size = conn->rmbe_size_short;
+		clc->d0.dmbe_size = conn->rmbe_size_comp;
 		clc->d0.dmbe_idx = 0;
 		memcpy(&clc->d0.linkid, conn->lgr->id, SMC_LGR_ID_SIZE);
 		if (version == SMC_V1) {
@@ -1050,7 +1050,7 @@ static int smc_clc_send_confirm_accept(struct smc_sock *smc,
 			clc->r0.qp_mtu = min(link->path_mtu, link->peer_mtu);
 			break;
 		}
-		clc->r0.rmbe_size = conn->rmbe_size_short;
+		clc->r0.rmbe_size = conn->rmbe_size_comp;
 		clc->r0.rmb_dma_addr = conn->rmb_desc->is_vm ?
 			cpu_to_be64((uintptr_t)conn->rmb_desc->cpu_addr) :
 			cpu_to_be64((u64)sg_dma_address
diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 3f465faf2b68..6b78075404d7 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -2309,31 +2309,30 @@ static int __smc_buf_create(struct smc_sock *smc, bool is_smcd, bool is_rmb)
 	struct smc_connection *conn = &smc->conn;
 	struct smc_link_group *lgr = conn->lgr;
 	struct list_head *buf_list;
-	int bufsize, bufsize_short;
+	int bufsize, bufsize_comp;
 	struct rw_semaphore *lock;	/* lock buffer list */
 	bool is_dgraded = false;
-	int sk_buf_size;
 
 	if (is_rmb)
 		/* use socket recv buffer size (w/o overhead) as start value */
-		sk_buf_size = smc->sk.sk_rcvbuf;
+		bufsize = smc->sk.sk_rcvbuf / 2;
 	else
 		/* use socket send buffer size (w/o overhead) as start value */
-		sk_buf_size = smc->sk.sk_sndbuf;
+		bufsize = smc->sk.sk_sndbuf / 2;
 
-	for (bufsize_short = smc_compress_bufsize(sk_buf_size, is_smcd, is_rmb);
-	     bufsize_short >= 0; bufsize_short--) {
+	for (bufsize_comp = smc_compress_bufsize(bufsize, is_smcd, is_rmb);
+	     bufsize_comp >= 0; bufsize_comp--) {
 		if (is_rmb) {
 			lock = &lgr->rmbs_lock;
-			buf_list = &lgr->rmbs[bufsize_short];
+			buf_list = &lgr->rmbs[bufsize_comp];
 		} else {
 			lock = &lgr->sndbufs_lock;
-			buf_list = &lgr->sndbufs[bufsize_short];
+			buf_list = &lgr->sndbufs[bufsize_comp];
 		}
-		bufsize = smc_uncompress_bufsize(bufsize_short);
+		bufsize = smc_uncompress_bufsize(bufsize_comp);
 
 		/* check for reusable slot in the link group */
-		buf_desc = smc_buf_get_slot(bufsize_short, lock, buf_list);
+		buf_desc = smc_buf_get_slot(bufsize_comp, lock, buf_list);
 		if (buf_desc) {
 			buf_desc->is_dma_need_sync = 0;
 			SMC_STAT_RMB_SIZE(smc, is_smcd, is_rmb, bufsize);
@@ -2377,8 +2376,8 @@ static int __smc_buf_create(struct smc_sock *smc, bool is_smcd, bool is_rmb)
 
 	if (is_rmb) {
 		conn->rmb_desc = buf_desc;
-		conn->rmbe_size_short = bufsize_short;
-		smc->sk.sk_rcvbuf = bufsize;
+		conn->rmbe_size_comp = bufsize_comp;
+		smc->sk.sk_rcvbuf = bufsize * 2;
 		atomic_set(&conn->bytes_to_rcv, 0);
 		conn->rmbe_update_limit =
 			smc_rmb_wnd_update_limit(buf_desc->len);
@@ -2386,7 +2385,7 @@ static int __smc_buf_create(struct smc_sock *smc, bool is_smcd, bool is_rmb)
 			smc_ism_set_conn(conn); /* map RMB/smcd_dev to conn */
 	} else {
 		conn->sndbuf_desc = buf_desc;
-		smc->sk.sk_sndbuf = bufsize;
+		smc->sk.sk_sndbuf = bufsize * 2;
 		atomic_set(&conn->sndbuf_space, bufsize);
 	}
 	return 0;
diff --git a/net/smc/smc_sysctl.c b/net/smc/smc_sysctl.c
index b6f79fabb9d3..0b2a957ca5f5 100644
--- a/net/smc/smc_sysctl.c
+++ b/net/smc/smc_sysctl.c
@@ -21,6 +21,10 @@
 
 static int min_sndbuf = SMC_BUF_MIN_SIZE;
 static int min_rcvbuf = SMC_BUF_MIN_SIZE;
+static int max_sndbuf = INT_MAX / 2;
+static int max_rcvbuf = INT_MAX / 2;
+static const int net_smc_wmem_init = (64 * 1024);
+static const int net_smc_rmem_init = (64 * 1024);
 
 static struct ctl_table smc_table[] = {
 	{
@@ -53,6 +57,7 @@ static struct ctl_table smc_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= &min_sndbuf,
+		.extra2		= &max_sndbuf,
 	},
 	{
 		.procname	= "rmem",
@@ -61,6 +66,7 @@ static struct ctl_table smc_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= &min_rcvbuf,
+		.extra2		= &max_rcvbuf,
 	},
 	{  }
 };
@@ -88,8 +94,8 @@ int __net_init smc_sysctl_net_init(struct net *net)
 	net->smc.sysctl_autocorking_size = SMC_AUTOCORKING_DEFAULT_SIZE;
 	net->smc.sysctl_smcr_buf_type = SMCR_PHYS_CONT_BUFS;
 	net->smc.sysctl_smcr_testlink_time = SMC_LLC_TESTLINK_DEFAULT_TIME;
-	WRITE_ONCE(net->smc.sysctl_wmem, READ_ONCE(net->ipv4.sysctl_tcp_wmem[1]));
-	WRITE_ONCE(net->smc.sysctl_rmem, READ_ONCE(net->ipv4.sysctl_tcp_rmem[1]));
+	WRITE_ONCE(net->smc.sysctl_wmem, net_smc_wmem_init);
+	WRITE_ONCE(net->smc.sysctl_rmem, net_smc_rmem_init);
 
 	return 0;
 
-- 
2.41.0

