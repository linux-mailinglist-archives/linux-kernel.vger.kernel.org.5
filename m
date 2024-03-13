Return-Path: <linux-kernel+bounces-102514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE7487B31F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01F4C1F274AC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1067258AA7;
	Wed, 13 Mar 2024 20:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cJmdM3H6"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4249E53390;
	Wed, 13 Mar 2024 20:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710363500; cv=none; b=PfjkGCDpT9AZt2Eidgdlr35j2Pe0wVJHs0cC0jzc3lULBN6ZJJTxkJYB3lJ5I6BUWzXkUoNzl19r3Ntl2I3WblU9AfWD+OpbYviYO4UOdo6X0/rAFt99x12q7XCTtFIiFsPZGnr4I7ee+Y4caN60P07gDOEW4uqvRJIqFMzNV6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710363500; c=relaxed/simple;
	bh=NpFjcNUfQjg6JaWNs+hjX6QA8yWopkHnzplj60Jq23A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SwmImfRSRUtGgdAie6VGegzqhI2tLEfxoT28MWR0YzzoOXPq/Sj7HfnuSHTtHH98NMz2AZiWYIsnVFyU/JyHnS6BFhDmah+BMGuTSHAw1yaOJwCWIdOrjVAD+ud5IxLV4CA+XFUStMM8BatDmtSZYWgO+nO/jyPeUvrxfLKUtLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cJmdM3H6; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42DJ0XDF010221;
	Wed, 13 Mar 2024 20:58:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=dDUKIL4CKAJWHXeBf8m3+sEfmmg46fIcRdtOGVn5uUI=;
 b=cJmdM3H6QITo230Xq0844UknYHcMCvRuO/jBWBXnpVV0lIWb24qOo5zhaqNXySLjTz5B
 FuzOYka6pkwz3kn1n80aSO0uCpLjyIBsx3D48MJqZbbxvpDxZqiQ3+T6VfLzU1r50jlk
 LOmTeYXlPiBBwTjFWpxSoWQP+JIr4IZUw8QUnM62j1svYpp5CturIrLTV5ZSSB3p3H+c
 PHXzrDekDUQFS7i3DHzbA5IDojXs+uAH7gxzVkVe1hrzajuwtewA6gS9UXQpM2VhOIUl
 7GIUgpLeLhIuVadwiNi0bAMZgw0LMPnko4VjIZU9EXDGLv5jurjUaCx7NLoBSV3OAA99 OA== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wug29k1q3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 20:58:16 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42DJn38S018552;
	Wed, 13 Mar 2024 20:58:16 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ws4t281hk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 20:58:16 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42DKwC6l32309524
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Mar 2024 20:58:14 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5739D58056;
	Wed, 13 Mar 2024 20:58:12 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE0CB5805A;
	Wed, 13 Mar 2024 20:58:11 +0000 (GMT)
Received: from jason-laptop.ibmuc.com (unknown [9.61.59.128])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 13 Mar 2024 20:58:11 +0000 (GMT)
From: "Jason J. Herne" <jjherne@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, pasic@linux.ibm.com, akrowiak@linux.ibm.com,
        borntraeger@de.ibm.com, agordeev@linux.ibm.com, gor@linux.ibm.com
Subject: [PATCH v3 5/5] docs: Update s390 vfio-ap doc for ap_config sysfs attribute
Date: Wed, 13 Mar 2024 16:58:07 -0400
Message-ID: <20240313205807.30554-6-jjherne@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240313205807.30554-1-jjherne@linux.ibm.com>
References: <20240313205807.30554-1-jjherne@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XK_49SgAFNsu43T5h2JENt48jYYOt8XW
X-Proofpoint-GUID: XK_49SgAFNsu43T5h2JENt48jYYOt8XW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-13_09,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403130160

A new sysfs attribute, ap_config, for the vfio_ap driver is
documented.

Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
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


