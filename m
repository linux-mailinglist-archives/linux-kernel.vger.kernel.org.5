Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA4A77F197
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 09:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348652AbjHQH6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 03:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348638AbjHQH57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 03:57:59 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D0810C0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 00:57:57 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230817075753euoutp012e86e5f883fb49793abd26512531a868~8HKlhOWIr2117821178euoutp01L
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 07:57:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230817075753euoutp012e86e5f883fb49793abd26512531a868~8HKlhOWIr2117821178euoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1692259073;
        bh=t1UOJhGLbqx7AloARPOgpsKT0OFq2C+AfZ7PKw7cKas=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=o3WT+uO2tMeJ0KbHakKLbxK4MU+ck1hFxjJIlNwoGGkOZT8LNklRQuQGZwfnEnZ4M
         TutG6RZqjdQ8xVUcoR0s3aR7Y26ckJZ4/1iX/SmJMfszZr1Mjju12kFDdBUPy0VIP5
         xEiB/YPrslB9dUqavJqpSriLGruCAdfwheSGB6GA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230817075753eucas1p243d429af37226bc8957ebe6de05550cb~8HKlNF2Gt3249832498eucas1p2W;
        Thu, 17 Aug 2023 07:57:53 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id F2.6F.11320.103DDD46; Thu, 17
        Aug 2023 08:57:53 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230817075753eucas1p20d42667d772e96643b18c6bc1a87b112~8HKk1wXlD3249832498eucas1p2V;
        Thu, 17 Aug 2023 07:57:53 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230817075753eusmtrp131c204cad3d36b3ea1561a486f0df956~8HKk1BjLp1722917229eusmtrp1j;
        Thu, 17 Aug 2023 07:57:53 +0000 (GMT)
