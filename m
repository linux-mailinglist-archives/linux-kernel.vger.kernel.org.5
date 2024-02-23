Return-Path: <linux-kernel+bounces-79076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6B4861D46
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1D9F1C23585
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAAA1146E6C;
	Fri, 23 Feb 2024 20:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="s5VlEGkR"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922E01448F8
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 20:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708718751; cv=none; b=Imgfyi3k/ZlbKwFlfHD7yDaH5QajREunzS4Fn7aEFii1AyZmNcx6Ju/pXR6trtjCw19fcgOiSYM613raK0ylBEl4KqGSljp7PKbpTgiNJxCm3rZc1fxUmWTbPlTky0fT9BwdPsbo45mtSxyHtHrd82gmjTyo4/Yh9Vt65lVrOmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708718751; c=relaxed/simple;
	bh=c93H0T4Zb2kqV8VXSrK+QwhYIgK7q9e3GVpJjBwlDPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h/2X08Nxh3TRW67VtNUMim+0rkHCZOa30xEouZlbiym4XUIiZxjS+hxYR4X5i4xwxquKVQ3q7+e3RJ4AcRz4Sw2mIku7jlm7ROznC2fpKyKtqTYD6v7lsfrL8Zuo3y3KUbufhNlLqLDlVTo0AyckN/mlfBXrAOSomrEhQwZ1PEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=s5VlEGkR; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e332bc65b3so770640b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 12:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1708718749; x=1709323549; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=77MYyBjrrun3U8EBRolVJQ+jLb+xOKAgdqcuRAFvrrQ=;
        b=s5VlEGkRy62fS5jPKo7jImCWldlFM7HGNErXd+RSWVzSfUYFWhLt0RSTzSk2sIWxPV
         FRj3aRnoDIja1NOryhm6YkAuQZwNY74a06qiK8tF9yFC0LYtlsnH4YnY6Njme2d87xNw
         QlVTvPgq4sae3FRIDi1tTQEe1PDgr/0Pq7WEFafuct5yb11wDFSZp079QDdhokLQD3Oc
         xlPp4tYBKp7mBfYHi0pIqOHNCn0z+gEMDifJF52UksaQYf/f94uVDBBvCcmgljwAXdsv
         W/GO6uaGHTNsHBwm0VuHmTNJlCnUkDXEp5pomWMSFw+OoDBSmtnN/DWR5yhfl7hM0ggh
         ihfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708718749; x=1709323549;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=77MYyBjrrun3U8EBRolVJQ+jLb+xOKAgdqcuRAFvrrQ=;
        b=L7TaJxskI2JfsE98smjOEkIa3f5OKpJe92M0qotK1Ze/RP748LXdUXONdZKOeNt7g9
         EBnTYIySU40ABHLocgwVq2KfmNnXZU3lOgVrCy6XDEagfHpv2BQh73YOxxndS4fReMPq
         h/fjshuEIDBbyYyleK7iWf972C2YESJdiOa4UuBq6APvTMYfH5fuXpFbBWmlPZX0SJER
         KPpXUyravnA7GH5N19bdiswxPbhB0w1XWJADNPTI2QHxUqIpRHdYk12ui4NVQvLpp8zs
         CN4P/HXDQdGtq6ZwVzLkzlLP5tcfY83NvEt0JpUo4UOks+lUWoiuy4RqM7Ab1GpsiipB
         CVBg==
X-Forwarded-Encrypted: i=1; AJvYcCVIlO/0MPHnK/dDIR9ESO2/30DV01MCoCbr8kOZHn9WAtbWv/1gA/0J1hQ2CiMoISCPCAzrOB+ddXv8GKYc8pb5H6stLFk+sxgCnS62
X-Gm-Message-State: AOJu0YyEFxB2JRFuZRdmcnNu9Xew0cQlv4miEL9cy4KCi5YstIvVJ/CM
	Ayp8U3AAOrIBSlhEYp5aYpqcmaTDk+W/RkBeqp6+rfUSt4MBdLnHMEjr7zv3nBc=
