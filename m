Return-Path: <linux-kernel+bounces-128328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AE9895963
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2398E28CC96
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2AF514B065;
	Tue,  2 Apr 2024 16:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="ejBUVAiv"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA9814AD21;
	Tue,  2 Apr 2024 16:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712074391; cv=none; b=npmpZpIwcWjyUCOdrWIqo0gsMK0DvWvIQjw12zXFhv4gy4H/ufE5lI8kc6Oluh+vL9CqkB/6ZTrYHSW8cl6a0KLwcPoaP9mMAm1TwjLQLNHXGtRODwNG+4lkgmVnT6Miuc9aTDj6u4/cJTHfYMkvsB+uvoSVSDkIf2EuA58fiZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712074391; c=relaxed/simple;
	bh=l2uJCn5EE/nmVlI3Yd0GJDFW+CzYJAEL5XE2EhTnbs4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mxtlH/CG/T4jATcoj+O1vdQdHmK/md8bdppxzaHYX0udXq5ZgRR2du/Fr3iJBl5Sl6foERllKOoDp1T0L/BrksKF+PbWFHpk/7lIvFA6uDheb/Fpq9f1+Mrf5BezYer5/ioNA7YMAeI7Pq5tkOYHG52QXjuS6ISetcAtz5OmZkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=ejBUVAiv; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 9CC0E47C41
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1712074388; bh=p/Jc35hywe3Mcn+8Ox6b/JZnMRzlqGbMNHhYUdkZFPc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ejBUVAivKo/ZZ/+YYE39vqfeUD2Us4QNHkP32sWbUWHzATQCb51e+4mYxGUauzFHG
	 iOMORsTBitk5xpPl2/VsMDOPDL/FnCm09+15GSXR++rQuBbr8hylbqmFXuZ420lmgt
	 ClNrdDylZj8nL+Nv+fsudTWmMyCKFq1GEYStUDExsTLEDMPHNoSp7Qg2Uww/eqr95K
	 MXukzyeX+7Fb767VbWb+QEGQxg68wbF8RpoNCn+bcqc0pBjSVw8NM3Pd3I8Wrnawfx
	 WMy9Edyx+0ibyIjRybpECnvFP65NDhS+Ts6fuhnd/AHL8iM4+cNKz3NScdio3tXE3w
	 I/BZesGmXI8JQ==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::646])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 9CC0E47C41;
	Tue,  2 Apr 2024 16:13:08 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-doc@vger.kernel.org, workflows@vger.kernel.org
Cc: apw@canonical.com, broonie@kernel.org, chenhuacai@loongson.cn,
 chris@zankel.net, dwaipayanray1@gmail.com, herbert@gondor.apana.org.au,
 joe@perches.com, linux-kernel@vger.kernel.org, linux@roeck-us.net,
 lukas.bulwahn@gmail.com, mac.xxn@outlook.com, sfr@canb.auug.org.au,
 v-songbaohua@oppo.com, Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH v5 1/2] Documentation: coding-style: ask function-like
 macros to evaluate parameters
In-Reply-To: <20240401012120.6052-2-21cnbao@gmail.com>
References: <20240401012120.6052-1-21cnbao@gmail.com>
 <20240401012120.6052-2-21cnbao@gmail.com>
Date: Tue, 02 Apr 2024 10:13:07 -0600
Message-ID: <87msqbvj3g.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

So I'm not sure what your desired path for getting this upstream is.  I
can take it, but I'm generally quite leery of taking coding-style
changes without some serious acks on them - nobody elected me as the
arbiter of proper coding style.

A nit below

Barry Song <21cnbao@gmail.com> writes:

> From: Barry Song <v-songbaohua@oppo.com>
>
> Recent commit 77292bb8ca69c80 ("crypto: scomp - remove memcpy if
> sg_nents is 1 and pages are lowmem") leads to warnings on xtensa
> and loongarch,
>    In file included from crypto/scompress.c:12:
>    include/crypto/scatterwalk.h: In function 'scatterwalk_pagedone':
>    include/crypto/scatterwalk.h:76:30: warning: variable 'page' set but not used [-Wunused-but-set-variable]
>       76 |                 struct page *page;
>          |                              ^~~~
>    crypto/scompress.c: In function 'scomp_acomp_comp_decomp':
>>> crypto/scompress.c:174:38: warning: unused variable 'dst_page' [-Wunused-variable]
>      174 |                         struct page *dst_page = sg_page(req->dst);
>          |
>
> The reason is that flush_dcache_page() is implemented as a noop
> macro on these platforms as below,
>
>  #define flush_dcache_page(page) do { } while (0)
>
> The driver code, for itself, seems be quite innocent and placing
> maybe_unused seems pointless,
>
>  struct page *dst_page = sg_page(req->dst);
>
>  for (i = 0; i < nr_pages; i++)
>  	flush_dcache_page(dst_page + i);
>
> And it should be independent of architectural implementation
> differences.
>
> Let's provide guidance on coding style for requesting parameter
> evaluation or proposing the migration to a static inline
> function.
>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> Suggested-by: Max Filippov <jcmvbkbc@gmail.com>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Huacai Chen <chenhuacai@loongson.cn>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Andy Whitcroft <apw@canonical.com>
> Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>
> Cc: Joe Perches <joe@perches.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> Cc: Xining Xu <mac.xxn@outlook.com>
> ---
>  Documentation/process/coding-style.rst | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
> index 9c7cf7347394..791d333a57fd 100644
> --- a/Documentation/process/coding-style.rst
> +++ b/Documentation/process/coding-style.rst
> @@ -827,6 +827,22 @@ Macros with multiple statements should be enclosed in a do - while block:
>  				do_this(b, c);		\
>  		} while (0)
>  
> +Function-like macros with unused parameters should be replaced by static
> +inline functions to avoid the issue of unused variables:
> +
> +.. code-block:: c

I would just use the "::" notation here; the ..code-block:: just adds
noise IMO.

> +	static inline void fun(struct foo *foo)
> +	{
> +	}
> +
> +For historical reasons, many files still use the cast to (void) to evaluate
> +parameters, but this method is not recommended:
> +
> +.. code-block:: c
> +
> +	#define macrofun(foo) do { (void) (foo); } while (0)
> +

1) If you're putting in examples of something *not* to do, it's probably
better to also put in something like:

   /* don't do this */

people don't always read closely.

2) Can we say *why* it's not recommended?

Thanks,

jon

