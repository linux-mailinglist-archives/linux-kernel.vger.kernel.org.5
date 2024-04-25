Return-Path: <linux-kernel+bounces-159019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FD58B2835
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1DEA1C20F89
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035F414C594;
	Thu, 25 Apr 2024 18:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="PhJ+wQeI"
Received: from forward501a.mail.yandex.net (forward501a.mail.yandex.net [178.154.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0175235280;
	Thu, 25 Apr 2024 18:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714070052; cv=none; b=TpAzHhWyBF7zIn9q9IC/79PF7SSAITxpVKBNRNSA3+uoC0BaNkFTLyDfYT86Ilwu1eXZXk+fapad50OvQUyqn/7hJ8KENQks5pne7nFKbAkupX+FZMXrGPyST3XDMThTUNqzq6eJ8L+FoRDt6wbYqh07zuFLURyKA6yRtYON+5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714070052; c=relaxed/simple;
	bh=+NLyQZeymksJv+UdhdpGq+UF4BkKRM/TdxoGx9KLh/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bz1YYJj4zc2UJoF7gPapL+H1pxbEddrMshKAaga6HiQ+REFu7Hw45Fquc8fB9ag9WXD9WKfi+t8cV1vxENe+uICBZmN7pZ03CQhRL69YCzptAu5NzVsKtKYLe4rnNwl/YgnnkYfWjTks3t7iW20XuRoSHhFlXUjabG0zaC2TYAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=PhJ+wQeI; arc=none smtp.client-ip=178.154.239.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Received: from mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:5408:0:640:72fa:0])
	by forward501a.mail.yandex.net (Yandex) with ESMTPS id 6A4E76147F;
	Thu, 25 Apr 2024 21:34:06 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id sXRDEK0m5mI0-RfeiK5Cn;
	Thu, 25 Apr 2024 21:34:05 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1714070045; bh=DsOxzxzCfZeBqcxKPCWjPBT8YlJh1q1TN/5DSawsLCs=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=PhJ+wQeIpXnDcYJpNL0EjkSeuovnNX+8X/hfuQlWz8wnNb4sbmuIXKRdSYqccsBaI
	 XTqY5JULI8FUnjxHxYo3Yk3p3cttkkMxDySecZdZOsqMiVK9wV2XudV0DHo3+D/zvX
	 AWRShMHNvBYK5NHEoq1aQonZQa95d4u9s6bbz/Go=
Authentication-Results: mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net; dkim=pass header.i=@ya.ru
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
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lech Perczak <lech.perczak@camlingroup.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v9 2/3] dt-bindings: sc16is7xx: Add compatible line for XR20M1172 UART
Date: Thu, 25 Apr 2024 21:32:34 +0300
Message-ID: <20240425183251.174412-3-rilian.la.te@ya.ru>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240425183251.174412-1-rilian.la.te@ya.ru>
References: <20240425183251.174412-1-rilian.la.te@ya.ru>
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


