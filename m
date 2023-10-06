Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72CE57BB867
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 15:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbjJFNB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 09:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232392AbjJFNBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 09:01:09 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551F9171C
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 06:00:36 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20231006130033euoutp01f76182ac1e656c4bb5daa1cb9662d082~LhjHdwfBy3271732717euoutp01e
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 13:00:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20231006130033euoutp01f76182ac1e656c4bb5daa1cb9662d082~LhjHdwfBy3271732717euoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1696597233;
        bh=yMIQ2PYZ0kLOnFppm+QOgiVTZ3gELpCwexB+P4HZV9Q=;
        h=From:To:Cc:Subject:Date:References:From;
        b=bI83gpthaxVbs9/Jqm+MJQdCdNWT0ISzvPZ/rF1NtxgHfvaK7WdtQtQ5vczbnQuEd
         TmGJ0W7bdTbzm6CsYxB28Kugss9kUv3Fe8FkaJjRBuUvfO/7m4nrIBkM+aDhFAG1es
         rMpSjMN6IdR+Kw+YQfZ2Rv+lAvdNKr5EqzSmPNF0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20231006130032eucas1p23c52d6b50a6384c50e5c0e4061bbaf3b~LhjHHKA9s3165431654eucas1p2n;
        Fri,  6 Oct 2023 13:00:32 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id C8.4A.42423.0F400256; Fri,  6
        Oct 2023 14:00:32 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20231006130032eucas1p18c6f5c39614768911730fa6ed0201ee3~LhjGq_j_v3011630116eucas1p1l;
        Fri,  6 Oct 2023 13:00:32 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231006130032eusmtrp1c043748a9e569b00072a6619a276d8c4~LhjGqXn_z3155531555eusmtrp1l;
        Fri,  6 Oct 2023 13:00:32 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-2b-652004f02a45
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id C5.AA.25043.0F400256; Fri,  6
        Oct 2023 14:00:32 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
        [106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231006130031eusmtip2d39c030222cb278c8c6958b14326d884~LhjF---HQ2114821148eusmtip2e;
        Fri,  6 Oct 2023 13:00:31 +0000 (GMT)
From:   Mateusz Majewski <m.majewski2@samsung.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mateusz Majewski <m.majewski2@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 0/4] Fix Samsung pinctrl driver static allocation of GPIO
 base warning
