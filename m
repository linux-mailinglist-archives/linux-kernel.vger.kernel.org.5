Return-Path: <linux-kernel+bounces-96942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3087287636C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61D381C20E8D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC82256743;
	Fri,  8 Mar 2024 11:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="OSUd4IgM"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D1955E7B
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 11:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709897945; cv=none; b=fXjsurzzTyk8iNKTtPbvS62564eYQ/ZgzGZyOUFSpFZ5tdKoeGm9YOFQYS62KqEByoFRjlLcUK3MhtQCissdkRXPGLtrGlf6NSU0RXKdETZes2NekkkeCdTbCYUjlQpoWXydmUxtlXyIvcHKOMPCjbQ8FXMssP9jnzXId0qcTkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709897945; c=relaxed/simple;
	bh=3B/cw9GjdraPUIrj1ZXN1KUh9QGuUVvejLGEF+4qNxE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZJirfqK5vslJkwxTzWlYUoqrTslbrzIxW7wBzRS8/6Nz8Q4uRbPlcuX0m1Q43K7xG3GCTV6y0XOx5d8xJTr3HvisE3zIc9rUDa7kZfyiSry+l3LXz7AX5k0FNqjStaNksmB0gRuBwESk6iWkMjrcf3eQcvcrfwF+kqIXYpFze9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=OSUd4IgM; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1709897934; x=1710157134;
	bh=3B/cw9GjdraPUIrj1ZXN1KUh9QGuUVvejLGEF+4qNxE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=OSUd4IgMVKN0oOIVzlTktQB29QCcp/OsDT50e1v6XwHBPfETmr9+citxCjFx9rjJ8
	 YQoii+NhZER+uRDFOCSbp8Bk/AFd5hauvhxYK/ckOyO12LpzAzubl2RwV8lFxQBwmi
	 SPAhEWrK44I/KcFIRnublcrH+yV9IvT1Svw0nk7yoUFQQlqiPQzIaG43xRMGFnZwiX
	 4AccqgPVOY+IUw5Ft2bK7uhczBwwxh7eRrOd6pI025qnE3EA2MIbhQC7/x1tuUe2XH
	 Hh5293mM3MSdEGZiyWVqRXqwzhbVz0+pEqb0dhQTJQnGsq+TptULbha0wirhSKFxPB
	 eUrjNchctzd0w==
Date: Fri, 08 Mar 2024 11:38:49 +0000
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: don't select CONSTRUCTORS
Message-ID: <a217a3d3-b81c-47e1-89a3-a67c57b44379@proton.me>
In-Reply-To: <20240308-constructors-v1-1-4c811342391c@google.com>
References: <20240308-constructors-v1-1-4c811342391c@google.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 3/8/24 10:36, Alice Ryhl wrote:
> This was originally part of commit 4b9a68f2e59a0 ("rust: add support for
> static synchronisation primitives") from the old Rust branch, which used
> module constructors to initialize globals containing various
> synchronisation primitives with pin-init. That commit has never been
> upstreamed, but the `select CONSTRUCTORS` statement ended up being
> included in the patch that initially added Rust support to the Linux
> Kernel.
>=20
> We are not using module constructors, so let's remove the select.
>=20
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Benno Lossin <benno.lossin@proton.me>


