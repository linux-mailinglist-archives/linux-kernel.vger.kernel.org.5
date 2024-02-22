Return-Path: <linux-kernel+bounces-76485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFAE085F7C3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0DF21C241D6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57AC7612C6;
	Thu, 22 Feb 2024 12:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y8gY5qaD"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1146660B86
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 12:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708603690; cv=none; b=KMX5qG0qUnEeYCL7oFFIezfsZQW7o6dd+PPWUTiFQ//TeBAc+WF6lwRSxAQE/YbEp/NNDuprc35zXYLClDZRaCiBVwLtW/1oeOEgXEKONJAtmqjcIrkO85fcs6Ha0AaAwYZ9djH5VayvV86XKaeuK+Ob4U941zDBRPRjkhfeIHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708603690; c=relaxed/simple;
	bh=6FG964kR+hhFtk+3weS36r/Bo7dX22EMfGbaKLILCDA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cfrNY1K7JyyfqjEBk5qzm3h65DkueYdq4B7u9FhcgnF33b9kCrxOJESOgWmEK7E/IlBIOTLaGPOnw3ytIN5ON/1S+rvPp6vBX5D2tuKhCWe8s76ZW+NrlTOBVSY7BL6mNdP9XVwayjEgLjg9yH4oaz2Mvx8JuF36OJemGBOnh4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y8gY5qaD; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dcbef31a9dbso5254794276.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 04:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708603688; x=1709208488; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6FG964kR+hhFtk+3weS36r/Bo7dX22EMfGbaKLILCDA=;
        b=Y8gY5qaD+ii0GUY5qH1s0Cjo8nD3CuuWrzuSnReDuDFOIEMRmQPDtb+eHRTiwp7i7u
         3IOdmMUfhHtL3sRufAMFF4b/yJj8bYs3UGGvexc0ELx1TO/mIylgO9sL47hfHsKJsR+w
         aKx910AWtWt9RiMhY/NJYBurySzQbGCHpsPhxL7FrWucYcYfD5SKCZea3Id8yTtmn2U1
         HFKKXhav2q4A2DIjkFGCeJt6lrwXnhM9jZvyKwTWYKRWciNGYCGIae7cWDG4aGdAUzbF
         yOn/oO1vgurR0IlYXvhHJsqDda+Idib5v7Di/GVPX8aIF5WQ//UyCxXIPnacOSRJmUPL
         EgIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708603688; x=1709208488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6FG964kR+hhFtk+3weS36r/Bo7dX22EMfGbaKLILCDA=;
        b=dj8NujIIflJTjAsSZnn+3LVGhSMXpN0SEhfbgCAm4NaAWxCUyFmBPbRzXKafqzjI4F
         WYtmlbvmDeC/QVaY9qc0ey7R8AXaikQKyfhjVlD6PCiD+Mi0nRyVpXckKeSr2ExkW2T6
         l3LkqRmpayt6ly7mGleP/CQM+9ub6X7fzNIRzOq0r+k2YAP6Nx2vhNUrrpF/TkBY2pyF
         EVeOnWxDMJ1piugUvGZVKbeIjrKiyZ8H4sO+hjWrHNrL3TPOpIA9U7uvwBpiQCXKyHaS
         /NqcNuApMGHQXXMtCkHspwJTfdckjRgWHTOizn28Lya7uDBHKNMOrJvzSFwxINxTmci8
         ke+A==
X-Forwarded-Encrypted: i=1; AJvYcCWQmZkzFO2tcZ6wkTrMhJgoA7n5yZpugBq5ONaqDr9d8Yiso+kFCBrKnjBwQGv5Ho25thq+Gj9n/sA1EP54PoUyDriLawV/UFd3jB1i
X-Gm-Message-State: AOJu0YwFRc+mCuZ2qUH7tNVnnTGrtqyAsdU5WPcYy9KZQ3ddbtdabg1S
	N9ZBwQuOJ+pTNxucy3VXy1VcId0jFdeJid7xF0Gh04WbpcLKsltlyQWHC7Bvvb0D1lGb2KL+mRY
	rUBcLblocmlJdSQ+tF5SdkT2vqY9kKMbAl5pL8w==
X-Google-Smtp-Source: AGHT+IEU4HN8gv1ygZj/+BrXjCf5uYMfTAT4T4O39OAQLi70KFgwNppvWRgM6E87AYUyqulhyKpRGLhEkDoZB0+igXQ=
X-Received: by 2002:a25:bed0:0:b0:dcd:2f2d:7a04 with SMTP id
 k16-20020a25bed0000000b00dcd2f2d7a04mr2028569ybm.10.1708603688074; Thu, 22
 Feb 2024 04:08:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240121203009.9257-1-ansuelsmth@gmail.com> <65d62b60.050a0220.c7b96.614e@mx.google.com>
In-Reply-To: <65d62b60.050a0220.c7b96.614e@mx.google.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 22 Feb 2024 13:07:56 +0100
Message-ID: <CACRpkdYZSr0Kif+q-DBZi7v7qZ=_tedONEP-OPhOHg4yHmwkhg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] ARM: decompressor: support AUTO_ZRELADDR and
 appended DTB
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>, "Mike Rapoport (IBM)" <rppt@kernel.org>, 
	Eric DeVolder <eric.devolder@oracle.com>, Nathan Chancellor <nathan@kernel.org>, 
	Kees Cook <keescook@chromium.org>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@somainline.org>, John Crispin <john@phrozen.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 5:57=E2=80=AFPM Christian Marangi <ansuelsmth@gmail=
com> wrote:

> Any news for this?

Can you please put the patches into Russell's patch tracker so he can
apply them?
https://www.arm.linux.org.uk/developer/patches/

If you run into any problems, ping me on IRC and I'll help out.

Yours,
Linus Walleij

