Return-Path: <linux-kernel+bounces-111477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9595E886CD5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 500CB282077
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 13:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985C14643B;
	Fri, 22 Mar 2024 13:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L1MAOW4B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D327A44C84;
	Fri, 22 Mar 2024 13:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711113976; cv=none; b=EM3BtrX3HNfIUItdy6GfBXsZ50cXWfpqG76XNgiyMSBQ3vR4caCNe0gc4yCAmoe17woBZX7qgLPErr6tRR+cwiB5RLbyKJYYZyV7zbCgeZtotruMTSDBl2ym1QqMmz12fgI/Nt9hFiLgP6NTZ9nnz2YKcV0CwjqykVmfCqHlxCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711113976; c=relaxed/simple;
	bh=KhGIxGzQHHpyZi1er77uS4aXuZbgvT9xv+BQ7arBReI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E6Q837BccEwYy1dg/R/UQfrnkjVzfSpuTkvmrrL5l3+f7PPtJ+78Rj+E7Q/xQPLPzybtiYnIWBSBog1JL2Kje4t0oiBfjTrKRl1PNFQpddVqKJf7hJHDMLDMTJ9/l0sTu9W05du9BNgdRMH/bgdQjdeSCV+IwbtQEGEIEfKT/hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L1MAOW4B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C27CC433F1;
	Fri, 22 Mar 2024 13:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711113976;
	bh=KhGIxGzQHHpyZi1er77uS4aXuZbgvT9xv+BQ7arBReI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L1MAOW4BqQ6QNLKmhvGzw61Uscyav+etxQJ+HTPNeY/eQXG616zB/1vLmNI93IftE
	 djhBB0R6QB+MKc4NNSab61TD3cuoJKyFEhO9L82t/DdsfvAVMInDDSz//O93yfmecA
	 e005+qIDIqKQEs+9qwSraFou1yNZ7OSgW1EEvdqIL+Op5oCcffdsC3XhVzc26wdmhH
	 XqD3wSrNU40ngYAmiRKt94UFYXIfMaW/aT/sgf12P3z1P9g8M7r/MtRKadBEdMFLmI
	 oH/yUF7xagVpZNirrCHRyNP7v7S94cLg5304u3EJneOnyV+ylIIrHP88yuUYLSjMrG
	 /HVERo6SIN5EA==
Date: Fri, 22 Mar 2024 13:26:11 +0000
From: Simon Horman <horms@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>, Kunwu Chan <chentao@kylinos.cn>,
	Joel Granados <joel.granados@gmail.com>,
	Zhengchao Shao <shaozhengchao@huawei.com>,
	Wangyang Guo <wangyang.guo@intel.com>,
	Kyle Zeng <zengyhkyle@gmail.com>,
	Beniamino Galvani <b.galvani@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipv4/route: avoid unused-but-set-variable warning
Message-ID: <20240322132611.GH372561@kernel.org>
References: <20240322131817.905700-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322131817.905700-1-arnd@kernel.org>

On Fri, Mar 22, 2024 at 02:18:12PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The log_martians variable is only used in an #ifdef, causing a 'make W=1'
> warning with gcc:
> 
> net/ipv4/route.c: In function 'ip_rt_send_redirect':
> net/ipv4/route.c:880:13: error: variable 'log_martians' set but not used [-Werror=unused-but-set-variable]
> 
> Change the #ifdef to an equivalent IS_ENABLED() to let the compiler
> see where the variable is used.
> 
> Fixes: 30038fc61adf ("net: ip_rt_send_redirect() optimization")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

## Form letter - net-next-closed

(text from Jakub)

The merge window for v6.9 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We are currently accepting bug fixes only.

Please repost when net-next reopens after March 25th.

RFC patches sent for review only are welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
--
pw-bot: defer

