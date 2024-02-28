Return-Path: <linux-kernel+bounces-85259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CF886B31D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49C661C26087
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1D315B99D;
	Wed, 28 Feb 2024 15:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PVxFofiZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E21C612FC;
	Wed, 28 Feb 2024 15:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709133957; cv=none; b=Yv2emJ1GNr6vHeIE556e0WIm1UMyz3txoaM5AeoZKr2yaXyjVdBo7S/GRTH0OxnMkUQKYx4AykLNsrD+ZnnbFVMNTHKy1gOAa7tJgKFjg6QByzBuys5jzpQBXKiVPqXTf8nJuwYT8yTZOlQ1wpg6DkXj4UsIX1lI/8ZslcJdlKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709133957; c=relaxed/simple;
	bh=zRhL6sA95yD5HfEybdKfbjQx6fTtohacYCQNOXDFAKI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k1ATUx6zRjREY3HvSo/Kon/nTOeMBDEkL0e8BKe7TZIfQG0YLwCMBCS9RMbGIR/qSpBYldbJMZjF03rb6+a9AOTK3Gg8BDfAZoyGphlevQA8apwPNJ4AmJPgvxqPYztVW2Lq31WmtQe8FmIOtI8c8aZVQB05A+Q1OzxHORxbt5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PVxFofiZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 774A9C433C7;
	Wed, 28 Feb 2024 15:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709133956;
	bh=zRhL6sA95yD5HfEybdKfbjQx6fTtohacYCQNOXDFAKI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PVxFofiZQhAAlusqbPKfLm+8kUCeKQH8L+YN4JiakSg/Y1tGk4WxBRClGRfSjC7yF
	 3n74IYopcNXHL+OzlB8+oRGczB5/9vtbSCVrHssIxiGnVm5WwQX7Oqtgnrc8k5F/L1
	 q8kB4LlRNzzwp/BfVzgIzv0N+NYn3tnZiW7/Ql3lsfz2dDsrgZocRDCMySEVoQvvcP
	 jlYiT3cMoQrHofdSPms3BbZjUNVyDvglcGYU5ckvMEpn/ch/7FxdRPP4kyrll3IEPB
	 rGICnDD2k/MuI+ZFhczwPN2aMalyADk33gUyTZlH+wqMfea7o1Fepu61XlkDD4n8Mt
	 0W03SwNydpIAg==
Date: Wed, 28 Feb 2024 07:25:55 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Breno Leitao
 <leitao@debian.org>, Arnd Bergmann <arnd@arndb.de>, Roger Quadros
 <rogerq@kernel.org>, Siddharth Vadapalli <s-vadapalli@ti.com>, Grygorii
 Strashko <grygorii.strashko@ti.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: ti: am65-cpsw-qos: fix non-bql configs
Message-ID: <20240228072555.428e0312@kernel.org>
In-Reply-To: <20240228140413.1862310-1-arnd@kernel.org>
References: <20240228140413.1862310-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Feb 2024 15:03:10 +0100 Arnd Bergmann wrote:
> +#ifdef CONFIG_BQL
>  		   dql_avail(&netif_txq->dql),
> +#else
> +		   0,
> +#endif

Same exact code exists in qdisc_avail_bulklimit()
How about we add static inline in netdevice.h wrapping
this, like we do for other BQL related functionality?
(taking in txq as the argument)

