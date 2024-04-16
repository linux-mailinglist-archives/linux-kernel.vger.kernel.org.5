Return-Path: <linux-kernel+bounces-146306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53EE18A635E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 07:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E3B6282946
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 05:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538913D549;
	Tue, 16 Apr 2024 05:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="c8ndtgB2"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143E93D57D
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 05:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713247129; cv=none; b=lD3pzRjdSdeoBWhDIbPDU9x0DoyL5hZV7ggm/4mElIiruEUn7yi7lFQdth1ZYq+FAqwpq/fXqUytJvmNfy3LAPJQvWqvilynFbqWiMgQq/8aUpfYZHdrie0wj9MR+c1XznZPvcywJH3XXEbbTkz96x69g0+8cJfCGNtI6HGasZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713247129; c=relaxed/simple;
	bh=h5mlv4HpkLUqyk2dIM6FJ/CwAPP4sxy+eOC/XSUkn1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uR6qRyZV8mYlDtdsysqUCjud3XlDn+LMslmqk+kPzcF+FKPwHGfgeSljviBajz4XBweaFxvP/NiMrdxx3F/Up7hx1Wq2NRHtre+oyjTTrlzijOEJ/3I2soxT0ODltxm2EEZbTAg4hZFoG4Ls4YvgfOFpg/wdggWhSHi2L4aVDFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=c8ndtgB2; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dd10ebcd702so3729244276.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 22:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1713247127; x=1713851927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h5mlv4HpkLUqyk2dIM6FJ/CwAPP4sxy+eOC/XSUkn1M=;
        b=c8ndtgB21SnyV2xQf5An4u6ssTRPV4E7uVLaWkgjxXLHFqVX7eB1jI2sCWJMXQ8q0O
         taH6zzr31CWCyogUxHKFHoog0NCY4tNj4LbjHx/FN7ew51nFQEPHlS8jleetUaApgMnb
         a7/2E67HsbyNAU6JkVi7GEGF2PIlwHnzawCOVtqc4OwNpX+a0qt6xRCQ/4bu5odTF3Tb
         tCuZVvQ6EyBzntjTK5M07pShkUFuF1Au5rh/RpAY48yASSR2CAV67c6k5xXIuHzpWTXh
         PrYqOKestD7tEsEoTq8/5/LtJKhQiT+CnLBx1GBGK2tVSK2jhg2lHPSXOdQDoqKaVatF
         92kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713247127; x=1713851927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h5mlv4HpkLUqyk2dIM6FJ/CwAPP4sxy+eOC/XSUkn1M=;
        b=PSXki1kmSFgq+T2Y+4gTdkaJFOm9diJa5aRo4tr6WG7JJnGywbVQZmkbYO0ylMdFEK
         ibuk15hvmxyxDVSZV9p/4OBL6qudzCnKE8ew8eQrf0xMJ7kKIwTJLaZcbD6vwBCb4kt3
         FxZc4A5alKI1YLD+9WWeISRpr5q3tjCkoEQ83ZFNwEAhjFpvl1NospHGgZM0Mnwfy/dm
         2pGfLo5/Y/VM3Eak3f9HRni2Ahq/PQwdgqqQYhwuto9AnGeyNkjYDJkJvMJ8QO4NHiha
         Y6XRO3+ZKP4BZL62fysCOfmDgDHeD5pPZb6KWU3l5VIhULmEVuUTyWzDLyk8Rm+br5N3
         yOWA==
X-Forwarded-Encrypted: i=1; AJvYcCXuCYoB2nWYAVYGldaKZ7FZwqMcK62u70RXpyqI3aiZHtd4BBdQl86aaMFk+qtXSkvINkSXz0rRsdd5LpxFh4gCS2kfGlMLQc9Q3LQm
X-Gm-Message-State: AOJu0YwHS+c8VZVjXgwSOMlLzdeWOg+tvMbsJpkVfaz1MASIONsUh+f0
	WeoHKXK6eJ4Aj5QPJbiYB5PXcwxR1ptolx0qxrnV5hPCR+goqmFt59Aquas5THnsj6mUtOrZA5/
	i6aHgHQBozBUPlvhqX1A8TFGV1GjlqR4b6PDesQ==
X-Google-Smtp-Source: AGHT+IFQwRxyUoH7cB9U8uuO8/5PMhrB/hlSqQbI7VhXJpfcFpOA7f59x1Z2Y1EapS4qAXIORAv/ywWLzM+Oee+OGv0=
X-Received: by 2002:a25:c246:0:b0:de3:ecc8:a0be with SMTP id
 s67-20020a25c246000000b00de3ecc8a0bemr3719194ybf.20.1713247127024; Mon, 15
 Apr 2024 22:58:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <eba70259-9b10-4bf7-ac4f-d7accf6b8891@smtp-relay.sendinblue.com>
In-Reply-To: <eba70259-9b10-4bf7-ac4f-d7accf6b8891@smtp-relay.sendinblue.com>
From: Trevor Gross <tmgross@umich.edu>
Date: Tue, 16 Apr 2024 01:58:36 -0400
Message-ID: <CALNs47uct--R4CGEQEO1vXTwMuBiqLaO1tREL2T4pP-ebZC+=Q@mail.gmail.com>
Subject: Re: [PATCH] rust: update `dbg!()` to format column number
To: dev@raxyte.com
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, aliceryhl@google.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 14, 2024 at 9:31=E2=80=AFAM <dev@raxyte.com> wrote:
>
> In Rust 1.76.0, the `dbg!()` macro was updated to also format the column
> number. The reason cited was usage of a few characters worth of
> horizontal space while allowing direct jumps to the source location. [1]
>
> Link: https://github.com/rust-lang/rust/pull/114962 [1]
> Link: https://github.com/Rust-for-Linux/linux/issues/1065

The second link could be "Fixes: ..." (but whoever picks this up can
probably do that)

> Signed-off-by: Raghav Narang <dev@raxyte.com>

Reviewed-by: Trevor Gross <tmgross@umich.edu>

