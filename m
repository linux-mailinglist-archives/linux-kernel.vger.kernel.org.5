Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 415637DA984
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 23:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjJ1VQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 17:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbjJ1VPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 17:15:53 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B868F1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 14:15:50 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20231028211549euoutp017d8de5698f5e44eb9243e5293ba79e3c~SYf0uDEVj2292822928euoutp01b
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 21:15:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20231028211549euoutp017d8de5698f5e44eb9243e5293ba79e3c~SYf0uDEVj2292822928euoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1698527749;
        bh=KMahjoHxxEGT5gaBZBeFILgQTlTnM1MpN5QmTOlrbgg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=NpS6/cZUu5469ui0A5b4Affrh1LC9nZowLTonIS7cPKyDXrNdXVKaiyGJ1TnafE5y
         4LZwZlvKcCw+9knXLxqd9tEsMBJwbMd4urVuLB7SzQre8J+EYyRm/gtGPXy8T2oiHE
         yjjkGvf2Jw+yP7iqeks84/0G685vWSuoHbxoybrU=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20231028211549eucas1p2fc824cd9bc602e094c2b9bc40e72187b~SYf0VLXIT1087910879eucas1p2M;
        Sat, 28 Oct 2023 21:15:49 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id FC.57.37758.40A7D356; Sat, 28
        Oct 2023 22:15:48 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20231028211546eucas1p2147a423b26a6fa92be7e6c20df429da5~SYfyRbpOf1224812248eucas1p2A;
        Sat, 28 Oct 2023 21:15:46 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231028211546eusmtrp2c9f70e6608c90b52dc9e964b9cdca2d6~SYfyQ6t5Z1141411414eusmtrp2e;
        Sat, 28 Oct 2023 21:15:46 +0000 (GMT)
