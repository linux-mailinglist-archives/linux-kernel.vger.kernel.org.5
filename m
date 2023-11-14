Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB577EB20D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 15:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbjKNOYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 09:24:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233311AbjKNOKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 09:10:43 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2269AAD;
        Tue, 14 Nov 2023 06:10:39 -0800 (PST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AEE5ANZ027348;
        Tue, 14 Nov 2023 14:10:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=aDw8Z+QQY/5SnbCPtGUQ11LbrC1Pxu4VuTPuWqU6a7U=;
 b=f1W1DeYc1ueL8PlzS9zDmk4wUWfqdlxetdnrcQcbf5WFjKx2JFJmq8OmU1lfXtWtDgu3
 CK3ZE2/IwMGTRKA0rBw4GK0LYq6MDgKwYO7363E4qzikxqn8exlr08P6CbQ3hu8MTS3N
 fw1MBX6gVpG8grMuHuT3CBLCvWH94xuhKyxRSBfHEzoadVh/+hy/1PstETDy52xbFxbT
 BWrS/KRweNGKcGj0b6Qbw9gvtEfBIWCOmLdBdQt/hZJEBjIEw9bgAryv4BQanM0VGSZo
 1sIoTxKT+oytox09861b9O8flGQzZNWsUgNKktU/7cIYSsdWjoAvfaIwiL8GBkQVy9NI Rw== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ucabgrb8g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Nov 2023 14:10:37 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AEBN6Eq014683;
        Tue, 14 Nov 2023 14:10:35 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uamay8emv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Nov 2023 14:10:35 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
        by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AEEAYXK50462980
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Nov 2023 14:10:34 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C93F05804E;
        Tue, 14 Nov 2023 14:10:34 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 168815803F;
        Tue, 14 Nov 2023 14:10:34 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 14 Nov 2023 14:10:33 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     zohar@linux.ibm.com, gregkh@linuxfoundation.org,
        initramfs@vger.kernel.org, Stefan Berger <stefanb@linux.ibm.com>,
        stable@vger.kernel.org, Rob Landley <rob@landley.net>
Subject: [PATCH v2] rootfs: Fix support for rootfstype= when root= is given
Date:   Tue, 14 Nov 2023 09:10:30 -0500
Message-ID: <20231114141030.219729-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KBORmMS8h6xjVPFvofXK5OwButrnbcdg
X-Proofpoint-ORIG-GUID: KBORmMS8h6xjVPFvofXK5OwButrnbcdg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-14_13,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 phishscore=0
 bulkscore=0 adultscore=0 spamscore=0 priorityscore=1501 mlxlogscore=999
 suspectscore=0 lowpriorityscore=0 mlxscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311140109
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation/filesystems/ramfs-rootfs-initramfs.rst states:

  If CONFIG_TMPFS is enabled, rootfs will use tmpfs instead of ramfs by
  default.  To force ramfs, add "rootfstype=ramfs" to the kernel command
  line.

This currently does not work when root= is provided since then
saved_root_name contains a string and initfstype= is ignored. Therefore,
ramfs is currently always chosen when root= is provided.

The current behavior for rootfs's filesystem is:

   root=       | initfstype= | chosen rootfs filesystem
   ------------+-------------+--------------------------
   unspecified | unspecified | tmpfs
   unspecified | tmpfs       | tmpfs
   unspecified | ramfs       | ramfs
    provided   | ignored     | ramfs

initfstype= should be respected regardless whether root= is given,
as shown below:

   root=       | initfstype= | chosen rootfs filesystem
   ------------+-------------+--------------------------
   unspecified | unspecified | tmpfs  (as before)
   unspecified | tmpfs       | tmpfs  (as before)
   unspecified | ramfs       | ramfs  (as before)
    provided   | unspecified | ramfs  (compatibility with before)
    provided   | tmpfs       | tmpfs  (new)
    provided   | ramfs       | ramfs  (new)

This table represents the new behavior.

Fixes: 6e19eded3684 ("initmpfs: use initramfs if rootfstype= or root=  specified")
Cc: <stable@vger.kernel.org>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Rob Landley <rob@landley.net>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 init/do_mounts.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/init/do_mounts.c b/init/do_mounts.c
index 5fdef94f0864..279ad28bf4fb 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -510,7 +510,10 @@ struct file_system_type rootfs_fs_type = {
 
 void __init init_rootfs(void)
 {
-	if (IS_ENABLED(CONFIG_TMPFS) && !saved_root_name[0] &&
-		(!root_fs_names || strstr(root_fs_names, "tmpfs")))
-		is_tmpfs = true;
+	if (IS_ENABLED(CONFIG_TMPFS)) {
+		if (!saved_root_name[0] && !root_fs_names)
+			is_tmpfs = true;
+		else if (root_fs_names && !!strstr(root_fs_names, "tmpfs"))
+			is_tmpfs = true;
+	}
 }
-- 
2.41.0

