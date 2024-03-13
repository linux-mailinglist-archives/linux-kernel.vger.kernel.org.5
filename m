Return-Path: <linux-kernel+bounces-102452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACE087B24A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 365EB28A62A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD284C60C;
	Wed, 13 Mar 2024 19:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Wteln205"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333FB50243;
	Wed, 13 Mar 2024 19:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710359533; cv=none; b=ocodyFSPJgsoQ7gYZPsQm+azqSyQGV4h/tDZlQ+dBtwkrzdaDj9QoRCS9VUl1znT/eWH3Y/sDoVr9RvG08SevMgQ8EA1WGvG+t09ObmwkpGZg10LG2oKQKCd/ZP2ZKrzb0+wdk++CRhvRMiIcj3wje3KEy/Nh8okn4WbqS1FIXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710359533; c=relaxed/simple;
	bh=2ZkDECGgCzxUfGsarTHx62/lL7Cs0OVqL8S2PP9gs3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OTcDIRFdbx26PCmKyPDhimGqbZEJhG3dPWtpJ1aECy9ZRIVGQfT0WdCdu/bW89X56SKFcfL3w4Ov8ctxgdXLezBr0AloujAOTFDYx4YIW01xfuVBSY4AuiGlFfsLsV+mGMpCQVxWlQrcpvneaffEORawdmKEfgRFRY2ZJqks5hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Wteln205; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KjmiZg3EAJQ/7RoTwqomd7rnaA5S0FajGsdfSKsK+LI=; b=Wteln2055cbwnePEQiiE5RkPGW
	BGbP4EIngHKXaoxI2XDXI/AfSmQx6qs8O616KuIqy8gKlkHGUB7U8r9PjGauF/bwK7+Fi+ukaC55R
	eezoS5aL2c+RFePjdDoM/a1oqCKjeQiXyVZa6WMazXaSNOR6CxBp+D9BxsP5NipvgLhg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rkUeY-00AGIU-0m; Wed, 13 Mar 2024 20:52:42 +0100
Date: Wed, 13 Mar 2024 20:52:42 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Ronnie.Kunin@microchip.com, Raju.Lakkaraju@microchip.com,
	netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	linux-kernel@vger.kernel.org, Bryan.Whitehead@microchip.com,
	richardcochran@gmail.com, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net 3/3] net: lan743x: Address problems with wake option
 flags configuration sequences
Message-ID: <725e8182-50de-4469-9f87-fa58179f8922@lunn.ch>
References: <20240226080934.46003-1-Raju.Lakkaraju@microchip.com>
 <20240226080934.46003-4-Raju.Lakkaraju@microchip.com>
 <78d7e538-9fa0-490e-bcfb-0a5943ad80c9@lunn.ch>
 <LV8PR11MB87008454A629EE15B9CE14099F272@LV8PR11MB8700.namprd11.prod.outlook.com>
 <PH8PR11MB79656DCF7806D7390C7100DE95272@PH8PR11MB7965.namprd11.prod.outlook.com>
 <fd22d022-cad4-489c-9861-36765dd98a87@lunn.ch>
 <PH8PR11MB79655416A331370D3496854A952A2@PH8PR11MB7965.namprd11.prod.outlook.com>
 <3e84e1c9-f680-47fa-aa59-615ce57b65da@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e84e1c9-f680-47fa-aa59-615ce57b65da@gmail.com>

So i think we need to agree on best practices for new drivers and
document what that is, probably in both the ethtool man page and
include/uapi/linux/ethtool.h

* WAKE_MAGIC on its own is O.K.
* WAKE_MAGICSECURE without WAKE_MAGIC is invalid. -EINVAL
* WAKE_MAGIC + WAKE_MAGICSECURE means only secure magic WoL.
* Each driver needs to enforce this, due to backwards compatibility.
  Some may decide not to.

Can we agree on this?

    Andrew


