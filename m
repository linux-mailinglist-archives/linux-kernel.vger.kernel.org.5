Return-Path: <linux-kernel+bounces-127668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE6C894F35
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F18E1282446
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F3359154;
	Tue,  2 Apr 2024 09:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Oz2XrnRL"
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7553F9454
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 09:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712051726; cv=none; b=ohxe9RKZcQOTuLEbnVLEa/9f2KYA9H7FfVXEgJMKbxAGJzO0GFU4YpuYTmfWdHI+koQJtUwWBFhrvRB4Zw0F5b9BGbh4rMhKxx14uYZ69PMz9HT4uoiOSWTqzAyn+nyAW9tev/agYkwI3C05fGwgvSx5Lr5JCgPfslvxWP+/Uf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712051726; c=relaxed/simple;
	bh=J22cvATvZxVx1kfNpr32VC2EcIinbWlHC5PnuEWb4Ig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RkTQASPHPss3+8oIR6Rahp9hlqxMSRjyNpAQlVKLlctcn5+aKJoMGewX3O+axLq3r+bUNggPLIeXiOM47wcGMvefunfZZgI6Br2XZtAsyzQB5HeR3y5ezDLcjM/Ln2fi2Pv+S+V9k429lTrqci6rwcVVIJbmVy9PRRYortkY3lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Oz2XrnRL; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-7e0425e5aa8so1733395241.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 02:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712051723; x=1712656523; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J22cvATvZxVx1kfNpr32VC2EcIinbWlHC5PnuEWb4Ig=;
        b=Oz2XrnRLX+uME+CBSziLRCDVpzIln2BK/DBu26vVhVX6Tv8+nCUnLNErJS8FKzUj26
         xDs+4yWjE38qeGTM6be0uy/EAku7++qscR5wlNHLiAeWRbdFO3oNZ9z4saRqOdkUrje3
         8guI2bdSRiayVsKYvxrh64OgIwFkF68zsnLj6W4oylGnuKJ8YZmEfCHqvHCbOex8AIjh
         HyaNNUNvLSwU4sNDSY5Wcpc3eC1Ju0FiH7sJnGkIYdISzWj5/iP6Az7TKRiG28qK0Min
         1oTt3KugWciJN7cYiLKLubnQsjJhwNrPNXiTfC79J4+JsRRaVRfV5J9XwZlW4te/yRgA
         9CSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712051723; x=1712656523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J22cvATvZxVx1kfNpr32VC2EcIinbWlHC5PnuEWb4Ig=;
        b=FEQ+40kGC7XIiyWmE+nzsMQ+TMeXZFuRnEkQi2EvjQa2KjV4donchvOdJoZ7bsrMUI
         18m0xzlF2F/gz3NySdUNNT1P53zQ/UaWDfOBfU5jnshLhZPHNEDVx4iytnVlpU5hW9md
         c25BYUnuB21v3Gc847YKa46DZEHPld53/GdvcpdMQIF0u7+NaHbLWCp68FvmcsPdJfzs
         7IE3UK4zTqyUrlAuQOQAy8wXuuL/ZiJqEZu0pRqO0vZPnoVJoapYpCSoB62UYRiqglfq
         R5G9l2TjjQX1DAMOcwAZy7gRQB9SSdNKPvXWqKbePhE1Hh27zVnAEmnOekELH2u1pRil
         NjxA==
X-Forwarded-Encrypted: i=1; AJvYcCVMOa8nz6hDW9mpXqYrFY1z9BNZVVli8zmRTocY+jK4pkqMC+WoyXr24njDJWnRU79S1y3xWCxmxKxqiWsLxsEOl9bSm85W5RlytKeE
X-Gm-Message-State: AOJu0YxuACbVmhsRBjMnAN/etS33PWC/pK1sm9LsN87Z9H7yQXE//ZTX
	a8tKYVZUzbTTbBs+gdc9wJdUnZd91c1thVVZbqPR9A4tah2C2OcfwRdp+NBahEBOFO861oFubBZ
	PJkiDl9atQyXadZnm5+OcpYW4ZzgBEIts3XFK
X-Google-Smtp-Source: AGHT+IEcu9bQPdWBbDR9srTAs9tC4rp1YEcz/A6uAognyfQwZDUdoacCnoOivbqDRFhPJKKxEQgRVosZhNrjILkSNkg=
X-Received: by 2002:a05:6102:b11:b0:478:8119:a040 with SMTP id
 b17-20020a0561020b1100b004788119a040mr5557763vst.14.1712051723373; Tue, 02
 Apr 2024 02:55:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240217002622.57322-1-ojeda@kernel.org>
In-Reply-To: <20240217002622.57322-1-ojeda@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 2 Apr 2024 11:55:12 +0200
Message-ID: <CAH5fLggsHHVsuXgzHF4eEpScDTp4pUwaq60tTi9CyL5JfuTFtQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: rust: use `-Zdebuginfo-compression`
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Wedson Almeida Filho <wedsonaf@gmail.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, linux-kbuild@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 17, 2024 at 1:26=E2=80=AFAM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> Rust 1.74.0 introduced (unstable) support for the
> `-Zdebuginfo-compression` flag, thus use it.
>
> Link: https://github.com/rust-lang/rust/issues/120953
> Link: https://github.com/rust-lang/rust/pull/115358
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

