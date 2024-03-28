Return-Path: <linux-kernel+bounces-122992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F1CD8900C3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B0732952DF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6EB8174E;
	Thu, 28 Mar 2024 13:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="juTgpk85"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C85657CD;
	Thu, 28 Mar 2024 13:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711633670; cv=none; b=kSMmvIXti59i7qnX1wTvpq45GlQaD6XFeGUtiaxqs++KdV5+Tg00js5Hb2msHZmUGJR/6BK9mfa+bMREKTsw50vLDHAMVYXPX5NzU8S1mmyGorJunLLJ0gjeVDUzvE1zQ/p3ldqpM3uyWh66F395OztuEd8K7lVJPRfryKtGlOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711633670; c=relaxed/simple;
	bh=oCfld3M/i1/A1YuFzPru35Sn9JFNy40soAlliMX8pSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CRP4uS/PQv3nkO3f1c04mPW7A+3Nqc3WkEZhPaVphqfdaNGY5YpFM9hjs1+A5VCtVFWEkayvCJuJDKw5vLdKj9zwz9zoNY3Zt2HbNvw28yoO/t1o2gYQmqhYdiVWN3btqxl/s9/zIvAyOCPIR3pxn3E+Mvwf77vLc/ZQxul+ae4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=juTgpk85; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9B00C433F1;
	Thu, 28 Mar 2024 13:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711633670;
	bh=oCfld3M/i1/A1YuFzPru35Sn9JFNy40soAlliMX8pSc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=juTgpk85gzBrrE17wHXZgWtvAP/xV1GPLtvm8HEICHUf6H9zl59WVgOYRxGrXwWLy
	 BXw2hNfoM8YhyT24JAE2x65w8u8eNgxIWBQcmCfs2PLHdLUFycsUj8/IYnPxFEX7Vl
	 Nqdpn51Qeu0JUyLGHZQQuKbwGVwTd6bXn+7wcnekV1Yw7QpKIixPtb31GpjumASPWp
	 0vDQa4/5wrq6phoGx1smz8N5BNisFu2vEU7v++3e2bGMgHGT8Q9SWEsKPWPJY6fEpq
	 aaPys6C01MbrstymnWTlywZjCi4cLGXzDbJT+7+X+KmXYt1G5wz7LFpsBLLbPE1OyK
	 wOJO85FqGznEg==
Date: Thu, 28 Mar 2024 13:47:45 +0000
From: Simon Horman <horms@kernel.org>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lukasz Majewski <lukma@denx.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@ew.tq-group.com,
	Michael Krummsdorf <michael.krummsdorf@tq-group.com>
Subject: Re: [PATCH] net: dsa: mv88e6xxx: fix usable ports on 88e6020
Message-ID: <20240328134745.GL403975@kernel.org>
References: <20240326123655.40666-1-matthias.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326123655.40666-1-matthias.schiffer@ew.tq-group.com>

On Tue, Mar 26, 2024 at 01:36:54PM +0100, Matthias Schiffer wrote:
> From: Michael Krummsdorf <michael.krummsdorf@tq-group.com>
> 
> The switch has 4 ports with 2 internal PHYs, but ports are numbered up
> to 6, with ports 0, 1, 5 and 6 being usable.
> 
> Fixes: 71d94a432a15 ("net: dsa: mv88e6xxx: add support for MV88E6020 switch")
> Signed-off-by: Michael Krummsdorf <michael.krummsdorf@tq-group.com>
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>

Reviewed-by: Simon Horman <horms@kernel.org>


