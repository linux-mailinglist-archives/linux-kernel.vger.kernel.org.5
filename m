Return-Path: <linux-kernel+bounces-150242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B6C8A9C31
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 281741F24A77
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC62165FB6;
	Thu, 18 Apr 2024 14:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="W1nXdZyN"
Received: from forward502c.mail.yandex.net (forward502c.mail.yandex.net [178.154.239.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F3615CD44;
	Thu, 18 Apr 2024 14:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713449069; cv=none; b=cJ62NlSFl2bNMwfSFTHn6xFlBFY8RJZkcbQCn931BV7lLFZAaHzRjVHhGlF7hVh04gfVh9BIEE0wsslWISC1BHLWg1t9yh7N4cyFAIKdyVHtIUduRxd3DjygfH7NCnU9aAkg8B1y7zeIXLIy7drHqHxAo5fFhSgqZopH7hGJtKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713449069; c=relaxed/simple;
	bh=9Gus4EALRgDWt/WMSWwqimg/P1msG+zc8pxmZmJWgpA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YgvtZDv5tFJqwtkUVBI3dIxDURNihyQ++JkVp8XxdxFlkLJnX22vmRPS1dEJNnBNjHi9dlCa1VGzVJELefr3Usn7qjcMlAZ4kg1I1mz1spYVnaBDUfiGuu25OEGBCQbSGe+pJOVwfhoSC1yATJNbw0dxF+xGveNMMzGO/mb1hrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=W1nXdZyN; arc=none smtp.client-ip=178.154.239.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Received: from mail-nwsmtp-smtp-production-main-25.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-25.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:c8ad:0:640:7c75:0])
	by forward502c.mail.yandex.net (Yandex) with ESMTPS id 5AB4B61354;
	Thu, 18 Apr 2024 16:58:00 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-25.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id gvF5FWNoJ8c0-qPiK6YaR;
	Thu, 18 Apr 2024 16:57:59 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1713448679; bh=CYpvT2N1pxyAISrMsrQLFmxiJD6VhxFEm/jx7F+8jGI=;
	h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=W1nXdZyNTE7q6Xu2+dxVHZDA03J8OcMZXftnuI4UlyZxdXaswJdOqjtWWR8nYwYCF
	 ZXoc9QlHBl1SZbxZq1fzARyR/qugUKR0o8XK3h+nIkMoSZANPkpqCmFtUgCoJda0Wy
	 9GFT8T5xfleEjIOiG6GAqAaOq8yi0i8LfOb6U/E8=
Authentication-Results: mail-nwsmtp-smtp-production-main-25.sas.yp-c.yandex.net; dkim=pass header.i=@ya.ru
From: Konstantin Pugin <rilian.la.te@ya.ru>
To: 
Cc: Konstantin Pugin <ria.freelander@gmail.com>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Lech Perczak <lech.perczak@camlingroup.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v2 2/3] serial: sc16is7xx: Add bindings documentation for EXAR XR20M1172 UART
Date: Thu, 18 Apr 2024 16:57:33 +0300
Message-Id: <20240418135737.3659498-3-rilian.la.te@ya.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240418135737.3659498-1-rilian.la.te@ya.ru>
References: <20240418135737.3659498-1-rilian.la.te@ya.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Konstantin Pugin <ria.freelander@gmail.com>

This patch adds the devicetree documentation for the XR20M1172 UART.

Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>
Signed-off-by: Konstantin Pugin <ria.freelander@gmail.com>
---
 Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml
index 5dec15b7e7c3..68fe7b11961c 100644
--- a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml
+++ b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml
@@ -18,6 +18,7 @@ properties:
       - nxp,sc16is752
       - nxp,sc16is760
       - nxp,sc16is762
+      - exar,xr20m1172
 
   reg:
     maxItems: 1
-- 
2.34.1