Date:   Fri,  6 Oct 2023 14:55:53 +0200
Message-ID: <20231006125557.212681-1-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf0yMcRzH932eu3ue4vJ0ZfehyMptmHIlPFRiQ7dsTdrMItzqcaW6co9T
        GD1UKPlx7pSuIkQcLUq33NImXEsNYbeb1JKY1VkqZrZbuevJ+O/1eX/en1/bh8Ql14RzyTT1
        AUajVmYEijwFZuvvl8HfBQsYOadbTfdfMYvox8NNBG1w1mJ0wyebkG686kT0W0uliL78qhWj
        dVY9Ttc96yXop45TQtpkcaJ1MxSPjL2E4oOtRaRorMlTnHtoQorxhvlbhImekSlMRtpBRrNs
        7R7P1BeXLES2RZRr6NNhHLotLEYeJFDh8Lrb7mJPUkLdRjBWbRPwwQ8ELbVWER+MIxiorhL9
        LXEYPyE+UYtg8qxu2lWIQY9VT7hdIkoO/Y5bhDvhS51CUPL+/VQJTrVioH/QPTXeh9oODfnF
        uJsFlAy+9NzF3CymosB0xiHg5wVAy/Vf07o3dJQPTum4S89vqsB5TzMJRpsPzxtgstyAePaB
        ofaHBM/+0Kkvme6ZBZcbR1xMujgXep/E8hgBo124G3FqMdRblvHqeigeXcWjF9i/efPjveCi
        uQznZTGcPinhO8ugveXi9FZ+MFjQg/GsgPsdJ4Ruu4RKgnxHygW0wPjfTcb/bjL+26Aa4SYk
        ZbRspophQ9VMTgirzGS1alVIclZmA3J9UedE+1gzqhoaDWlDGInaEJB4oK9YxfkzEnGK8tBh
        RpO1W6PNYNg25EcKAqViWUoAI6FUygNMOsNkM5q/WYz0mMthik3SVex2Q8e+LTfs8UVXj2SX
        pUnpW6NRYSM7S1LL434eaR5e+saeM1RELT2qZ6trKr3Kkp7rZqukxfLD4pzNGJZcYeKKIu0r
        ZqrSFw4fT1rukPadSToPmCxswFEYvbBi/y7f8PTk1fXRlV9y4mP3vboStOZjUMImZxCZ6eX8
        Gh42Z40M616pLh2s7HsXk7BoovSjsNGH2DypLdz1jc3VbJy4FMaEdmFj8cT497io4x7PzBrf
        wTs19yT1I5x571CQLffGyei42Z3BtnMRhnkTVccKrLata2kusc4vLyCmLZjzG4gxyS3bKuQ3
        67t2FKRz/We1AtXnbNnyWV+z3tgCBWyqMnQJrmGVfwAWmLcptAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNLMWRmVeSWpSXmKPExsVy+t/xe7ofWBRSDb51iVs8mLeNzWLv663s
        FlP+LGey2PT4GqvF5vl/GC0u75rDZjHj/D4mi4nHJjNbrD1yl93i8Jt2VotVu/4wOnB77Jx1
        l93jzrU9bB6bl9R79G1ZxejxeZNcAGuUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5
        rJWRqZK+nU1Kak5mWWqRvl2CXsapqbvYC3axVUy5N5GpgXEFaxcjJ4eEgInEm1mPGUFsIYGl
        jBK/d/JBxKUlDn+Zwg5hC0v8udbF1sXIBVTTzCQx6edssASbgIHEgzfLwGwRgW5GiW8TuUCK
        mAUOMEksmXWQDSQhLBAm8eHUDjCbRUBV4tnt1UwgNq+ArcSq7jcsEBvkJfYs+g4VF5Q4OfMJ
        WJwZKN68dTbzBEa+WUhSs5CkFjAyrWIUSS0tzk3PLTbSK07MLS7NS9dLzs/dxAiMhW3Hfm7Z
        wbjy1Ue9Q4xMHIyHGCU4mJVEeNMbZFKFeFMSK6tSi/Lji0pzUosPMZoC3TeRWUo0OR8YjXkl
        8YZmBqaGJmaWBqaWZsZK4ryeBR2JQgLpiSWp2ampBalFMH1MHJxSDUz5Gr1XD1bzN/lvkWl6
        PHNaUrrdh7c2PtP7xY5Lb4ivTOURfHjyo3pO1vT++vpokdsMwV0Zh2Z9SRFof8EmpeTWV7DE
        3Ixp7o+pM5qy1k2dPvVC8ALp8MRH/G9r/tr7CbRNTlz9xMyq+Eb8lbme8eEnayTkbb4tdS2P
        achdLJpUOU/Y45KD678jXo+vJzTaWv3NK5eM0SzRi8t/yaUQlfJeKufNwUTT5f+fzdUsUP6S
        vS5mTxn77j8utXOO97jkrtSJ6G97+3x779w/lz3+3PlurJCu4yjYtTiQz2TtpLJq2e/hx94K
        +jZq8ibv29zKM19mqscc8WVhvEz1575wFV9v+NbHKZeoXGoX/MRBiaU4I9FQi7moOBEAFUD+
        TQ4DAAA=
X-CMS-MailID: 20231006130032eucas1p18c6f5c39614768911730fa6ed0201ee3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20231006130032eucas1p18c6f5c39614768911730fa6ed0201ee3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231006130032eucas1p18c6f5c39614768911730fa6ed0201ee3
References: <CGME20231006130032eucas1p18c6f5c39614768911730fa6ed0201ee3@eucas1p1.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The object of this work is fixing the following warning, which appears
on all targets using that driver:

gpio gpiochip0: Static allocation of GPIO base is deprecated, use dynamic allocation.

This needs a small refactor to how we interact with the pinctrl
subsystem. Finally, we remove some bookkeeping that has only been
necessary to allocate GPIO bases correctly.

Mateusz Majewski (4):
  pinctrl: samsung: defer pinctrl_enable
  pinctrl: samsung: use add_pin_ranges method to add pinctrl ranges
  pinctrl: samsung: choose GPIO numberspace base dynamically
  pinctrl: samsung: do not offset pinctrl numberspaces

 drivers/pinctrl/samsung/pinctrl-samsung.c | 56 ++++++++++++-----------
 drivers/pinctrl/samsung/pinctrl-samsung.h |  4 +-
 2 files changed, 31 insertions(+), 29 deletions(-)

-- 
2.42.0

