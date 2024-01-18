Return-Path: <linux-kernel+bounces-29592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6102C831089
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 01:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F36431F22648
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 00:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF864A38;
	Thu, 18 Jan 2024 00:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="dzyo7iWY"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F69C4680
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 00:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705537982; cv=none; b=Sc3fl96ozJXgrnu/po3ibOIw2zCcfR5uR5f39yzJXdAkSKjEGPTtKRrtT9Bt1rdK5mAL7eaoAUuq8O0j0TN4vh1Y17ZslvI0QIA4a0NCVOHtFY9LKNoKYiJJu7FmzqF98JPqqJZ9RFIj0EV0OBhKF5zeZk794noAyLmOvGWpkYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705537982; c=relaxed/simple;
	bh=dgArgh2ul1TK0qfeeoEFab4QDGDik0poHIox2rwbC+E=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=gh5ZITmm3NxGhEkCT7aU4gBMa32/o/f6a37W3wHSFJRiP0qfJ840U7lOUSGyDqvSbt8xBgpJYY2eJxmA762XKvEvGjBXL9iuRlBSuuTYwbCwWYHdA2or5rzxtvx81jmXLCiOhb2k4DzBY4ITSbAW7MlUdkDqRVy+kSCenfS/B1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=dzyo7iWY; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dc223463ee4so2478493276.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 16:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1705537979; x=1706142779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r3Rwf3gJEOT09pg8xiRr1kC0KFvTO5PRFFjNSH/Q5UQ=;
        b=dzyo7iWY+xmeCAujYjViFV3JJM3LOPoRn/8NhUxpbIed2ntd2pss+3NaTveja1EcJP
         exclnwTO80BziAJpjd6W4qyRmN+7aiZNS3oCABph84pvNgYglF6TNCfhB37C1ka8QNVx
         VX0U6io53ApRVVWMMvUr5sf08YrdQ4N4grDxVLobINeM/f2g9qYbn5w+LR38Jxjm5GF4
         4gItnQJsAb1Jx7l6TQ7zRp26fwgQOEN/Hc3qbm47KuBunOqEkoVE7KQQ0qrmFLW1QILZ
         sv4hYV1tMiSjkgPRZ1fGRibmIk9ojiwFl5mQkGKJQJ7iy0ACPeinWYEjtnWAW85/4zc2
         HjRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705537979; x=1706142779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r3Rwf3gJEOT09pg8xiRr1kC0KFvTO5PRFFjNSH/Q5UQ=;
        b=rd8INtq2omWCEg9SB7go/oGZtvLHOO4StO+a+uF4/R5x7KDnDo7Qas1HeSG9xTShmd
         N8QGDwsqDTgWhetP3ZykaXc5Py+08b04lMjgaYV1krOO25/EX3s/lwn+uzp/KR5qNM0j
         G7w1XWPC+dSRMdN1IHknPawo2NcloUJk2RqstGxAVHuoayE3MeEzUrMyYzfl1gVuSrmQ
         3bNUIRcjI9EgeGayt7H0ej8Ici++Yh5feeJRGsTH0/AwrjPxUILrdmI8I+D7fw5fs+8b
         tpSFeV0uI3ScFII6V33CsbmCafSY39F6dypuxN0F7GfQvIb4n/MYY7ZFVorYQK6qJgyd
         /Zkw==
X-Gm-Message-State: AOJu0Yw9SRrYt220pkWtelCSOmgrgEHu1Qj1Chnim8uXgmPPXJ7i8WJG
	1M35B8HANFbiJ5nN0IFVIew6049d6g92NArJVBxXBBgh4viPFQhFBFBUzB6kLYXHqaavpJJw2z+
	GgKTGtn+rEtks1n9d7L8vbMQza+xsUckLzU4XJQ==
X-Google-Smtp-Source: AGHT+IGCo4JFNmq1MtDg/snqnH71lAjqJBX/OiRCcrythqB/eqvOz+3GIr9QT/e6exZhyNRWx0HWSz+Ry9oldhKBIkg=
X-Received: by 2002:a25:dcc7:0:b0:dc2:23f7:665f with SMTP id
 y190-20020a25dcc7000000b00dc223f7665fmr20241ybe.127.1705537979436; Wed, 17
 Jan 2024 16:32:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116160141.165951-1-kernel@valentinobst.de> <20240116160141.165951-4-kernel@valentinobst.de>
In-Reply-To: <20240116160141.165951-4-kernel@valentinobst.de>
From: Trevor Gross <tmgross@umich.edu>
Date: Wed, 17 Jan 2024 19:32:48 -0500
Message-ID: <CALNs47sgOaPZ6BiR3=WcG6bZuWVtF_vT4D+SLOdJ4jJoQwyAGg@mail.gmail.com>
Subject: Re: [PATCH 03/13] rust: ioctl: end top level module docs with full stop
To: Valentin Obst <kernel@valentinobst.de>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 11:05=E2=80=AFAM Valentin Obst <kernel@valentinobst=
de> wrote:
>
> Every other module ends its first line of documentation with a full
> stop. Adapt the only outlier.
>
> Signed-off-by: Valentin Obst <kernel@valentinobst.de>
> ---
>  rust/kernel/ioctl.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/rust/kernel/ioctl.rs b/rust/kernel/ioctl.rs
> index 59050e5f5a5a..5987ad6d38a7 100644
> --- a/rust/kernel/ioctl.rs
> +++ b/rust/kernel/ioctl.rs
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>
> -//! ioctl() number definitions
> +//! ioctl() number definitions.

Would you mind also adding backticks to `ioctl()` while you're here?

- Trevor

>  //!
>  //! C header: [`include/asm-generic/ioctl.h`](srctree/include/asm-generi=
c/ioctl.h)
>
> --
> 2.43.0
>

