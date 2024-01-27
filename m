Return-Path: <linux-kernel+bounces-40960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6C783E8FA
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 02:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29C1C1F27F20
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 01:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69DF9455;
	Sat, 27 Jan 2024 01:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q8aYe+lu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7816138;
	Sat, 27 Jan 2024 01:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706318975; cv=none; b=HFKB1/vcSry5G47onLscjBKChUe2TkH1S538ykTmu4RxOIm3I4sc3vvVVsdT2whei7qtK8m6b3rLQppA83VLgq62VqCXJcxyZoNeWplu2qFOqMOPvNVQGHx5l+CLuzylsF3OGgcjIO6jmAICQugQ0aJrlMb45Ce/r6s7HKFcMWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706318975; c=relaxed/simple;
	bh=ElSoXg1OfPbh1Sqb/lekb9GiMTTdEi7xVmIVe2Apz7k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sLIr4bhn8igVr7UO3nHAxPMmOhw0ZJPjfgFmv2yJX8+45D+oj6mHEavPnscYEnhSsGApmt7Qqpopei35HHulnZDOQHZD0WEiYF6XWQmyMjZICG6NfxI61mBmZpTTw94tStYCQGAHJ9pgTG+1ICxBA0YKyQI0UUCDmH+hGnGstac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q8aYe+lu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C13CAC433F1;
	Sat, 27 Jan 2024 01:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706318974;
	bh=ElSoXg1OfPbh1Sqb/lekb9GiMTTdEi7xVmIVe2Apz7k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q8aYe+luF85eo5Bn6p9MDVNaqJTSmVrMDU8Te+iZh6MoIXtUx7yU/7HibM/qkKlfH
	 fd6nUga4/oX4sogill72uDhMn+aOa+D5dWfofiQmQU59PPkbjP25iYya2+BLXQCY90
	 l7iFMkEL4O6iVt3P7ODMYFwFtWfu5Ei7Ero+ax64ogKtL5k3riLKB/07SjKstSgzX4
	 eyb+PXoy4uNOGr2cQNXxzgON99qtWhKZKegODG4dzMQ8nlnL4mhi6es1kg4NyeTf7H
	 wFUOOaTQxOsUHcx2wCldyt8BZE8pKv+hikjzNv0GfFcEmAHo/bj987iSgVjlTpT6nN
	 zxIP3uzVXfYwg==
Date: Fri, 26 Jan 2024 17:29:32 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Andrew Lunn
 <andrew@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, Jonathan Corbet <corbet@lwn.net>, Marek
 =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>, Piergiorgio Beruto
 <piergiorgio.beruto@gmail.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
 =?UTF-8?B?Tmljb2zDsg==?= Veronese <nicveronese@gmail.com>, Simon Horman
 <horms@kernel.org>
Subject: Re: [PATCH net-next v6 00/13] Introduce PHY listing and
 link_topology tracking
Message-ID: <20240126172932.326f6b03@kernel.org>
In-Reply-To: <20240126183851.2081418-1-maxime.chevallier@bootlin.com>
References: <20240126183851.2081418-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jan 2024 19:38:37 +0100 Maxime Chevallier wrote:
> Most of the changes were from Jakub's and Russell's reviews, the main
> point being a rework of the netlink API, removing uneeded nests and
> cleaning-up the dump code. Thanks's Jakub for all the tips, hopefulle
> the API is cleaner now.

Didn't get a chance to look today, sorry, but it appears to break
allmodconfig build:

ld: net/core/dev.o: in function `free_netdev':
dev.c:(.text+0x76e1): undefined reference to `phy_link_topo_destroy'
ld: net/core/dev.o: in function `alloc_netdev_mqs':
dev.c:(.text+0x79c2): undefined reference to `phy_link_topo_create'

so maybe fix up and post v7?
-- 
pw-bot: cr

