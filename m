Return-Path: <linux-kernel+bounces-44153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFD0841E08
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A2951C2416C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B944757867;
	Tue, 30 Jan 2024 08:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MsIQ/ckY"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F274345BE7;
	Tue, 30 Jan 2024 08:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706604057; cv=none; b=Aut9pG1nEepQDiNa/6BJv2qcgwVIqpEjBxXDJ6d4Isjedmfsyail03EvVUXQ5PIzTP0FAhwGG6mq+NWBumO/V/h34VkNsFF04WdzknBP3TDQRin7zFTPkZYqhUECl4QElEWHUqxBM8P54g3WtkDOg9L+pfrffuz6y53ah2F8uR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706604057; c=relaxed/simple;
	bh=3mCnULYUvuVIm9YefuIi3uDv+OP/G/w+ho5xbSCVtSg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GVwciCWI73rKrFVhXtwywvYZ3C/DUYIQlbGqEQEBSu48E4vwVruJTv8qjZIEFIE3zhMouya4TeToGJzUm86f5R9r/Kjk7pdKjB8vyDtUOTdxd3WmkMKSe03z0gJ18hidsb/yxzPka16G76db6DO3dNPaMJAoun/3MSsijGLLBtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MsIQ/ckY; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 5EA5960004;
	Tue, 30 Jan 2024 08:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706604046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AUeV+yMhbxDVAjRgWk2k0aDLQD1BT6Nz6bBduK/S5sI=;
	b=MsIQ/ckYWPcngblsFQZGtyAcbNgNbSOxM/uyYSWrBoI9SM0ZBpH8rtdFeA7pHblETcOOIN
	efPRUQZn6IcKQodfZGfhc2xGqOTWlSxVx4WyPiyVHBMyidiJsOyIyLCkv9Z+x32KPQfMYD
	jIDY9iwmb6UDFZKVoboPJ57r4G89T/nAro4ppMgxon1JnOF0MH7nxMGX5tELjzpIfnx8XF
	P8wr/2woAGhiHUrJ40p/2iTAQtbs8+jtF4MM4zCCakjEff6HGofSUdySLpbWKxVh+4zgLj
	AnI/qlnkw6yQsIn4UMCZRPKUD+BEhjM0yf9OBgYWGV9Tsq8plsTIccl5KEk/nQ==
From: Herve Codina <herve.codina@bootlin.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Herve Codina <herve.codina@bootlin.com>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Andrew Lunn <andrew@lunn.ch>,
	Mark Brown <broonie@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v2 0/6] Add support for QMC HDLC
Date: Tue, 30 Jan 2024 09:40:15 +0100
Message-ID: <20240130084035.115086-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi,

This series introduces the QMC HDLC support.

Patches were previously sent as part of a full feature series and were
previously reviewed in that context:
"Add support for QMC HDLC, framer infrastructure and PEF2256 framer" [1]

In order to ease the merge, the full feature series has been split and
needed parts were merged in v6.8-rc1:
 - "Prepare the PowerQUICC QMC and TSA for the HDLC QMC driver" [2]
 - "Add support for framer infrastructure and PEF2256 framer" [3]

This series contains patches related to the QMC HDLC part (QMC HDLC
driver):
 - Introduce the QMC HDLC driver (patches 1 and 2)
 - Add timeslots change support in QMC HDLC (patch 3)
 - Add framer support as a framer consumer in QMC HDLC (patch 4)

Compare to the original full feature series, a modification was done on
patch 3 in order to use a coherent prefix in the commit title.

I kept the patches unsquashed as they were previously sent and reviewed.
Of course, I can squash them if needed.

Compared to the previous iteration:
  https://lore.kernel.org/lkml/20240123164912.249540-1-herve.codina@bootlin.com/
this v2 series:
- Update the qmc_hdlc initialisation in qmc_hcld_recv_complete()
- Use WARN_ONCE()
- Add a new bitmap function and use bitmap_*() in the QMC HDLC driver.

Best regards,
Hervé

[1]: https://lore.kernel.org/linux-kernel/20231115144007.478111-1-herve.codina@bootlin.com/
[2]: https://lore.kernel.org/linux-kernel/20231205152116.122512-1-herve.codina@bootlin.com/
[3]: https://lore.kernel.org/linux-kernel/20231128132534.258459-1-herve.codina@bootlin.com/

Changes v1 -> v2
  - Patch 1
    Use the same qmc_hdlc initialisation in qmc_hcld_recv_complete()
    than the one present in qmc_hcld_xmit_complete().
    Use WARN_ONCE()

  - Patch 3 (new patch in v2)
    Make bitmap_onto() available to users

  - Patch 4 (new patch in v2)
    Introduce bitmap_off()

  - Patch 5 (patch 3 in v1)
    Use bitmap_*() functions

  - Patch 6 (patch 4 in v1)
    No changes

Changes compare to the full feature series:
  - Patch 3
    Use 'net: wan: fsl_qmc_hdlc:' as commit title prefix

Patches extracted:
  - Patch 1 : full feature series patch 7
  - Patch 2 : full feature series patch 8
  - Patch 3 : full feature series patch 20
  - Patch 4 : full feature series patch 27

Herve Codina (6):
  net: wan: Add support for QMC HDLC
  MAINTAINERS: Add the Freescale QMC HDLC driver entry
  bitmap: Make bitmap_onto() available to users
  bitmap: Introduce bitmap_off()
  net: wan: fsl_qmc_hdlc: Add runtime timeslots changes support
  net: wan: fsl_qmc_hdlc: Add framer support

 MAINTAINERS                    |   7 +
 drivers/net/wan/Kconfig        |  12 +
 drivers/net/wan/Makefile       |   1 +
 drivers/net/wan/fsl_qmc_hdlc.c | 806 +++++++++++++++++++++++++++++++++
 include/linux/bitmap.h         |   3 +
 lib/bitmap.c                   |  45 +-
 6 files changed, 873 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/wan/fsl_qmc_hdlc.c

-- 
2.43.0


