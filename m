Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A982783D92
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 12:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234621AbjHVKHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 06:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231998AbjHVKHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 06:07:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C8B18B;
        Tue, 22 Aug 2023 03:07:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC4D961EA9;
        Tue, 22 Aug 2023 10:07:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C88F1C433C8;
        Tue, 22 Aug 2023 10:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692698869;
        bh=0ZPGrRZRUWkkEZpVYAJWUY54RNL1FGjWiIVHPrXvI4A=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=WBifWWNdkmudUA6iIY+XTIJQtdWpoFy3ImtFfpxmIPUxQTqMKyDIz5Y53G7tySIeO
         PbYPotTHNqEL518JaM1DldT9BzdKdPnDS/CH96eu9UMg5gigvY268Mca1pS2EFEirs
         DWO15If0s1fSTWK9T7VB/5yJM8EBwLAR/zQ/VbOuFMyTE7WM+dqRDrvPGybMZipnxk
         EuI7Jqg74Q5jKX5JIhqcpFP7MXUCj29BDipu6mNzGPziUEBQwCKyre3YEoqLnkJiWu
         hUM1uK0Nil9xf2rLEVrODc0R49eMq+mP/kWG9MN5busFzQuQ+WNWe/Ze5TBOyQc4/8
         tR5eMIgw0p0gw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 22 Aug 2023 13:07:46 +0300
Message-Id: <CUYZO49LFVMX.1INU1A3LPM2MP@suppilovahvero>
Cc:     <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 3/8] selftests/sgx: Handle relocations in test enclave
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Jo Van Bulck" <jo.vanbulck@cs.kuleuven.be>, <kai.huang@intel.com>,
        <linux-sgx@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.14.0
References: <20230808193145.8860-1-jo.vanbulck@cs.kuleuven.be>
 <20230808193145.8860-4-jo.vanbulck@cs.kuleuven.be>
 <CUP5FP8OHD3I.2MUE3TTRVNRTQ@suppilovahvero>
 <d6db0aed-8e08-d850-b952-d8b102624669@cs.kuleuven.be>
In-Reply-To: <d6db0aed-8e08-d850-b952-d8b102624669@cs.kuleuven.be>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat Aug 19, 2023 at 3:32 AM EEST, Jo Van Bulck wrote:
> On 10.08.23 13:32, Jarkko Sakkinen wrote:
> > What happens if I only apply 1/8 and 2/8 from this patch set?
>
> This would work fine for gcc -O0/1/2/3, as encl_op_array happens to be=20
> locally initialized:
>
> 00000000000023f4 <encl_body>:
>       /* snipped */
>       2408:       48 8d 05 ec fe ff ff    lea    -0x114(%rip),%rax
> # 22fb <do_encl_op_put_to_buf>
>       240f:       48 89 45 b0             mov    %rax,-0x50(%rbp)
>       2413:       48 8d 05 18 ff ff ff    lea    -0xe8(%rip),%rax
> # 2332 <do_encl_op_get_from_buf>
>       241a:       48 89 45 b8             mov    %rax,-0x48(%rbp)
>       241e:       48 8d 05 44 ff ff ff    lea    -0xbc(%rip),%rax
> # 2369 <do_encl_op_put_to_addr>
>       /* snipped */
>
> However, when compiling with -Os, the initialization proceeds through a=
=20
> prepared copy from .data with hard-coded (ie non RIP-relative) function=
=20
> addresses:
>
>  > 00000000000021b5 <encl_body>:
>  >      /* snipped */
>  >      21bc:       48 8d 35 3d 2e 00 00    lea    0x2e3d(%rip),%rsi
>  > # 5000 <encl_buffer+0x2000>
>  >      21c3:       48 8d 7c 24 b8          lea    -0x48(%rsp),%rdi
>  >      21c8:       b9 10 00 00 00          mov    $0x10,%ecx
>  >      21cd:       f3 a5                   rep movsl %ds:(%rsi),%es:(%rd=
i)
>  >      /* snipped */

Thank you for the explanation.

