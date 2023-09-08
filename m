Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE09798354
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 09:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239486AbjIHHle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 03:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237344AbjIHHl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 03:41:29 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748A01990
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 00:41:24 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230908074122epoutp024490f2ba44eb562dca623988b6a7c5f8~C3IcJZlwz1142311423epoutp02o
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 07:41:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230908074122epoutp024490f2ba44eb562dca623988b6a7c5f8~C3IcJZlwz1142311423epoutp02o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1694158882;
        bh=5nnYH4bzmD+WGjO/Clg8fuD1bDH4eamc7G31VCFfHEk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WObHQC+/A0adM4XXj6sLP7yIWYdE51gPMbqG7WP+YTmJNwf4yCmPakRDCTXVYkXUo
         5xY8dsP1UOIZ0IOYkfdh/Dp6PbaDc5l7mKh5xVe9fSpCstbLMM/gsJ5/L2e7EsvU4G
         j16vidHeJvmVv4skm4LPQ3gz2pVozS34wkf8E+Mo=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230908074122epcas5p1a485c69ad14ec0e66649dfeb9963cbe1~C3Ib3KuY10093400934epcas5p1d;
        Fri,  8 Sep 2023 07:41:22 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.180]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Rhp2S3MqVz4x9Pp; Fri,  8 Sep
        2023 07:41:20 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1D.FB.19094.020DAF46; Fri,  8 Sep 2023 16:41:20 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230908063510epcas5p46aa338154cc48041c5d28dbead88c97c~C2OpCj5ll2066220662epcas5p4U;
        Fri,  8 Sep 2023 06:35:10 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230908063510epsmtrp1ad977c9cbfd52b5399318c4f1c2d2f85~C2OpB2Ft12348123481epsmtrp1C;
        Fri,  8 Sep 2023 06:35:10 +0000 (GMT)
X-AuditID: b6c32a50-39fff70000004a96-4b-64fad0200151
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        78.1E.08788.E90CAF46; Fri,  8 Sep 2023 15:35:10 +0900 (KST)
Received: from unvme-desktop.sa.corp.samsungelectronics.net (unknown
        [107.99.41.39]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230908063509epsmtip1a0e61af5359bf1954bcbbacb17be6c72~C2On9_ip63145631456epsmtip1U;
        Fri,  8 Sep 2023 06:35:09 +0000 (GMT)
From:   Ankit Kumar <ankit.kumar@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Keith Busch <kbusch@kernel.org>
Cc:     gost.dev@samsung.com, Ankit Kumar <ankit.kumar@samsung.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] block:t10-pi: remove redundant Type2 check during
 t10 PI verify
