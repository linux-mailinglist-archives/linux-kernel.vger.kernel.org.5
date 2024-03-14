Return-Path: <linux-kernel+bounces-103162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 971B087BBC5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 12:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 373101F23188
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 11:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13AB86EB59;
	Thu, 14 Mar 2024 11:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="e8hcjDqj"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16DB2A1D1;
	Thu, 14 Mar 2024 11:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710414882; cv=none; b=PlU1fUegPZRLcKy1n9aKXSarnZ8cTNmHO0as3g5bRWHvsqWUBm0yuws9ZoGQdtbCixvQaFptEFp4XXvXM8F5n72qdjvXRjRr+MRwCkXt0ZUUVd7G+jNiT0j3erjKm2t5+2RZ68hkHeTeBlFyl1Rz4bHV3cbYFTMUmVoIFdG7T3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710414882; c=relaxed/simple;
	bh=JYThXvFfSUt8bn/u7QVtG0aC+rU3gXJs6BreV0Jsjis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=drQcQdWmvVHqXB74vVfL6Wfy7V8RuDfXmIvWyllW/sLm6WvYaUKBBp467/mApj+d+jWN0yAPS2lTAc+eCsCsGYNQTdnF2ADdy1OO+sSFZ9wbQGgJEUyPODdCpOimNZEknJu2zxWk5ESZOtn0/zLA68fMo6NuZhV+5c8YPBgD6p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=e8hcjDqj; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3746240E0028;
	Thu, 14 Mar 2024 11:14:36 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id cDZD0dZP4nXi; Thu, 14 Mar 2024 11:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1710414873; bh=W6YiMJ4KVuTlhdWm5TtH44BSuR5hnaHMB6oOqeEuhNE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e8hcjDqjGJgU6UnJ56h1yfC0EpbT8zm/zqKVR5mgJF83np8lgdA42pCp+Rp0gg3nD
	 psadm7lJ8SSeBBFwcrsIco+XfdjQ1J5O/LUaH8Toh4qlyqHLNOvXpZbPhLAqHHMBXu
	 NquAaQbSzuC1TEMBgisSrSibPd2fCaJngqRnKMF8say/HsDtCDiCcET7gJ4ofo4IeG
	 RfTPGUB4bk1btF6VLLWRDD4P//4o28rN/H3y2ZV92IkTsphUW/8FqzO0xva0qo/hPk
	 ypmyj6oKVDAld5rSdrtlaelQAiQacGmQI+LEqTTzngD1oIwsWK3GJHxglLY0n8HkoE
	 dsXZF76Qt3tqpohkOVZNHAz5Uhs9U10asL92OHCMRCQrordgw/A06TrS+X2l6gef5m
	 QBhY+RguKkCiZdDrXKF9VhYKAV5XdRANak8m4b/66/VTV0K97oZF5AxWl3lblCtxYV
	 4FjqjsVNEprPJSaUtksJ4DRxrsEy6zadNk9yVJt8lft4jNeFnmuExRZu9EfdU+NhM1
	 hcEO2FcK571AAyeXxd0xkskdpWvrosSXWTgScISYmysZSVpPXXPLy7AKSAcorcsQm5
	 xkEhQJzn0yKpdi+EFtfyADQW5BQmX+XQWpoNPwLqBri/eW3JdFaECGf3j02ABwfYCI
	 8oVjq9oc5M2EB5FPPnMRdqvU=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9729940E016B;
	Thu, 14 Mar 2024 11:14:19 +0000 (UTC)
Date: Thu, 14 Mar 2024 12:14:18 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: x86@kernel.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
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
Message-ID: <20240314111418.GBZfLcCskn7Xjra4mu@fat_crate.local>
References: <CAHmME9oN+7rbLYcvQN=+KMjwrokvARy_7khLWJvDK=K_S5uHqg@mail.gmail.com>
 <20240224011921.2663985-1-Jason@zx2c4.com>
 <ZfI366mQplePkvHv@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZfI366mQplePkvHv@zx2c4.com>

Hi Jason,

On Thu, Mar 14, 2024 at 12:34:03AM +0100, Jason A. Donenfeld wrote:
> This has been sitting on the list for a while with a few positive
> reviews and no outstanding objections, afaict. Can you merge this to
> tip?

the tip tree is open for new code after the merge window is over.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

