Return-Path: <linux-kernel+bounces-128894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A67F896191
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 02:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD34E28493D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 00:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B35ECA6B;
	Wed,  3 Apr 2024 00:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DEkL8ide"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A49217C8;
	Wed,  3 Apr 2024 00:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712105046; cv=none; b=XU/2jYlns+88Kn1L9Pe7TTr/3V8ai4ElcRkHg0QRWXZygah5VrChTgPBjvQIeKiMMb5Y/ilvnyntF9kNAjp7DJLVKGe7DiYCq4HjcXIa7d1waO0O7BX7ONDQRn2c12efQvwXEOn3dBdJZc5qEHuKD/j5bAurn+QtNco1BSGoLXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712105046; c=relaxed/simple;
	bh=V61TCSZ0jUsTPk8qUFp6mxf+YZJrztTwe0Nf/jw49Do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G9UbuO/Ej/sjxvkrMahGG3Jccz7NLybMlUGvmT5ZWDT9qardScfCE2np8uwlmAF1DclZjaprMmzoTjpIRJKXqRn2Cfthi9KPv4/NRZ1LE6hHDlzqpms3+/y9Z8TXZrnsRwuNaI0hw99nFAPmeFOC73XQctGoYFhRaFFyeGhhEqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DEkL8ide; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D74EC433F1;
	Wed,  3 Apr 2024 00:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712105045;
	bh=V61TCSZ0jUsTPk8qUFp6mxf+YZJrztTwe0Nf/jw49Do=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DEkL8ideA+nykk4WpPhrpK+jwhG0lxLaujjNf0+Wm98BlPGJaQsH6m+BIg0Wxncb5
	 Ykj8+km41Q6RjP4468XKa2u6tdMi5FNiVl8NAHFCXxb4AOnynnwa28GPLPB79BPhUj
	 Au6aLcMtpZxvOVQrCisSOy6uYbkr/WW72FD8a6xI12rQOqNKJYgsCsDfU3qSmte/yx
	 s4KpUAgmT9xq0Jd+LAEdRUrG4UXZNnfAwp8+8HnAzUf7pjbGp1BOeVafD5DRcHOIeU
	 fNqomtEXTS7zT8+oqCmfx5AW+Amji6I79Woeqex7AvHoIb2Nc21iUZreX+eyWsggt7
	 xce0l8terT+bA==
Date: Tue, 2 Apr 2024 17:44:04 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-crypto@vger.kernel.org, x86@kernel.org,
	linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
	"Chang S . Bae" <chang.seok.bae@intel.com>
Subject: Re: [PATCH v2 0/6] Faster AES-XTS on modern x86_64 CPUs
Message-ID: <20240403004404.GC2576@sol.localdomain>
References: <20240329080355.2871-1-ebiggers@kernel.org>
 <CAMj1kXEupfkpe98PdtbxQbtx1z5J_fZFPzT7wJ2tsJnCT9uaxA@mail.gmail.com>
 <20240329093130.GA65937@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329093130.GA65937@sol.localdomain>

On Fri, Mar 29, 2024 at 02:31:30AM -0700, Eric Biggers wrote:
> > I wouldn't mind retiring the existing xts(aesni)
> > code entirely, and using the xts() wrapper around ecb-aes-aesni on
> > 32-bit and on non-AVX uarchs with AES-NI.
> 
> Yes, it will need to be benchmarked, but that probably makes sense.  If
> Wikipedia is to be trusted, on the Intel side only Westmere (from 2010) has
> AES-NI but not AVX, and on the AMD side all CPUs with AES-NI have AVX...

It looks like I missed some low-power CPUs.  Intel's Silvermont (2013), Goldmont
(2016), Goldmont Plus (2017), and Tremont (2020) support AES-NI but not AVX.
Their successor, Gracemont (2021), supports AVX.

I don't have any one of those immediately available to run a test on.  But just
doing a quick benchmark on Zen 1, xts-aes-aesni has 62% higher throughput than
xts(ecb-aes-aesni).  The significant difference seems expected, since there's a
lot of API overhead in the xts template, and it computes all the tweaks twice in
C code.

So I'm thinking we'll need to keep xts-aes-aesni around for now, alongside
xts-aes-aesni-avx.

(And with all the SIMD instructions taking a different number of arguments and
having different names for AVX vs non-AVX, I don't see a clean way to unify them
in assembly.  They could be unified if we used C intrinsics instead of assembly
and compiled a C function with and without the "avx" target.  However,
intrinsics bring their own issues and make it hard to control the generated
code.  I don't really want to rely on intrinsics for this code.)

- Eric

