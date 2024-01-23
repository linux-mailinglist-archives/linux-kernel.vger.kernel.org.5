Return-Path: <linux-kernel+bounces-35712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C45839587
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCD44B2E600
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6755A7F7FC;
	Tue, 23 Jan 2024 16:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AJPv6UFG"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CFF7F7D6;
	Tue, 23 Jan 2024 16:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706028565; cv=none; b=V/5vip1ms4SMH9dE6OEkIEkEfzdo9dgJKdjIoEjC79awTy8m5Axv5jyvrcx+gQW9QljCgHwpZjbX8ziRdBuEi8xSgpBQMZPTMo5PWZ2G7/Cb+gyvmET3lCLXm+c/sN/qNMQwtGmOI1EAMbl3luVKfNd5vOc2OiuUDfiWULpDt6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706028565; c=relaxed/simple;
	bh=s8eNjaucuWQYc0HKJeNwNy6Unt32xpOwN41j7lwXD78=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VfwVSJA1R/usPZyTgIswuhFhIoq5TBS6GgaCz6QdsCkNIZ+pVo6UxSpOxo9D6txwn8LH8GNLufST2VjD64XWdsnqirWcBptUe0w5mMjwNTYCdD5KBkSwSfr77K7pDX9XAS1SluLw4YXtq3ykDd9LWErHuI706JTmZqAquHyKymU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AJPv6UFG; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id E032D2000A;
	Tue, 23 Jan 2024 16:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706028560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2/nVxlyyP875JRLsYNdHih9WHy+g/yRTle4VEGY2Rms=;
	b=AJPv6UFGth4LkYMBRqtVGek3ksv+x7ewYqfnh5SiFiHrCCEyllw+hWxspNsaktGZrsGJTf
	hEJni2Cc7B4XPOVajApwG26SYDnc829fFcuEiWEakOEhzPgJubRDNN1P3ntj3679Fqq28t
	6S4tEyPCFd6oWkC6yYFo+plkZDnxRChOhTOyOfNM/J41xOJ02H+ymWRwRIXivjykxsvhnA
	a64RYSysgOBobhNQ5xsZBICe/8GyyY4p6Gac1XP2lTi5TEv7aGlqSj/Mf1KA3hmt37RVxz
	4PAF7dF6akyBr/DjEHjwRJIUA/YMtOjQv8sYkpFrwCW9o92Ou40iEkYiSLqeqQ==
From: Herve Codina <herve.codina@bootlin.com>
To: "David S. Miller" <davem@davemloft.net>,
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
Subject: [PATCH 0/4] Add support for QMC HDLC
Date: Tue, 23 Jan 2024 17:49:05 +0100
Message-ID: <20240123164912.249540-1-herve.codina@bootlin.com>
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

Best regards,
Hervé

[1]: https://lore.kernel.org/linux-kernel/20231115144007.478111-1-herve.codina@bootlin.com/
[2]: https://lore.kernel.org/linux-kernel/20231205152116.122512-1-herve.codina@bootlin.com/
[3]: https://lore.kernel.org/linux-kernel/20231128132534.258459-1-herve.codina@bootlin.com/

Changes compare to the full feature series:
  - Patch 3
    Use 'net: wan: fsl_qmc_hdlc:' as commit title prefix

Patches extracted:
  - Patch 1 : full feature series patch 7
  - Patch 2 : full feature series patch 8
  - Patch 3 : full feature series patch 20
  - Patch 4 : full feature series patch 27

Herve Codina (4):
  net: wan: Add support for QMC HDLC
  MAINTAINERS: Add the Freescale QMC HDLC driver entry
  net: wan: fsl_qmc_hdlc: Add runtime timeslots changes support
  net: wan: fsl_qmc_hdlc: Add framer support

 MAINTAINERS                    |   7 +
 drivers/net/wan/Kconfig        |  12 +
 drivers/net/wan/Makefile       |   1 +
 drivers/net/wan/fsl_qmc_hdlc.c | 820 +++++++++++++++++++++++++++++++++
 4 files changed, 840 insertions(+)
 create mode 100644 drivers/net/wan/fsl_qmc_hdlc.c

-- 
2.43.0


