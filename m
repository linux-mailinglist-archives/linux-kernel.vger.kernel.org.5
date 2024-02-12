Return-Path: <linux-kernel+bounces-62207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63736851D02
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2052B2811C6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8766940BED;
	Mon, 12 Feb 2024 18:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CC3IZAjB"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864B73FE2B
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 18:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707763352; cv=none; b=JvJf06gEKU4PBww+Q7I+JhX6N50ABAm8xHmRKnLq4wLAR0YThSxiQj2Dgg/peYwgiXLEdlWvCnGf7ia8J+oSzXshuFFCdmPqMrGFoYkLAPULWqLy9DY8WRnorHCGynTv5by1a6Niiz9W12/64ep0XCrjcXql6/SZl3ztRXuCJbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707763352; c=relaxed/simple;
	bh=Dc5XPnxb7UwGebap8tjBl1xRgA1Ca1uOKkbMPUv6C54=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GBmepKbc5a85SmtMTkuuzvKL7gzT0cEuJ7yngXn9hLjeevkPF2N/bP4EDH+UzwPPI6BTvult/C7nwl0Q3KhXS8+Rrykeg4cn1ruebp2s1iiFe3F/VhyAmSI8abauNyn+KtR31s/+uqeXhBS57HHqvQ1r2BFlt3kRoHVyeUODass=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CC3IZAjB; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d7354ba334so30159525ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 10:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707763351; x=1708368151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C5O/DgDJHKyCX9I0LJ0N7xQAH4vdnIVRZHo7qsnEaBE=;
        b=CC3IZAjBaE9iTWekttb/pkAkZ6a0cBlFBewIwLi0M0rAWolU2inX9QxcYLGPhZiIzv
         wLghtnt/+YjMl8X/T+Wgd+3diuASAKvZFBtTDakx/3miBwsfOyeDT+HvjkMkdxKkCP4e
         +a1qsptJRhZpAFXC8J+gMpUj/ndv+lFL/zyHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707763351; x=1708368151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C5O/DgDJHKyCX9I0LJ0N7xQAH4vdnIVRZHo7qsnEaBE=;
        b=GdOFLJA1fDp64JjcD3ljz/vFYHJ9+9737nH8nN7MlnjJ9dwOrcJwNhftXs0kqK5IPp
         hMKGIGJS71XspMpPfjR7vjWbDGZmYaxRRrFSioNqR9BuL0RFIfUKB6aOjfioBvwRsD+m
         ce3exgY3JhRqrDgMp9ljn+G7AXrpp7SoEKdhjPJw/lMUcozRq+lLbjDflLccb2IW4pv1
         dmDSUaNWALpommd65daQQu7Ec+4gNpDlmDJEjO6T0R8b4K4uA4ELOhkECncFFmVsnwOK
         YFoq9cKvZF0rE3bI6UJ2jQEp88sZbQH8KTV6TXggc3UZW8x77w8U+aFvWxDMUUc+KQ3/
         NcMA==
X-Forwarded-Encrypted: i=1; AJvYcCUEC/y9NbG7oFzpxZUo+9/rNvQ1GA8adU23niGWnodfJxjX55HS5CXUZtsfOTm+TU7UNfgTlmCw0rNMGp1xJApgIFwCFwA8+MW+67D6
X-Gm-Message-State: AOJu0YwPJMnoiQH0rwqIzGAaOudLWRv/b9M7RK2gmFNPGu4VoKnOmjyz
	uFhih+FVPBH7lErrMRLcw8uT29NWtbIJSNMkOzLL0Z+v/G/PY4nOeZTg47IlKg==
X-Google-Smtp-Source: AGHT+IGuNWmmvasCZlNeCuflr/l/B+u8uIsMCuE+Gp+MUi8YBlXHSsSjfuvdTAH3WF0RmOHfbet8rQ==
X-Received: by 2002:a17:903:228b:b0:1d9:bbc2:87e7 with SMTP id b11-20020a170903228b00b001d9bbc287e7mr10750955plh.36.1707763350839;
        Mon, 12 Feb 2024 10:42:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUlN1kCG4L3xI7IqulfRnGZ15q3ilsPABEiCGdulsJoWDtsXE46LZ/Ym6P5yoP53zCEmaijFBQHFhM01x1GopsuaZFy1q6u6QC9IzmhFBRdPZznJos6l+0lclEdcvZGPvL481HLNn0rjz+zhmE=
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u11-20020a170903308b00b001d9a146907dsm672613plc.11.2024.02.12.10.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 10:42:30 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Tycho Andersen <tycho@tycho.pizza>,
	Arnd Bergmann <arnd@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] samples: user-trap: fix strict-aliasing warning
Date: Mon, 12 Feb 2024 10:42:27 -0800
Message-Id: <170776334482.2557794.95461406898503535.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240212111737.917428-1-arnd@kernel.org>
References: <20240212111737.917428-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 12 Feb 2024 12:17:31 +0100, Arnd Bergmann wrote:
> I started getting warnings for this one file, though I can't see what changed
> since it was originally introduced in commit fec7b6690541 ("samples: add an
> example of seccomp user trap").
> 
> samples/seccomp/user-trap.c: In function 'send_fd':
> samples/seccomp/user-trap.c:50:11: warning: dereferencing type-punned pointer will break strict-aliasing rules [-Wstrict-aliasing]
>    50 |         *((int *)CMSG_DATA(cmsg)) = fd;
>       |          ~^~~~~~~~~~~~~~~~~~~~~~~
> samples/seccomp/user-trap.c: In function 'recv_fd':
> samples/seccomp/user-trap.c:83:18: warning: dereferencing type-punned pointer will break strict-aliasing rules [-Wstrict-aliasing]
>    83 |         return *((int *)CMSG_DATA(cmsg));
>       |                 ~^~~~~~~~~~~~~~~~~~~~~~~
> 
> [...]

Applied to for-next/seccomp, thanks!

[1/1] samples: user-trap: fix strict-aliasing warning
      https://git.kernel.org/kees/c/9ad28ca5238d

Take care,

-- 
Kees Cook


