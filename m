Return-Path: <linux-kernel+bounces-108744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE11880F78
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37A7C1C22236
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EEF53D0A3;
	Wed, 20 Mar 2024 10:17:47 +0000 (UTC)
Received: from esa2.ltts.com (unknown [14.140.155.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEDB3C460;
	Wed, 20 Mar 2024 10:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.140.155.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710929866; cv=none; b=XqLc+v4umiY3nMdj0KOXVHIQwkqAWYtotHaCgKNgsKy7tdMLcHpiXZf2JxFOfzpY2lkl8qk/Xq6Irmbbxs3WpSZxlRVqQ1bJZ5nP2iESqtcCVahdrGsCJ5+ZIU/ArK42NXfYiydUyUDW/An1xJPR77cj2Au9uxule415IqSXCas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710929866; c=relaxed/simple;
	bh=3c7SIBPcXa1tsEQ9GDQ8WzDWjWbomxFANSyFw4oyP7s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vGPJeXQ7X4JL9ai1vEOl8byHu0KstpeAB9rb9v0yYEtEC+eENoc+Rq8o6YMYasH/88YRZnsDiY8mdWz4uOwION9Y+6CdMrGHU8HsAbd8d3IpR/roQOSB96wLYpwcFzrUVOqS/AKMDf//91A99u56mO5N0ywjW/8PM/rCnSoS8+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com; spf=pass smtp.mailfrom=ltts.com; arc=none smtp.client-ip=14.140.155.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ltts.com
IronPort-SDR: ExPPrGOtUKQdIoi8dq2mAWYU3xj1nV/gUZGFU94t9Yr6WLUA5BsTy+hmvaQFLzmnIzvomqXykr
 U4g0qZbSdOEg==
Received: from unknown (HELO localhost.localdomain) ([192.168.34.55])
  by esa2.ltts.com with ESMTP; 20 Mar 2024 15:47:39 +0530
From: Bhargav Raviprakash <bhargav.r@ltts.com>
To: dan.carpenter@linaro.org
Cc: arnd@arndb.de,
	bhargav.r@ltts.com,
	broonie@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	eblanc@baylibre.com,
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
Subject: Re: [PATCH v3 09/11] regulator: tps6594-regulator: Add TI TPS65224 PMIC regulators
Date: Wed, 20 Mar 2024 15:47:25 +0530
Message-Id: <20240320101725.464327-1-bhargav.r@ltts.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <4aee8c9a-43eb-45b4-bc23-e58aede18e54@moroto.mountain>
References: <4aee8c9a-43eb-45b4-bc23-e58aede18e54@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

On Thu, 14 Mar 2024 16:30:09 +0300, Dan Carpenter wrote:
> On Fri, Mar 08, 2024 at 04:04:53PM +0530, Bhargav Raviprakash wrote:
> > @@ -374,11 +518,17 @@ static int tps6594_request_reg_irqs(struct platform_device *pdev,
> >  {
> >  	struct tps6594_regulator_irq_type *irq_type;
> >  	struct tps6594 *tps = dev_get_drvdata(pdev->dev.parent);
> > -	int j;
> > +	size_t j;
> >  	int irq;
> >  	int error;
> > +	size_t interrupt_cnt;
> > +
> > +	if (tps->chip_id == TPS6594)
> > +		interrupt_cnt = ARRAY_SIZE(tps6594_buck1_irq_types);
> > +	else
> > +		interrupt_cnt = ARRAY_SIZE(tps65224_buck1_irq_types);
>                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> >  
> > -	for (j = 0; j < REGS_INT_NB; j++) {
> > +	for (j = 0; j < interrupt_cnt; j++) {
> >  		irq_type = &tps6594_regs_irq_types[j];
>                             ^^^^^^^^^^^^^^^^^^^^^^
> >  		irq = platform_get_irq_byname(pdev, irq_type->irq_name);
> >  		if (irq < 0)
> 
> The tps6594_regs_irq_types pointer needs to be renamed or people won't
> know it's holding tps65224_ data.  Probably the function should be
> renamed too.
> 
> regards,
> dan carpenter

Thanks for the feedback! The name will be changed in the next version.

Regards,
Bhargav

