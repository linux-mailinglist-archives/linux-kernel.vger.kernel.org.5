Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E65197D2D02
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 10:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbjJWInL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 04:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbjJWInJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 04:43:09 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F94DD
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 01:43:05 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231023084302epoutp028369ef0a6fd42058b726ef8e8b779bda~QsAIWsq442559425594epoutp02j
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 08:43:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231023084302epoutp028369ef0a6fd42058b726ef8e8b779bda~QsAIWsq442559425594epoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1698050582;
        bh=HTJwEqe2gL+M6uZuKwI49ZiZ+DBMP7gSkZ2LxpURipU=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Hd0SUHr6wVX0Dois7KaMSgUBKsyKxJ8q0rQLT9jfy0KBk4N4i/+mFExdFkqqN+o7J
         L4e893gr+nPnc5oLDH60BWfalYUK4E2fxZfDTkFhwUCfkNS5+msAVRC6nYKA4hyCtQ
         6JxPnUQWJYtWOCuGxkwECSjCJG9eKmLMTLap6Rv8=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20231023084302epcas2p1525086f205cda4b707e9d5d8afba8ac2~QsAH826_52662426624epcas2p1U;
        Mon, 23 Oct 2023 08:43:02 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.99]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4SDTGs42wGz4x9Q6; Mon, 23 Oct
        2023 08:43:01 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        1A.A6.09607.51236356; Mon, 23 Oct 2023 17:43:01 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20231023084301epcas2p2de7cdc5cb6795d409a183aae43ce8c13~QsAHG-zXP1999019990epcas2p2l;
        Mon, 23 Oct 2023 08:43:01 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231023084301epsmtrp286dacf3e1b1a53d82a1b1f0f23d36aa8~QsAHGXSiX0893008930epsmtrp2c;
        Mon, 23 Oct 2023 08:43:01 +0000 (GMT)
X-AuditID: b6c32a48-bcdfd70000002587-d4-65363215ff17
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1E.72.08817.51236356; Mon, 23 Oct 2023 17:43:01 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.95.142]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20231023084300epsmtip1b2e9f35749e34d07523d745dff1ff595~QsAG6UvES1225612256epsmtip12;
        Mon, 23 Oct 2023 08:43:00 +0000 (GMT)
From:   Hyesoo Yu <hyesoo.yu@samsung.com>
Cc:     Hyesoo Yu <hyesoo.yu@samsung.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] mm: page_alloc: check the order of compound page even
 when the order is zero
