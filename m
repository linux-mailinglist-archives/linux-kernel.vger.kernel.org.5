Return-Path: <linux-kernel+bounces-62218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BFE851D2B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 157361F24748
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E638F4122D;
	Mon, 12 Feb 2024 18:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="URDbmCDg"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB96B3E464
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 18:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707763407; cv=none; b=Ygu23TlIky0/TvKjytdVt2z0AA+DwKJ9fr/8nnO7hYtfqWepi1+upB18My0Xeqjh/dN+V85HlR0hwlMoMMweWGGi6Rjpo0zAS8YvPBfNdnw0BXggcNQgNUDU3vANq/25fL0ibcu5Z/iaghv9OvUKwg1DIT86UdWId04RMV2xXvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707763407; c=relaxed/simple;
	bh=xuJuJVojqzGkpxFOVvXqEPg45jhcADabr87a55V2+r4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HzxZCv58LegXwz5iWZ2g7skPIoXnZ3/W0zjHpgMoA4gmF/zs6CKtPiIlMWq20QE0rIRiTFms+4wUJfwOZe9bb4WwGCTtFfVbgq3lDUPnu9iFkpPhvlv496NaUcEvC55bw7mFVnYalht0LZ0+20djYQbcpstyFWFL+VdxYeL7NHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=URDbmCDg; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=p0DdbAuSpgsYOwZa1oPHxn50PF84K4wxSeGZY4WB+KA=; b=URDbmCDgHekyc/FtZTQSr9K6e5
	ScyR7CUhtRVpT44a7oOHmrNBJAjsxg+mmxMOw25RzsyJGbUwVNBkGczISwbOlGQVwRvujWtEX7g1/
	/jJmiyPv2K/4xnyaLeFZCJ4sM6LOMZr04VwhXPvxMsNYXXo15moQG8ZvLv/KhHy8qxuhHhs/Wow5K
	+q+5wTIbHulxFUGCC1XU2nxznDgUGsRg6pn9XHIZvfgqx1zF/pso2c6561BgE+LaQiTfgOGy5wjRN
	Ok0PGmUwIwpIUKMsjjZoHqr+lYX78D3j4Beka7kFYX3jM9UCdeMli28kke3eQJRAwPzGOvXlXLkaL
	rgg2PmaQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rZbGw-0072Kh-1W;
	Mon, 12 Feb 2024 18:43:18 +0000
Date: Mon, 12 Feb 2024 18:43:18 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Charlie Jenkins <charlie@rivosinc.com>,
	David Laight <David.Laight@aculab.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] lib: checksum: Use aligned accesses for
 ip_fast_csum and csum_ipv6_magic tests
Message-ID: <20240212184318.GL608142@ZenIV>
References: <20240207-fix_sparse_errors_checksum_tests-v6-0-4caa9629705b@rivosinc.com>
 <20240207-fix_sparse_errors_checksum_tests-v6-2-4caa9629705b@rivosinc.com>
 <20240212062614.GI608142@ZenIV>
 <52393411-8313-4e94-9618-916b57f7d52e@roeck-us.net>
 <20240212181217.GK608142@ZenIV>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212181217.GK608142@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Feb 12, 2024 at 06:12:17PM +0000, Al Viro wrote:
>                          csum_ipv6_magic(data.saddr, data.daddr, ntohl(data.len),
					   &data.saddr, &data.daddr, ntohl(data.len),

obviously...