X-Google-Smtp-Source: AGHT+IEgmr0ZdwTYDwiLLCSnGGUBIxZ7Xut9Byi5mIRf8j8f1dL0+6Kee4jWo8g8/WX/ooPqwOMn1w==
X-Received: by 2002:a62:c186:0:b0:6e4:d0ed:d2b8 with SMTP id i128-20020a62c186000000b006e4d0edd2b8mr693710pfg.16.1708718748675;
        Fri, 23 Feb 2024 12:05:48 -0800 (PST)
Received: from ghost ([50.213.54.97])
        by smtp.gmail.com with ESMTPSA id a18-20020a056a000c9200b006e48e64ef54sm6019116pfv.173.2024.02.23.12.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 12:05:48 -0800 (PST)
Date: Fri, 23 Feb 2024 12:05:45 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Guenter Roeck <linux@roeck-us.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Erhard Furtner <erhard_f@mailbox.org>
Subject: Re: [PATCH net] kunit: Fix again checksum tests on big endian CPUs
Message-ID: <Zdj6mebHlbIq8u2o@ghost>
References: <73df3a9e95c2179119398ad1b4c84cdacbd8dfb6.1708684443.git.christophe.leroy@csgroup.eu>
 <Zdjcnp324nIRuyUI@ghost>
 <66402663-98dd-42a2-aa04-5f04cb76b147@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <66402663-98dd-42a2-aa04-5f04cb76b147@csgroup.eu>

