Return-Path: <linux-kernel+bounces-145455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D76D18A5658
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 147771C228E3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E88580C14;
	Mon, 15 Apr 2024 15:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QW26d0We"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF61D79B84;
	Mon, 15 Apr 2024 15:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713194766; cv=none; b=rY/9HQXT8AYSkUbv4zgtQHEc6zD5U1kIZkC2qmPL6gUmFLdXo0070zl09DUbaUTL1mTsUTlp0yyOhhvkuY2D2ruBnBuU5IPBaIHCqCLv6Zvfd7qsHxQLSnqR+v93RbIRz4YAmM/6sp3m7oXS0MiFAUwJOwB+EhR39I3bB14VrlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713194766; c=relaxed/simple;
	bh=9PD+9L0PVL8I44H98mCx75/QxiCwntwIQP0yJEXXBoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tx2EgO0jXOYba2WQLOhqzts0DltmUCv0Ub/TGmiaa6l9OMqwsFrpV8xkGQ3x94XaRvkDhKuP2RHXrsD0oOGKAGHM8XDPKVJLmpFrfDH1wvl20O0WVAs9ENBMIsyEn9JlGasHhI3fSNCVjM9ZKCEnqYd6GaigL+CRt1/JDfYjkCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QW26d0We; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43FEOirp008827;
	Mon, 15 Apr 2024 15:26:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=nA44NqsR5fKRH/saS36EU5J3ow43IZqAtKqBh0Egb6o=;
 b=QW26d0WeRKPSFtHkwEhITWAJVzNYRvWZVJoMmtp+G3ySVOkvvvdiXk8i0jP/2VzWPiZx
 QnlJkwAl3Mut4fZr1orW7MG0Jj3GMY9gKkxM4lySDzDC677n92WzyetdefvUSghZB14+
 aM1GIEdQXFnzYC99PddGAs4cQItAuCLqURLiWHeoIf4x850TIA7xN+k20WmUFmjste12
 KK4i1JQ4XfJbVVnSs1QFuJmzEd1qHCyGdLZmXjaxQwfxWIMGZsVsoQaNmVX8ofcbx6l0
 ZkaZm+0hDqdJ4jSf1yd3U+eeAVz5Ry5gPP2E2H+YNiNrboMg9Jilr6SGgbyvOz4d26IU Qw== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xh0btgwfw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 15:26:03 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43FFGhVj027354;
	Mon, 15 Apr 2024 15:26:02 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xg4ryrrj1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 15:26:02 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43FFPxY922020848
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Apr 2024 15:26:01 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5501B58059;
	Mon, 15 Apr 2024 15:25:59 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C99C158043;
	Mon, 15 Apr 2024 15:25:58 +0000 (GMT)
Received: from jason-laptop.ibmuc.com (unknown [9.61.81.98])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 15 Apr 2024 15:25:58 +0000 (GMT)
From: "Jason J. Herne" <jjherne@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, pasic@linux.ibm.com, akrowiak@linux.ibm.com,
        borntraeger@de.ibm.com, agordeev@linux.ibm.com, gor@linux.ibm.com,
        hca@linux.ibm.com
Subject: [PATCH v5 5/5] docs: Update s390 vfio-ap doc for ap_config sysfs attribute
Date: Mon, 15 Apr 2024 11:25:55 -0400
Message-ID: <20240415152555.13152-6-jjherne@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240415152555.13152-1-jjherne@linux.ibm.com>
References: <20240415152555.13152-1-jjherne@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hzVM5490X0k7TcU-tw1URiTXQJS3q44R
X-Proofpoint-GUID: hzVM5490X0k7TcU-tw1URiTXQJS3q44R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-15_12,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 suspectscore=0 spamscore=0 impostorscore=0 mlxlogscore=999 phishscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404150100

A new sysfs attribute, ap_config, for the vfio_ap driver is
documented.

Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
Reviewed-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 Documentation/arch/s390/vfio-ap.rst | 30 +++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Documentation/arch/s390/vfio-ap.rst b/Documentation/arch/s390/vfio-ap.rst
index 929ee1c1c940..6056a50ee841 100644
--- a/Documentation/arch/s390/vfio-ap.rst
+++ b/Documentation/arch/s390/vfio-ap.rst
@@ -380,6 +380,36 @@ matrix device.
     control_domains:
       A read-only file for displaying the control domain numbers assigned to the
       vfio_ap mediated device.
+    ap_config:
+        A read/write file that, when written to, allows all three of the
+        vfio_ap mediated device's ap matrix masks to be replaced in one shot.
+        Three masks are given, one for adapters, one for domains, and one for
+        control domains. If the given state cannot be set then no changes are
+        made to the vfio-ap mediated device.
+
+        The format of the data written to ap_config is as follows:
+        {amask},{dmask},{cmask}\n
+
+        \n is a newline character.
+
+        amask, dmask, and cmask are masks identifying which adapters, domains,
+        and control domains should be assigned to the mediated device.
+
+        The format of a mask is as follows:
+        0xNN..NN
+
+        Where NN..NN is 64 hexadecimal characters representing a 256-bit value.
+        The leftmost (highest order) bit represents adapter/domain 0.
+
+        For an example set of masks that represent your mdev's current
+        configuration, simply cat ap_config.
+
+        Setting an adapter or domain number greater than the maximum allowed for
+        the system will result in an error.
+
+        This attribute is intended to be used by automation. End users would be
+        better served using the respective assign/unassign attributes for
+        adapters, domains, and control domains.
 
 * functions:
 
-- 
2.41.0


