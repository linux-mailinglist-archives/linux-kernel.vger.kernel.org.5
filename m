Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8AC47BFF67
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 16:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbjJJOfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 10:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233312AbjJJO2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 10:28:47 -0400
Received: from out-198.mta0.migadu.com (out-198.mta0.migadu.com [IPv6:2001:41d0:1004:224b::c6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EDDB7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 07:28:44 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1696948122;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=GLeS08MBIWGTlAyOqrf8ngGV4rj6bq2718i39P+fBE0=;
        b=fgCPyXhoYfUC7YYYl8tbmesU6YmPouU1ODhbQ4C5ejRiZTvMAeIOKIIt9sB+Bi1MTFdfyL
        16O8Zfs7mISfCxZCLesDUK0x1PtKIFbYWJ5XSQmhjhNMJPKCVpLJkVGELKvZB+zJKGuJy8
        uZlhs5msyzRtDD0dz5FtKRSpSV16koU=
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/5] mm, kpageflags: support folio and fix output for compound pages
Date:   Tue, 10 Oct 2023 23:27:56 +0900
Message-Id: <20231010142801.3780917-1-naoya.horiguchi@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

This patchset addresses 2 issues in /proc/kpageflags.

  1. We can't easily tell folio from thp, because currently both pages are
     judged as thp, and
  2. we see some garbage data in records of compound tail pages because
     we use tail pages to store some internal data.

These issues require userspace programs to do additional work to understand
the page status, which makes situation more complicated.

This patchset tries to solve these by defining KPF_FOLIO for issue 1., and
by hiding part of page flag info on tail pages of compound pages for issue 2.

I think that technically some compound pages like thp/hugetlb/slab could be
considered as folio, but in this version KPF_FOLIO is set only on folios
in pagecache (so "folios in narrower meaning").  I'm not confident about
this choice, so if you have any idea about this, please let me know.

How we can see using tools/mm/page-types.c will change like below (only focusing
on compound pages).

Before patchset:

  // anonymous thp
  voffset         offset  len     flags
  ...
  700000000       156c00  1       ___U_l_____Ma_bH______t_____________f_d_____1
  700000001       156c01  1       L__U_______Ma___T_____t_____________f_______1
  700000002       156c02  1fe     ___________Ma___T_____t_____________f_______1

  // file thp
  700000000       15d600  1       __RUDl_____M__bH______t_____________f__I____1
  700000001       15d601  1       L__U_______M____T_____t_____________f_______1
  700000002       15d602  1fe     ___________M____T_____t_____________f_______1

  // large folio
  700000000       154f84  1       __RU_l_____M___H______t________P____f_____F_1
  700000001       154f85  1       ________W__M____T_____t_____________f_____F_1
  700000002       154f86  2       ___________M____T_____t_____________f_____F_1
  700000004       14d0a4  1       __RU_l_____M___H______t________P____f_____F_1
  700000005       14d0a5  1       ________W__M____T_____t_____________f_____F_1
  700000006       14d0a6  2       ___________M____T_____t_____________f_____F_1
  ...

  // free hugetlb (HVO disabled)
  offset  len     flags
  ...
  106a00  1       _______________H_G___________________________
  106a01  1       L__U__A_________TG___________________________
  106a02  1fe     ________________TG___________________________

  // anonymous hugetlb (HVO disabled)
  700000000       157200  1       ___U_______Ma__H_G__________________f_d_____1
  700000001       157201  1       L__U__A____Ma___TG__________________f_______1
  700000002       157202  1fe     ___________Ma___TG__________________f_______1

  // free hugetlb (HVO enabled)
  12a600  1       _______________H_G___________________________
  12a601  1       L__U__A_________TG___________________________
  12a602  3f      ________________TG___________________________
  12a641  1       L__U__A_________TG___________________________
  12a642  3f      ________________TG___________________________
  ...

  // anonymous hugetlb (HVO enabled)
  700000000       15e600  1       ___U_______Ma__H_G__________________f_d_____1
  700000001       15e601  1       L__U__A____Ma___TG__________________f_______1
  700000002       15e602  3e      ___________Ma___TG__________________f_______1
  700000040       15e640  1       ___U_______Ma___TG__________________f_d_____1
  700000041       15e641  1       L__U__A____Ma___TG__________________f_______1
  700000042       15e642  3e      ___________Ma___TG__________________f_______1
  ...

  // slab
               flags      page-count       MB  symbolic-flags                     long-symbolic-flags
  0x0000000000000080            5304       20  _______S_____________________________________      slab
  0x0000000000008080            1488        5  _______S_______H_____________________________      slab,compound_head
  0x0000000000010081             365        1  L______S________T____________________________      locked,slab,compound_tail
  0x0000000000010080            4142       16  _______S________T____________________________      slab,compound_tail
  0x0000000000010180             649        2  _______SW_______T____________________________      slab,writeback,compound_tail
  0x0000000000010181             474        1  L______SW_______T____________________________      locked,slab,writeback,compound_tail
  0x0000000000201080             192        0  _______S____a________x_______________________      slab,anonymous,ksm
  0x0000000000001080             427        1  _______S____a________________________________      slab,anonymous
  0x0000000000409080             237        0  _______S____a__H______t______________________      slab,anonymous,compound_head,thp
  0x0000000000411081              78        0  L______S____a___T_____t______________________      locked,slab,anonymous,compound_tail,thp
  0x0000000000609080              77        0  _______S____a__H_____xt______________________      slab,anonymous,compound_head,ksm,thp
  0x0000000000611081              32        0  L______S____a___T____xt______________________      locked,slab,anonymous,compound_tail,ksm,thp
  0x0000000000411080             698        2  _______S____a___T_____t______________________      slab,anonymous,compound_tail,thp
  0x0000000000611080             142        0  _______S____a___T____xt______________________      slab,anonymous,compound_tail,ksm,thp
  0x0000000000611180              32        0  _______SW___a___T____xt______________________      slab,writeback,anonymous,compound_tail,ksm,thp
  0x0000000000411181              95        0  L______SW___a___T_____t______________________      locked,slab,writeback,anonymous,compound_tail,thp
  0x0000000000411180              64        0  _______SW___a___T_____t______________________      slab,writeback,anonymous,compound_tail,thp
  0x0000000000611181              13        0  L______SW___a___T____xt______________________      locked,slab,writeback,anonymous,compound_tail,ksm,thp


After patchset:

  // anonymous thp
  700000000       117000  1       ___U_l_____Ma_bH______t_____________f_d_____1
  700000001       117001  1ff     ________________T_____t_____________f_______1

  // file thp
  700000000       118400  1       __RUDl_____M__bH______t_____________f__I____1
  700000001       118401  1ff     ________________T_____t_____________f_______1

  // large folio
  700000000       148da4  1       __RU_l_____M___H___________f___P____f_____F_1
  700000001       148da5  3       ________________T__________f________f_____F_1
  700000004       148da8  1       __RU_l_____M___H___________f___P____f_____F_1
  700000005       148da9  3       ________________T__________f________f_____F_1

  // free hugetlb (HVO disabled)
  116000  1       _______________H_G___________________________
  116001  1ff     ________________TG___________________________

  // anonymous hugetlb (HVO disabled)
  700000000       116000  1       ___U_______Ma__H_G__________________f_d_____1
  700000001       116001  1ff     ________________TG__________________f_______1

  // free hugetlb (HVO enabled)
  116000  1       _______________H_G___________________________
  116001  1ff     ________________TG___________________________

  // anonymous hugetlb (HVO enabled)
  700000000       116000  1       ___U_______Ma__H_G__________________f_d_____1
  700000001       116001  1ff     ________________TG__________________f_______1

  // slab
  0x0000000000000080            5659       22  _______S_____________________________________      slab
  0x0000000000008080            1644        6  _______S_______H_____________________________      slab,compound_head
  0x0000000000010080            6196       24  _______S________T____________________________      slab,compound_tail

Thanks,
Naoya Horiguchi
---
Summary:

Naoya Horiguchi (5):
      include/uapi/linux/kernel-page-flags.h: define KPF_FOLIO
      mm: kpageflags: distinguish thp and folio
      mm, kpageflags: separate code path for hugetlb pages
      mm, kpageflags: fix invalid output for PageSlab
      tools/mm/page-types.c: hide compound pages in non-raw mode

 fs/proc/page.c                         | 90 +++++++++++++++++++---------------
 include/uapi/linux/kernel-page-flags.h |  1 +
 tools/mm/page-types.c                  |  3 +-
 3 files changed, 53 insertions(+), 41 deletions(-)
