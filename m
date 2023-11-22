Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C41FB7F44E7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 12:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343709AbjKVL1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 06:27:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343602AbjKVL1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 06:27:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EE4D8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 03:27:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2425C433C8;
        Wed, 22 Nov 2023 11:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700652446;
        bh=Q7EDA56ebnC1dz/bS3pK4j1SAZ6zZU+SsLg6kzN3VwY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jCBuicab5eN/7loQy8rubKEUpqjuo8P3/jMJNWi62/qP6Eh3J9dVTe1nG/vDs8UNy
         1CL1H/eTzPHHl4jJyPkaShetJrEYfALNS88SpjYMZqnWZOPGX1s7R5YeypWNu9BGHs
         D+HTmlYp82LG6M2oBNqGVHnYAesZgtRSZPfGNZpdblLHniHQk+sbPoim9kzpb1McTR
         oSWdrO7fWojSE3FfYLKFCsAG+2zn9qRuxJXoK4cFd/frzMpVAornxYvqRvfUszslqH
         KMLegllvfbIU2V28Suq+hihqbRbr14ZRuWYtYEwGKeBDDEaia9kFiu9Hr9MnUJHTa9
         +JQ8Cew4tJvQg==
Date:   Wed, 22 Nov 2023 11:27:22 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     chengming.zhou@linux.dev, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v5 6/9] slub: Delay freezing of partial slabs
Message-ID: <ZV3lmlXCBOgbqe3w@finisterre.sirena.org.uk>
References: <20231102032330.1036151-1-chengming.zhou@linux.dev>
 <20231102032330.1036151-7-chengming.zhou@linux.dev>
 <4f3bc1bd-ea87-465d-b58a-0ed57b15187b@sirena.org.uk>
 <83ff4b9e-94f1-8b35-1233-3dd414ea4dfe@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1h4O2PMLWdrJT9Mu"
Content-Disposition: inline
In-Reply-To: <83ff4b9e-94f1-8b35-1233-3dd414ea4dfe@suse.cz>
X-Cookie: Slow day.  Practice crawling.
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1h4O2PMLWdrJT9Mu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 10:37:39AM +0100, Vlastimil Babka wrote:

> Can you try this, please?

> Subject: [PATCH] mm/slub: try to fix hangs without cmpxchg64/128
>=20
> If we don't have cmpxchg64/128 and resort to slab_lock()/slab_unlock()
> which uses PG_locked, we can get RMW with the newly introduced
> slab_set/clear_node_partial() operation that modify PG_workingset so all
> the operations have to be atomic now.

That seems to resolve the issue:

  https://validation.linaro.org/scheduler/job/4018096

Tested-by: Mark Brown <broonie@kernel.org>

Thanks!

--1h4O2PMLWdrJT9Mu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVd5ZoACgkQJNaLcl1U
h9CRxwf8D5LmbkdF3hZYr7ZtHbfy5umdIWqn6+wENLFqP5DvsdRvfjS5kcSvTlE6
Rk/R9DR9fCWubOmZkY+N8MU98KhJoDWRu32KOS3zjsMSdhPOuU/Cbv/22k+Ric0a
2I5lJjrrLaoZjLTDBKpxsFVzka4N57+UBzYJYfu+iJz/viEV6DhGEuRBIobCB8uF
27/oHArtUuIzZJ0RDXUFAp39M3VSB+/l0yzXu+x0Jk0Tgwq/MbdfR2e6wwo9LHyK
0zlSYceqQRR0N968Rf6yUy2+fVAUrYNRMNOCrvyKW0gvj6+lPUo4XPM10ShVrz7d
tnmTfwCxPpTR7LJ82VKYBm6YLRrayw==
=Rnlh
-----END PGP SIGNATURE-----

--1h4O2PMLWdrJT9Mu--
