Return-Path: <linux-kernel+bounces-157612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8018B138F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2640C28B239
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 19:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3127C78B4E;
	Wed, 24 Apr 2024 19:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="kEwbpGCb"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C341BF37;
	Wed, 24 Apr 2024 19:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713987077; cv=none; b=CR5wRtLb4gTcAKMeUKHTH1eMWPCVgPPJZDP6gZPS7W6BPFacBuTEpBsRWqi5kzDuO00qYE/5tqGEHjQuH1CRLB3A+uouKBFiOPE7fUK/UDDO9Zw+JFfiL+1xsQVQcgAKiaMo4Kw9CQCTwNO9seioBW7Xhf8mGf7yDFkwQpqvuKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713987077; c=relaxed/simple;
	bh=f5Ao0kXR9wgQ9qndsBddrePDZj2ijjLQhBhAGWqsY9M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tYCaxgyItm0/ETu2KH+m84XHg6uEFgEQUPCe8m6uGioJnWQ2x3qR3ZxT189YD/3Xlb6YUqoOOQWLrr3u3WF4wMcFs/jmX1n9hBWTjfRK3BFE+zx2txiyp32Q+SAz5gl+ajzQz+4w4b8adhqTPy3jyGSiFwEYhbsG8Ng8hrMBwks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=kEwbpGCb; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 76D3D47C41
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1713987075; bh=zV9bgV2MTfwKBqhBOhhlxAkLQT1T0lmWvKHJq+h7QSY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=kEwbpGCbXYNEgI2+Z1T9hwKhPOxm/JyjMUI38WtfH5sR3Hn/Q1TsnDkbgvE+ySRvo
	 sE4JZnmvIMkmEPG8mCrq3jVb9XEss19Atd/OpCGz5rPPJ2DsailCfd3JpwnKGtfWr0
	 wIFFJeKtu1UGf7w1dBJBBJNDN+DIi5ypndIzUXaiiEUq4DOazkjakK7wWDGPEIWMBb
	 2agh85P0/pXIeYHekNK/7aLBQ3AB0RQx7Dk/UaH+AlY3a6o7G9juYxnKdfQwBaOXYW
	 JWdCqD+YB/enk3OvQCkQeWLBIcCuvjO1H6C4xOSQRpMybjBPqnSZxRdfX4IN1lkg4L
	 vU+cNI6QJ1luA==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 76D3D47C41;
	Wed, 24 Apr 2024 19:31:15 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Kees Cook <keescook@chromium.org>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Jakub Kicinski <kuba@kernel.org>, Dan
 Williams <dan.j.williams@intel.com>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, Keith Packard <keithp@keithp.com>,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel-doc: fix struct_group_tagged() parsing
In-Reply-To: <20240411093208.2483580-1-aleksander.lobakin@intel.com>
References: <20240411093208.2483580-1-aleksander.lobakin@intel.com>
Date: Wed, 24 Apr 2024 13:31:14 -0600
Message-ID: <87r0eusgl9.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alexander Lobakin <aleksander.lobakin@intel.com> writes:

> From: Kees Cook <keescook@chromium.org>
>
> kernel-doc emits a warning on struct_group_tagged() if you describe your
> struct group member:
>
> include/net/libeth/rx.h:69: warning: Excess struct member 'fp' description in 'libeth_fq'
>
> The code:
>
> /**
>  * struct libeth_fq - structure representing a buffer queue
>  * @fp: hotpath part of the structure
>  * @pp: &page_pool for buffer management
> [...]
>  */
> struct libeth_fq {
> 	struct_group_tagged(libeth_fq_fp, fp,
> 		struct page_pool	*pp;
> [...]
> 	);
>
> When a struct_group_tagged() is encountered, we need to build a
> `struct TAG NAME;` from it, so that it will be treated as a valid
> embedded struct.
> Decouple the regex and do the replacement there. As far as I can see,
> this doesn't produce any new warnings on the current mainline tree.
>
> Reported-by: Jakub Kicinski <kuba@kernel.org>
> Closes: https://lore.kernel.org/netdev/20240405212513.0d189968@kernel.org
> Fixes: 50d7bd38c3aa ("stddef: Introduce struct_group() helper macro")
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Co-developed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>  scripts/kernel-doc | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

So, in docs-next, applying this *adds* two warnings:

> ./include/net/page_pool/types.h:77: warning: Function parameter or struct member 'fast' not described in 'page_pool_params'
> ./include/net/page_pool/types.h:77: warning: Function parameter or struct member 'slow' not described in 'page_pool_params'

In truth, the warnings look correct.  I guess I'll leave this applied,
but perhaps a fix for the warnings should go into the net tree?

Thanks,

jon

