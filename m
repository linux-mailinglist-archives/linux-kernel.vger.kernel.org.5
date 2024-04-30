Return-Path: <linux-kernel+bounces-164552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D06E28B7F37
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9052C1F25C88
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEA2181319;
	Tue, 30 Apr 2024 17:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YlWfulRY"
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831862E3F7
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 17:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714499319; cv=none; b=tV6v7YMG/TAL9KRLGSI6rrXUrZqev2QNXRJrRpzHithErZsF1z7c0luVmZuE2QLsLOMKcuHAvVm425A4+TexO220OYT+sbz4zv+V4mD18qo+1u6IS1T08g9PfpW4ldiZ/Ff6PVDlreSqrzz3igIp30Dm2vgNcS026MnBjJn+PRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714499319; c=relaxed/simple;
	bh=ru2MPyzMZQzjMduhv2N2UQ/9xbQn6QLmgfDKm1rsklI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CcBLSO/A/cIsrXqW93nYKICativuvLX21y+rAJHh8dccS2/xXuYLYo9SPeWMkdbI41EzWn2ga85Q4QgngHQqmoznsW95WX83ySKRHauoy6XhnmtAc2R1ccGNZhwdUHOVMkGIrrTK9dwa69fRpYu4KOEMWmXoFKVDUL6MZa9QGaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YlWfulRY; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5aa17c29ba0so3992700eaf.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 10:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714499317; x=1715104117; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PDq8d+gYPhH6UpCrQkijKEWZF+TRlH556m+C6sytk2c=;
        b=YlWfulRY7nqh3laQUcmN1fEm+6AaaTNAbM0M0PvA/Ad3IlANOoIDFKMRqieXqscD9L
         S2063I0rnjX5djdZo6JncbvbWsEHBi4my9rWG2UE9ku93DiXD/XdX/0Ma0VdhytQxvXH
         tavJxQNCWhxr6AhfBL8j0GiY2ayarvEst8738=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714499317; x=1715104117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PDq8d+gYPhH6UpCrQkijKEWZF+TRlH556m+C6sytk2c=;
        b=pNdauOlA8TkPKc9AtG1bTHg0CqLxvOGMo0sCsWnAnwQeUPpwk11MGwl6MPZ8mwkLym
         QhFn9VOibhmktiunyAQPtXDnzWC9RCSbx9WFcFdZ57y+3/tG7aALgiSa26/E/9GiBbHs
         UKYXI85M54iXymuEjLOa1am2Fs8cjR7jr9Hq4B73tq+8jswUNvfkLFnhbQ5mFGxg1II6
         kr+J8DL/M3j/jwG7YUhbrIIg2Z0ubyjG/2YfhoLyjCb6IDvZmjHoaZwjHo80dUGM7aGG
         Gjh86O/aYX+A8kd+0AFth9ZUElSxZxcMXZSSlerqvaAPjVpg+GVMOLsW311mPFvHqyKu
         BFDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvHnoqIWs7lmqG7B+QgcmqO8RPUOjNIRQGqCrSLg4/NpGSy5f0QUlwE44wUbATIR7Qp8bdcpCIiKnYoGE+0GOIn6bKnIS5IBAWq+h4
X-Gm-Message-State: AOJu0Yz5rsI4BoPUEcd6IG11yvNOwcRskYHpRp5bq2W2TvfjcZRpyIrW
	+pEH+evgfNO/X6E8FWcmOiFvGPpy3TO+paCCrJK5CMih2M+BbsLyZYXluiMSsQ==
X-Google-Smtp-Source: AGHT+IEmbtVwIHw8WS21DEFm3vZJtcsGN62O+K99Z6mISqTw/HC8GJbY1ZGTCLogwTQdWEB73IJAOg==
X-Received: by 2002:a05:6218:2616:b0:186:5c1:1dd1 with SMTP id oy22-20020a056218261600b0018605c11dd1mr672678rwc.19.1714499317510;
        Tue, 30 Apr 2024 10:48:37 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l185-20020a6391c2000000b005ffd8019f01sm15483435pge.20.2024.04.30.10.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 10:48:36 -0700 (PDT)
Date: Tue, 30 Apr 2024 10:48:36 -0700
From: Kees Cook <keescook@chromium.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-hardening@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hardening: Refresh KCFI options, add some more
Message-ID: <202404301037.9E34D4811@keescook>
References: <20240426222940.work.884-kees@kernel.org>
 <20240430092140.GE40213@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430092140.GE40213@noisy.programming.kicks-ass.net>

On Tue, Apr 30, 2024 at 11:21:40AM +0200, Peter Zijlstra wrote:
> On Fri, Apr 26, 2024 at 03:29:44PM -0700, Kees Cook wrote:
> 
> > - CONFIG_CFI_CLANG=y for x86 and arm64. (And disable FINEIBT since
> >   it isn't as secure as straight KCFI.)
> 
> Oi ?

Same objection I always had[1]: moving the check into the destination
means attacks with control over executable memory contents can just omit
the check.

But now that I went to go look I see 0c3e806ec0f9 ("x86/cfi: Add boot
time hash randomization") is only enabled under FINEIBT... seems better
if that were always enabled...

-Kees

[1] https://lore.kernel.org/all/202210181020.79AF7F7@keescook/


-- 
Kees Cook

