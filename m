Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C384E782AC3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 15:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233222AbjHUNpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 09:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbjHUNpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 09:45:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE89CE
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 06:45:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70A6C612D8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 13:45:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6EA5C433C7;
        Mon, 21 Aug 2023 13:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692625540;
        bh=iTPqdQ/uXa+eLP0dIZJz9UkFPdREyIBv6Qy4NpNiorQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NyJrY7pw9Oh6/i/LmANZoWw2D3xBHfz7xPLRTeD/vt+bCsImFh7sxHBwfOr2hGvSm
         9DCThK/LA28uVSOMmjEikZ+CHQudlWl633+i+Pa5Z7AQzkgP3J1crsZDsaEbDvATIF
         VjWUqa+dCeqY7lALlFMNkafJFf/P5RdifspbFu/rPMiC2N0f5k0SKtqbL1w+PGLAoo
         4A83nElstg92Cx8mm/MFBjgbmhUMtDHTuiK8qz9fxRdG5A0VVYWnvKKAId/HHxdKce
         lJeFtA4TyRf9Dn5GzdB7Vji1YpjhHSyTJ+/5nxf+OqUU589FwODuO9Bor9/xUBaAH5
         0X7/D/sVYXPrA==
Message-ID: <1022762b-d106-8dfe-7a4e-817c11981c01@kernel.org>
Date:   Mon, 21 Aug 2023 15:45:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: struct_size() using sizeof() vs offsetof()
Content-Language: en-US
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
References: <74e8cf91-d095-33e3-c548-34d80b691089@kernel.org>
 <55bb7e4f633340db9a9c013b91afedd6@AcuMS.aculab.com>
From:   Alejandro Colomar <alx@kernel.org>
Organization: Linux
In-Reply-To: <55bb7e4f633340db9a9c013b91afedd6@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On 2023-08-21 10:16, David Laight wrote:
> From: Alejandro Colomar
>> Sent: Thursday, August 17, 2023 1:23 AM
>>
>> 	strcpy(s->fam, "Hello, sizeof!");
>> 	p =3D (char *) s + sizeof(struct s);
>> 	puts(p);
>=20
> Why on earth would you expect the above to do anything sensible?

This trivial example may seem unreasonable, but I've seen code that
does something like that (but more complex).  Not in the kernel, but
in an nginx subproject:

<https://github.com/nginx/unit/blob/47ff51009fa05d83bb67cd5db16829ab4c008=
1d7/src/wasm/nxt_wasm.c#L108>
<https://github.com/nginx/unit/blob/47ff51009fa05d83bb67cd5db16829ab4c008=
1d7/src/wasm/nxt_wasm.c#L160>

It uses pointer arithmetic with sizeof to get the offset of the FAM,
instead of calling it by its name.

>=20
> It is a shame you can just use offsetof(type, member[count + 1]).
> That is fine for constants, but the C language requires offsetof()
> to be a compile-time constant - I can't help feeling the standards
> body didn't consider non-constant array offsets.

This helped catch a bug last week, so I think it's good that the
standard disallows it.

You can always write a macro offsetof_fam(type, fam, n) which does
that.  In fact, I've written it, and will be part of the patch that
I'll propose.  It is much safer than if offsetof() would just
accept that, as I can embed some static assertions within that
macro.

Here's a look at the file I've been testing before submitting a patch.
A lot of what you'll see here is similar to what I pretend to send in
a patch.


$ cat alx_cdefs.h=20
/* Copyright (C) 2023 Alejandro Colomar <alx@kernel.org> */
/* SPDX-License-Identifier: GPL-3.0-or-later */

#ifndef ALX_CDEFS_H_INCLUDED_
#define ALX_CDEFS_H_INCLUDED_


#include <stddef.h>
#include <sys/param.h>


#define sizeof_array(a)      (sizeof(a) + must_be_array(a))
#define nitems(a)            (sizeof_array(a) / sizeof((a)[0]))
#define memberof(T, member)  ((T){}.member)

#define sizeof_incomplete(x)                                             =
     \
(                                                                        =
     \
	sizeof(                                                               \
		struct {                                                      \
			max_align_t  a;                                       \
			typeof(x)    inc;                                     \
		}                                                             \
	)                                                                     \
	- sizeof(max_align_t)                                                 \
)

#define sizeof_fam0(T, fam)  (sizeof(memberof(T, fam[0])) + must_be_fam(T=
, fam))
#define sizeof_fam(T, fam, n)     (sizeof_fam0(T, fam) * (n))
#define offsetof_fam(T, fam, n)   (offsetof(T, fam) + sizeof_fam(T, fam, =
n))
#define sizeof_struct(T, fam, n)  MAX(sizeof(T), offsetof_fam(T, fam, n))=



#define is_zero_sizeof(z)     (sizeof_incomplete(z) =3D=3D 0)
#define is_same_type(a, b)    __builtin_types_compatible_p(a, b)
#define is_same_typeof(a, b)  is_same_type(typeof(a), typeof(b))
#define is_array(a)           (!is_same_typeof(a, &(a)[0]))


#define must_be(e)                                                       =
     \
(                                                                        =
     \
	0 * (int) sizeof(                                                     \
		struct {                                                      \
			_Static_assert(e, "");                                \
			int ISO_C_forbids_a_struct_with_no_members_;          \
		}                                                             \
	)                                                                     \
)


#define must_be_array(a)        must_be(is_array(a))
#define must_be_zero_sizeof(z)  must_be(is_zero_sizeof(z))

#define must_be_fam(T, fam)                                              =
 \
    (must_be_array(memberof(T, fam)) + must_be_zero_sizeof(memberof(T, fa=
m)))


#endif /* ALX_CDEFS_H_INCLUDED_ */


> (The compiler for a well known OS won't compile that (or anything
> that looks like it) even for a constant array subscript!)
>=20
> The actual problem with using offsetof() is that you might end
> up with something smaller than the structure size.
> (When the variable sized array is smaller than the padding.)

That's why MAX().

>=20
> While max() will generate a constant for constant input, it
> will be a real compare for non-constant input.

If the input was non-constant, then it would already have been
non-constant with the current code.  I don't think MAX() will
make it worse.

>=20
> 	David

Cheers,
Alex


--=20
<http://www.alejandro-colomar.es/>
GPG key fingerprint: A9348594CE31283A826FBDD8D57633D441E25BB5

