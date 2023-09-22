Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B53557AB1EE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 14:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234041AbjIVMPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 08:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233916AbjIVMPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 08:15:18 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1BEF99;
        Fri, 22 Sep 2023 05:15:10 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38MA7aMI005683;
        Fri, 22 Sep 2023 12:15:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-03-30; bh=blzyxcdh+2fQoo1NSytfc6fXxI2KT4Xa/hWS2PSa4UY=;
 b=lTE2ErHSRYMApI7M//5FnqWDeq+mrtgTf0Wv//aCHerH9jiiOuMf4gzS02J7X2KEp+Os
 oxGxkx6m+pIV6VOl/6eXNBTP30T1OcWZJUUSKaKjN2PU5TYEaH3qs5sdr2pvJ2f8hP+M
 vsUjXDklQ4rl/8Kmf1ss7+HNLZpYbA+serq9wBwavEsarG98QXmgaLu4/jSyHlKpxmew
 JVzz9eABbX+jWKn7aowJdndFsav7Lii7+CF/dHjL8WTverzyyw3UoNTMnxd9YjS99PT0
 Ysnie+0aPWA05ftnQ4IXV+SC1O/HmuJaDOyk4oXilj5HSSCS/a1rcRTZMdra8NlWDp+F KA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t8tsvsp9t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Sep 2023 12:15:03 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38MBRIHK035085;
        Fri, 22 Sep 2023 12:15:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t8ty2fmab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Sep 2023 12:15:02 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38MCCP7t015761;
        Fri, 22 Sep 2023 12:15:02 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3t8ty2fm9n-1;
        Fri, 22 Sep 2023 12:15:02 +0000
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To:     stable@vger.kernel.org
Cc:     joe@perches.com, gregkh@linuxfoundation.org, blamoreaux@vmware.com,
        linux-kernel@vger.kernel.org, vegard.nossum@oracle.com,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 4.14.y] drivers core: Use sysfs_emit and sysfs_emit_at for show(device *...) functions
Date:   Fri, 22 Sep 2023 05:14:54 -0700
Message-ID: <20230922121454.2735355-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-22_10,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309220104
X-Proofpoint-GUID: z2ypZ1ABch_FVB1kW-1Sd1pHN_xztKp_
X-Proofpoint-ORIG-GUID: z2ypZ1ABch_FVB1kW-1Sd1pHN_xztKp_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joe Perches <joe@perches.com>

commit aa838896d87af561a33ecefea1caa4c15a68bc47 upstream.

Convert the various sprintf fmaily calls in sysfs device show functions
to sysfs_emit and sysfs_emit_at for PAGE_SIZE buffer safety.

Done with:

$ spatch -sp-file sysfs_emit_dev.cocci --in-place --max-width=80 .

And cocci script:

$ cat sysfs_emit_dev.cocci
@@
identifier d_show;
identifier dev, attr, buf;
@@

ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	<...
	return
-	sprintf(buf,
+	sysfs_emit(buf,
	...);
	...>
}

@@
identifier d_show;
identifier dev, attr, buf;
@@

ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	<...
	return
-	snprintf(buf, PAGE_SIZE,
+	sysfs_emit(buf,
	...);
	...>
}

@@
identifier d_show;
identifier dev, attr, buf;
@@

ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	<...
	return
-	scnprintf(buf, PAGE_SIZE,
+	sysfs_emit(buf,
	...);
	...>
}

@@
identifier d_show;
identifier dev, attr, buf;
expression chr;
@@

ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	<...
	return
-	strcpy(buf, chr);
+	sysfs_emit(buf, chr);
	...>
}

@@
identifier d_show;
identifier dev, attr, buf;
identifier len;
@@

ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	<...
	len =
-	sprintf(buf,
+	sysfs_emit(buf,
	...);
	...>
	return len;
}

@@
identifier d_show;
identifier dev, attr, buf;
identifier len;
@@

ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	<...
	len =
-	snprintf(buf, PAGE_SIZE,
+	sysfs_emit(buf,
	...);
	...>
	return len;
}

@@
identifier d_show;
identifier dev, attr, buf;
identifier len;
@@

ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	<...
	len =
