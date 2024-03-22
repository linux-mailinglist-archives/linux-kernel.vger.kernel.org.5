Return-Path: <linux-kernel+bounces-111476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 059DC886CD2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99D5AB21D95
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 13:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E9646435;
	Fri, 22 Mar 2024 13:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JnrrkVnm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B8D4501D;
	Fri, 22 Mar 2024 13:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711113955; cv=none; b=nG9U3WJHSBvYkPwF3fQf783YMd1PqFC73VVx2l7PCQLFBwI6bBmbAO9tPcIbaGm56FSVl9nLB98uOXlPJx5Nnb3iZyEe1DIv0GxaxwnkbOMYqW+47h/rMDiQkFgpHagthAgcgxBf5aMaGodVg33vlWrj+iMcLlmLdvn7iXPyEng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711113955; c=relaxed/simple;
	bh=CENpD5NgmAJhS3D1ZXkdYGmEklIoEZGQs/+tbDdphNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cbXA6TZZRI4ysZppLSCGjsoknu8n4Cy4PHFm7hPiSZ+ZA9Emdai9Ooo4/vnREk5W5AQOTcxIfH+wkno49Zu1xc6KA8xGXdVaNPJPOtF+ap/7Am1jjNVgnf0oZAMQRDP2nU1hzzhtiIYTo0QQ+eB0zzS92m+HJ4wT9iFk06fOrcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JnrrkVnm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5D02C433F1;
	Fri, 22 Mar 2024 13:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711113954;
	bh=CENpD5NgmAJhS3D1ZXkdYGmEklIoEZGQs/+tbDdphNA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JnrrkVnmIrKqbKLZjGbRSzx7y3YfQyc7PgmFZWmwbjz345aiSwtKplKgRuaEnTF5u
	 uU3T+NlHWG3MCJ5Vwaej26vx0+N6U9YtsgnG5nW3l+mtpEL7IgNFH323KXJLhZyyOV
	 tMDyRgPVO2+qzNtj84FS5qcnKiHuk/iGk3hufWopnrK3NMjud6qZ0cWWWrQHejWZB3
	 JtAKPT4expA4Jvck6GCuitaHss6aJ0optS4vhUqewcBP8okggAXfJ0zb42eZvDJm6f
	 CnDkhQo370bZnamTExR0XEYe63E0VHbf2k5iqzYWNLJS05jq4KGI/XXVIYeuaF+SOE
	 B57PNzZdlWsQA==
Date: Fri, 22 Mar 2024 13:25:49 +0000
From: Simon Horman <horms@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>,
	Ville Nuorvala <vnuorval@tcs.hut.fi>, Arnd Bergmann <arnd@arndb.de>,
	Kui-Feng Lee <thinker.li@gmail.com>,
	Breno Leitao <leitao@debian.org>, Kunwu Chan <chentao@kylinos.cn>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipv6: fib: hide unused 'pn' variable
Message-ID: <20240322132549.GG372561@kernel.org>
References: <20240322131746.904943-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322131746.904943-1-arnd@kernel.org>

On Fri, Mar 22, 2024 at 02:14:10PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When CONFIG_IPV6_SUBTREES is disabled, the only user is hidden, causing
> a 'make W=1' warning:
> 
> net/ipv6/ip6_fib.c: In function 'fib6_add':
> net/ipv6/ip6_fib.c:1388:32: error: variable 'pn' set but not used [-Werror=unused-but-set-variable]
> 
> Add another #ifdef around the variable declaration, matching the other
> uses in this file.
> 
> Fixes: 66729e18df08 ("[IPV6] ROUTE: Make sure we have fn->leaf when adding a node on subtree.")
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

