Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C68806A0A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 09:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjLFIqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 03:46:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjLFIqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 03:46:54 -0500
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E275E11F
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 00:46:56 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20231206084653euoutp0208d65c95720c51a26b711d61d7c4c5d0~eMcDVnmbk2728827288euoutp02J
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 08:46:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20231206084653euoutp0208d65c95720c51a26b711d61d7c4c5d0~eMcDVnmbk2728827288euoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1701852413;
        bh=q4PDyyNqpXrVYosR/HC3mCzskrZhduX/SJA9wFZBRGQ=;
        h=From:To:Cc:Subject:Date:References:From;
        b=norDNfMz9S/Nh3vaYyTm4VbDjjG8HNp0TKznQRQB9Lt7O1zQ2hDWbk2/MCjTXL2f4
         ymfrcRx3K64hR2Fj7QlsQW5GiVDelQ8RrYPa7KAFaUXeshEc/5d/fMMoODNCNz+ovf
         1vb0YyoHEtBKlnRjkiXK1qB6ZxLVoIGB/cPkLJvc=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20231206084653eucas1p134fc27cc2ae2ffa9e188dc16ec92124f~eMcDA9mPa1222412224eucas1p12;
        Wed,  6 Dec 2023 08:46:53 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 13.8E.09814.DF430756; Wed,  6
        Dec 2023 08:46:53 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20231206084652eucas1p1fd6025710032f3a4a64b05dab67a2a17~eMcCjv-FX1414014140eucas1p1n;
        Wed,  6 Dec 2023 08:46:52 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231206084652eusmtrp1d620095f901b15e13a8be0efb99d76c0~eMcCiyr-G3235332353eusmtrp1m;
        Wed,  6 Dec 2023 08:46:52 +0000 (GMT)
X-AuditID: cbfec7f4-711ff70000002656-24-657034fd7a96
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 0E.66.09146.CF430756; Wed,  6
        Dec 2023 08:46:52 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231206084651eusmtip2f53b5a0cf2e7c5c077a9d3d4f416831d~eMcBy9Z122879728797eusmtip2P;
        Wed,  6 Dec 2023 08:46:51 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH] drivers: perf: constify the ctl_table argument of the riscv
 user access handler
