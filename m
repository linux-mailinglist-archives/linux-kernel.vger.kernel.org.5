Return-Path: <linux-kernel+bounces-152344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A708ABCAF
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 20:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3361A2815AE
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 18:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FEC3CF40;
	Sat, 20 Apr 2024 18:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="QWl+Nw3e"
Received: from forward501a.mail.yandex.net (forward501a.mail.yandex.net [178.154.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC532032C;
	Sat, 20 Apr 2024 18:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713637374; cv=none; b=f+8tAxyUOGtXShzksZS+ZKji8FBeGwZ5bFb6UjJaWjFfrAcCqkiQjFxTYHCRXmLdnzR6PkO1pHqMqN2LL9RLDZG/WZxeeC9jkzz4Vt9E0pWvpNhLBLZ3dWQimvsfD+++C2JI/rShei6O8lxM+xb5hH8lWXJdhdBPektc28fQCaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713637374; c=relaxed/simple;
	bh=+NLyQZeymksJv+UdhdpGq+UF4BkKRM/TdxoGx9KLh/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kBH87q2aW4zvASoQXEITYNT56eEMMkslC0M8ebFu58146Kp57cNdz51jBPdWcPqsAbMnYyz1NmlfzzVnX5qy7GSKMBaKiyDCv2D2vna39e4HPaFuysumP7ymqPCdxeZimjJDSaNlobbTdAeYkI2QpgviI/Ssj0idnO1aOaUjAbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=QWl+Nw3e; arc=none smtp.client-ip=178.154.239.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Received: from mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0f:60f:0:640:4965:0])
	by forward501a.mail.yandex.net (Yandex) with ESMTPS id D93356115A;
	Sat, 20 Apr 2024 21:22:42 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id WMMqk3Bj1a60-evRdivpm;
	Sat, 20 Apr 2024 21:22:41 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1713637361; bh=DsOxzxzCfZeBqcxKPCWjPBT8YlJh1q1TN/5DSawsLCs=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=QWl+Nw3e0pPtHJdTCIzIiN6q+jsHUopKb0uFbvd7rXQlkcaGHsTK+u34yYLua32kg
	 XTD4ZBttJRwpw96yLuWUSjruNra+dWkkT63srxxWOV4ac8PimDs3EAu9kl91f9Gjcl
	 hC0Yw/3Bp3U+13OW/sy8e4FPU5W6BjnNa5IuGWsc=
Authentication-Results: mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net; dkim=pass header.i=@ya.ru
From: Konstantin Pugin <rilian.la.te@ya.ru>
To: 
Cc: krzk@kernel.org,
	conor@kernel.org,
	lkp@intel.com,
	vz@mleia.com,
	robh@kernel.org,
	jcmvbkbc@gmail.com,
	nicolas.ferre@microchip.com,
	manikanta.guntupalli@amd.com,
	corbet@lwn.net,
	ychuang3@nuvoton.com,
	u.kleine-koenig@pengutronix.de,
	Maarten.Brock@sttls.nl,
	Konstantin Pugin <ria.freelander@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lech Perczak <lech.perczak@camlingroup.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v5 2/3] dt-bindings: sc16is7xx: Add compatible line for XR20M1172 UART
Date: Sat, 20 Apr 2024 21:22:05 +0300
Message-ID: <20240420182223.1153195-3-rilian.la.te@ya.ru>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240420182223.1153195-1-rilian.la.te@ya.ru>
References: <20240420182223.1153195-1-rilian.la.te@ya.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Konstantin Pugin <ria.freelander@gmail.com>

EXAR XR20M1172 UART is mostly register-compatible with NXP SPI UARTs.
It will be handled by same driver, so, it makes sense to add DT
definition for these block into driver's documentation.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>
Signed-off-by: Konstantin Pugin <ria.freelander@gmail.com>
---
 Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml
index 5dec15b7e7c3..c4bedf23368b 100644
--- a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml
+++ b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml
@@ -12,6 +12,7 @@ maintainers:
 properties:
   compatible:
     enum:
+      - exar,xr20m1172
       - nxp,sc16is740
       - nxp,sc16is741
       - nxp,sc16is750
-- 
2.44.0


