Return-Path: <linux-kernel+bounces-146307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 562DB8A6362
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E941D1F22826
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 06:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B886C3BBF1;
	Tue, 16 Apr 2024 05:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="NRKQuVG7"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA8A381BD
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 05:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713247196; cv=none; b=GJJ9VR3uVYJdDnFClBJLVatOCWVdrbs5UIcso6Vc8VxnKD1wSMz4jHtVPc0fe3un7s6YSpjtnUUrvoesd8RgZRRNDWDAAOK0gbI7DS2fBsb3ykCv5PFAojZTjpqkD9UmCUgB/PXERLJYd20qFBy8Cn+jz/11n/mEKnxKLf8sQ3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713247196; c=relaxed/simple;
	bh=/X8kldfFUfv1kzJjaEOkSnhEVlOxiDNHtvLt9f358Sw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lmDaGeG/z6+JxFhrmA9l0JcDa9gTDZ8UUJ4LbjMuvVEg7f2xV40XHK80bPxQtrZnw+9PdQBVpRMk1L8onC6z2bopRqlfcvrj9HI0r9jSguzR0QweYLyRLe/D1YOX48F0wNMftqOREhMs4QcySSE9HUo/OBZc5ry3voZk7l/0QOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=NRKQuVG7; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dcbcea9c261so3990564276.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 22:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1713247192; x=1713851992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/X8kldfFUfv1kzJjaEOkSnhEVlOxiDNHtvLt9f358Sw=;
        b=NRKQuVG77HhCrvAhtniZzTBuFWB9mDGIvv6hNhelED0+OyDiwsWP4IZgipl1K1pO3P
         zLOGu30RvbdJ+5Z9akTiOcTmHX/KQXjTQwsWJK+GudilMzNUbx6+yCX6KB8F38IUf20e
         PZcqTrsGs4xTS2BsPBYSMG4QV9Dr782Nda7XzA/2x24g3f+ehwimmjPBFejawGpCXlLF
         XTuW7bF1rGw9bGGvzSgxBPuoNtJuRyXsh3zXApdZ687Q4SEY7BZMFfsxCajMgvosvZ77
         Cr5WEPCA7a261VIMahbdywMvBo4bWRLkzpPb3OExsP74JKEl+Uq66QHF+CM41sSiGKue
         /CUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713247192; x=1713851992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/X8kldfFUfv1kzJjaEOkSnhEVlOxiDNHtvLt9f358Sw=;
        b=YrX1sbhF9TanKc8jzE+7Pgx364uSRrURTOrVivKVYTRAf3z/FasQOoJ7aS9wHJgLeV
         k98yu/DT6OkxlFxx6j7ALdfFFNFs2qGZWQ0+ONL1NNM58opuXVYodhLEZjBOX2B2m8qr
         +i2O6ksSNGw29oVfAaZTAnw297Xb7WD/8wrrw/Wt/RUa6+UVMviBBuMvfFts4BYYN+uk
         RcU2Z4jooUnZLRZoyab30JupB2YlbJJtczKSRt46n5Qb+rXDbhW6pfsa0xMpoJ8CBHuP
         6Hya8y84U6xXXLj+MsBegvNR6nym3VXv8wNK1kqpEbeGPIUDYHuDhyEsTtUb7yzTU4Dh
         /GWw==
X-Forwarded-Encrypted: i=1; AJvYcCVe/fc5jg1jwQ7/J3g+YiEwx3ZmbI2Orq6f9KErHEIPTxleRwXi+Gx0qu53HW1dHXsYfBVm1WG6B0cO3sDuDi7FQ7MIDkuNyqYgc/AT
X-Gm-Message-State: AOJu0Yyh4KkV78p6E/EcDKASkX307rvskPoWNXaJnKu0PaQT1c9vbBBv
	H+vMToESGdsHO0k90etKoxe4kpYSGesAjQJr7q6h1da8h+Coj3DF22iQITZvKSR5ypKZ4dTA0L9
	Fyo5mS+jU+HW0+p4ctUwWAMnx5dzViB1DkXW0JQ==
X-Google-Smtp-Source: AGHT+IGxAA1/6dVIS1Tb+gSLLJflL07G22oif0AkvdsPqP9aSqkDkjAr8InDn/XDCdmfFrrltHVNs2i2RdXihQa72Bs=
X-Received: by 2002:a25:8211:0:b0:de1:1af9:c7ea with SMTP id
 q17-20020a258211000000b00de11af9c7eamr9541679ybk.1.1713247192343; Mon, 15 Apr
 2024 22:59:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411205428.537700-1-thorsten.blum@toblux.com>
In-Reply-To: <20240411205428.537700-1-thorsten.blum@toblux.com>
From: Trevor Gross <tmgross@umich.edu>
Date: Tue, 16 Apr 2024 01:59:41 -0400
Message-ID: <CALNs47tJrsAJt+-CWfVuQDxUoNSi0De5-1y5hD=YZPKL26uVDw@mail.gmail.com>
Subject: Re: [PATCH] rust: helpers: Fix grammar in comment
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 4:55=E2=80=AFPM Thorsten Blum <thorsten.blum@toblux=
com> wrote:
>
> s/directly the bindings/the bindings directly/
>
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>

Reviewed-by: Trevor Gross <tmgross@umich.edu>

