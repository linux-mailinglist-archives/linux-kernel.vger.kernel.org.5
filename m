Return-Path: <linux-kernel+bounces-109456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E81F88197B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 23:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 318E8283C60
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 22:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE6286158;
	Wed, 20 Mar 2024 22:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="uAZ8jKkL"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AD117562;
	Wed, 20 Mar 2024 22:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710974113; cv=none; b=kTGxFSNPnfDIGu1WCT5/DtQPQsuTjJZlX5U1HBMkv6ZCwBAGt5A3koGNRPfXUo8f0J33D4I61TT/V6cI/w69y0AyHF9qFhA+ZLEU8nLsdNa/6V8Ai1LUFgSV7wUzomXLzNMyevi41M4dcekswi1vnFs9lAh5DBzHn/SPA+d8ARw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710974113; c=relaxed/simple;
	bh=rQ9ayU8h3vbhmp2fjgE+N6j3VApmNmtzYBgCEM8r62Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QqB6OMyIORn/aqqftkj/iz7rdCY5yM4oVpJasWgWSeFHwyQ5tJCyu8p4dFUNwDlDgl2QAYGUOdmPrJ+SM8Tp09scIhMICqPWlcJI5OKggICDgNr2ypal+UUUe0KUvjWVEjbqTHG+Yi02LFwOVuibISOJ8BuCrJGUTJ86uuemwjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=uAZ8jKkL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=E7i4Ih95/AYaHh8sYn8scPJ9xcj4zGqhtLHoX6z4xCk=; b=uAZ8jKkLhRdROnRWFFtuTTT+y4
	ABPZrO+Senebtu53YCh8jhIGFSGhz50P90JAEtcdvup+f2UPvpsoKkP6IeaSPOkMuwXrLNnFzRF7P
	XwPJEvFao/H5w8AXsF33gfVt34ItfGhJbtKdp2gC4TkCQKOzZ3ltGBJaizeRkp8SHhRs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rn4WO-00Aop5-Rj; Wed, 20 Mar 2024 23:34:56 +0100
Date: Wed, 20 Mar 2024 23:34:56 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: David Thompson <davthompson@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, u.kleine-koenig@pengutronix.de, leon@kernel.org,
	asmaa@nvidia.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v1] mlxbf_gige: stop PHY during open() error paths
Message-ID: <9e21ceae-e889-4177-8397-9df250ba558d@lunn.ch>
References: <20240320193117.3232-1-davthompson@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320193117.3232-1-davthompson@nvidia.com>

On Wed, Mar 20, 2024 at 03:31:17PM -0400, David Thompson wrote:
> The mlxbf_gige_open() routine starts the PHY as part of normal
> initialization.  The mlxbf_gige_open() routine must stop the
> PHY during its error paths.
> 
> Fixes: f92e1869d74e ("Add Mellanox BlueField Gigabit Ethernet driver")
> Signed-off-by: David Thompson <davthompson@nvidia.com>
> Reviewed-by: Asmaa Mnebhi <asmaa@nvidia.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