On Fri, Feb 23, 2024 at 06:15:16PM +0000, Christophe Leroy wrote:
> 
> 
> Le 23/02/2024 à 18:57, Charlie Jenkins a écrit :
> > On Fri, Feb 23, 2024 at 11:41:52AM +0100, Christophe Leroy wrote:
> >> Commit b38460bc463c ("kunit: Fix checksum tests on big endian CPUs")
> >> fixed endianness issues with kunit checksum tests, but then
> >> commit 6f4c45cbcb00 ("kunit: Add tests for csum_ipv6_magic and
> >> ip_fast_csum") introduced new issues on big endian CPUs. Those issues
> >> are once again reflected by the warnings reported by sparse.
> >>
> >> So, fix them with the same approach, perform proper conversion in
> >> order to support both little and big endian CPUs. Once the conversions
> >> are properly done and the right types used, the sparse warnings are
> >> cleared as well.
> >>
> >> Reported-by: Erhard Furtner <erhard_f@mailbox.org>
> >> Fixes: 6f4c45cbcb00 ("kunit: Add tests for csum_ipv6_magic and ip_fast_csum")
> >> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> >> ---
> >>   lib/checksum_kunit.c | 17 +++++++++--------
> >>   1 file changed, 9 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/lib/checksum_kunit.c b/lib/checksum_kunit.c
> >> index 225bb7701460..bf70850035c7 100644
> >> --- a/lib/checksum_kunit.c
> >> +++ b/lib/checksum_kunit.c
> >> @@ -215,7 +215,7 @@ static const u32 init_sums_no_overflow[] = {
> >>   	0xffff0000, 0xfffffffb,
> >>   };
> >>   
> >> -static const __sum16 expected_csum_ipv6_magic[] = {
> >> +static const u16 expected_csum_ipv6_magic[] = {
> >>   	0x18d4, 0x3085, 0x2e4b, 0xd9f4, 0xbdc8, 0x78f,	0x1034, 0x8422, 0x6fc0,
> >>   	0xd2f6, 0xbeb5, 0x9d3,	0x7e2a, 0x312e, 0x778e, 0xc1bb, 0x7cf2, 0x9d1e,
> >>   	0xca21, 0xf3ff, 0x7569, 0xb02e, 0xca86, 0x7e76, 0x4539, 0x45e3, 0xf28d,
> >> @@ -241,7 +241,7 @@ static const __sum16 expected_csum_ipv6_magic[] = {
> >>   	0x3845, 0x1014
> >>   };
> >>   
> >> -static const __sum16 expected_fast_csum[] = {
> >> +static const u16 expected_fast_csum[] = {
> >>   	0xda83, 0x45da, 0x4f46, 0x4e4f, 0x34e,	0xe902, 0xa5e9, 0x87a5, 0x7187,
> >>   	0x5671, 0xf556, 0x6df5, 0x816d, 0x8f81, 0xbb8f, 0xfbba, 0x5afb, 0xbe5a,
> >>   	0xedbe, 0xabee, 0x6aac, 0xe6b,	0xea0d, 0x67ea, 0x7e68, 0x8a7e, 0x6f8a,
> >> @@ -577,7 +577,8 @@ static void test_csum_no_carry_inputs(struct kunit *test)
> >>   
> >>   static void test_ip_fast_csum(struct kunit *test)
> >>   {
> >> -	__sum16 csum_result, expected;
> >> +	__sum16 csum_result;
> >> +	u16 expected;
> >>   
> >>   	for (int len = IPv4_MIN_WORDS; len < IPv4_MAX_WORDS; len++) {
> >>   		for (int index = 0; index < NUM_IP_FAST_CSUM_TESTS; index++) {
> >> @@ -586,7 +587,7 @@ static void test_ip_fast_csum(struct kunit *test)
> >>   				expected_fast_csum[(len - IPv4_MIN_WORDS) *
> >>   						   NUM_IP_FAST_CSUM_TESTS +
> >>   						   index];
> >> -			CHECK_EQ(expected, csum_result);
> >> +			CHECK_EQ(to_sum16(expected), csum_result);
> >>   		}
> >>   	}
> >>   }
> >> @@ -598,7 +599,7 @@ static void test_csum_ipv6_magic(struct kunit *test)
> >>   	const struct in6_addr *daddr;
> >>   	unsigned int len;
> >>   	unsigned char proto;
> >> -	unsigned int csum;
> >> +	__wsum csum;
> >>   
> >>   	const int daddr_offset = sizeof(struct in6_addr);
> >>   	const int len_offset = sizeof(struct in6_addr) + sizeof(struct in6_addr);
> >> @@ -611,10 +612,10 @@ static void test_csum_ipv6_magic(struct kunit *test)
> >>   		saddr = (const struct in6_addr *)(random_buf + i);
> >>   		daddr = (const struct in6_addr *)(random_buf + i +
> >>   						  daddr_offset);
> >> -		len = *(unsigned int *)(random_buf + i + len_offset);
> >> +		len = le32_to_cpu(*(__le32 *)(random_buf + i + len_offset));
> >>   		proto = *(random_buf + i + proto_offset);
> >> -		csum = *(unsigned int *)(random_buf + i + csum_offset);
> >> -		CHECK_EQ(expected_csum_ipv6_magic[i],
> >> +		csum = *(__wsum *)(random_buf + i + csum_offset);
> >> +		CHECK_EQ(to_sum16(expected_csum_ipv6_magic[i]),
> >>   			 csum_ipv6_magic(saddr, daddr, len, proto, csum));
> >>   	}
> >>   #endif /* !CONFIG_NET */
> >> -- 
> >> 2.43.0
> >>
> > 
> > There is no need to duplicate efforts here. This has already been
> > resolved by
> > https://lore.kernel.org/lkml/20240221-fix_sparse_errors_checksum_tests-v9-2-bff4d73ab9d1@rivosinc.com/.
> > 
> 
> The idea here is to provide a fix which is similar to the one done 
> previously and that uses the same approach and reuses the same helpers.
> 
> This is to keep the code homogeneous.
> 
> Christophe

htons makes more sense here since this is networking code, but I don't
care enough to argue the point. I tested it on big endian SPARC and on
riscv. I'll base my alignment patch on this.

Tested-by: Charlie Jenkins <charlie@rivosinc.com>


