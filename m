Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6096E7FCD25
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 04:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376862AbjK2DDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 22:03:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376791AbjK2DDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 22:03:34 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03AEE19A4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 19:03:38 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20231129030335epoutp042dbf4665807f51eda3abe6dea2c9404d~b_PUVRqHN2826628266epoutp04F
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 03:03:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20231129030335epoutp042dbf4665807f51eda3abe6dea2c9404d~b_PUVRqHN2826628266epoutp04F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1701227015;
        bh=PDEk9kY3nrmL8GjXi/hdUYFbHIowAUw4NK0dmP325t4=;
        h=From:To:Cc:Subject:Date:References:From;
        b=f4U9WICSyY1uFy92+OLvw/SKGUyfAE1/+PpFTYGpB9cvyreE1r9/u53XqbC8l49Zy
         xg0rdigKUBi8yE86aTPRv3Du3M9nG9dQfp92e4NMAuMcsFa/i+wiwXX+eljS9ivuYX
         CYmkr7Kv8L+bwQ7tjKNRlwBXTIH7vs95lowDYUl8=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20231129030335epcas5p4a4d1fe85dbbe937c8f36546094ffba78~b_PTu1kpj0805908059epcas5p4Y;
        Wed, 29 Nov 2023 03:03:35 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Sg4055tFTz4x9Pv; Wed, 29 Nov
        2023 03:03:33 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        4E.C2.10009.50AA6656; Wed, 29 Nov 2023 12:03:33 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20231128123622epcas5p4940679fbbafdf0da802deea3e531f850~byaI4M4UY1906519065epcas5p4P;
        Tue, 28 Nov 2023 12:36:22 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231128123622epsmtrp11d28128d4f35c3ff4c3aa4592c5ac963~byaI3cksl0249402494epsmtrp1t;
        Tue, 28 Nov 2023 12:36:22 +0000 (GMT)
X-AuditID: b6c32a4a-ff1ff70000002719-c3-6566aa056cc9
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        30.E7.18939.6CED5656; Tue, 28 Nov 2023 21:36:22 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
        [107.99.41.245]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20231128123621epsmtip1f39a9cdfbd0f70a2893b5e390ab4c438~byaHL45kA0175001750epsmtip1V;
        Tue, 28 Nov 2023 12:36:20 +0000 (GMT)
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>
Cc:     error27@gmail.com, gost.dev@samsung.com, nitheshshetty@gmail.com,
        Nitesh Shetty <nj.shetty@samsung.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] nvme: Update type from size_t to u16 for
 opts->queue_size
