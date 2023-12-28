Return-Path: <linux-kernel+bounces-12547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E7281F684
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 10:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BED79281364
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 09:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480A363D7;
	Thu, 28 Dec 2023 09:49:40 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170D663C9
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 09:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rIn0j-00F5cs-9p; Thu, 28 Dec 2023 17:49:06 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 28 Dec 2023 17:49:16 +0800
Date: Thu, 28 Dec 2023 17:49:16 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Barry Song <21cnbao@gmail.com>
Cc: Chengming Zhou <zhouchengming@bytedance.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Seth Jennings <sjenning@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Vitaly Wool <vitaly.wool@konsulko.com>,
	Nhat Pham <nphamcs@gmail.com>, Chris Li <chriscli@google.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Dan Streetman <ddstreet@ieee.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Chris Li <chrisl@kernel.org>
Subject: Re: [PATCH v4 2/6] mm/zswap: reuse dstmem when decompress
Message-ID: <ZY1EnEefZsRTGYnP@gondor.apana.org.au>
References: <20231213-zswap-dstmem-v4-0-f228b059dd89@bytedance.com>
 <20231213-zswap-dstmem-v4-2-f228b059dd89@bytedance.com>
 <CAGsJ_4yUCQrGKQD-oxSAhyvJ+fY_KXUoiVBXE_i0jDAhWiNGzA@mail.gmail.com>
 <c33d2811-7a61-40cc-a93e-9416bf9bbbf0@bytedance.com>
 <CAGsJ_4xHJzfjCsWqOdEs_=DTExJueO3gsVg4y_sNtr3U8BEuRg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGsJ_4xHJzfjCsWqOdEs_=DTExJueO3gsVg4y_sNtr3U8BEuRg@mail.gmail.com>

On Thu, Dec 28, 2023 at 09:03:32PM +1300, Barry Song wrote:
>
> for CPU-based alg, we have completed the compr/decompr within
> crypto_acomp_decompress()
> synchronously. they won't return EINPROGRESS, EBUSY.
> 
> The problem is that crypto_acomp won't expose this information to its
> users. if it does,
> we can use this info, we will totally avoid the code of copying
> zsmalloc's data to a tmp
> buffer for the most majority users of zswap.
> 
> But I am not sure if we can find a way to convince Herbert(+To)  :-)

What would you like to expose? The async status of the underlying
algorithm?

We could certainly do that.  But I wonder if it might actually be
better for you to allocate a second sync-only algorithm for such
cases.  I'd like to see some real numbers.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

