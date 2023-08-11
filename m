Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B658F778BE3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 12:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234802AbjHKKVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 06:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236009AbjHKKUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 06:20:52 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA88358D
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 03:20:15 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230811102012epoutp02e4908c47638cdc461dea77edb85159d6~6TPIJyEwm1300113001epoutp02L
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 10:20:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230811102012epoutp02e4908c47638cdc461dea77edb85159d6~6TPIJyEwm1300113001epoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1691749212;
        bh=xK/C7pUY7BW9RDauehwRtOOiTo7CY+gR9Le8RVIUu3s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DZShAyYLaGjOULeCqVTvw2ApgvU2iGxQYp+JwhfHnvehcX3W6jdJIhw/QzLw+lavt
         1t+bawtRERYg5CG5y/gkU6XMFZ22T4IK9rPYuGEaDnafmwa+UymOFeeyRcTAoDqhu/
         xr5gvH61YfBPVkjHJjQcxX6deW9qgc/F6am0V6+8=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230811102011epcas5p1d0d254fa923b448056dec3be86abc4e3~6TPHiAaxy1165811658epcas5p1d;
        Fri, 11 Aug 2023 10:20:11 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4RMftd3QmCz4x9Pp; Fri, 11 Aug
        2023 10:20:09 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        69.64.55522.75B06D46; Fri, 11 Aug 2023 19:20:07 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20230811101911epcas5p1b090eea2adf03e143ef6445a32278295~6TOP1JgK83174731747epcas5p1W;
        Fri, 11 Aug 2023 10:19:11 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230811101911epsmtrp2b48ee5d82b57624a0a828e34c67d3fbe~6TOP0h7540365303653epsmtrp2j;
        Fri, 11 Aug 2023 10:19:11 +0000 (GMT)
X-AuditID: b6c32a49-c94d0a800000d8e2-73-64d60b577678
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        AD.C1.64355.F1B06D46; Fri, 11 Aug 2023 19:19:11 +0900 (KST)
Received: from unvme-desktop.sa.corp.samsungelectronics.net (unknown
        [107.99.41.39]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230811101910epsmtip1f01b7e9c16cbbd33c13623f8dcdb5259~6TOOj2UvX1729217292epsmtip1Z;
        Fri, 11 Aug 2023 10:19:10 +0000 (GMT)
From:   Ankit Kumar <ankit.kumar@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Keith Busch <kbusch@kernel.org>
Cc:     gost.dev@samsung.com, Ankit Kumar <ankit.kumar@samsung.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] block:t10-pi: remove redundant Type2 check during t10
 PI verify
