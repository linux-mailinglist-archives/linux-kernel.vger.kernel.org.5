Return-Path: <linux-kernel+bounces-136027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F97589CF17
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 01:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AA9D287359
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 23:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01EFB149E1A;
	Mon,  8 Apr 2024 23:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dDvWjcTW"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BBE17745;
	Mon,  8 Apr 2024 23:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712620415; cv=none; b=eDZSx3admhByTii1RGsiIJAYvEAgAP92dCnNfmqT9LcH1BzJjUYWCMZ3aF3rpdMPTToSC5AGF3e7YYVhcv/z6i3RTP4+IiMRvG1k+pFPBfnF38VSFik3+mpp386LKyY62biCO1mB2MjcP9kHE0pt5dHzlLQP5xkzpfp90bU+tmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712620415; c=relaxed/simple;
	bh=WSCtpelLx1Ea3b5e2lFmBqD4BR4bFylzkoiMqtckb08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BkxhgXD/tpDfziQm3a6QEP3kr/rSt+Uf0N0onl59npBv7lpibK2NXuX+ubd31gL7dUgc0Ltk76VmT3iUeO65v6ON0y2EJdRfUy38hSqhO9M0Essyrd3oBCU+MaGX9bUx2sQMKhPU/mNOP0blt4JwgkBDHOBPSBjfaSeYb5ht6bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dDvWjcTW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=tDqBPkxmd7B14/uRg9vwFvYaFbd8qXypV891MvbNPAs=; b=dDvWjcTWxDQAzb9q2qqJSivqth
	kAHO9AoI9LD1RS0sc+1J6TjBQgGvU61Bs/6GtQhBEpmUGzenC2/znPDOEtpb3SAv9ZhfazTBrd8Mk
	ldSkF4YxZ5g/4VQByc83BBhjdZXc0gi6aJlX8qGVw6BwWgFAyViPHlZSGYrd53uOxnK8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rtynh-00CWf1-9L; Tue, 09 Apr 2024 01:53:21 +0200
Date: Tue, 9 Apr 2024 01:53:21 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Danielle Ratson <danieller@nvidia.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"sdf@google.com" <sdf@google.com>,
	"kory.maincent@bootlin.com" <kory.maincent@bootlin.com>,
	"maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
	"vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>,
	"przemyslaw.kitszel@intel.com" <przemyslaw.kitszel@intel.com>,
	"ahmed.zaki@intel.com" <ahmed.zaki@intel.com>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>,
	"shayagr@amazon.com" <shayagr@amazon.com>,
	"paul.greenwalt@intel.com" <paul.greenwalt@intel.com>,
	"jiri@resnulli.us" <jiri@resnulli.us>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	mlxsw <mlxsw@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>
Subject: Re: [RFC PATCH net-next 9/9] ethtool: Add ability to flash
 transceiver modules' firmware
Message-ID: <649f6db7-d0ef-41da-b2bb-e91fd0c21c7a@lunn.ch>
References: <20240122084530.32451-1-danieller@nvidia.com>
 <20240122084530.32451-10-danieller@nvidia.com>
 <5bf6b526-02c4-4940-b8ec-bf858f9d4a58@lunn.ch>
 <DM6PR12MB45161C82F43B67AD8EDB950BD87C2@DM6PR12MB4516.namprd12.prod.outlook.com>
 <DM6PR12MB4516BC80DBF383A186707F19D87C2@DM6PR12MB4516.namprd12.prod.outlook.com>
 <DM6PR12MB45161B8BB3E13CED7EAE3311D8002@DM6PR12MB4516.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR12MB45161B8BB3E13CED7EAE3311D8002@DM6PR12MB4516.namprd12.prod.outlook.com>

> Thanks again for your feedback.
> I thought again about you comment, and this patchset adds support for flashing CMIS compliant modules only.
> Later on, if it will be expanded to more modules, it will be more reasonable to add support like you have suggested to fit the new supported standard.
> So, currently I think it is better to not add it to this specific patchset.

O.K. It should not be a big change, and i doubt it has any major
performance impacts. I2C is not very fast, so we can probably get it
off the disk faster than it can be written to the device.

    Andrew

