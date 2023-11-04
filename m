Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB4AA7E0CF2
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 01:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbjKDA6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 20:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbjKDA6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 20:58:01 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32520123
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 17:57:57 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20231104005755euoutp02c0ee3a3361ee8cc1fd9a395ec3ad545f~URZc4GmEy2782627826euoutp02i
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 00:57:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20231104005755euoutp02c0ee3a3361ee8cc1fd9a395ec3ad545f~URZc4GmEy2782627826euoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1699059475;
        bh=vq5XfVrMOKsVUO/n+Dl3zxrCVLfn8cbM3pwCIF/gzn8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=jBZy/u1Ms8cnxeTGdvUvcIozvCIeQAkvCHW6AQE1leYyotj1xKkjXTaNCoIgtOdHY
         vI+NzQokythU5oUJw4tI8InTJBVA692ydctB8Jom21KGsKcZdiNjp9NDDpWwiArTnj
         Ob9Dw76g4nsBAfwFTVzhQHuvZq0J7Vbzz0jafn0U=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20231104005754eucas1p11b66a647fe97391b9fa01478866aef21~URZcBCPZC2693226932eucas1p1P;
        Sat,  4 Nov 2023 00:57:54 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 4F.9E.42423.21795456; Sat,  4
        Nov 2023 00:57:54 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20231104005753eucas1p161414dd7c5eb9cdc6863fb543459c242~URZbP8LD_1997019970eucas1p1g;
        Sat,  4 Nov 2023 00:57:53 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231104005753eusmtrp2d538881ce4ad2745aad6b017becbfe07~URZbPetd50448904489eusmtrp2v;
        Sat,  4 Nov 2023 00:57:53 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-39-65459712a792
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id F5.E9.10549.11795456; Sat,  4
        Nov 2023 00:57:53 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20231104005753eusmtip1c1658ebb8c51dfb882a49f7d92a06a35~URZbEkNXB1691316913eusmtip1M;
        Sat,  4 Nov 2023 00:57:53 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) with Microsoft SMTP
        Server (TLS) id 15.0.1497.2; Sat, 4 Nov 2023 00:57:52 +0000
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
        ([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Sat, 4 Nov
        2023 00:57:52 +0000
From:   Daniel Gomez <da.gomez@samsung.com>
To:     "willy@infradead.org" <willy@infradead.org>
CC:     "gost.dev@samsung.com" <gost.dev@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        Daniel Gomez <da.gomez@samsung.com>
Subject: [PATCH 2/2] XArray: add cmpxchg order test
Thread-Topic: [PATCH 2/2] XArray: add cmpxchg order test
Thread-Index: AQHaDrnwqmHp5sYBP0uShsjDRRtCbA==
Date:   Sat, 4 Nov 2023 00:57:52 +0000
Message-ID: <20231104005747.1389762-3-da.gomez@samsung.com>
In-Reply-To: <20231104005747.1389762-1-da.gomez@samsung.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [106.110.32.103]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmleLIzCtJLcpLzFFi42LZduzneV2h6a6pBstnc1pc3jWHzeLGhKeM
        Fr9/zGFzYPbYvELLY9OqTjaPz5vkApijuGxSUnMyy1KL9O0SuDKOvP7AUvBVvOLv6i6mBsY1
        wl2MnBwSAiYSWy6sY+5i5OIQEljBKLH60mVWCOcLo8SRq73sEM5nRol5fWsZYVo+/F/DApFY
        zijxYu1RZriqWYcPsYNUCQmcZpQ4dIoVbvDNo2vYQBJsApoS+05uAisSEdCXWHnpLCNIEbPA
        K0aJd0cnsoAkhAWMJZpXHGeBKLKQ+LH4KlARB5CtJ3FgjjdImEVAReLQl6nMIDavgLXE+76X
        YOdxCthI7Fm9Hmw+o4CsxKOVv8BsZgFxiVtP5jNBvCAosWj2HmYIW0zi366HbBC2jsTZ60+g
        3jSQ2Lp0HwuErSTxp2MhI8QcPYkbU6ewQdjaEssWvoa6QVDi5Mwn4GCREJjOKXHo8HaoBS4S
        a5b0Qy0Wlnh1fAs7hC0j8X/nfKYJjNqzkNw3C8mOWUh2zEKyYwEjyypG8dTS4tz01GLDvNRy
        veLE3OLSvHS95PzcTYzAdHL63/FPOxjnvvqod4iRiYPxEKMEB7OSCK+jt0uqEG9KYmVValF+
        fFFpTmrxIUZpDhYlcV7VFPlUIYH0xJLU7NTUgtQimCwTB6dUA5OywD1Wa6/Et5f51NiDwgUO
        WzCw3pR9XvksJu/gUca+67dChb/t+n7me1DohaemXGIvVHmZH0z8xf/65xx9IVZvkXk80vc4
        9MIb4/9sb4u+eVf37HKPSAumq62shYxnjr6WZbikKxm5hqlpDfOKjDTtfN27ofIpJ6RS+vkK
        C2M+znx22ebywXsvjiVpqSgqLmtafyf/U1nIeWeuV9/ajJbs47u+zL6t5VVzwPYLP9UezmIN
        sas6POnoIQXb3w901sl83qJ+48S/p9MXl3ModtiVaS1Leh16PfF+VQwnR098Z2VAdP2DrBfu
        8uWhmx33ftdVePPysM9J1wMhSt3fA67JaS8Oe5zeIFcnLH5IRomlOCPRUIu5qDgRAI31roqW
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPIsWRmVeSWpSXmKPExsVy+t/xu7qC011TDfq3iVlc3jWHzeLGhKeM
        Fr9/zGFzYPbYvELLY9OqTjaPz5vkApij9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3N
        Y62MTJX07WxSUnMyy1KL9O0S9DKOvP7AUvBVvOLv6i6mBsY1wl2MnBwSAiYSH/6vYeli5OIQ
        EljKKPG9p5kJIiEjsfHLVVYIW1jiz7UuNoiij4wSTZ9mM0E4pxkl+i7+YIRwVjBKbJv9G6yd
        TUBTYt/JTewgtoiAvsTKS2fBipgFXjFKNDxYDVYkLGAs0bziOAtEkYXEj8VXgYo4gGw9iQNz
        vEHCLAIqEoe+TGUGsXkFrCXe971kBLGFgOzv7QfAxnAK2EjsWb0ebBejgKzEo5W/wGxmAXGJ
        W0/mQ70jILFkz3lmCFtU4uXjf1Cv6Uicvf6EEcI2kNi6dB8LhK0k8adjISPEHD2JG1OnsEHY
        2hLLFr6GukdQ4uTMJywTGKVnIVk3C0nLLCQts5C0LGBkWcUoklpanJueW2yoV5yYW1yal66X
        nJ+7iRGYErYd+7l5B+O8Vx/1DjEycTAeYpTgYFYS4XX0dkkV4k1JrKxKLcqPLyrNSS0+xGgK
        DKOJzFKiyfnApJRXEm9oZmBqaGJmaWBqaWasJM7rWdCRKCSQnliSmp2aWpBaBNPHxMEp1cC0
        eI2wk7Cc9bP/Mso8v0Xc9V7IxfTx2Z15aDh5soFZ+pQ9v6Z9nxDed/DnhcURfIcO2y38fd5m
        zqqNx6KZF26t3XSo/nD4S53tnQ12F8V2+ylNZF8Ttn+/wve7jDav9s8Qd+py+nCVY+atq1Ov
        zyhfseLEz7tB7evDZzL5VPAf1PH4ZdD2r+jP3Duhgd8edoiEnMrhndczzaz2IYOXq3xFSLfM
        9+1XZiu5PHqvHbhDpDb58rPIpwnGNRN0+RfPYONxOils9mLWnKTYktnhl3slf5urFb9rtfSc
        f0Oj/O/T/V+9y1mmvp29R6hgz65pPhvOfGYPZBNz42u/kag2v6WGMadP6Oa9SF2Wnqo6lfPv
        lFiKMxINtZiLihMB5WI4kJIDAAA=
X-CMS-MailID: 20231104005753eucas1p161414dd7c5eb9cdc6863fb543459c242
X-Msg-Generator: CA
X-RootMTR: 20231104005753eucas1p161414dd7c5eb9cdc6863fb543459c242
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231104005753eucas1p161414dd7c5eb9cdc6863fb543459c242
References: <20231104005747.1389762-1-da.gomez@samsung.com>
        <CGME20231104005753eucas1p161414dd7c5eb9cdc6863fb543459c242@eucas1p1.samsung.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

XArray multi-index entries do not keep track of the order stored once
the entry is being marked as used with cmpxchg (conditionally replaced
with NULL). Add a test to check the order is actually lost. The test
also verifies the order and entries for all the tied indexes before and
after the NULL replacement with xa_cmpxchg.

Add another entry at 1 << order that keeps the node around and the order
information for the NULL-entry after xa_cmpxchg.

Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
---
 lib/test_xarray.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/lib/test_xarray.c b/lib/test_xarray.c
index 0572a3ec2cf8..3c19d12c1bf5 100644
--- a/lib/test_xarray.c
+++ b/lib/test_xarray.c
@@ -423,6 +423,59 @@ static noinline void check_cmpxchg(struct xarray *xa)
 	XA_BUG_ON(xa, !xa_empty(xa));
 }

+static noinline void check_cmpxchg_order(struct xarray *xa)
+{
+#ifdef CONFIG_XARRAY_MULTI
+	void *FIVE =3D xa_mk_value(5);
+	unsigned int i, order =3D 3;
+
+	XA_BUG_ON(xa, xa_store_order(xa, 0, order, FIVE, GFP_KERNEL));
+
+	/* Check entry FIVE has the order saved */
+	XA_BUG_ON(xa, xa_get_order(xa, xa_to_value(FIVE)) !=3D order);
+
+	/* Check all the tied indexes have the same entry and order */
+	for (i =3D 0; i < (1 << order); i++) {
+		XA_BUG_ON(xa, xa_load(xa, i) !=3D FIVE);
+		XA_BUG_ON(xa, xa_get_order(xa, i) !=3D order);
+	}
+
+	/* Ensure that nothing is stored at index '1 << order' */
+	XA_BUG_ON(xa, xa_load(xa, 1 << order) !=3D NULL);
+
+	/*
+	 * Additionally, keep the node information and the order at
+	 * '1 << order'
+	 */
+	XA_BUG_ON(xa, xa_store_order(xa, 1 << order, order, FIVE, GFP_KERNEL));
+	for (i =3D (1 << order); i < (1 << order) + (1 << order) - 1; i++) {
+		XA_BUG_ON(xa, xa_load(xa, i) !=3D FIVE);
+		XA_BUG_ON(xa, xa_get_order(xa, i) !=3D order);
+	}
+
+	/* Conditionally replace FIVE entry at index '0' with NULL */
+	XA_BUG_ON(xa, xa_cmpxchg(xa, 0, FIVE, NULL, GFP_KERNEL) !=3D FIVE);
+
+	/* Verify the order is lost at FIVE (and old) entries */
+	XA_BUG_ON(xa, xa_get_order(xa, xa_to_value(FIVE)) !=3D 0);
+
+	/* Verify the order and entries are lost in all the tied indexes */
+	for (i =3D 0; i < (1 << order); i++) {
+		XA_BUG_ON(xa, xa_load(xa, i) !=3D NULL);
+		XA_BUG_ON(xa, xa_get_order(xa, i) !=3D 0);
+	}
+
+	/* Verify node and order are kept at '1 << order' */
+	for (i =3D (1 << order); i < (1 << order) + (1 << order) - 1; i++) {
+		XA_BUG_ON(xa, xa_load(xa, i) !=3D FIVE);
+		XA_BUG_ON(xa, xa_get_order(xa, i) !=3D order);
+	}
+
+	xa_store_order(xa, 0, BITS_PER_LONG - 1, NULL, GFP_KERNEL);
+	XA_BUG_ON(xa, !xa_empty(xa));
+#endif
+}
+
 static noinline void check_reserve(struct xarray *xa)
 {
 	void *entry;
@@ -1934,6 +1987,7 @@ static int xarray_checks(void)
 	check_xas_erase(&array);
 	check_insert(&array);
 	check_cmpxchg(&array);
+	check_cmpxchg_order(&array);
 	check_reserve(&array);
 	check_reserve(&xa0);
 	check_multi_store(&array);
--
2.39.2