-	scnprintf(buf, PAGE_SIZE,
+	sysfs_emit(buf,
	...);
	...>
	return len;
}

@@
identifier d_show;
identifier dev, attr, buf;
identifier len;
@@

ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	<...
-	len += scnprintf(buf + len, PAGE_SIZE - len,
+	len += sysfs_emit_at(buf, len,
	...);
	...>
	return len;
}

@@
identifier d_show;
identifier dev, attr, buf;
expression chr;
@@

ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	...
-	strcpy(buf, chr);
-	return strlen(buf);
+	return sysfs_emit(buf, chr);
}

Signed-off-by: Joe Perches <joe@perches.com>
Link: https://lore.kernel.org/r/3d033c33056d88bbe34d4ddb62afd05ee166ab9a.1600285923.git.joe@perches.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[Harshit: backport to 4.14.y -- regenerated the diff with the help of
coccinelle script in driver/base/ directory.]
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
Only compile tested. This fixes CVE-2022-20166.
It is not clear whether the CVE was assigned for a demonstrated issue
or just a theoretical one. In any case it's a good defensive measure
against future patches that may introduce a real issue if they assume
this patch is already there.
---
 drivers/base/arch_topology.c  |  3 +-
 drivers/base/cacheinfo.c      | 18 ++++++------
 drivers/base/core.c           |  8 ++---
 drivers/base/cpu.c            | 26 ++++++++---------
 drivers/base/firmware_class.c |  2 +-
 drivers/base/memory.c         | 24 +++++++--------
 drivers/base/node.c           | 26 ++++++++---------
 drivers/base/platform.c       |  2 +-
 drivers/base/power/sysfs.c    | 55 ++++++++++++++++++-----------------
 drivers/base/soc.c            |  8 ++---
 10 files changed, 87 insertions(+), 85 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 3da53cc6cf2b..4b965f562d0b 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -41,7 +41,8 @@ static ssize_t cpu_capacity_show(struct device *dev,
 {
 	struct cpu *cpu = container_of(dev, struct cpu, dev);
 
-	return sprintf(buf, "%lu\n", topology_get_cpu_scale(NULL, cpu->dev.id));
+	return sysfs_emit(buf, "%lu\n",
+			  topology_get_cpu_scale(NULL, cpu->dev.id));
 }
 
 static ssize_t cpu_capacity_store(struct device *dev,
diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index e405ea3ca8d8..1d4969b0478f 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -388,7 +388,7 @@ static ssize_t size_show(struct device *dev,
 {
 	struct cacheinfo *this_leaf = dev_get_drvdata(dev);
 
-	return sprintf(buf, "%uK\n", this_leaf->size >> 10);
+	return sysfs_emit(buf, "%uK\n", this_leaf->size >> 10);
 }
 
 static ssize_t shared_cpumap_show_func(struct device *dev, bool list, char *buf)
@@ -418,11 +418,11 @@ static ssize_t type_show(struct device *dev,
 
 	switch (this_leaf->type) {
 	case CACHE_TYPE_DATA:
-		return sprintf(buf, "Data\n");
+		return sysfs_emit(buf, "Data\n");
 	case CACHE_TYPE_INST:
-		return sprintf(buf, "Instruction\n");
+		return sysfs_emit(buf, "Instruction\n");
 	case CACHE_TYPE_UNIFIED:
-		return sprintf(buf, "Unified\n");
+		return sysfs_emit(buf, "Unified\n");
 	default:
 		return -EINVAL;
 	}
@@ -436,11 +436,11 @@ static ssize_t allocation_policy_show(struct device *dev,
 	int n = 0;
 
 	if ((ci_attr & CACHE_READ_ALLOCATE) && (ci_attr & CACHE_WRITE_ALLOCATE))
-		n = sprintf(buf, "ReadWriteAllocate\n");
+		n = sysfs_emit(buf, "ReadWriteAllocate\n");
 	else if (ci_attr & CACHE_READ_ALLOCATE)
-		n = sprintf(buf, "ReadAllocate\n");
+		n = sysfs_emit(buf, "ReadAllocate\n");
 	else if (ci_attr & CACHE_WRITE_ALLOCATE)
-		n = sprintf(buf, "WriteAllocate\n");
+		n = sysfs_emit(buf, "WriteAllocate\n");
 	return n;
 }
 
@@ -452,9 +452,9 @@ static ssize_t write_policy_show(struct device *dev,
 	int n = 0;
 
 	if (ci_attr & CACHE_WRITE_THROUGH)
-		n = sprintf(buf, "WriteThrough\n");
+		n = sysfs_emit(buf, "WriteThrough\n");
 	else if (ci_attr & CACHE_WRITE_BACK)
-		n = sprintf(buf, "WriteBack\n");
+		n = sysfs_emit(buf, "WriteBack\n");
 	return n;
 }
 
diff --git a/drivers/base/core.c b/drivers/base/core.c
index e834087448a4..4f30ab4c3d95 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -766,7 +766,7 @@ ssize_t device_show_ulong(struct device *dev,
 			  char *buf)
 {
 	struct dev_ext_attribute *ea = to_ext_attr(attr);
-	return snprintf(buf, PAGE_SIZE, "%lx\n", *(unsigned long *)(ea->var));
+	return sysfs_emit(buf, "%lx\n", *(unsigned long *)(ea->var));
 }
 EXPORT_SYMBOL_GPL(device_show_ulong);
 
@@ -791,7 +791,7 @@ ssize_t device_show_int(struct device *dev,
 {
 	struct dev_ext_attribute *ea = to_ext_attr(attr);
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", *(int *)(ea->var));
+	return sysfs_emit(buf, "%d\n", *(int *)(ea->var));
 }
 EXPORT_SYMBOL_GPL(device_show_int);
 
@@ -812,7 +812,7 @@ ssize_t device_show_bool(struct device *dev, struct device_attribute *attr,
 {
 	struct dev_ext_attribute *ea = to_ext_attr(attr);
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", *(bool *)(ea->var));
+	return sysfs_emit(buf, "%d\n", *(bool *)(ea->var));
 }
 EXPORT_SYMBOL_GPL(device_show_bool);
 
@@ -1036,7 +1036,7 @@ static ssize_t online_show(struct device *dev, struct device_attribute *attr,
 	device_lock(dev);
 	val = !dev->offline;
 	device_unlock(dev);
-	return sprintf(buf, "%u\n", val);
+	return sysfs_emit(buf, "%u\n", val);
 }
 
 static ssize_t online_store(struct device *dev, struct device_attribute *attr,
diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index c9463c30b812..f602b2215026 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -154,7 +154,7 @@ static ssize_t show_crash_notes(struct device *dev, struct device_attribute *att
 	 * operation should be safe. No locking required.
 	 */
 	addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpunum));
-	rc = sprintf(buf, "%Lx\n", addr);
+	rc = sysfs_emit(buf, "%Lx\n", addr);
 	return rc;
 }
 static DEVICE_ATTR(crash_notes, 0400, show_crash_notes, NULL);
@@ -165,7 +165,7 @@ static ssize_t show_crash_notes_size(struct device *dev,
 {
 	ssize_t rc;
 
-	rc = sprintf(buf, "%zu\n", sizeof(note_buf_t));
+	rc = sysfs_emit(buf, "%zu\n", sizeof(note_buf_t));
 	return rc;
 }
 static DEVICE_ATTR(crash_notes_size, 0400, show_crash_notes_size, NULL);
@@ -318,8 +318,8 @@ static ssize_t print_cpu_modalias(struct device *dev,
 	ssize_t n;
 	u32 i;
 
-	n = sprintf(buf, "cpu:type:" CPU_FEATURE_TYPEFMT ":feature:",
-		    CPU_FEATURE_TYPEVAL);
+	n = sysfs_emit(buf, "cpu:type:" CPU_FEATURE_TYPEFMT ":feature:",
+		       CPU_FEATURE_TYPEVAL);
 
 	for (i = 0; i < MAX_CPU_FEATURES; i++)
 		if (cpu_have_feature(i)) {
@@ -506,56 +506,56 @@ static void __init cpu_dev_register_generic(void)
 ssize_t __weak cpu_show_meltdown(struct device *dev,
 				 struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "Not affected\n");
+	return sysfs_emit(buf, "Not affected\n");
 }
 
 ssize_t __weak cpu_show_spectre_v1(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "Not affected\n");
+	return sysfs_emit(buf, "Not affected\n");
 }
 
 ssize_t __weak cpu_show_spectre_v2(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "Not affected\n");
+	return sysfs_emit(buf, "Not affected\n");
 }
 
 ssize_t __weak cpu_show_spec_store_bypass(struct device *dev,
 					  struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "Not affected\n");
+	return sysfs_emit(buf, "Not affected\n");
 }
 
 ssize_t __weak cpu_show_l1tf(struct device *dev,
 			     struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "Not affected\n");
+	return sysfs_emit(buf, "Not affected\n");
 }
 
 ssize_t __weak cpu_show_mds(struct device *dev,
 			    struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "Not affected\n");
+	return sysfs_emit(buf, "Not affected\n");
 }
 
 ssize_t __weak cpu_show_tsx_async_abort(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
 {
-	return sprintf(buf, "Not affected\n");
+	return sysfs_emit(buf, "Not affected\n");
 }
 
 ssize_t __weak cpu_show_itlb_multihit(struct device *dev,
 			    struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "Not affected\n");
+	return sysfs_emit(buf, "Not affected\n");
 }
 
 ssize_t __weak cpu_show_srbds(struct device *dev,
 			      struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "Not affected\n");
+	return sysfs_emit(buf, "Not affected\n");
 }
 
 ssize_t __weak cpu_show_mmio_stale_data(struct device *dev,
diff --git a/drivers/base/firmware_class.c b/drivers/base/firmware_class.c
index 4b57cf5bc81d..7cb90e4ac4a6 100644
--- a/drivers/base/firmware_class.c
+++ b/drivers/base/firmware_class.c
@@ -698,7 +698,7 @@ static ssize_t firmware_loading_show(struct device *dev,
 		loading = fw_state_is_loading(&fw_priv->buf->fw_st);
 	mutex_unlock(&fw_lock);
 
-	return sprintf(buf, "%d\n", loading);
+	return sysfs_emit(buf, "%d\n", loading);
 }
 
 /* Some architectures don't have PAGE_KERNEL_RO */
diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index fe1557aa9b10..39359fb9146b 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -116,7 +116,7 @@ static ssize_t show_mem_start_phys_index(struct device *dev,
 	unsigned long phys_index;
 
 	phys_index = mem->start_section_nr / sections_per_block;
-	return sprintf(buf, "%08lx\n", phys_index);
+	return sysfs_emit(buf, "%08lx\n", phys_index);
 }
 
 /*
@@ -140,7 +140,7 @@ static ssize_t show_mem_removable(struct device *dev,
 	}
 
 out:
-	return sprintf(buf, "%d\n", ret);
+	return sysfs_emit(buf, "%d\n", ret);
 }
 
 /*
@@ -158,17 +158,17 @@ static ssize_t show_mem_state(struct device *dev,
 	 */
 	switch (mem->state) {
 	case MEM_ONLINE:
-		len = sprintf(buf, "online\n");
+		len = sysfs_emit(buf, "online\n");
 		break;
 	case MEM_OFFLINE:
-		len = sprintf(buf, "offline\n");
+		len = sysfs_emit(buf, "offline\n");
 		break;
 	case MEM_GOING_OFFLINE:
-		len = sprintf(buf, "going-offline\n");
+		len = sysfs_emit(buf, "going-offline\n");
 		break;
 	default:
-		len = sprintf(buf, "ERROR-UNKNOWN-%ld\n",
-				mem->state);
+		len = sysfs_emit(buf, "ERROR-UNKNOWN-%ld\n",
+				 mem->state);
 		WARN_ON(1);
 		break;
 	}
@@ -385,7 +385,7 @@ static ssize_t show_phys_device(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	struct memory_block *mem = to_memory_block(dev);
-	return sprintf(buf, "%d\n", mem->phys_device);
+	return sysfs_emit(buf, "%d\n", mem->phys_device);
 }
 
 #ifdef CONFIG_MEMORY_HOTREMOVE
@@ -417,7 +417,7 @@ static ssize_t show_valid_zones(struct device *dev,
 	 * This can happen e.g. for ZONE_DMA and ZONE_DMA32
 	 */
 	if (!test_pages_in_a_zone(start_pfn, start_pfn + nr_pages, &valid_start_pfn, &valid_end_pfn))
-		return sprintf(buf, "none\n");
+		return sysfs_emit(buf, "none\n");
 
 	start_pfn = valid_start_pfn;
 	nr_pages = valid_end_pfn - start_pfn;
@@ -459,7 +459,7 @@ static ssize_t
 print_block_size(struct device *dev, struct device_attribute *attr,
 		 char *buf)
 {
-	return sprintf(buf, "%lx\n", get_memory_block_size());
+	return sysfs_emit(buf, "%lx\n", get_memory_block_size());
 }
 
 static DEVICE_ATTR(block_size_bytes, 0444, print_block_size, NULL);
@@ -473,9 +473,9 @@ show_auto_online_blocks(struct device *dev, struct device_attribute *attr,
 			char *buf)
 {
 	if (memhp_auto_online)
-		return sprintf(buf, "online\n");
+		return sysfs_emit(buf, "online\n");
 	else
-		return sprintf(buf, "offline\n");
+		return sysfs_emit(buf, "offline\n");
 }
 
 static ssize_t
diff --git a/drivers/base/node.c b/drivers/base/node.c
index 57eef6b24448..a547867c2094 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -162,19 +162,19 @@ static DEVICE_ATTR(meminfo, S_IRUGO, node_read_meminfo, NULL);
 static ssize_t node_read_numastat(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf,
-		       "numa_hit %lu\n"
-		       "numa_miss %lu\n"
-		       "numa_foreign %lu\n"
-		       "interleave_hit %lu\n"
-		       "local_node %lu\n"
-		       "other_node %lu\n",
-		       sum_zone_numa_state(dev->id, NUMA_HIT),
-		       sum_zone_numa_state(dev->id, NUMA_MISS),
-		       sum_zone_numa_state(dev->id, NUMA_FOREIGN),
-		       sum_zone_numa_state(dev->id, NUMA_INTERLEAVE_HIT),
-		       sum_zone_numa_state(dev->id, NUMA_LOCAL),
-		       sum_zone_numa_state(dev->id, NUMA_OTHER));
+	return sysfs_emit(buf,
+			  "numa_hit %lu\n"
+			  "numa_miss %lu\n"
+			  "numa_foreign %lu\n"
+			  "interleave_hit %lu\n"
+			  "local_node %lu\n"
+			  "other_node %lu\n",
+			  sum_zone_numa_state(dev->id, NUMA_HIT),
+			  sum_zone_numa_state(dev->id, NUMA_MISS),
+			  sum_zone_numa_state(dev->id, NUMA_FOREIGN),
+			  sum_zone_numa_state(dev->id, NUMA_INTERLEAVE_HIT),
+			  sum_zone_numa_state(dev->id, NUMA_LOCAL),
+			  sum_zone_numa_state(dev->id, NUMA_OTHER));
 }
 static DEVICE_ATTR(numastat, S_IRUGO, node_read_numastat, NULL);
 
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 0ee3cab88f70..d0847c17d725 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -909,7 +909,7 @@ static ssize_t driver_override_show(struct device *dev,
 	ssize_t len;
 
 	device_lock(dev);
-	len = sprintf(buf, "%s\n", pdev->driver_override);
+	len = sysfs_emit(buf, "%s\n", pdev->driver_override);
 	device_unlock(dev);
 	return len;
 }
diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
index 156ab57bca77..b660446321c3 100644
--- a/drivers/base/power/sysfs.c
+++ b/drivers/base/power/sysfs.c
@@ -101,7 +101,7 @@ static const char ctrl_on[] = "on";
 static ssize_t control_show(struct device *dev, struct device_attribute *attr,
 			    char *buf)
 {
-	return sprintf(buf, "%s\n",
+	return sysfs_emit(buf, "%s\n",
 				dev->power.runtime_auto ? ctrl_auto : ctrl_on);
 }
 
@@ -133,7 +133,8 @@ static ssize_t rtpm_active_time_show(struct device *dev,
 	int ret;
 	spin_lock_irq(&dev->power.lock);
 	update_pm_runtime_accounting(dev);
-	ret = sprintf(buf, "%i\n", jiffies_to_msecs(dev->power.active_jiffies));
+	ret = sysfs_emit(buf, "%i\n",
+			 jiffies_to_msecs(dev->power.active_jiffies));
 	spin_unlock_irq(&dev->power.lock);
 	return ret;
 }
@@ -146,8 +147,8 @@ static ssize_t rtpm_suspended_time_show(struct device *dev,
 	int ret;
 	spin_lock_irq(&dev->power.lock);
 	update_pm_runtime_accounting(dev);
-	ret = sprintf(buf, "%i\n",
-		jiffies_to_msecs(dev->power.suspended_jiffies));
+	ret = sysfs_emit(buf, "%i\n",
+			 jiffies_to_msecs(dev->power.suspended_jiffies));
 	spin_unlock_irq(&dev->power.lock);
 	return ret;
 }
@@ -181,7 +182,7 @@ static ssize_t rtpm_status_show(struct device *dev,
 			return -EIO;
 		}
 	}
-	return sprintf(buf, p);
+	return sysfs_emit(buf, p);
 }
 
 static DEVICE_ATTR(runtime_status, 0444, rtpm_status_show, NULL);
@@ -191,7 +192,7 @@ static ssize_t autosuspend_delay_ms_show(struct device *dev,
 {
 	if (!dev->power.use_autosuspend)
 		return -EIO;
-	return sprintf(buf, "%d\n", dev->power.autosuspend_delay);
+	return sysfs_emit(buf, "%d\n", dev->power.autosuspend_delay);
 }
 
 static ssize_t autosuspend_delay_ms_store(struct device *dev,
@@ -218,7 +219,7 @@ static ssize_t pm_qos_resume_latency_show(struct device *dev,
 					  struct device_attribute *attr,
 					  char *buf)
 {
-	return sprintf(buf, "%d\n", dev_pm_qos_requested_resume_latency(dev));
+	return sysfs_emit(buf, "%d\n", dev_pm_qos_requested_resume_latency(dev));
 }
 
 static ssize_t pm_qos_resume_latency_store(struct device *dev,
@@ -249,11 +250,11 @@ static ssize_t pm_qos_latency_tolerance_show(struct device *dev,
 	s32 value = dev_pm_qos_get_user_latency_tolerance(dev);
 
 	if (value < 0)
-		return sprintf(buf, "auto\n");
+		return sysfs_emit(buf, "auto\n");
 	else if (value == PM_QOS_LATENCY_ANY)
-		return sprintf(buf, "any\n");
+		return sysfs_emit(buf, "any\n");
 
-	return sprintf(buf, "%d\n", value);
+	return sysfs_emit(buf, "%d\n", value);
 }
 
 static ssize_t pm_qos_latency_tolerance_store(struct device *dev,
@@ -286,8 +287,8 @@ static ssize_t pm_qos_no_power_off_show(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
 {
-	return sprintf(buf, "%d\n", !!(dev_pm_qos_requested_flags(dev)
-					& PM_QOS_FLAG_NO_POWER_OFF));
+	return sysfs_emit(buf, "%d\n", !!(dev_pm_qos_requested_flags(dev)
+					  & PM_QOS_FLAG_NO_POWER_OFF));
 }
 
 static ssize_t pm_qos_no_power_off_store(struct device *dev,
@@ -313,8 +314,8 @@ static ssize_t pm_qos_remote_wakeup_show(struct device *dev,
 					 struct device_attribute *attr,
 					 char *buf)
 {
-	return sprintf(buf, "%d\n", !!(dev_pm_qos_requested_flags(dev)
-					& PM_QOS_FLAG_REMOTE_WAKEUP));
+	return sysfs_emit(buf, "%d\n", !!(dev_pm_qos_requested_flags(dev)
+					  & PM_QOS_FLAG_REMOTE_WAKEUP));
 }
 
 static ssize_t pm_qos_remote_wakeup_store(struct device *dev,
@@ -343,9 +344,9 @@ static const char _disabled[] = "disabled";
 static ssize_t
 wake_show(struct device * dev, struct device_attribute *attr, char * buf)
 {
-	return sprintf(buf, "%s\n", device_can_wakeup(dev)
-		? (device_may_wakeup(dev) ? _enabled : _disabled)
-		: "");
+	return sysfs_emit(buf, "%s\n", device_can_wakeup(dev)
+			  ? (device_may_wakeup(dev) ? _enabled : _disabled)
+			  : "");
 }
 
 static ssize_t
@@ -538,26 +539,26 @@ static DEVICE_ATTR(wakeup_prevent_sleep_time_ms, 0444,
 static ssize_t rtpm_usagecount_show(struct device *dev,
 				    struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%d\n", atomic_read(&dev->power.usage_count));
+	return sysfs_emit(buf, "%d\n", atomic_read(&dev->power.usage_count));
 }
 
 static ssize_t rtpm_children_show(struct device *dev,
 				  struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%d\n", dev->power.ignore_children ?
-		0 : atomic_read(&dev->power.child_count));
+	return sysfs_emit(buf, "%d\n", dev->power.ignore_children ?
+			  0 : atomic_read(&dev->power.child_count));
 }
 
 static ssize_t rtpm_enabled_show(struct device *dev,
 				 struct device_attribute *attr, char *buf)
 {
 	if ((dev->power.disable_depth) && (dev->power.runtime_auto == false))
-		return sprintf(buf, "disabled & forbidden\n");
+		return sysfs_emit(buf, "disabled & forbidden\n");
 	else if (dev->power.disable_depth)
-		return sprintf(buf, "disabled\n");
+		return sysfs_emit(buf, "disabled\n");
 	else if (dev->power.runtime_auto == false)
-		return sprintf(buf, "forbidden\n");
-	return sprintf(buf, "enabled\n");
+		return sysfs_emit(buf, "forbidden\n");
+	return sysfs_emit(buf, "enabled\n");
 }
 
 static DEVICE_ATTR(runtime_usage, 0444, rtpm_usagecount_show, NULL);
@@ -568,9 +569,9 @@ static DEVICE_ATTR(runtime_enabled, 0444, rtpm_enabled_show, NULL);
 static ssize_t async_show(struct device *dev, struct device_attribute *attr,
 			  char *buf)
 {
-	return sprintf(buf, "%s\n",
-			device_async_suspend_enabled(dev) ?
-				_enabled : _disabled);
+	return sysfs_emit(buf, "%s\n",
+			  device_async_suspend_enabled(dev) ?
+			  _enabled : _disabled);
 }
 
 static ssize_t async_store(struct device *dev, struct device_attribute *attr,
diff --git a/drivers/base/soc.c b/drivers/base/soc.c
index 1242b2d2e01a..0e7ab127c5c4 100644
--- a/drivers/base/soc.c
+++ b/drivers/base/soc.c
@@ -72,13 +72,13 @@ static ssize_t soc_info_get(struct device *dev,
 	struct soc_device *soc_dev = container_of(dev, struct soc_device, dev);
 
 	if (attr == &dev_attr_machine)
-		return sprintf(buf, "%s\n", soc_dev->attr->machine);
+		return sysfs_emit(buf, "%s\n", soc_dev->attr->machine);
 	if (attr == &dev_attr_family)
-		return sprintf(buf, "%s\n", soc_dev->attr->family);
+		return sysfs_emit(buf, "%s\n", soc_dev->attr->family);
 	if (attr == &dev_attr_revision)
-		return sprintf(buf, "%s\n", soc_dev->attr->revision);
+		return sysfs_emit(buf, "%s\n", soc_dev->attr->revision);
 	if (attr == &dev_attr_soc_id)
-		return sprintf(buf, "%s\n", soc_dev->attr->soc_id);
+		return sysfs_emit(buf, "%s\n", soc_dev->attr->soc_id);
 
 	return -EINVAL;
 
-- 
2.38.1

