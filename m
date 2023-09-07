Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAE2796F51
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 05:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236212AbjIGDjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 23:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjIGDjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 23:39:24 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CD6CA
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 20:39:18 -0700 (PDT)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230907033915epoutp02b8811b327ec6ce501f5daeb461985093~CgLxBhvHV1995019950epoutp02d
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 03:39:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230907033915epoutp02b8811b327ec6ce501f5daeb461985093~CgLxBhvHV1995019950epoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1694057955;
        bh=t6O+sJV1CtCCVqO0k7CtCzBiHCIGrrRUSroD6WVLr+A=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=TROmi+Y03W8aIL+v7pMlrIrfSsDvOCZi6Yl/4KAcf6kYPDg/GR+6cYF1bcxRKt1NG
         w3WVflr1nH0Kt3tfzWlLjmFSBDzafJHuYy2wOhMfFIoGg2lR0ekTIfNbpsMTvKz1Zf
         Uyzk/iSBKlmKZIJYBGCMDEQhXBs4uT3SIJeZU0KI=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230907033915epcas1p16d8a604545c2129f6601035750634685~CgLw1BmJG2828928289epcas1p1X;
        Thu,  7 Sep 2023 03:39:15 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.38.249]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Rh4jb28vsz4x9Pp; Thu,  7 Sep
        2023 03:39:15 +0000 (GMT)
X-AuditID: b6c32a33-749fa700000021d1-34-64f945e365a5
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        0E.E9.08657.3E549F46; Thu,  7 Sep 2023 12:39:15 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH] maple_tree: use GFP_KERNEL on mas_node_count
Reply-To: jason.sim@samsung.com
Sender: =?UTF-8?B?7Ius7J6s7ISg?= <jason.sim@samsung.com>
From:   =?UTF-8?B?7Ius7J6s7ISg?= <jason.sim@samsung.com>
To:     "liam.howlett@oracle.com" <liam.howlett@oracle.com>
CC:     "surenb@google.com" <surenb@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230907033914epcms1p61c5eed4d34d5c4212436c201f33292b3@epcms1p6>
Date:   Thu, 07 Sep 2023 12:39:14 +0900
X-CMS-MailID: 20230907033914epcms1p61c5eed4d34d5c4212436c201f33292b3
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCKsWRmVeSWpSXmKPExsWy7bCmru5j158pBrf28Ft0b57JaLG94QG7
        xeVdc9gs7q35z2qxYWUDk8XkSwvYHNg8ds66y+6xYFOpx6ZPk9g9Ni+p9/j49BaLx+dNcgFs
        Udk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUBHKCmU
        JeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIKzAr0ihNzi0vz0vXyUkusDA0MjEyBChOy
        M6bfOcNU8JWjovXjMvYGxknsXYycHBICJhKtG3uYQWwhgR2MEo+35HcxcnDwCghK/N0hDBIW
        FrCV2Ll4ChtEibzE2S0NjBBxC4muV8+ZQGw2ATOJCQsXMYK0igiYS7w8JQ8SZhaYzCRx5lQm
        xCZeiRntT1kgbGmJ7cu3MkLYohI3V79lh7HfH5sPFReRaL13lhnCFpR48HM3VFxK4kzbEqg5
        xRLr11xngrBrJI4+2Q8VN5doeLsS7GReAV+JFXuvgs1nEVCVOPHyBytEjYvEoyXnGSHulJfY
        /nYOM8j5zAKaEut36UOUKErs/D0XqoRP4t3XHlaYV3bMewK1Vlni47cLYJ9LCEhKTNhlDmF6
        SHT8NoGEWaDEhUMrmCYwys9ChOwsJGtnIaxdwMi8ilEstaA4Nz012bDAEB6Xyfm5mxjByU/L
        eAfj5fn/9A4xMnEwHmKU4GBWEuF9J/8tRYg3JbGyKrUoP76oNCe1+BCjKdDDE5mlRJPzgek3
        ryTe0MTSwMTMyMTC2NLYTEmcV3HC7BQhgfTEktTs1NSC1CKYPiYOTqkGppSuV5zMVrFqE+c2
        t61aI7ZSkSNpsqnf7tYOeZYGb3ul1mtax3+adyspyWjNZ3shayKT3dHKkriiLmRKwvwTZ5+L
        Pp/tfy3d66Pe3jqLytCPLkpTFmTuLU+9yrylYveJQ8umnr9U/vDdnCNqcbO/rzNJ1naN/u9f
        qZjY8MtEJPy5ytFFF4Njkk9c+Sd7ybuMxyc7h13+zJJjwcwfg1dEPRKOvpWeXLstf9ZeN/t/
        gXydmU8NhH7qvj0lcsi+n0Vxy7SHinaKSnUmjXMauzUrLyfybtv0+Njdw/NWRW2/8KrW53Iy
        S8JRwai5Zzdey2EpbMiqYV/7eanzntCrf33kLwTG391Uf2bpjKyykhYNJZbijERDLeai4kQA
        G//BKwcEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230907033914epcms1p61c5eed4d34d5c4212436c201f33292b3
References: <CGME20230907033914epcms1p61c5eed4d34d5c4212436c201f33292b3@epcms1p6>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use GFP_KERNEL on mas_node_count instead of GFP_NOWAIT | __GFP_NOWARN
in order to allow memory reclaim.

Currently, fork errors occur on low free memory as follows:

 Zygote  : Failed to fork child process: Out of memory (12)

-ENOMEM was returned as following path:

 mas_node_count
 mas_expected_entries
 dup_mmap
 dup_mm
 copy_mm
 copy_process

Signed-off-by: jason.sim <jason.sim@samsung.com>
---
 lib/maple_tree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index ee1ff0c59fd7..076798f83baa 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -1336,11 +1336,11 @@ static void mas_node_count_gfp(struct ma_state *mas, int count, gfp_t gfp)
  * @mas: The maple state
  * @count: The number of nodes needed
  *
- * Note: Uses GFP_NOWAIT | __GFP_NOWARN for gfp flags.
+ * Note: Uses GFP_KERNEL for gfp flags.
  */
 static void mas_node_count(struct ma_state *mas, int count)
 {
-       return mas_node_count_gfp(mas, count, GFP_NOWAIT | __GFP_NOWARN);
+       return mas_node_count_gfp(mas, count, GFP_KERNEL);
 }
 
 /*
-- 
2.17.1
