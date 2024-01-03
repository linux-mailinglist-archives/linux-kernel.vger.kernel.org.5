Return-Path: <linux-kernel+bounces-15626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A0F822F12
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 15:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 689F11F23D8B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 14:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A812F1A5A1;
	Wed,  3 Jan 2024 14:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Kofrjrnm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F741A593;
	Wed,  3 Jan 2024 14:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=AsG33UPNYjYCjVVsF0qY80s0GE26xn+JI/RSCas0qdI=; b=Kofrjrnmvk2RLHNCJnjXC/iFyX
	U+oxOjVpJ8MVWuF0Uv0DCO9lH8BHbvzcmEN2EqKeNReOvuPsXS0/zwyH7hr/bcZ2q1+2t/pCTatBM
	Zzbo8ZEu5O1IK1wGpQPprU+rAhWg4IpzXMVFUno0xWaWJG8euRPpUNDkc7xlYTSa+T2tqEealWgWr
	slVgv9J+H5JIJNkYp6OMlG21uNDUnsv3jPLSPZ3ssz2RpgePDWNtGB9XNxYPsOS0ypkurs2VLf/jX
	VTp1udt8Oe9TPYTm+kz3CQHUthFrSZRtPe4qi4F0Js0+8SrZ0W+zCYOc15dMpmZMT2AwEQaaDk8CU
	umBF3lLQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36860)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rL1nM-0007X5-2r;
	Wed, 03 Jan 2024 14:00:32 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rL1nM-0006QC-I6; Wed, 03 Jan 2024 14:00:32 +0000
Date: Wed, 3 Jan 2024 14:00:32 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Yajun Deng <yajun.deng@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew@lunn.ch, olteanv@gmail.com,
	hkallweit1@gmail.com, przemyslaw.kitszel@intel.com,
	kabel@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH net-next v2 0/2] net: phy: Use is_phy_driver() and
 is_phy_device()
Message-ID: <ZZVogCGYu9pIR620@shell.armlinux.org.uk>
References: <20240103025334.541682-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103025334.541682-1-yajun.deng@linux.dev>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Jan 03, 2024 at 10:53:32AM +0800, Yajun Deng wrote:
> There is only one flag that can be set in struct mdio_driver_common and
> mdio_device. We can compare the probe of the driver or the type of the
> device to implement it. Hence, these flags in struct mdio_driver_common
> and mdio_device can be removed.
> 
> Introduce is_phy_driver() and is_phy_device(). Use them test the driver
> or device.

It is not a good idea to post a new series while discussion of the first
is still on-going, even if it has been 24 hours since you last posted a
patch. If discussion is still going on, then we don't need the
distraction of yet another series to duplicate the comments to.

I remain completely unconvinced of the merit of these changes. IMHO,
it is pure churn for churn's sake - there is no _real_ benefit. It
doesn't fix a bug. It doesn't make the code easier to read. It only
satisfies some ideological idea that all drivers should look the same.

Unless a very good justification can be found, I am not in favour of
changing these drivers.

There _may_ be good merit in is_phy_driver() and is_phy_device(), and
as Andrew says, that should be done _first_.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

