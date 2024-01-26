Return-Path: <linux-kernel+bounces-40194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E1683DC0F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 954D11C23605
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 14:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751191CD36;
	Fri, 26 Jan 2024 14:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UPKbboBm"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D701C693;
	Fri, 26 Jan 2024 14:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706279739; cv=none; b=F48WAIqWlRPsQWm8858mFKgCA2ZDlhOqpJv3B9cPjGZjDIZDfA2AtHXCgZvv/SugTKJbHhE3Ph4CnOKG0WnVX9LHYA1XEr5tjVBWaXqms6eAs1ooM9V/xr07Hyvd6/QblTVSqy+d23Pj3TcRT+KBiSPkniKvdDt/2OlY7hnBNAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706279739; c=relaxed/simple;
	bh=00iuVnMhBqyr7kI4JUWMIzqhsTGDKdX5ZMcXxJXFZXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TWDq8P6Wm3I1qHdoXsx8eEiy+T12STSrdyHgy4ZrZ736tJiXd8+RvSVuymHrCA/5fsNYrCY2e5lne3ObzIL9FTzdmZer1seSG8Vm/RxxKfBkhXe2cavq2elm6rQwYlr5BIKW8W9HJ2v7+KN2wu94ITSSdzaO/EAX87n6ld39j/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UPKbboBm; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40QENFLV028908;
	Fri, 26 Jan 2024 14:35:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=AAtVdCLgElC7PvjzVIgz+2EULBdJfRACXXrd0e9tuuU=;
 b=UPKbboBm5o/GmShhMrxt4s1ehYfgJu7Sg1H6jaeG2/Qj7b6JtGgvIbmk+xzzlTegNOA2
 OhEtheqON0/WGVyx/tLos8NPgBByLsGLslBPgjSFQI5c10nozZhhT5C6jTP7fubKXa/g
 Y5BoEx0rP1Y/0BdwR/4c3e+ULFGCwhQWcBInhVgQXkaniMj4vbYW6ma9v3VsxfzVvkzq
 HxJduBC7tY5lgx7b1CHgA/Z6hyErbgn6+w5Rlqx081ADe/CtKecyAKPTH0M35dzge9UZ
 bGrLG+fcp83ntH7uZjieABDIeVUT8OAG06yg8MtG9+RB2kOmmkRH/wH8YQXiHanhmwAz OQ== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vveeugdgf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 14:35:36 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40QBMNoY010854;
	Fri, 26 Jan 2024 14:35:36 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vrrw0basu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 14:35:35 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40QEZY7K57082352
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jan 2024 14:35:35 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E1DC05805E;
	Fri, 26 Jan 2024 14:35:34 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8AC6358065;
	Fri, 26 Jan 2024 14:35:34 +0000 (GMT)
Received: from li-4795344c-3451-11b2-a85c-ab40c30bcc43.ibm.com (unknown [9.61.37.129])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 26 Jan 2024 14:35:34 +0000 (GMT)
From: "Jason J. Herne" <jjherne@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, pasic@linux.ibm.com, akrowiak@linux.ibm.com
Subject: [PATCH 2/3] s390/vfio-ap: Add sysfs attr, queue_configuration, to export mdev state
Date: Fri, 26 Jan 2024 09:35:32 -0500
Message-ID: <20240126143533.14043-3-jjherne@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240126143533.14043-1-jjherne@linux.ibm.com>
References: <20240126143533.14043-1-jjherne@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yjoNoCCVQS0v0kHK1USf5QXm4i1TeEUs
X-Proofpoint-ORIG-GUID: yjoNoCCVQS0v0kHK1USf5QXm4i1TeEUs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 mlxlogscore=999 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2401260106

Add ap_config sysfs attribute. This will provide the means for
setting or displaying the adapters, domains and control domains assigned
to the vfio-ap mediated device in a single operation. This sysfs
attribute is comprised of three masks: One for adapters, one for domains,
and one for control domains.

This attribute is intended to be used by mdevctl to query a vfio-ap
mediated device's state.

Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 243d252bc631..96293683b939 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -1508,6 +1508,32 @@ static ssize_t guest_matrix_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(guest_matrix);
 
+static ssize_t write_ap_bitmap(unsigned long *bitmap, char *buf, int offset, char sep)
+{
+	return sysfs_emit_at(buf, offset, "0x%016lx%016lx%016lx%016lx%c",
+			 bitmap[0], bitmap[1], bitmap[2], bitmap[3], sep);
+}
+
+static ssize_t ap_config_show(struct device *dev, struct device_attribute *attr,
+			      char *buf)
+{
+	struct ap_matrix_mdev *matrix_mdev = dev_get_drvdata(dev);
+	int idx = 0;
+
+	idx += write_ap_bitmap(matrix_mdev->matrix.apm, buf, idx, ',');
+	idx += write_ap_bitmap(matrix_mdev->matrix.aqm, buf, idx, ',');
+	idx += write_ap_bitmap(matrix_mdev->matrix.adm, buf, idx, '\n');
+
+	return idx;
+}
+
+static ssize_t ap_config_store(struct device *dev, struct device_attribute *attr,
+			       const char *buf, size_t count)
+{
+	return count;
+}
+static DEVICE_ATTR_RW(ap_config);
+
 static struct attribute *vfio_ap_mdev_attrs[] = {
 	&dev_attr_assign_adapter.attr,
 	&dev_attr_unassign_adapter.attr,
@@ -1515,6 +1541,7 @@ static struct attribute *vfio_ap_mdev_attrs[] = {
 	&dev_attr_unassign_domain.attr,
 	&dev_attr_assign_control_domain.attr,
 	&dev_attr_unassign_control_domain.attr,
+	&dev_attr_ap_config.attr,
 	&dev_attr_control_domains.attr,
 	&dev_attr_matrix.attr,
 	&dev_attr_guest_matrix.attr,
-- 
2.41.0


