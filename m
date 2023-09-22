Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE3D7AA907
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 08:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbjIVG1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 02:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbjIVG1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 02:27:15 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06574CE
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 23:27:08 -0700 (PDT)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230922062706epoutp0166e89d99a99e0924e6291ba2b24d88ac~HJJlw_R6I2466924669epoutp01P
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 06:27:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230922062706epoutp0166e89d99a99e0924e6291ba2b24d88ac~HJJlw_R6I2466924669epoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695364026;
        bh=Hb4LK5km1WEqj6D7AXzSXon9Q0vrfwXxLWOoV26SQdE=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=EmAF6m7JoU8D2EZTeEB/Pa6OJhUy9xxH3BdYD+F4Jl+erdpmvzTGP2MwI9Zobpd5i
         NBxRaC8IdM8Wc+cmXqQigPl4xPJP1+eStz1Tozgpnu0iUGf7lwHp3sqRmwLXzAXUmm
         NcyJd7rhPPPLrydPqqj/df+MZ0xDxmcKIsP4HDfw=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20230922062705epcas1p34f0ace6c5a64263ee8e96a68e7bbcd4f~HJJlG8xmN3259332593epcas1p3J;
        Fri, 22 Sep 2023 06:27:05 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.38.242]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4RsMkK0hR2z4x9Pp; Fri, 22 Sep
        2023 06:27:05 +0000 (GMT)
X-AuditID: b6c32a38-4dbf8700000027b3-12-650d33b849f7
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        FA.B9.10163.8B33D056; Fri, 22 Sep 2023 15:27:05 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH] mm/vmalloc: Remove WARN_ON_ONCE related to
 adjust_va_to_fit_type
Reply-To: jason.sim@samsung.com
Sender: Jaeseon Sim <jason.sim@samsung.com>
From:   Jaeseon Sim <jason.sim@samsung.com>
To:     "bhe@redhat.com" <bhe@redhat.com>,
        "urezki@gmail.com" <urezki@gmail.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "lstoakes@gmail.com" <lstoakes@gmail.com>,
        Jaeseon Sim <jason.sim@samsung.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jaewon Kim <jaewon31.kim@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230922062704epcms1p1722f24d4489a0435b339ce21db754ded@epcms1p1>
Date:   Fri, 22 Sep 2023 15:27:04 +0900
X-CMS-MailID: 20230922062704epcms1p1722f24d4489a0435b339ce21db754ded
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmk+LIzCtJLcpLzFFi42LZdlhTV3enMW+qwZPNTBZz1q9hszj/4Beb
        xekJi5gset+/YrJYdOASo8XlXXPYLO6t+c9qcefbPHaL1RdZHDg9ds66y+6xeYWWx6ZPk9g9
        Tsz4zeLxft9VNo++LasYPT5vkgtgj8q2yUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0
        MFdSyEvMTbVVcvEJ0HXLzAE6TEmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYFag
        V5yYW1yal66Xl1piZWhgYGQKVJiQnfH2zhLmgkNSFRe/3WBsYGyQ7GLk5JAQMJHo//eerYuR
        i0NIYAejxKwPn5m6GDk4eAUEJf7uEAapERYIlph1eQkriC0kIC9xdksDI0RcW+LUyovMIDab
        gKZE14Ut7CC2iICPxLnvh8BmMgucZZJYevQMM8QyXokZ7U9ZIGxpie3LtzJC2KISN1e/ZYex
        3x+bDxUXkWi9dxaqV1Diwc/dUHEpiTNtS6DmFEusX3OdCcKukTj6ZD9U3Fyi4e1KNohffCUW
        7fMBCbMIqEr0LLzIBlHiItH2aivYX8xAvyxb+JoZpJwZ6Jf1u/QhShQldv6eywhRwifx7msP
        K8wnO+Y9gdqqLPHx2wVGkFYJAUmJCbvMIcIeEjufroSGWqDEu98n2Scwys9ChO0sJHtnIexd
        wMi8ilEstaA4Nz212LDABB6dyfm5mxjBqVLLYgfj3Lcf9A4xMnEwHmKU4GBWEuFN/sSVKsSb
        klhZlVqUH19UmpNafIjRFOjjicxSosn5wGSdVxJvaGJpYGJmZGJhbGlspiTOe+xVb4qQQHpi
        SWp2ampBahFMHxMHp1QD0/znP1/pvtq786jtVh3RglTHS2bOp4275zCozDJckHd48krf/3+u
        xT/KDl/mdvpqxAZG888JiwQnHGLSkW/o29h1TOkos8gxptTHu44Jv/q3XF84ZJmTbMifJ5cv
        eNoGGvZJp+fMMrhx7/TeiZ3aN+cG872OT+TeZsU598GCbuk9l+aeZTqjurg0Y3HL5KKqZ2WR
        uz/W3VNkz5CaJFp+KNT/HKuUxMKlv+8ELzqoLOp0ccNxq5znC6W/FJxpDs/5oiV0+nhv3azp
        uqIrmS5P6g4pm35T2L5KOludaSrj/47G7bmbjuvFSsecff7vUvd/iYNJhz33MB45WLiwfmFu
        aILorkfrVB/fOjY1aafhwc1KLMUZiYZazEXFiQBwXZhTHgQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230922061715epcms1p7cd5a37f4bba0abf4bc159b844bd8ee65
