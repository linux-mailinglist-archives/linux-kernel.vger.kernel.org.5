Return-Path: <linux-kernel+bounces-94042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 385C58738F5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCA8B1F24254
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51FE13248E;
	Wed,  6 Mar 2024 14:24:58 +0000 (UTC)
Received: from 5.mo550.mail-out.ovh.net (5.mo550.mail-out.ovh.net [178.33.45.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC40060895
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 14:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.33.45.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709735098; cv=none; b=twCmX4TgI6VlV0BBe8rM6H2dH3xrKeMrgHOpLzv0agZwD+rz+yHGcsj/BUORy9PHv1hWlqkUpYhEWDMZG3VqT32/B4L1R5OS0gbL88E7YAx8bWhlomsRRv37oEQwFYbhAwF5ILqJDJ0y/AH6vHs0kTRdZAvxK0JyXioofMZg+ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709735098; c=relaxed/simple;
	bh=r5/BbODiVYHKi4Vy9BlmKr5xBKMSKvqljtQVJe3nSwc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XZdTTe/zyExAfiG/OsQ/lHBmf4XHOJVFqB701GBEICFJQDIFoWpzc6ykz7O1l6wGprbkBOCbb099w9skxNDOUiVHGy22QDn/bl1rvejj8+3JJ4WIKod0qpaUutcBCGr2R8zHGS2DAw5GOhJz3vGyYIVbWptgm61mhJSTkozVYMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=etezian.org; arc=none smtp.client-ip=178.33.45.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etezian.org
Received: from director7.ghost.mail-out.ovh.net (unknown [10.109.176.170])
	by mo550.mail-out.ovh.net (Postfix) with ESMTP id 4TqW8n0x2hz1L27
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 11:55:37 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-n2q92 (unknown [10.110.113.124])
	by director7.ghost.mail-out.ovh.net (Postfix) with ESMTPS id B275B1FE65;
	Wed,  6 Mar 2024 11:55:33 +0000 (UTC)
Received: from etezian.org ([37.59.142.107])
	by ghost-submission-6684bf9d7b-n2q92 with ESMTPSA
	id xHmDHbVZ6GUUgAEA0v5T7Q
	(envelope-from <andi@etezian.org>); Wed, 06 Mar 2024 11:55:33 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-107S0019a2d669e-ee64-4ca9-a271-21f25ef40524,
                    62DEF991EB217AB86F953B10C2782167B22AFEEB) smtp.auth=andi@etezian.org
X-OVh-ClientIp:89.217.109.169
From: Andi Shyti <andi.shyti@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Jesper Nilsson <jesper.nilsson@axis.com>
Cc: Naveen Krishna Ch <ch.naveen@samsung.com>, linux-i2c@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel@axis.com
In-Reply-To: <20240305-i2c_exynos5-v3-1-17a749688806@axis.com>
References: <20240305-i2c_exynos5-v3-1-17a749688806@axis.com>
Subject: Re: [PATCH v3] i2c: exynos5: Init data before registering
 interrupt handler
Message-Id: <170972613133.1712532.6066452137196640811.b4-ty@kernel.org>
Date: Wed, 06 Mar 2024 12:55:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-Ovh-Tracer-Id: 6464917266006870544
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledriedugdefudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevjghfuffkffggtgfgofesthejredtredtjeenucfhrhhomheptehnughiucfuhhihthhiuceorghnughirdhshhihthhisehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnhepffetheduffdvhfdugfffudfgjeejudehheegfeeguefhieeugffhgfeuffdvgfefnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepuddvjedrtddrtddruddpkeelrddvudejrddutdelrdduieelpdefjedrheelrddugedvrddutdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpegrnhguihesvghtvgiiihgrnhdrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheehtddpmhhouggvpehsmhhtphhouhht

Hi

On Tue, 05 Mar 2024 11:50:00 +0100, Jesper Nilsson wrote:
> devm_request_irq() is called before we initialize the "variant"
> member variable from of_device_get_match_data(), so if an interrupt
> is triggered inbetween, we can end up following a NULL pointer
> in the interrupt handler.
> 
> This problem was exposed when the I2C controller in question was
> (mis)configured to be used in both secure world and Linux.
> 
> [...]

Applied to i2c/i2c-host-fixes on

git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git

Thank you,
Andi

Patches applied
===============
[1/1] i2c: exynos5: Init data before registering interrupt handler
      commit: 51130d52b84c473f5da5378aa7e7633611f79313


