Return-Path: <linux-kernel+bounces-164566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA188B7F60
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 20:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BD2B1F230CC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB10184119;
	Tue, 30 Apr 2024 18:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jaGiYMnh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D899181CE8;
	Tue, 30 Apr 2024 18:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714500064; cv=none; b=Jcg+kKjaV7bS1D/SrGWO7xKG55PmqlM9ot0ymKqotVS1XsqHkjSzX3Ka+Tj0+aU7aRBETc20HSo/YnM6tUMLtHZQRLkNy23e61luOY9kC0guD0ovI583xBeJq4F+y0MtGTR/DOOjzyYSi4w5rZJgda0v0yYjY4H81Z2Y+niua9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714500064; c=relaxed/simple;
	bh=2SAtvmYEA6DI5uOixBmWe365nJFeU1B9FMxLQgXluxY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AAPobV6iBp64PbWQjlwJ4VSCINhXG+kXLmeqE18gmiyVkdzMPIkI9TH8aRh7mwYEAD16mlTQBG0/pVqX2CmUxsN4JXDy7Lp2cGJThQD8tbzFL5Kf35eX10KFOnQQ/rkaoeYrUs5m8psh1M/EyaZ9mc9NLEMxIITtVWt2P0o39xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jaGiYMnh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F09EBC4AF17;
	Tue, 30 Apr 2024 18:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714500063;
	bh=2SAtvmYEA6DI5uOixBmWe365nJFeU1B9FMxLQgXluxY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jaGiYMnhxBypT44vDoujQqFJ4PAwUjYX2mGSSseoUWfbOfTW96sPKQX93HmbnDicw
	 Bcp5yItbede6FIq8UBYb4wLXE5+tJn3rG1t2gYvIfWmlvNBqcDdMk+2eVKbmwljPn/
	 PDXfxm989JUh7DNlN4OcsYwdNyQF8ufU3vDTFp/OKEJF5MrzbLFz5izeR7l6lKfcuB
	 NyqZQtXsLLoKiY7xwTeIqPmr9ARwfRULesSEtytLGKYUnB5KTSrjPANQTfVC2iBYWM
	 fJs3TYdfnh+GLx5KkD/sXYFinrU9BdNatqUCI70HLakfHA3uIzsLtmnCwYeqXCoiXf
	 9QZesBAEtfxNg==
Date: Tue, 30 Apr 2024 11:01:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Danielle Ratson <danieller@nvidia.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "corbet@lwn.net" <corbet@lwn.net>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "sdf@google.com"
 <sdf@google.com>, "kory.maincent@bootlin.com" <kory.maincent@bootlin.com>,
 "maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
 "vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>,
 "przemyslaw.kitszel@intel.com" <przemyslaw.kitszel@intel.com>,
 "ahmed.zaki@intel.com" <ahmed.zaki@intel.com>, "richardcochran@gmail.com"
 <richardcochran@gmail.com>, "shayagr@amazon.com" <shayagr@amazon.com>,
 "paul.greenwalt@intel.com" <paul.greenwalt@intel.com>, "jiri@resnulli.us"
 <jiri@resnulli.us>, "linux-doc@vger.kernel.org"
 <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, mlxsw <mlxsw@nvidia.com>, Petr Machata
 <petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: Re: [PATCH net-next v5 10/10] ethtool: Veto some operations during
 firmware flashing process
Message-ID: <20240430110101.0ba7d54c@kernel.org>
In-Reply-To: <DM6PR12MB45166623E27B6A3A972DAF70D81A2@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20240424133023.4150624-1-danieller@nvidia.com>
	<20240424133023.4150624-11-danieller@nvidia.com>
	<20240429202331.29f3dafa@kernel.org>
	<DM6PR12MB45166623E27B6A3A972DAF70D81A2@DM6PR12MB4516.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Apr 2024 17:48:17 +0000 Danielle Ratson wrote:
> Some of this code is only presented in patch 9, so it will cause
> splitting some of the vetoes in patch 5 and some of it where the code
> around is presented. Does it sound reasonable to you?

Yup! Thanks sounds good.

