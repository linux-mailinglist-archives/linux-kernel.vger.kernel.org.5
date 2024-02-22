Return-Path: <linux-kernel+bounces-76336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A1885F5C5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8920282169
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C963F9E2;
	Thu, 22 Feb 2024 10:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QZGZQspl"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9657F22F0C;
	Thu, 22 Feb 2024 10:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708597888; cv=none; b=dsPVmQaQBulOhCLmnQq6iFrtivggz+d4k2IEjhX5XyKT/rAt8zQt94Nw5WQiHayiEtIuuG9CDHCnI2ioHwn+bCDil2ZTFsyn3rOdcHRWoGppeSosSsAR1UP+KKb5wiucNPm57sxVcgstRxx4UPnPlUSPLT0n8uAvGitKNlzOZBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708597888; c=relaxed/simple;
	bh=cvAVudDIoWoUoaJqLInNNrpIO3J8u/OOuWGjXc5U+RA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=atCBASzP+u5ajionit585hSVWAMyIvcFPc5Ommk/gi9mCrH3gUtzjajbPWs4Vb1ZnD2kN/x6OFcL87AAHhxNHSlPOowTwvKbIHZE0S8DBmIlihu/PmIV3Z+CklZScada37uOUWLMC5pp69AzYGlVLNp+gv7zeCiipPVSQe7ofJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QZGZQspl; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DB2E1FF808;
	Thu, 22 Feb 2024 10:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708597885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EUBZIS6T/qLjtF5ns0fFYJqEALyXOpqOh5I1fTOvjy8=;
	b=QZGZQsplpYiao1CnngozWgY+pdVXe6ZKvyqqFiCKX5/zyWkXvOYe6jwuMbetqDgDMqnTCz
	8I1mGYS0cdjUd2IBUscIkeBssxpTTiqrU5WRKra0LLiVCFN4yddnqnkhCrL+fcp9VNld3Z
	eSXh5zCK+6i4q1Y1wNjECgFUGVI5u540UdJQpSjyZL2yfT7H4zkDwzc3EJ6qDPqwRfnSa+
	SH9uO1hDoTzEY9FN4etIa2lm6Mq+Z7gyDs0Qo8Ou3pgSC+sbW80GRkywMH9lZsaFdZcWaT
	4u2lmljncLNY/+Sk/sDK3B9DyOFjHgxLeP2Cf8mEPCqQoI3pTZd5yYAndZc3Ag==
From: =?UTF-8?q?J=C3=A9r=C3=A9mie=20Dautheribes?= <jeremie.dautheribes@bootlin.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Andrew Davis <afd@ti.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>,
	Yen-Mei Goh <yen-mei.goh@keysight.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	=?UTF-8?q?J=C3=A9r=C3=A9mie=20Dautheribes?= <jeremie.dautheribes@bootlin.com>
Subject: [PATCH net-next 0/3] Add support for TI DP83826 configuration
Date: Thu, 22 Feb 2024 11:31:14 +0100
Message-Id: <20240222103117.526955-1-jeremie.dautheribes@bootlin.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: jeremie.dautheribes@bootlin.com

Hi everyone,

This short patch series introduces the possibility of overriding
some parameters which are latched by default by hardware straps on the
TI DP83826 PHY.

The settings that can be overridden include:
  - Configuring the PHY in either MII mode or RMII mode.
  - When in RMII mode, configuring the PHY in RMII slave mode or RMII
  master mode.

The RMII master/slave mode is TI-specific and determines whether the PHY
operates from a 25MHz reference clock (master mode) or from a 50MHz
reference clock (slave mode).

While these features should be supported by all the TI DP8382x family,
I have only been able to test them on TI DP83826 hardware.
Therefore, support has been added specifically for this PHY in this patch
series.

Jérémie Dautheribes (3):
  dt-bindings: net: dp83822: support configuring RMII master/slave mode
  net: phy: dp83826: Add support for phy-mode configuration
  net: phy: dp83826: support configuring RMII master/slave operation
    mode

 .../devicetree/bindings/net/ti,dp83822.yaml   | 16 +++++++
 drivers/net/phy/dp83822.c                     | 44 +++++++++++++++++++
 2 files changed, 60 insertions(+)

-- 
2.34.1


