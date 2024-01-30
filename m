Return-Path: <linux-kernel+bounces-44237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8426F841F34
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 246361F28C61
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C1160B9F;
	Tue, 30 Jan 2024 09:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xVuD7ujF"
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76BD5B211
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 09:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706606332; cv=none; b=AIGUkbWypzoO6dqjGTZhdZtfhvT7lEJNKVPTr8lEp+zEsZc0uD+EIYXtnzZ2NhplDSkX48IHhcqux2WHdaV6ShtEB0mRVJH8wfZgtjrPHmx48CvU+SpPUZvV5J87tcbA5fXJSHmfFFRR6xjRUCCTv0Wo26t+C72JA64DKhJyhbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706606332; c=relaxed/simple;
	bh=F/cTM4VSLKcMhFnMv4L77ZMGQE1ijg1rGP30sPQqzyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cNFpF4Fkm+q462zo7VpO9ijGZs+lIPQri1K0G7FvVpJAZDB1yNLP128C8krxmNDFW5u74QHb+55n005Go1FoPQbDEjbM6bU0rr00zWh7CDRgdJGkA/oiUfqvWtjTQG7D0Lops/dgIlVfkY64bj3nCrFi9/uqXah7cyfvWF4HPCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xVuD7ujF; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-7ce3c7566e0so1309021241.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 01:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706606329; x=1707211129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/pJoui15436YDNlZShmKGvqb7ZMmNypRm9KPXDZ5Kug=;
        b=xVuD7ujFH5WIw2eAF+D/ACPQloKaFP6wXO4VlLT49mIttteMTKyjYmVXAAxO5Iu3I8
         CFRUVs+bNWIoKbOSfgLBVHNfUGaB/790UAmXvnO/LwJC5mVISgHk96VgDAa3js/5YGhV
         iXV3cT85pYZ58m/uDveEDP9J388FZ3r4cZoha6YhC5CnBHfAOH8zt18HoIPn3E+JBba6
         +T4jRzVVqUBCG/uWZx32xoIk5t7ty5OCuO7ZE8QKeUd/RwPSmds+mqbCH+KsjjXj0khl
         4gUp9hoerDm0mlRlUl25HL83tdG3kkw/DaUZKOTVSAPAPqTnTzfS0ac8GgZSCUGKlNcF
         pzTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706606329; x=1707211129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/pJoui15436YDNlZShmKGvqb7ZMmNypRm9KPXDZ5Kug=;
        b=hcL8UDMcVngfX+h3dO20v23mH4kti6Mr6h23zN7YTM2NWKTD/ZqYLql6odjjyp/j83
         jcYVZp6p6wQtBKpwLLxZeHz0mkrn6tJmopar3ujmlCk4PL8uD7jej4pUi1frrcJeeb/l
         ddKSARLd2wLMkXKa4vUUsgktzea25tdSmVh6gWXIgKXRm96B5jDZjbX5d0MD8kvWFgeA
         eNEa/5LyMFgc3anYyS6iKs0YM0LXsBJvp+AwD7TsstjKADT745hqieWMaWt/VcEs2bVB
         xRUT6G7mta8PkcizIf4qhp1b24UKK0telGXquvTlWp79WKrcw6EG5lacUwu2JFzrLn2C
         5lDA==
X-Gm-Message-State: AOJu0YyzyqMreLp9edi/m2zbIRHchSc2n4fuHc2mZqnUsojzsK3rGC7s
	NtZE+USgShTZ24zOc1IqHpeJfhdX7yFTFJcNLqJFq5+cv+MKw0Lm1ymJ3q0FgmwH5Iy/vdNwxrp
	evUOin2tpVE/cWBD7Ke3quewjWRkCQYqdbOKz
X-Google-Smtp-Source: AGHT+IGL9TpDEm0usJlZsZmrnrDFEOo/OkF5iOfjXZgDhZOEsbrsnK1HFGwr55WJnyuQ51NnWN6Kq8QwZ+tboOoBO9M=
X-Received: by 2002:a05:6102:66f:b0:466:e5d2:4d7a with SMTP id
 z15-20020a056102066f00b00466e5d24d7amr2462740vsf.28.1706606329521; Tue, 30
 Jan 2024 01:18:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116160141.165951-1-kernel@valentinobst.de> <20240117001613.169177-1-kernel@valentinobst.de>
In-Reply-To: <20240117001613.169177-1-kernel@valentinobst.de>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 30 Jan 2024 10:18:38 +0100
Message-ID: <CAH5fLghSaorRgDDuqNCN-BhQ86ysX96b=nKM_cZAN0_E6Ai04A@mail.gmail.com>
Subject: Re: [PATCH 13/13] rust: locked_by: shorten doclink preview
To: Valentin Obst <kernel@valentinobst.de>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 1:16=E2=80=AFAM Valentin Obst <kernel@valentinobst.=
de> wrote:
>  /// In most cases, data protected by a lock is wrapped by the appropriat=
e lock type, e.g.,
> -/// [`super::Mutex`] or [`super::SpinLock`]. [`LockedBy`] is meant for c=
ases when this is not
> +/// [`Mutex`] or [`SpinLock`]. [`LockedBy`] is meant for cases when this=
 is not
>  /// possible. For example, if a container has a lock and some data in th=
e contained elements needs
>  /// to be protected by the same lock.

It looks like the text should be reflowed here. The "possible" word
fits on the previous line.

