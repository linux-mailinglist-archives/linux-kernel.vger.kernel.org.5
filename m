Return-Path: <linux-kernel+bounces-103033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6F587BA2D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E81D1C22358
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3146CDDC;
	Thu, 14 Mar 2024 09:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ubFCNPhe"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5686BFB3
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 09:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710407712; cv=none; b=qzv1rWNKTyJdUv7t7S803LgfOV1MlZOd1Lwu8P3HbT/hvOZ2LFNzX0rohRjyCm2BJ4q+WYqBT7F9vW4YkyyvsunZm+HNdZ27DD3+c9km/fz0gjH+1EAY4paNy5tYkog6xHas0bo2Tr5b3XT383JZTjEz+dGaZusW7RBtXY1z+mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710407712; c=relaxed/simple;
	bh=lE/ZP5Tkvx9YY0FpPfk+sLpzNiYxoj91aWi14jou22k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VLxKI3c8aWlZdPb2NP84RRMiZWgfkRvhtN89++k3d0ihQpYBZB82lP6oAO5rAysLRzUeSLWfwd06mCnEa6o9nsDlQunPXnXwfZOfYMLTNG+GI5iINElqqjaXDfOUXjCH3yfewV5xMIM2tixWquP+TTG7SnH5cWrZPvcYAprKUsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ubFCNPhe; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-690c5d7851dso3811276d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 02:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710407708; x=1711012508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lE/ZP5Tkvx9YY0FpPfk+sLpzNiYxoj91aWi14jou22k=;
        b=ubFCNPheSIZ9cs6MaZxKWElEVqfL+s3kamjXeBCi5TL+nFgDVocsEf/N34w/gQXVeR
         0LqK5N5L9cob0jrM+f06EPxadjMNgbXM10e4we3+v20YN4+oZzGSq809ILziIuLklVf3
         MBm43VXX5DXR9vpuXWhLQJkZrcstImmNuzovBiJ6kUS7KGdNafB6ePLmas1Yg90DDG03
         whRbVMEzHbrjEoARIstnlcsrPPjeL90l7fJUSi7+N1nlhc63QTNiYR/XCWHbWFoB4enw
         T02PnMckcF/xjSPGoeMaeSN/Mx2E151p/NulWThbpZmFZgW6TqG22w6hjIaIO52cbznP
         R02Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710407708; x=1711012508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lE/ZP5Tkvx9YY0FpPfk+sLpzNiYxoj91aWi14jou22k=;
        b=b+KeSSzHLByP72AtFCtMQWS0S7rYS+dTgwmp+FjiiAelPX1EZKk1f7P5Ws9H4CKUvq
         VfAQA5mEzJiuzYGy3fREZR0HvKZpE+YjTyNMOni3kUNyMdL99pmxrA0gzuZ/vNlhSg0i
         xJTVrMg1l56mLMhxRW9w8c93wjqfhzphQYywu1VcqrPWoJEgN7TDGzm9qO5Tt7T09Sin
         W3gPFgk+zXRgZW9n2iyT8rz2+QJyiCwzvH2rt4PoTalpHjvM8mPMDPiRsEXQLtBxZCUL
         YZ66Hyf28kYBtMbRHtbWUU4wuQML5gGlb//wJKXUTeIkgXsHtorsjBTUfcQS7Qez3sNm
         74Sw==
X-Forwarded-Encrypted: i=1; AJvYcCUCjRdTKzfl9Rd1zFPxVtGTNtbZQ39/WZqk1kKFgS9vij1TulvqvrmqGJ2At3oNUPCnzfucaUTt97jmc9V/oudEyk3WkD0RYUuZA9RD
X-Gm-Message-State: AOJu0YwX24VLp8cWvNRkxPgeN7IwYQcauVkCBEf18GlUqGdDXLTmr4RX
	CwKoHUApJmm9t7Kr9WCblI8I1O6c52oUI40ah0I0KVpHFxBj7gx6ZRMK/tcOPpPOp77GM7PcfPk
	3r4+6yMSmyvNKmwpd6hPfSvYfBf6wyzrzWNFE
X-Google-Smtp-Source: AGHT+IGfMznYIETWqpb1PprXePzqaigF18dojgQnMhgp1CmXhdyU8MIRSF4qLWE020QEL3knnSBFKCRcRErOBRLrkgE=
X-Received: by 2002:ad4:53a6:0:b0:690:d719:d575 with SMTP id
 j6-20020ad453a6000000b00690d719d575mr1324895qvv.43.1710407708463; Thu, 14 Mar
 2024 02:15:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313230713.987124-1-benno.lossin@proton.me>
In-Reply-To: <20240313230713.987124-1-benno.lossin@proton.me>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 14 Mar 2024 10:14:57 +0100
Message-ID: <CAH5fLgjMkWxqTxZKt_w+V6X1qfUzosTbwMxDVXUmw_qTdzYP_A@mail.gmail.com>
Subject: Re: [PATCH] rust: init: remove impl Zeroable for Infallible
To: Benno Lossin <benno.lossin@proton.me>, Laine Taffin Altman <alexanderaltman@me.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, stable@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 12:09=E2=80=AFAM Benno Lossin <benno.lossin@proton.=
me> wrote:
>
> From: Laine Taffin Altman <alexanderaltman@me.com>
>
> It is not enough for a type to be a ZST to guarantee that zeroed memory
> is a valid value for it; it must also be inhabited. Creating a value of
> an uninhabited type, ZST or no, is immediate UB.
> Thus remove the implementation of `Zeroable` for `Infallible`, since
> that type is not inhabited.
>
> Cc: stable@vger.kernel.org
> Fixes: 38cde0bd7b67 ("rust: init: add `Zeroable` trait and `init::zeroed`=
 function")
> Closes: https://github.com/Rust-for-Linux/pinned-init/pull/13
> Signed-off-by: Laine Taffin Altman <alexanderaltman@me.com>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

