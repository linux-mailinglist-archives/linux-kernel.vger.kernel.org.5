Return-Path: <linux-kernel+bounces-41692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C29BC83F687
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 399551F218C7
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F3F2D05C;
	Sun, 28 Jan 2024 16:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+/N0+1b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BE145973;
	Sun, 28 Jan 2024 16:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458311; cv=none; b=SaGNPj7X0UaxAdDviY/lA3/sBzBSzpB9YK9imocSoRRBij535DiK3fznS9MxDqaadEtJJ4WEKiDAXEm3thjza/ZrPNR3Ayfr4KU88oY6YPfWnnvnyQwTEWni3JK+Y4kGWLaomn8LAdSIE0lW2snKAH7P987NVOL4dppJOGNbBjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458311; c=relaxed/simple;
	bh=bDRFmt9TPDWC71U4gviKIO8cCZqDHb0Zd0pX0lGIH/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fPKaWIKW4Ht6H/qZ+8HR8tpb8j/RWvhd576dqemSOAHwR5GSbmgv23y2P4E+xwC4fNudpTBx6SIesIyRZWw80TrpBYPUugXXssFN8MA6ru0aQrf/Zeg9O3Pq8+spUrBVYlagUT6eLeHmSGDwhYdpOjiwtgnFR192ophrmstC+FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+/N0+1b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4784DC433C7;
	Sun, 28 Jan 2024 16:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458310;
	bh=bDRFmt9TPDWC71U4gviKIO8cCZqDHb0Zd0pX0lGIH/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K+/N0+1b63Oi/C85HBOzAS2QSRWHaR2q+F0CnVuheuTSxarX/3jHtVJUK4GxA53jN
	 q1b568hbYX87bIUnfaAZCUMVepuCOKATitGud3IV4+HKWyL7ukV1i3BYtrrp+Ml2Qz
	 zc9qboDn3HOFSOWGh0Tx0Srrd6gSwdf1uuR5HujCtmA518raoHuSNQHitgrOcjlL9O
	 /BWYYESi/Jh9zg08MmyC0a4cQcB8LirJXp6GgiqCRciaaggUKhunbxJrFFy3Nn6W16
	 FRqnFHkK5Pq1mgQcWjG85xZ/QPjWkMPJLyFYVyRhQQTZn87HfHv/0TIX3Rtzm8gTGl
	 5BC6qbid0nQmg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Crescent CY Hsieh <crescentcy.hsieh@moxa.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	cang1@live.co.uk,
	andriy.shevchenko@linux.intel.com,
	jiaqing.zhao@linux.intel.com,
	kumaravel.thiagarajan@microchip.com,
	linux-serial@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 10/39] tty: serial: 8250: Set RS422 interface by default to fix Moxa RS422/RS485 PCIe boards
Date: Sun, 28 Jan 2024 11:10:30 -0500
Message-ID: <20240128161130.200783-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128161130.200783-1-sashal@kernel.org>
References: <20240128161130.200783-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.2
Content-Transfer-Encoding: 8bit

From: Crescent CY Hsieh <crescentcy.hsieh@moxa.com>

[ Upstream commit 43f012df3c1e979966524f79b5371fde6545488a ]

MOXA PCIe RS422/RS485 boards will not function by default because of the
initial default serial interface of all MOXA PCIe boards is set to
RS232.

This patch fixes the problem above by setting the initial default serial
interface to RS422 for those MOXA RS422/RS485 PCIe boards.

Signed-off-by: Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
Link: https://lore.kernel.org/r/20231214060234.6147-1-crescentcy.hsieh@moxa.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/8250/8250_pci.c | 58 +++++++++++++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 614be0f13a31..8ccf691935b7 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -19,6 +19,7 @@
 #include <linux/serial_core.h>
 #include <linux/8250_pci.h>
 #include <linux/bitops.h>
+#include <linux/bitfield.h>
 
 #include <asm/byteorder.h>
 #include <asm/io.h>
@@ -1970,6 +1971,20 @@ pci_sunix_setup(struct serial_private *priv,
 
 #define MOXA_GPIO_PIN2	BIT(2)
 
+#define MOXA_RS232	0x00
+#define MOXA_RS422	0x01
+#define MOXA_RS485_4W	0x0B
+#define MOXA_RS485_2W	0x0F
+#define MOXA_UIR_OFFSET	0x04
+#define MOXA_EVEN_RS_MASK	GENMASK(3, 0)
+#define MOXA_ODD_RS_MASK	GENMASK(7, 4)
+
+enum {
+	MOXA_SUPP_RS232 = BIT(0),
+	MOXA_SUPP_RS422 = BIT(1),
+	MOXA_SUPP_RS485 = BIT(2),
+};
+
 static bool pci_moxa_is_mini_pcie(unsigned short device)
 {
 	if (device == PCI_DEVICE_ID_MOXA_CP102N	||
@@ -1983,13 +1998,54 @@ static bool pci_moxa_is_mini_pcie(unsigned short device)
 	return false;
 }
 
+static unsigned int pci_moxa_supported_rs(struct pci_dev *dev)
+{
+	switch (dev->device & 0x0F00) {
+	case 0x0000:
+	case 0x0600:
+		return MOXA_SUPP_RS232;
+	case 0x0100:
+		return MOXA_SUPP_RS232 | MOXA_SUPP_RS422 | MOXA_SUPP_RS485;
+	case 0x0300:
+		return MOXA_SUPP_RS422 | MOXA_SUPP_RS485;
+	}
+	return 0;
+}
+
+static int pci_moxa_set_interface(const struct pci_dev *dev,
+				  unsigned int port_idx,
+				  u8 mode)
+{
+	resource_size_t iobar_addr = pci_resource_start(dev, 2);
+	resource_size_t UIR_addr = iobar_addr + MOXA_UIR_OFFSET + port_idx / 2;
+	u8 val;
+
+	val = inb(UIR_addr);
+
+	if (port_idx % 2) {
+		val &= ~MOXA_ODD_RS_MASK;
+		val |= FIELD_PREP(MOXA_ODD_RS_MASK, mode);
+	} else {
+		val &= ~MOXA_EVEN_RS_MASK;
+		val |= FIELD_PREP(MOXA_EVEN_RS_MASK, mode);
+	}
+	outb(val, UIR_addr);
+
+	return 0;
+}
+
 static int pci_moxa_init(struct pci_dev *dev)
 {
 	unsigned short device = dev->device;
 	resource_size_t iobar_addr = pci_resource_start(dev, 2);
-	unsigned int num_ports = (device & 0x00F0) >> 4;
+	unsigned int num_ports = (device & 0x00F0) >> 4, i;
 	u8 val;
 
+	if (!(pci_moxa_supported_rs(dev) & MOXA_SUPP_RS232)) {
+		for (i = 0; i < num_ports; ++i)
+			pci_moxa_set_interface(dev, i, MOXA_RS422);
+	}
+
 	/*
 	 * Enable hardware buffer to prevent break signal output when system boots up.
 	 * This hardware buffer is only supported on Mini PCIe series.
-- 
2.43.0