Date:   Fri, 11 Aug 2023 21:03:12 +0530
Message-Id: <20230811153313.93786-2-ankit.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230811153313.93786-1-ankit.kumar@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplk+LIzCtJLcpLzFFi42LZdlhTSzec+1qKwa8DWhZrrvxmt1h9t5/N
        4uaBnUwWkw5dY7TYe0vb4vKuOWwWy4//Y3Jg97h8ttRj06pONo+PT2+xePRtWcXo8XmTXABr
        VLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2Si0+ArltmDtARSgpl
        iTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwCkwK94sTc4tK8dL281BIrQwMDI1OgwoTs
        jKWHnjMW3GWtOPP3NGsD40WWLkYODgkBE4mn7+u7GLk4hAR2M0rM/bebCcL5xChxrGUqI5yz
        bNJ8oA5OsI5bLydDJXYySuxas4wNwulkkph9rpMdpIpNQFvi1dsbzCC2iECZxJuHO8FsZoEa
        ic57s5hAbGGBMIlvB58wg9zBIqAq0fgULMwrYCNxZOZmRohl8hIzL30HG8kpYCsx9ccbRoga
        QYmTM5+wQIyUl2jeOpsZ5AYJgUfsEu3fp7NDNLtITDg6lQ3CFpZ4dXwLVFxK4vO7vVDxbIlN
        D38yQdgFEkde9DJD2PYSraf6wW5jFtCUWL9LHyIsKzH11DomiL18Er2/n0C18krsmAdjq0r8
        vXcbGljSEjffXYWyPSQm374LDbgJjBJ/ev8wTmBUmIXkn1lI/pmFsHoBI/MqRsnUguLc9NRi
        0wLDvNRyeCQn5+duYgSnSy3PHYx3H3zQO8TIxMF4iFGCg1lJhNc2+FKKEG9KYmVValF+fFFp
        TmrxIUZTYHhPZJYSTc4HJuy8knhDE0sDEzMzMxNLYzNDJXHe161zU4QE0hNLUrNTUwtSi2D6
        mDg4pRqYwh+lbXBfeVhq5idtaXsttk3291nEFL82n1539Mfjgw5qGz5/EdGTn2jLLBOm6d6Y
        F6W9+EB5RfiuleFMFgmL3j4WNX6f4T5ljuiOJDWL1f0zvtf2vH3RI6DotPXf4r7Eg5XLTSV1
        4v2ehfxs7rRPt2O8aWfLEvuEW/j5jcWTXl7gP15VJHV8Jp9F++1YnvVNj/XKj51eWcSr9uTe
        h+Q7kzLUNH0Ov+pUPOBfLLfZLvHVzg2J4Yn7hCO35DOumKVZGWBxa9Psc1d226/LmbxtV77H
        pF1vZj/2vLfpx/fv/h+nf2DYefVK/W5xfb2TL2ba7WqeyvG8a1a6fFv5pmTb4CMabw+LnymV
        /BvzKXjNdCWW4oxEQy3mouJEANLxKJ0gBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrALMWRmVeSWpSXmKPExsWy7bCSnK4897UUg303TC3WXPnNbrH6bj+b
        xc0DO5ksJh26xmix95a2xeVdc9gslh//x+TA7nH5bKnHplWdbB4fn95i8ejbsorR4/MmuQDW
        KC6blNSczLLUIn27BK6MpYeeMxbcZa048/c0awPjRZYuRk4OCQETiVsvJzN2MXJxCAlsZ5R4
        vGwxcxcjB1BCWmLh+kSIGmGJlf+es0PUtDNJzP97lw0kwSagLfHq7Q1mEFtEoEJizqelrCBF
        zAINjBJTPveBJYQFQiQebu5mBRnKIqAq0fiUCSTMK2AjcWTmZkaIBfISMy99ZwexOQVsJab+
        eAMWFwKqObrqChtEvaDEyZlPwI5mBqpv3jqbeQKjwCwkqVlIUgsYmVYxiqYWFOem5yYXGOoV
        J+YWl+al6yXn525iBAeyVtAOxmXr/+odYmTiYDzEKMHBrCTCaxt8KUWINyWxsiq1KD++qDQn
        tfgQozQHi5I4r3JOZ4qQQHpiSWp2ampBahFMlomDU6qBqZNvFn988yu2SaL9hj3zK69fc4+y
        /r/asuGYwu4rOVJNq7MW5/nbLLBhVr4hFruwjavprMXnB628Tf1ZB7x9PJ4ZcLXdNF7v2PP1
        spvktOKvNyWnBnkoGYiybnN7ZqidaK16/8dJs1hPg85jXaplN/wOb1OL7hT425zLo3ej5InD
        nCnb94iGi3pfz6hTmp3G5OYb42XHFSYj8i7k/cY3tpYse5Itqsv0otlKD7tOO5nB7mK3ZWp4
        RaA401fD0CUBp94t3H38mbJ23zruc5WTFjueE7zZNFd009SuPqdDv95blUvMk+ms4eYLtHJP
        +7WAKXhxzEvTnOps6SVce3LKp53pXr9/Y/DKs01v7yqxFGckGmoxFxUnAgAbTiVg0wIAAA==
X-CMS-MailID: 20230811101911epcas5p1b090eea2adf03e143ef6445a32278295
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230811101911epcas5p1b090eea2adf03e143ef6445a32278295
References: <20230811153313.93786-1-ankit.kumar@samsung.com>
        <CGME20230811101911epcas5p1b090eea2adf03e143ef6445a32278295@epcas5p1.samsung.com>
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T10_PI_TYPE2_PROTECTION is neither used to generate nor verify
crc and ip. Remove this redundant check.

Signed-off-by: Ankit Kumar <ankit.kumar@samsung.com>
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

