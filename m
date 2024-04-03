Return-Path: <linux-kernel+bounces-129663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC6A896E3B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A72BAB2D2ED
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F11142E97;
	Wed,  3 Apr 2024 11:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KnLpst57"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BEB17583;
	Wed,  3 Apr 2024 11:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712143773; cv=none; b=e8+Hvpmdp7ELPnh/PGpJPwScBaTpPtmEAB2vWfWC5lunkLPmRR+rVbsJqOkeZ965EDkcYcsc/etGTQ3WaztLXHeudYi2KFJ0qIDIH8t6z1odcX+9v1dhJRPzQdNcwqeGFRjo87fXidi2sorxJSwslqpHw+RjxovljtSL3uAGwO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712143773; c=relaxed/simple;
	bh=eBEKgmTKHane4Dqp52MxNEhoor9QSax5g3H7v6Urg3w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=djNO5nu+c2xVnlyRZOuQajADcvo4qEKNtY4FwENK6zpKljmq45BcB0mmU2IAnXORZFAf5+6Gh7qeWiV5RmdtSwQE6FBkoIJlhmvVN4H6/XSeyC3kpTwURI2yB8P7hi9pEzP4L9enbqewMJuW+2XEbNo7b6+RKvaVFDAojRmehBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KnLpst57; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4339t8hW002791;
	Wed, 3 Apr 2024 11:29:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=ec2Fije6X4O/M4nF/nInmoNZVq0q1ZIcyrBfwQBHW/o=;
 b=KnLpst575+PmP+WyYtS3Dwg7jRH26kQuhrO0payT3UV9XNEyOotX3Fl0Dk6Yserh2iiA
 IuxYOsTonb6Oucr5CRWrrQ5qTQLMSEhz18JsYkVeyEL1qdSszdDSLsuVVUJR/fvqaRY9
 4Z7dHIQI/enq/vWMFXgqjBzwJrgc7h8CYsKr8Drj0R/mWAjm9V1FJ6jyZQmZS87aG86i
 1mZnSGVQxJ3u4e4/0WmmcRo5wJcgENoleZLmPlzwCrSHjNMwatoRkap2Td1bJK10+xlp
 V0ZRduSdRqIcMPFv44zH1g13s63Uh5DdcHOwtuv68hS3xTzQOfA6Q5gIkSRkR17NsXpd Vw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x94jx87r6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 11:29:25 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 433BTPQP017280;
	Wed, 3 Apr 2024 11:29:25 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x94jx87nu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 11:29:24 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 433A4VJZ029600;
	Wed, 3 Apr 2024 11:28:01 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x6ys34gbr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 11:28:00 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 433BRtIk45023562
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Apr 2024 11:27:57 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7516020043;
	Wed,  3 Apr 2024 11:27:55 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5465320040;
	Wed,  3 Apr 2024 11:27:54 +0000 (GMT)
Received: from [9.171.60.51] (unknown [9.171.60.51])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  3 Apr 2024 11:27:54 +0000 (GMT)
Message-ID: <a9e1cdfba05279c36b7b85f327af66cf497d42b9.camel@linux.ibm.com>
Subject: Re: [RFC PATCH net-next v5 02/11] net/smc: introduce loopback-ism
 for SMC intra-OS shortcut
From: Gerd Bayer <gbayer@linux.ibm.com>
To: Wen Gu <guwen@linux.alibaba.com>, wintera@linux.ibm.com,
        twinkler@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, wenjia@linux.ibm.com,
        jaka@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, alibuda@linux.alibaba.com,
        tonylu@linux.alibaba.com, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org
Date: Wed, 03 Apr 2024 13:27:54 +0200
In-Reply-To: <20240324135522.108564-3-guwen@linux.alibaba.com>
References: <20240324135522.108564-1-guwen@linux.alibaba.com>
	 <20240324135522.108564-3-guwen@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-2.fc39app4) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QroWNzYyRlpBiCu6AdsAw1Xv9Ni_4Tpb
X-Proofpoint-ORIG-GUID: _Vh-x1q2-JP_K6XSyRo82l68TsDRoIYt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_10,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 adultscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403210000
 definitions=main-2404030079

On Sun, 2024-03-24 at 21:55 +0800, Wen Gu wrote:
> Configuration of this feature is managed through the config SMC_LO.

Hi Wen,

you could omit building smc_loopback.o if CONFIG_SMC_LO was not set if
you included the following fixup-patch. I think it's cleaner to put a
few parts of net/smc/af_smc.c under conditional compile rather than
have most of the contents of net/smc/smc_loopback.c under #ifdef.

