Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A5A7CF84D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 14:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345497AbjJSMHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 08:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235431AbjJSMGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 08:06:19 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50EA10C9
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 05:04:34 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20231019120425epoutp039786145caa1673b146632f2a6777c172~PgK0uDScR2841428414epoutp03L
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 12:04:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20231019120425epoutp039786145caa1673b146632f2a6777c172~PgK0uDScR2841428414epoutp03L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1697717065;
        bh=W6Cvqjs8GJhwgBfxrn3JFatd+tYHBlqUZSV4Q7H1XFM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cOITCODNXXuYwgLQ6hyqZYYLH3GJY/7fPZzF/sdr6RHAL+atAmR8035wbBK7PTHfO
         EXsUuQMhgjAF3ITxKiEVZVxl0OgT/b5Yh/Y06YT90ChXO3+AMzQUIb1Owrmbh/4Fgw
         G7zSuNMG68blBewu27/NB+JxxA5XIdOp93yC8R1A=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20231019120425epcas5p39a9a0961718caa950f5d37351b93c490~PgK0GSnQG1178011780epcas5p3O;
        Thu, 19 Oct 2023 12:04:25 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4SB5x3443yz4x9Pp; Thu, 19 Oct
        2023 12:04:23 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F7.DB.19369.74B11356; Thu, 19 Oct 2023 21:04:23 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20231019110954epcas5p132f1188382b57c5e6cd071e52100b60f~PfbOf8T-e2531825318epcas5p1C;
        Thu, 19 Oct 2023 11:09:54 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231019110954epsmtrp2dead90b55f80f656007a5524af4403c2~PfbOfE_Un1629616296epsmtrp2u;
        Thu, 19 Oct 2023 11:09:54 +0000 (GMT)
X-AuditID: b6c32a50-c99ff70000004ba9-22-65311b4779c4
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        08.88.08817.28E01356; Thu, 19 Oct 2023 20:09:54 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
        [107.99.41.245]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20231019110951epsmtip1cdd2d4cc218dfbcf4982a24ae7888de3~PfbLbvW240548505485epsmtip1H;
        Thu, 19 Oct 2023 11:09:51 +0000 (GMT)
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@lists.linux.dev,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        nitheshshetty@gmail.com, anuj1072538@gmail.com,
        gost.dev@samsung.com, mcgrof@kernel.org,
        Nitesh Shetty <nj.shetty@samsung.com>,
        Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v17 10/12] dm: Enable copy offload for dm-linear target
