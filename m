Return-Path: <linux-kernel+bounces-134956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A919189B951
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A29D1F2175E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 07:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7D64D5BA;
	Mon,  8 Apr 2024 07:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5J8RCAs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871F15FB95;
	Mon,  8 Apr 2024 07:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712562512; cv=none; b=e3y3+mL4GtWTLUqtHEVQmfySzENNMmlfHQCqL/LrtGT5rRHnYoTu4i8dmylTQtrDLDl/5Z2NjEUwRixKAcP1NBQeqilSsG3mXW8b64ilZHrFQFBdoaY96UBtIWq4qVmUVc7cEhx47o3obIGNYerITeQwUqzZ7G19WC3kpQ8MVrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712562512; c=relaxed/simple;
	bh=OyivqxCyCQHaU0TBvZu93VhrYPwd0djlXetBhWNnesg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pxs8y2cBebP20ZMzIVPeyFU7CeUGGQ4jvr4n/Yerc1EJZ7qYRzMRqKBGRsZljS/3U9eyB6vNzG/fztruHmpEdH8lE+f2T8e4lgVv+oV/tfwotwq1SyLmU5xhrgK7L/wjwXg9kjaT6W6f0RBjz+FOp32Eq/vZFClacVoBVXNSesA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5J8RCAs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6E45C433C7;
	Mon,  8 Apr 2024 07:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712562512;
	bh=OyivqxCyCQHaU0TBvZu93VhrYPwd0djlXetBhWNnesg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B5J8RCAsrKzRVEhhwi/e38juo3WpjVWQRnbyNanqNA6q/wEidu68HX91oGo+Wts8M
	 HSrpru0oR2wUqZq9D+fZQi6I84bKIyh7Enb7oHQHXWYdlAcylmkepJI1OKJo2scDII
	 7o/efqaTf1SyH5XZWL20kh29NdFdsDcTljpDSZIjs8VlSnpwqV0ry3N+ce4m1fp9Z+
	 D16nABgcaVDmzyXmXuhbuU+bZkEPTrbPThBBk7MaMb6np+OubsWPXAMM62NcID6MPt
	 l4KWRstfel4q0W2nWeYICj5y7GWvzx3pYRowW6oG+TQZXw78gnJX7UUAhBUghxvTSA
	 sEBn334ShUFmg==
Date: Mon, 8 Apr 2024 08:48:26 +0100
From: Simon Horman <horms@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	David Ahern <dsahern@kernel.org>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] ip_tunnel: harden copying IP tunnel params to
 userspace
Message-ID: <20240408074826.GA26556@kernel.org>
References: <20240404160302.3585661-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404160302.3585661-1-aleksander.lobakin@intel.com>

On Thu, Apr 04, 2024 at 06:03:02PM +0200, Alexander Lobakin wrote:
> Structures which are about to be copied to userspace shouldn't have
> uninitialized fields or paddings.
> memset() the whole &ip_tunnel_parm in ip_tunnel_parm_to_user() before
> filling it with the kernel data. The compilers will hopefully combine
> writes to it.
> 
> Fixes: 117aef12a7b1 ("ip_tunnel: use a separate struct to store tunnel params in the kernel")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/netdev/5f63dd25-de94-4ca3-84e6-14095953db13@moroto.mountain
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


