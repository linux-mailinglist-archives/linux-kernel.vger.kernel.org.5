Return-Path: <linux-kernel+bounces-78877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3B6861A03
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45CE31C253AC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F651339B0;
	Fri, 23 Feb 2024 17:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="qScQXBs5"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867751E89B
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 17:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708709743; cv=none; b=uvoqqrQ27hVA3aecRbNPgDJKHhkkM7LwW4EoWkDf8dawtd3qZufTeP/61P/gBHfo56Kio5yiW8YRVTZS26RLfwHSQTzZ58qyj8Sel4v45mS9qa03snIhhyD7UFtdyYdRkz03TK/VCe4+HJm9+hXhppJb3Gaea/q/+NDbB+C90xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708709743; c=relaxed/simple;
	bh=uP196vhNcAl/lNIHrFt6S43MIT/4vtIwLl32+2wSd5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lrYDiDcH+yGZ6MdSIJMN2JtRsNnI9/vCv9gCRd6DBXnudOvfdyLmpQdHN5aos7lPpYmzBb66YfZXugGANTtTy5rUtlvD6HUOkU5v3IJjBmhbXpY76xI0JmQ7GUEzwdWrhuCV0yW7tqwF4TjZw7onR5c063Ril01DFztl0KasaTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=qScQXBs5; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e48eef8be5so803095b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 09:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1708709740; x=1709314540; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TALnjDZ5EDzF1r03NOUytXvsy5VPlkVBfZq9r4Y1MmM=;
        b=qScQXBs519jypteznjP+yTX/RS3nPUV9V7LFc6EAqN8/mQIpCCuBnehXY3RteI5LWu
         vNuwEPwYqw+E3H6RVq3uPo4j0lV6iqZY2gtzFosOvH4QjX+eMqZ8h2QTTMidls96XkyB
         kx1vd5cWgieeD+q+SZSlR0kASDkG0owR+/1C/1aUjAA/TOcE/v0xMcWxYrsYimp6+mHT
         ydTrkT2yDsbfsfsdSWm9OTha/FZ2+PpZkeqReSBEPVABgloV+ObwUhci0UOAoOe8Yn+q
         4alGIzax+vds4VQKrgJs0CIEUyDvAygX+EjsT8SauweFLWk7YWtGtyC8bSwY14OeZq84
         E8EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708709740; x=1709314540;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TALnjDZ5EDzF1r03NOUytXvsy5VPlkVBfZq9r4Y1MmM=;
        b=v0Y3/BARCocBZiFNRI8jljddIb76ja80RK0roEzx84k8wBYHqhcG4o2intLXBCtEet
         onUyY1qxPCtN6cxLDqgi9OvTHtK3omVyHiWhvgX02izNsTJrOf8bE3Qg0UEUYLlMY8vI
         S2flF8kmOrakzZVg1BJOcXOUimh1aPSBKe0znycO8LSeM/37wnbZnBFLFsbyXASMmXd7
         ZjA0GNsZUQOB/UI703PinlbIa1QHSuYjk3F05fCPCgDYLeV653MWfm6zFaYqyJJBRsvJ
         RWRzqr8yRW55wo6gEIonGOImu93WKcrfmk/MUNDc/gpa7vmXxhSFIIUBHR13OpONIwo6
         YIDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoZ6XRvpXLEGWAjWN6wzLx2lW8oKn6ZamuYRTWizjCv+2Hp3sZSS6aCj2/DEKTff0UGwqyIooNcZ218FC5BXSC3XDMLoI/y79scQ5m
X-Gm-Message-State: AOJu0YyRBGbcJTBG+pUxKzwRVCYoh8VFfL9+hrpA1BZDVimJxbmWbk2r
	PZ21/Nm9nOnhWXMn9EGWtlohKXrw/RDmxFJrYAPDySG1k+NysfMTCKo/bWakEzydkj6God/OXBE
	n9nc=
X-Google-Smtp-Source: AGHT+IG2NUpChUqHFDo+6qytjnOzmiC/aIOk+8cwdfaAm9BENlvzXbtxorpixDlr754ZsSfWzxNrDw==
X-Received: by 2002:a05:6a20:b715:b0:1a0:e5af:b240 with SMTP id fg21-20020a056a20b71500b001a0e5afb240mr430800pzb.45.1708709739814;
        Fri, 23 Feb 2024 09:35:39 -0800 (PST)
