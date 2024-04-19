Return-Path: <linux-kernel+bounces-150920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 090E78AA6B7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 03:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DE221F220A2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 01:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19FF4436;
	Fri, 19 Apr 2024 01:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OcXbXpwp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2741E10F9;
	Fri, 19 Apr 2024 01:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713491612; cv=none; b=m8U1ec003vaYMXAdBx1lBLVUtJ64T+oIVYnaFXZhL8u4ZdrzSgHwjshUl3+IQf43V+9Dk0SD42PImzkPUkhMH0wbKgSJ21hE46kU4sPNFJ9Q89xS35ZhnWmNzEJCPzunaoQtdUhZfJCbbiPrI6OicVd1MVZqF0KcHNQjDGs0QHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713491612; c=relaxed/simple;
	bh=MYLR6N6n0EJwAup/aFkpHCNwIWRltBcvf8lipAcV6rE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h8v7hKLxJ/szNrFJE67wuvq2KZoY0+oOEPrBc5EabRA13tbcZ0HppKz2iiteOlU7209h+YvVgsl4gv5Q3AU7UzJxFA2BIlizOx7t+5QtBErQf1a/4NbRSBBT/C64zq7KC4tiJ0r1iTW08e3f/h883CpndYc8tipNJw0DocgtzLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OcXbXpwp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E6DC113CC;
	Fri, 19 Apr 2024 01:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713491610;
	bh=MYLR6N6n0EJwAup/aFkpHCNwIWRltBcvf8lipAcV6rE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OcXbXpwpKvxerW53Z/tCPH9JAZLM+UZuGz9QJLb5nbh0UPIy5ufe3FI4XAL6Pl4FZ
	 WXuSTAm7ucsU0TXHaAabT16/e8QUrhifETxAjUDiGDjQ54+W2XBz2fvblElPPLHXoN
	 CUjDig3uIZCZaW2bkFQ2eenzPrvkcQf2LLSkgn3rYYUPtG5Ub7Z/QTnKlFQIQCQvwb
	 GbbKU82r2wqDU4BHv4hTx8Pvj3RLsKhlUW7/IlWTy/rVzYCouALSXw3PLVr6XESiRr
	 5vNtXZp2Q6KEi3u5+/bTVJBMFsjMWi4RFEsx3AwUn0tHQMxpOOPyP+YR42uGAIBX8h
	 dF7rjEiHZDa1A==
Date: Thu, 18 Apr 2024 18:53:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Russell
 King <linux@armlinux.org.uk>, Yanteng Si <siyanteng@loongson.cn>, Romain
 Gantois <romain.gantois@bootlin.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Simon Horman <horms@kernel.org>, Huacai Chen
 <chenhuacai@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/2] net: stmmac: Fix MAC-capabilities
 procedure
Message-ID: <20240418185328.79c38358@kernel.org>
In-Reply-To: <20240417140013.12575-1-fancer.lancer@gmail.com>
References: <20240417140013.12575-1-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Apr 2024 17:00:06 +0300 Serge Semin wrote:
> The series got born as a result of the discussions around the recent
> Yanteng' series adding the Loongson LS7A1000, LS2K1000, LS7A2000, LS2K2000
> MACs support:
> Link: https://lore.kernel.org/netdev/fu3f6uoakylnb6eijllakeu5i4okcyqq7sfafhp5efaocbsrwe@w74xe7gb6x7p
> 
> In particular the Yanteng' patchset needed to implement the Loongson
> MAC-specific constraints applied to the link speed and link duplex mode.
> As a result of the discussion with Russel the next preliminary patch was
> born:
> Link: https://lore.kernel.org/netdev/df31e8bcf74b3b4ddb7ddf5a1c371390f16a2ad5.1712917541.git.siyanteng@loongson.cn
> 
> The patch above was a temporal solution utilized by Yanteng for further
> developments and to move on with the on-going review. This patchset is a
> refactored version of that single patch with formatting required for the
> fixes patches.
> 
> The main part of the series has already been merged in on v1 stage. The
> leftover is the cleanup patches which rename
> stmmac_ops::phylink_get_caps() callback to stmmac_ops::update_caps() and
> move the MAC-capabilities init/re-init to the phylink MAC-capabilities
> getter.

According to the build bot it didn't apply at the time of posting :S
It does apply now but the bot doesn't have a "retry now" button.
Could you repost?
-- 
pw-bot: cr