Date:   Tue, 28 Nov 2023 17:59:56 +0530
Message-Id: <20231128122958.2235-1-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMJsWRmVeSWpSXmKPExsWy7bCmui7rqrRUg+N/FC1W3+1ns3i0zM/i
        5oGdTBYrVx9lsti98COTxaRD1xgtnl6dxWRxedccNov5y56yW+x40shose33fGaLda/fszjw
        eMy6f5bNY+esu+we5+9tZPG4fLbUY9OqTjaPzUvqPXbfbGDz6G1+x+bRt2UVo8fnTXIBXFHZ
        NhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlAVysplCXm
        lAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCkwK9IoTc4tL89L18lJLrAwNDIxMgQoTsjP6
        unewFbRLVSw7sIi9gfGuaBcjJ4eEgInE1ekH2bsYuTiEBHYzSkw8/JUVwvnEKPHo3F8WOOf2
        1V9MMC3fXqyASuxklFg76RIbhNPKJHGr8xBQFQcHm4C2xOn/HCBxEYErjBKzHz4FK2IWWMso
        ce31YXaQUcICARJnV3SxgjSwCKhKfFseBhLmFbCU2PRjNlhYQkBfov++IERYUOLkzCcsIDaz
        gLxE89bZzCAjJQSmckhMuryLEeI6F4nV25qgbGGJV8e3sEPYUhIv+9ug7HKJlVNWsEE0tzBK
        zLo+C6rBXqL1VD8zyGJmAU2J9bv0IcKyElNPrWOCWMwn0fv7CTQkeCV2zIOxlSXWrF/ABmFL
        Slz73ghle0jc/3oRrEZIIFZi1oafTBMY5Wch+WcWkn9mIWxewMi8ilEytaA4Nz212LTAKC+1
        HB6zyfm5mxjBqVfLawfjwwcf9A4xMnEwHmKU4GBWEuHV+5icKsSbklhZlVqUH19UmpNafIjR
        FBjEE5mlRJPzgck/ryTe0MTSwMTMzMzE0tjMUEmc93Xr3BQhgfTEktTs1NSC1CKYPiYOTqkG
        JvkAp/I18x44JK7dW3n6vNNkQ9Z2VsGT4q8k9Q6mnPqVI2E8h092H+/q5BxTdumdh+SbOKeV
        /Nx1IrlRTdnh/7f1LJaTfCTn71tr8ovnVnG95OUvHSz/tzYpx7t686wsmv680Ssx/dW9yzP+
        7RTV+Pyo4rhuxa+lv/l3q228cfDNy7ssJ4pv6639cPEvF1/7hvs/H939mnroXtybm7Ovlh/X
        K857qDrJoW2u7oX67XGmTk87GjVj4x7xlC57uKj43uYl54wz//hN6DfoPXXjgYruzI6mIvOe
        t23iRy/yrG8/+0fymKPR4imXY11T0+dPKr8/gW+J2C1drVtZ9/c++7dx5bftNRttda7WvxDk
        2DxFiaU4I9FQi7moOBEATPe1tEYEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBLMWRmVeSWpSXmKPExsWy7bCSnO6xe6mpBs+WaVusvtvPZvFomZ/F
        zQM7mSxWrj7KZLF74Ucmi0mHrjFaPL06i8ni8q45bBbzlz1lt9jxpJHRYtvv+cwW616/Z3Hg
        8Zh1/yybx85Zd9k9zt/byOJx+Wypx6ZVnWwem5fUe+y+2cDm0dv8js2jb8sqRo/Pm+QCuKK4
        bFJSczLLUov07RK4Mvq6d7AVtEtVLDuwiL2B8a5oFyMnh4SAicS3FytYuhi5OIQEtjNKrD77
        lBkiISmx7O8RKFtYYuW/5+wgtpBAM5NE43T+LkYODjYBbYnT/zlAekUEbjFKPN++gBnEYRbY
        zCgx7ckmsAZhAT+JbQ8+MoI0sAioSnxbHgYS5hWwlNj0YzYrSFhCQF+i/74gRFhQ4uTMJywg
        NrOAvETz1tnMExj5ZiFJzUKSWsDItIpRNLWgODc9N7nAUK84Mbe4NC9dLzk/dxMjOPC1gnYw
        Llv/V+8QIxMH4yFGCQ5mJRFevY/JqUK8KYmVValF+fFFpTmpxYcYpTlYlMR5lXM6U4QE0hNL
        UrNTUwtSi2CyTBycUg1MxVV2llosDXZbLiiGH1JbFdrU7XeXQ2fv1on/zYx0/LIra1Rs4/ev
        /M2YP+cZd8ikINEVOVbN2znmy1atZzHNMTbZ5xHXW1VXtqy8XrGy5/uTesHzBfN2nX2cbsC8
        b3PR+wOvClbrmDM4d062mPbesujz9imLrrg/fX3uzZm86pm2p7Rf/08JX3LFh3/9qTMPDTa2
        iDO5zlb8O39j5M0pC97/fL39asbeepMmvuV+PxZuezijfxvft/y3PQ7OW37dv1Amk8P1R8h3
        14Q/k1ew84UnVHUbdKoUvzLY+lRXPuvHhs83TplJf7A1y1FTc1rKfGgdQ115/epY37+/b882
        ENv0cOIT+btnKvbJmbR9U2Ipzkg01GIuKk4EAN1hxXbrAgAA
