Return-Path: <linux-kernel+bounces-154555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4718ADD95
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FF7D1F21FFE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 06:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4914722F11;
	Tue, 23 Apr 2024 06:36:35 +0000 (UTC)
Received: from 14.mo582.mail-out.ovh.net (14.mo582.mail-out.ovh.net [46.105.56.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8351B974
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 06:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.105.56.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713854194; cv=none; b=a3eww6mbOdUge7JkNZUsU5v/wgAI8N62XpXOLlzmq2wpb5YajtIgHFsGoDR+z1i8c2DE0nMbHjTBGCNSdDSZ1qBf/A7gDbQW36TeLeyCNsJvMOypGNJ+VNDdnrnLdOVkOgSncXYm1PKDHSi25Ktn98SFWsADzNromt6O6j5U2mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713854194; c=relaxed/simple;
	bh=//7ShSPA2EP5NwaaZfEki8K7OlVZFgyEEue1rd1oyaw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MVwv0gJAMoBlENxeaApTYc8Bgl2yaQyUBWSau3AMOAAMin1/5s0cSLE1JauDcP90rHZXxVsrX99vmvquXhXq/zVpjUgE26tEBJcrT1Qix1wocEvhSRqZsV3ZSASVHY2gx4InCsgLNz/zIxYNAWrOXBzdLQb9fLWcSMXtoT7AWlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=etezian.org; arc=none smtp.client-ip=46.105.56.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etezian.org
Received: from director11.ghost.mail-out.ovh.net (unknown [10.108.25.169])
	by mo582.mail-out.ovh.net (Postfix) with ESMTP id 4VNgTj1l2jzywq
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 22:51:21 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-4tf5f (unknown [10.110.96.193])
	by director11.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 3F4BD1FE78;
	Mon, 22 Apr 2024 22:51:18 +0000 (UTC)
Received: from etezian.org ([37.59.142.106])
	by ghost-submission-6684bf9d7b-4tf5f with ESMTPSA
	id +ft0C+bpJmbCFQIAE4RCCA
	(envelope-from <andi@etezian.org>); Mon, 22 Apr 2024 22:51:18 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-106R0069a4220ad-9504-47e7-a8ce-39f0ca134099,
                    C447AC6F663E29B5B072953094682C3B23667ADA) smtp.auth=andi@etezian.org
X-OVh-ClientIp:89.217.109.169
From: Andi Shyti <andi.shyti@kernel.org>
To: Dong Aisheng <aisheng.dong@nxp.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: NXP Linux Team <linux-imx@nxp.com>, linux-i2c@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 imx@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20240422113629.1629891-1-alexander.stein@ew.tq-group.com>
References: <20240422113629.1629891-1-alexander.stein@ew.tq-group.com>
Subject: Re: (subset) [PATCH v3 1/1] i2c: lpi2c: Avoid calling clk_get_rate
 during transfer
Message-Id: <171382627746.248626.17524804161385336410.b4-ty@kernel.org>
Date: Tue, 23 Apr 2024 00:51:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-Ovh-Tracer-Id: 16855003081161378475
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudeltddgudeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvegjfhfukfffgggtgffosehtjeertdertdejnecuhfhrohhmpeetnhguihcuufhhhihtihcuoegrnhguihdrshhhhihtiheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpeffteehudffvdfhudfgffdugfejjeduheehgeefgeeuhfeiuefghffgueffvdfgfeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduvdejrddtrddtrddupdekledrvddujedruddtledrudeiledpfeejrdehledrudegvddruddtieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomheprghnughisegvthgviihirghnrdhorhhgpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehkedvpdhmohguvgepshhmthhpohhuth

Hi

On Mon, 22 Apr 2024 13:36:29 +0200, Alexander Stein wrote:
> Instead of repeatedly calling clk_get_rate for each transfer, lock
> the clock rate and cache the value.
> A deadlock has been observed while adding tlv320aic32x4 audio codec to
> the system. When this clock provider adds its clock, the clk mutex is
> locked already, it needs to access i2c, which in return needs the mutex
> for clk_get_rate as well.
> 
> [...]

Applied to i2c/i2c-host on

git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git

Thank you,
Andi

Patches applied
===============
[1/1] i2c: lpi2c: Avoid calling clk_get_rate during transfer
      commit: 7ec84d4d55504710a828047d079cb22f12d4133f


