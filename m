Return-Path: <linux-kernel+bounces-18963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B31F38265C7
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 20:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF76A1C210D2
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 19:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3AB1119B;
	Sun,  7 Jan 2024 19:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="xjgfuRce"
X-Original-To: linux-kernel@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60B210A3C;
	Sun,  7 Jan 2024 19:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ShIBqfFvGWvOYEHtMNULgAQ4OuLCr8SgdXz0DO7tAwE=; b=xjgfuRceNwNt8POVHAxhoDta4n
	Sb50yfK4BEU1CNA4NNOTuQLVNOEeBX3GQ7aEFulG01eDLsd1eGhnD0Zl4qZYefWz+7Gnl1H6xgbfE
	Vml1QVZS+DgcLQSS2kOkYWutOZsl1W3/J/QurlMTEUn0SIoov15j7qJmz3QFg+tzA4cbP90YhvYhM
	DNL8GYwbmmccfKXu3NzFk0y80+pJiwHLbWhctnz7RGRy3mxAd0uXNUjcwJQvD5CqGWnOPzkOW6Y7G
	c+SvvkBNXqN5UG7s8Weav15eoeqbdEsQD+Gdl3dd2dReAGbNF4af/beLKjzlO2OatqcHmvYMFVFn2
	NpagF3QA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37984)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rMYeJ-0002Ki-1A;
	Sun, 07 Jan 2024 19:17:31 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rMYeK-0002UL-8f; Sun, 07 Jan 2024 19:17:32 +0000
Date: Sun, 7 Jan 2024 19:17:32 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Sergio Palumbo <palumbo.ser@outlook.it>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]     net: sfp: add quirk for DFP-34X-2C2 GPON ONU SFP
Message-ID: <ZZr4zCzEpuzOoIGQ@shell.armlinux.org.uk>
References: <AS1PR03MB8189FE82C632EBA97644D70082642@AS1PR03MB8189.eurprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS1PR03MB8189FE82C632EBA97644D70082642@AS1PR03MB8189.eurprd03.prod.outlook.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sun, Jan 07, 2024 at 05:17:57PM +0100, Sergio Palumbo wrote:
>     Add a quirk for a GPON SFP that identifies itself as "OEM"
>     "DFP-34X-2C2". This module's PHY is accessible at 1000base-X,
>     but can also run at 2500base-X as per specs of the module.
>     After application of the quirk the module is enebled to run both
>     at 1000base-X as well as at 2500base-X interface mode.
> 
> Signed-off-by: Sergio Palumbo <palumbo.ser@outlook.it>

There are several issues here:

1. Submitting to netdev needs either [PATCH net] or [PATCH net-next]
   to indicate which tree is being targetted. As this isn't a fix,
   net-next is appropriate, but I would also suggest that it is too
   late in the cycle as v6.7 is due out today.

2. How does the module switch between 1000base-X and 2500base-X?
   What happens if the module wants to use 2500base-X but the host
   doesn't support it? Please include these details in the commit
   message.

3. While I know the Turris Rollball entries are out of order, please
   try to keep the list alphabetically sorted, first by vendor string
   and then part string.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

