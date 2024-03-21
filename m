Return-Path: <linux-kernel+bounces-110584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A30D8860EE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 20:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01B6F283533
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 19:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84D7134413;
	Thu, 21 Mar 2024 19:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="WJS/i5Rg"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93459383A4;
	Thu, 21 Mar 2024 19:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711048962; cv=none; b=ClNpmqehLfLHbW+FbUYRYDhix9mva18nFuLNauYimlawf/3BZoZ/qSyuirE71jy8Au+/E9J/kmHH5NgvqmrrwQQCao7AcYdPxsWfDsfd1Ls2EiPFmYV4ayUnp4vU8yAIbC8wZLCyVIUt/jMFJR/WjimlbQyPdezYwzOz/qtqwrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711048962; c=relaxed/simple;
	bh=wS8i8FIdhCjUypMo/Cb6EE93+qGvdAIFzzqWejT/LTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E9CMJ4oMHdO9rbx3D+PzfAEIgKPmOc1Wtha+ucv78OwhkZFGUFOzMl1rfaX8+ueoqleqFxoBYxjYm/Shg/JVwxziRjsq9G22oVSEsQg4KSOuP+TcHJV83KH9XChS8lRLgnOrYjFLGPcqrKgQZ+Cyfub7y4SUgIoyZi7loz/DoBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=WJS/i5Rg; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=vqL7u9oyMANO/zy+gwhMEpFhK/8938wkNZRvMcW8tm0=; b=WJS/i5RgaG93bD4JOTAmcdNflV
	JwAY8j81Ni6XQ0qCZYvhXNk3AKxh2FlBCQWj4/ekzaZmfDQ3ucotQ271s7d35W+OmcGbNFonYE5QQ
	2Htw4esdZyyYVfGgodIXuXJDtCkE3DNGF18scB0tRarE2rS6HggfHzMBa03wQu22HhBk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rnNzJ-00Au1Z-C2; Thu, 21 Mar 2024 20:22:05 +0100
Date: Thu, 21 Mar 2024 20:22:05 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Elad Nachman <enachman@marvell.com>
Cc: Taras Chornyi <taras.chornyi@plvision.eu>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"kory.maincent@bootlin.com" <kory.maincent@bootlin.com>,
	"thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>,
	"miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
	"przemyslaw.kitszel@intel.com" <przemyslaw.kitszel@intel.com>,
	"dkirjanov@suse.de" <dkirjanov@suse.de>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH v2 0/5] Fix prestera driver fail to probe
 twice
Message-ID: <89a01616-57c2-4338-b469-695bdc731dee@lunn.ch>
References: <20240320172008.2989693-1-enachman@marvell.com>
 <4104387a-d7b5-4029-b822-060ef478c6e3@lunn.ch>
 <BN9PR18MB42517F8E84C8C18078E45C37DB322@BN9PR18MB4251.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR18MB42517F8E84C8C18078E45C37DB322@BN9PR18MB4251.namprd18.prod.outlook.com>

> Originally, the pain point for Kory was the rmmod + insmod re-probing failure,
> Which is only fixed by the first two commits, so I see little point in submitting 3-5 alone,
> Without fixing Kory's problem.

I thought Kory's problem was actually EPROBE_DEFER? The resources
needed for the PoE are not available, so probing the switch needs to
happen again later, when PoE can get the resources it needs.

But if that is going to take 30 seconds, i'm not sure we can call
EPROBE_DEFER solved.

The later patches are pretty simple, don't need discussion, so could
be merged. However, i think we need to explore different possible
solutions for firmware {re}loading.

> The problem is not with the hardware, but with the existing firmware code on the
> Firmware cpu, most probably secure-boot protected, which lacks the ABIs to report to
> The kernel what is loaded, what version, what state, etc.

Can you at least tell if it is running firmware?

Can you explain the boot in a bit more detail. Are you saying it could
be running an old firmware when the driver first loads? So you need to
hit it with a reset in order to load the firmware for /lib/firmware,
which might be newer than what it is already running?

That would imply the device has FLASH and has a copy of firmware in
it? And if that is true, i think that also implies you have no way to
upgrade the image in FLASH? Otherwise you would implement "devlink
flash" to allow it to be upgraded. You then would not need to load the
firmware on driver probe....

	Andrew




