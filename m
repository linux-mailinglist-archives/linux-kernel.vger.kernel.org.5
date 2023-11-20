Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5457F1647
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 15:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233944AbjKTOwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 09:52:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233480AbjKTOvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 09:51:54 -0500
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF4110F2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 06:51:02 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20231120145058euoutp028d7f9841a0afec3f11188ef96825ba15~ZXFXs84og2495724957euoutp02N
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 14:50:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20231120145058euoutp028d7f9841a0afec3f11188ef96825ba15~ZXFXs84og2495724957euoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1700491858;
        bh=kWsxoLQNXYZ1sg/aFjeO2DmyiYG2CGJGIrMWlbQssos=;
        h=From:To:Cc:Subject:Date:References:From;
        b=sBXcqkjzFS+tJ4kQ5DXqArlNzHFfuU8lN61S1lgku27DNLXfqsTCsMqZwOAcTHkG4
         d58kwdtLJaerGSlZ3d3e8+vUUlhkJK/CadJwBB/z4SPL2A2G2P0zg9NoMOuK7+IyQ0
         8Xp8F1JMqbizg15V0C0vO5T8qooMwUvsZr6cmad0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20231120145057eucas1p28fcd91b9d36324a7ed5aaeb6e8732682~ZXFXPX2fG1152011520eucas1p2s;
        Mon, 20 Nov 2023 14:50:57 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id E4.37.09539.1527B556; Mon, 20
        Nov 2023 14:50:57 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20231120145057eucas1p2d3f7936d6a988d138af18e0011e7ad75~ZXFWp3QmW1152011520eucas1p2r;
        Mon, 20 Nov 2023 14:50:57 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231120145057eusmtrp232c8ff735899e1d7f795311f1994d531~ZXFWo-u0U0691806918eusmtrp2z;
        Mon, 20 Nov 2023 14:50:57 +0000 (GMT)
