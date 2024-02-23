Return-Path: <linux-kernel+bounces-78643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 569B0861663
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A2361C23F1A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280B183A01;
	Fri, 23 Feb 2024 15:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="STClP0P/"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6662082C7E;
	Fri, 23 Feb 2024 15:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708703568; cv=none; b=i0eNpYHGQAOUHPOEWYOo6Cssro60b6UJhf2NbntWT189I21leS07NM6zmeGMUGCfSGESEQGizkK97KQ42njSnVkuF76MZV5ecOxZ2bhEZqOfjpNOsEwsOc5c5asNJXcQuO8e1QcxkJWsBQsZsTwkzfRmKbP+ogKkFMVrmmR3QsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708703568; c=relaxed/simple;
	bh=Zg4/yM2+D353pwCwBx2z4ODyHZFdnG8vURiaClyz2oU=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=TkQWhsbgtni1u501UnzzcXQHYHWWpLneoOQRDp1qKpSuq+hQ2j6CnQFh5om7AtZ+hHcKhUiZeAw9uwFVX5oWXyPZLQliUy2eUDurlodURb4qVorLwCgp4b3k7+pf8Y/f07j80mJ+kAapTGUYnjMszUechIJp12j4/qUgEIVQ0SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=STClP0P/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41NFh5Ii020600;
	Fri, 23 Feb 2024 15:52:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=3eih1dJ8XSmxwxaJDoZeQD1NSLR/sl7/BTSNGdIN0D8=;
 b=STClP0P//JEmZKYSkLdRBrXXxCWkQClR/PJkjct07ubvEcgOCeegF9VNZpYFmhYwhbyA
 8cJhaQOSdB+7tJcgG5EHAe0Opc6+gCCOpGy9Cr6m/ZJY1+fDiKvBkrYDKf9jGOTQ6CkH
 le+XIrixF2wpRwkL8c3WLvRyWfsFm5LQW51loeeCJK8zyVmsIXpVKLLO2L3iFVlIZ/vB
 sICeUCIL+yGlvsL4xvRM3bCR0lEOhLmstnUT8+Jb7qyTG/+QWJ+npF1s+lOA/7MoFxbD
 AB+5fNEAPNaNaZ1tSzbaP8jLhU5tDXaR1nNTNPN6mOMjmEu1yqKqYV4pQHMQv9tboKIc +g== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wex8ag7ac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 15:52:44 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41NDd8EM013470;
	Fri, 23 Feb 2024 15:52:28 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wb7h0xj0b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 15:52:28 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41NFqMJU18547394
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 15:52:24 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7BEE82004B;
	Fri, 23 Feb 2024 15:52:22 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 395FB20040;
	Fri, 23 Feb 2024 15:52:22 +0000 (GMT)
Received: from osiris (unknown [9.171.74.183])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 23 Feb 2024 15:52:22 +0000 (GMT)
Date: Fri, 23 Feb 2024 16:52:20 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] s390 fixes for 6.8-rc6
Message-ID: <20240223155220.36568-A-hca@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _P4s09vrJLSwmA1u57sU35ARNrNHc6we
X-Proofpoint-GUID: _P4s09vrJLSwmA1u57sU35ARNrNHc6we
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_02,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 clxscore=1015 impostorscore=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 mlxscore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402230114

Hi Linus,

please pull s390 fixes for 6.8-rc3.

Thanks,
Heiko

