Return-Path: <linux-kernel+bounces-40242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ABFD83DD12
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41E182880C4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCFF11CD34;
	Fri, 26 Jan 2024 15:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dSDx1zsx"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EA41B7F2
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 15:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706281803; cv=none; b=IzUkgM0aC5LT0dbtzIpAjrth0s3kRXRKbvkj3QpUrPWMK99AkZPHZ99TnVHrdj/svyW7Zw/IphAmvhUd7AADn6n0m9bILfYD4wyGdmtbNZxYWrPof7PmcCq5TCKMhZ7dcNdCDWOoJWJzCyihzV/D9jdZc+fcB46yNRBfEru4u9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706281803; c=relaxed/simple;
	bh=eVJOccb+zS20vYhXESd5lUpidtZyc+x1M67JNbou9XA=;
	h=Subject:From:To:Cc:Date:Message-ID:Content-Type:MIME-Version; b=g+WDyoeC61VFnA0VneAfkTzixZ9cZzjQbBX2+uMQVBOWrHtqgtCVREg4tz80Bd/QNFbuFGpreq3FtYwzxnu30aVjKhQoqapabVBy73X06VH4WTjAmopdj7L9NcH5PC/AiUFbJr8mhfe3fhLe4eZ9an8fCO68tP5PxWxi0V7j3M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dSDx1zsx; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40QEWUt0016460;
	Fri, 26 Jan 2024 15:09:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : from : to : cc
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=EMfDROFbgJEi008tLRtRfT5S/vVzIQIrctpoV9Kn3Kk=;
 b=dSDx1zsxQ7vx+0ifKCtclKF1SH3AuEsQzf0vjxAhom2XNuLpwk/SVB0C4lwCV+USmygd
 twrkr745XknJkghyH0974ZZpMZ1A+EPU7l+DorkdVAU2z3Ahei88CYFyeBWzVnUIuuXB
 TLHc0kQPGvoJbd9W9BVbFgLRgtubddA2Pg6QINrPUpyq1KIhTWwlNOuQo45YKl4BYORR
 GV60paUIHtCOW2pb6cx5c6PAG3BrpWSm7dCxMjaXCF4/mK6pYBiKq1PfVg+T4HbVleQO
 dTHobHKLofwZKH1JKk9WkuIsK9NMe78OkK3Wg8lpBnX7HDhsguKh7DFjYrg6TnnoPu/O zg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vvek90wjm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 15:09:26 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40QF7XKX006293;
	Fri, 26 Jan 2024 15:09:26 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vvek90wja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 15:09:26 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40QD78IV028239;
	Fri, 26 Jan 2024 15:09:25 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vru732xwe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 15:09:25 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40QF9MJK27460100
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jan 2024 15:09:22 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 348192004B;
	Fri, 26 Jan 2024 15:09:22 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A624320049;
	Fri, 26 Jan 2024 15:09:19 +0000 (GMT)
Received: from ltcd48-lp2.aus.stglab.ibm.com (unknown [9.3.101.175])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 26 Jan 2024 15:09:19 +0000 (GMT)
Subject: [PATCH v2] powerpc: iommu: Bring back table group release_ownership()
 call
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
To: iommu@lists.linux.dev, linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, aneesh.kumar@kernel.org,
        naveen.n.rao@linux.ibm.com, jgg@ziepe.ca, jroedel@suse.de,
        tpearson@raptorengineering.com, aik@amd.com, bgray@linux.ibm.com,
        gregkh@linuxfoundation.org, sbhat@linux.ibm.com,
        gbatra@linux.vnet.ibm.com, vaibhav@linux.ibm.com
Date: Fri, 26 Jan 2024 09:09:18 -0600
Message-ID: 
 <170628173462.3742.18330000394415935845.stgit@ltcd48-lp2.aus.stglab.ibm.com>
User-Agent: StGit/1.5
Content-Type: text/plain; charset="utf-8"
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YFJalwNzOQy4a9hjiadrOA2gTSIYVP95
X-Proofpoint-ORIG-GUID: W4cEKw2h2TRDXchVH7azbDxp1mZ68xEa
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=999 mlxscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401260111

