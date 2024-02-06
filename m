Return-Path: <linux-kernel+bounces-55108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4CB84B7D5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B020B1C22784
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014E4132C37;
	Tue,  6 Feb 2024 14:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="b7vrV39A"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901DB132C09;
	Tue,  6 Feb 2024 14:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707229561; cv=none; b=l60z6sr4oDVXCv2HmwJRhdWtpsgj78vKquZT09/0t2jFOLXgZrxKDX0l3N2/ON5tPXrz66QEJdw0RcwPqsHDFKUKdUSroldBGkoCyzyknUEG8xEHVvz98Mv+qnPmpIOozWRXK0fXvXAvn9jWJ1j62TYXnzUGtueKUFUY/IaVFx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707229561; c=relaxed/simple;
	bh=5J1DHXhtJMQ4CbzsyxiP+MOl0UOFuDY+e2LH/+A+T00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=StAGX7qCjC2gx5SierhdhSfmqdqbCySkt7njTfOSIEELTqSPEvpDMMllhLHiqvyPtRzO8pKMPQSoGBHGL/F/BAncZBvDR4sHRY9gPNkvTZJr6q8haq7VZWVSj4Myvo5O84CKlDE69Akty04+I9qowv+xaHWROKRrimI0BwRGoqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=b7vrV39A; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=v9k+wXSjFP1gf2hdsJ6BF7YhNnlmP4KyBwDgOaZfcbI=; b=b7vrV39A71XHo6t/G+sJWupZJm
	Iaveyf5gWkytLfoRXY2yzy15yPlqA9DSPGb72mGmuMsrpJVQOSFtmPKx8LhiPF18kSZY4OHH51UfY
	EwS/sUZpA7wyPzfy4Z1N/rOUhayCf15zB7y6UHnKIqzkMnCAjluSKRxLreZtmgl61rks=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rXMOD-0078nm-UA; Tue, 06 Feb 2024 15:25:33 +0100
Date: Tue, 6 Feb 2024 15:25:33 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ariel Elior <aelior@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH 7/8] net: intel: igb: Use linkmode helpers for EEE
Message-ID: <a476df99-d6f9-43ad-8af1-afc858bcd3a8@lunn.ch>
References: <20240204-keee-u32-cleanup-v1-0-fb6e08329d9a@lunn.ch>
 <20240204-keee-u32-cleanup-v1-7-fb6e08329d9a@lunn.ch>
 <20240206103425.28e64a8f@device-28.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206103425.28e64a8f@device-28.home>

> > -		adv100m_eee = !!(edata->advertised_u32 & ADVERTISE_100_FULL);
> > -		adv1g_eee = !!(edata->advertised_u32 & ADVERTISE_1000_FULL);
> > +		adv100m_eee = linkmode_test_bit(
> > +			ETHTOOL_LINK_MODE_100baseT_Full_BIT,
> > +			edata->advertised);
> > +		adv1g_eee = linkmode_test_bit(
> > +			ETHTOOL_LINK_MODE_100baseT_Full_BIT,
> 
> Probably a typo, I think it should be ETHTOOL_LINK_MODE_1000baseT_Full_BIT
> here :)

Yes, good catch. Thanks.

    Andrew

---
pw-bot: cr