The following changes since commit 54be6c6c5ae8e0d93a6c4641cb7528eb0b6ba478:

  Linux 6.8-rc3 (2024-02-04 12:20:36 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.8-3

for you to fetch changes up to 5ef1dc40ffa6a6cb968b0fdc43c3a61727a9e950:

  s390/cio: fix invalid -EBUSY on ccw_device_start (2024-02-22 15:53:15 +0100)

----------------------------------------------------------------
s390 fixes for 6.8-rc6

- Fix invalid -EBUSY on ccw_device_start() which can lead to failing
  device initialization

- Add missing multiplication by 8 in __iowrite64_copy() to get the
  correct byte length before calling zpci_memcpy_toio()

- Various config updates

----------------------------------------------------------------
Heiko Carstens (3):
      s390/configs: provide compat topic configuration target
      s390/configs: enable INIT_STACK_ALL_ZERO in all configurations
      s390/configs: update default configurations

Jason Gunthorpe (1):
      s390: use the correct count for __iowrite64_copy()

Peter Oberparleiter (1):
      s390/cio: fix invalid -EBUSY on ccw_device_start

 arch/s390/configs/compat.config      | 3 +++
 arch/s390/configs/debug_defconfig    | 8 +-------
 arch/s390/configs/defconfig          | 9 +--------
 arch/s390/configs/zfcpdump_defconfig | 2 +-
 arch/s390/pci/pci.c                  | 2 +-
 drivers/s390/cio/device_ops.c        | 6 +++---
 6 files changed, 10 insertions(+), 20 deletions(-)
 create mode 100644 arch/s390/configs/compat.config

diff --git a/arch/s390/configs/compat.config b/arch/s390/configs/compat.config
new file mode 100644
index 000000000000..6fd051453ae8
--- /dev/null
+++ b/arch/s390/configs/compat.config
@@ -0,0 +1,3 @@
+# Help: Enable compat support
+CONFIG_COMPAT=y
+CONFIG_COMPAT_32BIT_TIME=y
diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debug_defconfig
index cae2dd34fbb4..c924be0d7ed8 100644
--- a/arch/s390/configs/debug_defconfig
+++ b/arch/s390/configs/debug_defconfig
@@ -118,7 +118,6 @@ CONFIG_UNIX=y
 CONFIG_UNIX_DIAG=m
 CONFIG_XFRM_USER=m
 CONFIG_NET_KEY=m
-CONFIG_SMC=m
 CONFIG_SMC_DIAG=m
 CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
@@ -374,6 +373,7 @@ CONFIG_NET_ACT_POLICE=m
 CONFIG_NET_ACT_GACT=m
 CONFIG_GACT_PROB=y
 CONFIG_NET_ACT_MIRRED=m
+CONFIG_NET_ACT_IPT=m
 CONFIG_NET_ACT_NAT=m
 CONFIG_NET_ACT_PEDIT=m
 CONFIG_NET_ACT_SIMP=m
@@ -436,9 +436,6 @@ CONFIG_SCSI_DH_ALUA=m
 CONFIG_MD=y
 CONFIG_BLK_DEV_MD=y
 # CONFIG_MD_BITMAP_FILE is not set
-CONFIG_MD_LINEAR=m
-CONFIG_MD_MULTIPATH=m
-CONFIG_MD_FAULTY=m
 CONFIG_MD_CLUSTER=m
 CONFIG_BCACHE=m
 CONFIG_BLK_DEV_DM=y
@@ -637,7 +634,6 @@ CONFIG_FUSE_FS=y
 CONFIG_CUSE=m
 CONFIG_VIRTIO_FS=m
 CONFIG_OVERLAY_FS=m
-CONFIG_NETFS_SUPPORT=m
 CONFIG_NETFS_STATS=y
 CONFIG_FSCACHE=y
 CONFIG_CACHEFILES=m
@@ -709,7 +705,6 @@ CONFIG_IMA_DEFAULT_HASH_SHA256=y
 CONFIG_IMA_WRITE_POLICY=y
 CONFIG_IMA_APPRAISE=y
 CONFIG_LSM="yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor"
-CONFIG_INIT_STACK_NONE=y
 CONFIG_BUG_ON_DATA_CORRUPTION=y
 CONFIG_CRYPTO_USER=m
 # CONFIG_CRYPTO_MANAGER_DISABLE_TESTS is not set
@@ -739,7 +734,6 @@ CONFIG_CRYPTO_TEA=m
 CONFIG_CRYPTO_TWOFISH=m
 CONFIG_CRYPTO_ADIANTUM=m
 CONFIG_CRYPTO_ARC4=m
-CONFIG_CRYPTO_CFB=m
 CONFIG_CRYPTO_HCTR2=m
 CONFIG_CRYPTO_KEYWRAP=m
 CONFIG_CRYPTO_LRW=m
diff --git a/arch/s390/configs/defconfig b/arch/s390/configs/defconfig
index 42b988873e54..c8f0c9fe40d7 100644
--- a/arch/s390/configs/defconfig
+++ b/arch/s390/configs/defconfig
@@ -109,7 +109,6 @@ CONFIG_UNIX=y
 CONFIG_UNIX_DIAG=m
 CONFIG_XFRM_USER=m
 CONFIG_NET_KEY=m
-CONFIG_SMC=m
 CONFIG_SMC_DIAG=m
 CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
@@ -364,6 +363,7 @@ CONFIG_NET_ACT_POLICE=m
 CONFIG_NET_ACT_GACT=m
 CONFIG_GACT_PROB=y
 CONFIG_NET_ACT_MIRRED=m
+CONFIG_NET_ACT_IPT=m
 CONFIG_NET_ACT_NAT=m
 CONFIG_NET_ACT_PEDIT=m
 CONFIG_NET_ACT_SIMP=m
@@ -426,9 +426,6 @@ CONFIG_SCSI_DH_ALUA=m
 CONFIG_MD=y
 CONFIG_BLK_DEV_MD=y
 # CONFIG_MD_BITMAP_FILE is not set
-CONFIG_MD_LINEAR=m
-CONFIG_MD_MULTIPATH=m
-CONFIG_MD_FAULTY=m
 CONFIG_MD_CLUSTER=m
 CONFIG_BCACHE=m
 CONFIG_BLK_DEV_DM=y
@@ -622,7 +619,6 @@ CONFIG_FUSE_FS=y
 CONFIG_CUSE=m
 CONFIG_VIRTIO_FS=m
 CONFIG_OVERLAY_FS=m
-CONFIG_NETFS_SUPPORT=m
 CONFIG_NETFS_STATS=y
 CONFIG_FSCACHE=y
 CONFIG_CACHEFILES=m
@@ -693,7 +689,6 @@ CONFIG_IMA_DEFAULT_HASH_SHA256=y
 CONFIG_IMA_WRITE_POLICY=y
 CONFIG_IMA_APPRAISE=y
 CONFIG_LSM="yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor"
-CONFIG_INIT_STACK_NONE=y
 CONFIG_BUG_ON_DATA_CORRUPTION=y
 CONFIG_CRYPTO_FIPS=y
 CONFIG_CRYPTO_USER=m
@@ -724,11 +719,9 @@ CONFIG_CRYPTO_TEA=m
 CONFIG_CRYPTO_TWOFISH=m
 CONFIG_CRYPTO_ADIANTUM=m
 CONFIG_CRYPTO_ARC4=m
-CONFIG_CRYPTO_CFB=m
 CONFIG_CRYPTO_HCTR2=m
 CONFIG_CRYPTO_KEYWRAP=m
 CONFIG_CRYPTO_LRW=m
-CONFIG_CRYPTO_OFB=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_AEGIS128=m
 CONFIG_CRYPTO_CHACHA20POLY1305=m
diff --git a/arch/s390/configs/zfcpdump_defconfig b/arch/s390/configs/zfcpdump_defconfig
index 30d2a1687665..c51f3ec4eb28 100644
--- a/arch/s390/configs/zfcpdump_defconfig
+++ b/arch/s390/configs/zfcpdump_defconfig
@@ -8,6 +8,7 @@ CONFIG_BPF_SYSCALL=y
 # CONFIG_NET_NS is not set
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+CONFIG_KEXEC=y
 CONFIG_CRASH_DUMP=y
 CONFIG_MARCH_Z13=y
 CONFIG_NR_CPUS=2
@@ -64,7 +65,6 @@ CONFIG_ZFCP=y
 # CONFIG_MISC_FILESYSTEMS is not set
 # CONFIG_NETWORK_FILESYSTEMS is not set
 CONFIG_LSM="yama,loadpin,safesetid,integrity"
-CONFIG_INIT_STACK_NONE=y
 # CONFIG_ZLIB_DFLTCC is not set
 CONFIG_XZ_DEC_MICROLZMA=y
 CONFIG_PRINTK_TIME=y
diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index 676ac74026a8..52a44e353796 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -252,7 +252,7 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 /* combine single writes by using store-block insn */
 void __iowrite64_copy(void __iomem *to, const void *from, size_t count)
 {
-       zpci_memcpy_toio(to, from, count);
+	zpci_memcpy_toio(to, from, count * 8);
 }
 
 void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
diff --git a/drivers/s390/cio/device_ops.c b/drivers/s390/cio/device_ops.c
index c533d1dadc6b..a5dba3829769 100644
--- a/drivers/s390/cio/device_ops.c
+++ b/drivers/s390/cio/device_ops.c
@@ -202,7 +202,8 @@ int ccw_device_start_timeout_key(struct ccw_device *cdev, struct ccw1 *cpa,
 		return -EINVAL;
 	if (cdev->private->state == DEV_STATE_NOT_OPER)
 		return -ENODEV;
-	if (cdev->private->state == DEV_STATE_VERIFY) {
+	if (cdev->private->state == DEV_STATE_VERIFY ||
+	    cdev->private->flags.doverify) {
 		/* Remember to fake irb when finished. */
 		if (!cdev->private->flags.fake_irb) {
 			cdev->private->flags.fake_irb = FAKE_CMD_IRB;
@@ -214,8 +215,7 @@ int ccw_device_start_timeout_key(struct ccw_device *cdev, struct ccw1 *cpa,
 	}
 	if (cdev->private->state != DEV_STATE_ONLINE ||
 	    ((sch->schib.scsw.cmd.stctl & SCSW_STCTL_PRIM_STATUS) &&
-	     !(sch->schib.scsw.cmd.stctl & SCSW_STCTL_SEC_STATUS)) ||
-	    cdev->private->flags.doverify)
+	     !(sch->schib.scsw.cmd.stctl & SCSW_STCTL_SEC_STATUS)))
 		return -EBUSY;
 	ret = cio_set_options (sch, flags);
 	if (ret)

