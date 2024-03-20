Return-Path: <linux-kernel+bounces-109477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A148819BB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 23:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34AF3B250CA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 22:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D0F86134;
	Wed, 20 Mar 2024 22:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="JIY3LCEt"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50DF85C6C;
	Wed, 20 Mar 2024 22:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710975507; cv=none; b=Ow3PE5FyslolZ49qU5MsNB0vXdiObjbxGXX37QebmKa1k2iHrdNQl5qnu8RFuOFmO0tFiifdG3aF03cs5BCNfw0dh8fYzyfm2K/zhRIKtyJ4p6tDViaEo8nn3TszrNZ58CaSQ9+eHZjGMmpW4m+IBzvFMtzHkDUjGrsyYOr0eqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710975507; c=relaxed/simple;
	bh=yxbUKjR/eQ+A4TDHgpThQwIVWkZZpAq34ngZ7oYpkAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EzkgQRAWhNJerfKyjbuvxHrjCBVJ8JbpiMOJrjrHSw+BftxyAl0Cx/jwMImyKVrYc7kvI2DA0WtZ52pMyaACZ43CmvcKvyuhHESzo5a6BSdOb63qxbOVjSc75oW8cZyEMsJuqYRTX7wni8p/3sgJ4x8O+CRU+EQ/yPDc4UB9P30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=JIY3LCEt; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=13ghe/Dcccxys0JDUXSMtaJE6mxH8x5jhjb9llYFpQ0=; b=JIY3LCEtex2FFYR6+ZBGIDiPy/
	A6RA+5Cr8x6nVJ3eM+rLlJ0SiKV3IUDeOWsJp7VQVd050LKeI6Jjn6ZUJaPIFDk23BFoEXLsjiLa/
	75rGtVicd8Z2/sE4uNqdlcUfv8VslqHlP4RxirFhJKMr6CIxVJG2YUbc78qxFJyZP1W4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rn4st-00AotP-Vv; Wed, 20 Mar 2024 23:58:11 +0100
Date: Wed, 20 Mar 2024 23:58:11 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Elad Nachman <enachman@marvell.com>
Cc: taras.chornyi@plvision.eu, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, kory.maincent@bootlin.com,
	thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com,
	przemyslaw.kitszel@intel.com, dkirjanov@suse.de,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] net: marvell: prestera: fix driver reload
Message-ID: <d02e6c38-042f-416e-b5c8-96dc55e1fd5f@lunn.ch>
References: <20240320172008.2989693-1-enachman@marvell.com>
 <20240320172008.2989693-2-enachman@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320172008.2989693-2-enachman@marvell.com>

On Wed, Mar 20, 2024 at 07:20:04PM +0200, Elad Nachman wrote:
> From: Elad Nachman <enachman@marvell.com>
> 
> Driver rmmod after insmod would fail because API call to reset the switch
> HW and restart the firmware CPU code loading procedure was missing in
> driver removal code handler.
> 
> Firmware reset and reload is needed as the firmware termination will make
> the firmware loader change its state machine to the firmware loading state,
> and thus will be able to load new firmware, which is done at the beginning
> of the probing of the prestera_pci module.
> 
> Without this reset, the firmware loader will stay in the wrong state,
> causing the next firmware loading phase in the probe to fail.

What is missing from this is an explanation why you need to reload the
firmware at the next re-probe. That just seems like a waste of time if
you have already loaded it once.

    Andrew