X-AuditID: cbfec7f2-52bff70000002543-3f-655b7251e0c2
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 8E.B3.09146.1527B556; Mon, 20
        Nov 2023 14:50:57 +0000 (GMT)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
        [106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231120145056eusmtip283cfcb2cc1784047a130724fc22843e0~ZXFVygwwk1014210142eusmtip2Z;
        Mon, 20 Nov 2023 14:50:56 +0000 (GMT)
From:   Mateusz Majewski <m.majewski2@samsung.com>
To:     linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Mateusz Majewski <m.majewski2@samsung.com>,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: [PATCH v5 0/9] Improve Exynos thermal driver
Date:   Mon, 20 Nov 2023 15:50:40 +0100
Message-ID: <20231120145049.310509-1-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKKsWRmVeSWpSXmKPExsWy7djPc7qBRdGpBvcuGVs8mLeNzeLw/AqL
        qQ+fsFl833KdyWLeZ1mLva+3slt8u9LBZLHp8TVWi8u75rBZfO49wmgx4/w+JouFTS3sFhOP
        TWa2WHvkLrvF3C9TmS2ePOxjcxDwWDNvDaPHzll32T0W73nJ5LFpVSebx51re9g8Ni+p9+jb
        sorR4/MmuQCOKC6blNSczLLUIn27BK6Mo/+vMRZM46+4veQaWwNjP08XIweHhICJxJa7Hl2M
        XBxCAisYJZZPXckG4XxhlNgzoZMJwvnMKPHsy1cghxOs4/imYywgtpDAckaJE/+cIIpamST+
        T3nLCJJgEzCQePBmGTuILSLQyigxs0kdpIhZ4CuzxNXX85lBdgsLmErsveQDUsMioCrR0rEY
        bAGvgK3Em/U9rBDL5CX2LPoOFReUODnzCdhiZqB489bZzCAzJQS+cEh0rToN1eAisfnzRBYI
        W1ji1fEt7BC2jMT/nfOhPsiXmLH5PQvE/xUSdw96QZjWEh/PgF3GLKApsX6XPkSxo8TKNxMZ
        ISr4JG68FYQ4gE9i0rbpzBBhXomONiGIalWJ43smMUPY0hJPWm5DrfSQ2LjpJTtIuZBArMS7
        tpoJjAqzkHw1C8lXsxBOWMDIvIpRPLW0ODc9tdgwL7Vcrzgxt7g0L10vOT93EyMwpZ3+d/zT
        Dsa5rz7qHWJk4mA8xCjBwawkwvtNKCJViDclsbIqtSg/vqg0J7X4EKM0B4uSOK9qinyqkEB6
        YklqdmpqQWoRTJaJg1OqgUmcI3De0oDEohrlv7cabz9oi7JNDF5Rqbr5vJ7WvsDizV+mn/c+
        Jn/udP12/oyIcy5icTv/GfzcP8/93qfQzHKlLKM7Dx/uish8I/pj07dHWz3TLOI15zSl5cfK
        NpXYJl17a+K68nYdy+Q5IauTZLgkt09gjrqisODlkn07XllY/jsS35mwYcrpNXyvZm7a4nU7
        yjZqwr6ttld+H2X94/Ah9Fv8joy1E1cVr183Ue1no5jeciGV+8q7w7YorL51KnEHm83Hoj1u
        t+P/tP47v3nhaY58ZiPRaOV3oZ9SF7TMv7CQxbRPpOr36aL7zjPvN7+buJDNMe79LHFmheZd
        Qp9NFWWXLzjAdPcst9Elg+jjSizFGYmGWsxFxYkAbd0AatgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIIsWRmVeSWpSXmKPExsVy+t/xe7qBRdGpBv2veSwezNvGZnF4foXF
        1IdP2Cy+b7nOZDHvs6zF3tdb2S2+Xelgstj0+BqrxeVdc9gsPvceYbSYcX4fk8XCphZ2i4nH
        JjNbrD1yl91i7pepzBZPHvaxOQh4rJm3htFj56y77B6L97xk8ti0qpPN4861PWwem5fUe/Rt
        WcXo8XmTXABHlJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllq
        kb5dgl7G0f/XGAum8VfcXnKNrYGxn6eLkZNDQsBE4vimYyxdjFwcQgJLGSU2t+xkh0hISxz+
        MgXKFpb4c62LDaKomUniz5FzrCAJNgEDiQdvlrGDJEQEOhklujafYwJJMAv8Z5b4OlOhi5GD
        Q1jAVGLvJR+QMIuAqkRLx2KwEl4BW4k363tYIRbIS+xZ9B0qLihxcuYTFogx8hLNW2czT2Dk
        m4UkNQtJagEj0ypGkdTS4tz03GJDveLE3OLSvHS95PzcTYzAuNp27OfmHYzzXn3UO8TIxMF4
        iFGCg1lJhPebUESqEG9KYmVValF+fFFpTmrxIUZToPsmMkuJJucDIzuvJN7QzMDU0MTM0sDU
        0sxYSZzXs6AjUUggPbEkNTs1tSC1CKaPiYNTqoHJYsa2r0n/hc9P1ZxgpBG743vM9G0nrsbn
        1YZ7a8xyzvF8sLvhRqFfqqLfypv5P5PELqZ2vPnhIxIRdTCsVsOUZXv7pH+mRz58PqYlubXu
        ikWG/cztFgkB9i9neKzaY6H9KqI0Nf+NjW5BqALbbNGY41yn+tzrQmqv9/6PcN/YeWPt3Pak
        ienn/HUmrOjs9phd3X9m7rX5p4O+9H0OvfNg/iqVXXyH74bkGZ1mTGzK2OtaXWhjpTqvgONH
        44ttZyJzVS5N3MT8+veWL8FshznkEpftF7gophSj1BH9oSN9N/PxqH3595a+fWV12/l95va9
        ttsnTJ3x9VBEmphs/MbGBP+WyPaqfX85bu//8uuLEktxRqKhFnNRcSIA+mxlFzQDAAA=
X-CMS-MailID: 20231120145057eucas1p2d3f7936d6a988d138af18e0011e7ad75
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20231120145057eucas1p2d3f7936d6a988d138af18e0011e7ad75
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231120145057eucas1p2d3f7936d6a988d138af18e0011e7ad75
References: <CGME20231120145057eucas1p2d3f7936d6a988d138af18e0011e7ad75@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This work improves Exynos thermal driver in various ways. This is
related to the discussion in
https://lore.kernel.org/all/97201878-3bb8-eac5-7fac-a690322ac43a@linaro.org/

The primary issue being fixed is a lockdep warning, which is fixed by
the thermal: exynos: use set_trips patch. We also simplify the code in
general.

Changelog:
 v5:
   - Used BIT wherever possible
   - Simplified Exynos 7 code and used the correct register offsets for
     Exynos 7
   - Refactored some common register-setting code
 v4:
   - Resolved merge conflict when applying thermal: exynos: split
     initialization of TMU and the thermal zone
   - Reordered calls done when leaving exynos_tmu_initialize for
     symmetry
 v3:
   - Fixed regulator initialization
   - Fixed formatting of some comments
 v2:
   - Added missing field descriptions
   - Removed an unnecessary field description
   - Removed the commits that made clock management more fine-grained
     (need more discussion), and adapted the new code to manage clocks
   - Removed the devicetree changes (will be uploaded separately),
     changing the recipient list accordingly
   - Improved formatting of the devm_request_threaded_irq call

Mateusz Majewski (9):
  thermal: exynos: remove an unnecessary field description
  thermal: exynos: drop id field
  thermal: exynos: switch from workqueue-driven interrupt handling to
    threaded interrupts
  thermal: exynos: handle devm_regulator_get_optional return value
    correctly
  thermal: exynos: simplify regulator (de)initialization
  thermal: exynos: stop using the threshold mechanism on Exynos 4210
  thermal: exynos: split initialization of TMU and the thermal zone
  thermal: exynos: use BIT wherever possible
  thermal: exynos: use set_trips

 drivers/thermal/samsung/exynos_tmu.c | 532 +++++++++++++--------------
 1 file changed, 258 insertions(+), 274 deletions(-)

-- 
2.42.0

