Return-Path: <linux-kernel+bounces-59526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2382284F863
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F1DD1C23243
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414ED71B56;
	Fri,  9 Feb 2024 15:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aEMDcCAH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EABF6A018
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 15:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707492152; cv=none; b=J3NZF9yYeEo+fdmcqJmxT0vt3SwjXrkndoKXzQ5B7H11ML1mqrZOANth7wmJFSV6iEROYYzKmrnA1tjuvWvHrnomQIHd3ToSwwaCV6miGho7peW8YtVf8mOsv+Tx9Lrk3vcHqVQoa1PS8q+ZHuUEz0ouhxmV5Hx1zsvC08S2IA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707492152; c=relaxed/simple;
	bh=4w4nZBv+82YsBlgTXyhAINiiD+1MISPEh/ZZnZDPk2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KLRMPrd/KjYSYPkq5OgZxlK8DC3vqsZnimnZVJCl41Kh/R2kRRRciLhY5e+7rm7VE6EsWDC4va6WruflgCbyfhZftXPTLcW+qrsysbLTHsHEVk+Q2GffDss/UzMowh5IoXNFPoz+EbDYnh2by78Dh/B4BrvLu2VqCOfKsvVcgK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aEMDcCAH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB0DCC43390
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 15:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707492152;
	bh=4w4nZBv+82YsBlgTXyhAINiiD+1MISPEh/ZZnZDPk2c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aEMDcCAH35jlMmr4u9MbrxI0rCLFf+b6Yu21To+tgAsdTPHsIbGgxT3uIEm1ZXIun
	 XjlPynIDNuGnDlkqDbCEvi71RApRaI0nGmxKkzVSDJFTt4TrO8D46SjJrvAWuY+XfP
	 jHJvkS5k8uOsx0bMGUG69xyOxx39kof8eSn49sys9nRi3qTvoa8DdGUmmi9x2TySlw
	 HUgk2t1I/UJ/WztN08c5IeKw+M0ZDXKydvqncC7Pgk8992MjvPD0oUWmEfqazmGbcu
	 TsqD5jyDzeivNJDegyvlNykT16hyZcIAawB5hQB9NpaQOC/xfCGOpYvttFpzs7MuHU
	 KrsjNYLsy+PjA==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d0cd9871b3so19915481fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 07:22:31 -0800 (PST)
X-Gm-Message-State: AOJu0YyddfyB5E/+8/6VFxOgZYep/gsJ7fx0Ns4g4rmvRd6ai+iln/71
	dfa4kamC70EkpX3Lm6POgoVXSTGXdPa7GIlDNLOhaWXphflMrS/YQ/cT408VPFZwsEQLqvYBxuq
	QMJeyyz1KX1i7L6MiJBqFKBgXf+w=
X-Google-Smtp-Source: AGHT+IGkvPhqy7hFj1Y0ufun2PQAFMP6VjM3iC0Ia2Zdtcpmlq0xqEtITxmNpljfJ1+W5J2D9fN5jhiGd3/LlF0mkwg=
X-Received: by 2002:a2e:86d7:0:b0:2d0:82f0:ba3b with SMTP id
 n23-20020a2e86d7000000b002d082f0ba3bmr508186ljj.5.1707492150162; Fri, 09 Feb
 2024 07:22:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206223620.1833276-1-acdunlap@google.com> <168b4e3b-8076-4fc3-92bc-fcd9f2b516a8@intel.com>
In-Reply-To: <168b4e3b-8076-4fc3-92bc-fcd9f2b516a8@intel.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 9 Feb 2024 15:22:18 +0000
X-Gmail-Original-Message-ID: <CAMj1kXE4Yhh_5y=ybFkD7YQUZuh7+-P_Vyzv-gpvbQ=i=eRMnw@mail.gmail.com>
Message-ID: <CAMj1kXE4Yhh_5y=ybFkD7YQUZuh7+-P_Vyzv-gpvbQ=i=eRMnw@mail.gmail.com>
Subject: Re: [PATCH v3] x86/asm: Force native_apic_mem_read to use mov
To: Dave Hansen <dave.hansen@intel.com>
Cc: Adam Dunlap <acdunlap@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, 
	Arjan van de Ven <arjan@linux.intel.com>, Wei Liu <wei.liu@kernel.org>, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, Jacob Xu <jacobhxu@google.com>, Alper Gun <alpergun@google.com>, 
	Kevin Loughlin <kevinloughlin@google.com>, Peter Gonda <pgonda@google.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 8 Feb 2024 at 16:48, Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 2/6/24 14:36, Adam Dunlap wrote:
> ...
> > In particular, when compiled with clang and run as a SEV-ES or
> > SEV-SNP guest, the compiler would emit a testl instruction which is
> > not supported by the SEV-ES emulator
>
> What changed?  Why is this a bug that we're only noticing now?  The line
> of code that's modified here is from 2008.
>
> I assume that it's something new in clang, but it'd be great to know
> that for sure.
>

Might be the use of LTO in the Google prod[uction]kernel. Adam, can you confirm?

> Also, considering the age of the last commit to touch that line:
>
> Fixes: 67c5fc5c330f ("x86: merge apic_32/64.h")
>
> this seems like the kind of thing we'll want in -stable in case folks
> are compiling stable kernels with new clangs.

LTO support was introduced in v5.12 afaict.

