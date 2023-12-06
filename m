Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A02806B6F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 11:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377518AbjLFKLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 05:11:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377371AbjLFKLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 05:11:31 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B91D49
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 02:11:37 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231206101135epoutp0215661fd96ad0fb356efc9dcb010b3725~eNmAxCUoj2244322443epoutp02S
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 10:11:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231206101135epoutp0215661fd96ad0fb356efc9dcb010b3725~eNmAxCUoj2244322443epoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1701857495;
        bh=3rmMeBvqvZnLG710cTQe8+pDj6/LHJ1Es1eTLbldN3I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DphrSG+Xwn2/GmRM0Y5eZ21WK+jKGIYamGjzIFChOCw5HfsG25bvH5ubi7CdzGiGk
         pGMYchCk2MEIHJanydNnElpttb/sY+ji+46RVummntAYDa3CM3Ek1Fcnag3rbgM8Z9
         WRJRe0WNPzLJb4+1EQ3stmDnLnuSn3sek9qy/9u8=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20231206101135epcas5p366d5b258f1c0a8617a18ef7ac61e9e00~eNmAQkMlO0036000360epcas5p36;
        Wed,  6 Dec 2023 10:11:35 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4SlY8j3VPtz4x9Ps; Wed,  6 Dec
        2023 10:11:33 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        12.52.08567.5D840756; Wed,  6 Dec 2023 19:11:33 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20231206101133epcas5p28efae88fbc435e0a42bc89c94eec3ac2~eNl_BD5Zu3161231612epcas5p27;
        Wed,  6 Dec 2023 10:11:33 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231206101132epsmtrp2312dbf0d8724cfaaf3b06742b41fe8ee~eNl9--tcq0990909909epsmtrp2J;
        Wed,  6 Dec 2023 10:11:32 +0000 (GMT)
X-AuditID: b6c32a44-3abff70000002177-42-657048d5891e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        24.52.08817.4D840756; Wed,  6 Dec 2023 19:11:32 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231206101126epsmtip2a3dcf704089d260dd01017179cde49db~eNl4WElIo1181511815epsmtip2G;
        Wed,  6 Dec 2023 10:11:26 +0000 (GMT)
From:   Kanchan Joshi <joshi.k@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        dm-devel@lists.linux.dev, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        nitheshshetty@gmail.com, anuj1072538@gmail.com,
        gost.dev@samsung.com, mcgrof@kernel.org,
        Anuj Gupta <anuj20.g@samsung.com>,
        Hannes Reinecke <hare@suse.de>,
        Nitesh Shetty <nj.shetty@samsung.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v18 05/12] fs/read_write: Enable copy_file_range for block
 device.
