Return-Path: <linux-kernel+bounces-42807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2C78406FA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 902B91F26F04
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FF7651B5;
	Mon, 29 Jan 2024 13:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wl2qKrAS"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25C867732;
	Mon, 29 Jan 2024 13:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706534967; cv=none; b=Noy0XNvDpI7Gwfsi5POqDtBwuaPJDOAfzOmHFWyPSh58fDJklGu+lJXf4z036a6Ti+uDCWGZp32HKWUrv4Ua5g8ov6PQFQ9monOmsknu5p3kZaCadeaa2DT50f5Qyy3rXOL4gTnMKxDbyEb9X5H3e+I8HsvVs9uLefhKteMv+V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706534967; c=relaxed/simple;
	bh=b1pZyK7FsCUmhPlvju8roc6IUuWpgZNleb3xFjmFVeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NawWaP1De/cfsgGizZnKYLLd7Nz+sY0TSAy3S7MCzwsPquaMaI+fzCf2x6vNclaLsI5+3iUYGiO4tzRgr5xfP28AgSYxOxD7zxIXLN98wnl758VUcd0AqNSe+TLY6O58Gjt/wt5HM8nLbQGr4N1nas1d66wK8k1u6azgZ9LYmUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wl2qKrAS; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=BK3kTu4rO51T+6hQ0GXL+VPtTV0TrbToYj9UeX6NjHI=; b=wl2qKrASfp/BvbBxyEVBLUfG3u
	ykI+KQnWsL+wI8c9s7TpjzZCUrnpfB3ZAUGyH0T/myQ8773F0GoMV100LR7FlWQF3UvVLgTxCDAQp
	xbt2ZG4lQtplPSlSKcLiFVr+62ZNmVg+MBcgXJ1t1HnaHcrcBf7Yq04WaHlyaWgrUdYA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rURhO-006Nix-ME; Mon, 29 Jan 2024 14:29:18 +0100
Date: Mon, 29 Jan 2024 14:29:18 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Andre Werner <andre.werner@systec-electronic.com>
Cc: hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next v4 1/2] net: phy: phy_device: Prevent nullptr
 exceptions on ISR
Message-ID: <57ea16c1-530b-40c9-8f94-973c9595923c@lunn.ch>
References: <20240121201511.8997-1-andre.werner@systec-electronic.com>
 <20240121201511.8997-2-andre.werner@systec-electronic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240121201511.8997-2-andre.werner@systec-electronic.com>

On Sun, Jan 21, 2024 at 08:54:48PM +0100, Andre Werner wrote:
> If phydev->irq is set unconditionally, check
> for valid interrupt handler or fall back to polling mode to prevent
> nullptr exceptions in interrupt service routine.
> 
> Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

