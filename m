Return-Path: <linux-kernel+bounces-69744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC92858E01
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 09:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6AD6B21437
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 08:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7459C1D529;
	Sat, 17 Feb 2024 08:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="ADr0PuQp"
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500FB1B7F2;
	Sat, 17 Feb 2024 08:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708158047; cv=none; b=ojbLstEj/Vku0moYTMmG5UYalJB2zQM9a00k/C48kba5OPQbVjnB9oBOPNU6KpKM8tu2Ag39ucW6Nk/vMxPwNnDzBnA2RNklMc+zLOUtnQT5IluEWG43PRS9+kaQZbHWCV/ZL721E0x4QZlI9fFuSKuQpi4G5l6HSA8QtNAGSqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708158047; c=relaxed/simple;
	bh=rlrKqJgDDoZsSfU8eHHfyWZ3HpVBBXtH8uA9Pgt9aF0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DgFPB+U/YHs4AY/TwPLmwMMn9TNr73soKOoDeo4RkZShSbpVWf+q3uBYN/knhEMV7wCTFYi9ddqmmy65YT6bWzEiIjtexKoTvVpvGXVjVaq1nQYMY7UvU1303KMdOtksnCz15+7E5bQBPZV/cMjd2VB251uLHjLpDZS4ulq68p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=ADr0PuQp; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=lU5OchIEvF38TLlRSscnw+iYzDDWri1rHhV16S0CVpM=; b=ADr0PuQpZRMBepM64LjFYaaOi+
	tkcPwSo+I4qeLQBDaLa7fpFBaydlqooJTMus9WqxsFLTM+d1iNkEL0VRu4Fjh6LpZPeFp0giGVtHK
	DU9OFYbk/eWc8xwDi1D2t1pnvfUg4EpUifsLuUxgZSppXbapvwxBAKh3QuxeldXe4O2T74OJ1I81t
	veGV819ckIuaf0kFaxrP92fvo8KK7R3Q67tOwcHFY/7q8GvGX4Y+a/rfLQU9b92s5UKzyRXsL7ftG
	XYo7ETnB5CI+UxLwHUYcjoSjjVqvIQzSUG4H5f59p5hAxAscqE7n8w3JtNnzgMRpd4eGRdHyBULWm
	lXiVV34A==;
Received: from p2003010777002c001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:107:7700:2c00:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andreas@kemnade.info>)
	id 1rbFvz-009WA1-GY; Sat, 17 Feb 2024 09:20:31 +0100
Received: from andi by aktux with local (Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1rbFvy-00Dabd-37;
	Sat, 17 Feb 2024 09:20:30 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: lee@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	bcousson@baylibre.com,
	tony@atomide.com,
	andreas@kemnade.info,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org
Cc: Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 1/5] dt-bindings: mfd: ti,twl: Document system-power-controller
Date: Sat, 17 Feb 2024 09:20:03 +0100
Message-Id: <20240217082007.3238948-2-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240217082007.3238948-1-andreas@kemnade.info>
References: <20240217082007.3238948-1-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add system-power-controller property because these chips
can power off the device.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/mfd/ti,twl.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/ti,twl.yaml b/Documentation/devicetree/bindings/mfd/ti,twl.yaml
index c04d57ba22b49..52ed228fb1e7e 100644
--- a/Documentation/devicetree/bindings/mfd/ti,twl.yaml
+++ b/Documentation/devicetree/bindings/mfd/ti,twl.yaml
@@ -34,6 +34,8 @@ properties:
 
   interrupt-controller: true
 
+  system-power-controller: true
+
   "#interrupt-cells":
     const: 1
 
-- 
2.39.2


