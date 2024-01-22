Return-Path: <linux-kernel+bounces-34063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4ED8372BC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4645328A21E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4005A3F8F2;
	Mon, 22 Jan 2024 19:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IA9+x55Y"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE6C3E48B;
	Mon, 22 Jan 2024 19:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705952320; cv=none; b=m6dfMKuntnaZkPzxjz6n4p36FtGQIev21wI4yeMkxOB3b1Cy2lxxnV1Zdet9xS3DFEZVWDlMKjZswMJMovvsfQWZQdyBZAd9aObXg6OrdHUcKXgd1uAUiEtPzWhKenXj48GxIs6PEKscsKtfRjhA2tLLL/zHLb2GzRcMiVQ2h2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705952320; c=relaxed/simple;
	bh=jVDYzTKoeN5seaHXGwaDqhA2K29ijc6wqpC2n+h3Yrg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lPy1IeQlfFHyGQol5PTn0sn9NaazooQfmW4nzSye1pMvB+s0Q9NEuky8djOW+Q+5XJ9nzdRr7cuPggiW1d2Af1jNQP+UhfAZnk7YIixbvTClp/YPGEyGv7PewOKZho/GiAkvdXycWQ13JU8WMobWOGosoWgjP/Uj50ofE1im7m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IA9+x55Y; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5f254d1a6daso34867827b3.2;
        Mon, 22 Jan 2024 11:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705952318; x=1706557118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H3nGTriVYNiDa8Acgezp4UDQW22qmr1rfJZKcpn5sq4=;
        b=IA9+x55YyzYkzKMWpTjsODG7/zaOL3I1X3DaTByZjOiiY2A3oP8HbZIJs42qKCbBfI
         sBPF/9eJGqQFXfWO344wu9IQiSOCYx3Gt8r/Ur6+80tWZmcJpzsp9iaemUc1bvphL24/
         hoHFLyt0l1sQZpetoCAg/0se6IgahjXrTTSm+LdDwkgjgIZqICHHd4GILkzlCYkgKvtY
         DXGh3ocdBlG7ByzQvg2GMPqRIxeO7BPz8Iy91el7HNi8mSgu0qkgUKmvM3N9xNfByGOI
         sbaQBNiacIEvr03jI6DZLVHw3JqElddzh6/PnzCDzrVrVgZtYKxpZEHSLuxrRjcYzPQY
         u9nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705952318; x=1706557118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H3nGTriVYNiDa8Acgezp4UDQW22qmr1rfJZKcpn5sq4=;
        b=UoKv4vkCdO71dLwm5/1uzZWsi3b0+OmptK/K83y73NVvn0weRqpCHBf1rsfBdQz8O6
         YgFhpE70VMdibrQkLtzzf7NkcG2kgkJ/WuuFjWVcssxnB9gzTynpiqvRsxLuxiYQV4rA
         Nit+8yaBkO1JsSf1vdDjGYPxRsDIJhDxyugdt7Ufx68oGUkgcxNK32HJDFaAf/WAUSVV
         LGpwY6t/Ih7inwS/gLYtgJwXSWTdcfeIANpKuE6ChgTF2GeeB0OVBp0ubVaXqDflxZeg
         zxpJSvT2LR9wY/BIC73CAOIf68FuI8smayJ7Q4+kMwnWaTVyTzl2mSEzQq9kNw83c8gO
         viFQ==
X-Gm-Message-State: AOJu0YzefVRPtAxSCUGUsRrqhqjooNaEBhSp1Z68J4Q1g85c5v5qpuzR
	fLjjc6KFy5veXQzvHQbxdXvP9Je5P7+VE+JmAFuZdrBvBBgYNkDKIK0HgfsbsSVTQUi+rk41Vdg
	zAZbnRVugdKZFUnNJnqxtjuSeHsA=
X-Google-Smtp-Source: AGHT+IFI0WuJaFhUBM3jZxZieoXHqxPdjS0wMkWfijuPxy0V0M5AG/fSKfFvpqMlsz+etL5sn7LOE7Z3RJgOPLnt5Io=
X-Received: by 2002:a81:5f8b:0:b0:5ff:7c76:888d with SMTP id
 t133-20020a815f8b000000b005ff7c76888dmr3658032ywb.6.1705952318176; Mon, 22
 Jan 2024 11:38:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122184608.11863-1-dakr@redhat.com>
In-Reply-To: <20240122184608.11863-1-dakr@redhat.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 22 Jan 2024 20:38:26 +0100
Message-ID: <CANiq72kdX-LK=OurnR5ZGDXEf90DxshUX13up4c8kiz0jxHc+Q@mail.gmail.com>
Subject: Re: [PATCH] rust: str: add to_ascii_{upper,lower}case() to CString
To: Danilo Krummrich <dakr@redhat.com>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, aliceryhl@google.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 7:46=E2=80=AFPM Danilo Krummrich <dakr@redhat.com> =
wrote:
>
> Add functions to convert a CString to upper- / lowercase assuming all
> characters are ASCII encoded.

Like Alice mentioned, please mention the use case, i.e. the "why?"
(perhaps also linking the Zulip discussion if you like [1]).

[1] https://rust-for-linux.zulipchat.com/#narrow/stream/288089-General/topi=
c/String.20manipulation.20in.20kernel.20Rust

> +    /// Converts the whole CString to lowercase.

Please use Markdown and, if possible, an intra-doc link, i.e.

    /// Converts the whole [`CString`] to lowercase.

Also perhaps we should mimic the standard library docs?

> +    pub fn to_ascii_lowercase(&mut self) {
> +        self.buf.make_ascii_lowercase();
> +    }

Why did you choose the `to_ascii_*()` name for these? In the standard
library, the in-place ones are `make_ascii_*()` (like the one you call
in the implementation).

Should the new-object-returned ones be added, by the way, if we are
adding these?

Cheers,
Miguel

