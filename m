Return-Path: <linux-kernel+bounces-103673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C980E87C2D4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 19:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6430C1F2147D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B749757E2;
	Thu, 14 Mar 2024 18:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+jUWnHd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB3B1A38FB;
	Thu, 14 Mar 2024 18:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710441297; cv=none; b=ctjqf5udzvARO1t2iCgg82LvhB3uXrzV1+hVc28B2HspZIsDq90EJE0PBXfhzZIemLHdW3MRJcYAce5+Wm5aAXkq5dpKj3bdoPbyjreO9gY9IXpSJNb48YTGKPXkTCkHU91QNC4loGNx5NSy7cmne8+D6FEZOMlaCXeffwR2YUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710441297; c=relaxed/simple;
	bh=/Vt9G3MB7vSqqQzVnMSe8pAnjzC1rvozbwallsCWSnA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZBxNSwI5Mz6pwMxD8gGh4mS/IdnAoWnb08FgYOHBPRzrG2H5F8RSFfN80xqy6VbJHrx6RMLu3BGjR+pD0W9esvTJN/OabTY1T1eydEtuKfsp0WxGwiy3xAigIAZ2YaE5+VRGp1voCz3O4MaRKDVNU4bjl0d5h7KXfpMPypKu8ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+jUWnHd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A675BC433F1;
	Thu, 14 Mar 2024 18:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710441297;
	bh=/Vt9G3MB7vSqqQzVnMSe8pAnjzC1rvozbwallsCWSnA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=a+jUWnHdjSstOKo6slsJbBzqxJg2KgOYE/LzwCAW2IuXyAwhdvx47cUSqsngKZq3m
	 RdvP9biRaZOiTnYAfdIQisCrNjHDVrLWVgv1wkwelsR6sr3Z0uYkf1eXfBCcWz6cDs
	 UAxcE1R0Jk4GCLHj3EZ09u1xvmfbMC/UGNzu826vgCpSY9yVc0OXFgWq8ej0nNPZRH
	 3h34o0IMd4TmrZJbD8Q4cBytN/Dsda9wO06QVg7pk1hhZ2QqkRT28Shj5Zkg2H25j1
	 VVYx2NCdutNwOmdrD/Y1C9pMD5astVeTjJtFS9bfdqn2HOtrD2xpMV+hx1VlLPWbnv
	 MiC7WP6z0ouew==
Date: Thu, 14 Mar 2024 11:34:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mark Cilissen <mark@yotsuba.nl>
Cc: netdev@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Eric
 Dumazet <edumazet@google.com>, Breno Leitao <leitao@debian.org>, Ingo
 Molnar <mingo@redhat.com>, "David S. Miller" <davem@davemloft.net>, Paolo
 Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netpoll: support sending over raw IP interfaces
Message-ID: <20240314113455.152cebc9@kernel.org>
In-Reply-To: <20240313124613.51399-1-mark@yotsuba.nl>
References: <20240313124613.51399-1-mark@yotsuba.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Mar 2024 13:46:13 +0100 Mark Cilissen wrote:
> Currently, netpoll only supports interfaces with an ethernet-compatible
> link layer. Certain interfaces like SLIP do not have a link layer
> on the network interface level at all and expect raw IP packets,
> and could benefit from being supported by netpoll.
> 
> This commit adds support for such interfaces by using the network device's
> `hard_header_len` field as an indication that no link layer is present.
> If that is the case we simply skip adding the ethernet header, causing
> a raw IP packet to be sent over the interface. This has been confirmed
> to add netconsole support to at least SLIP and WireGuard interfaces.

Would be great if this could come with a simple selftest under
tools/testing/selftests/net. Preferably using some simple tunnel
device, rather than wg to limit tooling dependencies ;)

