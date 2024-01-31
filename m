Return-Path: <linux-kernel+bounces-45726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6318434B3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 04:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E51D1F25B96
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 03:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C317168C2;
	Wed, 31 Jan 2024 03:57:48 +0000 (UTC)
Received: from 15.mo582.mail-out.ovh.net (15.mo582.mail-out.ovh.net [188.165.39.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6EA14F6C
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 03:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.39.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706673468; cv=none; b=tmP1oWs5B0lnk9KmyO76yRk/tE7RGKiC4ntKDAvB3mLQPAjE9DvkjpBJjTMdC7/hVvbnE9KH8oMrbtuFDOGmQG3uYJVABYn167A5rBHk6JOMFg2iTOE2l5Y95qg5jWPdAowhCk/Pc/Bk7MIkS4Kjf6BMtui89VIq2bk0gx6JwDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706673468; c=relaxed/simple;
	bh=i8BIsOT8W4WGisGfZie/bbA4EqATNtceo5TqR/xHMJY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=T72XOxn9W1jivIv3RzNIhKPKObuWcJQCFAxDmVAoXmLXyrNeA5Gc7dD8jey4Ze2ikgQ89DaV9xlyiTzNz/rSNwWhTjkD4fF4xZMl64vV1xOtxEHHskrC9PmpCx6WHTrN5hhAiAXQG8DXBZn7TKLXRCXwM7XJeLx+FhDcI09M1/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=etezian.org; arc=none smtp.client-ip=188.165.39.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etezian.org
Received: from director11.ghost.mail-out.ovh.net (unknown [10.108.25.136])
	by mo582.mail-out.ovh.net (Postfix) with ESMTP id 84D0426C44
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 00:18:48 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-xxf4f (unknown [10.110.96.146])
	by director11.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 3CB261FE08;
	Wed, 31 Jan 2024 00:18:46 +0000 (UTC)
Received: from etezian.org ([37.59.142.110])
	by ghost-submission-6684bf9d7b-xxf4f with ESMTPSA
	id oo4kCeaRuWUyKAUAXj/8UA
	(envelope-from <andi@etezian.org>); Wed, 31 Jan 2024 00:18:46 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-110S00402f30d86-61d5-4f29-8f2e-26c26e74ee30,
                    F33A5955C440BB32736DBBB85AFDD5E0974CF895) smtp.auth=andi@etezian.org
X-OVh-ClientIp:194.230.145.85
From: Andi Shyti <andi.shyti@kernel.org>
To: linux-i2c@vger.kernel.org, 
 Gregor Herburger <gregor.herburger@ew.tq-group.com>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
 Esben Haabendal <esben@geanix.com>
Cc: linux-kernel@vger.kernel.org, Jinjie Ruan <ruanjinjie@huawei.com>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 linux-arm-kernel@lists.infradead.org
In-Reply-To: <01abf8ccc0af74b4fb0124977ed6bdfb9d7107b6.1706190706.git.esben@geanix.com>
References: <01abf8ccc0af74b4fb0124977ed6bdfb9d7107b6.1706190706.git.esben@geanix.com>
Subject: Re: [PATCH] i2c: imx: move to generic GPIO recovery
Message-Id: <170666032453.3913934.17156311653699191147.b4-ty@kernel.org>
Date: Wed, 31 Jan 2024 01:18:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4
X-Ovh-Tracer-Id: 10513653330233395856
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtkedgvdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvegjfhfukfffgggtgffosehtjeertdertdejnecuhfhrohhmpeetnhguihcuufhhhihtihcuoegrnhguihdrshhhhihtiheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpeffteehudffvdfhudfgffdugfejjeduheehgeefgeeuhfeiuefghffgueffvdfgfeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduvdejrddtrddtrddupdduleegrddvfedtrddugeehrdekhedpfeejrdehledrudegvddruddutdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoegrnhguihesvghtvgiiihgrnhdrohhrgheqpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehkedvpdhmohguvgepshhmthhpohhuth

Hi

On Thu, 25 Jan 2024 14:56:36 +0100, Esben Haabendal wrote:
> Starting with
> commit 75820314de26 ("i2c: core: add generic I2C GPIO recovery")
> GPIO bus recovery is supported by the I2C core, so we can remove the
> driver implementation and use that one instead.
> 
> As a nice side-effect, pinctrl becomes optional, allowing bus recovery on
> LS1021A, which does not have such luxury, but can be wired up to use extra
> fixed GPIO pins.
> 
> [...]

Applied to i2c/i2c-host on

git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git

Thank you,
Andi

Patches applied
===============
[1/1] i2c: imx: move to generic GPIO recovery
      commit: 11f1357336cde9924da0b455e528f11fbd5011f4


