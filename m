Return-Path: <linux-kernel+bounces-163368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F81B8B69FB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 07:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E413B211C1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 05:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997E417732;
	Tue, 30 Apr 2024 05:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fgdPrb1f"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA69417582
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 05:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714455306; cv=none; b=sVZlj0zQpHyi2EKHtdBfVIkxbPKWpBLavjzi/AcqvhHLa5KTEkQD6E2ngwFc1qx4dH7Tx6q87dMkQTrL9aesp5y6ACzZTNHkEZ7DUcB0KZKl9QbxpSPUr2f4JXCnU83hAwfHFbgmulSVioN2ORH+ltU1FUWxLEs7SGi/N0MyqMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714455306; c=relaxed/simple;
	bh=0lANZJBk2q8qyeCEkyiuDs1ISrEWT6/wJvz29MPlTds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0DOO2GG41Y46ecQ5BZyS6/OSzqMVL+muEYsgxjYiosbqgRl0MjEV9vozW9XN/+Zr5NAsvxYTOmNBJ+crbAifq2VvNWWYinyfV4QIKe44pA5WI/NG2H9HYlpJuD8xM/tPxZP5OHv2yBIlwEPvCLqzu62T+tk2rFUGQ3aPqbeYCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fgdPrb1f; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e51398cc4eso47424315ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 22:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714455305; x=1715060105; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C86TkJMefuwLFYqPDfjsQaXZDgvqLvjIZeQbeqShpoI=;
        b=fgdPrb1fqMg18QNi+Pibt7ddGBbLBeJTYIr+rtbLx4zjLo43ZPIOW8c9E5FGJW6+MP
         1VxatqfLGnebt+stBICmPtKa355/tPMUFLb2jr/6oGDJshRknfbLwjWPuyrqvEXcGS3t
         dJoSkL6kbLyXEokUdojkGlim1daRxm6Dyjo4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714455305; x=1715060105;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C86TkJMefuwLFYqPDfjsQaXZDgvqLvjIZeQbeqShpoI=;
        b=ZJ4dR57Z15cbpS2YHf+5cdSSfIfGRWjPTwQrb8+p8Mr/BcdpPrZ3c03elsS+AigKqF
         I6JZi54bPiepzQEnSC6itpL7xA6qM58HLjosy3feunQrmesomB2Gnn0mja2Elq7NIP6l
         mxW2J0Jg0/Ji4ihbLrlSTQFkEAKn+7QEygPKr6Re3FJUL9+5RCCXhZKqdl2ozxg7LOK3
         PpzzqwQVQTSkizfQnEF9hfTYM9HF1gXB4UiBpocQsOz8l2Jt0LMtTLmsdpvuXthOuZp0
         UEI+47ukK3j5mdXy0zUCEyw4jfu0LKRsCroFmJwBIXbkB2BygtwLYDK3gU99OHMv1sUM
         IF5g==
X-Forwarded-Encrypted: i=1; AJvYcCWBhLGq2g3PpjClLauDSaLJUnAPzs40PmGFFdTze/kS8OZEUEcMhdny5Fd00Jw4Aua3pCY0Ra8RvyBgafpbu9kj8x0ENtKiKjVup7AD
X-Gm-Message-State: AOJu0YwDsCy/y0a+g2sAQxupO4tYOVJRYpMIN+j1Pfz++aQkMudhbyi0
	uayeleKj3/S5dCdhMlyXpyGgTaV2TSbUx7yxDyOLHGPUSIpdpS0OF9x1duTtvg==
X-Google-Smtp-Source: AGHT+IExYVGtME+b7bsTki80m/529C/WFpqN5LWnzvSEWxibnamEqrs4aXGKwGyaazB7ViSXdQpIYA==
X-Received: by 2002:a17:903:41ca:b0:1eb:1240:1aea with SMTP id u10-20020a17090341ca00b001eb12401aeamr16493520ple.20.1714455305039;
        Mon, 29 Apr 2024 22:35:05 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q4-20020a170902edc400b001e29c4b7bd2sm21410591plk.240.2024.04.29.22.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 22:35:04 -0700 (PDT)
Date: Mon, 29 Apr 2024 22:35:03 -0700
From: Kees Cook <keescook@chromium.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-hardening@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hardening: Refresh KCFI options, add some more
Message-ID: <202404292233.9A98A7C@keescook>
References: <20240426222940.work.884-kees@kernel.org>
 <20240429221650.GA3666021@dev-arch.thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429221650.GA3666021@dev-arch.thelio-3990X>

On Mon, Apr 29, 2024 at 03:16:50PM -0700, Nathan Chancellor wrote:
> On Fri, Apr 26, 2024 at 03:29:44PM -0700, Kees Cook wrote:
> [...]
> > +# Enable Kernel Control Flow Integrity (currently Clang only).
> > +CONFIG_CFI_CLANG=y
> > +# CONFIG_CFI_PERMISSIVE is not set
> 
> Should this be a part of kernel/configs/hardening.config because RISC-V
> supports it (and 32-bit ARM will soon too)?

Probably yes. I was worried it might be "noisy" for archs that don't
support it, but frankly if someone is using "make hardening.config" they
probably want to know about unsupported options. :)

-- 
Kees Cook