X-AuditID: cbfec7f4-993ff70000022c38-e4-64ddd301d0f0
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 85.D9.10549.003DDD46; Thu, 17
        Aug 2023 08:57:52 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230817075752eusmtip207582b636cabfaed71f2c0a2405bbc4e~8HKkqV0Le0551605516eusmtip2t;
        Thu, 17 Aug 2023 07:57:52 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) with Microsoft SMTP
        Server (TLS) id 15.0.1497.2; Thu, 17 Aug 2023 08:57:52 +0100
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
        ([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Thu, 17 Aug
        2023 08:57:52 +0100
From:   Daniel Gomez <da.gomez@samsung.com>
To:     David Hildenbrand <david@redhat.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "vishal.moola@gmail.com" <vishal.moola@gmail.com>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "yuzhao@google.com" <yuzhao@google.com>,
        "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
        "shy828301@gmail.com" <shy828301@gmail.com>
Subject: Re: [PATCH v2 3/3] madvise:madvise_free_pte_range(): don't use
 mapcount() against large folio for sharing check
Thread-Topic: [PATCH v2 3/3] madvise:madvise_free_pte_range(): don't use
        mapcount() against large folio for sharing check
Thread-Index: AQHZz3vpurV86lSwc0Wr64w4rsIXva/r8T+AgADNGgCAAAV0gIAAJCQAgAAQTgCAARkNgA==
Date:   Thu, 17 Aug 2023 07:57:52 +0000
Message-ID: <g6t5ldoy64lrurvuttfhw3kxc6tdtphbskxezyaocaadrhgkfb@kws4v6gewbh3>
In-Reply-To: <2b6cc6b6-8fcb-35ff-3d5b-e4a6068847d9@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [106.110.32.67]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <994AA9B08B1A534E9BED4AE8B38D7DC0@scsc.local>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOKsWRmVeSWpSXmKPExsWy7djP87qMl++mGBz6K2YxZ/0aNouv638x
        W1w5/YbJ4vKuOWwW99b8Z7VY9vU9u0XP7qmMFgtOLAYSGx8xWqzfd4PVovHzfUaL3z+A6t5N
        +MLqwOuxZt4aRo+ds+6yeyzYVOrRcuQtq8fmFVoei/e8ZPLYtKqTzWPTp0nsHidm/GbxeL/v
        KpvH501yAdxRXDYpqTmZZalF+nYJXBnrpu9iLJihXPF+xSLGBsbtUl2MnBwSAiYSHzZOYu5i
        5OIQEljBKNG3cRYrhPOFUWLpjgYo5zOjRMvUc6wwLVvaZ0MlljNKPF9ygA2u6vGyxVCZM4wS
        k9/+YwFpERJYySix+HMciM0moCmx7+QmdpAiEYFmVom+tyuZQBLCAlUSK7YdZOxi5ABKVEtc
        3VYNEhYRCJO49/U4I4jNIqAqcf/MGjYQm1fAV+LGnC9gJ3EK2Ensf7ScHcRmFJCVeLTyF5jN
        LCAucevJfCaIswUlFs3ewwxhi0n82/WQDcLWkTh7/QkjhG0gsXXpPhYIW1Gi49hNNog5OhIL
        dn+Csi0lmjf2Q83Xlli28DUzxD2CEidnPmEB+UtCYCaXxIvmu0wgv0gIuEh0TVaEmCks8er4
        FnYIW0bi9OQelgmM2rOQnDoLybpZSNbNQrJuFpJ1CxhZVzGKp5YW56anFhvlpZbrFSfmFpfm
        pesl5+duYgSmxdP/jn/Zwbj81Ue9Q4xMHIyHGCU4mJVEeHt4b6UI8aYkVlalFuXHF5XmpBYf
        YpTmYFES59W2PZksJJCeWJKanZpakFoEk2Xi4JRqYAovDFkU9V7rb/i3mNuvM8QSH4guT/3/
        fMeCv8xtacUlbVfYVBKWO2pZbxR6+t157T6R1y90nsqued97wdB35e75C1L55pq1iLClBRp8
        LWOsDhdI4dodlOHrJG4utf3Dnsue3fdY31lMtI7cHnQzbbqv7Sbrl7UvWE5+rlz7dWrxo4dH
        FO6bf1Q+Oscl+uSCokdCPaZy3GeCFz+/sbLmYfg9pq0Lj/Y0SIUreivJ53TOM/E6tF/qzK8d
        SwTmVX/Nm1FZ+Mm77ap26LTOI/JJxzMuGUpmL5y5bWdbYJt+eqfjWtdpNY+FA09VucWfE1Fu
        nDu949KC9/9KOENtDlgw+z/4uTer/BnjjhLnGUJKJ5VYijMSDbWYi4oTAUWhU3j6AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGKsWRmVeSWpSXmKPExsVy+t/xe7oMl++mGMxebmMxZ/0aNouv638x
        W1w5/YbJ4vKuOWwW99b8Z7VY9vU9u0XP7qmMFgtOLAYSGx8xWqzfd4PVovHzfUaL3z+A6t5N
        +MLqwOuxZt4aRo+ds+6yeyzYVOrRcuQtq8fmFVoei/e8ZPLYtKqTzWPTp0nsHidm/GbxeL/v
        KpvH501yAdxRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF
        +nYJehnrpu9iLJihXPF+xSLGBsbtUl2MnBwSAiYSW9pns3YxcnEICSxllGh7v4YFIiEjsfHL
        VVYIW1jiz7UuNoiij4wS54H+hXDOMErs2zkXqn0lo8SDM0eYQVrYBDQl9p3cxA6SEBFoZpXo
        e7uSCSQhLFAlsWLbQUYQW0SgWuL+8RMsEHaYxL2vx8HiLAKqEvfPrGEDsXkFfCVuzPkCs4FF
        ounHcrCjOAXsJPY/Ws4OYjMKyEo8WvkLzGYWEJe49WQ+E8ThAhJL9pxnhrBFJV4+/gf1kI7E
        2etPGCFsA4mtS/dBPa0o0XHsJhvEHB2JBbs/QdmWEs0b+6Hma0ssW/iaGeI4QYmTM5+wTGCU
        noVk9Swk7bOQtM9C0j4LSfsCRtZVjCKppcW56bnFhnrFibnFpXnpesn5uZsYgQlu27Gfm3cw
        znv1Ue8QIxMH4yFGCQ5mJRHeHt5bKUK8KYmVValF+fFFpTmpxYcYTYGBN5FZSjQ5H5hi80ri
        Dc0MTA1NzCwNTC3NjJXEeT0LOhKFBNITS1KzU1MLUotg+pg4OKUamNIUj676K+8wf329u+eF
        5Crh8o1fMtxcZZnVJ/GmhWy5sOgIv04fK6fFiillGVfNfes52W+J6K8PzS6IDWgRYZ17/P2J
        r/tcp/k/1Dit9vnmTfkgxe3S2S4lIbwfbnO3lT/oXGZ6gOW33N6+90XtSuczbWqt/vz7/0Bn
        3n+Xb71TXl0L9v/pdmHWtTQmnwnh5pNV/FfIbvz+LTh2dcfuzNO2pzWLNHSi9yj4+MhxzNn9
        xjZ9x+wXvXecG4972XjcWnpV+qO86ov3q7wkP0nIH+WXNnI5dGLaVflrm1+HfemWWDHt+s/t
        ZaLz0owPqojn5/jU3XjupN23s7VCV+LY8+aAZe18jM+e7LzsceGPuRJLcUaioRZzUXEiAFlf
        miP5AwAA
X-CMS-MailID: 20230817075753eucas1p20d42667d772e96643b18c6bc1a87b112
X-Msg-Generator: CA
X-RootMTR: 20230815132509eucas1p1b34b2852a9c4efe743c8da82867c4cc3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230815132509eucas1p1b34b2852a9c4efe743c8da82867c4cc3
References: <20230808020917.2230692-1-fengwei.yin@intel.com>
        <20230808020917.2230692-4-fengwei.yin@intel.com>
        <CGME20230815132509eucas1p1b34b2852a9c4efe743c8da82867c4cc3@eucas1p1.samsung.com>
        <4jvrmdpyteny5vaqmcrctzrovap2oy2zuukybbhfqyqbbb5xmy@ufgxufss2ngw>
        <2bfa1931-1fc6-5d6f-cba1-c7a9eb8a279a@intel.com>
        <svdxtqiihsjwcbxjp67s6cteprhoxgypf7rjrk2v73ppyn2ogp@ee4ru6vgspl4>
        <4412ad3c-ebed-40a4-8f4e-83bb1b53b686@intel.com>
        <a4k27pleianmjbt2d5lqlmwqv7k2pujzfv75y2q564vrcdye3w@xf3wcifffxkx>
        <2b6cc6b6-8fcb-35ff-3d5b-e4a6068847d9@redhat.com>
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

On Wed, Aug 16, 2023 at 05:11:54PM +0200, David Hildenbrand wrote:
> On 16.08.23 16:13, Daniel Gomez wrote:
> > On Wed, Aug 16, 2023 at 08:04:11PM +0800, Yin, Fengwei wrote:
> > >
> > >
> > > On 8/16/2023 7:44 PM, Daniel Gomez wrote:
> > > > On Wed, Aug 16, 2023 at 07:30:35AM +0800, Yin Fengwei wrote:
> > > > >
> > > > >
> > > > > On 8/15/23 21:25, Daniel Gomez wrote:
> > > > > > Hi Yin,
> > > > > > On Tue, Aug 08, 2023 at 10:09:17AM +0800, Yin Fengwei wrote:
> > > > > > > Commit 98b211d6415f ("madvise: convert madvise_free_pte_range=
() to use a
> > > > > > > folio") replaced the page_mapcount() with folio_mapcount() to=
 check
> > > > > > > whether the folio is shared by other mapping.
> > > > > > >
> > > > > > > It's not correct for large folios. folio_mapcount() returns t=
he total
> > > > > > > mapcount of large folio which is not suitable to detect wheth=
er the folio
> > > > > > > is shared.
> > > > > > >
> > > > > > > Use folio_estimated_sharers() which returns a estimated numbe=
r of shares.
> > > > > > > That means it's not 100% correct. It should be OK for madvise=
 case here.
> > > > > >
> > > > > > I'm trying to understand why it should be ok for madvise this c=
hange, so
> > > > > > I hope it's okay to ask you few questions.
> > > > > >
> > > > > > folio_mapcount() calculates the total maps for all the subpages=
 of a
> > > > > > folio. However, the folio_estimated_sharers does it only for th=
e first
> > > > > > subpage making it not true for large folios. Then, wouldn't thi=
s change
> > > > > > drop support for large folios?
> > > > > I saw David explained this very well in another mail.
> > > > >
> > > > > >
> > > > > > Seems like folio_entire_mapcount() is not accurate either becau=
se of it
> > > > > > does not inclue PTE-mapped sub-pages which I think we need here=
. Hence,
> > > > > > the folio_mapcount(). Could this be something missing in the te=
st side?
> > >  > >
> > > > > > I tried to replicate the setup with CONFIG_TRANSPARENT_HUGEPAGE=
 but
> > > > > > seems like I'm not able to do it:
> > > > > >
> > > > > > ./cow
> > > > > > # [INFO] detected THP size: 2048 KiB
> > > > > > # [INFO] detected hugetlb size: 2048 KiB
> > > > > > # [INFO] detected hugetlb size: 1048576 KiB
> > > > > > # [INFO] huge zeropage is enabled
> > > > > > TAP version 13
> > > > > > 1..166
> > > > > > # [INFO] Anonymous memory tests in private mappings
> > > > > > # [RUN] Basic COW after fork() ... with base page
> > > > > > not ok 1 MADV_NOHUGEPAGE failed
> > > > > > # [RUN] Basic COW after fork() ... with swapped out base page
> > > > > > not ok 2 MADV_NOHUGEPAGE failed
> > > > > > # [RUN] Basic COW after fork() ... with THP
> > > > > > not ok 3 MADV_HUGEPAGE failed
> > > > > > # [RUN] Basic COW after fork() ... with swapped-out THP
> > > > > > not ok 4 MADV_HUGEPAGE failed
> > > > > > # [RUN] Basic COW after fork() ... with PTE-mapped THP
> > > > > > not ok 5 MADV_HUGEPAGE failed
> > > > > > # [RUN] Basic COW after fork() ... with swapped-out, PTE-mapped=
 THP
> > > > > > not ok 6 MADV_HUGEPAGE failed
> > > > > > ...
> > > > > Can you post the MADV_PAGEOUT and PTE-mapped THP related testing =
result?
> > > > > And I suppose swap need be enabled also for the testing.
> > > >
> > > > You may find a dump of the logs in the link below with system infor=
mation. Let me
> > > > know if you find something wrong in my setup or if you need somethi=
ng else.
> > > > Besides CONFIG_TRANSPARENT_HUGEPAGE, CONFIG_SWAP is also enabled in=
 the kernel.
> > > >
> > > > https://gitlab.com/-/snippets/2584135
> > > >
> > > > Also, strace reports ENOSYS for MADV_*:
> > > > madvise(0x7f2912465000, 4096, MADV_NOHUGEPAGE) =3D -1 ENOSYS (Funct=
ion not implemented)
> > > > madvise(0x7f2912000000, 2097152, MADV_HUGEPAGE) =3D -1 ENOSYS (Func=
tion not implemented)
> > > O. The problem here is MADV_HUGEPAGE/MADV_NOHUGEPAGE doesn't work.
> > > Do you have CONFIG_ADVISE_SYSCALLS enabled?
> > It worked after I enabled the conf. Some tests failed and some were
> > skipped. But I managed to reproduce the issue now, thanks Yin!
> >
> > Bail out! 4 out of 166 tests failed
> > # Totals: pass:146 fail:4 xfail:0 xpass:0 skip:16 error:0
> >
>
> These hugetlb that are failing are known failures.

Hi David, thanks for letting me know. Also, thanks for the description
of the folio mapping in the other mail.
>
> --
> Cheers,
>
> David / dhildenb
>=
