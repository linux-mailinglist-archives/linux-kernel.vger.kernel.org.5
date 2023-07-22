Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC96075D862
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 02:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjGVAlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 20:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjGVAlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 20:41:17 -0400
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B1C3C1D;
        Fri, 21 Jul 2023 17:41:07 -0700 (PDT)
Received: from imladris.home.surriel.com ([10.0.13.28] helo=imladris.surriel.com)
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <riel@shelob.surriel.com>)
        id 1qN0fq-0001Ui-0w;
        Fri, 21 Jul 2023 20:40:42 -0400
Message-ID: <74c0d1b900d8f518bc152478682a353c29e0faa3.camel@surriel.com>
Subject: Re: [PATCH] mm,ima,kexec: use memblock_free_late from
 ima_free_kexec_buffer
From:   Rik van Riel <riel@surriel.com>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Mike Rapoport <rppt@kernel.org>, devicetree@vger.kernel.org,
        x86@kernel.org, Juergen Gross <jgross@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Date:   Fri, 21 Jul 2023 20:40:41 -0400
In-Reply-To: <20230721193815.GA1679711-robh@kernel.org>
References: <20230720101431.71640c8a@imladris.surriel.com>
         <20230721193815.GA1679711-robh@kernel.org>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-arL+6ARjPI5tJ5FA86BZ"
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
Sender: riel@surriel.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-arL+6ARjPI5tJ5FA86BZ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2023-07-21 at 13:38 -0600, Rob Herring wrote:
> On Thu, Jul 20, 2023 at 10:14:31AM -0400, Rik van Riel wrote:
> > The code calling ima_free_kexec_buffer runs long after the memblock
> > allocator has already been torn down, potentially resulting in a
> > use
> > after free in memblock_isolate_range.
> >=20
> > With KASAN or KFENCE, this use after free will result in a BUG
> > from the idle task, and a subsequent kernel panic.
> >=20
> > Switch ima_free_kexec_buffer over to memblock_free_late to avoid
> > that issue.
> >=20
> > Fixes: fee3ff99bc67 ("powerpc: Move arch independent ima kexec
> > functions to drivers/of/kexec.c")
>=20
> Fixes: b69a2afd5afc ("x86/kexec: Carry forward IMA measurement log on
> kexec")
>=20
Thank you for digging further back in the history of that code.

> Acked-by: Rob Herring <robh@kernel.org>
>=20
> (I'm assuming someone else is taking this)

I hope so, but I don't know who...

--=20
All Rights Reversed.

--=-arL+6ARjPI5tJ5FA86BZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAmS7JYkACgkQznnekoTE
3oNweggAoTeYhkK7Bv29fhN4TQ3HPkHD/lkY8tc+Kul8fw1jvDSGfWdYOj8oB1hb
WyDd+U2i0hJvA4ox324sIHxhjx3+WfZgWwRVu8yTB13WjgM6Z+7LaBMvhbHGXq+W
bihdg26uumxREuF8slsvxAnhVIC5ZRbfGXFnvTo7T3ufJ7xSHT82WF+2+Zp6S7gs
9kMFRrnb1lafUBomKHm/g4iaFxDTYYxPt73aJzPEXBSDwkjuGiJpUoLKgH5X3u/o
6WI1/2UMzJR+K3dCI1ps6pZSG++JfR64OZDvKKR/SqbOW2yhtCING16b4SbD3HjA
GGvP+81Bg3iZdWZCdmhRsA5AZ3t0oA==
=6DM6
-----END PGP SIGNATURE-----

--=-arL+6ARjPI5tJ5FA86BZ--