X-AuditID: cbfec7f5-7ffff7000002937e-05-653d7a045348
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id AF.F0.25043.20A7D356; Sat, 28
        Oct 2023 22:15:46 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20231028211546eusmtip1b8f4d77fa5acb0d4af2695620577282c~SYfyEc2tN0467404674eusmtip1Q;
        Sat, 28 Oct 2023 21:15:46 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
        Server (TLS) id 15.0.1497.2; Sat, 28 Oct 2023 22:15:46 +0100
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
        ([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Sat, 28 Oct
        2023 22:15:45 +0100
From:   Daniel Gomez <da.gomez@samsung.com>
To:     "minchan@kernel.org" <minchan@kernel.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "hughd@google.com" <hughd@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
CC:     "gost.dev@samsung.com" <gost.dev@samsung.com>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Daniel Gomez <da.gomez@samsung.com>
Subject: [RFC PATCH 07/11] shmem: remove huge arg from
 shmem_alloc_and_add_folio()
Thread-Topic: [RFC PATCH 07/11] shmem: remove huge arg from
        shmem_alloc_and_add_folio()
Thread-Index: AQHaCePqWfxF+qVFe0qg34umJ1pkKA==
Date:   Sat, 28 Oct 2023 21:15:45 +0000
Message-ID: <20231028211518.3424020-8-da.gomez@samsung.com>
In-Reply-To: <20231028211518.3424020-1-da.gomez@samsung.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKKsWRmVeSWpSXmKPExsWy7djPc7osVbapBoenWlrMWb+GzWL13X42
        i8tP+Cyefupjsdh7S9tiz96TLBaXd81hs7i35j+rxa4/O9gtbkx4ymix7Ot7dovdGxexWfz+
        MYfNgddjdsNFFo8Fm0o9Nq/Q8rh8ttRj06pONo9Nnyaxe5yY8ZvF4/MmuQCOKC6blNSczLLU
        In27BK6Mh5N2sxcsEqo4/ES4gfENXxcjJ4eEgInE2n3fWEBsIYEVjBKPJ8Z1MXIB2V8YJVbt
        Oc4I4XxmlHi9qgvI4QDruPuFEyK+nFHi1tclbBDdQEVfFnJBJM4wSlxf844FwlnJKLFp4kQm
        kCo2AU2JfSc3sYMkRARms0ocXtzBCJJgFqiTWPNsFgvICmGBEIk3TUEgpohApMTc2WALRAT0
        JG78nccMEmYRUJXY1FUIEuYVsJb413OOFcTmFLCRuP9tO1g5o4CsxKOVv9ghhotL3Hoynwni
        Y0GJRbP3MEPYYhL/dj1kg7B1JM5ef8IIYRtIbF26jwXCVpL407EQ6kigE6ZOYYOwtSWWLXzN
        DHGDoMTJmU/A3pUQaOKSOPX6A9QCF4kz0xvZIWxhiVfHt0DZMhL/d85nmsCoPQvJfbOQ7JiF
        ZMcsJDsWMLKsYhRPLS3OTU8tNs5LLdcrTswtLs1L10vOz93ECExpp/8d/7qDccWrj3qHGJk4
        GA8xSnAwK4nwMjvapArxpiRWVqUW5ccXleakFh9ilOZgURLnVU2RTxUSSE8sSc1OTS1ILYLJ
        MnFwSjUwzT56fvrH+S5Jb2ueTORgXruvRnfy3kX/47Nceh5cKwhaK+F/w/v8FYfY3Wm9yzYc
        uxozN3BCgRyPf0HqehHJYk8n72sSdVOrdng+5HMomH8raHUaj/S8GVdChRZmz91xeorGy9bW
        v3EsKtsu3tJVuVNqGvk1dFPtH5WdkeZp88ONLxxmVkt99+HISSE+Bp26vUcXx7rd9Vz/8jzT
        ZfcfK1ynar/surM7Uv+CzJY3YS+WrX9ZUJZbvmeFT0eE4bo1O3Rebr03a+PFhcvFWF7s9Q2K
        Kd3VKphTmefZ47nDmHf1zBR9sZ/Xe2X4vodfmLvcwNMkJe3huopzpecm1fkJxJ+I57YOSRAI
        O1z46ue7K0osxRmJhlrMRcWJAHkGjYrYAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIKsWRmVeSWpSXmKPExsVy+t/xu7pMVbapBp836VnMWb+GzWL13X42
        i8tP+Cyefupjsdh7S9tiz96TLBaXd81hs7i35j+rxa4/O9gtbkx4ymix7Ot7dovdGxexWfz+
        MYfNgddjdsNFFo8Fm0o9Nq/Q8rh8ttRj06pONo9Nnyaxe5yY8ZvF4/MmuQCOKD2bovzSklSF
        jPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2Mh5N2sxcsEqo4/ES4
        gfENXxcjB4eEgInE3S+cXYxcHEICSxklpk16y9rFyAkUl5HY+OUqlC0s8edaFxtE0UdGib9/
        HzOCJIQEzjBKnH9aDpFYySixb8kksASbgKbEvpOb2EESIgKzWSUOL+4ASzAL1EmseTaLBWS1
        sECIxJumIJCwiECkxIS2bkYIW0/ixt95zCAlLAKqEpu6CkHCvALWEv96zrGChIUEciX62zJB
        wpwCNhL3v21nA7EZBWQlHq38xQ6xSFzi1pP5TBD3C0gs2XOeGcIWlXj5+B/UXzoSZ68/YYSw
        DSS2Lt3HAmErSfzpWAh1MNA1U6ewQdjaEssWvmaGOEdQ4uTMJywTGKVnIVk3C0nLLCQts5C0
        LGBkWcUoklpanJueW2ykV5yYW1yal66XnJ+7iRGYlrYd+7llB+PKVx/1DjEycTAeYpTgYFYS
        4WV2tEkV4k1JrKxKLcqPLyrNSS0+xGgKDKGJzFKiyfnAxJhXEm9oZmBqaGJmaWBqaWasJM7r
        WdCRKCSQnliSmp2aWpBaBNPHxMEp1cBks26VznGhj91Xr5m8ZpLoz6jMnXtSun7dzUbri1qW
        397emvzNawZjSlfOxk1PpRNvmU88dWVWedtuOyEdi7rogBLmfxbM196sM01a8GzajgsT3yv6
        FC7w2KWf+uDmF2OWsP/lfQ+fJgXn2XS05d/aVZtWf/K8URvX5vuSoa+3ngtZd+oQ66+Enfu0
        /B5VqRjJrDnWedNwyRG9CCvWh+EHn39XfmolML3Inff9tR8xW7R0nIOVhc3v7Rf4WVJfrLx1
        MeN0dv4Lsda2kc9qzxwN/bTdusf+hZea09sjL2WYNp9vX6PEG6cvt9P5QV//a66Yuc/O/Utm
        d03/XTU72TEo9pztvSbThUm9S+Yqf01TYinOSDTUYi4qTgQA2WR+ZdQDAAA=
X-CMS-MailID: 20231028211546eucas1p2147a423b26a6fa92be7e6c20df429da5
X-Msg-Generator: CA
X-RootMTR: 20231028211546eucas1p2147a423b26a6fa92be7e6c20df429da5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231028211546eucas1p2147a423b26a6fa92be7e6c20df429da5
References: <20230919135536.2165715-1-da.gomez@samsung.com>
        <20231028211518.3424020-1-da.gomez@samsung.com>
        <CGME20231028211546eucas1p2147a423b26a6fa92be7e6c20df429da5@eucas1p2.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The huge flag is already part of of the memory allocation flag (gfp_t).
Make use of the VM_HUGEPAGE bit set by vma_thp_gfp_mask() to know if
the allocation must be a huge page.

Drop CONFIG_TRANSPARENT_HUGEPAGE check in shmem_alloc_and_add_folio()
as VM_HUGEPAGE won't be set unless THP config is enabled.

Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
---
 mm/shmem.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index e2893cf2287f..9d68211373c4 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1644,7 +1644,7 @@ static struct folio *shmem_alloc_folio(gfp_t gfp,
=20
 static struct folio *shmem_alloc_and_add_folio(gfp_t gfp,
 		struct inode *inode, pgoff_t index,
-		struct mm_struct *fault_mm, bool huge)
+		struct mm_struct *fault_mm)
 {
 	struct address_space *mapping =3D inode->i_mapping;
 	struct shmem_inode_info *info =3D SHMEM_I(inode);
@@ -1652,10 +1652,7 @@ static struct folio *shmem_alloc_and_add_folio(gfp_t=
 gfp,
 	long pages;
 	int error;
=20
-	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
-		huge =3D false;
-
-	if (huge) {
+	if (gfp & VM_HUGEPAGE) {
 		pages =3D HPAGE_PMD_NR;
 		index =3D round_down(index, HPAGE_PMD_NR);
=20
@@ -1690,7 +1687,7 @@ static struct folio *shmem_alloc_and_add_folio(gfp_t =
gfp,
 		if (xa_find(&mapping->i_pages, &index,
 				index + pages - 1, XA_PRESENT)) {
 			error =3D -EEXIST;
-		} else if (huge) {
+		} else if (gfp & VM_HUGEPAGE) {
 			count_vm_event(THP_FILE_FALLBACK);
 			count_vm_event(THP_FILE_FALLBACK_CHARGE);
 		}
@@ -2054,7 +2051,7 @@ static int shmem_get_folio_gfp(struct inode *inode, p=
goff_t index,
 		huge_gfp =3D vma_thp_gfp_mask(vma);
 		huge_gfp =3D limit_gfp_mask(huge_gfp, gfp);
 		folio =3D shmem_alloc_and_add_folio(huge_gfp,
-				inode, index, fault_mm, true);
+				inode, index, fault_mm);
 		if (!IS_ERR(folio)) {
 			count_vm_event(THP_FILE_ALLOC);
 			goto alloced;
@@ -2063,7 +2060,7 @@ static int shmem_get_folio_gfp(struct inode *inode, p=
goff_t index,
 			goto repeat;
 	}
=20
-	folio =3D shmem_alloc_and_add_folio(gfp, inode, index, fault_mm, false);
+	folio =3D shmem_alloc_and_add_folio(gfp, inode, index, fault_mm);
 	if (IS_ERR(folio)) {
 		error =3D PTR_ERR(folio);
 		if (error =3D=3D -EEXIST)
--=20
2.39.2
