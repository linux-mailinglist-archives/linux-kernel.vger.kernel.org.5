Return-Path: <linux-kernel+bounces-44205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4940841EC3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A072629162D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44B660869;
	Tue, 30 Jan 2024 09:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iUGHGvxO"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5639D66B46;
	Tue, 30 Jan 2024 09:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706605477; cv=none; b=Im1Mkgp+XF8cT6udfAHFZiBPsrBEY9ZD6SZ16j7irj0ED9+KfhVfchC+oQQFCAcjoTlrWpeRG02gaBfD0ZeuLHZ1k94VWs0BzRj/5vR0EvYAg9IKaHM/IwRowDuVU4xI67A72rynMPnK0bSPwmUjih8b08Dqf40IiMfvM4R/yvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706605477; c=relaxed/simple;
	bh=4XgBQQ3juSbUpkKMMs7aW+PfhE8Y3xmTKKHhjIsTQQk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fg4Xdiyzf3ZxzUUjA1fMl+HUM8cf3T+NkejtyffVG7lM18Fte34LyAU+2TgXV/6zbtkLxZnR3kkCZGumChIlmyH+TCus/jyDtmWzjJk3OJ7tkwVNl3mOhDYxjm8HqLTTjj+J9DxrYd2I3uAW/2REadZOCXHoEGrJvuPiuUUeJGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iUGHGvxO; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 61C9D240007;
	Tue, 30 Jan 2024 09:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706605472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pAKHzaNOMh1xHR6FDCCFSU4eCbm5CK+UjZM9xHkQa8I=;
	b=iUGHGvxOvWQVhG6pKA6+GztCmARC7ypRb4ct0JuFrly0QTecU6wJg7AfIhfwOyUKWU0hmo
	7y472mX3bH4k3UTRj7R9OdA56fnl0ZKxKzMiB9rRtbljEu75I8ppsLTHdO4mtveuz/cuxN
	SYAaLuxWgXFwM+CF9USTNfj5qTcQecvp2oOc1uAGWSOsFipboAqmREulYJ2X6AA8z1Eukn
	1XI5hZQqRLBxR7uh4fRCCwiBlzzwWn7ehd/78fw9s5FXOaMBh42KukeY07NdPwxcryi8oc
	FSuvNW4rBGOS+XdJXnwdvNSwbpILSW+aafpC+nhNQuJZ8TUv9ACkR+tabtJV6g==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH 0/2] Add device tree binding support to TI's DP83640
Date: Tue, 30 Jan 2024 09:59:33 +0100
Message-ID: <20240130085935.33722-1-bastien.curutchet@bootlin.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: bastien.curutchet@bootlin.com

Hi everyone,

This short patch series adds a device-tree binding support to the TI's PHY
DP83640. The goal is to be able to enable or disable the following features
through the device tree:
   - Energy Detect Mode
   - PHY Control Frames
   - LED Configuration
   - Fiber Mode

Bastien Curutchet (2):
  dt-bindings: net: Add TI DP83640
  net: phy: Add some configuration from device-tree

 .../devicetree/bindings/net/ti,dp83640.yaml   | 113 +++++++++++++++
 drivers/net/phy/dp83640.c                     | 131 +++++++++++++++++-
 drivers/net/phy/dp83640_reg.h                 |  21 ++-
 include/dt-bindings/net/ti-dp83640.h          |  18 +++
 4 files changed, 281 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/ti,dp83640.yaml
 create mode 100644 include/dt-bindings/net/ti-dp83640.h

-- 
2.43.0


