Return-Path: <linux-kernel+bounces-131720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65014898B0D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A7D91F2273F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50BFC129A75;
	Thu,  4 Apr 2024 15:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3KbwrrJQ"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247C45C8FE
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 15:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712244328; cv=none; b=R7erYSpdia1hL7XYaYBPGwRfK93D09Z6n1KF5asoTAex2q7Gj/n5OVKv+xFT6fLGqgxielsHlFhFYGFZR/aVynGOjMor+fR7LfUBy1eJ+69/t9+sdDkowi+jtHqb4EeskxSlLmSGA9x/PQ8XeazvZoLQPCku04D0wME8D4exlE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712244328; c=relaxed/simple;
	bh=ByPtciC+URhiVQn652U1XVXGfMYChxV1rxw8MNlXaIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fZsX6eTvyEyP7gNgbO3/TUMP8ETxd+XA/4PaShYBzkwK9FIPPOrVIc1w4cqLlXlee2vaoiKrMjZBFMTAdX5Ij5hwDLysvX1QvEUBoJ+A/0gJCzddDbzboG4gCp5U3SBLzrlyxQUqR879SbTU7uwEGqklq7m2lhB4/HIxcPZxWsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3KbwrrJQ; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56dec96530bso15807a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 08:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712244324; x=1712849124; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ByPtciC+URhiVQn652U1XVXGfMYChxV1rxw8MNlXaIw=;
        b=3KbwrrJQZzfIrIw9kmj5cAwEQcQe+0cQnLbAtma5TERwj6wcfCE6ZBwEZrc8GBQgfd
         nlisOW0fe6K0IcWmdHupK7T0l94BQkYP6YJORP6rpGJPLZMGZeUmNPZZOudKY+QoUkHZ
         nlFVDvvnypBAHuFzeY2WIkVAmNjHFn/eOCIcO95ndgR6Wy5nIcOIlyoSkSUjbwuXnpsi
         plka2E9MmNY6aqwGdt7w9bX/tLEDhm8hDMkK2YSZpfFMOHRWrRsAOocQvAKIDZ/BIWrH
         t0tIxSik+9PS4aLEsc0d6c5feBKF5WWeo1u9J67F0dVw3/o0cMwQRTYPJjA/amRbZ3o2
         cXpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712244324; x=1712849124;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ByPtciC+URhiVQn652U1XVXGfMYChxV1rxw8MNlXaIw=;
        b=hkImqRgLoQ0S3R7diX8+8exjXc/LSts3E2Gmp5K+ZK/ecVmQfaMzFQNvaGFxVOVyk/
         1o5RlBVhmYWPM3qvi8wEGBdgKOiUVdVG1bF1j7BBLyk9FdVeJ70krRosWIgIk7DD+m9K
         WnuHhKSSyc92f9Iyy6MaibzrZtF25kK4AawwXTT6w8Xmq2/924VsYWnOgbcBe8LzW2x/
         uMk+W7sPBbFrbd+twEQxyjXt13GBcjRP83aTFSq6r1hrqFiXhxTopjiHundtq0GqORhl
         mWBB43tXPN/JGQQtgRr7UgKDYI9JRr6rKeYUSN96EhuskfIhOB2GQdrhGgfY4sCRkcOS
         t7DQ==
X-Forwarded-Encrypted: i=1; AJvYcCWugFU8YU4Riahxvi4BZIEhuyqVx77uPcAeAf/x4TMWnl0IEPRWHYgHCpsFx/ZQWQZpR4Fs8wA0pNQSJ4yMjYRlQkqrxrN21oK+758N
X-Gm-Message-State: AOJu0YxA9cSPPvBwQRHCD9pbRB3TpX3eyjazHk5TbFckoO6MO2XR1lBb
	AAbU3RIYEef3i1imntgca5TtGIDI4Y6HysdS2CccYqAfSXvy4SrdIOAE2euzzz0igHwsXM6+kbq
	WUrw4OoCYf8cHCsqUgxMliGsPCf8sOHiJzvCj
X-Google-Smtp-Source: AGHT+IGu/Cr/TzqDAagcQzAh2crALYKXnU9saXFMj2Uan9qVNOsYqiQC9yQvytlJZqCQ8hhUrVOQhul4utm/mgjk4xU=
X-Received: by 2002:aa7:c38a:0:b0:56e:234f:b44 with SMTP id
 k10-20020aa7c38a000000b0056e234f0b44mr71333edq.5.1712244324404; Thu, 04 Apr
 2024 08:25:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404-providing-emporium-e652e359c711@spud> <CANiq72m9YAu=dr1=WMSHOqfpszj4S6OkMEQ05vqbv_zKO5pOsg@mail.gmail.com>
In-Reply-To: <CANiq72m9YAu=dr1=WMSHOqfpszj4S6OkMEQ05vqbv_zKO5pOsg@mail.gmail.com>
From: Matthew Maurer <mmaurer@google.com>
Date: Thu, 4 Apr 2024 08:25:11 -0700
Message-ID: <CAGSQo024u1gHJgzsO38Xg3c4or+JupoPABQx_+0BLEpPg0cOEA@mail.gmail.com>
Subject: Re: [PATCH v3] rust: make mutually exclusive with CFI_CLANG
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org, 
	Conor Dooley <conor.dooley@microchip.com>, stable@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Sami Tolvanen <samitolvanen@google.com>, 
	Kees Cook <keescook@chromium.org>, Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev, 
	Ramon de C Valle <rcvalle@google.com>
Content-Type: text/plain; charset="UTF-8"

>
> Cc'ing Matthew & Ramon as well so that they are aware and in case they
> want to comment.
>
> Cheers,
> Miguel

This patch is fine by me - the last patch needed for KCFI to be
functional in Rust just landed upstream last night, so we should
revisit this (in the form of enabling it) once we move to
`rustc-1.79.0` or later. In case anyone wants it for local
experimentation, I have a backport branch [1] which applies these to
the 1.73.0 compiler and enables it in the kernel [2] (not upstreamed
because the feature isn't yet in kernel's `rustc`), which Android will
be using for the Rust binder driver. This patch will require a recent
(last year or so) clang, as it relies on
`-fsanitize-cfi-icall-experimental-normalize-integers`.

[1]: https://github.com/maurer/rust/tree/1.73.0%2Bcfi
[2]: https://android-review.git.corp.google.com/c/kernel/common/+/2930616

