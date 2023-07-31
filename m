Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970EF768F2A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 09:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbjGaHtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 03:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbjGaHtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 03:49:11 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD27618B
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 00:49:08 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230731074904epoutp04e3fcea934465d8012e42ddfb81c9f552~25FCYHdud0204302043epoutp04z
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 07:49:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230731074904epoutp04e3fcea934465d8012e42ddfb81c9f552~25FCYHdud0204302043epoutp04z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690789744;
        bh=SQJcltz9OcRew/9F82robeZASzNGmx6wunn4k15sco8=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=WXyX4ESYAW6OPbR8OYrCb+nx+6fzGnNr0ONuf/L/FmEYpev//NehzCG6/QaJBZ8nO
         mX6Ayw5X7Pw4dAuOKEgt4vOWZRAAIww+q+4PV6T66u7XDPmE9k6dtdsa96Z23yY4jF
         svCtKJm440Qu7w6lXj4uCryMqIDe7tRoqqh8QDqg=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20230731074903epcas2p15208627290162fbc7bfb7ad7a52c5d86~25FBczs5S0433904339epcas2p1V;
        Mon, 31 Jul 2023 07:49:03 +0000 (GMT)
Received: from epsmgec2p1.samsung.com (unknown [182.195.36.88]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4RDr3M4HSfz4x9Q2; Mon, 31 Jul
        2023 07:49:03 +0000 (GMT)
X-AuditID: b6c32a43-2f3ff7000001d7ef-72-64c7676ed46d
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmgec2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        9C.60.55279.E6767C46; Mon, 31 Jul 2023 16:49:02 +0900 (KST)
Mime-Version: 1.0
Subject: RE:(2) [PATCH v2] md/bitmap: Avoid protection error writing bitmap
 page with block integrity
Reply-To: j-young.choi@samsung.com
Sender: Jinyoung Choi <j-young.choi@samsung.com>
From:   Jinyoung Choi <j-young.choi@samsung.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     "song@kernel.org" <song@kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <ZMdiEavzzRwAFjPq@infradead.org>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230731074902epcms2p5383ba1e030b5c79730fa14393bb1cdb5@epcms2p5>
Date:   Mon, 31 Jul 2023 16:49:02 +0900
X-CMS-MailID: 20230731074902epcms2p5383ba1e030b5c79730fa14393bb1cdb5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFKsWRmVeSWpSXmKPExsWy7bCmuW5e+vEUg71fLC1eHtK0OD1hEZPF
        5V1z2Cza5+9itHg5K83i+PK/bA5sHptXaHlsWtXJ5vHk3ARmj74tqxg9Pm+SC2CNyrbJSE1M
        SS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMAVqvpFCWmFMKFApI
        LC5W0rezKcovLUlVyMgvLrFVSi1IySkwL9ArTswtLs1L18tLLbEyNDAwMgUqTMjOOPLrIWvB
        Qc6KyTPOMTUwfuLoYuTgkBAwkVh/JqGLkYtDSGAHo8Sx2ceYQOK8AoISf3cIdzFycggLpEvM
        2f2IDcQWElCSOLdmFiNE3ECi5XYbC4jNJqAnseP5bnYQW0RAU+LW8nZmEJtZ4AajxKpNXCC2
        hACvxIz2pywQtrTE9uVbweZwCuhKrPpxGCquIfFjWS8zhC0qcXP1W3YY+/2x+YwQtohE672z
        UDWCEg9+7oaKS0ocOvSVDeKtfIkNBwIhwjUSbb/eQ5XrS1zr2Ai2ilfAV+Lk0UdMIDaLgKrE
        pLYVTBA1LhKzGy5Cna8tsWzha2aQkcxAb63fpQ8xXVniyC0WiAo+iY7Df9lhHmzY+Bsre8e8
        J0wQrWoSi5qMJjAqz0KE8iwkq2YhrFrAyLyKUSy1oDg3PTXZqMAQHq/J+bmbGMGJUMt5B+OV
        +f/0DjEycTAeYpTgYFYS4T0VcChFiDclsbIqtSg/vqg0J7X4EKMp0JMTmaVEk/OBqTivJN7Q
        xNLAxMzM0NzI1MBcSZz3XuvcFCGB9MSS1OzU1ILUIpg+Jg5OqQam6tMZt38znjUO5DvpFvXg
        xS+LLwyLHnxUff7zcrDEhY/8dyrNVX5XHNCc3D9vaemDduvYY/mLE7ddj+qJerJn/woN367e
        6TP+zqnNYl4du+6lK8edczpHVmw+5ex0efehmtaq7CBtw/w5arvSPL0LL85Ysd+dK5hhL2+a
        l+oL/i95nd6VN5d93vLQ+VT758RLl6OnfLB9qeP1cOKeM4Zc2THSfOyut+z/sM0UOLPh4end
        uj61ext1m656fK3m3XnmyBrbknMdR/7lPHM2897E1fzim8/b30ynTq0xf/P3aNDihzyxG3Xt
        1vFEdUWolCQtmrfYQCm8ZrtS0DSH8FkMOxqP/KlSnRMV7RrkMP+nvxJLcUaioRZzUXEiADBj
        quUNBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230720092957epcms2p6cbd0ecdf7f5bf0db3c04eefaf0a6644d
References: <ZMdiEavzzRwAFjPq@infradead.org>
        <20230720092957epcms2p6cbd0ecdf7f5bf0db3c04eefaf0a6644d@epcms2p6>
        <CGME20230720092957epcms2p6cbd0ecdf7f5bf0db3c04eefaf0a6644d@epcms2p5>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Jul 20, 2023 at 06:29:57PM +0900, Jinyoung Choi wrote:
> > Changing the bitmap page is also possible on the page where the DMA is
> > being performed or scheduled in the MD.
>=20
> Are you guys actually using the whacky bitmap feature?=C2=A0=20If=20so,=
=20this=0D=0A>=20really=20is=20the=20least=20of=20our=20problems=20and=20yo=
u=20need=20to=20invest=20some=20real=0D=0A>=20work=20into=20it=20to=20get=
=20it=20off=20->bmap=20and=20into=20using=20->read_iter=20and=0D=0A>=20->wr=
ite_iter.=C2=A0=20Right=20now=20Song=20has=20a=20series=20from=20me=20queue=
d=20up=20to=0D=0A>=20deprecated=20it.=0D=0A>=20=0D=0A>=20I=20also=20don't=
=20think=20a=20simple=20wait=20for=20existing=20writers=20prevents=20you=0D=
=0A>=20from=20other=20modifications,=20but=20maybe=20I'm=20issing=20somethi=
ng.=0D=0A=0D=0AHi,=20Christoph.=0D=0A=0D=0AI=20think=20the=20way=20to=20wri=
te=20bitmap=20page=20like=20you=20should=20be=20changed.=0D=0AThis=20patch=
=20is=20a=20simple=20workaround=20in=20the=20current=20system.=0D=0A=0D=0AI=
=20will=20check=20the=20patches=20you=20provided=20for=20bitmap=20processin=
g.=0D=0A=0D=0AThank=20you=20for=20your=20review.=0D=0A=0D=0ABest=20Regards,=
=0D=0AJinyoung.
