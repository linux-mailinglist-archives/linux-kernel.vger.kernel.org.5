Return-Path: <linux-kernel+bounces-148416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4558A8243
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 181EC1C21C6C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6720E13CF87;
	Wed, 17 Apr 2024 11:41:50 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B1213C8FD;
	Wed, 17 Apr 2024 11:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713354110; cv=none; b=g5hox6Kwg19ydeIjoV9P7gDecGGSubwE/oAI2WNAVgTDN81hfjWr97ursDB+hH7Iu15WZJrHiGa02efckns5QDzjybWlah+AImFhJJ1evtsz1N/8f7t92QkcbGnNwo9UBUQ5ylk+WFLVPo5ehOvHSndmJigoWR2qCFq7Gb3FB30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713354110; c=relaxed/simple;
	bh=l54Wu8s+duN2ahaY2Z71FTJM436QMiVa5c8omPbhR7w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Cgkaf06iACKv5yGGD7WWNZC7xxAkns7clDYL/PGNz5y+d6jFd4mp8dTejR1UCZStc/wcnbV/ZEOchm6gycYF4K7rz0alBHAXtoNcuQJKXxiA6FNPM5WJ8nU6GX44CryM/aYXjthiU1hFFeMDNgEFD3Oe+/0yIoAuqEECUMUwAPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.07,209,1708354800"; 
   d="scan'208";a="205707553"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 17 Apr 2024 20:41:46 +0900
Received: from renesas-deb12.cephei.uk (unknown [10.226.93.98])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id A71B841D6871;
	Wed, 17 Apr 2024 20:41:43 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	linux-renesas-soc@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] pinctrl: renesas: rzg2l: Limit 2.5V power supply to Ethernet interfaces
Date: Wed, 17 Apr 2024 12:41:31 +0100
Message-Id: <20240417114132.6605-1-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RZ/G3S SoC supports configurable supply voltages for several of its
I/O interfaces. All of these interfaces support both 1.8V and 3.3V
supplies, but only the Ethernet and XSPI interfaces support a 2.5V
supply.

Voltage selection for the XSPI interface is not yet supported, so this
leaves only the Ethernet interfaces currently supporting selection of a
2.5V supply. So we need to return an error if there is an attempt to
select a 2.5V supply for any non-Ethernet interface.

Fixes: 51996952b8b5 ("pinctrl: renesas: rzg2l: Add support to select power source for Ethernet pins")
Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index eb5a8c654260..33602f0e4dad 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -892,6 +892,8 @@ static int rzg2l_set_power_source(struct rzg2l_pinctrl *pctrl, u32 pin, u32 caps
 		val = PVDD_1800;
 		break;
 	case 2500:
+		if (!(caps & (PIN_CFG_IO_VMC_ETH0 | PIN_CFG_IO_VMC_ETH1)))
+			return -EINVAL;
 		val = PVDD_2500;
 		break;
 	case 3300:
-- 
2.39.2


