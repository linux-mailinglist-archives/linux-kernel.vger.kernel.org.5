Return-Path: <linux-kernel+bounces-108746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DCC9880F7F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01BA81F21A03
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70633D0A1;
	Wed, 20 Mar 2024 10:19:12 +0000 (UTC)
Received: from esa2.ltts.com (unknown [14.140.155.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895D33D3B8;
	Wed, 20 Mar 2024 10:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.140.155.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710929952; cv=none; b=fplHrSwtKPja4tw3gdzSUCm2jmuyFHanM3R2GcDobg+/nShzbrV3z7blzEAnn1WhbucBB9jd6IQxoYrcaNjJtnBeV8MhbiQnlmAOPh9Yb9iM9xGdNSWdE1J/11sOr0oofjTceuXjO3k/B/kvKR/j1pObXf4qCXJZRLy/xccI2ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710929952; c=relaxed/simple;
	bh=sHz1b4+w2VmuCDq0NFjSHsu5Jh7QjvvpN2QQ5HDSoog=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GQ97WMrBTqeGb9NVR+c5Z9UvMI3UjHbN2Jx0Ehf1wENVPYA9hY6YSKMLsFeTZCw69xdgOTvekYWEyuq0ZnKtNwkltjj3oZttZ1f8lP/6dsiNh8hqNxCs/hvcqz2GuluwQ7gS/vtriYoEM3prT3WJqK2EezU3jTsJqPTjj5K+u3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com; spf=pass smtp.mailfrom=ltts.com; arc=none smtp.client-ip=14.140.155.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ltts.com
IronPort-SDR: 72OkoL4oJSz74/abrQJBbo8wGQ0EtUGOe5eUVbjj+RkZP6XIHbkTKGRp+vORlIDL6y6Q3sJ8Gc
 WdDfYw2XFztw==
Received: from unknown (HELO localhost.localdomain) ([192.168.34.55])
  by esa2.ltts.com with ESMTP; 20 Mar 2024 15:49:05 +0530
From: Bhargav Raviprakash <bhargav.r@ltts.com>
To: eblanc@baylibre.com
Cc: arnd@arndb.de,
	bhargav.r@ltts.com,
	broonie@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jpanis@baylibre.com,
	kristo@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	lee@kernel.org,
	lgirdwood@gmail.com,
	linus.walleij@linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	m.nirmaladevi@ltts.com,
	nm@ti.com,
	robh+dt@kernel.org,
	vigneshr@ti.com
Subject: Re: [PATCH v3 10/11] pinctrl: pinctrl-tps6594: Add TPS65224 PMIC pinctrl and GPIO
Date: Wed, 20 Mar 2024 15:48:51 +0530
Message-Id: <20240320101851.464478-1-bhargav.r@ltts.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CZTFSA2OG09N.3V2KR7KS6GU1W@baylibre.com>
References: <CZTFSA2OG09N.3V2KR7KS6GU1W@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

On Thu, 14 Mar 2024 12:29:23 +0100, Esteban Blanc wrote:
> On Fri Mar 8, 2024 at 11:34 AM CET, Bhargav Raviprakash wrote:
> > From: Nirmala Devi Mal Nadar <m.nirmaladevi@ltts.com>
> >
> > Add support for TPS65224 pinctrl and GPIOs to TPS6594 driver as they have
> > significant functional overlap.
> > TPS65224 PMIC has 6 GPIOS which can be configured as GPIO or other
> > dedicated device functions.
> >
> > Signed-off-by: Nirmala Devi Mal Nadar <m.nirmaladevi@ltts.com>
> > Signed-off-by: Bhargav Raviprakash <bhargav.r@ltts.com>
> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Hi,
> 
> What changed here compared to the previous version?
> 
> You might have missed my previous email[1] since I don't see any of changes
> I suggested.
> 
> [1] https://lore.kernel.org/r/CZHM5FYHS6G0.295L6AYUNZCT@baylibre.com/
> 
> Best regards,
> 
> -- 
> Esteban "Skallwar" Blanc
> BayLibre

Thanks for the feedback!
It will be addressed in the next version.
We have regrouped wherever logically possible. 

Regards,
Bhargav