> > I'm just wondering why there is no mention of "-static-pie" here.
>
> This patch 3/8 is expected to be applied on top of 2/8 which adds=20
> "-static-pie". While "-static-pie" is necessary to generate proper,=20
> position-independent code when referencing global variables, there may=20
> still be relocations left. These are normally handled by glibc on=20
> startup, but we don't have that in the test enclave, so this commit=20
> explicitly handles the (only) relocations for encl_op_array.
>
> When only applying 2/8, gcc generates correct code with -O0/1/2/3, as=20
> the local encl_op_array initialization happens to be initialized in=20
> encl_body:
>
> >> +extern uint8_t __attribute__((visibility("hidden"))) __enclave_base;
> >=20
> > I'd rename this as __encl_base to be consistent with other naming here.
> >=20
> > You could also declare for convenience and clarity:
> >=20
> > 	static const uint64_t encl_base =3D (uint64_t)&__encl_base;
> >=20
>
> Thanks, makes sense!

Great!

> >> +
> >> +void (*encl_op_array[ENCL_OP_MAX])(void *) =3D {
> >> +	do_encl_op_put_to_buf,
> >> +	do_encl_op_get_from_buf,
> >> +	do_encl_op_put_to_addr,
> >> +	do_encl_op_get_from_addr,
> >> +	do_encl_op_nop,
> >> +	do_encl_eaccept,
> >> +	do_encl_emodpe,
> >> +	do_encl_init_tcs_page,
> >> +};
> >> +
> >=20
> > Why you need to drop "const"? The array is not dynamically updated, i.e=
.
> > there's no reason to move it away from rodata section. If this was
> > kernel code, such modification would be considered as a regression.
>
> I dropped "const" to work around a clang warning:
>
> test_encl.c:130:2: warning: incompatible pointer types initializing=20
> 'const void (*)(void *)' with an expression of type 'void (void *)'=20
> [-Wincompatible-pointer-types]
>
> But I agree dropping const is inferior and it's better to fix the=20
> incompatible pointer types as per below.
>
> > I would also consider cleaning this up a bit further, while you are
> > refactoring anyway, and declare a typedef:
> >=20
> > 	typedef void (*encl_op_t)(void *);
> >=20
> > 	const encl_op_t encl_op_array[ENCL_OP_MAX] =3D {
>
> Thanks this is indeed cleaner. This also fixes the above clang warning.
>
> >=20
> >>   void encl_body(void *rdi,  void *rsi)
> >>   {
> >> -	const void (*encl_op_array[ENCL_OP_MAX])(void *) =3D {
> >> -		do_encl_op_put_to_buf,
> >> -		do_encl_op_get_from_buf,
> >> -		do_encl_op_put_to_addr,
> >> -		do_encl_op_get_from_addr,
> >> -		do_encl_op_nop,
> >> -		do_encl_eaccept,
> >> -		do_encl_emodpe,
> >> -		do_encl_init_tcs_page,
> >> -	};
> >> -
> >>   	struct encl_op_header *op =3D (struct encl_op_header *)rdi;
> >>  =20
> >> +	/*
> >> +	 * Manually rebase the loaded function pointer as enclaves cannot
> >> +	 * rely on startup routines to perform static pie relocations.
> >> +	 */
> >=20
> > This comment is not very useful. I'd consider dropping it.
>
> Dropped.
>
> >=20
> >>   	if (op->type < ENCL_OP_MAX)
> >> -		(*encl_op_array[op->type])(op);
> >> +		(*(((uint64_t) &__enclave_base) + encl_op_array[op->type]))(op);
> >                                ~
> > 			      should not have white space here (coding style)
>
> Thanks for pointing this out.
>
> > This would be cleaner IMHO:
> >=20
> > void encl_body(void *rdi,  void *rsi)
> > {
> > 	struct encl_op_header *header =3D (struct encl_op_header *)rdi;
> > 	encl_op_t op;
> > =09
> > 	if (header->type >=3D ENCL_OP_MAX)
> > 		return;
> >=20
> > 	/*
> > 	 * "encl_base" needs to be added, as this call site *cannot be*
> > 	 * made rip-relative by the compiler, or fixed up by any other
> > 	 * possible means.
> > 	 */
> > 	op =3D encl_base + encl_op_array[header->type];
> >=20
> > 	(*op)(header);
> > }
>
> Thanks, this is indeed much cleaner! Including this in the next revision.
>
> >> +		/* Dynamic symbol table not supported in enclaves */
> >=20
> > I'd drop this comment.
>
> Dropped.

Awesome!

BR, Jarkko
