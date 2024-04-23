Return-Path: <linux-kernel+bounces-154777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0FF8AE0E2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09F40281479
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 09:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614D55915A;
	Tue, 23 Apr 2024 09:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CFPGCN2Y"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B085812B;
	Tue, 23 Apr 2024 09:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713864078; cv=none; b=hK5OmAShjryFPQgtEjorhi4vHfyOlUG2mUqtAlGjNMwpYNzkOD3cIQgOmwu+xljf4Q9e7hikb7mIMi3MYaXNnt6jwJKDSXa8/4Pu/Va/Np1gPDdHogDcKH6MLP9d8vHuaqjcF7osAlBkoBAgnyK+04AKE3FW9qPWHFWoAAHLgcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713864078; c=relaxed/simple;
	bh=YIN9+krGjvjchguMObGmZpeiEOypatUjCyGvB6glPf4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WnjiHZG3fUl/jYqDAtbcYjsvaJyiIC6E2ZjYaKItmXn+lUiVWk8XX+KBPYjmUgYP3dcGFKzBfJ9BtBoll2v9mBgZyKtPNHoCFheKCLzUgJAqHukxbBxVMwUEJ9276W+PaC7SOu2ENbs4y0bZM2zTXyhWfNpFWRzwoA8YVNIiEyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CFPGCN2Y; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7A188240004;
	Tue, 23 Apr 2024 09:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713864074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XdOinIEzJPvj+ljxe3DKbLT5nxeNSe27OaZUS7l8hZo=;
	b=CFPGCN2YuQCldfMHFmt6OIJbV7W9R6fMTLgdEYh3TmmNtzs69nvzW3wqmN9CscQgrp0eE9
	l84RVVzotDeT9YN4YHG72RX4zMJzgGIC6YHwXv7r7L0TgT1w3o89n5DMJsQ86U0l76bWnd
	L45INM4goT5/F6SfYTELyiRidYu+oaOKaMFVelOUcBBWWKWX/WI/mPDE59nBWRhwEihGrk
	aIMV9ti0FfX0llrHef6WdD1DTN3nVWd4UL5wW+PkYQvBU7jkvXzSlNtdHNK31mtdRcchsv
	H5S3QkIk828zgP2n6hjrWZAJ9X5X8N2G0sQWkig4Dx9E92afJDA58g0Ns6PcYA==
From: Kory Maincent <kory.maincent@bootlin.com>
Subject: [PATCH net-next v3 0/3] net: pse-pd: Fixes for few small issues
Date: Tue, 23 Apr 2024 11:21:09 +0200
Message-Id: <20240423-fix_poe-v3-0-e50f32f5fa59@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAIV9J2YC/3WNQQrCMBBFr1JmbSSZtpi48h4i0iZTG9CkJCFUS
 u9uyFJx+Xnz3mwQKViKcG42CJRttN6V0R4a0PPgHsSsKRuQY8c7RDbZ9b54YoZPIyrUykiCcr0
 EKqiWruAoMUdrglshs43Jh3d9kUXlP7UsGGdSCC01H5UZTpfR+/S07qj9q1Yy/jGxmNTLFnvV8
 4l/mfu+fwCUQKbB5AAAAA==
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew@lunn.ch>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.14-dev
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

This patch series fix few issues in PSE net subsystem like Regulator
dependency, PSE regulator type and kernel Documentation.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
Changes in v3:
- Add a missing Fixes tag.
- Remove "Dent project" from the patch author description.
- Link to v2: https://lore.kernel.org/r/20240422-fix_poe-v2-0-e58325950f07@bootlin.com

Changes in v2:
- Remove "Dent project" from my sob.
- Link to v1: https://lore.kernel.org/r/20240422-fix_poe-v1-0-811c8c0b9da7@bootlin.com

---
Kory Maincent (3):
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


