Return-Path: <linux-kernel+bounces-152308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BF78ABC35
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 17:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABDFB2817E6
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 15:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9DC29CFA;
	Sat, 20 Apr 2024 15:30:10 +0000 (UTC)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E66DF43;
	Sat, 20 Apr 2024 15:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713627009; cv=none; b=cT+qKUIcmRz0u4f/HuMfKxu/o6iw0z6KhJ6Gydd0I5f+GRAcjoc/GgxIYIgpQSld2soSGNM1c1HbfkANJ1bB2msTFKcVZNTr7pZ3oE1BBUgNTBORdTjXS2CNiGCcX/ULmrxLuqAjs8GlYuE0R+/O05WJwI72GDl/8WesEjXKDEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713627009; c=relaxed/simple;
	bh=zrpo3OvsUFS4Ufib08wcjF98LCeg0CMEAhoUL8ACJSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mw75dZUFf8RP/RZ9aa5k7glam601Auwl4RI+VP7c5ZERQsxrzQJEoVAJ+X+uWpi9v6bOXVe18jihC9eDLn3vJFVE2FkENU7N5AkmXCU+jdYali3VOxwQ6eSBmBsE+UTymC0fIfW2dafiYaFYETIvegzzbkm7QYot8H4KSN9Drwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1C71940E02A5;
	Sat, 20 Apr 2024 15:30:06 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id y7PQuM5tyGjq; Sat, 20 Apr 2024 15:29:59 +0000 (UTC)
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0707840E00B2;
	Sat, 20 Apr 2024 15:29:42 +0000 (UTC)
Date: Sat, 20 Apr 2024 17:29:38 +0200
From: Borislav Petkov <bp@alien8.de>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, Song Liu <song@kernel.org>,
	Ricardo Ribalda <ribalda@kernel.org>,
	Fangrui Song <maskray@google.com>,
	Arthur Eubanks <aeubanks@google.com>, stable@vger.kernel.org,
	Steve Wahl <steve.wahl@hpe.com>,
	Vaibhav Rustagi <vaibhavrustagi@google.com>,
	Andreas Smas <andreas@lonelycoder.com>
Subject: Re: [PATCH] x86/purgatory: Switch to the position-independent small
 code model
Message-ID: <20240420152938.GDZiPfYl9iIgJw6_ux@fat_crate.local>
References: <20240418201705.3673200-2-ardb+git@google.com>
 <CAKwvOdnNurTJNb7iOVW4dpkV-rZGWg2t3HuLkL+B5sNOin39WA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOdnNurTJNb7iOVW4dpkV-rZGWg2t3HuLkL+B5sNOin39WA@mail.gmail.com>

On Thu, Apr 18, 2024 at 01:36:22PM -0700, Nick Desaulniers wrote:
> Reported-by: ns <0n-s@users.noreply.github.com>

I don't know what the goal with this tag is but this'll keep bouncing:

<0n-s@users.noreply.github.com>: Host or domain name not found. Name service
    error for name=users.noreply.github.com type=AAAA: Host not found

Maybe use a non-void email...?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