Date:   Mon, 23 Oct 2023 17:32:16 +0900
Message-Id: <20231023083217.1866451-1-hyesoo.yu@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCKsWRmVeSWpSXmKPExsWy7bCmma6okVmqwdx3chZz1q9hs/jbeYHV
        4vKuOWwW99b8Z7VYv+8GqwOrx85Zd9k9Nn2axO5xYsZvFo++LasYPT5vkgtgjcq2yUhNTEkt
        UkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAFarqRQlphTChQKSCwu
        VtK3synKLy1JVcjILy6xVUotSMkpMC/QK07MLS7NS9fLSy2xMjQwMDIFKkzIzmjrXMFW0MFb
        0fPqFHsD42muLkZODgkBE4nmS0uYuxi5OIQEdjBK3DlymBXC+cQosfbtMTYI5xujxOsTy9m7
        GDnAWu7f1IaI72WUmHX5DxPIKCGBz4wSG98kgdhsAuoSJ7YsYwSxRQRYJFZ+/84C0sAssJZR
        YsuEfewgCWGBJIkvyz4xg9gsAqoSB7qnsoDYvAI2Eo/fr2WGuE9eYual7+wQcUGJkzOfgNUw
        A8Wbt84Gu1tC4Bi7xMTOZ1ANLhKtr3ayQtjCEq+Ob2GHsKUkPr/bywZhZ0vc/TgByi6RWHem
        AarGWGLWs3ZGkC+ZBTQl1u/Sh3hYWeLILai1fBIdh/9Cw4FXoqNNCKJRWWL/snksELakxKO1
        7VAHeEh8eXgNGjyxEkdXvGKcwCg/C8kzs5A8Mwth7wJG5lWMYqkFxbnpqcVGBSbwOE3Oz93E
        CE5+Wh47GGe//aB3iJGJg/EQowQHs5II7+xwk1Qh3pTEyqrUovz4otKc1OJDjKbA4J3ILCWa
        nA9Mv3kl8YYmlgYmZmaG5kamBuZK4rz3WuemCAmkJ5akZqemFqQWwfQxcXBKNTDJcW28UWx9
        ml3Mgd9KmFN5/QS5O9Pa30a4d/D2vTH7Mcnqa+Vcgb++kk1CgsJehiZPGvc1ScYwH7dt778U
        v73beIbXvv1pxb9lrl1Wstqx7oXU/MZzWttS6vf3Gy+fwOupOy2CoShac7v4Atu8Uz1GTzVa
        HGq27onwLbXicJF42/Hx6XzLju5V/lNqf0xxz3s7Q+Bic61W47XlrxZKX8vhdn6h0Xm1qzjh
        p+0jvf5ui+h8lbTLsqHeGySE7m2LSNVYUXvggPX/7by3fP02lv2wOGgm6PqgyfD5w/wLe+vf
        3vNPN7j0SOvGC+Hv4T3bTQpbTE3PLJ7wW+a6TJL57UtO+z9+/Be/IZN1YqzwTSWW4oxEQy3m
        ouJEAOrE7sMHBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKLMWRmVeSWpSXmKPExsWy7bCSnK6okVmqwf1vLBZz1q9hs/jbeYHV
        4vKuOWwW99b8Z7VYv+8GqwOrx85Zd9k9Nn2axO5xYsZvFo++LasYPT5vkgtgjeKySUnNySxL
        LdK3S+DKaOtcwVbQwVvR8+oUewPjaa4uRg4OCQETifs3tbsYuTiEBHYzSrR+u8/UxcgJFJeU
        mPX5JJQtLHG/5QgrRNFHRokd5xewgiTYBNQlTmxZxghiiwiwSKz8/p0FpIhZYCOjxJTjZ8G6
        hQUSJG5PeAFWxCKgKnGgeyoLiM0rYCPx+P1aZogN8hIzL31nh4gLSpyc+QSshhko3rx1NvME
        Rr5ZSFKzkKQWMDKtYpRMLSjOTc8tNiwwykst1ytOzC0uzUvXS87P3cQIDkktrR2Me1Z90DvE
        yMTBeIhRgoNZSYR3drhJqhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeb697U4QE0hNLUrNTUwtS
        i2CyTBycUg1MzgLl91hnFHmfjxbzWbrn4Sc+tY03Fu6U/zeRsf+U5G3nzfPM/29cGs6/yr7k
        0cZVjE1zP+RMeDhJh+Xful/5nA9XHZJbNdVt8Xl+sbAtNW7miuHaBytW+X35+c5VyT/UffeJ
        uHvyZudnTNc8cOVVXfjH4Bv+27IvsH07lCpwb+nRX+ftV8nnt10xWTW37bz8jI2JT0Ur355u
        jdmb/YR10qFD6vcjIjbslJa+2/JGf1fwwsePtkid60xYvkAx6vq64q8LG934FZ33hX/46Zq1
        tnzJ9CS9nKwFal8jpuzw0tIWWvFI5fCHiSnqG4tri5cu+Scaxslx4bfN9fkXY1wykrbITvz2
        lUXX+egDX0GVHdFKLMUZiYZazEXFiQCY7gK8uAIAAA==
X-CMS-MailID: 20231023084301epcas2p2de7cdc5cb6795d409a183aae43ce8c13
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231023084301epcas2p2de7cdc5cb6795d409a183aae43ce8c13
References: <CGME20231023084301epcas2p2de7cdc5cb6795d409a183aae43ce8c13@epcas2p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For compound pages, the head sets the PG_head flag and
the tail sets the compound_head to indicate the head page.
If a user allocates a compound page and frees it with a different
order, the compound page information will not be properly
initialized. To detect this problem, compound_order(page) and
the order argument are compared, but this is not checked
when the order argument is zero. That error should be checked
regardless of the order.

Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Signed-off-by: Hyesoo Yu <hyesoo.yu@samsung.com>
---
 mm/page_alloc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 95546f376302..fc92ac93c7c8 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1078,6 +1078,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
 	int bad = 0;
 	bool skip_kasan_poison = should_skip_kasan_poison(page, fpi_flags);
 	bool init = want_init_on_free();
+	bool compound = PageCompound(page);
 
 	VM_BUG_ON_PAGE(PageTail(page), page);
 
@@ -1096,16 +1097,15 @@ static __always_inline bool free_pages_prepare(struct page *page,
 		return false;
 	}
 
+	VM_BUG_ON_PAGE(compound && compound_order(page) != order, page);
+
 	/*
 	 * Check tail pages before head page information is cleared to
 	 * avoid checking PageCompound for order-0 pages.
 	 */
 	if (unlikely(order)) {
-		bool compound = PageCompound(page);
 		int i;
 
-		VM_BUG_ON_PAGE(compound && compound_order(page) != order, page);
-
 		if (compound)
 			page[1].flags &= ~PAGE_FLAGS_SECOND;
 		for (i = 1; i < (1 << order); i++) {
-- 
2.25.1