The commit 2ad56efa80db ("powerpc/iommu: Setup a default domain and
remove set_platform_dma_ops") refactored the code removing the
set_platform_dma_ops(). It missed out the table group
release_ownership() call which would have got called otherwise
during the guest shutdown via vfio_group_detach_container(). On
PPC64, this particular call actually sets up the 32-bit TCE table,
and enables the 64-bit DMA bypass etc. Now after guest shutdown,
the subsequent host driver (e.g megaraid-sas) probe post unbind
from vfio-pci fails like,

megaraid_sas 0031:01:00.0: Warning: IOMMU dma not supported: mask 0x7fffffffffffffff, table unavailable
megaraid_sas 0031:01:00.0: Warning: IOMMU dma not supported: mask 0xffffffff, table unavailable
megaraid_sas 0031:01:00.0: Failed to set DMA mask
megaraid_sas 0031:01:00.0: Failed from megasas_init_fw 6539

The patch brings back the call to table_group release_ownership()
call when switching back to PLATFORM domain from BLOCKED, while
also separates the domain_ops for both.

Fixes: 2ad56efa80db ("powerpc/iommu: Setup a default domain and remove set_platform_dma_ops")
Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
---
Changelog:
v1: https://lore.kernel.org/linux-iommu/170618451433.3805.9015493852395837391.stgit@ltcd48-lp2.aus.stglab.ibm.com/
 - Split the common attach_dev call to platform and blocked attach_dev
   calls as suggested.

 arch/powerpc/kernel/iommu.c |   37 ++++++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index ebe259bdd462..d71eac3b2887 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -1287,20 +1287,20 @@ spapr_tce_platform_iommu_attach_dev(struct iommu_domain *platform_domain,
 	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
 	struct iommu_group *grp = iommu_group_get(dev);
 	struct iommu_table_group *table_group;
-	int ret = -EINVAL;

 	/* At first attach the ownership is already set */
 	if (!domain)
 		return 0;

-	if (!grp)
-		return -ENODEV;
-
 	table_group = iommu_group_get_iommudata(grp);
-	ret = table_group->ops->take_ownership(table_group);
+	/*
+	 * The domain being set to PLATFORM from earlier
+	 * BLOCKED. The table_group ownership has to be released.
+	 */
+	table_group->ops->release_ownership(table_group);
 	iommu_group_put(grp);

-	return ret;
+	return 0;
 }

 static const struct iommu_domain_ops spapr_tce_platform_domain_ops = {
@@ -1312,13 +1312,32 @@ static struct iommu_domain spapr_tce_platform_domain = {
 	.ops = &spapr_tce_platform_domain_ops,
 };

-static struct iommu_domain spapr_tce_blocked_domain = {
-	.type = IOMMU_DOMAIN_BLOCKED,
+static int
+spapr_tce_blocked_iommu_attach_dev(struct iommu_domain *platform_domain,
+				     struct device *dev)
+{
+	struct iommu_group *grp = iommu_group_get(dev);
+	struct iommu_table_group *table_group;
+	int ret = -EINVAL;
+
 	/*
 	 * FIXME: SPAPR mixes blocked and platform behaviors, the blocked domain
 	 * also sets the dma_api ops
 	 */
-	.ops = &spapr_tce_platform_domain_ops,
+	table_group = iommu_group_get_iommudata(grp);
+	ret = table_group->ops->take_ownership(table_group);
+	iommu_group_put(grp);
+
+	return ret;
+}
+
+static const struct iommu_domain_ops spapr_tce_blocked_domain_ops = {
+	.attach_dev = spapr_tce_blocked_iommu_attach_dev,
+};
+
+static struct iommu_domain spapr_tce_blocked_domain = {
+	.type = IOMMU_DOMAIN_BLOCKED,
+	.ops = &spapr_tce_blocked_domain_ops,
 };

 static bool spapr_tce_iommu_capable(struct device *dev, enum iommu_cap cap)



