Return-Path: <linux-kernel+bounces-95199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E31B4874A8F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC3CD1C20BD7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B2C839FE;
	Thu,  7 Mar 2024 09:18:41 +0000 (UTC)
Received: from esa2.ltts.com (unknown [14.140.155.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F281A839F6;
	Thu,  7 Mar 2024 09:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.140.155.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709803120; cv=none; b=Ul1QCliAoQL7AS7rOZzzqc4SLK4tOG4evVhMSCoWxRe0nCHn1DWFdEbPZ38UEBweA+ZQWRvVovSTrWxW5Oid3tyiU0bNez59zLKhImPhOPuAnhn9sQAqrWcEvB1lvC8+wHGDko+57unIsjmLnKqMKaUTmc8V3yeiHuHRU+aqOlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709803120; c=relaxed/simple;
	bh=T4FiHVTAJAfthIiOc24UxKIA2+yHHEcgJD6hGrrdgmk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VRoWAjvtpGtGkNRNLtdq9Q4snGi7I9BpSpT85p8h0dwMskFQuH/Fsk7qFRq4VT0FKfPLAZfc4V/agYCw/Uu76XhWs32D4usaTgOTZJHNSrAI28w/VlvHvWy/DAPdYiO5uZS1E1G6PPOQS1O++cAsfkd/0MlKPNm2MisvdKcxMmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com; spf=pass smtp.mailfrom=ltts.com; arc=none smtp.client-ip=14.140.155.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ltts.com
IronPort-SDR: s2r9boCswk44kgrxVXVgIt3dntph98vGssg0BeLOWdvmdoRI/88/B2hDmLZQasT+h6VJXxxpl7
 JNy2VA8uiQ7A==
Received: from unknown (HELO localhost.localdomain) ([192.168.34.55])
  by esa2.ltts.com with ESMTP; 07 Mar 2024 14:48:33 +0530
From: Bhargav Raviprakash <bhargav.r@ltts.com>
To: broonie@kernel.org
Cc: arnd@arndb.de,
	bhargav.r@ltts.com,
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
Subject: Re: [PATCH v2 12/14] regulator: tps6594-regulator: Add TI TPS65224 PMIC regulators
Date: Thu,  7 Mar 2024 14:48:23 +0530
Message-Id: <20240307091823.171504-1-bhargav.r@ltts.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <6fa04f9a-2904-4955-a219-d4962b8fe41b@sirena.org.uk>
References: <6fa04f9a-2904-4955-a219-d4962b8fe41b@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,
On Thu, 29 Feb 2024 14:49:16 +0000, Mark Brown wrote:
> On Thu, Feb 29, 2024 at 03:42:50PM +0100, Esteban Blanc wrote:
> > On Fri Feb 23, 2024 at 10:36 AM CET, Bhargav Raviprakash wrote:
> 
> > > +	/* Number of interrupts supported by each voltage source */
> > > +	interrupt_cnt = (tps->chip_id == TPS6594) ?
> > > +			 ARRAY_SIZE(tps6594_buck1_irq_types) :
> > > +			 ARRAY_SIZE(tps65224_buck1_irq_types);
> 
> > The comment is not adding anything, the name is clear and ARRAY_SIZE is
> > quite explicit.
> 
> Also please don't abuse the ternery operator like this, write normal
> conditionals or for a case like this where we may get more options in
> future use switch statements.

Got it! will fix it in the next version.

Regards,
Bhargav

