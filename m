Return-Path: <linux-kernel+bounces-131626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2431C898A33
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AB241C29D9A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BBC1C696;
	Thu,  4 Apr 2024 14:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3IDwNJd"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692B415EA6;
	Thu,  4 Apr 2024 14:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712241232; cv=none; b=QebNiiaeUVIigJxD0RHwmQwVS3CTrWB4x73Kiib3EDyyt2X6w2frHRUNk/6k0R9BfHk80rYrKtmGjq4sr+p3h6a/KdipPH5LCH2XV3AbAnGrmyf4ljiplkj9CrvYmCKSOyA0LOCi2VEjG/9nqxgI3H1zkDFIwumF5GxzbDobRaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712241232; c=relaxed/simple;
	bh=jpF7tTa5Sd3tDtJxZDaT9Swi8PyGNUK+y0VMQ7cXB4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KWg3TIzPpjUdeAJAdLVMEi1KUX59IbEAW6qRC9FIhbJ3ck18WZlvX+mf+/1k855PpasDTc4bOdJrzp5wrvAU5MK4co82UdSQ/LhxYJHy9RNbLkrliKJgcGSKUnmLrpWI0wtmCx/TqyvSeWAHRMrsf1m1EPMpoY6bQq8zkmNR1Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M3IDwNJd; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-53fa455cd94so905560a12.2;
        Thu, 04 Apr 2024 07:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712241230; x=1712846030; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jpF7tTa5Sd3tDtJxZDaT9Swi8PyGNUK+y0VMQ7cXB4o=;
        b=M3IDwNJdiyZ4qFR05T+FfB15+HQK9J3X4VLsA/UlyweDiZhCEZHVAQVcsKKrdVNegF
         /369KiTIZirVN1gQ53sP/GsFkl3XqWIYtL9Fd8JfXlxNA+qlNSzgieaBEYbD4qYN+vpK
         rQJGC09Q0hbiboWMzrxJRcVVchc4qn7E7YRJ7TdkWRKmQD8dz7s3Mxcm/VewvgyHH/mE
         X6jq0OCnO5ex/DNI/KMIje5XrHJDCINYLxg8+tpt+j105WFE9YWmPsde4tOdSjuLA0yv
         uy1mV7MB3/pPSBboyJAY8ysTgnnQsuTHX+yyGJzGmg1e1pTmcWII/hDZJuHU/srtxMqn
         /nlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712241230; x=1712846030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jpF7tTa5Sd3tDtJxZDaT9Swi8PyGNUK+y0VMQ7cXB4o=;
        b=q7WjwBqhxq/Pvl3xYvC9oG0Co2l1D466u09n/Gj6IcUnKm9WP+CG+/g06H4Gf5sOzR
         HSgoUvgMaFIo7oxhzvol6VaxBueY8XSCu1JG6eS156J8VvmYl4QIZKsTeWKkhxvF58Ot
         bvl7bKsCIEOWRHONuecORGrwAllSYtCCkrlzrOhe0iUkdO4RQXcuKr6E0q5hs9NVkThs
         B9UXU349JbDCvUtLz5qATq4TV+dEpSHxonUtMh/CkdzLnJhyPDpnODMeHMeY/MVg4s0W
         wNJhn226PSaK7eZqmYy1CHJQaroSpHykDUjpwEzP9c2RdyRqjDvF0u6GUA3oJ+CYzQyt
         OJoA==
X-Forwarded-Encrypted: i=1; AJvYcCWD909KEA3nsUAiJwyjoW4vbGJz76USkfooaAWmi1IoxXfIEZoWGWvRhWqpT2EcaEM33JomFw8bV1xItoeuYV1gMw4PUdOuoINPlFnl48UxQovweHR9m7CAxM1jljSbOAlnle3Kf/1hiDc3VzIoEcQiBr3IR9FpfdMbtVjf7gecR43zdhk=
X-Gm-Message-State: AOJu0YyF5q/hrJdvUMxRev7exbrX1Gi7Fwui/GhCM0CH16XEWWf+Iiv8
	Wl8dxzWBnYudHin13C6DJNFzQA5+VztdkdbUJwvE2WgoqMU+qvsMEAd5HZcJH/qxF9FJwSTE+4n
	C3CqOPuWL5KBWROrtYySbRI1BA/8=
X-Google-Smtp-Source: AGHT+IG20eNpSzNkxnsgTkafpuA97Ew4OmO4JnqBaV5mNVNvOzgcdHEwHOPWG79O1UTpYlFkEm87j6CqNJkr6GVC/L4=
X-Received: by 2002:a17:90b:f18:b0:29d:dd93:5865 with SMTP id
 br24-20020a17090b0f1800b0029ddd935865mr2399668pjb.46.1712241230437; Thu, 04
 Apr 2024 07:33:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404-providing-emporium-e652e359c711@spud>
In-Reply-To: <20240404-providing-emporium-e652e359c711@spud>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 4 Apr 2024 16:33:08 +0200
Message-ID: <CANiq72m9YAu=dr1=WMSHOqfpszj4S6OkMEQ05vqbv_zKO5pOsg@mail.gmail.com>
Subject: Re: [PATCH v3] rust: make mutually exclusive with CFI_CLANG
To: Conor Dooley <conor@kernel.org>
Cc: linux-riscv@lists.infradead.org, Conor Dooley <conor.dooley@microchip.com>, 
	stable@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Sami Tolvanen <samitolvanen@google.com>, 
	Kees Cook <keescook@chromium.org>, Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev, 
	Matthew Maurer <mmaurer@google.com>, Ramon de C Valle <rcvalle@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 4:17=E2=80=AFPM Conor Dooley <conor@kernel.org> wrot=
e:
>
> From: Conor Dooley <conor.dooley@microchip.com>
>
> On RISC-V and arm64, and presumably x86, if CFI_CLANG is enabled,
> loading a rust module will trigger a kernel panic. Support for
> sanitisers, including kcfi (CFI_CLANG), is in the works, but for now
> they're nightly-only options in rustc. Make RUST depend on !CFI_CLANG
> to prevent configuring a kernel without symmetrical support for kfi.
>
> Fixes: 2f7ab1267dc9 ("Kbuild: add Rust support")
> cc: stable@vger.kernel.org
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> Sending this one on its own, there's no explicit dep on this for the
> riscv enabling patch, v3 to continue the numbering from there. Nothing
> has changed since v2.
>
> CC: Miguel Ojeda <ojeda@kernel.org>
> CC: Alex Gaynor <alex.gaynor@gmail.com>
> CC: Wedson Almeida Filho <wedsonaf@gmail.com>
> CC: linux-kernel@vger.kernel.org (open list)
> CC: rust-for-linux@vger.kernel.org
> CC: Sami Tolvanen <samitolvanen@google.com>
> CC: Kees Cook <keescook@chromium.org>
> CC: Nathan Chancellor <nathan@kernel.org>
> CC: llvm@lists.linux.dev

Cc'ing Matthew & Ramon as well so that they are aware and in case they
want to comment.

Cheers,
Miguel

