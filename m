Return-Path: <linux-kernel+bounces-165915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A881A8B9353
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 04:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 541FE1F22A54
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 02:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED7917BB7;
	Thu,  2 May 2024 02:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DqO+sfLm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60ABF2C9D;
	Thu,  2 May 2024 02:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714616050; cv=none; b=sJbXN4zIepXjrjISbW0AdW9iFF1L35vg7aGPvqG39KfWyDYuhKJcrsXnLYXsvYoppDxBllrTbzuKObn56rx5eJLYY+/GBL3xVOUNNjgN+66HfaJnt91JmPSQR2YJsH9CTjkbklIcDskDi66ScoYZxmRXEEa4Lk5XrwKopCEfkqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714616050; c=relaxed/simple;
	bh=TlbegFKMMlrkIU8WC7jdVp30LiHli2gqp41ZScKawDk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QLfUH679u0+b7Dz6hz3ANXvE81szz4WSksqVUUnLvlQQ4kIlOByGlCT94XZoscw7Gmw94OGc9ri890ESumZhLbY2ZulE+kwPWNU88DZXFYSFfCK6ci1nO+jbxa8RxOwM1E7VaFAbQU7hFSV0jwwWHzw3obl8QYGUuVskqjSvra8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DqO+sfLm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6221C072AA;
	Thu,  2 May 2024 02:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714616049;
	bh=TlbegFKMMlrkIU8WC7jdVp30LiHli2gqp41ZScKawDk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DqO+sfLmWT4c6a/a1eJXdFMz3CEkweSG1uQc3wC+EOUt2ayAthYDhK3UDekzfzYLR
	 NGZpAMUuSEsFwvIr+JmjERuXpRMbs0mfIQs5hIbzFTz/B/DadztdAUr/KTh437wgAE
	 0RnNxM1p8jgNMzkQUewlJc6pf+73OCNJqFf064tr5G285zYSpUBU1TbNcB0DsQHgoV
	 TjDV8cAs1goSoRfSfgWFWPCTw1rz4rZpJ7kVs4Ncyhzs9GYm1NbbbRp1jeiwGKAqPA
	 1E6+MKQEu4SVA8TUM9T7E6de18kMXiCkTUTlxIv9oIWG6gl5i4uGBuDVzW5qGiFKl8
	 REFebrG6P+qzw==
Date: Wed, 1 May 2024 19:14:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Broadcom internal
 kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Richard
 Cochran <richardcochran@gmail.com>, Radu Pirea
 <radu-nicolae.pirea@oss.nxp.com>, Jay Vosburgh <j.vosburgh@gmail.com>, Andy
 Gospodarek <andy@greyhouse.net>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jonathan Corbet
 <corbet@lwn.net>, Horatiu Vultur <horatiu.vultur@microchip.com>,
 UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: Re: [PATCH net-next v12 13/13] netlink: specs: tsinfo: Enhance
 netlink attributes and add a set command
Message-ID: <20240501191407.5661aca0@kernel.org>
In-Reply-To: <20240430-feature_ptp_netnext-v12-13-2c5f24b6a914@bootlin.com>
References: <20240430-feature_ptp_netnext-v12-0-2c5f24b6a914@bootlin.com>
	<20240430-feature_ptp_netnext-v12-13-2c5f24b6a914@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 30 Apr 2024 17:49:56 +0200 Kory Maincent wrote:
> +      -
> +        name: hwtst-provider
> +        type: nest
> +        nested-attributes: tsinfo-hwtst-provider
> +      -
> +        name: hwtst-flags
> +        type: u32

C code is unhappy about the naming here vs what the actual C enums
are called (make -C tools/net/ynl)

You can keep the shorter names if very strongly prefer (=F0=9F=99=82=E2=80=
=8D=E2=86=94=EF=B8=8F) but then
you need to give C code gen hints about naming:
https://docs.kernel.org/next/userspace-api/netlink/c-code-gen.html