Date:   Wed,  6 Dec 2023 15:32:37 +0530
Message-Id: <20231206100253.13100-6-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231206100253.13100-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02TaVBTVxTHe98LL4ESfY10uJCKmBk7QgWSst1YoLYGeQydlpn2g9h2Qgae
        gUlI0ixuoGItIJsg2FYiS1iqI4IIqOzWwlRERKiUilhSCgl1DEtl0U4z0iYEW7/9zrn//5zl
        zmHhnAKmJytZoaXVComcR7gwrvX4+PiNUCqaf6EcoobbN3H0ZNnKQF8WPsfRxfECAll6FgAy
        3cgCyFBVxkAPbrRhqLOqCEMXLv6IoaLuXwAyj+gx1DX2FqrMrGGgzq4+BhpuLyVQxTkzE+Xe
        byXQ+d4VDI0WmgE6dWIEQ62mYwBds1bg6JJlnoFujXHR4PNepx2eVJt+nEkNGhsZ1PCAjmqq
        zSao5pqj1KPmEkB1PEgnqOqTxU5U/vE5gnpiHmNQ89dHCOrklVpANfenUotNXlSTaRaLXb9H
        FpZESxJptTetSFAmJiuk4byYj8U7xcEhfIGfQIhCed4KSQodzhN9EOu3K1luWwnPe59ErrOl
        YiUaDS8gIkyt1Glp7ySlRhvOo1WJclWQyl8jSdHoFFJ/Ba3dLuDz3w62CeNlSUZDNqGaYx+o
        t46CdDD0ag5wZkEyCOYuXydygAuLQ3YAeL44H3MECwDetdYBR/AUwO9KpvAXlobSvDVLF4Dj
        My24I1gEsLc/i5kDWCyC9IFDxTq7wY2sw2Fbo8CuwclyHE7/YwD2hw3kJ3D2VjnTzgxyC2zU
        D68ym0RwObMfOKptgiX3nq3mnUkhLP6jCndoXoN9JSaGnXGb5vjVs6tNQLLDGS6cu8p0mEVw
        8r6R4eAN8HHvlbW8J1yc6yIcnADvldzFHKyFU50/rPG7MON2AW4fBrcN09Ae4Ki1DuZbTZg9
        DUk2PJHJcag3Q2OR2cnB7vD3MzVrTMGM+YHVDjhkHoDfWKMLwSb9SxPoX5pA/38xA8BrgQet
        0qRI6YRglUBB7//vYxOUKU1g9TJ8Ra1gtGLFvxtgLNANIAvnubHlg0qaw06UHDxEq5VitU5O
        a7pBsG3Fp3DP1xOUttNSaMWCICE/KCQkJEgYGCLgubMtGWWJHFIq0dIymlbR6hc+jOXsmY5N
        9aXyZ4yz4evzOqeR61Tk0tkj3A73HS20zjIBpJ2lFbKDae4ajzFRfVjZLlZNjPSNrIdRT8Wi
        qIKcw68w+3bXB8ZEdIRPurumPbxc2R+vdMld56uT4eOijXmP7hi27I97v+Vw5RfcuMCbez/C
        k2Dq5cilZzHlUP8r+1iyxWAa96mO8esZ2irfLEv+6U2vo2nE5JAm5fPs1Ljdbp8NHAnt+Xlj
        e0a18Wth5tifUStC8d5pwVe80IZtjRNbF8v8DnmM8v+KiN9u4Xd9us/1RJrPbzMTBdS2rOgP
        v+U+Lu7Pjax854D36TNxhqXuS2an6L/r9hTUeH2/UzD/3nDAAHfB4w7F5TE0SRKBL67WSP4F
        G3zg0qIEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsWy7bCSvO4Vj4JUg+0nTC3WnzrGbPHx628W
        i6YJf5ktVt/tZ7N4ffgTo8WTA+2MFgsWzWWxuHlgJ5PFnkWTmCxWrj7KZDHp0DVGi6dXZzFZ
        7L2lbbGwbQmLxZ69J1ksLu+aw2Yxf9lTdovu6zvYLJYf/8dkcWPCU0aLiR1XmSx2PGlktNj2
        ez6zxbrX71ksTtyStjj/9zirg5THzll32T3O39vI4nH5bKnHplWdbB6bl9R7vNg8k9Fj980G
        No/FfZNZPXqb37F5fHx6i8Xj/b6rbB59W1Yxemw+Xe3xeZOcx6Ynb5kC+KO4bFJSczLLUov0
        7RK4Mu4t6GQreMdbsfb3DcYGxgvcXYycHBICJhLr5/SwdTFycQgJ7GaU2Lv1NBtEQlyi+doP
        dghbWGLlv+dgtpDAR0aJUwukuxg5ONgENCUuTC4F6RUR2MEs8XNtMxOIwyywhlniytWZYIOE
        BYIk/h4+xwhiswioSmycdRlsEK+AhcTXttOMEAvkJWZe+g4W5xSwlJj8fBEzxDILiX2N01kg
        6gUlTs58AmYzA9U3b53NPIFRYBaS1CwkqQWMTKsYJVMLinPTc4sNC4zyUsv1ihNzi0vz0vWS
        83M3MYLjXUtrB+OeVR/0DjEycTAeYpTgYFYS4c05n58qxJuSWFmVWpQfX1Sak1p8iFGag0VJ
        nPfb694UIYH0xJLU7NTUgtQimCwTB6dUA5PUHM5wjdroWP0Gv1PnEqVn1Hp0BlZP1Tix3n5Z
        8owX9tuc+Badc1snvnR79272JVZN4gVVt+Nt25pXpDpzJ2QFf1uWxtPkfJ/n6+si2ejuCXEX
        98ovjvc7sGC/gR//l4XV069c+L171Tepqha5+l/fNx0LYPorL+Buf+p/2raHW6/IGLrknl5T
        0l4nGLnnx8La9f8LZwlfnptSJPjuXavq7Kdv3+5cyt94uG7dQTGbkLaCpxf2yjEx3ApyCF13
        eZt5j83SazKizuuO3+N45vX34DWhP3qlk7jffKpYbaq39vCd2gbvvT/uaCvGZBzN5urp9WJn
        X71uyzP+7OoVpfu3c5nZHblefOGWsKFb/2klluKMREMt5qLiRABeV9QYZgMAAA==
X-CMS-MailID: 20231206101133epcas5p28efae88fbc435e0a42bc89c94eec3ac2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231206101133epcas5p28efae88fbc435e0a42bc89c94eec3ac2
References: <20231206100253.13100-1-joshi.k@samsung.com>
        <CGME20231206101133epcas5p28efae88fbc435e0a42bc89c94eec3ac2@epcas5p2.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anuj Gupta <anuj20.g@samsung.com>

This is a prep patch. Allow copy_file_range to work for block devices.
Relaxing generic_copy_file_checks allows us to reuse the existing infra,
instead of adding a new user interface for block copy offload.
Change generic_copy_file_checks to use ->f_mapping->host for both inode_in
and inode_out. Allow block device in generic_file_rw_checks.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
---
 fs/read_write.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index e0c2c1b5962b..92729c7547d3 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1441,8 +1441,8 @@ static int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
 				    struct file *file_out, loff_t pos_out,
 				    size_t *req_count, unsigned int flags)
 {
-	struct inode *inode_in = file_inode(file_in);
-	struct inode *inode_out = file_inode(file_out);
+	struct inode *inode_in = file_in->f_mapping->host;
+	struct inode *inode_out = file_out->f_mapping->host;
 	uint64_t count = *req_count;
 	loff_t size_in;
 	int ret;
@@ -1750,7 +1750,9 @@ int generic_file_rw_checks(struct file *file_in, struct file *file_out)
 	/* Don't copy dirs, pipes, sockets... */
 	if (S_ISDIR(inode_in->i_mode) || S_ISDIR(inode_out->i_mode))
 		return -EISDIR;
-	if (!S_ISREG(inode_in->i_mode) || !S_ISREG(inode_out->i_mode))
+	if (!S_ISREG(inode_in->i_mode) && !S_ISBLK(inode_in->i_mode))
+		return -EINVAL;
+	if ((inode_in->i_mode & S_IFMT) != (inode_out->i_mode & S_IFMT))
 		return -EINVAL;
 
 	if (!(file_in->f_mode & FMODE_READ) ||
-- 
2.35.1.500.gb896f729e2