Date:   Thu, 19 Oct 2023 16:31:38 +0530
Message-Id: <20231019110147.31672-11-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20231019110147.31672-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TbUxTZxTOe+/tpTA7LkXDuzI2UkIIMqDdKHtBkE0N3o39wGjcQia1gbtC
        gLZry1CYAQRkIF9zGKHyUTrCVwk4vkYZzK6oSBkjzg8GypymZEwQFSawEexais5/z3lynnOe
        c04OG+dWOvHYyTI1o5RJUvmkC9E37O8XuN9TyAiqSr1Qp/kKjp48XSeQfqacRPPDSwBZjIUA
        aXW1BJoyGjA0qDuDoVb9ZQydMd0CaPamBkND0wGo4VQjgQaHRgl0faCGRPVNs07o9GQ/iZpH
        nmHot4pZgPotuQD1rdfjqGP+EYGuTnuiiY0R1nuQNmhmnOiJ378j6Ovj6XRXWxFJdzdm03Pd
        1YD+YSqHpL8t+4ZFl+YtkvST2WmCfvTjTZIu62kDdPdYFr3c9QbdZXmIxbrGpUQkMZJERunN
        yBLkickyaSQ/5qB4r1gUKhAGCsPQu3xvmSSNieTv+yg2MDo51bYIvvcXktR0GxUrUan4wbsj
        lPJ0NeOdJFepI/mMIjFVEaIIUknSVOkyaZCMUYcLBYK3RbbEoylJxjkjpuhgHau6XQlygJEo
        Bs5sSIXAqSIdXgxc2FxqEMCKxzOkI1gCcPmXSSdHsAJg842NFxKL9Y8tyRCAs6W3tyQFGLxb
        +DOrGLDZJBUAx6xsO7+dKsDhxTsLwB7g1D8YzGu5Cuyl3Kn9MH+mhGXHBOUL7zdaN3kOtQuO
        fV+L2QtBKhiW33Wz0842+sJpu1l7ihscrbZsOsKpN2Fe7/lNR5DSO8P7q4PAYXUfPLVkZTmw
        O3ww0uPkwDy4vDhEOnAGbK1sIR3ifAA1k5otcRQsMJfjdhM45Q87B4IdtBc8a+7AHI1fhaXr
        FszBc2B/3XPsA9s7tVv1X4O3VnO3MA2rSoc3MZcqA/DG0NEK4K15aR7NS/No/u+sBXgb4DEK
        VZqUSRAphIEyJuPFnRPkaV1g8z12xvYD/YWNIBPA2MAEIBvnb+f40gKGy0mUHM9klHKxMj2V
        UZmAyLbwr3HejgS57b9karEwJEwQEhoaGhL2TqiQ78GZL6hN5FJSiZpJYRgFo3yuw9jOvBzs
        EHciO0P/qSE7qy7G75iXci36r5gDqmHyUkmtVdvk+2vhiHvv5x2cPZJtH8rCORlGLjvwpIvJ
        z2fxMTfF5P9Wy0ZmvO4OIaZETbvChZl8M+ve3uiEj+PjelbMTWZxU6f24EbvqvuVBUNVciN7
        1NX4yQms9eHc8eoaGefSWT1Hu5r1tLnKZ/ya8eI5a+SXnz3R/3To/J+GcsOBQt7lgC6xV11W
        t8+Jf3cfznnfkxvh6tI3phtjxRj8pP7THq7SyoYMt3H52gcP/s5vcdu2wlmr6Y4Slew5Eufc
        fu31IknEEdXAyCtZ55KfxS98pWPMuYdPRjVme3iT9+oLfdsbanZE9LXwCVWSRLgTV6ok/wFO
        aP8OpwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02RfUzMcRzH9/39fvfr123Hr8N8i3VzZiiuwvSdh8rD5rsR1kyeJqe+q6au
        3PXkOUJzyZ0Uitx1JVwoVxJOOycP5w7zEMryeEdzKnkeq7hi89/78369Pw/bh6PFNsaPS1Sk
        EaVCniRlhUz9Nan/xB2DQkjwseOTUfXtGzTq/vqLQVVtGha5r30CyGnJBUhvKGVQi+UihcyG
        AgqdqrpOoQLrY4BczSUUutIaiMp2VzDIfMXGoIeXjrJIV+nyQnlPGlh04mYvhZ5qXQA1OLcD
        VP9LR6Oz7i4G3Wodge713BREQHyxpM0L33t+jsEP76Rjk3EPi2srtuH22mKAL7dks7h83wEB
        zs/pZHG3q5XBXY3NLN5XZwS41r4Jfzb5Y5Ozg1o8eIVwRhxJSswgyqCwNcIES7uFSj0ryDr8
        rBBkAwujBt4c5KdAZ99LWg2EnJi/DGDjrg/0APCFlT1Nf/UQeKr3nddAKIeCTXoHqwYcx/KB
        0N7HefyhvIaGnT2HKE9B87k0tL93U57uIfw8uLNtr8CjGX4MfF3RBzxaxE+H9gullGcQ5IOg
        5oWPx/b+Y9fkGfoXi/lp8KX+jddA3Afaip39V9O8BOacP0JrAV/yHyr5D+kBZQS+JFWVHJ+s
        CkmdpCCZMpU8WZWuiJfFpiSbQP+3AwIagNn4UWYFFAesAHK0dKhoDA4mYlGcfMNGokyJUaYn
        EZUVjOAY6XDRN3d+nJiPl6eRdYSkEuU/SnHeftlUZLtk+s93b0ur1iR+jsoaVV5Aolt5q8qY
        FT7BbLz9KO2OYsPJtK2hwqIM0e4ZY4OQTSeRTiq7/wrPMo97Ejl7ap1T+jUsAZ0ZPWyR/uqe
        WTsKHQn+HcvIhY5nhnUv3JqluTXRgvrMmJj5Mx8Ri7ZoyYL98dmxd+sekHRhUsaXExmXJr6d
        6z3tWFyjpDtvTrgsczDwWXjGb1RMuV17TlcZJLE54I+Pc8aGH+ydLRObPqkXzq+eF+WInLky
        5EdgxOn1VdpITWiUw652vmp57bvZFNUi1o3ftXzkWlRzpHPLMk1ORH5h86qDYZzcUF2YlxLb
        uzr/fe74va7gD12hxU3fsVTKqBLkIQG0UiX/DageFnZcAwAA
X-CMS-MailID: 20231019110954epcas5p132f1188382b57c5e6cd071e52100b60f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231019110954epcas5p132f1188382b57c5e6cd071e52100b60f
References: <20231019110147.31672-1-nj.shetty@samsung.com>
        <CGME20231019110954epcas5p132f1188382b57c5e6cd071e52100b60f@epcas5p1.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setting copy_offload_supported flag to enable offload.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
---
 drivers/md/dm-linear.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
index f4448d520ee9..1d1ee30bbefb 100644
--- a/drivers/md/dm-linear.c
+++ b/drivers/md/dm-linear.c
@@ -62,6 +62,7 @@ static int linear_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	ti->num_discard_bios = 1;
 	ti->num_secure_erase_bios = 1;
 	ti->num_write_zeroes_bios = 1;
+	ti->copy_offload_supported = 1;
 	ti->private = lc;
 	return 0;
 
-- 
2.35.1.500.gb896f729e2