Date:   Fri,  8 Sep 2023 17:22:30 +0530
Message-Id: <20230908115233.261195-2-ankit.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230908115233.261195-1-ankit.kumar@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAJsWRmVeSWpSXmKPExsWy7bCmlq7ChV8pBm/+S1qsufKb3WL13X42
        i5sHdjJZTDp0jdFi7y1ti8u75rBZLD/+j8mB3ePy2VKPTas62Tw+Pr3F4tG3ZRWjx+dNcgGs
        Udk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUBHKCmU
        JeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIKTAr0ihNzi0vz0vXyUkusDA0MjEyBChOy
        M042nmYs2MpW8bLpJ3MD4xzWLkZODgkBE4nDHZ+Yuhi5OIQE9jBKTN22gBXC+cQo8fz+RmYI
        5xujxO3Hv5lhWg7uamaESOxllGib0soG4XQySSyY950JpIpNQFvi1dsbYB0iAmUSbx7uBLOZ
        BWokOu/NAqsRFoiU2Nf5GcxmEVCVWLJxDQuIzStgK9Ez+yQ7xDZ5iZmXvoPZnAJ2Eg8XHWCD
        qBGUODnzCQvETHmJ5q2zwU6VEHjELtF8bhobRLOLRPe7G0wQtrDEq+NboIZKSbzsb4OysyU2
        PfwJVVMgceRFL9Sb9hKtp/qBbA6gBZoS63fpQ4RlJaaeWscEsZdPovf3E6hWXokd82BsVYm/
        926zQNjSEjffXYWyPSSeNC9mgQTWREaJ3+cmsUxgVJiF5J9ZSP6ZhbB6ASPzKkap1ILi3PTU
        ZNMCQ9281HJ4PCfn525iBCdNrYAdjKs3/NU7xMjEwXiIUYKDWUmEd7XIrxQh3pTEyqrUovz4
        otKc1OJDjKbAEJ/ILCWanA9M23kl8YYmlgYmZmZmJpbGZoZK4ryvW+emCAmkJ5akZqemFqQW
        wfQxcXBKNTAJRCi8X3gwM/yZvsJRi+7V3G45jXumiMyS4Xyi2n9qxY3LChIPrrL9yGP+Ftk9
        OZf7yOMHaf/Wh56ZNPOj24yd9f82/IzcEPF1212vv16Z/ZJia3YUaMbWTz1v90Hz6Nr3u8+8
        XiSnppilX7Qz8n7r8zLX1BeMGxveBW1QWpLKujxr7nk+AamcLEnlwztK3pzm3bxx5f7+386y
        U5WfXmQ1TKhevc1UuGnu9H0FB3covFH5sc0zpPRmEKvD1QvO05KVLE/Lyt7/xcllJGthu2+N
        Tgx3DaOa7ufXF5T3PXMNOZ4163zCD0HdWV0mu17anY45djm140Et22TbhOpwZ/bvBVEc7+Ja
        v152Yo4T/hGtxFKckWioxVxUnAgAVC2jbSMEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKLMWRmVeSWpSXmKPExsWy7bCSnO68A79SDM4ukbBYc+U3u8Xqu/1s
        FjcP7GSymHToGqPF3lvaFpd3zWGzWH78H5MDu8fls6Uem1Z1snl8fHqLxaNvyypGj8+b5AJY
        o7hsUlJzMstSi/TtErgyTjaeZizYylbxsukncwPjHNYuRk4OCQETiYO7mhm7GLk4hAR2M0r8
        2fIeKMEBlJCWWLg+EaJGWGLlv+fsEDXtTBI/NyxjBkmwCWhLvHp7A8wWEaiQmPNpKStIEbNA
        A6PElM99YAlhgXCJDwevsYHYLAKqEks2rmEBsXkFbCV6Zp9kh9ggLzHz0ncwm1PATuLhogNg
        9UJANe8vf2CEqBeUODnzCVgvM1B989bZzBMYBWYhSc1CklrAyLSKUTK1oDg3PbfYsMAoL7Vc
        rzgxt7g0L10vOT93EyM4pLW0djDuWfVB7xAjEwfjIUYJDmYlEd7VIr9ShHhTEiurUovy44tK
        c1KLDzFKc7AoifN+e92bIiSQnliSmp2aWpBaBJNl4uCUamDKUhRjW8HiHy87hSFjvt+0yQ/v
        dpn/Otm89M98tnU/GQuuv9/95eL6U/957dwOZtRte8T5im29ov1fvd2eD96wn9hsbmgU5sPm
        5LNlratoKrtbf7Pzmx67UheTh4FKhm3bN2k1aJ6WmHLeIDBy/QYJzdptLIvuTa4vFfYQkdtR
        tMRFJWyXyGKpn2uTZXaJtzeEbc/OfFsRcf5lhPX/Gd7sZw6Zzr3VvHnVfn3HCk6DgODPVfkH
        r2iLqTOE6B/92vu1X+vi860G0bbcqh+KdscuyP50cv03626/Vx9/x6yNVhFttTK/1ce26EhA
        a3GY+lyfi4pz3VakeHB0dXza1V3imCQSZnpagSfMyXOhvBJLcUaioRZzUXEiADhUEwjYAgAA
X-CMS-MailID: 20230908063510epcas5p46aa338154cc48041c5d28dbead88c97c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230908063510epcas5p46aa338154cc48041c5d28dbead88c97c
References: <20230908115233.261195-1-ankit.kumar@samsung.com>
        <CGME20230908063510epcas5p46aa338154cc48041c5d28dbead88c97c@epcas5p4.samsung.com>
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T10_PI_TYPE2_PROTECTION is neither used to generate nor verify
crc and ip. This remained since T10 PI code was moved out of SCSI.

Signed-off-by: Ankit Kumar <ankit.kumar@samsung.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 block/t10-pi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/t10-pi.c b/block/t10-pi.c
index 914d8cddd43a..bf0bba01417f 100644
--- a/block/t10-pi.c
+++ b/block/t10-pi.c
@@ -64,8 +64,7 @@ static blk_status_t t10_pi_verify(struct blk_integrity_iter *iter,
 		struct t10_pi_tuple *pi = iter->prot_buf;
 		__be16 csum;
 
-		if (type == T10_PI_TYPE1_PROTECTION ||
-		    type == T10_PI_TYPE2_PROTECTION) {
+		if (type == T10_PI_TYPE1_PROTECTION) {
 			if (pi->app_tag == T10_PI_APP_ESCAPE)
 				goto next;
 
-- 
2.25.1

