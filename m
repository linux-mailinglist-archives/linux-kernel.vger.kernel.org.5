Return-Path: <linux-kernel+bounces-69934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21974859074
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 16:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC65A1F21B19
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 15:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A0C7C6CC;
	Sat, 17 Feb 2024 15:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xYa2WbGj"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206EF7C08E;
	Sat, 17 Feb 2024 15:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708183268; cv=none; b=CPDGWFZU9Tinyvk5D+M7EiTGjFfoqayGRvLXYT8UTaKTK4uAB3l0+3hTGeYNI+Xm/bOUipG52bLQaUZxbEkUKkz5v4U6lfm1b78XRNOkEG0dGMXxGq+8fB2s9ff5PNG+2tSn5rcfsQ+SUI45fot5TD52jsyDt6jhVHBFA+Hnrd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708183268; c=relaxed/simple;
	bh=WuZxqs6937g1zwRym9vbzWJK0sKCJMSfEkaZRvnSlcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e8nsgbhpT6XUR9zgADM2EjNHrkrftw8G1UMdPxzo+TK67qLUWlHDZUykPd0xdKfHIuaERjPFR/8nOWR+EBt2xuSmqWLjmFBvwEmzENqzkQNInAQZvCLrdKXIPYOFPUyLBjHgoQh0P/yChsoqO8euT7hE2iUeRuUjf9sjx8DWUlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xYa2WbGj; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=BlAL3Ogiky64AxQUBh37Q3N615bOBJULteBDI6SCcjw=; b=xYa2WbGjgRR1fdXXI5P68ukVP4
	/4I1/nGhDlj0nWZ4TAOljc4INpRzCWjL0wrPA9IOmORiIFV7JCCvFr/+bGbbvbZ3IGtKEmr8+Z0mH
	o/UihEoeBnfEr3Hged5ORKf+XoTXm83GH2Lk1FZaB+ACVH04h5+nxWwBJ/f9CwA+cBgY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rbMV3-0084EE-6A; Sat, 17 Feb 2024 16:21:09 +0100
Date: Sat, 17 Feb 2024 16:21:09 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Doug Berger <opendmb@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	open list <linux-kernel@vger.kernel.org>,
	Justin Chen <justin.chen@broadcom.com>
Subject: Re: [PATCH net-next 2/3] net: bcmgenet: Pass "main" clock down to
 the MDIO driver
Message-ID: <eb59097d-7ecf-4b7a-bc15-66a740b212da@lunn.ch>
References: <20240216184237.259954-1-florian.fainelli@broadcom.com>
 <20240216184237.259954-3-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216184237.259954-3-florian.fainelli@broadcom.com>

On Fri, Feb 16, 2024 at 10:42:36AM -0800, Florian Fainelli wrote:
> GENET has historically had to create a MDIO platform device for its
> controller and pass some auxiliary data to it, like a MDIO completion
> callback. Now we also pass the "main" clock to allow for the MDIO bus
> controller to manage that clock adequately around I/O accesses.

I guess this code comes from before the times of DT? I would normally
expect to see a clock added to the DT node for the MDIO bus. But if
there is no node, because it is not in DT....

      Andrew

