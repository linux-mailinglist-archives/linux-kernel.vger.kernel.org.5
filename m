Return-Path: <linux-kernel+bounces-103570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1974A87C139
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 17:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83044B225D1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7E873533;
	Thu, 14 Mar 2024 16:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="NvR543C0"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC616F524;
	Thu, 14 Mar 2024 16:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710433652; cv=none; b=iYwfGVBmpxPMWQPtc+TTmlY7zabJ6Tm1OGcvAvF0zrwPXxHaAB0RlizYTPRVTuCR6YDZvO2LvNeUbSIa6thorfFuDH4PAMVdNIDuYUoiWKnulrt8Nc4jFyWOx/PrOE6CMfNwnhk2WabkbFjneaQbvAV57+WdfaoS9taWyBVdd9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710433652; c=relaxed/simple;
	bh=vwoyE2mDyn9On8hrLTCnfN060DQ8TxSfqTAxI+RAnKw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VOJqwB59/kke0iVPGAd9xnLuYOiMhKHcQtQ2s058z6tJq0pqmr72hIc+aqsM5D3Nl+rQ2u8DfTOSX2liyT4yZ5GQ4pMO0a4jBIAgIhZfvnfG1ZlHrpKBkjf+UWKHDYOCzIxY0c7nEIG7Ct9rT0fvmsdCMvAdaatZkbCc6ofpfuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=NvR543C0; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1710433648; x=1710692848;
	bh=vwoyE2mDyn9On8hrLTCnfN060DQ8TxSfqTAxI+RAnKw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=NvR543C0oZfacPkUN+ozGEYwwwBKN1k0iTFQliPRarb7BOLfs0qRAk7zcFkzv1aSk
	 eroiTKoVMPV68qZyjv69B8NQhRG9WxKF5DxkS8+tYyonuapvzhzX7pkRLwsmAJfQH5
	 coxxoBid4P2e2ml6xRwYoprRuDh2kylDcCX50806fYMnuZEWtf1WRZTwIW/cmYMuCr
	 4x4V/HKhiKZgzcHVYpsjfN3yLaV1oGuqhKx86KIvXw8NidMMuk4mV5Kp5AHMiYAF1f
	 eQGyWrTpsojGtXDIAStk47pGDQPCLJXB8lN3VrRWcRN8wWud/lV6+gv02Q3ZPku28k
	 Pvt4e4ZKWVsig==
Date: Thu, 14 Mar 2024 16:27:09 +0000
To: Matt Gilbride <mattgilbride@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Christian Brauner <brauner@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Rob Landley <rob@landley.net>, Davidlohr Bueso <dave@stgolabs.net>, Michel Lespinasse <michel@lespinasse.org>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] rust: rbtree: add `RBTreeIteratorMut`
Message-ID: <94cced92-7cb0-4c6c-934f-7f9190abe3a1@proton.me>
In-Reply-To: <20240219-b4-rbtree-v2-4-0b113aab330d@google.com>
References: <20240219-b4-rbtree-v2-0-0b113aab330d@google.com> <20240219-b4-rbtree-v2-4-0b113aab330d@google.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/19/24 12:48, Matt Gilbride wrote:
> From: Wedson Almeida Filho <wedsonaf@gmail.com>
>=20
> Add mutable Iterator implementation (`RBTreeIteratorMut`) for `RBTree`,
> allowing iteration over (key, value) pairs in key order. Only values are
> mutable, as mutating keys implies modifying a node's position in the tree=
.
>=20
> Mutable iteration is used by the binder driver during shutdown to
> clean up the tree maintained by the "range allocator" [1].
>=20
> Link: https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-6-08=
ba9197f637@google.com/ [1]
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Signed-off-by: Matt Gilbride <mattgilbride@google.com>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Tested-by: Alice Ryhl <aliceryhl@google.com>

The comments from patch 3 also apply here.

--=20
Cheers,
Benno


