Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482F9768C14
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 08:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjGaGfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 02:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbjGaGfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 02:35:13 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D049EE59
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 23:35:11 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230731063508epoutp027419256ad35f95b3cead5348804506c6~24EfFg6y92139221392epoutp02-
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 06:35:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230731063508epoutp027419256ad35f95b3cead5348804506c6~24EfFg6y92139221392epoutp02-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690785309;
        bh=7L0WdLbSY4+UIiexiV8CHrSFkrbBOMcaSOPaBv2tq1E=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=URjjHkmXhIm4h077k0YwzVR0lnmjqd66g5MamhblgkukPyF/h3tL/CzuX7jyDYK7Y
         SbvjlHV8WMeeOUAtcBlVuksyHkgFAvud7fUWCDyjWYOIuCQ+3e9/9FUBF7RPUU7DMn
         eIS+8FVjjdGmV3FotFamoaikmKE4e0auHVLfIs3Y=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20230731063508epcas2p36a50b1d688e1e4a907345e20105a35ae~24EeuONxh3254932549epcas2p3J;
        Mon, 31 Jul 2023 06:35:08 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.92]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4RDpQ41wtSz4x9Q6; Mon, 31 Jul
        2023 06:35:08 +0000 (GMT)
X-AuditID: b6c32a48-adffa70000007e89-6f-64c7561c39e3
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        6C.C0.32393.C1657C46; Mon, 31 Jul 2023 15:35:08 +0900 (KST)
Mime-Version: 1.0
Subject: RE:(2) [PATCH 2/2] bio-integrity: create multi-page bvecs in
 bio_integrity_add_page()
Reply-To: j-young.choi@samsung.com
Sender: Jinyoung Choi <j-young.choi@samsung.com>
From:   Jinyoung Choi <j-young.choi@samsung.com>
To:     "hch@lst.de" <hch@lst.de>
CC:     "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "chaitanya.kulkarni@wdc.com" <chaitanya.kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20230731055524.GA30066@lst.de>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230731063507epcms2p185efd3a1774bf0482cd7133a509863d6@epcms2p1>
Date:   Mon, 31 Jul 2023 15:35:07 +0900
X-CMS-MailID: 20230731063507epcms2p185efd3a1774bf0482cd7133a509863d6
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBJsWRmVeSWpSXmKPExsWy7bCmha5M2PEUg8lzeC1W3+1ns5h1+zWL
        xctDmhYrVx9lsph06Bqjxd5b2haXd81hs1h+/B+TxbrX71kcOD3O39vI4nH5bKnHplWdbB67
        bzaweXx8eovFo2/LKkaPz5vkPNoPdDMFcERl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY
        6hpaWpgrKeQl5qbaKrn4BOi6ZeYAHaekUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJ
        KTAv0CtOzC0uzUvXy0stsTI0MDAyBSpMyM6Y8m02U8E1zormf/PYGhh/cnQxcnJICJhIXDjY
        w9bFyMUhJLCDUeLQlXUsXYwcHLwCghJ/dwiD1AgLJEj0z/3IBGILCShJnFszixEibiDRcruN
        BcRmE9CT2PF8NztIq4iArMSVFfUgI5kFPjNJPDhwmhliF6/EjPanLBC2tMT25VvB5nAK6Ejs
        +rmZFSKuIfFjWS9UvajEzdVv2WHs98fmM0LYIhKt985C1QhKPPi5GyouKXHo0Fc2kBskBPIl
        NhwIhAjXSLT9eg9Vri9xrWMj2Am8Ar4S2xc/ZAOxWQRUJZ7ffMcI0eoisXQFWJhZQFti2cLX
        zCBhZgFNifW79CEqlCWO3GKBqOCT6Dj8lx3mv4aNv7Gyd8x7wgTRqiaxqMloAqPyLEQgz0Ky
        ahbCqgWMzKsYxVILinPTU4uNCkzg8Zqcn7uJEZxEtTx2MM5++0HvECMTB+MhRgkOZiUR3lMB
        h1KEeFMSK6tSi/Lji0pzUosPMZoC/TiRWUo0OR+YxvNK4g1NLA1MzMwMzY1MDcyVxHnvtc5N
        ERJITyxJzU5NLUgtgulj4uCUamAyOXi4nScgMvCtoO+21Vca2Yu/cyc19snc7Ax78sAz+Eac
        kdUpQWenk5YHF6yxZt/fGZdfv+Lt8ccp9wNuO4hssgjZdlb8oluTxWQLrrlexsXPShI37TrM
        YBO3+PP98KuJ7lnbJsrdYn0WNO9Bxktdzd7j+jt9Mps2aT3r/MLTpR0baS+0Rtq8ukR8cnNJ
        1Z7nlrGaZnd3tdmX7ZmceTKtZWN33JNFx3pDby16e2rN/LSZhyWefF9d+meD9J8fz4tmNHww
        ncMXU/gtvd/Q94LJe9b3/fNM7aQaXYxFjVlKWW/U5K8UdBWSUpF68VSEySXn/PSSkKTCS1e8
        eeR85fpPrD3D83HyKUcJ1nRdWyWW4oxEQy3mouJEABA58kkrBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230728075537epcms2p194154023a4cdbe37c0346ef1102d1d63
References: <20230731055524.GA30066@lst.de>
        <20230728075537epcms2p194154023a4cdbe37c0346ef1102d1d63@epcms2p1>
        <20230728075753epcms2p7354d445f1888ab3942a16e26a13d5bbd@epcms2p7>
        <CGME20230728075537epcms2p194154023a4cdbe37c0346ef1102d1d63@epcms2p1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Jul 28, 2023 at 04:57:53PM +0900, Jinyoung Choi wrote:
> > Allow bio_integrity_add_page to create multi-page bvecs, just like
> > the bio payloads. This simplifies adding larger payloads, and fixes
> > support for non-tiny workloads with nvme, which stopped using
> > scatterlist for metadata a while ago
>=20
> Missing dot at the end of the sentence here.=C2=A0=20Also=20the=20commit=
=20log=20feels=0D=0A>=20very=20short=20to=20me=20for=20such=20a=20substania=
l=20change,=20although=20even=20thinking=0D=0A>=20hard=20about=20it=20I'm=
=20not=20entirely=20sure=20what=20would=20be=20missing,=20so=20it's=0D=0A>=
=20probably=20fine..=0D=0A>=20=0D=0A>=20Looks=20good=20to=20me:=0D=0A>=20=
=0D=0A>=20Reviewed-by:=20Christoph=20Hellwig=20<hch=40lst.de>=0D=0A=0D=0AHi=
,=20Christoph.=0D=0A=0D=0AI=20will=20add=20a=20commit=20message=20for=20the=
=20substanial=20change.=0D=0A=0D=0AOh,=20and=20I=20missed=20some=20patches=
=20that=20should=20be=20included=20in=20the=20patch=20set.=0D=0AIn=20the=20=
next=20version,=20I=20will=20add=20patches=20that=20are=20affected=20by=20t=
his=20patch=20=0D=0Aand=20must=20be=20changed.=0D=0A=0D=0AThank=20you=20for=
=20your=20review.=0D=0A=0D=0ABest=20Regards,=0D=0AJinyoung.
