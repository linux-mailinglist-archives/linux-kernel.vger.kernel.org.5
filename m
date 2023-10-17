Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D10D7CBD18
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 10:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234630AbjJQIJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 04:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234615AbjJQIJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 04:09:15 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7140793;
        Tue, 17 Oct 2023 01:09:14 -0700 (PDT)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39H7xlWk030480;
        Tue, 17 Oct 2023 01:09:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=PPS06212021; bh=xeHRr
        YSlwFJ7Ie5ghNKEBZpDUSrY1cP2h0yJxyOOoys=; b=UzL6cmBsK0UcX29R5XOy3
        hxTzah7yHsZ3DYxJ58SOpuho7GdqUhRa3kSZGzgvnRgNmoreqgxMNcptDgk43T4X
        U0VTbcScumPIRPg5KzwRJxR30iXJYQfoQbJ4p1AdIH3tHHGrShd2CaGZBDmqyZZ2
        +Ov8XaHKSorO9dg8m5qw5jmh+IajBnqe8FNpNKTsrjMIWXql9ucfGytTWdSSJvCG
        gXdf8VsnLkghjmwzynJiqePAylaIjUnUZAe2DkGFK3gykBh0DhXbl0mW1tSDIKAy
        wG7Z+sT1N6vcBwmk+Rf17K8fAGPLWO9bKoc8E/YDLbINccBYGtKFSsiA8rrZ5rpU
        A==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3tqtgfjgrf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 17 Oct 2023 01:09:02 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 17 Oct 2023 01:09:01 -0700
Received: from pek-lpd-susbld.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.32 via Frontend Transport; Tue, 17 Oct 2023 01:09:01 -0700
From:   Li Wang <li.wang@windriver.com>
To:     <axboe@kernel.dk>, <lilingfeng3@huawei.com>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] block: fix ioctl return error with GENHD_FL_NO_PART
Date:   Tue, 17 Oct 2023 16:09:00 +0800
Message-ID: <20231017080900.842241-1-li.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: hjHpSh-v2Nkok_XuB1Rg5uiAs_Oi14uf
X-Proofpoint-ORIG-GUID: hjHpSh-v2Nkok_XuB1Rg5uiAs_Oi14uf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_13,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 phishscore=0
 mlxlogscore=999 adultscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2309180000 definitions=main-2310170066
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GENHD_FL_NO_PART means no device(-ENXIO), not parameter error(-EINVAL).

test case with parted command:
@dd if=/dev/zero of=./blk-file bs=1M count=200
@losetup /dev/loop0 ./blk-file
@parted -s /dev/loop0 mklabel MSDOS
Error: Partition(s) 1, ..., 64 on /dev/loop0 have been written,
but we have been unable to inform the kernel of the change,
probably because it/they are in use. As a result,
the old partition(s) will remain in use. You should reboot now
before making further changes.
@echo $?
1

Fixes: 1a721de8489f ("block: don't add or resize partition on the disk with GENHD_FL_NO_PART")
Signed-off-by: Li Wang <li.wang@windriver.com>
---
 block/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index d5f5cd61efd7..701c64cd67e8 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -21,7 +21,7 @@ static int blkpg_do_ioctl(struct block_device *bdev,
 	long long start, length;
 
 	if (disk->flags & GENHD_FL_NO_PART)
-		return -EINVAL;
+		return -ENXIO;
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
 	if (copy_from_user(&p, upart, sizeof(struct blkpg_partition)))
-- 
2.25.1

