Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D0F7A1A99
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbjIOJc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233639AbjIOJcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:32:54 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261C51700
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 02:32:48 -0700 (PDT)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230915093245epoutp02d611ad00e07b3fc6e84cb9f737edb979~FCKrwdgJD1893918939epoutp02a
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 09:32:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230915093245epoutp02d611ad00e07b3fc6e84cb9f737edb979~FCKrwdgJD1893918939epoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1694770365;
        bh=COEjL6Q2FTTuh/PxqldNTlUbNgf87Ec9vVPZAjMR5lw=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=RcSMVmBPujn38McZI6hBMffUYyX/I9QBhoa+n+pAhO8t7oraOSt7qwNruLTOPQKNw
         mmI3fAWuIVlpYMsgUiNyo/pfY1WwjMc43B6LSSmmWv6kU5pTa4n0LsSuKVi8jv3dY0
         42rjH5SiYxoy7QvA64RRCjYtvVpWuJqcowYjoGwM=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230915093244epcas1p20f0650b9993e8a19c7768bdfb4967e21~FCKrSEdP41302813028epcas1p2M;
        Fri, 15 Sep 2023 09:32:44 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.36.225]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Rn89m0zsqz4x9Px; Fri, 15 Sep
        2023 09:32:44 +0000 (GMT)
X-AuditID: b6c32a38-4dbf8700000027b3-8e-650424bcda69
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        2E.57.10163.CB424056; Fri, 15 Sep 2023 18:32:44 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v2] maple_tree: use mas_node_count_gfp on
 mas_expected_entries
Reply-To: jason.sim@samsung.com
Sender: Jaeseon Sim <jason.sim@samsung.com>
From:   Jaeseon Sim <jason.sim@samsung.com>
To:     "Liam.Howlett@Oracle.com" <Liam.Howlett@Oracle.com>
CC:     "willy@infradead.org" <willy@infradead.org>,
        "zhangpeng.00@bytedance.com" <zhangpeng.00@bytedance.com>,
        "surenb@google.com" <surenb@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        Jaewon Kim <jaewon31.kim@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230915093243epcms1p46fa00bbac1ab7b7dca94acb66c44c456@epcms1p4>
Date:   Fri, 15 Sep 2023 18:32:43 +0900
X-CMS-MailID: 20230915093243epcms1p46fa00bbac1ab7b7dca94acb66c44c456
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCJsWRmVeSWpSXmKPExsWy7bCmvu4eFZZUg1uXmS26N89ktOh9/4rJ
        YnvDA3aLy7vmsFncW/Of1WLDygYmi8mXFrBZ/P4BFHv65y+zA6fHvxNr2Dx2zrrL7rFgU6nH
        5hVaHps+TWL32Lyk3uPj01ssHn1bVjF6fN4kF8AZlW2TkZqYklqkkJqXnJ+SmZduq+QdHO8c
        b2pmYKhraGlhrqSQl5ibaqvk4hOg65aZA3ShkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRW
        KbUgJafArECvODG3uDQvXS8vtcTK0MDAyBSoMCE7o7Mvt+AAR8Xc3w1sDYw/2boYOTkkBEwk
        /nxuBLK5OIQEdjBKrGt9wNjFyMHBKyAo8XeHMEiNsECAxIGrq8HqhQTkJc5uaWCEiGtLnFp5
        kRnEZhPQlOi6sIUdxBYRMJd48vwAE8hMZoFlzBI/GrazQizjlZjR/pQFwpaW2L58KyOELSpx
        c/Vbdhj7/bH5UHERidZ7Z5khbEGJBz93Q8WlJM60LYGaUyyxfs11Jgi7RuLok/1QcXOJhrcr
        wY7mFfCVWP5rMdgNLAKqEm8XbYaa4yKxZ+UCsF5moMe2v53DDPI7M9Az63fpQ5QoSuz8PZcR
        ooRP4t3XHrhXdsx7ArVWWeLjtwvgYJMQkJSYsMscIuwhsat5Bwsk2AIlFv7sYpnAKD8LEbiz
        kOydhbB3ASPzKkax1ILi3PTUYsMCE3h0JufnbmIEJ08tix2Mc99+0DvEyMTBeIhRgoNZSYSX
        zZYpVYg3JbGyKrUoP76oNCe1+BCjKdDHE5mlRJPzgek7ryTe0MTSwMTMyMTC2NLYTEmc99ir
        3hQhgfTEktTs1NSC1CKYPiYOTqkGJpmU4m2OK4Tb+RZOm6IU+lr6yIZr55WDZOL1j+S52LIf
        M372n/3y8sN8bG8mhToeV2IXcz0ax+FhJTmBP+9r5cLcRRUMm+z364lmeEyau0rh35UMCZ/p
        p7UOqy/3ntL8+m/MNcdlj16VP37Zdu/k2n/zZErPaPQ2rXAJOM+fLO/UO/2Gx9HCN5zeaZLb
        fCV5RX30z1kus9iQrqJ9++5S+3kGxikzgyv2TGuvDDr6YP2j+0I1a9q9D2/M3drR82qxONuT
        zud7BOTavW++UuyO0c/Rjiy3+9c1Zee5qDdt7YEJxv52akln1HRvbRCOKngufthxxsMXy6pP
        Zcw7Ybh22i2Fdf7n72pW+3KYxdfLK7EUZyQaajEXFScCACP016MnBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230915093243epcms1p46fa00bbac1ab7b7dca94acb66c44c456
References: <CGME20230915093243epcms1p46fa00bbac1ab7b7dca94acb66c44c456@epcms1p4>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use mas_node_count_gfp with GFP_KERNEL instead of 
GFP_NOWAIT | __GFP_NOWARN on mas_expected_entries 
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

Signed-off-by: Jaeseon Sim <jason.sim@samsung.com>
---
 lib/maple_tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index ee1ff0c59fd7..b0229271c24e 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5574,7 +5574,7 @@ int mas_expected_entries(struct ma_state *mas, unsigned long nr_entries)
 	/* Internal nodes */
 	nr_nodes += DIV_ROUND_UP(nr_nodes, nonleaf_cap);
 	/* Add working room for split (2 nodes) + new parents */
-	mas_node_count(mas, nr_nodes + 3);
+	mas_node_count_gfp(mas, nr_nodes + 3, GFP_KERNEL);
 
 	/* Detect if allocations run out */
 	mas->mas_flags |= MA_STATE_PREALLOC;
-- 
2.17.1
