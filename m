Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A651F7D7873
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 01:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjJYXQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 19:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJYXQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 19:16:10 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84EF3BB;
        Wed, 25 Oct 2023 16:16:07 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39PLPwHS019306;
        Wed, 25 Oct 2023 23:15:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2023-03-30;
 bh=YhogheplkOov6CtuctZ/3d9HRRT8CjStcBY8dqmxkp8=;
 b=YPNtUBboX2R2y8h6H9ms+P7TnCCvpqdKDAnXm17vwlGO/aBuh8E+bUU50vb9pfcfEKmk
 iTjlVFhCMlWBAESEI6Y6yxVemvhiKT6S58CMSIUyHsbDpEm9Umo6eWTyC0ghoHsi1UHX
 Ue87p1fXPH+o+2D0cNqvd5TRlH2Xb5GWNabRWZWmNCV+WeLDOcrMoJD5t4JOlhCqCd2i
 nUwV4wpK8UjQfmhnkiRJTSxeqKvqf/RLDfgHclve2ktJ3xZw9pIT/tIoheVZk+O2LV+d
 5TfOkMYx8M/wHIJyNRrJLY3RlB61wWuTLnNsLNja74KMgAwgo18zeew4IjZAp6kRRUVb CA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv68thh08-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Oct 2023 23:15:58 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39PLKj1j001460;
        Wed, 25 Oct 2023 23:15:57 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com [10.153.73.24])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3tv53dutnx-1;
        Wed, 25 Oct 2023 23:15:57 +0000
From:   Si-Wei Liu <si-wei.liu@oracle.com>
To:     jasowang@redhat.com, mst@redhat.com,
        virtualization@lists.linux-foundation.org, sfr@canb.auug.org.au
Cc:     leiyang@redhat.com, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org
Subject: [PATCH] vhost-vdpa: fix use-after-free in _compat_vdpa_reset
Date:   Wed, 25 Oct 2023 16:13:14 -0700
Message-Id: <1698275594-19204-1-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_13,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=807
 adultscore=0 bulkscore=0 suspectscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310250198
X-Proofpoint-ORIG-GUID: YZX4G4tlMob0ASMuBYR5Jy2w6eU9RXzk
X-Proofpoint-GUID: YZX4G4tlMob0ASMuBYR5Jy2w6eU9RXzk
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the vhost-vdpa device is being closed, vhost_vdpa_cleanup() doesn't
clean up the vqs pointer after free. This could lead to use-after-tree
when _compat_vdpa_reset() tries to access the vqs that are freed already.
Fix is to set vqs pointer to NULL at the end of vhost_vdpa_cleanup()
after getting freed, which is guarded by atomic opened state.

  BUG: unable to handle page fault for address: 00000001005b4af4
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  PGD 16a80a067 P4D 0
  Oops: 0000 [#1] PREEMPT SMP NOPTI
  CPU: 4 PID: 40387 Comm: qemu-kvm Not tainted 6.6.0-rc7+ #3
  Hardware name: Dell Inc. PowerEdge R750/0PJ80M, BIOS 1.8.2 09/14/2022
  RIP: 0010:_compat_vdpa_reset.isra.0+0x27/0xb0 [vhost_vdpa]
  Code: 90 90 90 0f 1f 44 00 00 41 55 4c 8d ae 08 03 00 00 41 54 55 48
  89 f5 53 4c 8b a6 00 03 00 00 48 85 ff 74 49 48 8b 07 4c 89 ef <48> 8b
  80 88 45 00 00 48 c1 e8 08 48 83 f0 01 89 c3 e8 73 5e 9b dc
  RSP: 0018:ff73a85762073ba0 EFLAGS: 00010286
  RAX: 00000001005b056c RBX: ff32b13ca6994c68 RCX: 0000000000000002
  RDX: 0000000000000001 RSI: ff32b13c07559000 RDI: ff32b13c07559308
  RBP: ff32b13c07559000 R08: 0000000000000000 R09: ff32b12ca497c0f0
  R10: ff73a85762073c58 R11: 0000000c106f9de3 R12: ff32b12c95b1d050
  R13: ff32b13c07559308 R14: ff32b12d0ddc5100 R15: 0000000000008002
  FS:  00007fec5b8cbf80(0000) GS:ff32b13bbfc80000(0000)
  knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00000001005b4af4 CR3: 000000015644a003 CR4: 0000000000773ee0
  PKRU: 55555554
  Call Trace:
   <TASK>
   ? __die+0x20/0x70
   ? page_fault_oops+0x76/0x170
   ? exc_page_fault+0x65/0x150
   ? asm_exc_page_fault+0x22/0x30
   ? _compat_vdpa_reset.isra.0+0x27/0xb0 [vhost_vdpa]
   vhost_vdpa_open+0x57/0x280 [vhost_vdpa]
   ? __pfx_chrdev_open+0x10/0x10
   chrdev_open+0xc6/0x260
   ? __pfx_chrdev_open+0x10/0x10
   do_dentry_open+0x16e/0x530
   do_open+0x21c/0x400
   path_openat+0x111/0x290
   do_filp_open+0xb2/0x160
   ? __check_object_size.part.0+0x5e/0x140
   do_sys_openat2+0x96/0xd0
   __x64_sys_openat+0x53/0xa0
   do_syscall_64+0x59/0x90
   ? syscall_exit_to_user_mode+0x22/0x40
   ? do_syscall_64+0x69/0x90
   ? syscall_exit_to_user_mode+0x22/0x40
   ? do_syscall_64+0x69/0x90
   ? do_syscall_64+0x69/0x90
   ? syscall_exit_to_user_mode+0x22/0x40
   ? do_syscall_64+0x69/0x90
   ? exc_page_fault+0x65/0x150
   entry_SYSCALL_64_after_hwframe+0x6e/0xd8

Fixes: 10cbf8dfaf93 ("vhost-vdpa: clean iotlb map during reset for older userspace")
Fixes: ac7e98c73c05 ("vhost-vdpa: fix NULL pointer deref in _compat_vdpa_reset")
Reported-by: Lei Yang <leiyang@redhat.com>
Closes: https://lore.kernel.org/all/CAPpAL=yHDqn1AztEcN3MpS8o4M+BL_HVy02FdpiHN7DWd91HwQ@mail.gmail.com/
Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 drivers/vhost/vdpa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 9a2343c45df0..30df5c58db73 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -1355,6 +1355,7 @@ static void vhost_vdpa_cleanup(struct vhost_vdpa *v)
 	vhost_vdpa_free_domain(v);
 	vhost_dev_cleanup(&v->vdev);
 	kfree(v->vdev.vqs);
+	v->vdev.vqs = NULL;
 }
 
 static int vhost_vdpa_open(struct inode *inode, struct file *filep)
-- 
2.39.3

