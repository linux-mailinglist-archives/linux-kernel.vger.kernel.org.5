Return-Path: <linux-kernel+bounces-151166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A13B78AAA2F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 10:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D66428250F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 08:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D361B21A0C;
	Fri, 19 Apr 2024 08:31:29 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0364C8A
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 08:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713515489; cv=none; b=tedOK9zHhM5dmEFcZm9VG/ZkcR/LeoPE48s5i22xsRg/WeGybDKxl9x2mxRwoVa2Ofila5qu1O9F0ePSJ2ApYUHs2LC/WpaZwmbD++r5aWXs3D2vKovpeWZtqtpoXl5/DgtR9dXhrYfR5T0KkSvRy9bUB2QHCEJAUtYWarX7bMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713515489; c=relaxed/simple;
	bh=FZzw0JYnvC5nwQsmLuivT95hJ3WwR6ccoWGB4AUybQU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LzE9Y7Bn2jgV8B+uuAa11dvoK51YMkFOlOD58WCCBcE8pGI3UsoC2cQK4+KquLUnPWKJy6MZ1jZj/d6PH6fqk0R2Ia4vg1gT3pDZTdK3fU1p/c8BuuDZwM9aBFoTdSk+tihMse7bbKg3AygvOlTcEAORfW2f9HvgVcw9qCt7Xq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <has@pengutronix.de>)
	id 1rxjeP-0006hu-VF; Fri, 19 Apr 2024 10:31:17 +0200
Received: from [2a0a:edc0:0:1101:1d::39] (helo=dude03.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <has@pengutronix.de>)
	id 1rxjeP-00D7h7-Bi; Fri, 19 Apr 2024 10:31:17 +0200
Received: from has by dude03.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <has@pengutronix.de>)
	id 1rxjeP-00DyIC-0x;
	Fri, 19 Apr 2024 10:31:17 +0200
From: Holger Assmann <h.assmann@pengutronix.de>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	yibin.gong@nxp.com
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Holger Assmann <h.assmann@pengutronix.de>
Subject: [PATCH 0/2] regulator: pca9450: enable restart handler for I2C
Date: Fri, 19 Apr 2024 10:31:02 +0200
Message-Id: <20240419083104.3329252-1-h.assmann@pengutronix.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: has@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

This series introduces a restart handler for the pca9450. This is an
optional feature and can be activated by assigning the handler priority
in the device tree.

Best regards,
Holger

Holger Assmann (2):
  regulator: pca9450: enable restart handler for I2C operation
  dt-bindings: regulator: pca9450: add restart handler priority

 .../regulator/nxp,pca9450-regulator.yaml      |  3 ++
 drivers/regulator/pca9450-regulator.c         | 54 +++++++++++++++++++
 include/linux/regulator/pca9450.h             |  7 +++
 3 files changed, 64 insertions(+)

-- 
2.39.2


