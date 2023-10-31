Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB317DD0CA
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 16:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbjJaPok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 11:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjJaPoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 11:44:39 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71248F
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 08:44:36 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39VFErFP011868;
        Tue, 31 Oct 2023 15:44:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=hcPfPdzQdn3iAnwDyKZq0p0knBZPODiqUl2zgguD4uU=;
 b=jMSYpk2bN7uISar83gP/SOJeylP+OPj3Hf2sgSkBM8WA8qDSfdsSpMgp36XYndJy7c8Y
 k0ZnysmWn9cHjpHKVaqPZ+0DB1iviLU3qjckjtTFQwxAGN3aZesGHQvN3eb4Oeqakt+B
 r+Gk/DX1mNL0PrYWDrCx5uOLjS5UMkEglkR1uFhA+8Voa7K2HI260kcm0f2AUEvxTnWG
 +75UA40W2csDkKH2qGQI1FfbtFpZLDH5gmXb+1xmyMcnSPjI2yA/kzVE+9r3aAmkmjMC
 RaFCCiw3KSx7JIrT07QgiYEQdjOBsX1OYBPsvaLFUnjKhrXnmVRiCrkDIFo3XuzUkbY5 rA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u33qn1w1s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 15:44:24 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39VFF1Qp012731;
        Tue, 31 Oct 2023 15:44:23 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u33qn1w1a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 15:44:23 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39VEH4It011310;
        Tue, 31 Oct 2023 15:44:23 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u1euk16f6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 15:44:22 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39VFiL4J36831698
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Oct 2023 15:44:21 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 841AA58065;
        Tue, 31 Oct 2023 15:44:21 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D00CD5805D;
        Tue, 31 Oct 2023 15:44:20 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 31 Oct 2023 15:44:20 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Stefan Berger <stefanb@linux.ibm.com>,
        "Milton D. Miller II" <mdmii@outlook.com>,
        Rob Landley <rob@landley.net>,
        Jeff Layton <jlayton@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Jim Cromie <jim.cromie@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "H. Peter Anvin" <hpa@zytor.com>, Mimi Zohar <zohar@linux.ibm.com>
Subject: [RFC PATCH] rootfs: Use tmpfs for rootfs even if root= is given
Date:   Tue, 31 Oct 2023 11:44:17 -0400
Message-ID: <20231031154417.621742-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2LrlqeqYgtB4SLYojPQI_PGG228vNGTn
X-Proofpoint-GUID: Xd9rqnfNRXDAGVBAN3DYBn_YOMaZETdg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-31_02,2023-10-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 mlxlogscore=795 clxscore=1011 malwarescore=0 impostorscore=0
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310310125
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rootfs currently does not use tmpfs if the root= boot option is passed
even though the documentation about rootfs (added in 6e19eded3684) in
Documentation/filesystems/ramfs-rootfs-initramfs.rst states:

  If CONFIG_TMPFS is enabled, rootfs will use tmpfs instead of ramfs by
  default.  To force ramfs, add "rootfstype=ramfs" to the kernel command
  line.

However, this currently does not work when root= is passed on the boot
command line since then saved_root_name contains a string and prevents
usage of tmpfs. Therefore, remove the check on saved_root_name to
enable tmpfs for rootfs.

Fixes: 6e19eded3684 ("initmpfs: use initramfs if rootfstype= or root= specified")
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Cc: "Milton D. Miller II" <mdmii@outlook.com>
Cc: Rob Landley <rob@landley.net>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Jim Cromie <jim.cromie@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>
---
 init/do_mounts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/do_mounts.c b/init/do_mounts.c
index 5dfd30b13f48..6567cf5807ee 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -510,7 +510,7 @@ struct file_system_type rootfs_fs_type = {
 
 void __init init_rootfs(void)
 {
-	if (IS_ENABLED(CONFIG_TMPFS) && !saved_root_name[0] &&
+	if (IS_ENABLED(CONFIG_TMPFS) &&
 		(!root_fs_names || strstr(root_fs_names, "tmpfs")))
 		is_tmpfs = true;
 }
-- 
2.40.1

