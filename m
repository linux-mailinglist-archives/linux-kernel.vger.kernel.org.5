Return-Path: <linux-kernel+bounces-69361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF588587E7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A857B281BFE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 21:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6345E146009;
	Fri, 16 Feb 2024 21:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cK//LtsA"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319DF145B18
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 21:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708118363; cv=none; b=e4QF98SI3H5IqKGD9Zi0ScGCPBhrqMgF4nDkPo3ov6lZl7Q61CHxp2Vjv3xUMNPjIzBpyMtxZB64V5afZ54QQSKvdx3umkTxpDviEpsk1vGxSabZWtw07LS4T4r0h5Cx/L6wdwy5Zhur4uWb6Ik2nNLdrFdLGn+NPLJSfMciZWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708118363; c=relaxed/simple;
	bh=pjViwhXqVkFuRcb9TtMCBqAXy9IB1rtSAVc+/tWHUoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kRsOXr3HTxulqNFnVihQhOjVFcoE94A18Idfh7r4EdqZ2wnYBW/Y11AsXMYfsB4qJklZuVuqn0Whd7FS3OdUX0YhUDJhsOeldURa34bdxDsUFSLohRmesNhybOx41sl5/13bjt8q3sTQMQ2Cl5EJhizrBdIXoXZ0XO4y+S48IzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cK//LtsA; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5ce2aada130so2155717a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 13:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708118361; x=1708723161; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Slargkifk+xN9eeRz4eeZrRCV6UdKDbpUow5tWWQ8Nw=;
        b=cK//LtsAUxR2N9tqu1a4AEH4D2i/Y92EaTnzsi/SJFgrT3dL9zfI5+nNd3hAKDw8TP
         momltlpGm0AD7E5gBbFA2Hypdq/fvYQLheII8S3zF0ZQQyVWd6jtMPnlLOzwAUZntsRQ
         G5NCF21aCMVf1iM/jXLB2XOn8k+OuwQmGfaFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708118361; x=1708723161;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Slargkifk+xN9eeRz4eeZrRCV6UdKDbpUow5tWWQ8Nw=;
        b=vqDLWdgqjAbOamEqNcLjFhpJa+8agGjvk0FVRpAuwbVOjNg8FPfvUNrxvsSIC2q/cj
         qPRUkmwW1aBnhonuwShWHu2rLs3xFs+jioaK8BpUhxhMMPWcjY8wlRyp2UuDsNlAg1m2
         4EDN4da0VYpbG47Xx/7WZBgHfSrwLKKBu+LMBWjPrvFsKWwtAfTkKNgnPzBk6w/zXZuM
         e2vlzYmWXy+N7RPjWCO6/DLDzLn1Tb4efxtSHjgk0nUtq5HfzUEvCBmQL7V2tkWNACXy
         Vru2T7RYV6BAWbGJv6ccIHhaiKoWuMb0dn7UByKIZfMXthgKlvj9ijLrlVK5WGbkaI+s
         AXnA==
X-Forwarded-Encrypted: i=1; AJvYcCVH7tvZeF0rM+0l010j6NrV6VN27l/aeyBRn7RVnz+hMkI7FOaKtS5JovUiqlWO0HxlBsFAfScSEg0fNCBbu9hg7MKEsWTxZpBqneUN
X-Gm-Message-State: AOJu0Yx9LnbMpzWXEsNcZO2deojkAbRNG5vBwH9wj3xAjy15P8PTRy2l
	dxW5tGugZnb8QL8ukZBHYYGXgfPhvFTll2/ogzWeshq5D8MIREi1/cMPDuX9AQ==
X-Google-Smtp-Source: AGHT+IHmIetBf12lZgnCIBsuyMKApScxQdHnKJTRQax45DnTFQUW8k5/OMVTOg+jgfmD8hQL5KfA0Q==
X-Received: by 2002:a05:6a21:670b:b0:19c:9b7b:66a with SMTP id wh11-20020a056a21670b00b0019c9b7b066amr6805585pzb.49.1708118361358;
        Fri, 16 Feb 2024 13:19:21 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id kq15-20020a056a004b0f00b006db05eb1301sm395754pfb.21.2024.02.16.13.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 13:19:20 -0800 (PST)
Date: Fri, 16 Feb 2024 13:19:20 -0800
From: Kees Cook <keescook@chromium.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Leon Romanovsky <leon@kernel.org>, Lin Ma <linma@zju.edu.cn>,
	Simon Horman <horms@kernel.org>, Breno Leitao <leitao@debian.org>,
	Tobias Brunner <tobias@strongswan.org>,
	Raed Salem <raeds@nvidia.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] [RFC] xfrm: work around a clang-19 fortifiy-string
 false-positive
Message-ID: <202402161301.BBFA14EE@keescook>
References: <20240216202657.2493685-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216202657.2493685-1-arnd@kernel.org>

On Fri, Feb 16, 2024 at 09:26:40PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> clang-19 recently got branched from clang-18 and is not yet released.
> The current version introduces exactly one new warning that I came
> across in randconfig testing, in the copy_to_user_tmpl() function:
> 
> include/linux/fortify-string.h:420:4: error: call to '__write_overflow_field' declared with 'warning' attribute: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror,-Wattribute-warning]
>   420 |                         __write_overflow_field(p_size_field, size);
> 
> I have not yet produced a minimized test case for it, but I have a
> local workaround, which avoids the memset() here by replacing it with
> an initializer.
> 
> The memset is required to avoid leaking stack data to user space
> and was added in commit 1f86840f8977 ("xfrm_user: fix info leak in
> copy_to_user_tmpl()"). Simply changing the initializer to set all fields
> still risks leaking data in the padding between them, which the compiler
> is free to do here. To work around that problem, explicit padding fields
> have to get added as well.

Per C11, padding bits are zero initialized if there is an initializer,
so "= { }" here should be sufficient -- no need to add the struct
members.

> Since this is a false positive, a better fix would likely be to
> fix the compiler.

As Nathan has found, this appears to be a loop unrolling bug in Clang.
https://github.com/ClangBuiltLinux/linux/issues/1985

The shorter fix (in the issue) is to explicitly range-check before
the loop:

       if (xp->xfrm_nr > XFRM_MAX_DEPTH)
               return -ENOBUFS;

-- 
Kees Cook

