Return-Path: <linux-kernel+bounces-76285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B1B85F535
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC78C2824D6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC75839859;
	Thu, 22 Feb 2024 10:03:13 +0000 (UTC)
Received: from 13.mo561.mail-out.ovh.net (13.mo561.mail-out.ovh.net [188.165.33.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A36381B8
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 10:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.33.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708596193; cv=none; b=ROM5u3KTU+9z1vBN7xPSrPoFI6ZGyf+UdXuZ1tBtIKB/RdjMxcVdmGzgyAirxIeiS4djrD/aLSfI25iW0w9rmM1tsI2avh1fuJ3/RkvDPA/jTvw4li47e88ZpBtCTI7Zdj0S1VzZmKlWA/Pk9xtf0bVdeGyyerdf1GA6nnw6Okg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708596193; c=relaxed/simple;
	bh=W+jnHVVB3ZRAg9EX2fNf/hRjYdScgr/CZdITpC+rZpA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=r6zRHMZRTJyEYYgHbQV1I1yYz/rhtjxY8CHBT7g/rvujYgunMc8t/5ACFAGwIdUeJ7b5Qex86bcijUnAZUn4Qgomb9wOYr/zbfA8B4dimC5veAIwPn8MhX3klqNasggwRi6qpIq7MLhsIjK/WQURby+AyPzvm+PasSG6lBe3nH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=etezian.org; arc=none smtp.client-ip=188.165.33.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etezian.org
Received: from director4.ghost.mail-out.ovh.net (unknown [10.109.148.126])
	by mo561.mail-out.ovh.net (Postfix) with ESMTP id 4TgRbg6FHlz1GZ0
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 08:47:27 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-dnswc (unknown [10.111.174.115])
	by director4.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 922F11FD6F;
	Thu, 22 Feb 2024 08:47:24 +0000 (UTC)
Received: from etezian.org ([37.59.142.107])
	by ghost-submission-6684bf9d7b-dnswc with ESMTPSA
	id LdgvFRwK12VVngkAllgtww
	(envelope-from <andi@etezian.org>); Thu, 22 Feb 2024 08:47:24 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-107S0017b51d39a-e42a-4bc8-afd5-71473328faab,
                    D266FE3A7B9817F169603FF0F8C90E47FA3D240B) smtp.auth=andi@etezian.org
X-OVh-ClientIp:89.217.109.169
From: Andi Shyti <andi.shyti@kernel.org>
To: linux-i2c@vger.kernel.org, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Corey Minyard <minyard@acm.org>, 
 Andrew Manley <andrew.manley@sealingtech.com>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240221193013.14233-2-wsa+renesas@sang-engineering.com>
References: <20240221193013.14233-2-wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH v3] i2c: imx: when being a target, mark the last read
 as processed
Message-Id: <170859164340.336357.16059990973960196120.b4-ty@kernel.org>
Date: Thu, 22 Feb 2024 09:47:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4
X-Ovh-Tracer-Id: 729301668120365699
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrfeefgdduvdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvegjfhfukfffgggtgffosehtjeertdertdejnecuhfhrohhmpeetnhguihcuufhhhihtihcuoegrnhguihdrshhhhihtiheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpeffteehudffvdfhudfgffdugfejjeduheehgeefgeeuhfeiuefghffgueffvdfgfeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduvdejrddtrddtrddupdekledrvddujedruddtledrudeiledpfeejrdehledrudegvddruddtjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomheprghnughisegvthgviihirghnrdhorhhgpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehiedupdhmohguvgepshhmthhpohhuth

Hi

On Wed, 21 Feb 2024 20:27:13 +0100, Wolfram Sang wrote:
> When being a target, NAK from the controller means that all bytes have
> been transferred. So, the last byte needs also to be marked as
> 'processed'. Otherwise index registers of backends may not increase.
> 
> 

Applied to i2c/i2c-host-fixes on

git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git

Thank you,
Andi

Patches applied
===============
[1/1] i2c: imx: when being a target, mark the last read as processed
      commit: cf8281b1aeab93a03c87033a741075c39ace80d4


