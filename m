Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29F2F76DD7C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 03:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjHCBsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 21:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjHCBsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 21:48:20 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806C230C0
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 18:48:18 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230803014815epoutp0277025cae46e236f1d356a0c72455eb21~3vF2prkfR2714827148epoutp02e
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 01:48:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230803014815epoutp0277025cae46e236f1d356a0c72455eb21~3vF2prkfR2714827148epoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1691027295;
        bh=HgBY7lrPaWXKVOL88v/DbQ4RH1S1ZvplAdNDATbtocI=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=N/n27RTeK1RwkQlyEVkB/TjRV7uKEtHMwTfRHQWR/4X4A/yOcnehS8hg9MLD6xdQ5
         +YvRtZBjHLxQTVGVQV6oQCXI2TvY45QzzFF3qrpFCDJwIG8B9uNEnVJG/+LWOXtU1z
         zAU08PDbO+tx5fsn5hLjOClNfRDkj4kbiP+n4dyw=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20230803014814epcas2p29e71ca25cc489b9c720dee4b14ac3d78~3vF17XHeX1271112711epcas2p2k;
        Thu,  3 Aug 2023 01:48:14 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.101]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4RGWvf3MQjz4x9Px; Thu,  3 Aug
        2023 01:48:14 +0000 (GMT)
X-AuditID: b6c32a47-9cbff70000007f5e-e0-64cb075e5051
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        0F.93.32606.E570BC46; Thu,  3 Aug 2023 10:48:14 +0900 (KST)
Mime-Version: 1.0
Subject: RE:(2) [PATCH v2 3/4] bio-integrity: cleanup adding integrity pages
 to bip's bvec
Reply-To: j-young.choi@samsung.com
Sender: Jinyoung Choi <j-young.choi@samsung.com>
From:   Jinyoung Choi <j-young.choi@samsung.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "chaitanya.kulkarni@wdc.com" <chaitanya.kulkarni@wdc.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <ZMjYYtXgzn86UIF8@infradead.org>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230803014814epcms2p3ed3f8a7e5f53e98d0acf478617445aee@epcms2p3>
Date:   Thu, 03 Aug 2023 10:48:14 +0900
X-CMS-MailID: 20230803014814epcms2p3ed3f8a7e5f53e98d0acf478617445aee
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBJsWRmVeSWpSXmKPExsWy7bCmuW4c++kUg4+TpCxW3+1ns5h1+zWL
        xctDmhanJyxisph06Bqjxd5b2haXd81hs1h+/B+TxbrX71kcOD3O39vI4rF5hZbH5bOlHptW
        dbJ5fHx6i8Wjb8sqRo/Pm+Q82g90MwVwRGXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjq
        GlpamCsp5CXmptoqufgE6Lpl5gDdpqRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkp
        MC/QK07MLS7NS9fLSy2xMjQwMDIFKkzIzmh9fYypYCZ7RcuLGcwNjBvZuhg5OSQETCS2bnzF
        0sXIxSEksINR4nZHI1MXIwcHr4CgxN8dwiA1wgIxEque72AGsYUElCTOrZnFCBE3kGi53cYC
        YrMJ6EnseL6bHcQWEdCUuLW8nRlkJrPAZyaJmY2XmSCW8UrMaH/KAmFLS2xfvhVsEKeArsTb
        lZ1QB2lI/FjWywxhi0rcXP2WHcZ+f2w+I4QtItF67yxUjaDEg5+7oeKSEocOfWUDuV9CIF9i
        w4FAiHCNRNuv91Dl+hLXOjaCncAr4CvxpfkKI0g5i4CqRMdXbYgSF4nTG7aBXcMsoC2xbOFr
        ZpASZqC31u/ShxiuLHHkFgtEBZ9Ex+G/7DD/NWz8jZW9Y94TJohWNYlFTUYTGJVnIUJ5FpJV
        sxBWLWBkXsUollpQnJueWmxUYAyP2OT83E2M4CSq5b6DccbbD3qHGJk4GA8xSnAwK4nwSv8+
        niLEm5JYWZValB9fVJqTWnyI0RTox4nMUqLJ+cA0nlcSb2hiaWBiZmZobmRqYK4kznuvdW6K
        kEB6YklqdmpqQWoRTB8TB6dUA1Pm1BOFnNrHjh+ZMberpKxt3epJony9wR2mP+YJdnHOtdf8
        0H/96eRo/l+zvQUuWejcNHp8+dCT5llKmR9M8jQeWT9wrru8LVS+YE8Dw+Sv9rZWTvNsrj8L
        27okwWh276oy7wtLb1b9vrnqS6jLzc27xdZ9/B1xq8AiJEmg9KQUf0DC5bwfX5MOr1p4u9T/
        4tmyX86Ls44EcL1vLD+waJpov4PUUwE5l5cTeR99Yc1Q4bp8Kl9+MvvZhSrLwyuPbKhp2812
        hNXznuPjhJDYIzavHsrxMd/SmHaeo1F4l/Qc7lDm8JPLmr64r5qzvvDE3qZ1kv5Cmzc8Ld/g
        WMgVZHlk/sRoVauqGY82rtLVPiSmxFKckWioxVxUnAgAjm6LRisEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230731124710epcms2p55b4d1a163b5ee6f15d96bf07817e12a5
References: <ZMjYYtXgzn86UIF8@infradead.org>
        <20230731124710epcms2p55b4d1a163b5ee6f15d96bf07817e12a5@epcms2p5>
        <20230731125459epcms2p177a5cc5caa7ef0a9de35689e96558f43@epcms2p1>
        <CGME20230731124710epcms2p55b4d1a163b5ee6f15d96bf07817e12a5@epcms2p3>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, Jul 31, 2023 at 09:54:59PM +0900, Jinyoung Choi wrote:
> > The bio_integrity_add_page() returns the set length if the execution
> > result is successful. Otherwise, return 0.
> >=20
> > Unnecessary if statement was removed. And when the result value was les=
s
> > than the set value, it was changed to failed.
>=20
> Maybe word this as
>=20
> bio_integrity_add_page() returns the add length if successful, else 0,
> just as bio_add_page.=C2=A0=20Simply=20check=20return=20value=20checking=
=20in=0D=0A>=20bio_integrity_prep=20to=20not=20deal=20with=20a=20>=200=20bu=
t=20<=20len=20case=20that=20can't=0D=0A>=20happen.=0D=0A>=20=0D=0A>=20Other=
wise=20looks=20good:=0D=0A>=20=0D=0A>=20Reviewed-by:=20Christoph=20Hellwig=
=20<hch=40lst.de>=0D=0A=0D=0AHi,=20Christoph.=0D=0AThank=20you=20for=20your=
=20review.=20I=20will=20update=20comment=20soon=21=0D=0A=0D=0ABest=20Regard=
s,=0D=0AJinyoung.
