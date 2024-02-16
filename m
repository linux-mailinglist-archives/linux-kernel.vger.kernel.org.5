Return-Path: <linux-kernel+bounces-67886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D611485725A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 01:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 154041C22820
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 00:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD3C46A0;
	Fri, 16 Feb 2024 00:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BpABSFK0"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D6B38F;
	Fri, 16 Feb 2024 00:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708042557; cv=none; b=dbAkCUzN5V7jFCGoKwiBuMNEfPHGUy81qNExsl9Ucl/ckwZpR2UeCg/jhcLxpbb+GTgJ0xbaYoBHnw2vkq9ioTLX4YHkNgX43f3K8RC3GrhdB7GETsg/nKWtklssEZVPrzNh9EsOLZMUQrCeeQqvBMIiMa56sG6lWP3gYWFBksw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708042557; c=relaxed/simple;
	bh=o6+gUd5DJEgPqvaI67TQJWxb0xcbvBI1jdkEAjWquzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pKiR8I+5oIxyF1RsZB4YDxAi/LcAmxT7Y7Ey7qgkMOeoFCOdRGU/VLOqf2y2Wmcdpl8gxUH+P9hZGtvDIQn24aSjCw9YAh67QhYziojEF9d49ihs0vWYHYfXmKj5fD4iXACgkiUwpi1S96/5vp3plzhFJps7LBcA5CWSmz3N2CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=BpABSFK0; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=JqAy6DlroIJ9l7o/NbDSLbIGKoCKSO71Lmwdp7enbQw=; b=BpABSFK0gL4HaxZXBUyhj8IzPh
	HakVCCG+QWxbe+yuxYNkCOiBxekYPzzXHpMt7MVZ31oMQ+tc8lTBBTlcthm6E7TtEEiMPdmUxzuY8
	tcxnBn6qsAgyz0xFcudTRDXX6MmSROvw6/VmWMEzyawnkp34rpwG70JHtgIUPg1Mqwzw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1raltO-007vtb-Dh; Fri, 16 Feb 2024 01:15:50 +0100
Date: Fri, 16 Feb 2024 01:15:50 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ariel Elior <aelior@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org,
	linux-usb@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: Re: [Intel-wired-lan] [PATCH net-next v2 0/8] drivers: net: Convert
 EEE handling to use linkmode bitmaps
Message-ID: <c92f69a6-7024-4463-84d4-2be519291abf@lunn.ch>
References: <20240214-keee-u32-cleanup-v2-0-4ac534b83d66@lunn.ch>
 <fc1be95d-b34b-4153-ba0b-f124180a33ec@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc1be95d-b34b-4153-ba0b-f124180a33ec@molgen.mpg.de>

> Am 15.02.24 um 12:13 AM schrieb Andrew Lunn:
> > EEE has until recently been limited to lower speeds due to the use of
> > the legacy u32 for link speeds. This restriction has been lifted, with
> > the use of linkmode bitmaps. This patchset convert some MAC drivers
> 
> Maybe reference the commit introducing them?

That would be:

1f069de63602 ethtool: add linkmode bitmap support to struct ethtool_keee
1d756ff13da6 ethtool: add suffix _u32 to legacy bitmap members of struct ethtool_keee
285cc15cc555 ethtool: adjust struct ethtool_keee to kernel needs
0b3100bc8fa7 ethtool: switch back from ethtool_keee to ethtool_eee for ioctl
d80a52335374 ethtool: replace struct ethtool_eee with a new struct ethtool_keee on kernel side
 
> One small nit: convert*s*

Thanks.

	Andrew

