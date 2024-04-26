Return-Path: <linux-kernel+bounces-159420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C098B2E66
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 03:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CC0C2837BC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 01:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202471849;
	Fri, 26 Apr 2024 01:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HS608SRp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5238CEDB;
	Fri, 26 Apr 2024 01:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714095899; cv=none; b=ZiX2yHbzOXF8byuX2g2HMMKqkCVGipHfP+W1e1NwH/24oVo6fyTUXjTPFIcnFUn19zd4FTz3hTspRCSORqn2p6sJE3ySVYraZbNi1cGPmSDVMZogbPwj9RJL6UWT69ULwUfhTJ0lSSBKLFWMPOqhcySR+CZmnFbzO660D5mFgy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714095899; c=relaxed/simple;
	bh=IR//jThu/U9egNMuv+6E0sm2QH0SMHzFqU2fqERc3Ns=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E4ZjIUPvw5OUOBwWeamv4ULJKyQLFY/22b4V8wUan95Aiin76q/z9l/f7hOo/8UDn2uBEKbB4/MzH45Bm49k97Y4HVLAYrKP4ycqMwHzT4TU1u6g8/aEOZZ/K2EzfL8DXqJevxDvWT9Jk/bCtBNuPCabYt8c007nBy4t/sfqaoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HS608SRp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C798C113CC;
	Fri, 26 Apr 2024 01:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714095898;
	bh=IR//jThu/U9egNMuv+6E0sm2QH0SMHzFqU2fqERc3Ns=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HS608SRpF65Dg8JQNvLkdHc9olAA3ejT86T1XtNc6DWa3HogO8B2oo0g92GJZWtpz
	 mEP0gViIIkgeB09RmHb1dCu27kvxuqk93ksZqbp1Z3Su4UmUx4Q14QgaHZb5sXY2rH
	 cGZoc2n+DVMLKehA4OteH6p3lBLDznbSCKCkk8rVacjLZ0JrJNOyJXpp39kipLu+zT
	 68RMNqM+PygxXmy59KoYqwg6p40dq64EPlt1a37EwU4nOJNqiYjoiHvzd4DIpRin8E
	 RPuE+4AXWzI49k+NiEVWT9C+byznVsxmIj0RjSwJBufXuUQkA09xK5gtGsSa9Wk4lc
	 27OQBj/TsTzuQ==
Date: Thu, 25 Apr 2024 18:44:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <richardcochran@gmail.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: phy: micrel: Add support for PTP_PF_EXTTS
 for lan8814
Message-ID: <20240425184457.70d4748e@kernel.org>
In-Reply-To: <20240423195732.3353522-1-horatiu.vultur@microchip.com>
References: <20240423195732.3353522-1-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Apr 2024 21:57:32 +0200 Horatiu Vultur wrote:
> Where the configuration was the following:
> ---
> [global]
> ts2phc.pin_index  3
> 
> [eth0]
> ---

You'll have to resend, sorry, the --- lines are "cut-off markers" for
git-am. So your commit message will get mangled. Either replace them or
indent the config sample by a couple of spaces, that does the trick.
-- 
pw-bot: cr

