Return-Path: <linux-kernel+bounces-75034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C3A85E1F8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6AED1C244F9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B49281749;
	Wed, 21 Feb 2024 15:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="ki+ifFrU"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13E280C04
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 15:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708530782; cv=none; b=EcdioNRONrhHyoAQ0CYigulrVZTb5GOaWmfqYBhZAh8biO6DjRYFsxxnB6JBLYR+PeuyInfMDe8XG9ASnr0B0D67FXyYcKl7jun2+PduavXXRYV1HJI3KUlMDAZ7HZifCwZkYEA6oLhOx1cjgVKqVVEKMrPuEkkJSyWKvxmYeIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708530782; c=relaxed/simple;
	bh=Ra9/UKRL6qZi0vZz1rdmAVM+RpYX5dfMa4L3P5pdOAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H6OoifpVaMX6gCCjBR/uZGxKwYkaqvtLdUkw0a/SMKd+w3PeWgzwgTq+T11MHjbjTQvdFCb5Zq6XggAF3+7tK4ndXssjTyXLfSi+MABcjWW6XMtaacb5c2g3sp5aeyhD170UH/59DhE0wjC8gzRivuKW4ZqAmWkF6NsoTITg434=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=ki+ifFrU; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-102-198.bstnma.fios.verizon.net [173.48.102.198])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 41LFpwMs001015
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 10:51:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1708530721; bh=efKwvL9uolpwwXii1YLcblvLBk1Mkbsw9Oy9VotAMtk=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=ki+ifFrU+r4cRsszgtOQQkvuU8AnK11ChkT5VsV8okX/4tPPZv/N0zZwFcraoxJcX
	 xXwHcov90zmAowqGIJ4yZiC8WPGoFN7WAxYbfa9Ro5H2nY9JOLn8RALnRzQLMz4mXi
	 PSvltheY44N+df/l11hoGrSkvVM6hcD1/kP6+yeFdEQhyNDFO44Bbd0wZ1UBTcOciP
	 Be9ufPu6gYU02l+7GS/I8nF1rQxUALOkWsFfbRtFdYqU6AxKkvhtYccJvCNfFeMbz3
	 Gl+Ag+qhnQ2MRd5dcj1zcOBxWTNkLXH+uCnhSY/FNrFZxI4pzRF0wr1EZLYHNQO3KQ
	 uJE9Yj0ro6KfA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id DA42915C0336; Wed, 21 Feb 2024 10:51:57 -0500 (EST)
Date: Wed, 21 Feb 2024 10:51:57 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: x86@kernel.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3] x86/coco: Require seeding RNG with RDRAND on CoCo
 systems
Message-ID: <20240221155157.GB594407@mit.edu>
References: <20240221123248.25570-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240221123248.25570-1-Jason@zx2c4.com>

On Wed, Feb 21, 2024 at 01:32:40PM +0100, Jason A. Donenfeld wrote:
> There are few uses of CoCo that don't rely on working cryptography and
> hence a working RNG. Unfortunately, the CoCo threat model means that the
> VM host cannot be trusted and may actively work against guests to
> extract secrets or manipulate computation. Since a malicious host can
> modify or observe nearly all inputs to guests, the only remaining source
> of entropy for CoCo guests is RDRAND.
> 
> If RDRAND is broken -- due to CPU hardware fault -- the RNG as a whole
> is meant to gracefully continue on gathering entropy from other sources,
> but since there aren't other sources on CoCo, this is catastrophic.
> This is mostly a concern at boot time when initially seeding the RNG, as
> after that the consequences of a broken RDRAND are much more
> theoretical.
> 
> So, try at boot to seed the RNG using 256 bits of RDRAND output. If this
> fails, panic(). This will also trigger if the system is booted without
> RDRAND, as RDRAND is essential for a safe CoCo boot.
> 
> This patch is deliberately written to be "just a CoCo x86 driver
> feature" and not part of the RNG itself. Many device drivers and
> platforms have some desire to contribute something to the RNG, and
> add_device_randomness() is specifically meant for this purpose. Any
> driver can call this with seed data of any quality, or even garbage
> quality, and it can only possibly make the quality of the RNG better or
> have no effect, but can never make it worse. Rather than trying to
> build something into the core of the RNG, this patch interprets the
> particular CoCo issue as just a CoCo issue, and therefore separates this
> all out into driver (well, arch/platform) code.
> 
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Daniel P. Berrangé <berrange@redhat.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Elena Reshetova <elena.reshetova@intel.com>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

Reviewed-by: Theodore Ts'o <tytso@mit.edu>

						- Ted

