Return-Path: <linux-kernel+bounces-55077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6318984B75F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A05DFB22E3B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDEB3132462;
	Tue,  6 Feb 2024 14:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="h5LPULT0"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE92E131752;
	Tue,  6 Feb 2024 14:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707228446; cv=none; b=JMTo8gL1ZxqtOr4A/jTiuX0Nzcgn4Qtk/xByyP2se41FX9wyeplf3ysICgTISvtiKRnbYGzHQAfCx4NJ5vcws8+InxHwxh19k+v1acB/J5CfHjkTmvtHKxi1oSDLwKeyQlGVv7dNI63Ifs5iqSP7CzHzFv2T2PcLPjB5Au55Xpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707228446; c=relaxed/simple;
	bh=mSaO4V8eXYIJo9QKirxHj5d/f+K8vcYSiVLtD13X1X0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BYIwPq6RDTpa+6yC5ypf+u9we/opVq9s1uVRgeKJg+CIs4v1yeyismypt/xM5iHZJQ+1KeCLr3yHhbJNQrdwgLZUnvfyL/pf0PmetzEC25HuutpyRL+tSYEJadZI9cwNkOgTXfLPtT3qimkpoKUxfGWkn/2hTFvmTzRSZ5cpth8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=h5LPULT0; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 02B5C1C000D;
	Tue,  6 Feb 2024 14:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707228440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sa5nE+pLpd7ozU5Sgh5in8PkbOnzrLpb9BwEvhv2Oes=;
	b=h5LPULT01iBz35OAODeIBje7aY26ADfBPG6tPdh2/2Y5rukXfXuSNiT4L1GTZkV7/VZLu4
	I147/Z+PAr6n3VXJg9dVfnijvqj9wolYd06n+/6mQNkbtWl6oBeswLK+QO4LPzjSvl5cFJ
	BgHJreJW/U2sTlWXAMGLHLdc7rqIwWkMzlbnP7lumwm5Es1I69y5OZ6TH3neVoPDoSttNC
	dFs4yxhLUbAFF2D8EsJ6BvPbkTP5wwlqXWVGI401ponlvHCPRoUcQ42Ul+opHWyLXPOnsk
	aOpvr/8nck1Y52CWOwuFtsIYi40o/mWF98gN4f5YI+oQFR5vc2QWx+IVRredeA==
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
Subject: [PATCH v3 0/6] Add support for QMC HDLC
Date: Tue,  6 Feb 2024 15:07:10 +0100
Message-ID: <20240206140717.107930-1-herve.codina@bootlin.com>
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
  https://lore.kernel.org/linux-kernel/20240130084035.115086-1-herve.codina@bootlin.com/
this v3 series:
- Remove 'inline' function specifier from .c file.
- Fixed a bug introduced in the previous iteration.
- Remove one lock/unlock sequence in the QMC HDCL xmit path.
- Use bitmap_from_u64().

Best regards,
Hervé

[1]: https://lore.kernel.org/linux-kernel/20231115144007.478111-1-herve.codina@bootlin.com/
[2]: https://lore.kernel.org/linux-kernel/20231205152116.122512-1-herve.codina@bootlin.com/
[3]: https://lore.kernel.org/linux-kernel/20231128132534.258459-1-herve.codina@bootlin.com/

Changes v2 -> v3
  - Patch 1
    Remove 'inline' function specifier from .c file.
    Fix a bug introduced when added WARN_ONCE(). The warn condition must
    be desc->skb (descriptor used) instead of !desc->skb.
    Remove a lock/unlock section locking the entire qmc_hdlc_xmit()
    function.

  - Patch 5
    Use bitmap_from_u64() everywhere instead of bitmap_from_arr32() and
    bitmap_from_arr64().

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
 drivers/net/wan/fsl_qmc_hdlc.c | 807 +++++++++++++++++++++++++++++++++
 include/linux/bitmap.h         |   3 +
 lib/bitmap.c                   |  45 +-
 6 files changed, 874 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/wan/fsl_qmc_hdlc.c

-- 
2.43.0


