Return-Path: <linux-kernel+bounces-46808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B37844492
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F84A1F2DBEB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6262212CDA4;
	Wed, 31 Jan 2024 16:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="iDNSeBwD"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFF112CDAA;
	Wed, 31 Jan 2024 16:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706718676; cv=none; b=b/71f2ro/pLF6OhCeD6GpdElsx7euTFbeNEEHnRrMCIgq6qFAd6zoe/4jfCORFIFSXB7uMisY1pHM6otP2Qc0dM2lgVlEXOhFyLiTPx9r7NTM/GsLaeIhiPYafnGRT1YZ3CZfoPm33FBCBlTGks+ZZg9TDPHezCxCdbPvIqCeP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706718676; c=relaxed/simple;
	bh=FQk80lx6LBU/vGzS3KvVOXF8bV761X7qqWnO6O3DsnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FVLmJiqMPQ2wkMvpUw4fxuMitboyGFYdRpBqV+o0+ZB1Fsr2IeBYTBVpj8H7zm6aq0uYMJOS7SOkrLyivoyImBiKQ/kmneZ0MP8Mvzfpm+2llrK+Joh7IYNqE66rTohQ/AeXSzD/cOAaR/71evKHDaRROOnsQ4Idli/H1juT6WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=iDNSeBwD; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kjk4r4IOpDJAInBw9oQcvbcWlzWkItt0uplMKw74Lkk=; b=iDNSeBwDEwR6AhvBychY0Uo9zA
	TxBMH/wwrLaFa4WAqlJqrZox7kraISilV/Ol53k3JphW0L+kDp/u8iL+b0WRn0q8eManrxukhJF6j
	NITQzNf15WeVSKljl8V3bH8TDNe5+1glCwUt77XqK2iowopWnMPQ/FMXUPVOYXjkiovk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rVDU8-006bAp-Tk; Wed, 31 Jan 2024 17:30:48 +0100
Date: Wed, 31 Jan 2024 17:30:48 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Danielle Ratson <danieller@nvidia.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"sdf@google.com" <sdf@google.com>,
	"kory.maincent@bootlin.com" <kory.maincent@bootlin.com>,
	"maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
	"vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>,
	"przemyslaw.kitszel@intel.com" <przemyslaw.kitszel@intel.com>,
	"ahmed.zaki@intel.com" <ahmed.zaki@intel.com>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>,
	"shayagr@amazon.com" <shayagr@amazon.com>,
	"paul.greenwalt@intel.com" <paul.greenwalt@intel.com>,
	"jiri@resnulli.us" <jiri@resnulli.us>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	mlxsw <mlxsw@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>
Subject: Re: [RFC PATCH net-next 9/9] ethtool: Add ability to flash
 transceiver modules' firmware
Message-ID: <7039bd68-d972-46f6-8d8d-5388d9cff109@lunn.ch>
References: <20240122084530.32451-1-danieller@nvidia.com>
 <20240122084530.32451-10-danieller@nvidia.com>
 <5bf6b526-02c4-4940-b8ec-bf858f9d4a58@lunn.ch>
 <DM6PR12MB45161C82F43B67AD8EDB950BD87C2@DM6PR12MB4516.namprd12.prod.outlook.com>
 <DM6PR12MB4516BC80DBF383A186707F19D87C2@DM6PR12MB4516.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR12MB4516BC80DBF383A186707F19D87C2@DM6PR12MB4516.namprd12.prod.outlook.com>

> > > How big are these firmware blobs?
> > >
> 
> The largest file I came across is 400K.

https://hack-gpon.org/ont-fs-com-gpon-onu-stick-with-mac/

Suggests that some GPON devices have 16MB of flash. Ideally we don't
want to map a 16MB firmware image into the kernel address space. A
high end switch could do it, but a typical OpenWRT 'cable modem' is
likely to have trouble.

     Andrew

