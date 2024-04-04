Return-Path: <linux-kernel+bounces-131433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B698987DD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82E3AB2B859
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121361272A6;
	Thu,  4 Apr 2024 12:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="pFEWSlGT"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BEA8061C;
	Thu,  4 Apr 2024 12:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712233793; cv=none; b=Y45rrEB+Bzf1jeOWBSEbVKZD2n0jz8ZaJAdEQiUPs4V24QhJtisqi3r/3+ziv7D/LcN7qo64vohjYmUh8vK3zX9y1G1KmpsuIrP60eYQTi+6pPaNIRx6q4rSqGZiA4FqAFhDNwOkTkbqZPKRq4E2NYnZGC5fPH66UJLN+NvhCcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712233793; c=relaxed/simple;
	bh=BcxpXjPSmsKAbU456Bp+/7SK2T0g+bD6bO4JZuD0d8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ug7YGW/mkXtT+kFy3aUG6DV7qeXhk+4AfW5HR94cH50VaBNH51Q8mU62BAi13tN+Rq0YsPVQlvYraymFYVJxdmaqj3/OM5R0qGOD4/Ob7rCukp8uigIsrfEOs8fRcTg6Qu2jXbpNKyH7x8aboYWdFVYY24b5+X90CQLygiJpGEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=pFEWSlGT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8e2XpBc5P5eCivhQQJ4FMLgSWua+y+xiv5vOOT3AMew=; b=pFEWSlGTk+16lscUcrDjvHmGR9
	oi4cNbJdAty84CPXRwB11qekvMPZW/Ai+beeMf7+9dtlNC+rNZVjzR4icCoSgNDk2N+2h2bnrWdx9
	39LWu/ZjQ5GzjI61TzdbCsT9r9m88ercWQjp8vlQcjDSoloNsmeoebcB3BsneH0Y52S4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rsMDk-00CBHM-MD; Thu, 04 Apr 2024 14:29:32 +0200
Date: Thu, 4 Apr 2024 14:29:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: marvell: implement cable test for
 88E1111
Message-ID: <b24f4c2e-239c-4534-ba5b-969f7ae19f60@lunn.ch>
References: <20240404090726.3059610-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404090726.3059610-1-paweldembicki@gmail.com>

On Thu, Apr 04, 2024 at 11:07:26AM +0200, Pawel Dembicki wrote:
> The same implementation is also valid for 88E1145. VCT in 88E1111 is
> similar to the 88E609x family. The main difference lies in register
> organization and required workarounds.
> 
> It utilizes the same fields in registers but requires a simpler
> implementation.
> 
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