Date:   Wed,  6 Dec 2023 09:46:42 +0100
Message-Id: <20231206084642.802053-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEKsWRmVeSWpSXmKPExsWy7djPc7p/TQpSDd4sZ7Zo+fCO1WLr71ns
        Fh3n3CzOdOdabHp8jdXi8q45bBbbPrewWfz+8YzJYu2Ru+wWS69fZLK4MeEpo8XLyz3MFm2z
        +C1a7pg68HmsmbeG0eNax0YWj6m/z7B4zG64yOLx5uVLFo/DHV/YPTat6mTz2Lyk3qNvyypG
        j0vN19k9Pm+S8+jvPsYewBPFZZOSmpNZllqkb5fAlbGzVbJgCnvFqwkVDYyNbF2MnBwSAiYS
        n5fNArK5OIQEVjBKfF76jhXC+cIocXlZIxOE85lR4sXSZawwLTv2/YCqWs4ocah/GjNIAqzl
        /1JLEJtNwFCi620X2A4RgUyJA49mgDUwC+xllti2fDojSEJYIEli/u1HYM0sAqoSL2+tB9vA
        K2An0Tb7DQvENnmJ/QfPMkPEBSVOznwCFmcGijdvnc0MMlRC4AeHRNu+FiaIBheJ0ztmQX0n
        LPHq+BZ2CFtG4vTkHhaIhnZGiQW/7zNBOBMYJRqe32KEqLKWuHPuF1A3B9AKTYn1u/Qhwo4S
        Ox4vYgEJSwjwSdx4KwhxBJ/EpG3TmSHCvBIdbUIQ1WoSs46vg1t78MIlZgjbQ2L3q1eMkMCK
        lXiy9THrBEaFWUhem4XktVkINyxgZF7FKJ5aWpybnlpslJdarlecmFtcmpeul5yfu4kRmOxO
        /zv+ZQfj8lcf9Q4xMnEwHmKU4GBWEuHNOZ+fKsSbklhZlVqUH19UmpNafIhRmoNFSZxXNUU+
        VUggPbEkNTs1tSC1CCbLxMEp1cC06ek8e22P99aLPqky9Au82OEvL/uCbYlvZ+7buj8sQp/O
        Ncyct2rnprnz1z1i0KiTLoh/sK7p/+HA7qTW6ish8eLVlXxM3HcLOM/Eqlf/+Hom9enk6brv
        30Z5ru/cViZ65sjCbwZGnOqiLn79AhIq07azMYQdYo3ulY4+vHKrPeuswh9pbVVu4S6XHDuD
        Q131o3WWP80X7Sq6teB//rktVW/urzPa7PBY+QxvS/auZZp2jSaNObM2TneQ3q+bv1pbR43j
        nNR9c4MnWhybKpbW/o3P17olwyl22OHq9KKYdTOM1l/MO1Gqpp22u/bzvAov2dV6QTplxwuN
        /Tkvbo/KTt24wFli3bE9DpJKXEosxRmJhlrMRcWJAGGMYfLlAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRmVeSWpSXmKPExsVy+t/xe7p/TApSDbZsULJo+fCO1WLr71ns
        Fh3n3CzOdOdabHp8jdXi8q45bBbbPrewWfz+8YzJYu2Ru+wWS69fZLK4MeEpo8XLyz3MFm2z
        +C1a7pg68HmsmbeG0eNax0YWj6m/z7B4zG64yOLx5uVLFo/DHV/YPTat6mTz2Lyk3qNvyypG
        j0vN19k9Pm+S8+jvPsYewBOlZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRv
        Z5OSmpNZllqkb5egl7GzVbJgCnvFqwkVDYyNbF2MnBwSAiYSO/b9YO1i5OIQEljKKLH04FMm
        iISMxMlpDawQtrDEn2tdbBBFnxglmn7MYQRJsAkYSnS97QKbJCKQLbH98wR2kCJmgaPMEtNW
        vgabJCyQIHHp5XIwm0VAVeLlrfVgU3kF7CTaZr9hgdggL7H/4FlmiLigxMmZT8DizEDx5q2z
        mScw8s1CkpqFJLWAkWkVo0hqaXFuem6xoV5xYm5xaV66XnJ+7iZGYJRtO/Zz8w7Gea8+6h1i
        ZOJgPMQowcGsJMKbcz4/VYg3JbGyKrUoP76oNCe1+BCjKdB9E5mlRJPzgXGeVxJvaGZgamhi
        ZmlgamlmrCTO61nQkSgkkJ5YkpqdmlqQWgTTx8TBKdXAtPKcUm3ppeyeL72xRsYvNk/3En21
        LHPn8TL26X098TJOe9cU61xuez7HyCu9UyflxiLbTSUt8prPHrJUH/L55fHuY4HttMd1//aX
        ZG+RLfOK4os0fZ32TFPhpdERbsmzB6QdHplYewl/2cg7w1O/K+mxd8TyqvqpCxwXXDhS+MLk
        1dHSlU2fQ9dkhKqv7gwrX/dK+kdHQVFIyro74f+WK7Xvr9vuqrfx+LoHE2Zkqn1bXOIadzt5
        1tInLLmLdDeuz3YRVW+ftvbbt5etp6fMjeX8flhccZVESu2SrvRDG7keV9wuj5msF7j7yUz3
        34vZBIWP3PR/NWmm78wFckk98y0WmD62F64PnSz1nyUgVomlOCPRUIu5qDgRAG1C6e07AwAA
X-CMS-MailID: 20231206084652eucas1p1fd6025710032f3a4a64b05dab67a2a17
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20231206084652eucas1p1fd6025710032f3a4a64b05dab67a2a17
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231206084652eucas1p1fd6025710032f3a4a64b05dab67a2a17
References: <CGME20231206084652eucas1p1fd6025710032f3a4a64b05dab67a2a17@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fix riscv build break after commit c8be9e66ca1e ("sysctl: treewide:
constify the ctl_table argument of handlers").

Fixes: c8be9e66ca1e ("sysctl: treewide: constify the ctl_table argument of handlers")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/perf/riscv_pmu_sbi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 16acd4dcdb96..97e345f7d25d 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -986,7 +986,7 @@ static void riscv_pmu_update_counter_access(void *info)
 		csr_write(CSR_SCOUNTEREN, 0x2);
 }
 
-static int riscv_pmu_proc_user_access_handler(struct ctl_table *table,
+static int riscv_pmu_proc_user_access_handler(const struct ctl_table *table,
 					      int write, void *buffer,
 					      size_t *lenp, loff_t *ppos)
 {
-- 
2.34.1

