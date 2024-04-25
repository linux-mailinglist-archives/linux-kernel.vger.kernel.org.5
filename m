Return-Path: <linux-kernel+bounces-158671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 156878B23AA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C291E288917
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3401814A4EE;
	Thu, 25 Apr 2024 14:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="PY+5C0qn"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A6214A09A;
	Thu, 25 Apr 2024 14:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714054416; cv=none; b=qJPLMM8HrgSWl3PaAVEU/CRjQ9Y2qh8WG0ksritMaQGvuirUNo8pvTw5dI3jikHEyXoOHIGOgXwaEe6+ZT+9UVAUDqtk5tVcMAzztDdaYdOr+JOsz40NkrvJf0bMn6N77WEAVH+mpw+HnYazYXCoHZt4R5ZPHLsL2Dmn5ZQIj84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714054416; c=relaxed/simple;
	bh=vnMkoliidnUgjWCP/KC7GNCTd2r4EQjwYmsuFjvucw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NtCoS19L2JMjmcw+Kd8lwo0hBJF79JnaThhmL+DqFTjlMnrLgD71eXhoLMy2KkthnQHa2pcz611K1JzWHLZbq84YOuVf+bD+ml3ExhLRs9y0vWcfEN+tTnij8bwdzAfGj5crV4+28HVE2qEy0XL5mNPQMRMc5wMvB4Gf0WP3qQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=PY+5C0qn; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=EdGAMsXDk5Z9irIqk6ZPajxgCEsTnc0pm/mZs2Sxzu8=; b=PY+5C0qnxpEuwhbKn2GR7rM+R8
	6YnNaBVgt9UWSO43a7wyfqOGHbUf1zNLI86T7OeIl4D7Djf7H0BEWZaBes+fArDb//mPb9hD4VekJ
	08PeYEJwR4YA0xZ1VNH6CRbE/82ew2FjYeJvemg8QE8BPAXe7nvbDg3S49kI2yftQ3i0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rzzqk-00DzXE-V9; Thu, 25 Apr 2024 16:13:22 +0200
Date: Thu, 25 Apr 2024 16:13:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Raju.Lakkaraju@microchip.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com,
	linux-kernel@vger.kernel.org, Bryan.Whitehead@microchip.com,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net V2 2/2] net: lan743x: support WOL in MAC even when
 PHY does not
Message-ID: <38718a9b-bc7b-45d1-b15e-f4fea628db3d@lunn.ch>
References: <20240320042107.903051-1-Raju.Lakkaraju@microchip.com>
 <20240320042107.903051-3-Raju.Lakkaraju@microchip.com>
 <22089299-a3e2-4cbd-942a-65ea070657b8@lunn.ch>
 <LV8PR11MB87003ABBCA98F00F3EEA9AB09F032@LV8PR11MB8700.namprd11.prod.outlook.com>
 <fb5a6f19-ae4c-443e-babb-cbbcf6ba5fc6@lunn.ch>
 <LV8PR11MB8700A34520EA2521BC5F59EF9F112@LV8PR11MB8700.namprd11.prod.outlook.com>
 <9c4f8fcd-ae95-4874-b829-d381928c5f13@lunn.ch>
 <LV8PR11MB8700D54F5E03440681BF0D449F172@LV8PR11MB8700.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <LV8PR11MB8700D54F5E03440681BF0D449F172@LV8PR11MB8700.namprd11.prod.outlook.com>

> If PHY handles the magic packet or phy activity (i.e. WAKE_MAGIC or WAKE_PHY), our PCI11x1x's MAC will handle only interrupt (MDINT from PHY). Not MAC's magic packet.
> In this case do we really call phy_speed_down( ) ?

phy_speed_down() is orthogonal to who does the wake. Packets are
packets. phy_speed_down() does not change that. All it does it drop
the link to a slower speed. And slower speed means less power
consumption. A PHY operating at 10Mbps uses about 1W less power than a
PHY operating at 1G. The numbers will depend on the PHY, but you get
the idea. Plus the link peer will also save a similar amount out
power....

If the MAC is needed for WoL, because the PHY does not support the
needed modes, you probably also save power with the MAC running at
10Mbps. Its clocks probably tick slower, etc.

But there is a trade off. When resuming, you want to go back to the
full speed link. And that takes time, a little over 1 second. So you
need to decide, do you want to prioritise minimum power consumption
when suspended, or fast resume?

     Andrew

