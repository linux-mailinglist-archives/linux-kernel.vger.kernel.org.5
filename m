Return-Path: <linux-kernel+bounces-103922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A11387C695
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 00:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CB6A1F216B9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 23:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24D3125C9;
	Thu, 14 Mar 2024 23:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gcHAZhzR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14680FC02;
	Thu, 14 Mar 2024 23:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710460108; cv=none; b=Bu5NOc+P/TCE7IFB9HsWZSTFv1kdkCrtHwdXBoH1JylSpIasgnHWw0id/pn62H4I6Tb/zg7bmKu6tnhubSAla/ljJzEgY4+KRs8kzPLMHki6ufCc0sSdQSUH/vQXdQwDzXiqMOck/ic7MciKbnxEDBMTEyJgG7wo8fhtFhScQNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710460108; c=relaxed/simple;
	bh=5hBfl7rp5xpyFDv/cfYVaSlK2zQRJq4wKIsO53dJ7tI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gABXUvJw3Q8NTbxwoWQXIRnlnXp3v8c+gzW79kR753PnAMKoMdb+vflz6bCMYN9qjzt23M8jII0vvawvyR5qm2OkErsO2Y1EB/4srLNrNrWZmKsO6gQp53X6kd37KTpJbh5Wmes9I0S7PssqsDIM9rmwujU9PATcF/5F9lt7znY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gcHAZhzR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E9FCC43390;
	Thu, 14 Mar 2024 23:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710460107;
	bh=5hBfl7rp5xpyFDv/cfYVaSlK2zQRJq4wKIsO53dJ7tI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gcHAZhzRO3WLjK06BBhvdYkEU55HOM07N7Z54T8yrDgl2qRZ7EWusm2wcqfR6KFzB
	 ic7I8wiIBr1WHnPfTV/567CvFmIgKyjSOsbUY6zsc3ZiWFDuqMMbzMoF3yPN+NARLH
	 epD+iK5mxncgoZp2i3QkykpUKjwy3SG89/FGcWsbgzqclw2c3bfF8PBnZpk0o05vz6
	 WMbJNJ2Wz3uN054THrlW4IJ4lN0ZEyIy9lcnWtfEYnjj+xNRRotxyMQ29LDb1LtBl7
	 nPfiZyHtbDubQntaJuHzceZtOrIanFP76q32VjZVI//QkkfN0WwW1roUz9Z27eSKrF
	 pmVuribwbC27A==
Date: Thu, 14 Mar 2024 16:48:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nikita Kiryushin <kiryushin@ancud.ru>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
Subject: Re: [PATCH net] net: phy: fix phy_read_poll_timeout argument type
 in genphy_loopback
Message-ID: <20240314164826.161bd398@kernel.org>
In-Reply-To: <031a0fe6-79dc-464b-b8d9-946f75971378@ancud.ru>
References: <031a0fe6-79dc-464b-b8d9-946f75971378@ancud.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Mar 2024 14:15:37 +0300 Nikita Kiryushin wrote:
> read_poll_timeout inside phy_read_poll_timeout can set val negative
> in some cases (for example, __mdiobus_read inside phy_read can return
> -EOPNOTSUPP).
> 
> Supposedly, commit 4ec732951702 ("net: phylib: fix phy_read*_poll_timeout()")
> should fix problems with wrong-signed vals, but I do not see how
> as val is sent to phy_read as is and __val = phy_read (not val)
> is checked for sign.
> 
> Change val type for signed to allow better error handling as done in other
> phy_read_poll_timeout callers. This will not fix any error handling
> by itself, but allows, for example, to modify cond with appropriate
> sign check or check resulting val separately.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 014068dcb5b1 ("net: phy: genphy_loopback: add link speed configuration")
> Signed-off-by: Nikita Kiryushin <kiryushin@ancud.ru>

Please use git send email, the patch is mangled.
-- 
pw-bot: cr

