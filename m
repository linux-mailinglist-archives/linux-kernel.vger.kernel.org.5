Return-Path: <linux-kernel+bounces-161112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B40F8B4745
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 19:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AC7A282388
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 17:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A45143C53;
	Sat, 27 Apr 2024 17:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VylxVv+Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9A5142E6A;
	Sat, 27 Apr 2024 17:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714239436; cv=none; b=QwS4De7/jzH5znxdhc5cO6AGd3sKFiVL0im2SK9ux8sb6RCj0OD/SpLbheqx1eK0AN3ohF9rZ8nKBY1VbnXd10cgaC4FyRPx5hlyONUz3wS5PNeORj+tHNnQbogOdux2v8gv5bJcZO9MlPF9uL6KHsRNgAHxu7HLl7rrpdHgByc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714239436; c=relaxed/simple;
	bh=ACWSgz/gFQd2YmHbZIxyYXBsocr+bVp+iXY4UiYTy2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MngPH95WeBPbQJIboF2+o0EW1rysNS9IjyrOFPfSRWJ4UFtHAyriBYZ4BJnIXFv7H+yTT+ye3xHEosQjjj5saQ6FYNO010Xpca3wBg9laTW8/Od9iHzIkNY3CHue7TUBIrWkuwRNPlKQLzzocT3/KcsvaqYQnwSzvZ9JWg5sLCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VylxVv+Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35865C113CE;
	Sat, 27 Apr 2024 17:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714239435;
	bh=ACWSgz/gFQd2YmHbZIxyYXBsocr+bVp+iXY4UiYTy2c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VylxVv+YIYX1ia6njxBXD7tS/94XLt6o6W48Az/58PoLP+T/S8822+CN/8X/Vdq6K
	 qw9yHPNlvIZmSUrUxkK6U0BCcKJL5MBn8AHcNr1njj1+mOQdbgXKoBiSeKjA+R5s0I
	 00g1KgwDfGiN0ao2M6QFz+tVFKBSsgK5x+l2oMVQlwcGWHiPtnASQaPaaSFZOaK+Zu
	 09clU3kHp3kTp/iNIdfJiRkbWE/Rarm1cWbEk4lfyAQPbZLjR74piBhTyCLaOa9+VJ
	 bMYOWs6dGLwEnzb5meqk4mjg84MFQNsRi2X8B0xMxw8PaAmAc0QOQ8H1JTbwsTnq77
	 MGAEDovVr76hA==
Date: Sat, 27 Apr 2024 18:37:10 +0100
From: Simon Horman <horms@kernel.org>
To: =?utf-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ariel Elior <aelior@marvell.com>,
	Manish Chopra <manishc@marvell.com>, Jiri Pirko <jiri@resnulli.us>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: Re: [PATCH net 1/4] net: qede: sanitize 'rc' in
 qede_add_tc_flower_fltr()
Message-ID: <20240427173710.GA2323996@kernel.org>
References: <20240426091227.78060-1-ast@fiberby.net>
 <20240426091227.78060-2-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240426091227.78060-2-ast@fiberby.net>

On Fri, Apr 26, 2024 at 09:12:23AM +0000, Asbjørn Sloth Tønnesen wrote:
> Explicitly set 'rc' (return code), before jumping to the
> unlock and return path.
> 
> By not having any code depend on that 'rc' remains at
> it's initial value of -EINVAL, then we can re-use 'rc' for
> the return code of function calls in subsequent patches.
> 
> Only compile tested.
> 
> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
> ---
>  drivers/net/ethernet/qlogic/qede/qede_filter.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)

Reviewed-by: Simon Horman <horms@kernel.org>


