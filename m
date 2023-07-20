Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA9E975ADC3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 14:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbjGTMGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 08:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjGTMGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 08:06:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C81010F5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 05:06:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0814561A59
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 12:06:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5A00C433C7;
        Thu, 20 Jul 2023 12:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689854807;
        bh=jPdP9GZazbPohmSBfvulF4WU7xmAHLyL6Lam/41SMK4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rGN/cnm3vfJTU7YKAOi15so7isOJgRbZG+SF58jILbUTzo3YcIOEPPB8e+ZwwyJoI
         l06P2eV1tsjFlfgIXVdA4KSxgeyF2lN/ZT5F3ZS4Ce5yvgkMFptj6UIGbZPNSKLttd
         uhpm61nWtJ09mRflHOhvZsxLEbLgyrbrfzTHxS/15fsE9BsyKABdispuWJSSVWMrpF
         gOwL/1yzEZUhLIGFWPypadEVBxYGTOpb8H4jUFfRBVj76r6YY5FWgyW0H2L/jxieyw
         V6AfO5cGMBovSMtBWHalk9atTmh5p5EOy8GOfOc3/3OdatSAP+HHLqe9YTpPeRS5T3
         LgfTolpHI8sOg==
Date:   Thu, 20 Jul 2023 13:06:36 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     Hugh Dickins <hughd@google.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Yang Shi <shy828301@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Yu Zhao <yuzhao@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Steven Price <steven.price@arm.com>,
        SeongJae Park <sj@kernel.org>,
        Huang Ying <ying.huang@intel.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zack Rusin <zackr@vmware.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Song Liu <song@kernel.org>,
        Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        regressions@leemhuis.info, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 12/32] mm/vmalloc: vmalloc_to_page() use
 pte_offset_kernel()
Message-ID: <df264993-107c-44a1-a8ff-245bce044206@sirena.org.uk>
References: <c1c9a74a-bc5b-15ea-e5d2-8ec34bc921d@google.com>
 <696386a-84f8-b33c-82e5-f865ed6eb39@google.com>
 <42279f1f-7b82-40dc-8546-86171018729c@sirena.org.uk>
 <901ae88d-ad0c-4e9d-b199-f1566cc62a00@lucifer.local>
 <c2358f37-ebaa-44d1-b443-ff91bdedc00b@sirena.org.uk>
 <977ddee4-35f0-fcd1-2fd-1c3057e7ea2a@google.com>
 <fbb2b76c-bc5c-4d75-b8cd-37479de688d4@sirena.org.uk>
 <b479b946-f052-eb75-295d-6fa7c2d8ce8e@google.com>
 <591b5253-47f0-440c-84b6-7786ff59667d@sirena.org.uk>
 <20230720103227.GB11034@willie-the-truck>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Bb9JqOrF/z0TC5UB"
Content-Disposition: inline
In-Reply-To: <20230720103227.GB11034@willie-the-truck>
X-Cookie: Ginger snap.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Bb9JqOrF/z0TC5UB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 20, 2023 at 11:32:28AM +0100, Will Deacon wrote:
> On Tue, Jul 11, 2023 at 06:57:33PM +0100, Mark Brown wrote:

> > Still investigating but I'm pretty convinced this is nothing to do with
> > your commit/series and is just common or garden memory corruption that
> > just happens to get tickled by your changes.  Sorry for the noise.

> Did you get to the bottom of this? If not, do you have a reliable way to
> reproduce the problem? I don't like the sound of memory corruption :(

Not to the bottom of it, but getting there - I isolated the issue to
something in the unregistration path for thermal zones but didn't manage
to figure out exactly what.  There was some indication it might be a use
after free but I'm not convinced.

I have a reliable way to reproduce this if you have a pine64plus, it
also shows up a lot on the Libretech Tritium but not quite so reliably
as pine64plus since Hugh's changes.  Equally pine64plus was rock solid
until those so there's some timing/environment thing going on which
makes the issue manifest obviously, I expect you should be able to
trigger the issue by unregistering a thermal driver but the effects
might not be visible.

There is a change on the list to make the Allwinner SoCs not trigger the
issue during boot (their thermal driver refuses to register if any one
zone fails but most of their SoCs have multiple thermal zones with only
one fully described) but it needs fixing either way.

--Bb9JqOrF/z0TC5UB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmS5I0sACgkQJNaLcl1U
h9CXgwf8Dw3YMYw4WOhw/YJtPAAANuKw+Zy86uChY4Ts5qPQSbVSwU3C+HSO1kz6
rsyG3dwIfPq1Zj93/9VIw6rWvIaAFRT8ahat1yP5iBmmphKSzCmDMmBiy3JV26v1
GbIX/dm/qVRmC6MzN/iom/XVWSc7nByWSBxjmuEUe535oSeScoVgo3REv/NDQalm
JVTJ3R5/C0ZTiUzrlUPs/DNFGNVbJIEzDd2KxMQ82GzSDK4G+wVUEpfd9rWkFEC/
HAttaNYB/xgrYzkdgE94p7wQuXo1Ni7ggL3/2zVwr1IZEPr6IyoKipgGkGeJF5bX
4wMSGLbOh0p/lU1O3vFdo6mnxFeYUA==
=jXeg
-----END PGP SIGNATURE-----

--Bb9JqOrF/z0TC5UB--
