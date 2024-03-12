Return-Path: <linux-kernel+bounces-100814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9BA879D91
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87EED1C21921
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 21:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68C614374E;
	Tue, 12 Mar 2024 21:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Tr2/bmlG"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3AB13B2BF;
	Tue, 12 Mar 2024 21:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710279612; cv=none; b=skk0tSoUnwwbXQt3FQhJIej53kRBs/XCqd6qXtZ/F76s0IGvRJ1bfkIL6ohBkToHaw6xoBCpYmIiJADa+1FMTGPjTCg+zkVJCLMehfmNGf3qHazE+4qHlzWXjyUGY+wfm1PGHOITmcyvPFw8LLdrvFc4APb7nh2prpK0ikcrVtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710279612; c=relaxed/simple;
	bh=+80JYJzoe18PwUCOYAW7gnfaLZghFUWOhMTo6ihGcoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hpjP0x49XVSMcYTlnw48EjGcrNyr7S1yZVqwCjcBlxDuBHgT6xOuqcATsADzEulBTA7kA2jRxxyDZYorTD7BfsuAa73UtKjiT0FqpuTGROridplL5HErGeCTSqEvtn2b0tuzrf2JTF2FD4ZDLSacwxRHZyvRug6FD7veQEOEJyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Tr2/bmlG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=pB0npZBb02/Y7AXQyoSQVHyq17wriRhZ0GXXdXTPYXU=; b=Tr2/bmlGtLutH42IYRuYmfOZZy
	+nc0B3WD8q8J/rMNBisjeLQBjUFU3EHvIDDJwrYYMqCXgvMJqQ4gZr6ElT321sVZyoq4gZBBEqW4i
	RQa97YJ1CdlThAjWpELSF7yt9vE6NtS1pxwKZ2YAnXXVRIXeDGMhc1GjJk+WtjqBLoIk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rk9rT-00A570-D4; Tue, 12 Mar 2024 22:40:39 +0100
Date: Tue, 12 Mar 2024 22:40:39 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ronnie.Kunin@microchip.com
Cc: Raju.Lakkaraju@microchip.com, netdev@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org,
	Bryan.Whitehead@microchip.com, richardcochran@gmail.com,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net 3/3] net: lan743x: Address problems with wake option
 flags configuration sequences
Message-ID: <fd22d022-cad4-489c-9861-36765dd98a87@lunn.ch>
References: <20240226080934.46003-1-Raju.Lakkaraju@microchip.com>
 <20240226080934.46003-4-Raju.Lakkaraju@microchip.com>
 <78d7e538-9fa0-490e-bcfb-0a5943ad80c9@lunn.ch>
 <LV8PR11MB87008454A629EE15B9CE14099F272@LV8PR11MB8700.namprd11.prod.outlook.com>
 <PH8PR11MB79656DCF7806D7390C7100DE95272@PH8PR11MB7965.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH8PR11MB79656DCF7806D7390C7100DE95272@PH8PR11MB7965.namprd11.prod.outlook.com>

> I understand that the TI devices give the *impression* of supporting
> both, but based on what I explained above, even if you accept
> WAKE_MAGIC and WAKE_MAGICSEGURE on a set and report them both back
> as enabled on a get; whatever behavior your hardware does will not
> be fully compliant to both specs simultaneously anyway. I discussed
> this with Raju and what we decided to do for our driver/device is
> that if you pass both WAKE_MAGIC and WAKE_MAGICSEGURE flags to us we
> will report them back as both being enabled in a subsequent get as
> you suggested, but the behavior of our driver/hardware will be as if
> you had only enabled WAKE_MAGIC.

So i agree having WAKE_MAGIC and WAKE_MAGICSECURE at the same time
seems very odd. So i see no real problem limiting the driver to only
one or the other. However, if the user does ask for both, i would say
silently ignoring one is incorrect. You should return -EOPNOTUPP to
make it clear you don't support both at the same time.

I would also say that silently ignore the Secure version is probably
the worst choice. Things should be secure by default...

     Andrew

