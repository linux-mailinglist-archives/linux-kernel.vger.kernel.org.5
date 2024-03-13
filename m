Return-Path: <linux-kernel+bounces-102642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 267B687B536
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 00:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 597821C21804
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 23:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F0C5D73A;
	Wed, 13 Mar 2024 23:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="MMtq5M5M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFF25EE64;
	Wed, 13 Mar 2024 23:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710372848; cv=none; b=S5iLXgZ1xmptVwMA6i5sUwDI4TLWoPf3hzSki45IMZ7+NNGdVbK2SwUMDZgmSDjFq2+9p4kBFwL4TlDZubTOhOM434Dcshgcdf358TKIt3U+JQ21H4eDRaRUy5PIsY7yspMDDgIvdAt3zR+UiTsLuve2lAWH1Y66OGntCNj2QHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710372848; c=relaxed/simple;
	bh=whkIXUwacmK25UpsXAzYc6urI2QdGo2r/V3+fH0Eoxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dWXsEMbxMJK4qWzMAG9GssDHb7eNOfI/8bdFwdmfQW2pBjo9R4KJOirnckPiJeB1HhHlucZCHBH1zZdUz8oHO19T9pyxXqE5SGVnhmHkilY/oasHwy1Il/kVB1T4Nk/aVur2BNjsQeLgtnHMAcJIJy+GiBzD6ByKSyfCn20uLao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=MMtq5M5M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53F86C433C7;
	Wed, 13 Mar 2024 23:34:06 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="MMtq5M5M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1710372844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p3zmeXxzdCToZqnWjGmQGSAP39p4sNEysp0MFtFKYJM=;
	b=MMtq5M5MQcos/Ph8psXzmSyXjTuUQ/ubznxBpoI2RhOlajKhs39s8O+ntSa6Q20xd7UVKZ
	5DRGlUxFw+rTlqzXUtni5BbBDWqvtaJkFfLyQarKQ8OYpPtZNLzJ1sSW1b1cWwareRuAi1
	DRMEYR3P7NSr51tsYEZ3ATK8PMKciB0=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 6a922124 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 13 Mar 2024 23:34:04 +0000 (UTC)
Date: Thu, 14 Mar 2024 00:34:03 +0100
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: x86@kernel.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Borislav Petkov <bp@alien8.de>,
	Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tom Lendacky <thomas.lendacky@amd.com>, stable@vger.kernel.org,
	Elena Reshetova <elena.reshetova@intel.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v5] x86/coco: Require seeding RNG with RDRAND on CoCo
 systems
Message-ID: <ZfI366mQplePkvHv@zx2c4.com>
References: <CAHmME9oN+7rbLYcvQN=+KMjwrokvARy_7khLWJvDK=K_S5uHqg@mail.gmail.com>
 <20240224011921.2663985-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240224011921.2663985-1-Jason@zx2c4.com>

Hi Borislav,

On Sat, Feb 24, 2024 at 02:18:56AM +0100, Jason A. Donenfeld wrote:
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
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: stable@vger.kernel.org
> Reviewed-by: Elena Reshetova <elena.reshetova@intel.com>
> Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Theodore Ts'o <tytso@mit.edu>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

This has been sitting on the list for a while with a few positive
reviews and no outstanding objections, afaict. Can you merge this to
tip?

Thanks,
Jason

