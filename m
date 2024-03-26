Return-Path: <linux-kernel+bounces-118873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F29788C085
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7428B216A6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86485548E5;
	Tue, 26 Mar 2024 11:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="c3YBRnf2"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D3C52F67;
	Tue, 26 Mar 2024 11:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711452125; cv=none; b=GiPfjwU5E018Eu0CilLyI1Vlp6dzJA6hZiwRWVpAFsyMbmVJ5O+xTi71A3WYx48Amz+UA0+U0zAX0zv3/AeH3eWEpSdkSTFrgHXfJbQgDsRMuwpg6mC6O/OS59kpjcwFugcJDDc8C9ZyXGekczWDCqfJwsy49wKJ2R01wPTq7co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711452125; c=relaxed/simple;
	bh=Ga+xwbpBO/hlGb01zxGPxIvFBmt8yPbMcDjpoO97q3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RFflxrW0uoUdlfxm2Y6Fone1zkKEuKHJNniYtNxMIzbcOyXMAgk3oBZcgExsKK2uU6RewHDvXfvoX8UVLllYsjlL+fg//6XWFQTLZKkc5IOIUmlTYoW9uYLD4bx1XheS1LjmILieLazuJ0abCOdTdZfMyOliyudQ/caVF8a7hZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=c3YBRnf2 reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 88B8240E024C;
	Tue, 26 Mar 2024 11:22:01 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id xqH6euSnifRy; Tue, 26 Mar 2024 11:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1711452116; bh=5xySxgxUex7yGo/N3CjIUaOQ92oGCY0B9c5aUdVDJHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c3YBRnf2JupbhmiWyx3+d7vnRmROs10DZoQ+00EoYLMSAZhZhoPfdydM9S8QMOO/T
	 Cn6d2qmXnIoYZiHiAVBZuCUhngqF/1Bup3PsSLiNuvNoVxbZM6zjdHw+vDM8+iueuD
	 aXfragH1pM6MyY3kiJYACfWxgzbenIp1Ifl4pkRO35KdIQ7SAdPGUV49Skb9QKAwIR
	 kwCLSN0yr3jYdsmF+gLgtT1UTRUCMaOkwzg0selKbaLBlbAs8e2iFZ2hTqBYCl3C52
	 StTZq7gUnHjtVfRTOkIxtuBQYeLY7hE3i0wbV9/CqgEF2PgGCqKQuyjLgRYpfoPrpU
	 OaxaRqEeFZPZX0axI1SqptsS3K7pJ4ftGdGjHJwHWp37WcEhR/8bRl0cZI6HzVH4V7
	 dTryPnhHdJILUk6BrQmnePC0OaVjEBH3ao+Vf4Qp0p4//xko6PoFG7s57vTNVXDuIG
	 DT3zbb9Iin0K3cz6vD4KHnldUpvaDmMYLcGOFrRSz+SN+9KRh24SrgMCUXMVJrDczn
	 vZRG2JouUOtxUzPIP4DxrGu8kj/IuFbvVlEz/nrTQOz8w4iOc6hk/2Wz9WycEg6g8f
	 V+Oyk7OQt4zaum9UFJg41HowMRyM9GzzMfkTLZlS0Su2PlzzOgfB3mqBWqa9Ikr/xb
	 CvqaUFRHJsmKINNES/a1x4ZU=
Received: from zn.tnic (p5de8ecf7.dip0.t-ipconnect.de [93.232.236.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7966F40E00B2;
	Tue, 26 Mar 2024 11:21:42 +0000 (UTC)
Date: Tue, 26 Mar 2024 12:21:37 +0100
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
Message-ID: <20240326112137.GDZgKvwRHD4yQs3Zm-@fat_crate.local>
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
In-Reply-To: <20240224011921.2663985-1-Jason@zx2c4.com>
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 24, 2024 at 02:18:56AM +0100, Jason A. Donenfeld wrote:
> +__init void cc_random_init(void)
> +{
> +	/*
> +	 * The seed is 32 bytes (in units of longs), which is 256 bits, which
> +	 * is the security level that the RNG is targeting.
> +	 */
> +	unsigned long rng_seed[32 / sizeof(long)];
> +	size_t i, longs;
> +
> +	if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
> +		return;
> +
> +	/*
> +	 * Since the CoCo threat model includes the host, the only reliable
> +	 * source of entropy that can be neither observed nor manipulated is
> +	 * RDRAND. Usually, RDRAND failure is considered tolerable, but since
> +	 * CoCo guests have no other unobservable source of entropy, it's
> +	 * important to at least ensure the RNG gets some initial random seed=
s.
> +	 */
> +	for (i =3D 0; i < ARRAY_SIZE(rng_seed); i +=3D longs) {
> +		longs =3D arch_get_random_longs(&rng_seed[i], ARRAY_SIZE(rng_seed) -=
 i);
> +
> +		/*
> +		 * A zero return value means that the guest doesn't have RDRAND
> +		 * or the CPU is physically broken, and in both cases that
> +		 * means most crypto inside of the CoCo instance will be
> +		 * broken, defeating the purpose of CoCo in the first place. So
> +		 * just panic here because it's absolutely unsafe to continue
> +		 * executing.
> +		 */
> +		if (longs =3D=3D 0)
> +			panic("RDRAND is defective.");
> +	}
> +	add_device_randomness(rng_seed, sizeof(rng_seed));
> +	memzero_explicit(rng_seed, sizeof(rng_seed));

Please redo your patch ontop of latest tip/master:

arch/x86/coco/core.c: In function =E2=80=98cc_random_init=E2=80=99:
arch/x86/coco/core.c:189:9: error: implicit declaration of function =E2=80=
=98memzero_explicit=E2=80=99 [-Werror=3Dimplicit-function-declaration]
  189 |         memzero_explicit(rng_seed, sizeof(rng_seed));
      |         ^~~~~~~~~~~~~~~~
cc1: some warnings being treated as errors
make[4]: *** [scripts/Makefile.build:244: arch/x86/coco/core.o] Error 1
make[3]: *** [scripts/Makefile.build:485: arch/x86/coco] Error 2
make[3]: *** Waiting for unfinished jobs....
make[2]: *** [scripts/Makefile.build:485: arch/x86] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/mnt/kernel/kernel/2nd/linux/Makefile:1919: .] Error 2
make: *** [Makefile:240: __sub-make] Error 2

Thx.

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

