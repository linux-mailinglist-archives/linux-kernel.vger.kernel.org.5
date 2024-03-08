Return-Path: <linux-kernel+bounces-96983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B2D876414
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE7602833F5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700E956768;
	Fri,  8 Mar 2024 12:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="pbzvu5tR"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8851056746
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 12:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709899904; cv=none; b=fbbPmfCYFUBWyMroUUhG5zDE/+u8FqUTPjCgu3Z1DL8X/4bmnBN6bfhFoTOJGbFmGsbIvSLlk5cwL1MTd8/W0mzqKEUOUYuG7npK7W5gYOi4JaYI7UyFuMMCp8zN/b/ZPgLxlUB6fVPDwEWIPkS3u2zNkwGdi7QmwLjM3HUE6gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709899904; c=relaxed/simple;
	bh=h1EUAZcY4Sa9OLfLS8GuZCaKJI43c+bS6eKGcPLLqVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IZ3u2VQtS9kUCbzUZ6U6Tq+8kBZovj28j1DOwoxs3FfbYXBm+HJ5b6XNtgtVSsM5HhFvFHdlYOTVTwyFt44rlqnJfiRV3ZjjxLIN6XeWdHsLhHYYcsHkMtdT+0MGuM3ibDVolku6/Z7m1eKXRze3ZcGMGM9lyxvtyV3w97neJP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=pbzvu5tR; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-78850a904e4so26407985a.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 04:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1709899901; x=1710504701; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LFWHyOgkTFQ1yJTh6kQ8rZCjVUuuePKTHTw1zfzOKuU=;
        b=pbzvu5tRB/lqisuP71hR0ywqb5B3VpAK2GgJE+5luY3O8a47GFGrh1pVkuCammvtTu
         sNpRkU220qbOq2k2Cagz+ncOMJ5zuVMfHBXE2Ezn7bkuo4VId9JD7fXBcfSbna/r0uFB
         Mgj62TpaYAyaZH3rTNdNo+c0tnU4oMPNGyEU3now5lrmaqy5+L+n08O+N4GiNxjzZt+L
         KyMJWPe++8rkl9Gl0XRJlRbrvN21X5I5Roh2Cg2d2phphqDLU+0jTzYZAZdWYnEmaH5Q
         MChyAo9kJ0d6EMlXyauaqPjDsmu4s9/Nu3X0OF+EMPjZHQ4jeBiXPfyaCVxEkcukPzwN
         xM8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709899901; x=1710504701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LFWHyOgkTFQ1yJTh6kQ8rZCjVUuuePKTHTw1zfzOKuU=;
        b=G+u8ytCU/QMy/QBl3+nMJuBWIlV/xNH2hHU5h8EviolBM+2cILdE+KJOe9/yHauhs0
         uwqGiFcLnSUypBG5mdM1hfGNWFxF/qXEAOsCkPUKd0xS3GJMtyw/wz0hwGsKi5mIJbXh
         +IU2+e0DHSJk8PFfYqS/mY3LuZbWNJHyV5Hm1S/Tz5zarC7mUa5RNegJYhjnPLAPMqhr
         QdLy9b+lKpDIsmNj67btBzTjLHACJH51k//3+IY66XUGfFdzsmS7pTirBTFFK0g9u7EI
         puhsy7Qd7sCiqThxW32QBDQ5jBfXVWuuoyRaeY5Dodo5nCPsw4wXjTk1pMBLlfCgkf0o
         J1nw==
X-Forwarded-Encrypted: i=1; AJvYcCVWTe8ZY8NfcuExo0sYl6S3FOIH1G8NrH++7zJJUd4Xk6TeX6+7lE/xC42+N3kolX8I3jZZWAHE8Pye/NpgO0ojAVWZNbUrgWcSUfXe
X-Gm-Message-State: AOJu0Yw7d4p0AMFmVC+XloemH0xVbfP0bwzsnk/Vv0CcRUAoZs5glo6h
	himbwWpHZwQFR9XB2TlIhy5nyF9jCKO61L2Tkj5Museh5jaqWXZp/4fonfTLMeg=
X-Google-Smtp-Source: AGHT+IEzxOxVKkJMR57UwDLb3/yh3+LCr6bD0C5SHDj0C+YHgMECjWjVL0bqStieUxK8nnlRvm1EGA==
X-Received: by 2002:a05:620a:1265:b0:788:1dbd:efe6 with SMTP id b5-20020a05620a126500b007881dbdefe6mr10872949qkl.55.1709899901345;
        Fri, 08 Mar 2024 04:11:41 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id s18-20020ae9f712000000b007882b33f6d5sm4969471qkg.114.2024.03.08.04.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 04:11:40 -0800 (PST)
Date: Fri, 8 Mar 2024 07:11:39 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, davem@davemloft.net,
	herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
	linux-mm@kvack.org, nphamcs@gmail.com, yosryahmed@google.com,
	zhouchengming@bytedance.com, chriscli@google.com, chrisl@kernel.org,
	ddstreet@ieee.org, linux-kernel@vger.kernel.org,
	sjenning@redhat.com, vitaly.wool@konsulko.com,
	Barry Song <v-songbaohua@oppo.com>
Subject: Re: [PATCH v6 0/2] zswap: remove the memcpy if acomp is not sleepable
Message-ID: <20240308121139.GA116548@cmpxchg.org>
References: <20240222081135.173040-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222081135.173040-1-21cnbao@gmail.com>

On Thu, Feb 22, 2024 at 09:11:33PM +1300, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> In zswap, if we use zsmalloc, we cannot sleep while we map the
> compressed memory, so we copy it to a temporary buffer. By
> knowing the alg won't sleep can help zswap to avoid the
> memcpy.
> Thus we introduce an API in crypto to expose if acomp is async,
> and zswap can use it to decide if it can remove copying to the
> tmp buffer.
> 
> -v6:
>  * add acked-by of Herbert, Thanks!
>  * remove patch 3/3 from the series, as that one will go
>    through crypto
> 
> Barry Song (2):
>   crypto: introduce: acomp_is_async to expose if comp drivers might
>     sleep
>   mm/zswap: remove the memcpy if acomp is not sleepable
> 
>  include/crypto/acompress.h | 6 ++++++
>  mm/zswap.c                 | 6 ++++--
>  2 files changed, 10 insertions(+), 2 deletions(-)

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Looks good to me.

One small question: why cache is_sleepable in zswap instead of
checking acomp_is_async() directly? It doesn't look expensive.