From 11a9cfce550f0c4df10eafdd30aa4226d4d522a8 Mon Sep 17 00:00:00 2001
From: Gerd Bayer <gbayer@linux.ibm.com>
Date: Wed, 3 Apr 2024 11:43:36 +0200
Subject: [PATCH] fixup! net/smc: introduce loopback-ism for SMC intra-
OS
 shortcut

---
 net/smc/Makefile       | 5 +++--
 net/smc/af_smc.c       | 6 ++++++
 net/smc/smc_loopback.c | 8 --------
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/net/smc/Makefile b/net/smc/Makefile
index a8c37111abe1..3b73c9d561bb 100644
--- a/net/smc/Makefile
+++ b/net/smc/Makefile
@@ -4,5 +4,6 @@ obj-$(CONFIG_SMC)	+=3D smc.o
 obj-$(CONFIG_SMC_DIAG)	+=3D smc_diag.o
 smc-y :=3D af_smc.o smc_pnet.o smc_ib.o smc_clc.o smc_core.o smc_wr.o
smc_llc.o
 smc-y +=3D smc_cdc.o smc_tx.o smc_rx.o smc_close.o smc_ism.o
smc_netlink.o smc_stats.o
-smc-y +=3D smc_tracepoint.o smc_loopback.o
-smc-$(CONFIG_SYSCTL) +=3D smc_sysctl.o
+smc-y +=3D smc_tracepoint.o
+smc-$(CONFIG_SMC_LO)	+=3D smc_loopback.o
+smc-$(CONFIG_SYSCTL)	+=3D smc_sysctl.o
diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index fce7a5b2ce5c..bcbf600cd271 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -3574,11 +3574,13 @@ static int __init smc_init(void)
 		goto out_sock;
 	}
=20
+#if IS_ENABLED(CONFIG_SMC_LO)
 	rc =3D smc_loopback_init();
 	if (rc) {
 		pr_err("%s: smc_loopback_init fails with %d\n",
__func__, rc);
 		goto out_ib;
 	}
+#endif
=20
 	rc =3D tcp_register_ulp(&smc_ulp_ops);
 	if (rc) {
@@ -3590,8 +3592,10 @@ static int __init smc_init(void)
 	return 0;
=20
 out_lo:
+#if IS_ENABLED(CONFIG_SMC_LO)
 	smc_loopback_exit();
 out_ib:
+#endif
 	smc_ib_unregister_client();
 out_sock:
 	sock_unregister(PF_SMC);
@@ -3628,7 +3632,9 @@ static void __exit smc_exit(void)
 	tcp_unregister_ulp(&smc_ulp_ops);
 	sock_unregister(PF_SMC);
 	smc_core_exit();
+#if IS_ENABLED(CONFIG_SMC_LO)
 	smc_loopback_exit();
+#endif
 	smc_ib_unregister_client();
 	smc_ism_exit();
 	destroy_workqueue(smc_close_wq);
diff --git a/net/smc/smc_loopback.c b/net/smc/smc_loopback.c
index 994fe39930ad..8d0181635ded 100644
--- a/net/smc/smc_loopback.c
+++ b/net/smc/smc_loopback.c
@@ -19,7 +19,6 @@
 #include "smc_ism.h"
 #include "smc_loopback.h"
=20
-#if IS_ENABLED(CONFIG_SMC_LO)
 #define SMC_LO_V2_CAPABLE	0x1 /* loopback-ism acts as ISMv2 */
 #define SMC_LO_SUPPORT_NOCOPY	0x1
 #define SMC_DMA_ADDR_INVALID	(~(dma_addr_t)0)
@@ -442,20 +441,13 @@ static void smc_lo_dev_remove(void)
 	smc_lo_dev_exit(lo_dev);
 	put_device(&lo_dev->dev); /* device_initialize in
smc_lo_dev_probe */
 }
-#endif
=20
 int smc_loopback_init(void)
 {
-#if IS_ENABLED(CONFIG_SMC_LO)
 	return smc_lo_dev_probe();
-#else
-	return 0;
-#endif
 }
=20
 void smc_loopback_exit(void)
 {
-#if IS_ENABLED(CONFIG_SMC_LO)
 	smc_lo_dev_remove();
-#endif
 }
--=20
2.40.1


Even nicer would be, if smc_loopback_init() and smc_loopback_exit()
would have an NO-OP implementation { } straight in
net/smc/smc_loopback.h if CONFIG_SMC_LO was not enabled. That way, one
could leave out the #if ENABLED's in net/smc/af_smc.c entirely.

I think that's more kernel-style like...
Gerd

