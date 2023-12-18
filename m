Return-Path: <linux-kernel+bounces-3129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA26C8167C4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 08:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F67C2825C3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 07:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2CCFBF4;
	Mon, 18 Dec 2023 07:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Ndco3uE/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0135963AA;
	Mon, 18 Dec 2023 07:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-158-149-209.elisa-laajakaista.fi [91.158.149.209])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id CBFED57E;
	Mon, 18 Dec 2023 08:53:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1702886021;
	bh=cql4h96dv06hH9CykfpuGnZfzJq+KMy0qwgU5DQIW/g=;
	h=From:Subject:Date:To:Cc:From;
	b=Ndco3uE/vI4r0yJX8AAZ75uRyxCrfM5MPyP/kQ/yL3qZuGoxmtJcDRwPiD8/UMQTJ
	 dQalEThfJAIKR5p27XBxvbbenv3zO/cnR8yI2UpcivAR/jOYUsqM1ReXFyle/QLRt8
	 1CZqxHmp1/KKaMUDInStANY7NDLEvCehMwHOMf2I=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH 0/2] media: rkisp1: Fix shared interrupt handling
Date: Mon, 18 Dec 2023 09:53:59 +0200
Message-Id: <20231218-rkisp-shirq-fix-v1-0-173007628248@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJf6f2UC/x2M0QpAQBAAf+XaZ1vuDuFX5IGz2BRnt6Tk310eZ
 2rmASVhUmjNA0IXKx97ApsZCOuwL4Q8JQaXO2+drVE21oi6spw4841VaGjyY+HqsoRURaGk/2P
 Xv+8H6loVzWEAAAA=
To: Dafna Hirschfeld <dafna@fastmail.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, Mikhail Rudenko <mike.rudenko@gmail.com>
Cc: Kieran Bingham <kieran.bingham@ideasonboard.com>, 
 Paul Elder <paul.elder@ideasonboard.com>, linux-media@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=901;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=cql4h96dv06hH9CykfpuGnZfzJq+KMy0qwgU5DQIW/g=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBlf/qxIB9lMmj1ncHt1yEst2NSWVcnLKBfqBBcY
 DKGLj2np2iJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZX/6sQAKCRD6PaqMvJYe
 9c02EACm9p0tAvZkK0CDtj1+iQWKoGDOaeWaWXi5OGj4pvT+xVUqhvtgfjgC0XU8cZBqJAfUJmF
 0d5HB4wmBLXye/70Szw4S9PR7yYkArKvaeePxd2Y3Wh2JLasbWsZww9tTL1MKsE/H+sn6I4PvlK
 VIXPqU3yIfkZj0RkOowLYmuHaBOjLBLZt0R9n/9UG7H3WRmpKL7PGAQOGOgomT1h09TE3m8gLER
 I7lWzG/Wvs9I8HKyNeIcuVaVoKMCz7/Q3IoluAtokc9kRL8IowQ8N684zZpfNUJ2fMwZJibVbGj
 ppP1nGCmC13zymOWkEcU09SdE3hSP2xntcgS20i4g/YE9MAHP+AtEpC/U6cYr1j8z62Im9JSDii
 qvwi5PtdujD1YJWyHwFqwzz4n3NGc6I1o0LkKt5pmwrxK9Ud/FNiXkZoXWn1hiVEfVRWCkI9wZF
 Dc9NMB+G4xvzbms5bxTBTUkoxFbAKDHYpfrSd7g1fF9rxdTThitwgnRS1hA/lYDgKO1OIGgYUqd
 /FdUcB3V8g0X1Ka3EeNoH5C8vus3HRdloOTokQvz5eoVdqQ1R914b7+9qoDedYdNvX7MZR7PBJO
 lGz8eI9cemHUDRGMnPTKrfPxIO5cQcQSGazTHGclRnKKWnSinVXFHnRUIam2BPitJc/5rhAOHvX
 v6rJz05+4OK8QBQ==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

First revert the commit that dropped IRQF_SHARED, as it is required
after all. Then fix the driver to handle shared irqs.

 Tomi

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
Tomi Valkeinen (2):
      Revert "media: rkisp1: Drop IRQF_SHARED"
      media: rkisp1: Fix IRQ handling due to shared interrupts

 .../platform/rockchip/rkisp1/rkisp1-capture.c      |  3 +++
 .../media/platform/rockchip/rkisp1/rkisp1-common.h |  2 ++
 .../media/platform/rockchip/rkisp1/rkisp1-csi.c    |  3 +++
 .../media/platform/rockchip/rkisp1/rkisp1-dev.c    | 24 +++++++++++++++++++++-
 .../media/platform/rockchip/rkisp1/rkisp1-isp.c    |  3 +++
 5 files changed, 34 insertions(+), 1 deletion(-)
---
base-commit: 02d4e62ae2452c83e4a3e279b8e4cb4dcbad4b31
change-id: 20231218-rkisp-shirq-fix-6c9ed3b42855

Best regards,
-- 
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>


