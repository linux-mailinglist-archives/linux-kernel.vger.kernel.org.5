Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A447E8003
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235581AbjKJSDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:03:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235762AbjKJSCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:02:44 -0500
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1B631E4A;
        Fri, 10 Nov 2023 03:48:20 -0800 (PST)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3AABUXtK023201;
        Fri, 10 Nov 2023 03:48:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PPS06212021; bh=feAmthakErj4UOFOkEZXH1ohZ3TPcXzAn7ar+R3ELWU=; b=
        kGKyo7YU7EZn2nuPeqV3P3nwUMu5wXpjYhLql8WGZJ43KtH0G5Rit85LJd5f0Y5J
        FSJvXYhicOHqj4ZOFiMNcpypLB3aMtTQ9OmjJQTO+0FuTPp0oF3WQVFa47pSJeDD
        zdGaXGsAzddRDu+zGlwEupBb6kwtUhSfYq3gq8cIBxCqyEHBE3XqjgvQBeyx3v6T
        GquonGizdD3AF670VazJ3MCbsYllGrEaQO+ShlQQMxB68UOOWocHRIOVd7KTMPwl
        RMKW7SysJuDbgrRLXXLvsoaaqJq7c2L5rUKe3tnfq9FpMQzOZKJTM+a1yBSDFgrF
        47jZOL7v5h+LyO4LHwygEQ==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3u7w2t30k5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 10 Nov 2023 03:48:10 -0800 (PST)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 10 Nov 2023 03:48:13 -0800
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.34 via Frontend Transport; Fri, 10 Nov 2023 03:48:10 -0800
From:   Lizhi Xu <lizhi.xu@windriver.com>
To:     <syzbot+4d81015bc10889fd12ea@syzkaller.appspotmail.com>
CC:     <boris@bur.io>, <clm@fb.com>, <dsterba@suse.com>,
        <josef@toxicpanda.com>, <linux-btrfs@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <syzkaller-bugs@googlegroups.com>
Subject: [PATCH] btrfs: fix warning in create_pending_snapshot
Date:   Fri, 10 Nov 2023 19:48:06 +0800
Message-ID: <20231110114806.3366681-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <0000000000001959d30609bb5d94@google.com>
References: <0000000000001959d30609bb5d94@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: tjoSHBo47CL5QMVxWy5JUXO5hy0Yt9Yo
X-Proofpoint-ORIG-GUID: tjoSHBo47CL5QMVxWy5JUXO5hy0Yt9Yo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_08,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 mlxlogscore=897 impostorscore=0 clxscore=1011 phishscore=0 bulkscore=0
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311060001 definitions=main-2311100096
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

r0 = open(&(0x7f0000000080)='./file0\x00', 0x0, 0x0)
ioctl$BTRFS_IOC_QUOTA_CTL(r0, 0xc0109428, &(0x7f0000000000)={0x1})
r1 = openat$cgroup_ro(0xffffffffffffff9c, &(0x7f0000000100)='blkio.bfq.time_recursive\x00', 0x275a, 0x0)
ioctl$BTRFS_IOC_QGROUP_CREATE(r1, 0x4010942a, &(0x7f0000000640)={0x1, 0x100})
r2 = openat(0xffffffffffffff9c, &(0x7f0000000500)='.\x00', 0x0, 0x0)
ioctl$BTRFS_IOC_SNAP_CREATE(r0, 0x50009401, &(0x7f0000000a80)={{r2},

From the logs, it can be seen that syz can execute to btrfs_ioctl_qgroup_create()
through two paths.
Syz enters btrfs_ioctl_qgroup_create() by calling ioctl$BTRFS_IOC_QGROUP_CREATE(
r1, 0x4010942a,&(0x7f000000 640)={0x1, 0x100}) or ioctl$BTRFS_IOC_SNAP_CREATE(r0,
0x50009401,&(0x7f000000 a80)={r2}," respectively;

The most crucial thing is that when calling ioctl$BTRFS_IOC_QGROUP_CREATE,
the passed parameter qgroupid value is 256, while BTRFS_FIRST_FREE_OBJECTID
is also equal to 256, indicating that the passed parameter qgroupid is
obviously incorrect.

Reported-and-tested-by: syzbot+4d81015bc10889fd12ea@syzkaller.appspotmail.com
Fixes: 6ed05643ddb1 ("btrfs: create qgroup earlier in snapshot creation")
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
---
 fs/btrfs/ioctl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 752acff2c734..21cf7a7f18ab 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3799,6 +3799,11 @@ static long btrfs_ioctl_qgroup_create(struct file *file, void __user *arg)
 		goto out;
 	}
 
+	if (sa->create && sa->qgroupid == BTRFS_FIRST_FREE_OBJECTID) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	trans = btrfs_join_transaction(root);
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
-- 
2.25.1

