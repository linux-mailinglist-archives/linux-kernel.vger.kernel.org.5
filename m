Return-Path: <linux-kernel+bounces-85772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0100086BA90
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 23:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0D252888FE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 22:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA46A1361D7;
	Wed, 28 Feb 2024 22:08:57 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC411361B5;
	Wed, 28 Feb 2024 22:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709158137; cv=none; b=WMlNNcznXzx6eAD8bdcVIPJBNe3Z5sgc231RWvAqWDtlmRcu4oSY7l3Wufdy9uxM87j1v0HFe+Elqmh0+qFTpIvrwDNTOI7wvTGq6epMhxzq4QLEcyLxFiXO2SZFAf+iB8lKJxXdAr4ltQKit0RW5f29qyjlCDI8Hsg+FC4U/lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709158137; c=relaxed/simple;
	bh=r1i94g2MPDnIrgqSNviSxFemOVfH2bZ3i25wcrLYUfE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SwldOUkY3OZbkg3wW/q/cxj58XnZXLG23D0gfrRggdfWuUPI3G4Whh45Ek2aLVdHb9Ozj+M3x1CU5J0Uh3O3mkk35KrnBs8r1xPbbGdPD1ot/4C4xSdhFgnca2Kp+heiRbI5EzNYGNVmzJtoZzIowzlMWm0xp3btoufBs2ROm+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6BCAC433A6;
	Wed, 28 Feb 2024 22:08:56 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 63C431067A0E; Wed, 28 Feb 2024 23:08:53 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Nathan Chancellor <nathan@kernel.org>
In-Reply-To: <20240228-device_cleanup-power-v1-1-52c0321c48e1@marliere.net>
References: <20240228-device_cleanup-power-v1-1-52c0321c48e1@marliere.net>
Subject: Re: [PATCH] power: supply: move power_supply_attr_group into
 #ifdef block
Message-Id: <170915813338.50142.16479593478459212798.b4-ty@collabora.com>
Date: Wed, 28 Feb 2024 23:08:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Wed, 28 Feb 2024 10:46:28 -0300, Ricardo B. Marliere wrote:
> When building with CONFIG_SYSFS=n, the build error below is triggered:
> 
> ld: drivers/power/supply/power_supply_core.o:(.data+0x0): undefined
> reference to `power_supply_attr_group'
> 
> The problem is that power_supply_attr_group is needed in
> power_supply_core.c but defined in power_supply_sysfs.c, which is only
> targeted with CONFIG_SYSFS=y. Therefore, move the extern declaration into
> the #ifdef block that checks for CONFIG_SYSFS, and define an empty static
> const struct otherwise. This is safe because the macro __ATRIBUTE_GROUPS in
> power_supply_core.c will expand into an empty attribute_group array.
> 
> [...]

Applied, thanks!

[1/1] power: supply: move power_supply_attr_group into #ifdef block
      commit: ea4367c40c79a5f16cb0de8a94a6b72697d37f06

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


