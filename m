Return-Path: <linux-kernel+bounces-108191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DB6880746
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 23:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65E3E1F23307
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 22:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147C65A0E5;
	Tue, 19 Mar 2024 22:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="DwpdCwJ7"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B3939FC5
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 22:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710887342; cv=none; b=O+Q+50aAmazbP+7KfsuSFJEbJqoprRR4UWOKB8Du8W1DK/31mrcGLmt1fKoT+qRd0Vpg2T2f9U26r7X7LurJwHEPW4lsVpqaG6IOdej6bXhg/FnmtCTz+A6W84kkxl9WoRupdHtioRYb3e7EuCHC5azyx0x4y+wgWMDLa1MPVns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710887342; c=relaxed/simple;
	bh=btl7GVMkOPqh3jelHMmXpcxt9NraTyxeTaEChB9epX4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LyNWYokaqCvOMogo22QRJSYqqSFZJXTSt4gAzD0PT0jeCFZu7J3mLiST4hGKWL38M0q19VNSk1CWNvFIAT3ZPvBOsTH7FcCzIiTy9Xn2/nJk2YAeATPPyQe4GOASdcZygKwjSy4f9dQaWTzgXqPGmzEL3u4oQyK74YQRtz4Qhuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=DwpdCwJ7; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=2td2hcxam5f4blla4qexiqfvti.protonmail; t=1710887338; x=1711146538;
	bh=L20ailqB2zZNQ2Pi1DlqP7RA7u5R9k3CUjUtV3VgrxQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=DwpdCwJ7R0FXhXwrI1LaTEYBTItAi/qrEMzB7FUkf2GbMnh2NaOxQbkwb6P1ixTuv
	 LH5nbCsEpmrJ+pH4texbSAicrUz8XowP6FwhRWKRldXsnhVEus1GkDi9zQaNuUgsD4
	 Ajz9VBySgeCOjDUe9T1ROslu5kyNNRrPtXsLdFfHYofRkXtvz9sr9Q/D/EodOenOka
	 zSCiebBcGWFEsYAsOKhh3XWb8HFgvM4u9O1O151CY8iIrbO8bEP8Tc14ciW72qjo88
	 5VEWgoXgpvlMzl4QaBouqB/+zp2cH+z3d9VjVBKPy1/4dFLP88jjFKK8WTlPzhxl2p
	 VthyZsOKjUFuw==
Date: Tue, 19 Mar 2024 22:28:52 +0000
To: Boqun Feng <boqun.feng@gmail.com>, Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v3 4/4] rust: add abstraction for `struct page`
Message-ID: <65457833-adbe-4a60-95d9-8391a746ede0@proton.me>
In-Reply-To: <ZfoO1h0Kzdz4ln26@boqun-archlinux>
References: <20240311-alice-mm-v3-0-cdf7b3a2049c@google.com> <20240311-alice-mm-v3-4-cdf7b3a2049c@google.com> <ZfoO1h0Kzdz4ln26@boqun-archlinux>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 3/19/24 23:16, Boqun Feng wrote:
> On Mon, Mar 11, 2024 at 10:47:16AM +0000, Alice Ryhl wrote:
> [...]
>>   /* `bindgen` gets confused at certain things. */
>>   const size_t RUST_CONST_HELPER_ARCH_SLAB_MINALIGN =3D ARCH_SLAB_MINALI=
GN;
>> +const size_t RUST_CONST_HELPER_PAGE_SIZE =3D PAGE_SIZE;
>> +const size_t RUST_CONST_HELPER_PAGE_MASK =3D PAGE_MASK;
>=20
> At least for me, bindgen couldn't work out the macro expansion, and I
> got:
>=20
> =09pub const PAGE_SIZE: usize =3D 4096;
> =09extern "C" {
> =09    pub static RUST_CONST_HELPER_PAGE_MASK: usize;
> =09}
>=20
> in rust/bindings/bindings_generated.rs, which will eventually cause the
> code cannot compile.
>=20
> I'm using bindgen-cli 0.65.1, libclang (16 or 17), rustc (1.76 or 1.77).
>=20
> Anyone else sees the same thing?

I also have this problem with bindgen-cli 0.69.1 libclang 16 and rustc 1.76=
0.
For reference, here is the actual compilation error:

error[E0425]: cannot find value `PAGE_MASK` in crate `bindings`
      --> rust/kernel/page.rs:17:40
       |
17    | pub const PAGE_MASK: usize =3D bindings::PAGE_MASK as usize;
       |                                        ^^^^^^^^^ help: a constant =
with a similar name exists: `GATE_TASK`
       |
      ::: /home/benno/kernel/review/mem-man-binder/rust/bindings/bindings_g=
enerated.rs:12188:1
       |
12188 | pub const GATE_TASK: _bindgen_ty_4 =3D 5;
       | ---------------------------------- similarly named constant `GATE_=
TASK` defined here

error: type `gfp_t` should have an upper camel case name
   --> rust/kernel/page.rs:21:14
    |
21 |     pub type gfp_t =3D bindings::gfp_t;
    |              ^^^^^ help: convert the identifier to upper camel case: =
`GfpT`
    |
    =3D note: `-D non-camel-case-types` implied by `-D warnings`
    =3D help: to override `-D warnings` add `#[allow(non_camel_case_types)]=
`

error: aborting due to 2 previous errors

For more information about this error, try `rustc --explain E0425`.

@Alice: the second error should be unrelated to this problem.

--=20
Cheers,
Benno

>=20
> Regards,
> Boqun
>=20
>>   const gfp_t RUST_CONST_HELPER_GFP_KERNEL =3D GFP_KERNEL;
>>   const gfp_t RUST_CONST_HELPER___GFP_ZERO =3D __GFP_ZERO;
>> +const gfp_t RUST_CONST_HELPER___GFP_HIGHMEM =3D ___GFP_HIGHMEM;
> [...]



