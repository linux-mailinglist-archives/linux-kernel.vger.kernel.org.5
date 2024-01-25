Return-Path: <linux-kernel+bounces-38970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F38FB83C931
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADED22907AF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54E213F014;
	Thu, 25 Jan 2024 16:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DVAE6WpC"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BF3135A57;
	Thu, 25 Jan 2024 16:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706201657; cv=none; b=nBLXhSGnPu6sxF11C1vJmJnAJ/pfLYGvDOIeMH1Sw/AVPnadDK+QuMmQYceQN4Aylk+2Vpc6j/s8oQAxDL03C4pPSuOiWbcOJLI8HTm348lOZin2wsrs8XXsBwoLPrTvGnwY+U3gvmu9Y3KrV0PCqhOggCLEqrU/omGw1dhby1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706201657; c=relaxed/simple;
	bh=xwUzrUtpCO7WW33Mo8eyVKKCRCa9+kTRiiI3pKhWLoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bA7cNvyvIgctwj2mwx5fc5tn+7KcaHcLTo/h5miXVjrs7AqskZ7y5f2/oYtFH2o+hEUNF2/MSeSIAghpWzk5QcUqEBaNK/HAash1OcONOHViw020uowlfAQyw2s9z3RQ1J6NAnpQgej8CWBeSaZxetfitCI/OSTGFr1oyIFzoLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=DVAE6WpC; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=LBMrhYMlOAKi+6baCK6Bh6+PaUoCfYaNGKf7azBPRFk=; b=DVAE6WpCY7JDWTaFfUGyvvFACh
	zSOUiTh8R2/Jqavj99emQDZLrqYj/QY+VfeF2PFR6ehB3cW/jsEby5VslqCv3MvwV9MKfGJl8ok1T
	NGlgXx3NUPD2gdwyjoXk1EoTBKzwJbENSFqQJG4zuEGRwxbi/nP9aXYhHmLnHwo9gmB0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rT2zL-0066Td-MJ; Thu, 25 Jan 2024 17:54:03 +0100
Date: Thu, 25 Jan 2024 17:54:03 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Christian Lamparter <chunkeey@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, petr.benes@ysoft.com,
	Vladimir Oltean <olteanv@gmail.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: Re: [PATCH net] net: dsa: qca8k: fix illegal usage of GPIO
Message-ID: <89c03705-5409-4a46-b9e5-d5f2a0143ac3@lunn.ch>
References: <1705925049-5756-1-git-send-email-michal.vokac@ysoft.com>
 <82712052-e7e6-414d-9c11-5595e0d6e097@lunn.ch>
 <4e74b2a8-f19e-492a-a796-057f52dddd93@ysoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e74b2a8-f19e-492a-a796-057f52dddd93@ysoft.com>

> I wonder who do you mean by qca8k maintainers? There is no one explicitly
> stated as a qca8k driver maintainer in MAINTAINERS file.
> 
> I admit that there is couple of people listed in get_maintainer output
> as authors/commit signers that I have not Cc'd.

get_maintainer gives you both the formal Maintainers, and the de-facto
maintainers due to actually working on the driver. I would expect
Christian Marangi to get Cc:ed, and maybe others.

> I have added them to the Cc list now and will do in the v2 as well.

Thanks
	Andrew