Received: from ghost ([2601:647:5700:6860:a351:1ab0:98d6:3d53])
        by smtp.gmail.com with ESMTPSA id nb12-20020a17090b35cc00b00296fd5e0de1sm1771118pjb.34.2024.02.23.09.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 09:35:39 -0800 (PST)
Date: Fri, 23 Feb 2024 09:35:37 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Erhard Furtner <erhard_f@mailbox.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: "test_ip_fast_csum: ASSERTION FAILED at
 lib/checksum_kunit.c:589" at boot with CONFIG_CHECKSUM_KUNIT=y enabled on a
 Talos II, kernel 6.8-rc5
Message-ID: <ZdjXaUit6r7uvq3N@ghost>
References: <20240223022654.625bef62@yea>
 <528c6abf-e5ef-42cd-a5d7-6ede3254523d@csgroup.eu>
 <Zdg3X4A1eJsJ+ACh@ghost>
 <6c37ffa2-8642-46c0-89ba-1f1e29b094d9@csgroup.eu>
 <ZdhCnoRu3i1Cnwks@ghost>
 <b2a7b678-fc59-4d12-acc3-696866cfd7c2@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b2a7b678-fc59-4d12-acc3-696866cfd7c2@csgroup.eu>

On Fri, Feb 23, 2024 at 09:06:56AM +0000, Christophe Leroy wrote:
> 
> 
> Le 23/02/2024 à 08:00, Charlie Jenkins a écrit :
> > On Fri, Feb 23, 2024 at 06:58:14AM +0000, Christophe Leroy wrote:
> >>
> >>
> >> Le 23/02/2024 à 07:12, Charlie Jenkins a écrit :
> >>> On Fri, Feb 23, 2024 at 05:59:07AM +0000, Christophe Leroy wrote:
> >>>> Hi Erhard, hi Charlie,
> >>>>
> >>>> Le 23/02/2024 à 02:26, Erhard Furtner a écrit :
> >>>>> Greetings!
> >>>>>
> >>>>> Looks like my Talos II (running a BE kernel+system) fails some of the kernels internal unit tests. One of the failing tests is checksum_kunit, enabled via CONFIG_CHECKSUM_KUNIT=y:
> >>>>>
> >>>>> [...]
> >>>>>       KTAP version 1
> >>>>>        # Subtest: checksum
> >>>>>        # module: checksum_kunit
> >>>>>        1..5
> >>>>> entry-flush: disabled on command line.
> >>>>>        ok 1 test_csum_fixed_random_inputs
> >>>>>        ok 2 test_csum_all_carry_inputs
> >>>>>        ok 3 test_csum_no_carry_inputs
> >>>>>        # test_ip_fast_csum: ASSERTION FAILED at lib/checksum_kunit.c:589
> >>>>>        Expected ( u64)expected == ( u64)csum_result, but
> >>>>>            ( u64)expected == 55939 (0xda83)
> >>>>>            ( u64)csum_result == 33754 (0x83da)
> >>>>>        not ok 4 test_ip_fast_csum
> >>>>>        # test_csum_ipv6_magic: ASSERTION FAILED at lib/checksum_kunit.c:617
> >>>>>        Expected ( u64)expected_csum_ipv6_magic[i] == ( u64)csum_ipv6_magic(saddr, daddr, len, proto, csum), but
> >>>>>            ( u64)expected_csum_ipv6_magic[i] == 6356 (0x18d4)
> >>>>>            ( u64)csum_ipv6_magic(saddr, daddr, len, proto, csum) == 43586 (0xaa42)
> >>>>>        not ok 5 test_csum_ipv6_magic
> >>>>> # checksum: pass:3 fail:2 skip:0 total:5
> >>>>> # Totals: pass:3 fail:2 skip:0 total:5
> >>>>> not ok 4 checksum
> >>>>> [...]
> >>>>>
> >>>>> Full dmesg + kernel .config attached.
> >>>>
> >>>> Looks like the same problem as the one I fixed with commit b38460bc463c
> >>>> ("kunit: Fix checksum tests on big endian CPUs")
> >>>>
> >>>> The new tests implemented through commit 6f4c45cbcb00 ("kunit: Add tests
> >>>> for csum_ipv6_magic and ip_fast_csum") create a lot of type issues as
> >>>> reported by sparse when built with C=2 (see below).
> >>>>
> >>>> Once those issues are fixed, it should work.
> >>>>
> >>>> Charlie, can you provide a fix ?
> >>>>
> >>>> Thanks,
> >>>> Christophe
> >>>
> >>> The "lib: checksum: Fix issues with checksum tests" patch should fix all of these issues [1].
> >>>
> >>> [1] https://lore.kernel.org/all/20240221-fix_sparse_errors_checksum_tests-v9-1-bff4d73ab9d1@rivosinc.com/T/#m189783a9b2a7d12e3c34c4a412e65408658db2c9
> >>
> >> It doesn't fix the issues, I still get the following with your patch 1/2
> >> applied:
> >>
> >> [    6.893141] KTAP version 1
> >> [    6.896118] 1..1
> >> [    6.897764]     KTAP version 1
> >> [    6.900800]     # Subtest: checksum
> >> [    6.904518]     # module: checksum_kunit
> >> [    6.904601]     1..5
> >> [    7.139784]     ok 1 test_csum_fixed_random_inputs
> >> [    7.590056]     ok 2 test_csum_all_carry_inputs
> >> [    8.064415]     ok 3 test_csum_no_carry_inputs
> >> [    8.070065]     # test_ip_fast_csum: ASSERTION FAILED at
> >> lib/checksum_kunit.c:589
> >> [    8.070065]     Expected ( u64)expected == ( u64)csum_result, but
> >> [    8.070065]         ( u64)expected == 55939 (0xda83)
> >> [    8.070065]         ( u64)csum_result == 33754 (0x83da)
> >> [    8.075836]     not ok 4 test_ip_fast_csum
> >> [    8.101039]     # test_csum_ipv6_magic: ASSERTION FAILED at
> >> lib/checksum_kunit.c:617
> >> [    8.101039]     Expected ( u64)( __sum16)expected_csum_ipv6_magic[i]
> >> == ( u64)csum_ipv6_magic(saddr, daddr, len, proto, ( __wsum)csum), but
> >> [    8.101039]         ( u64)( __sum16)expected_csum_ipv6_magic[i] ==
> >> 6356 (0x18d4)
> >> [    8.101039]         ( u64)csum_ipv6_magic(saddr, daddr, len, proto, (
> >> __wsum)csum) == 43586 (0xaa42)
> >> [    8.106446]     not ok 5 test_csum_ipv6_magic
> >> [    8.143829] # checksum: pass:3 fail:2 skip:0 total:5
> >> [    8.148334] # Totals: pass:3 fail:2 skip:0 total:5
> >> [    8.153173] not ok 1 checksum
> >>
> >> All your patch does is to hide the sparse warnings. But forcing a cast
> >> doesn't fix byte orders.
> >>
> >> Please have a look at commit b38460bc463c ("kunit: Fix checksum tests on
> >> big endian CPUs"), there are helpers to put checksums in the correct
> >> byte order.
> >>
> >> Christophe
> > 
> > Well that's what the second patch is for. Is it failing with the second
> > patch applied?
> > 
> 
> Yes, with second patch is magically works, meaning the patch description 
> is not correct because the problem for powerpc it not at all related to 
> memory alignment but to endianness. And endianness should have been 
> fixed by patch 1, but instead of it, patch 1 just hides the problem by 
> forcing casts.
> 
> The real fix for endianness which should be your patch 1 is the 
> following change. With that change it works perfectly well without any 
> forced cast:

Saying without "any forced casted" is misleading. You are just hiding
the forced cast behind a function call. to_sum16 is defined as (__force
__sum16)le16_to_cpu((__force __le16)x) which does two forced casts.
Since this is networking code, htons makes more logical sense here and
it is the same result.

Sparse simply requires forced casts, as the networking types uses
restricted types. I can rearrange the patches so that the first patch is
not solely fixing the sparse forced casts and include the endianness
fixes from the second patch.

I see how the title of the second patch is confusing since it only says
alignment, but I included endianness in the description which I assumed
would sufficiently convey the point.

- Charlie

> 
> diff --git a/lib/checksum_kunit.c b/lib/checksum_kunit.c
> index 225bb7701460..bf70850035c7 100644
> --- a/lib/checksum_kunit.c
> +++ b/lib/checksum_kunit.c
> @@ -215,7 +215,7 @@ static const u32 init_sums_no_overflow[] = {
>   	0xffff0000, 0xfffffffb,
>   };
> 
> -static const __sum16 expected_csum_ipv6_magic[] = {
> +static const u16 expected_csum_ipv6_magic[] = {
>   	0x18d4, 0x3085, 0x2e4b, 0xd9f4, 0xbdc8, 0x78f,	0x1034, 0x8422, 0x6fc0,
>   	0xd2f6, 0xbeb5, 0x9d3,	0x7e2a, 0x312e, 0x778e, 0xc1bb, 0x7cf2, 0x9d1e,
>   	0xca21, 0xf3ff, 0x7569, 0xb02e, 0xca86, 0x7e76, 0x4539, 0x45e3, 0xf28d,
> @@ -241,7 +241,7 @@ static const __sum16 expected_csum_ipv6_magic[] = {
>   	0x3845, 0x1014
>   };
> 
> -static const __sum16 expected_fast_csum[] = {
> +static const u16 expected_fast_csum[] = {
>   	0xda83, 0x45da, 0x4f46, 0x4e4f, 0x34e,	0xe902, 0xa5e9, 0x87a5, 0x7187,
>   	0x5671, 0xf556, 0x6df5, 0x816d, 0x8f81, 0xbb8f, 0xfbba, 0x5afb, 0xbe5a,
>   	0xedbe, 0xabee, 0x6aac, 0xe6b,	0xea0d, 0x67ea, 0x7e68, 0x8a7e, 0x6f8a,
> @@ -577,7 +577,8 @@ static void test_csum_no_carry_inputs(struct kunit 
> *test)
> 
>   static void test_ip_fast_csum(struct kunit *test)
>   {
> -	__sum16 csum_result, expected;
> +	__sum16 csum_result;
> +	u16 expected;
> 
>   	for (int len = IPv4_MIN_WORDS; len < IPv4_MAX_WORDS; len++) {
>   		for (int index = 0; index < NUM_IP_FAST_CSUM_TESTS; index++) {
> @@ -586,7 +587,7 @@ static void test_ip_fast_csum(struct kunit *test)
>   				expected_fast_csum[(len - IPv4_MIN_WORDS) *
>   						   NUM_IP_FAST_CSUM_TESTS +
>   						   index];
> -			CHECK_EQ(expected, csum_result);
> +			CHECK_EQ(to_sum16(expected), csum_result);
>   		}
>   	}
>   }
> @@ -598,7 +599,7 @@ static void test_csum_ipv6_magic(struct kunit *test)
>   	const struct in6_addr *daddr;
>   	unsigned int len;
>   	unsigned char proto;
> -	unsigned int csum;
> +	__wsum csum;
> 
>   	const int daddr_offset = sizeof(struct in6_addr);
>   	const int len_offset = sizeof(struct in6_addr) + sizeof(struct in6_addr);
> @@ -611,10 +612,10 @@ static void test_csum_ipv6_magic(struct kunit *test)
>   		saddr = (const struct in6_addr *)(random_buf + i);
>   		daddr = (const struct in6_addr *)(random_buf + i +
>   						  daddr_offset);
> -		len = *(unsigned int *)(random_buf + i + len_offset);
> +		len = le32_to_cpu(*(__le32 *)(random_buf + i + len_offset));
>   		proto = *(random_buf + i + proto_offset);
> -		csum = *(unsigned int *)(random_buf + i + csum_offset);
> -		CHECK_EQ(expected_csum_ipv6_magic[i],
> +		csum = *(__wsum *)(random_buf + i + csum_offset);
> +		CHECK_EQ(to_sum16(expected_csum_ipv6_magic[i]),
>   			 csum_ipv6_magic(saddr, daddr, len, proto, csum));
>   	}
>   #endif /* !CONFIG_NET */
> ---
> 
> Christophe

