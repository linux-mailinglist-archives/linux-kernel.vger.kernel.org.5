Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF9F777586
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 12:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234957AbjHJJV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234899AbjHJJVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:21:41 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7AC4232
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:20:27 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230810092017euoutp011d9a381d9092dfee8366124c2e6c272e~5_xiIichd2589325893euoutp014
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 09:20:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230810092017euoutp011d9a381d9092dfee8366124c2e6c272e~5_xiIichd2589325893euoutp014
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1691659217;
        bh=QoClOrdI4RdByI00yXTFHg7j9E7DmiY7US96iwKAhaw=;
        h=From:To:Cc:Subject:Date:References:From;
        b=No8kffyMP8s/uzcC7VWFdYmmnTH7P0NcoRyPRUcGyT3Pu+rGmuo2IICzlkBn7yrQ+
         WAjAcVBOcOC1Wzg928NF7JJAA5LpCUZWhvtE3MBkPUctHbaUQ5iXA856BglecJ18zV
         FGED3UoqIgDgLO8PM/75FFiwmC7Eg+8XHkKIdxK4=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230810092017eucas1p18efdff903fca3c7dcc6d86863914493b~5_xh6JbFA3218732187eucas1p1d;
        Thu, 10 Aug 2023 09:20:17 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 41.CE.42423.1DBA4D46; Thu, 10
        Aug 2023 10:20:17 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230810092017eucas1p23930e5e5ec443ac7776002f2f09967d4~5_xhnoU-F2123221232eucas1p2n;
        Thu, 10 Aug 2023 09:20:17 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230810092017eusmtrp16964dd133a8fc6ce491f9c5b24516a77~5_xhmuQQl0594805948eusmtrp1s;
        Thu, 10 Aug 2023 09:20:17 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-4f-64d4abd1b7af
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 3B.9B.10549.1DBA4D46; Thu, 10
        Aug 2023 10:20:17 +0100 (BST)
Received: from AMDC4653.eu.corp.samsungelectronics.net (unknown
        [106.120.51.32]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230810092016eusmtip12c5ea43f9dd13ae1e5edbf6ed97f6bf3~5_xhHr2NS2978429784eusmtip1P;
        Thu, 10 Aug 2023 09:20:16 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Russell King <linux@armlinux.org.uk>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>
Subject: [PATCH] arm: dma-mapping: don't call folio_next() beyond the
 requested region
Date:   Thu, 10 Aug 2023 11:19:55 +0200
Message-Id: <20230810091955.3579004-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsWy7djPc7oXV19JMZiyW8Fizvo1bBabHl9j
        tbi8aw6bxaGpexkt1h65y25xZP12JovfP+awObB7XL52kdlj8wotj02rOtk8Tsz4zeKxeUm9
        R9+WVYwenzfJBbBHcdmkpOZklqUW6dslcGXsPMdSsJqtom/fGvYGxumsXYycHBICJhJ7Jp5g
        7mLk4hASWMEoseDlMTYI5wujxOxXjSwQzmdGiet7m+FaPl1eCdWynFFiw5kbLCAJIYFWJok3
        5xhBbDYBQ4mut11sILaIgJvEjcYOJpAGZoFrjBLbd01iBkkIC0RIrPn4gx3EZhFQlZj8/S1Y
        M6+AvcT+SfdZILbJS+w/eJYZIi4ocXLmE7A4M1C8eetssCskBFZySKw6vI8JosFFYsK6XYwQ
        trDEq+Nb2CFsGYnTk3tYIBragT79fZ8JwpnAKNHw/BZUh7XEnXO/gO7mAFqhKbF+lz5E2FFi
        18Y3YGEJAT6JG28FIY7gk5i0bTozRJhXoqNNCKJaTWLW8XVwaw9euMQMYXtIXPm6nB0SWLES
        yzpPMk5gVJiF5LVZSF6bhXDDAkbmVYziqaXFuempxYZ5qeV6xYm5xaV56XrJ+bmbGIHJ5/S/
        4592MM599VHvECMTB+MhRgkOZiURXtvgSylCvCmJlVWpRfnxRaU5qcWHGKU5WJTEebVtTyYL
        CaQnlqRmp6YWpBbBZJk4OKUamBTtnDaWGdyu/+9/SOp7YfvBzF16enV2i8+ocIn+K416F/NK
        ttrCfC2P9tFnV+L3qK6LmpuReP66sPGxJxLOyjvPv+z+tmul/4SVefGFOy/fPzlzvu38WO3j
        B01CmDsSYh9mz9kZ/J3n2obQlxHm+gt/f35//aPOe730Jm1OIavnT3teK3V/mR9VLlLBLu1o
        myx1SyRi2jGPqumZSsder8p5KbBJr/CKfNLKk1PtfNhj9pSpLUyYnzbl/IKsO6vYfNZ+bvtU
        UaR+6uLeEJk9AuzXl+gHP5X/cbbaQrdjxmP7d3fudvPss2P0nff661ah9U7JhXovI5o39/To
        /onrvXR5/gm/5dOvVDm7N2mdeqnEUpyRaKjFXFScCABFn4BErQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrALMWRmVeSWpSXmKPExsVy+t/xu7oXV19JMfj8mtNizvo1bBabHl9j
        tbi8aw6bxaGpexkt1h65y25xZP12JovfP+awObB7XL52kdlj8wotj02rOtk8Tsz4zeKxeUm9
        R9+WVYwenzfJBbBH6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp29mkpOZk
        lqUW6dsl6GXsPMdSsJqtom/fGvYGxumsXYycHBICJhKfLq9k7mLk4hASWMooceTgSyaIhIzE
        yWkNUEXCEn+udbFBFDUzSUy9up4NJMEmYCjR9bYLzBYR8JBo+3cPbBKzwC1GiQnb37GDJIQF
        wiQ+/HkINpVFQFVi8ve3jCA2r4C9xP5J91kgNshL7D94lhkiLihxcuYTsDgzULx562zmCYx8
        s5CkZiFJLWBkWsUoklpanJueW2yoV5yYW1yal66XnJ+7iREY9NuO/dy8g3Heq496hxiZOBgP
        MUpwMCuJ8NoGX0oR4k1JrKxKLcqPLyrNSS0+xGgKdN9EZinR5Hxg3OWVxBuaGZgamphZGpha
        mhkrifN6FnQkCgmkJ5akZqemFqQWwfQxcXBKNTBVmHRuN1HYtD/lRGexmZnk0uQZMnHHfkx/
        fc/0zSrrPfd+ejPua1+//5e1UcQryS+bzhjoRKYyNdk/uji/IfDcCzMG9WnTTuzRSVNKVpuz
        ZOI5sbX+1ofNcu5dvFAozzh/CuvLYE4zfacvR5//bygJSlunpRIrfUY+rUw/ZUf5ixrfJK0H
        k1cmb7tR5ie6MebYo6oGbdZ1113+hu6V7AgW6dc4t1fjo5Jb3IRLN7aKGu+dsNb5R//aPPsX
        d2epmGprfAhaUmg17YU6C2uVwt+2rYnMbhOvhJos+qiaaibP4ZdsutH5kml8r5lUx40ZkfeX
        hdYVy9lp8S2+ssYq3kdnx4PYo1s0ZJYuDxQ71KvEUpyRaKjFXFScCACv2/22AwMAAA==
X-CMS-MailID: 20230810092017eucas1p23930e5e5ec443ac7776002f2f09967d4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230810092017eucas1p23930e5e5ec443ac7776002f2f09967d4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230810092017eucas1p23930e5e5ec443ac7776002f2f09967d4
References: <CGME20230810092017eucas1p23930e5e5ec443ac7776002f2f09967d4@eucas1p2.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a check for the non-zero offset case to avoid calling folio_next()
beyond the requested region and relying on its parameters.

Fixes: cc24e9c0895c ("arm: implement the new page table range API")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Suggested-by: Matthew Wilcox <willy@infradead.org>
---
 arch/arm/mm/dma-mapping.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 0474840224d9..6c952d6899f2 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -715,6 +715,8 @@ static void __dma_page_dev_to_cpu(struct page *page, unsigned long off,
 
 		if (offset) {
 			left -= folio_size(folio) - offset;
+			if (left <= 0)
+				return;
 			folio = folio_next(folio);
 		}
 
-- 
2.34.1

