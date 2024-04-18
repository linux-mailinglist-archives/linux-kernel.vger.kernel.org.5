Return-Path: <linux-kernel+bounces-150549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EAE8AA0D4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 19:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75C811C211B4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8AE16191A;
	Thu, 18 Apr 2024 17:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="wEo7gMHQ"
Received: from forward501a.mail.yandex.net (forward501a.mail.yandex.net [178.154.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E09B172BD7;
	Thu, 18 Apr 2024 17:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713460345; cv=none; b=CGRp/ufyTNUTOkWrdnZEcXSdVsPCVihrXKGUTKNwKtBCZan7SXODaQg8eG0nCxNcbGbVLGnjNYATjczMWGXHTCJQRcvWPsAqDSX02Hvh+nDX0mYlqperttOFzpNDC1UiVBSGZaMPuBAkxfsQSR+d8Jsf5P/s7d6oKckJClBPhbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713460345; c=relaxed/simple;
	bh=FOi6eJPUFSojRtF9P/XwjqEpVwed2EL1xlarcDukTeg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ksLGSIHa5LCZZQ0l3pytGsHoDp1td6qaLzV4W4M2eUjxeMcH6a/kdX03FbzMRgRcx35S2wePZtJNWIu8MK3ST6/NdMb/WaN6fp0S2adRrZYQ+XNiMRJLGwDZ3jhre828nQ1tCoUmTqTZpiAOVHz4Wf/0Zeqsy+Nqx3V5kx4r7Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=wEo7gMHQ; arc=none smtp.client-ip=178.154.239.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Received: from mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1d:2c01:0:640:acf3:0])
	by forward501a.mail.yandex.net (Yandex) with ESMTPS id 872DC61487;
	Thu, 18 Apr 2024 20:06:34 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id M6JHjm3m3Gk0-GjtOvhpt;
	Thu, 18 Apr 2024 20:06:33 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1713459993; bh=GaYIntdqsvXpjyEkkhoOihijbTv7eiJ72X4WWAqXMnU=;
	h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=wEo7gMHQV5h7QrVruUvQOA6I/7OL8GKS6zvTjk+aCM0ScW/srE0ld6ARudnds6YQQ
	 dpEVzU7mGWLBk3DUIhV1LlfEbSVeFQjRw7DBeBLTXotgp9L3gqBWI3e2bpLeOaSAIG
	 BvKxqXyDdVQVjv3PHrWaplz8cDl7MaGuE+ID2xZ8=
Authentication-Results: mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net; dkim=pass header.i=@ya.ru
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
Subject: [PATCH v3 2/3] dt-bindings: sc16is7xx: Add compatible line for XR20M1172 UART
Date: Thu, 18 Apr 2024 20:06:06 +0300
Message-Id: <20240418170610.759838-3-rilian.la.te@ya.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240418170610.759838-1-rilian.la.te@ya.ru>
References: <20240418170610.759838-1-rilian.la.te@ya.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Konstantin Pugin <ria.freelander@gmail.com>

Add EXAR XR20M1172 UART compatible line into devicetree documentation.

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
2.34.1


