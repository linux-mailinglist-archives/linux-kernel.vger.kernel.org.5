Return-Path: <linux-kernel+bounces-61118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB7A850D88
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 07:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63FA81F25ECD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 06:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6589C6FD8;
	Mon, 12 Feb 2024 06:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="VyV8difg"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39775538D
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 06:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707719185; cv=none; b=JIfWu/1qQmIT1U6c4fhWbXxX+sWcCQI2rXREh1y7spOsC6Yi/G37UHQFKbmTNu30pdBACqNHqnYQl+y9qcddOcKiTNtU/sUBZZAy53qAQPebkUzHVaa7TJx72ywD2bMMUpSc3w9U2T4BNJJbMeCBvjH8z0FIpC6OSuc3Yd8vWAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707719185; c=relaxed/simple;
	bh=KuLc+F11ArVpFzno+5E4qlkep2uSTg7WemeMowm4Nyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PHDZhuOCD6EMh+C7opEWae0+Tm+FPclpjyEo6tCQZGA22fr9tcpVdF/fnSjnpkrJeBFwTsj9YrJZyiquO7+LkQcwnGggiW/nQMD/AeDb85wkbz4AC7u3D/AKQsGK87DfOvuUXXdZng3q6v2epHUd7qQEvCwgwuncxF6EKRnQyPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=VyV8difg; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wRL75x4XE4MFE8XmThFTmgQtY9HLmq9ojhS+mB9cHlI=; b=VyV8difgWT9YdsQl6BOmnco4yM
	s/eKiBP80J16FSJKTWAJ9Bob23SYqbTSQH43JjLG3iF6JOcfd+ZPUhlGO89bbIlIsWtiBmn2nlD5b
	yrNm04/neMiRx9jT49FRsivjW3aiN+Ha3jZYCPIFwDj7k5drKwiVlbLUIYKug0bR/MIkaKMiXLJQ6
	yNSzJBEVx2fvJNHLLHzzxdHGRxfxOLKXWvny6cEV2s/D9zMDXtHJYSA8ZNFkjLEIYCMHPPzwxiIkN
	+XyHKGZ2pyMVzyfwPwLzVYg+pNN3VyhD/a+O9q9BP9CjkVye/cZmLdslZRKGJsEVQRkAfD/G8s6pL
	BUB9JWQw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rZPle-006Vty-2y;
	Mon, 12 Feb 2024 06:26:15 +0000
Date: Mon, 12 Feb 2024 06:26:14 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Guenter Roeck <linux@roeck-us.net>,
	David Laight <David.Laight@aculab.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] lib: checksum: Use aligned accesses for
 ip_fast_csum and csum_ipv6_magic tests
Message-ID: <20240212062614.GI608142@ZenIV>
References: <20240207-fix_sparse_errors_checksum_tests-v6-0-4caa9629705b@rivosinc.com>
 <20240207-fix_sparse_errors_checksum_tests-v6-2-4caa9629705b@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207-fix_sparse_errors_checksum_tests-v6-2-4caa9629705b@rivosinc.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Feb 07, 2024 at 04:22:51PM -0800, Charlie Jenkins wrote:
> +	struct csum_ipv6_magic_data {
> +		const struct in6_addr saddr;
> +		const struct in6_addr daddr;
> +		unsigned int len;
> +		__wsum csum;
> +		unsigned char proto;
> +	} data, *data_ptr;

Huh?

> +	int num_tests = MAX_LEN / WORD_ALIGNMENT - sizeof(struct csum_ipv6_magic_data);
> +
> +	for (int i = 0; i < num_tests; i++) {
> +		data_ptr = (struct csum_ipv6_magic_data *)(random_buf + (i * WORD_ALIGNMENT));
> +
> +		cpu_to_be32_array((__be32 *)&data.saddr, (const u32 *)&data_ptr->saddr,
> +				  sizeof_field(struct csum_ipv6_magic_data, saddr) / 4);
> +		cpu_to_be32_array((__be32 *)&data.daddr, (const u32 *)&data_ptr->daddr,
> +				  sizeof_field(struct csum_ipv6_magic_data, daddr) / 4);
> +		data.len = data_ptr->len;
> +		data.csum = (__force __wsum)htonl((__force u32)data_ptr->csum);

What are those cpu_to_be32() about?  Checksum calculations *DO* *NOT* involve
any endianness conversions.  At any point.

Replace those assignments with memcpy() and be done with that - that will take
care of unaligned accesses.

Result will have host-independent memory representation.  The only place where you
might want to play with byteswaps (only 16-bit ones) is if you initialized the
array of expected results with u16 constants.  That will have opposite memory
representations on l-e and b-e, so you'll need to byteswap to compare with
what you get from function.  Alternatively, make it an array of bytes and
do
	sum16 = csum_ipv6_magic(saddr, daddr, len, proto, csum);
	if (memcmp(sum16, expected_csum_ipv6_magic + i * 2, 2))
		complain

That's it.

