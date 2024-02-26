Return-Path: <linux-kernel+bounces-81530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D3B867726
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB4FE1C2984B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E9D128839;
	Mon, 26 Feb 2024 13:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLF2GRs1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2C91AACC;
	Mon, 26 Feb 2024 13:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708955256; cv=none; b=aEJMX3MxKcxNwdGANM1x6eqiSKU53vmzOfbYzA5dFYzEFeZSMusgLbaZn3QkBtC5UbarwdouQXCoOLwR4zQWIKWbwRLnnJ5AWkb9Nag75lHH1H5dSUzhfeJbBWsYV1dCJFMFtRh6HKILSjyxktAZw0sUGp3bNPrlhVfRx+rKPE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708955256; c=relaxed/simple;
	bh=fSJaGhfbzk3mg9Gy/IkD4517DdQOP65I1oQqAokj57g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kv5owtYhvTKfPO+JgWkoQ5IDtG7KjL6kXjcIJFt04QSjKr9Wm14nyyI6QXjGyWI7gUgQ3uXkVRD4p9YGFds4p7DUej0Pies5WmRxLuX7QOyFk77awWxlt7IwREK+xjgAQFvUjqlrbNukDeMZAl+48SViDyQwL/9H6KXU+Jh7+oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLF2GRs1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B552C433C7;
	Mon, 26 Feb 2024 13:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708955255;
	bh=fSJaGhfbzk3mg9Gy/IkD4517DdQOP65I1oQqAokj57g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SLF2GRs1FNRQRREvRc0IrbCboJQPubtEH/xb1/5pMSw4F/R5Ds+sNAKHXtH3bTZ73
	 IipHQ7/5PdlRjKq0/n2WuEQGT81qUUAmsd3l4Sh3rEbbDgoUHGhFBWTmRRYrKrKD1k
	 p3rqxWMAuCSy8yyPUBPCawWS46wLH6pUQXi1Aw5Lpog2b5rLJsMxOfJS9CajvuICQ0
	 d+zJv0b8zQ/PNYvOzo+GG+/3srCyC6GNu1PEMK+XPrBfRVzvo3Ra7qoINBrJHuIZIZ
	 aqlSU/DN4ZjmecGXdHB+/Oj4iAreUbOoBZximzjzWy7xdkBy2mR3V0FOUVHMFyH4gz
	 d3HbrlViWZT+w==
Date: Mon, 26 Feb 2024 13:47:30 +0000
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
	edumazet@google.com,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] xfrm: Do not allocate stats in the driver
Message-ID: <20240226134730.GE13129@kernel.org>
References: <20240222144117.1370101-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222144117.1370101-1-leitao@debian.org>

On Thu, Feb 22, 2024 at 06:41:17AM -0800, Breno Leitao wrote:
> With commit 34d21de99cea9 ("net: Move {l,t,d}stats allocation to core and
> convert veth & vrf"), stats allocation could be done on net core
> instead of this driver.
> 
> With this new approach, the driver doesn't have to bother with error
> handling (allocation failure checking, making sure free happens in the
> right spot, etc). This is core responsibility now.
> 
> Remove the allocation in the xfrm driver and leverage the network
> core allocation.

Reviewed-by: Simon Horman <horms@kernel.org>


