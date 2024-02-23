Return-Path: <linux-kernel+bounces-77866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A29860B47
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 08:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A5DD2867F6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 07:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D4413AED;
	Fri, 23 Feb 2024 07:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="X2HGfkaz"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F79812B6C;
	Fri, 23 Feb 2024 07:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708672964; cv=none; b=JVFP4BgAKWXv6wMDg5xWBkTqtHBS1ukj4SGxzx+Ew3zt1GpikwP2Kzb8PFcJ4ZofABaZQNk6NnYvTDtPbykVHun12PcWAAfaz9ASFzQIwKcIDeduqbgFju1v+EPo3OkLE9F7orbMhNAbqlazs9HZ3JekVnY6SoK79APpEqQqK6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708672964; c=relaxed/simple;
	bh=vwp4GjlNciDL6nP4uzwnqF2x8bx41g9ZfCJR6fssjoY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YSL2qm06FadM0tY1bEudnk4EqJPQzP3/ehxUlJeLtFJFMgdI+W23s7QYCTHXtP3FleRTsIxzA9YPOQCi575jVkgr51pQ0uGVKGyX4tQwoKbTEpHIBniInx/orZs6kSlcWDVupxoniTjh+vN1oRiX/wu77fZh4YJvZpF2pT3coas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=X2HGfkaz; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1708672957;
	bh=0jxjJo5a/nwAFGvAgFnEwUXk3S6zyyTCzIeeGMVoVrs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=X2HGfkazDb9ote7U1IMTw0PoXzCfd+bHiDSW6cNhQ43KoHF/ESiATMFxZBeigjFJo
	 TuZtwXLvk5+0OS56hhbNZe7hx4Bdi1328+ftD46264nAFD/NSDJ+8CKdnklufKrbmD
	 omeaBN4KsyyqWj65xrrXKvG48HMv/yTDSrpxO1/s4cuG368/F+GQFmL8ktmS7VAj4g
	 /dQE6RvdU4wcNk+DiUhRX5+4G+rdXBVBhb0neS7jThUhc2GB/8eUiCESAmTqVf1p3q
	 38giU/oGyQFpGO9NrcNbojcTwNaOLPF38R9d+UBOwK6+z+AYgPxQGHh2OnqkazUP7r
	 XaN4ZG2jrtokw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Th1gB3LCbz4wcR;
	Fri, 23 Feb 2024 18:22:30 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Palmer Dabbelt <palmer@dabbelt.com>, Charlie Jenkins <charlie@rivosinc.com>
Cc: linux@roeck-us.net, David.Laight@aculab.com, akpm@linux-foundation.org,
 deller@gmx.de, James.Bottomley@hansenpartnership.com,
 linux-parisc@vger.kernel.org, viro@zeniv.linux.org.uk,
 linux-kernel@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>,
 lkp@intel.com
Subject: Re: [PATCH v9 0/2] lib: checksum: Fix issues with checksum tests
In-Reply-To: <mhng-7bd71679-7e7b-459d-8d6f-068a0ee090ba@palmer-ri-x1c9a>
References: <mhng-7bd71679-7e7b-459d-8d6f-068a0ee090ba@palmer-ri-x1c9a>
Date: Fri, 23 Feb 2024 18:22:30 +1100
Message-ID: <87plwnabm1.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Palmer Dabbelt <palmer@dabbelt.com> writes:
> On Wed, 21 Feb 2024 18:55:48 PST (-0800), Charlie Jenkins wrote:
>> The ip_fast_csum and csum_ipv6_magic tests did not work on all
>> architectures due to differences in endianness and misaligned access
>> support. Fix those issues by changing endianness of data and aligning
>> the data.
>>
>> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
>> ---
>> Changes in v9:
>> - Revert back to v7, the changes to v8 were not needed
>> - Link to v8: https://lore.kernel.org/r/20240214-fix_sparse_errors_checksum_tests-v8-0-36b60e673593@rivosinc.com
..
>>
>> ---
>> Charlie Jenkins (2):
>>       lib: checksum: Fix type casting in checksum kunits
>>       lib: checksum: Use aligned accesses for ip_fast_csum and csum_ipv6_magic tests
>>
>>  lib/checksum_kunit.c | 396 ++++++++++++++++++---------------------------------
>>  1 file changed, 136 insertions(+), 260 deletions(-)
>> ---
>> base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
>> change-id: 20240119-fix_sparse_errors_checksum_tests-26b86b34d784
>
> I put a 
>
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
>
> on the v4, but looks like it got lost.  I'm happy to take this via the 
> RISC-V tree, as that's how I merged the broken patches in the first 
> place, but no big deal if someone else wants to pick it up.
>
> It looks like the issues are all resolved and such, but there's been a 
> long tail of them so I'm not 100% sure here...

I tested v9 on ppc32/64 BE, and it fixes the test failures and the
sparse errors, so LGTM.

Tested-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers

