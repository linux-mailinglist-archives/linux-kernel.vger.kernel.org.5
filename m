Return-Path: <linux-kernel+bounces-117839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B2088B04C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 333F61FA4E1D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52A845BE1;
	Mon, 25 Mar 2024 19:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Wr/mJECD"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F474E1A2;
	Mon, 25 Mar 2024 19:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711395680; cv=none; b=RbFsdIoWzyW88gPe8qn0nW5DXYRF8DNxfozKASlocRILOjeEVZDEsqBmQMGjiNUDqyvSwYmBPm6hZI6vgBySIbtnvrvhYg4IrOYpLEuZUHyZdfPrgvUwLgToAaIamDxurA3D1cFba9fESL2wVrZGTy1OgMOR6I8qvgddqnTL6t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711395680; c=relaxed/simple;
	bh=3xnZx4O3dbcAf+Y7O5EM0rkpFufFse3NgrQVMqIYK90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LbnYjy5UQt4uiq/kPjv7hRrNSWa6eiWfarefHWWWmIMjJBPWR4Y3GHqbWkaBa9fxQZQi/AqWqwg938xKhNeGFuXjh0nUT7bXpWdJ6g8JBstdE5Ckf5JZagRqu1wLdMOkbeJVXHGd+VyIxu7VVa4+4ynzi38LcabnYRQW9bJ4uCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Wr/mJECD; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ib7GsXJL2hwjOEEuaNYmsfMXqAJ+kFKKW9Qz5HRmhc8=; b=Wr/mJECDMriqE1iWmGeyTFQbAo
	rvKuQ545xY7dKNCtNQmC+5TBM/O8Rbg6xWUY7oypmsUuoQkcOUSohqcz9BIpC7sOPrBQEYOFKH/iU
	uSWVsiY22Cjk0qNs9mZULIHVy7ox/XRNxYy86SRwBdb7bGMJ8+NzzkVZNZqalfhsF/TI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1roqBf-00BC1C-AC; Mon, 25 Mar 2024 20:40:51 +0100
Date: Mon, 25 Mar 2024 20:40:51 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	William Wortel <wwortel@dorpstraat.com>, stable@vger.kernel.org
Subject: Re: [net PATCH] net: phy: qcom: at803x: fix kernel panic with
 at8031_probe
Message-ID: <28af27cd-52a5-443c-86a9-60c0699bc0ef@lunn.ch>
References: <20240325190621.2665-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325190621.2665-1-ansuelsmth@gmail.com>

On Mon, Mar 25, 2024 at 08:06:19PM +0100, Christian Marangi wrote:
> On reworking and splitting the at803x driver, in splitting function of
> at803x PHYs it was added a NULL dereference bug where priv is referenced
> before it's actually allocated and then is tried to write to for the
> is_1000basex and is_fiber variables in the case of at8031, writing on
> the wrong address.
> 
> Fix this by correctly setting priv local variable only after
> at803x_probe is called and actually allocates priv in the phydev struct.
> 
> Reported-by: William Wortel <wwortel@dorpstraat.com>
> Cc: <stable@vger.kernel.org>
> Fixes: 25d2ba94005f ("net: phy: at803x: move specific at8031 probe mode check to dedicated probe")
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

