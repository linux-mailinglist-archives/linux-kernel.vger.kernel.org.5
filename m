Return-Path: <linux-kernel+bounces-62773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A07B085258E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 02:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D36BC1C24231
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFF21CABF;
	Tue, 13 Feb 2024 00:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HkzA0QKa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823131AAD0;
	Tue, 13 Feb 2024 00:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707785426; cv=none; b=Qy2nuu1xd/4O3TomoJvYi3eSYTGOGwRTMmbsNBz7Ka6p5tqNEYOfHNdUVcyY77mQNru89hQVzneYWV1wj77zqn7sd2Cjrlu0yzNr1FD57whr0EjqHRrdVxNdgwRObVgg3TDNe+gbRfNkRrufadHeMs0XSCenufRy1Ef170n1PAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707785426; c=relaxed/simple;
	bh=K/bAxyR0fYoT2pJ02PB4C42YcI+MyTEOXFP3goPA3ek=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LdCleCLSFEL9KVzPATBzxngbxsZ6u/0gQBVH9CPcUYLTi/Xc9/KbEIfH8q6YgrHuW9aKSzAcysVk0/58JkaLtZyssTLjr2p8teJnXwydAy3cCqKsqUqimGQutDOh0R6izrUgkgITcHper1WWmEDlH6Ka2ZyxzUYFYAYBFmSfOt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HkzA0QKa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90370C433F1;
	Tue, 13 Feb 2024 00:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707785426;
	bh=K/bAxyR0fYoT2pJ02PB4C42YcI+MyTEOXFP3goPA3ek=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HkzA0QKaeZ+EdYpb3HzsPRpu5qFBSHjUvz84lNmSLDFA9CwD3px0efE75i3Si2thD
	 OkjbFTN6af8Yr274yssMIw5zcNBH4P7w2qIWJazxvEi2QlZCqtCPF1sAou+LM5wYpm
	 erxDEJtQVQB0/rT3VGnPhE5FNdsQrbeTIOzT+tRdFeuCERe7PKvPGcd8q/EI5C1bEN
	 TrOFuS+BJkiqFog6aq1XdAFxXo9mlzpsntJD7/AjQ7C5iR3H/lMRvsiMFk0VZ0pI4e
	 Qvx6ZD7yfk94HdNiYBjlW5VG+ywBb9nCVqMt/pTocEmobzI9/j7V0gPctD7I/SdhNo
	 mHw7skiVCDnJw==
Date: Mon, 12 Feb 2024 16:50:24 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Daniil Dulov <d.dulov@aladdin.ru>
Cc: Woojung Huh <woojung.huh@microchip.com>, <UNGLinuxDriver@microchip.com>,
 Andrew Lunn <andrew@lunn.ch>, Vivien Didelot <vivien.didelot@gmail.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Alexandre
 Belloni <alexandre.belloni@bootlin.com>, Helmut Grohne
 <helmut.grohne@intenta.de>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: Re: [PATCH 18/18] net: dsa: microchip: Check return value of
 of_get_phy_mode()
Message-ID: <20240212165024.664ac4fe@kernel.org>
In-Reply-To: <20240211150804.3893-1-d.dulov@aladdin.ru>
References: <20240211150804.3893-1-d.dulov@aladdin.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 11 Feb 2024 07:08:04 -0800 Daniil Dulov wrote:
> +				ret = of_get_phy_mode(port,
>  						&dev->ports[port_num].interface);

1) run checkpatch please.
2) we only got patch 18 on netdev, and we don't process partial series.
-- 
pw-bot: cr

