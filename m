Return-Path: <linux-kernel+bounces-51826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7776848FBE
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 18:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6A551F227B2
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 17:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51AB0249F3;
	Sun,  4 Feb 2024 17:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="trI3WmwG"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434E2249E8;
	Sun,  4 Feb 2024 17:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707067850; cv=none; b=YnolxMNY1yGGCJgiVB3T3X/plQvRWJDQJ/RicR7gm9VKgwvlRlLZ5RvqF11ULpZPnxvYVnA5AiuSiWI4LhijGjDK8ZY2QPqrUJN0nu4WWbZ4wOudwx5ObLaDp0rIvHC9plBbIKRhjKQk12JR0THanELe5r6HpMRac2QwEHUAXoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707067850; c=relaxed/simple;
	bh=I3g9WDQRF5vBIUqmbuExMuLRf1s6UoZuTmaXbeShB5U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NvwIlKzGJg9QGkUr6mBsl3vEr2SlaRG4ehvOECTZ/BTYnVJmG9ojM1ZbCslV91FWYZyy+/PYZpLUXNl4K1kh4dbClTy0RdhZvfdQavVKSrWgHssAVTYxIIWWnEYreZpI8KvSjueHjr78J/SauRp/YJYRCNTKoKQlpC1jHJaM6FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=trI3WmwG; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1707067846;
	bh=I3g9WDQRF5vBIUqmbuExMuLRf1s6UoZuTmaXbeShB5U=;
	h=From:Date:Subject:To:Cc:From;
	b=trI3WmwGD9DstJVbJ42DsrZ2yGW+N8TGmJ99mI82T4uk5vm4UaDS7WpGHC3cmQrou
	 JKA8QMkARvFcvnTWxa/t9qo+pHsWYWDTMRFyOHjHvBMYeBF0V3dCxv7Xo0XprkkaCE
	 0PAb8CNgHfo9e9wLe+aGEdMzy5q+wTuLRA/IfH3c=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 04 Feb 2024 18:30:43 +0100
Subject: [PATCH] power: supply: mm8013: select REGMAP_I2C
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240204-mm8013-regmap-v1-1-7cc6b619b7d3@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAMLJv2UC/x3MQQqAIBBA0avIrBNGE5KuEi1EJ5uFJgoRhHdPW
 r7F/y80qkwNVvFCpZsbX3lATQL86XIkyWEYNGqDGo1MyaKaZaWYXJHBBmVdcLh4DaMplQ5+/t+
 29/4BqgCIG18AAAA=
To: Sebastian Reichel <sre@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707067844; l=975;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=I3g9WDQRF5vBIUqmbuExMuLRf1s6UoZuTmaXbeShB5U=;
 b=y2EcWG8Rw69t7dC9mJC/9uObCqm14upCgRqgzcqgT2gCvLcAK3j0SvE6gXEfG5AgjvQzJKEgR
 ldqHKNmV6TcAs1Rht4AGs4nXIvsDyhF/BHhvV63SH3SI03DTfRISKfh
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The driver uses regmap APIs so it should make sure they are available.

Fixes: c75f4bf6800b ("power: supply: Introduce MM8013 fuel gauge driver")
Cc:  <stable@vger.kernel.org>
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/power/supply/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index f21cb05815ec..3e31375491d5 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -978,6 +978,7 @@ config CHARGER_QCOM_SMB2
 config FUEL_GAUGE_MM8013
 	tristate "Mitsumi MM8013 fuel gauge driver"
 	depends on I2C
+	select REGMAP_I2C
 	help
 	  Say Y here to enable the Mitsumi MM8013 fuel gauge driver.
 	  It enables the monitoring of many battery parameters, including

---
base-commit: 54be6c6c5ae8e0d93a6c4641cb7528eb0b6ba478
change-id: 20240204-mm8013-regmap-d8d18ada07c2

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


