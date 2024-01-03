Return-Path: <linux-kernel+bounces-15847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECF882343F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 19:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B9D21F250DB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 18:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55EBE1C69F;
	Wed,  3 Jan 2024 18:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="IF9rG6EF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33A81C693
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 18:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 945D440E01FB;
	Wed,  3 Jan 2024 18:19:10 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id tIVUWCeT5Roq; Wed,  3 Jan 2024 18:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1704305948; bh=41ckwIQ1cOsTanraxssYiLysA3mszDJQngRh8ndGtWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IF9rG6EF6vgcO37vd44iR8uhe74ZYsVsHCGg3gc/8Aj1AIhESxNfqRSi9gy3N3tMa
	 xexNQSYLw/Y2Bn+swerZ0kdEAfN/LX4ebJvBBNioCAbzwVGISkh+SYZlOxFqJG1a3i
	 O3q2b+AMbtW5NWDV3LoTjfJPk1vaANxU2aoSnPFwrg/S7V7HzGpGCZuzGF9xfCYIbs
	 x597oHg9c3jOEA27pieOcCmkXy7YgaJplvJsXB/cLJ5LlpZEAwtNsBGthfGkPtdd1z
	 PWNgm3LSoUjE9JTTdB9b8Mejb4j0iIQQv0F6bNALKei/3m77J2Zwcwf9DG0Wy44pB4
	 VOQnSt+7na6TUICD3+vkPjtO6ST3GjlTHimadW/2qJYqmF1xYGR7lnftZD0lzXnR3l
	 wPyPECi6Y4fepwJVleQ53Z5kTUxbBZUEsxJS2/yzp06ybbSGoZkCxARedfwDxZZf1Z
	 vNdmLueV3kj2wCbP0nDMSJSK9OyaSoU0gdKk4fCy0ksvnHoQL+AZS7IFwh9NMViKFu
	 +lf0dw7900bacnH4Oy7N9hVzCTBDjOAh7S56QyYjJmJ/hwd3vrvar7j/MUG9C4aqPS
	 f0rvZ56Ck0r9fXV4rmbjftIj0gEGF5X9xHjKfvpeQo0tJcXy4FFJsPL/35GHAyNQsk
	 NzaZh+It+5Nura1Tne5PTsoE=
Received: from zn.tnic (pd9530f8c.dip0.t-ipconnect.de [217.83.15.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6BA0D40E01F7;
	Wed,  3 Jan 2024 18:18:59 +0000 (UTC)
Date: Wed, 3 Jan 2024 19:18:52 +0100
From: Borislav Petkov <bp@alien8.de>
To: Nathan Chancellor <nathan@kernel.org>
Cc: tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, mhiramat@kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, patches@lists.linux.dev
Subject: Re: [PATCH] x86/tools: objdump_reformat.awk: Skip bad instructions
 from llvm-objdump
Message-ID: <20240103181852.GDZZWlDJMVvqAZdpfV@fat_crate.local>
References: <20231205-objdump_reformat-awk-handle-llvm-objdump-bad_expr-v1-1-b4a74f39396f@kernel.org>
 <20240103181542.GA629234@dev-arch.thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240103181542.GA629234@dev-arch.thelio-3990X>

On Wed, Jan 03, 2024 at 11:15:42AM -0700, Nathan Chancellor wrote:
> Ping? I am still seeing this issue.

Does this need a Fixes tag and needs to go to Linus now or are you fine
with 6.8-rc0?

I.e., the answer probably depends on what kernels you're running the
llvm tests...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

