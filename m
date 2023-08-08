Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07BBC773F40
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbjHHQou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233273AbjHHQoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:44:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E70691BF
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:56:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81A2C624AD
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 11:10:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19FC2C433C8;
        Tue,  8 Aug 2023 11:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691493011;
        bh=19pV4hQvMhWN4VhmYApfZmIgWsEXTM2Lh3IfDUNTGGA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iCQDO9G8ji1H+6GdiGshIIyY4PytBWNaJy2SZxah+iwRTvhxCieLi7wxdr1fUBO3B
         tsrUCanSGrqSArW8VW68g3Xk6dzzFT32odY1shRfrCFiFh/5L93oIhAWyCmr5VNBxs
         CIBlDYyCYnFIzsilA1myxnXm3XhD2LILC2lqswJjBhGdsLXcsD0z8UO8Hp6WVNA4wv
         Hm++fKFFoFtq1LZZo6cPi32s8mJ0sc8jRYvjRPiSGWY33q13ERcM8/fBpi6nvZbqB7
         N2gKTebQyZWb++hTRe22D2/OQo7EEDPa5TBzeR5j87vg6+eCMhPHSuaEvo54YYMgOJ
         OwMDKNeyY7eNg==
Date:   Tue, 8 Aug 2023 12:09:57 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Will Deacon <will@kernel.org>, Hugh Dickins <hughd@google.com>,
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
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 12/32] mm/vmalloc: vmalloc_to_page() use
 pte_offset_kernel()
Message-ID: <59946f0b-2a31-4bb2-a5a5-a051f3978c26@sirena.org.uk>
References: <42279f1f-7b82-40dc-8546-86171018729c@sirena.org.uk>
 <901ae88d-ad0c-4e9d-b199-f1566cc62a00@lucifer.local>
 <c2358f37-ebaa-44d1-b443-ff91bdedc00b@sirena.org.uk>
 <977ddee4-35f0-fcd1-2fd-1c3057e7ea2a@google.com>
 <fbb2b76c-bc5c-4d75-b8cd-37479de688d4@sirena.org.uk>
 <b479b946-f052-eb75-295d-6fa7c2d8ce8e@google.com>
 <591b5253-47f0-440c-84b6-7786ff59667d@sirena.org.uk>
 <20230720103227.GB11034@willie-the-truck>
 <df264993-107c-44a1-a8ff-245bce044206@sirena.org.uk>
 <88bb7f30-cbfe-feb4-1101-b7c98843652d@leemhuis.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eZf2JqvLz6LnNLGw"
Content-Disposition: inline
In-Reply-To: <88bb7f30-cbfe-feb4-1101-b7c98843652d@leemhuis.info>
X-Cookie: You need not be present to win.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eZf2JqvLz6LnNLGw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 08, 2023 at 07:52:43AM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:

> Hi Mark, just wondering did anything come out of this and is this still
> happening? I'm just wondering, as I still have this on my list of
> tracked regressions.

It's fixed.

--eZf2JqvLz6LnNLGw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTSIoUACgkQJNaLcl1U
h9BB9gf8D/0tBbXWlvputjizTyP1NhPhcuKIekWzHEv5JO2TVYu3O1C0SiegHl+5
L5yPFNALZklT8IjxaY309Fs2oSMY9sETOZGYuMUvPW3Imn2q82NQf/UIxEy6SRAI
W1dmnrXqgMqeJ+njvCeFHoIrTW2B3LvXMaGet06Ju2LPQDnHCRYr9TEAIUYtsvau
a09b83gbjcqwxfwoIGpw8K9/kAVPCBNNKg/6GTpxpqSR2Q9UBM4Y/JYsMnc7l/i0
zBDLETGSBpc5WIgUdJ2nfEacA86G8RTDML9FJlqk5vgrgggb1OFnlsmV48ylrLI3
BgXHZ5r1q+F935f9OM+x8BvoeESSyg==
=ff0m
-----END PGP SIGNATURE-----

--eZf2JqvLz6LnNLGw--
