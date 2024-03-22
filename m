Return-Path: <linux-kernel+bounces-112078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C84E68874EB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 23:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69CADB2137D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 22:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C01882892;
	Fri, 22 Mar 2024 22:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BY56IZxS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4D61CD00;
	Fri, 22 Mar 2024 22:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711147795; cv=none; b=n9W+dCYclGnyGqbH9ZrHtrH2xePwZ+bbvpMswqte84d8j4yhswmpKrPTgQv9xDXaDOfa6GkATFLu98jVRq5nOQJnB67vw4qZfCx1KaMKIejKyRN4ApiKFTSY/903NefVq5YYuLQT5zUR6ee1GP3Oipv7p+jRuOIgcuMgN4GMveI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711147795; c=relaxed/simple;
	bh=H3FeOQH6sBeVeQM36PEvoaOUsJ0P5+pGKeNAJLCnNOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GRbXha5JLU+EokT2MqOWrJDY/aL5uuMx0KIRpPW5RS/UA1fn7kJSbfcYjoOPyfDRO3hy5laVzfx4JN4jPDVbGyGHtsj/VGIf1FRTevNEQP/Y+VGGgTemqiZaGzjyYZ3CFIhrCkGNJ0ZWwUfpAarmKuul4PkLDmGMxDUNsuUYVQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BY56IZxS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D296FC433F1;
	Fri, 22 Mar 2024 22:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711147795;
	bh=H3FeOQH6sBeVeQM36PEvoaOUsJ0P5+pGKeNAJLCnNOQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BY56IZxSnLvGQyUIDb5I3i9eQgwqsYRGVsf3+3OzXMYPH75+9HTDnAyfZf7V1mElw
	 ZSnRJhUDigGAyXF9NDpt96iIzSm9ROaQW+BWVt2RDit0FwMIBK4RWT1SelqVn3D4WW
	 TN6ABBfmkNBImKVeyT5lbHKoaS8B9wyl/G2fXNaHeF68qy7puBYxOCDUBRVwdPat+O
	 73Huvp87w2p3+TcWMqV7IMEjD/F2apHUM7z4I94k7NWMsCFDRYerHMNVylB+BPE52B
	 Z8d4F3xYkn/e8HbQMOtJmFyuWj8AfOBQGhn0wo/FQ4Y8Z8XE8+jouc67QchGY61OZ7
	 t1KRLYWI3l9ug==
Date: Fri, 22 Mar 2024 15:49:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Arnd Bergmann <arnd@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, YOSHIFUJI Hideaki
 <yoshfuji@linux-ipv6.org>, Ville Nuorvala <vnuorval@tcs.hut.fi>, Arnd
 Bergmann <arnd@arndb.de>, Kui-Feng Lee <thinker.li@gmail.com>, Breno Leitao
 <leitao@debian.org>, Kunwu Chan <chentao@kylinos.cn>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipv6: fib: hide unused 'pn' variable
Message-ID: <20240322154953.0f3618b4@kernel.org>
In-Reply-To: <20240322132549.GG372561@kernel.org>
References: <20240322131746.904943-1-arnd@kernel.org>
	<20240322132549.GG372561@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Mar 2024 13:25:49 +0000 Simon Horman wrote:
> > Fixes: 66729e18df08 ("[IPV6] ROUTE: Make sure we have fn->leaf when adding a node on subtree.")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>  
> 
> ## Form letter - net-next-closed

I guess... If it's a W=1 warning there's no real urgency.
We should probably also drop the Fixes tag, then.

