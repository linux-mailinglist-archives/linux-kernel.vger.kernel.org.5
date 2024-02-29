Return-Path: <linux-kernel+bounces-86029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE1C86BEBC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 03:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 904412887DA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 02:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F8736AFF;
	Thu, 29 Feb 2024 02:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0MHKAcv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E692C13D2F5;
	Thu, 29 Feb 2024 02:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709172542; cv=none; b=VWYmOu4QHygaddk7+X6RNcMQeQOepehq68A2/znx4wFzJpiIW01hLiv+8SZlhO9tXhOt1ITJ+KS5db/9RNCttVfnE/3iOGOCVVe9HV17XfdrrByZFZpUj9Utp5na5G2RHDPRSPjctRMOto1N3ozQCQrSQUEDSFpc6Vytndg1mGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709172542; c=relaxed/simple;
	bh=sq0phy4iuo5IpdkIIXUzUPsgH9Su7zFWmJP0ylcTmGo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sa4cDRC2Sjua24dt9Sb0PuJD8UQaVJMqPFbAxVqasqg6Njd1mKRNracEJDuKWCjLpz5H9lbLPsQ88lDLgen7VmacwCSbYwtagpFLAFdAkLEciIK6a1vjR7XNrc1W1lXnpCX4p6DkValYDX0IQaZbp6POyuPaNf6uGiWTMeMLKuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g0MHKAcv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84E0FC433C7;
	Thu, 29 Feb 2024 02:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709172541;
	bh=sq0phy4iuo5IpdkIIXUzUPsgH9Su7zFWmJP0ylcTmGo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g0MHKAcvPLTcv9FmGAqOvCO4gP7LuD6fdt88S8HmsV8zOcBD6CjwSCi6r/8rz2EyS
	 MvR5jndo5mBLy7nETDDKnN+nPtVjoBzC/gspjfjKEqNf5Ib1v8En87Urw92iAupJp9
	 vN+SgUg4NuG1oZDBDnZIch3xCav5TpffSzFZbYw5vWTmrfwBMXqfTxT/ZGGfKhLJlF
	 ha7QSf7nVkqg9HVuHgYkY8eV0qKMhlucG/Z/Uj8I2GF1A+hL1jSa7S0dnCo7O9MnRq
	 p0qNb6SnEak3d0Hvg9np3gYSauycg4py3IIUdohpjdCOazZmOAyMiZfYhzVLAMPyFs
	 2pc5bJ82SMaqw==
Date: Wed, 28 Feb 2024 18:08:59 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>, Saeed Mahameed
 <saeed@kernel.org>, Leon Romanovsky <leon@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Richard Cochran
 <richardcochran@gmail.com>, Tariq Toukan <tariqt@nvidia.com>, Gal Pressman
 <gal@nvidia.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Ahmed  Zaki <ahmed.zaki@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>, Hangbin Liu
 <liuhangbin@gmail.com>, Paul  Greenwalt <paul.greenwalt@intel.com>, Justin
 Stitt <justinstitt@google.com>, Randy Dunlap <rdunlap@infradead.org>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, Kory Maincent
 <kory.maincent@bootlin.com>, Wojciech Drewek <wojciech.drewek@intel.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Jiri Pirko <jiri@resnulli.us>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <joabreu@synopsys.com>, Dragos  Tatulea <dtatulea@nvidia.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH RFC net-next v1 5/6] tools: ynl: ethtool.py: Make tool
 invokable from any CWD
Message-ID: <20240228180859.5ff8d7e2@kernel.org>
In-Reply-To: <87y1bavm50.fsf@nvidia.com>
References: <20240223192658.45893-1-rrameshbabu@nvidia.com>
	<20240223192658.45893-6-rrameshbabu@nvidia.com>
	<6e0a725f-3bd8-4e14-afda-860f1e4c1dc5@intel.com>
	<87y1bavm50.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Feb 2024 14:39:07 -0800 Rahul Rameshbabu wrote:
> Unfortunately, even though in the next patch after this one where I add
> the ts stats group as a comment, the tool seems to fail at rendering the
> actual counters of the stats group, so I had to use the ethtool tree to
> test. I should look into that, so that way other contributors such as
> Intel can simply use this script to test that they hooked into the
> ethtool ts stats interface correctly.

IIRC some attribute nesting in ETHTOOL_MSG_STATS_GET is too "creative"
for the YAML specs. Using the ETHTOOL_FLAG_STATS path should avoid this
problem.

