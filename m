Return-Path: <linux-kernel+bounces-94702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AB08743C3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 00:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2956D1F28AE0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 23:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F451C6BE;
	Wed,  6 Mar 2024 23:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="53qhwLSb"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3505D1C684;
	Wed,  6 Mar 2024 23:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709767146; cv=none; b=kEXoSAHILUI+CLgHqaJb0CqnvKAwIAFpii0zJShT3/yNRMWrpYlVed/HbcA1/tHrh8sfYb7l6oQmmMhbfcztKNkT1y0RgGhe5DdjnO2c1lZQUdP6L9YGG9YOc2UTDJJCNIVnwcTk7GFYg3QN5O2t6MtWArR2iHp//cE2rVD2JHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709767146; c=relaxed/simple;
	bh=upHSE3Z4rIUmGGYbuJAUrYzQRj2maCqMzegqvGENBnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kyz8pVn0zNP1KQO+lTQW7pMJn2tJ2fz+4O64kJzkaH3hd+MAqoMmEdeVK/zTeExDGFeseC9pKRa7KJlijUHw9N6yF5LBGxRvj8hZ0BpuX6elq3Ei8OzLG8nPov0OubRKAt1XJC3dGQegWTt2TcA356ps/FQhqNk5O83XDI/HRbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=53qhwLSb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ernnd5D8e8Iwl4Vz0vO6Y7+VleA1yRKjoKPp5Py+iFI=; b=53qhwLSb1zUc/8R0W4UHfrSKK3
	7G9/u2/UnQI8pygFg3oaN6A/0O6KG+fkPnMY1eNB9vyAXm8RqNJ7+GHQnAgZy2EHfTP1xQndXLthW
	MRbcETkYH6YZTqZXa2e4FBzJgMlx0KIoBWmvdeAfdJRV9KIOGJkJyhDjmghfRLj5/UN4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ri0Xp-009XNj-26; Thu, 07 Mar 2024 00:19:29 +0100
Date: Thu, 7 Mar 2024 00:19:29 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Raju.Lakkaraju@microchip.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	linux-kernel@vger.kernel.org, Bryan.Whitehead@microchip.com,
	richardcochran@gmail.com, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net 3/3] net: lan743x: Address problems with wake option
 flags configuration sequences
Message-ID: <70b01df1-d651-4f6b-a7fc-8e16c18c6e32@lunn.ch>
References: <20240226080934.46003-1-Raju.Lakkaraju@microchip.com>
 <20240226080934.46003-4-Raju.Lakkaraju@microchip.com>
 <b83b74b7-3221-4747-8b71-17738c18c042@lunn.ch>
 <LV8PR11MB8700C2F9461F4200431446D49F5F2@LV8PR11MB8700.namprd11.prod.outlook.com>
 <e038ec4e-c54d-4628-8997-90510c0d96ab@lunn.ch>
 <LV8PR11MB8700FC048AB32D6E7168855E9F5E2@LV8PR11MB8700.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <LV8PR11MB8700FC048AB32D6E7168855E9F5E2@LV8PR11MB8700.namprd11.prod.outlook.com>

> I'm not able to find  any more "ethtool" documentations other than ethtool man page.
> 
> I have gone through the ethtool application code.
> (git://git.kernel.org/pub/scm/network/ethtool/ethtool.git) and check the WOL options.
> 
> In ioctl method (Not netlink), do_sset( ) function, before set the parameters, first get the WOL configuration.
> (i.e. in ethtool.c file, Line no. 3294)
> 
> Then, assign/overwrite WOL wanted config to wolopts parameter.

Thanks for documenting all this. So it does seem like wol options
overwrite, rather than add incrementally. So i would say the correct
'fix' here is to document that in the man page, because at the moment
it is not clear what should happen.

Now i need to go back and look at what your original issue was...

	Andrew

