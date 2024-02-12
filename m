Return-Path: <linux-kernel+bounces-62166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B429851C88
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF1DC28244E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394F244C8B;
	Mon, 12 Feb 2024 18:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Pxu/43Up"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082634176B
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 18:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707761547; cv=none; b=LI4LY/T7JccpXQeYEs6I73WQNhQzLfpql9rE7O4izlxHgHJ2awudGdE+ztoskvDDk4iPH1p+EhyIRM1ZftgVEPPFyTJIboqGGCH3vrgC51OUeSVARBbkFVoGbKc5FOYrCw7ajF6vTUnhDhTFBVWS/Mgn4ZCeEStp4F2nFrZ8QyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707761547; c=relaxed/simple;
	bh=vx+FLfr7ce/UQqqu1Khd9TxZz+5/OjveSIVTS+FRqj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DE/T7gAlovKaBTaj6NwqxzH1JHWjqYTI/KL2kIOu8oPv+opgsy4BgrzXWLORZua0cL3trPC37LNf5+D6aPWrm35rW5ZZg/T5v73uNpvtWG7BS6IcioQuAJLQXPq5JFM2G7VDPLXKhnP7I9zLasCEZOmbZDanWC19hgRYLnBW4x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Pxu/43Up; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rsBAVXiIzak7tZKaq29MJMOa8EtmcDav3gxRlW2bFOY=; b=Pxu/43UpZ05UWh82/eKRAhrr+4
	XsMMDhI1SR4UDs3Tw6qXO/ASnD/qGnOKeNPdUq8p4XI+rZpQr6izjMJ1J1uYPVP76UxpBHjNDMLpa
	CNAqIZTXeqa9qjLXBRxCjcT+Rb39D/HgIxtV9WKfX+PYzeoocVhLhwuEPeaOPZBrncUsPh98oZMmF
	OQJj3lTKVTADLdHQK2WSyoRqvyXy7ZaZgieHO9uDy5gCzn9hbYa0Jgt6tGfR5OgPGKXIsNzgD2eAk
	nNa92ZovoeSH98xIHG10NuVnQWyvSEbrc5tar8VSl71gawrnexQcbEDlpW7LgRaJyM7aAj7YbSYUS
	TbgYS/EQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rZamv-0071D4-21;
	Mon, 12 Feb 2024 18:12:17 +0000
Date: Mon, 12 Feb 2024 18:12:17 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Charlie Jenkins <charlie@rivosinc.com>,
	David Laight <David.Laight@aculab.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] lib: checksum: Use aligned accesses for
 ip_fast_csum and csum_ipv6_magic tests
Message-ID: <20240212181217.GK608142@ZenIV>
References: <20240207-fix_sparse_errors_checksum_tests-v6-0-4caa9629705b@rivosinc.com>
 <20240207-fix_sparse_errors_checksum_tests-v6-2-4caa9629705b@rivosinc.com>
 <20240212062614.GI608142@ZenIV>
 <52393411-8313-4e94-9618-916b57f7d52e@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52393411-8313-4e94-9618-916b57f7d52e@roeck-us.net>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Feb 12, 2024 at 09:18:14AM -0800, Guenter Roeck wrote:

> Almost. Turns out the csum parameter of csum_ipv6_magic() needs to be in
> network byte order, and the length parameter needs to be in host byte order.
> So instead of
> 	data.len = data_ptr->len;
> 	data.csum = (__force __wsum)htonl((__force u32)data_ptr->csum);
> it needs to be something like
> 	data.len = ntohl(data_ptr->len);
> 	data.csum = data_ptr->csum;
> 
> Also, as you mentioned, either the returned checksum or the expected
> checksum needs to be converted for the comparison because one is in
> network byte order and the other in host byte order.

        for (int i = 0; i < NUM_IPv6_TESTS; i++) {
		struct args {
			struct in6_addr saddr;
			struct in6_addr daddr;
			__be32 len;
			__wsum csum;
			unsigned char proto;
		} __packed data = (struct args *)(random_buf + i);
                CHECK_EQ(cpu_to_le16(expected_csum_ipv6_magic[i]),
                         csum_ipv6_magic(data.saddr, data.daddr, ntohl(data.len),
					 data.proto, data.sum));
        }
and to hell with field-by-field copying.  __packed here will tell the compiler
that alignment of the entire thing is 1 - the total size of fields is 41 bytes,
so "no padding" translates into "can't even assume that address is even".

And I'd probably turn that expect_csum....[] array into an array of bytes,
with *(__sum16*)(expected_csum_ipv6_magic + 2 * i) in your CHECK_EQ instead
of arch-dependent byteswaps.

