Return-Path: <linux-kernel+bounces-159239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98AAA8B2B3C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 23:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB156B25329
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 21:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CD4156231;
	Thu, 25 Apr 2024 21:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Mge3iFRK"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048C71553A0
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 21:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714081561; cv=none; b=hHCq18MXCJi7O0w9cBj/zTy3faLZLw1b+G4G86tzMKda3l39oYCKXsRbxI78kMI/0Tk9FDbuTUrIIhHGZZaaWW9izxy82g2VJkia7KXWxpG2GWzwbnZlieoL2+iZsRA+oQ9ty5KHPuDTvkTC57l+GxGX/Sl4MH7yV9PBdJbWEXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714081561; c=relaxed/simple;
	bh=YKw6OAais4gM4JicLcbq2kNDKCivA0K/YpqzcFf016A=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pLDhjim9Kk9B31nV7eUz+Ij5En5GseMmmVPr/QbCzBOlwEbpHnUASM9NR0yamrrhSoys4wW0tTM6TUfMXA63rdfh4YWuDhraGEyKclfCl/boEMDGFnQkJs8XPIZWdOEIfF4s2BZAOMQklF6MX1cgf+c2V2xXCV/2Bf9lAlqr7/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Mge3iFRK; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1714081557; x=1714340757;
	bh=97Q4StEMSnaGADHQavqUT0bLsHbHLwxhsBOtn/7AolM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Mge3iFRKSiHxa2lzkeSAmzi7MjU65qn/kz2OEqCeBlMYcml1Y9jkU5wpk6KM71UHe
	 +jY6HrpERqdbmTONqVtNQsYJRNm3dkKoBFw94dzw9qzJK84x9WNh8jZ52D8H7iWerm
	 ZwF1m5Q3AE+hcej/oYJgdRnRE0+3iQmVgV/ywv2J5cuxIT8Dt1679Yg3kgBj+QiK0j
	 rZT6lQcHdtFNnOeKm1wKOeq0rXWn3Ms+7FMHr9tIhlVuh6Gi91WDR+MuSSdBPd5OtV
	 DT0pAiuIE42FxLmWPxBEbdLN4kxe/l/J2JYCDDMDNhKZLieElRazx+gSvqR0kaM/rj
	 i+QeS9JtMNBig==
Date: Thu, 25 Apr 2024 21:45:54 +0000
To: Matt Gilbride <mattgilbride@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Christian Brauner <brauner@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Rob Landley <rob@landley.net>, Davidlohr Bueso <dave@stgolabs.net>, Michel Lespinasse <michel@lespinasse.org>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] rust: rbtree: add `RBTreeIterator`
Message-ID: <ba946689-d10b-4752-989f-4c6404d7ee55@proton.me>
In-Reply-To: <20240418-b4-rbtree-v3-2-323e134390ce@google.com>
References: <20240418-b4-rbtree-v3-0-323e134390ce@google.com> <20240418-b4-rbtree-v3-2-323e134390ce@google.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: e011ff89a2cfa0e9231357b446c0d1d40cbda54c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 18.04.24 16:15, Matt Gilbride wrote:
> @@ -188,6 +212,25 @@ pub fn try_reserve_node() -> Result<RBTreeNodeReserv=
ation<K, V>> {
>      pub fn try_allocate_node(key: K, value: V) -> Result<RBTreeNode<K, V=
>> {
>          Ok(Self::try_reserve_node()?.into_node(key, value))
>      }
> +
> +    /// Returns an iterator over the tree nodes, sorted by key.
> +    pub fn iter(&self) -> RBTreeIterator<'_, K, V> {
> +        RBTreeIterator {

There is a missing `INVARIANT` comment here justifying the invariants of
`RBTreeIterator`.

> +            _tree: PhantomData,
> +            // SAFETY: `root` is valid as it's embedded in `self` and we=
 have a valid `self`.
> +            next: unsafe { bindings::rb_first(&self.root) },
> +        }
> +    }
> +
> +    /// Returns an iterator over the keys of the nodes in the tree, in s=
orted order.
> +    pub fn keys(&self) -> impl Iterator<Item =3D &'_ K> {
> +        self.iter().map(|(k, _)| k)
> +    }
> +
> +    /// Returns an iterator over the values of the nodes in the tree, so=
rted by key.
> +    pub fn values(&self) -> impl Iterator<Item =3D &'_ V> {
> +        self.iter().map(|(_, v)| v)
> +    }
>  }
>=20
>  impl<K, V> RBTree<K, V>
> @@ -373,6 +416,56 @@ fn drop(&mut self) {
>      }
>  }
>=20
> +impl<'a, K, V> IntoIterator for &'a RBTree<K, V> {
> +    type Item =3D (&'a K, &'a V);
> +    type IntoIter =3D RBTreeIterator<'a, K, V>;
> +
> +    fn into_iter(self) -> Self::IntoIter {
> +        self.iter()
> +    }
> +}
> +
> +/// An iterator over the nodes of a [`RBTree`].
> +///
> +/// Instances are created by calling [`RBTree::iter`].
> +///
> +/// # Invariants
> +/// - `self.next` is a valid pointer.
> +/// - `self.next` points to a node stored inside of a valid `RBTree`.
> +pub struct RBTreeIterator<'a, K, V> {
> +    _tree: PhantomData<&'a RBTree<K, V>>,
> +    next: *mut bindings::rb_node,
> +}
> +
> +// SAFETY: The [`RBTreeIterator`] gives out immutable references to K an=
d V, so it has the same
> +// thread safety requirements as immutable references.
> +unsafe impl<'a, K: Sync, V: Sync> Send for RBTreeIterator<'a, K, V> {}

The bounds on `K` and `V` look like typos to me. They should be `Send`
instead.

> +
> +// SAFETY: The [`RBTreeIterator`] gives out immutable references to K an=
d V, so it has the same
> +// thread safety requirements as immutable references.
> +unsafe impl<'a, K: Sync, V: Sync> Sync for RBTreeIterator<'a, K, V> {}
> +
> +impl<'a, K, V> Iterator for RBTreeIterator<'a, K, V> {
> +    type Item =3D (&'a K, &'a V);
> +
> +    fn next(&mut self) -> Option<Self::Item> {
> +        if self.next.is_null() {
> +            return None;
> +        }
> +
> +        // SAFETY: By the type invariant of `Self`, all non-null `rb_nod=
e` pointers stored in `self`

This is not an invariant of `Self`, but rather `RBTree` and `self`
should be "`RBtree`s".

--=20
Cheers,
Benno

> +        // point to the links field of `Node<K, V>` objects.
> +        let cur =3D unsafe { container_of!(self.next, Node<K, V>, links)=
 };
> +
> +        // SAFETY: `self.next` is a valid tree node by the type invarian=
ts.
> +        self.next =3D unsafe { bindings::rb_next(self.next) };
> +
> +        // SAFETY: By the same reasoning above, it is safe to dereferenc=
e the node. Additionally,
> +        // it is ok to return a reference to members because the iterato=
r must outlive it.
> +        Some(unsafe { (&(*cur).key, &(*cur).value) })
> +    }
> +}
> +
>  /// A memory reservation for a red-black tree node.
>  ///
>  /// It contains the memory needed to hold a node that can be inserted in=
to a red-black tree. One
>=20
> --
> 2.44.0.769.g3c40516874-goog
>=20


