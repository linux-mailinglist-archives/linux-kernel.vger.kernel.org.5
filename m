Return-Path: <linux-kernel+bounces-153388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FAB8ACD84
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F21702822BC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A5F14F9D4;
	Mon, 22 Apr 2024 12:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Km2SzPy9"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEC311CAB;
	Mon, 22 Apr 2024 12:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713790277; cv=none; b=VqK8+YLJZe/fXd0NcCX4eiwgXZERuxWb7zkLeyCEGvlWLkQi9f81sIZYGO6OsXwZuOMLLVL9FJoJmqMkQNqn2ASs1kLD6s7fBzfXrXdofdlT6Eji2H9XHiRYmsRw3AFPvRM7sz7B4KtSIn7IQYV+iQM/fuVu1B2rSw++T5YHfj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713790277; c=relaxed/simple;
	bh=OqJowIvIBbs+JYGsA5jVoM/XZKtxufyerAuSQ5qi5Ng=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=g0cCK1VFg2/jPej6dPu6erN0n4AzbC8OufUXYQf8eTmXmTfV8Roiq+kpfS2sNzArP1RiOjwpBdms9gr68eci3U7NBbzOwWZGJuwVsodTaXOOk07xvoM/cy3YBLsg/vRU+uGtPpy2StPXo49YKjOa2vZUhxxffCzI/gQ2ddL04Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Km2SzPy9; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9E2D660007;
	Mon, 22 Apr 2024 12:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713790274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NRmVKFErPTs4HxJ6RGextmFIQtqaP7B12gOM7nUeqho=;
	b=Km2SzPy9iZSAOx+2unPoaG1/zbOAqZIa/UG6UCXw87YfcVvhYvs/xYqvGf/EO9xAFQjLC+
	3AU0hVsctgZRTJI9CtaUthHqWAlAHqWDOfrA456utc9RPsqfdHMhFEEZsekR6OLl98CyzK
	gG0V4HEQd/LbxkrZO5BLuMAPGNNNL2sqPLUGaUl60gMoxYhd0tO3jLANugCb2xsIcWKap2
	k94b8cj/63s1Xpl0JL070LI/t090iaoi83YY5jMkmlPlfB7B3N9bo5dx33B4zZstlJtfkZ
	wgUyKtHjvYeAuyQgDo4tneZkNI8S1w97Ar0me9lc34u5AiTtmbBy+yw4dJfAfQ==
From: "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>
Subject: [PATCH net-next 0/3] net: pse-pd: Fixes for few small issues
Date: Mon, 22 Apr 2024 14:50:47 +0200
Message-Id: <20240422-fix_poe-v1-0-811c8c0b9da7@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACddJmYC/x2MQQqAIBQFrxJ/nWAfF9VVIqLyWX+johGBdPek5
 TDDFMpIgkxjUyjhlizBV+jahvZz9QeU2MrEmo02zMrJs8QAZbXbeOB9sD2o1jGhqv80kcelPJ6
 L5vf9AKnh6HdjAAAA
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew@lunn.ch>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, 
 "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>, 
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.14-dev
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

This patch series fix few issues in PSE net subsystem like Regulator
dependency, PSE regulator type and kernel Documentation.

Signed-off-by: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
---
Kory Maincent (Dent Project) (3):
      net: pse-pd: pse_core: Add missing kdoc return description
      net: pse-pd: pse_core: Fix pse regulator type
      net: pse-pd: Kconfig: Add missing Regulator API dependency

 drivers/net/pse-pd/Kconfig    |  2 +-
 drivers/net/pse-pd/pse_core.c | 10 +++++++++-
 2 files changed, 10 insertions(+), 2 deletions(-)
---
base-commit: 6a57f091622a1251c2826f7380577049199b80ea
change-id: 20240422-fix_poe-d0fb292c9d8e

Best regards,
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