X-CMS-MailID: 20231128123622epcas5p4940679fbbafdf0da802deea3e531f850
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231128123622epcas5p4940679fbbafdf0da802deea3e531f850
References: <CGME20231128123622epcas5p4940679fbbafdf0da802deea3e531f850@epcas5p4.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the smatch warning, "nvme_loop_create_ctrl() warn:
'opts->queue_size - 1' 18446744073709551615 can't fit into 65535
'ctrl->ctrl.sqsize'"
We don't need size_t for queue_size, u16 should serve the purpose,
as max size is limited to NVMF_DEF_QUEUE_SIZE(1024).

Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
---
 drivers/nvme/host/fabrics.h | 2 +-
 drivers/nvme/host/fc.c      | 2 +-
 drivers/nvme/host/rdma.c    | 2 +-
 drivers/nvme/host/tcp.c     | 2 +-
 drivers/nvme/target/loop.c  | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index fbaee5a7be19..0b2e45faa3b9 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -125,7 +125,7 @@ struct nvmf_ctrl_options {
 	char			*trsvcid;
 	char			*host_traddr;
 	char			*host_iface;
-	size_t			queue_size;
+	u16			queue_size;
 	unsigned int		nr_io_queues;
 	unsigned int		reconnect_delay;
 	bool			discovery_nqn;
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 9f9a3b35dc64..7f680443b3cf 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3159,7 +3159,7 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 	if (opts->queue_size > ctrl->ctrl.maxcmd) {
 		/* warn if maxcmd is lower than queue_size */
 		dev_warn(ctrl->ctrl.device,
-			"queue_size %zu > ctrl maxcmd %u, reducing "
+			"queue_size %u > ctrl maxcmd %u, reducing "
 			"to maxcmd\n",
 			opts->queue_size, ctrl->ctrl.maxcmd);
 		opts->queue_size = ctrl->ctrl.maxcmd;
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 6d178d555920..d0b7543f753e 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1025,7 +1025,7 @@ static int nvme_rdma_setup_ctrl(struct nvme_rdma_ctrl *ctrl, bool new)
 
 	if (ctrl->ctrl.opts->queue_size > ctrl->ctrl.sqsize + 1) {
 		dev_warn(ctrl->ctrl.device,
-			"queue_size %zu > ctrl sqsize %u, clamping down\n",
+			"queue_size %u > ctrl sqsize %u, clamping down\n",
 			ctrl->ctrl.opts->queue_size, ctrl->ctrl.sqsize + 1);
 	}
 
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index d79811cfa0ce..d03f5921d344 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2193,7 +2193,7 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
 
 	if (opts->queue_size > ctrl->sqsize + 1)
 		dev_warn(ctrl->device,
-			"queue_size %zu > ctrl sqsize %u, clamping down\n",
+			"queue_size %u > ctrl sqsize %u, clamping down\n",
 			opts->queue_size, ctrl->sqsize + 1);
 
 	if (ctrl->sqsize + 1 > ctrl->maxcmd) {
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 9cb434c58075..0416f41fad19 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -573,7 +573,7 @@ static struct nvme_ctrl *nvme_loop_create_ctrl(struct device *dev,
 	if (opts->queue_size > ctrl->ctrl.maxcmd) {
 		/* warn if maxcmd is lower than queue_size */
 		dev_warn(ctrl->ctrl.device,
-			"queue_size %zu > ctrl maxcmd %u, clamping down\n",
+			"queue_size %u > ctrl maxcmd %u, clamping down\n",
 			opts->queue_size, ctrl->ctrl.maxcmd);
 		opts->queue_size = ctrl->ctrl.maxcmd;
 	}

base-commit: da59b416ba80e43afb2b642e0cee73739f4c6079
-- 
2.35.1.500.gb896f729e2

