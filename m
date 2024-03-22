Return-Path: <linux-kernel+bounces-111585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EFE886E2B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BED21C21183
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D58747A57;
	Fri, 22 Mar 2024 14:11:11 +0000 (UTC)
Received: from esa2.ltts.com (unknown [14.140.155.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E864776F;
	Fri, 22 Mar 2024 14:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.140.155.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711116670; cv=none; b=H2fbRtqrwEOyzMqaSBt2IbST0sC3AjM/29TQ46seNjvTuPr1DAnZCRyP4PUR2mj6Rt2ZJD/ft7vRW+hiFrBPfY0pX8Fq2q3LGOEjmPzCihOEdEf/v8fJa4VX5uFt0BL2BXU2Jcf+o/iZvvePyArCAbPgi4LtIH+k+ijO/K915zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711116670; c=relaxed/simple;
	bh=0ngLNG+fpcgu6YV8g75uVpWB9d0bOm6Y2oHAg8Xfao0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XeFd5yMvTJ/KOT5uYxNkLJ9EQ23UEWQ9xOo3QAhXk9nJ9IWBQhimqj5OdL7FsgHCysbQgxfMb6OIGKzXxla2YCM2aqkxhg6VOwbnPBtzidrKdVk6Dd3fkD2ZhaQcoG7I0MXpL1BUieezYulT7ma6IddPR+tx1Bg6rApFsdIj8Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com; spf=pass smtp.mailfrom=ltts.com; arc=none smtp.client-ip=14.140.155.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ltts.com
IronPort-SDR: Sco+iRQAbTlF9smETMExkEVw9rwmM1Bc7/GBtWiiRFEZRlovG9zHI7ccPIgyvG3nZGRXOCMomU
 YVLCY524gUOg==
Received: from unknown (HELO localhost.localdomain) ([192.168.34.55])
  by esa2.ltts.com with ESMTP; 22 Mar 2024 19:40:57 +0530
From: Bhargav Raviprakash <bhargav.r@ltts.com>
To: jpanis@baylibre.com
Cc: arnd@arndb.de,
	bhargav.r@ltts.com,
	broonie@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	eblanc@baylibre.com,
	gregkh@linuxfoundation.org,
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
Subject: Re: [PATCH v4 10/11] pinctrl: pinctrl-tps6594: Add TPS65224 PMIC pinctrl and GPIO
Date: Fri, 22 Mar 2024 19:40:43 +0530
Message-Id: <20240322141043.498005-1-bhargav.r@ltts.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <b473d940-0301-472d-90f0-297da6815377@baylibre.com>
References: <b473d940-0301-472d-90f0-297da6815377@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 22 Mar 2024 09:06:13 +0100, Julien Panis wrote:
> On 3/21/24 12:10, Julien Panis wrote:
> > On 3/20/24 11:25, Bhargav Raviprakash wrote:
> >> From: Nirmala Devi Mal Nadar <m.nirmaladevi@ltts.com>
> >>
> >> Add support for TPS65224 pinctrl and GPIOs to TPS6594 driver as they have
> >> significant functional overlap.
> >> TPS65224 PMIC has 6 GPIOS which can be configured as GPIO or other
> >> dedicated device functions.
> >>
> >> Signed-off-by: Nirmala Devi Mal Nadar <m.nirmaladevi@ltts.com>
> >> Signed-off-by: Bhargav Raviprakash <bhargav.r@ltts.com>
> >> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> >
> > With this patch, an issue is observed on am62a:
> >
> > root@am62axx-evm:~# dmesg | grep tps
> > ...
> > [   12.122631] tps6594-pinctrl tps6594-pinctrl.2.auto: error -EINVAL: Couldn't register 
> > gpio_regmap driver
> > [   12.133216] tps6594-pinctrl: probe of tps6594-pinctrl.2.auto failed with error -22
> >
> > Without this patch, the issue disappears. Do you observe
> > the same result with your am62p ?
> >
> > Julien Panis
> >
> 
> Hi Barghav.
> 
> I found the issue in your patch.
> 
> In probe function you handle TPS652254 and TPS6594 'switch' cases,
> but you do not handle TPS6593 and LP8764 cases.
> Since AM62A uses a TPS6593, it currently falls in the default case,
> and as a result probe fails.
> 
> Please fix it for v5.
> 
> Julien Panis

Hi Julien,
 
Thanks for pointing it out.
We added support for TPS6594 alone as mentioned in header description "Pinmux and GPIO driver for tps6594 PMIC". 
TPS6594 and TPS6593 has similar gpio map, however gpio map for LP8764 is different from TPS6594 / TPS6593.

Regards,
Bhargav