References: <CGME20230922061715epcms1p7cd5a37f4bba0abf4bc159b844bd8ee65@epcms1p1>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's panic issue as follows when do alloc_vmap_area:

Kernel panic - not syncing: kernel: panic_on_warn set ...

page allocation failure: order:0, mode:0x800(GFP_NOWAIT)
Call Trace:
warn_alloc+0xf4/0x190
__alloc_pages_slowpath+0xe0c/0xffc
__alloc_pages+0x250/0x2d0
new_slab+0x17c/0x4e0
___slab_alloc+0x4e4/0x8a8
__slab_alloc+0x34/0x6c
kmem_cache_alloc+0x20c/0x2f0
adjust_va_to_fit_type
__alloc_vmap_area
alloc_vmap_area+0x298/0x7fc
__get_vm_area_node+0x10c/0x1b4
__vmalloc_node_range+0x19c/0x7c0

Commit 1b23ff80b399 (=22mm/vmalloc: invoke classify_va_fit_type() in
adjust_va_to_fit_type()=22) moved classify_va_fit_type() into
adjust_va_to_fit_type() and used WARN_ON_ONCE() to handle return
value of adjust_va_to_fit_type(), just as classify_va_fit_type()
was handled.

There is another path in adjust_va_to_fit_type() which could
return failure and will be handled in alloc_vmap_area().
Remove WARN_ON_ONCE() for this case.

Fixes: 45c62fc2897d (=22mm/vmalloc: Remove WARN_ON_ONCE related to adjust_v=
a_to_fit_type=22)
Signed-off-by: Jaeseon Sim <jason.sim=40samsung.com>
---
=C2=A0mm/vmalloc.c=20=7C=204=20++--=0D=0A=C2=A01=20file=20changed,=202=20in=
sertions(+),=202=20deletions(-)=0D=0A=0D=0Adiff=20--git=20a/mm/vmalloc.c=20=
b/mm/vmalloc.c=0D=0Aindex=20ef8599d394fd..4a82b6525d48=20100644=0D=0A---=20=
a/mm/vmalloc.c=0D=0A+++=20b/mm/vmalloc.c=0D=0A=40=40=20-1522,7=20+1522,7=20=
=40=40=20__alloc_vmap_area(struct=20rb_root=20*root,=20struct=20list_head=
=20*head,=0D=0A=C2=A0=0D=0A=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0/*=20U=
pdate=20the=20free=20vmap_area.=20*/=0D=0A=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0ret=20=3D=20adjust_va_to_fit_type(root,=20head,=20va,=20nva_start_=
addr,=20size);=0D=0A-=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20if=20(WARN_ON_ONCE=
(ret))=0D=0A+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20if=20(ret)=0D=0A=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0return=
=20vend;=0D=0A=C2=A0=0D=0A=C2=A0=23if=20DEBUG_AUGMENT_LOWEST_MATCH_CHECK=0D=
=0A=40=40=20-4143,7=20+4143,7=20=40=40=20struct=20vm_struct=20**pcpu_get_vm=
_areas(const=20unsigned=20long=20*offsets,=0D=0A=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0ret=20=3D=20adjust_va_to=
_fit_type(&free_vmap_area_root,=0D=0A=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0&free_vmap_area_list,=0D=0A=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0va,=20start,=20size);=0D=0A-=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20if=20(WARN_ON_ONCE(unlik=
ely(ret)))=0D=0A+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20if=20(unlikely(ret))=0D=0A=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0/*=20It=20is=20a=20BUG(),=20but=20trigger=20recovery=20instead.=20*/=
=0D=0A=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0goto=20recovery;=0D=0A=C2=A0=
=0D=0A--=C2=A0=0D=0A2.17.1
