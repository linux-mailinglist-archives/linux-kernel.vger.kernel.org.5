Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBAB7D4325
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 01:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbjJWXRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 19:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJWXRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 19:17:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5DCC0;
        Mon, 23 Oct 2023 16:17:29 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39NMJZnC012114;
        Mon, 23 Oct 2023 23:17:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2023-03-30;
 bh=GpxSDSh7UIyddMbQEDT+nBmKcU5KTVkXVikk2aYD+GM=;
 b=VXqYeNUGIT8y0g4T2ZEdAQYN3l9XjV49wDOfcpXMc3yh+hYxg1vDI3VvoCzuuU0g2FCt
 QDoUuKyxedDQcIodsfm3k4DABNRGj6jZ8XKftBZsad5a61jp2JcsEmObvTkXORwHpCiJ
 XEb2OJ1xMkKmnc35fSa14UtB5l/p7GRHalPGyZqBrFUeeTiyZFqmuY3UXkBNaSfuGTmx
 fFAeoKyUrMP6GBFYPdFsrTDwsyriN5fYeRExKFmjMQAG2c5pCiO2Fik0c9d6MFjUECjb
 J4q8pAhETydCyO6wvPMEjhlOz6Yq82SFIt6GbtPAnQzgQnfEQZCm70H4DSvItCxC8yJ7 RA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv68tc9rw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Oct 2023 23:17:05 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39NLO3lF018954;
        Mon, 23 Oct 2023 23:17:05 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com [10.153.73.24])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3tv534verp-1;
        Mon, 23 Oct 2023 23:17:05 +0000
From:   Si-Wei Liu <si-wei.liu@oracle.com>
To:     jasowang@redhat.com, mst@redhat.com,
        virtualization@lists.linux-foundation.org, sfr@canb.auug.org.au
Cc:     dtatulea@nvidia.com, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org
Subject: [PATCH] vhost-vdpa: fix NULL pointer deref in _compat_vdpa_reset
Date:   Mon, 23 Oct 2023 16:14:23 -0700
Message-Id: <1698102863-21122-1-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_21,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 suspectscore=0 phishscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310230204
X-Proofpoint-ORIG-GUID: kFqRJFETwDPh-5HKFdvBMTVe0lcMo_3O
X-Proofpoint-GUID: kFqRJFETwDPh-5HKFdvBMTVe0lcMo_3O
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As subject. There's a vhost_vdpa_reset() done earlier before
vhost_dev is initialized via vhost_dev_init(), ending up with
NULL pointer dereference. Fix is to check if vqs is initialized
before checking backend features and resetting the device.

  BUG: kernel NULL pointer dereference, address: 0000000000000000
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  PGD 0 P4D 0
  Oops: 0000 [#1] SMP
  CPU: 3 PID: 1727 Comm: qemu-system-x86 Not tainted 6.6.0-rc6+ #2
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-
  a4aeb02-prebuilt.qemu.org 04/01/2014
  RIP: 0010:_compat_vdpa_reset+0x47/0xc0 [vhost_vdpa]
  Code: c7 c7 fb 12 56 a0 4c 8d a5 b8 02 00 00 48 89 ea e8 7e b8 c4
  48 89 ee 48 c7 c7 19 13 56 a0 4c 8b ad b0 02 00 00 <48> 8b 00 49
  00 48 8b 80 88 45 00 00 48 c1 e8 08 48
  RSP: 0018:ffff8881063c3c38 EFLAGS: 00010246
  RAX: 0000000000000000 RBX: ffff8881074eb800 RCX: 0000000000000000
  RDX: 0000000000000000 RSI: ffff888103ab4000 RDI: ffffffffa0561319
  RBP: ffff888103ab4000 R08: 00000000ffffdfff R09: 0000000000000001
  R10: 0000000000000003 R11: ffff88887fecbac0 R12: ffff888103ab42b8
  R13: ffff888106dbe850 R14: 0000000000000003 R15: ffff8881074ebc18
  FS:  00007f02fba6ef00(0000) GS:ffff88885f8c0000(0000)
  knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000000000000000 CR3: 00000001325e5003 CR4: 0000000000372ea0
  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
  Call Trace:
   <TASK>
   ? __die+0x1f/0x60
   ? page_fault_oops+0x14c/0x3b0
   ? exc_page_fault+0x74/0x140
   ? asm_exc_page_fault+0x22/0x30
   ? _compat_vdpa_reset+0x47/0xc0 [vhost_vdpa]
   ? _compat_vdpa_reset+0x32/0xc0 [vhost_vdpa]
   vhost_vdpa_open+0x55/0x270 [vhost_vdpa]
   ? sb_init_dio_done_wq+0x50/0x50
   chrdev_open+0xc0/0x210
   ? __unregister_chrdev+0x50/0x50
   do_dentry_open+0x1fc/0x4f0
   path_openat+0xc2d/0xf20
   do_filp_open+0xb4/0x160
   ? kmem_cache_alloc+0x3c/0x490
   do_sys_openat2+0x8d/0xc0
   __x64_sys_openat+0x6a/0xa0
   do_syscall_64+0x3c/0x80
   entry_SYSCALL_64_after_hwframe+0x46/0xb0

Fixes: 10cbf8dfaf93 ("vhost-vdpa: clean iotlb map during reset for older userspace")
Reported-by: Dragos Tatulea <dtatulea@nvidia.com>
Closes: https://lore.kernel.org/all/b4913f84-8b52-4d28-af51-8573dc361f82@oracle.com/
Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 drivers/vhost/vdpa.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 9ce40003793b..9a2343c45df0 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -232,9 +232,11 @@ static int _compat_vdpa_reset(struct vhost_vdpa *v)
 	struct vdpa_device *vdpa = v->vdpa;
 	u32 flags = 0;
 
-	flags |= !vhost_backend_has_feature(v->vdev.vqs[0],
-					    VHOST_BACKEND_F_IOTLB_PERSIST) ?
-		 VDPA_RESET_F_CLEAN_MAP : 0;
+	if (v->vdev.vqs) {
+		flags |= !vhost_backend_has_feature(v->vdev.vqs[0],
+						    VHOST_BACKEND_F_IOTLB_PERSIST) ?
+			 VDPA_RESET_F_CLEAN_MAP : 0;
+	}
 
 	return vdpa_reset(vdpa, flags);
 }
-- 
2.39.3

