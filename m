Return-Path: <linux-kernel+bounces-97756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A81D4876F02
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 04:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2BAD1F2196F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 03:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FEA36124;
	Sat,  9 Mar 2024 03:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s6mxlKcE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A3236123;
	Sat,  9 Mar 2024 03:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709956341; cv=none; b=SxH/ywdTHPdDj4R1BU401s+X79B7vwUDbMoJFbewQPnFAVMIooWEBQyBAo838EdxG0500z1Hew77fycOpWcx85emPZL7Dmau0Hi8B7BPJXDT4ofpKlR4X3tbUcn8xH8kjmKo3xZQq1ttprCl1aSDkBrIOXTyJSY/Y3FRYrLXIMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709956341; c=relaxed/simple;
	bh=+qc/HwE+N2E+pOqZ+dIKfsDstUXZTyieQyJAXxKhKgs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eGBpb4dRsHC6NOZzysWBJd5+5ge3l9vPNrYe5+a7oE0Z2KqOuee43KymXtMDdILvAyzP5nbULsbfB0+rwEU1udX3FGElB0ALyDZ0/ehSmZytYh37XUTaxShwjxp6JKcenD0BzPhsXDiXMkyW5wpeGEdWfC+cyR/LV14MCgKj+Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s6mxlKcE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A46F4C433F1;
	Sat,  9 Mar 2024 03:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709956341;
	bh=+qc/HwE+N2E+pOqZ+dIKfsDstUXZTyieQyJAXxKhKgs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s6mxlKcEO3RUzgQZWn0RN/W6UcxtHg30CUOClNGr73QMj1WK37AvChQRr34XZDDaK
	 qk7Oy4qCiKr8aRUlJNhN5vTMuY2eoVxluC0CBDfXUc/Z9e3ZcjTzeZ/ny1hVIblpar
	 KEU4z7xWkGQFBim7gvte625k1YRTKuNexRw+Ef1/mTyFR6kYGAR0Edsjh83qLCmz9k
	 faPux9L1XnDEOi0FmcF5VwmVWtI91w1ahyoa87u66UT3B+icAWndEnYac5RqvJ4b9H
	 wCn0rYkDbEi1Y0rUBjDbgolrPueD4IGciIHfQ9xfWAqr3gn72DLImByxpNQDV7DBw/
	 L3uEhl0WzJjRw==
Date: Fri, 8 Mar 2024 19:52:19 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Daniil Dulov <d.dulov@aladdin.ru>, Doug Berger <opendmb@gmail.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
Subject: Re: [PATCH] net: phy: mdio-bcm-unimac: Cast denominator to unsigned
 long to avoid overflow
Message-ID: <20240308195219.542550eb@kernel.org>
In-Reply-To: <5592aeca-608f-4817-8848-99deb2815ddc@broadcom.com>
References: <20240307131947.13133-1-d.dulov@aladdin.ru>
	<5592aeca-608f-4817-8848-99deb2815ddc@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 7 Mar 2024 12:21:26 -0800 Florian Fainelli wrote:
> On 3/7/2024 5:19 AM, Daniil Dulov wrote:
> > The expression priv->clk_freq * 2 can lead to overflow that will cause
> > a division by zero. So, let's cast it to unsigned long to avoid it.  
> 
> It will not in real life because the maximum clock frequency is 250MHz, 
> but it also does not hurt.

If that's the case - Daniil, could you respin against net-next without
the Fixes tag? Otherwise it'll cause a conflict, if it's not a real
issue no point creating an extra hassle.
-- 
pw-bot: cr

