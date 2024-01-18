Return-Path: <linux-kernel+bounces-29608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF588310B9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 02:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 098EF1C21DE5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 01:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32A3187E;
	Thu, 18 Jan 2024 01:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="fLU1bQnF"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AAE17C3
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 01:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705540099; cv=none; b=jeK6hl90iBitdmu+L+n6TKO7a3Jhg5rNDSyQYa12jG3KfO99AtYeNeG4n4G7owHO/loAxXYe0bLjk9bOk6jd/601MY+DaB994TmhqalTPZ/IjIBvc5rcT7rm08sYAqZI8hCnDSt6GcH6dUJSEMW0BSxBBHV0l62vYgzEyY9Patg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705540099; c=relaxed/simple;
	bh=8T7NC9Swub/nQZ9DVuaYsmYOVn2PSq1kpJSa5iPp6AQ=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=QiGXpcnWNx4acdkW/wBfpc5dX3KRg+cGRM6FdTfCs0z6kGnUuIpsJ9AwQWSNu06umu0G1xKeAhE8PinqdQx8KxqOYgEfRwTz4fy5AteLV4ZLYtbfQGziGXqW1j29maxuNGNeqa7tj8SlnuIx0lgzCAfW5UOuFA4bKyUBjdbdykE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=fLU1bQnF; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5e734251f48so2105307b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 17:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1705540096; x=1706144896; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lfrc0adm8w3bLRpMaJS6zecF+K47ffHuEOwCMesTrUI=;
        b=fLU1bQnFpbsIvB/Dg8fbdwZafy/0/9v5nNrL1EevzHd34ECdflpgObjgB33XkGCl5P
         ISpC/90zqkeBQk7KHEADG7d8y4g6OgoqPB37NaloYOEO9ZcPxp4O0bhOaUH731NbOzdt
         HONMytFr+pcfyYrsh7qK8OlHHgnIjqraiP2Mpw0pi8GqXUwT7W7JamYytxHPe9Jp9yLD
         95r/oS3pX/mozDcQLpMKnCH6UAzzhrN92T44eIpf71Jo6Z9VDTlIEwlji3S+TAk3j7px
         4hddT7JAEc9JhlxeWJCml5r6YdK7zsmEubxobKPOqMpbXGLeVWSvVD9d0E7RXJhBzMfZ
         CVcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705540096; x=1706144896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lfrc0adm8w3bLRpMaJS6zecF+K47ffHuEOwCMesTrUI=;
        b=wczjxEAycCir26VM2QIp723lsjBpr5N7Cdf3810qdpMVf8HHpE0otTqnea0AynjXYz
         Z9AK9rCnXJRbAcDTuMpmHal0c1DWhQ1ZtaU4v7QGp83Pvyth5NRJd0ykHIxmZHUp5ZHy
         iRvbNXy2RutrYnop6wMSAMosxKqallwWaHT+vm8HsZtkVTftn9jfUmvTPEe5HxLMMnyN
         Tupgnw3bFj5DLtHc9+JGZHbxeZd6CF/NSCY7wrzHoPRlkxfNxiWKZhxOO8AVDs361ySb
         ijWt87+X5Eg4ueY585fMsXvhP7uzCg3BbD4KDtxiIUB5bkJJVe0hSyqqlvAnAXITWmoR
         3wIw==
X-Gm-Message-State: AOJu0YzS+BRa2iW9WFzh0M7tJGpQwzQbzaG+zFExRwgwfimKoy9FwyEN
	Jd/H8OFDl2kiYsAjzAoOr8O9ZJ7QQlxIROeH9t5X/G8E2GQKssxBGy5aoUfxw/A4kKdJrfZ+L00
	SIdy1DXRfDeymVORpChL8OBcZYrtDePsjvNU/YQ==
X-Google-Smtp-Source: AGHT+IEcS3VxlJsgml3wAtNi0i4aW2103tOvs3ohRe5uF7KGfdjATYiKhxmMoj6o0VOFrUJO48mwvQHH5Ryf3T27jKc=
X-Received: by 2002:a05:690c:fd0:b0:5ff:6509:1e87 with SMTP id
 dg16-20020a05690c0fd000b005ff65091e87mr1447967ywb.18.1705540096635; Wed, 17
 Jan 2024 17:08:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116160141.165951-1-kernel@valentinobst.de>
 <20240116160141.165951-4-kernel@valentinobst.de> <CALNs47sgOaPZ6BiR3=WcG6bZuWVtF_vT4D+SLOdJ4jJoQwyAGg@mail.gmail.com>
In-Reply-To: <CALNs47sgOaPZ6BiR3=WcG6bZuWVtF_vT4D+SLOdJ4jJoQwyAGg@mail.gmail.com>
From: Trevor Gross <tmgross@umich.edu>
Date: Wed, 17 Jan 2024 20:08:05 -0500
Message-ID: <CALNs47tKVZR8YQ4yLQ8J1CxqDS8bVeKikXHhKcXmn-ejNnUbDA@mail.gmail.com>
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

On Wed, Jan 17, 2024 at 7:32=E2=80=AFPM Trevor Gross <tmgross@umich.edu> wr=
ote:
>
> On Tue, Jan 16, 2024 at 11:05=E2=80=AFAM Valentin Obst <kernel@valentinob=
st.de> wrote:
> >
> > Every other module ends its first line of documentation with a full
> > stop. Adapt the only outlier.
> >
> > Signed-off-by: Valentin Obst <kernel@valentinobst.de>
> > ---
> >  rust/kernel/ioctl.rs | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/rust/kernel/ioctl.rs b/rust/kernel/ioctl.rs
> > index 59050e5f5a5a..5987ad6d38a7 100644
> > --- a/rust/kernel/ioctl.rs
> > +++ b/rust/kernel/ioctl.rs
> > @@ -1,6 +1,6 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >
> > -//! ioctl() number definitions
> > +//! ioctl() number definitions.
>
> Would you mind also adding backticks to `ioctl()` while you're here?
>
> - Trevor
>
> >  //!
> >  //! C header: [`include/asm-generic/ioctl.h`](srctree/include/asm-gene=
ric/ioctl.h)
> >
> > --
> > 2.43.0
> >

Nevermind, I see you got this in patch 8/13.

Reviewed-by: Trevor Gross <tmgross@umich.edu>

