Return-Path: <linux-kernel+bounces-95439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 883C5874DA5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA2AC1C208A2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22305129A87;
	Thu,  7 Mar 2024 11:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eQe55MjL"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C01126F39;
	Thu,  7 Mar 2024 11:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709811564; cv=none; b=HSXC3bewoKIBQen4CFKNS6oI7Y/gvHyWiRtONfUi9JzvTcEeuKSlKDeT4rCDWeas70+GFviOz1QWeey8bT9fMLfcRyE6vRFUqwZLpUn7i/po/Lz+fAYJ4jNGT/OQZ1ulsjQ23Z1F6iqfohafS2k4Cc9zm0LXAwfDoj6QkgZSABE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709811564; c=relaxed/simple;
	bh=lYW4Xvnrb3pnEateFCKn9iC3QBk75W4e7BtlYDke2BM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fRPJhXEjgam2xjBikcw+XFtVg9n2T799ryStcKHznLnmVyHsq9brUOrWOJCFUW64QIupbHapssH+wTiiw5j5kPH9lMg+RD9M1az1qJWiv3wFMIJJO06hRy8ieljWJMEeQa1GHC3p/dSLC4HZKdN/M/DdK643mxfMhJJhLBRw+tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eQe55MjL; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 5EAFBC0009;
	Thu,  7 Mar 2024 11:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709811559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zqCO0royVyl24RgST1chkgBP+oGFft/R1sEvJ3adLr4=;
	b=eQe55MjLemol9ZFxJckuA3xPRgXf5CICKTgSliL2UVG85qnUbu/LUr/A0w+owyNCdAMIs/
	GraTGosX04FHUtsaDuffRnDKy9ObAdOj379EVTnTsWLjYHNfmpp6iXjB7R0WwlR4dAVJfg
	2u/3apcI/+R6upNF3q2d09iWm5NbcRzLwIFK4StMXFpBYBl1lXSAfpHa9gSj4ZLQ21sOt6
	Czyf9GN9jf+DbDPTIVoa4lwfOULX13VLlVamN6ba4f7yjxTbOidxZx9NHe1Bx8Wjg2X8UF
	MmqeHRT1Yzp+W6ch+28OGCoXabP3kbZF8FcXj7NHRI122NiDC77EegeHPeLSpg==
From: Herve Codina <herve.codina@bootlin.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Yury Norov <yury.norov@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Andrew Lunn <andrew@lunn.ch>,
	Mark Brown <broonie@kernel.org>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v7 0/5] Add support for QMC HDLC
Date: Thu,  7 Mar 2024 12:39:03 +0100
Message-ID: <20240307113909.227375-1-herve.codina@bootlin.com>
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
  https://lore.kernel.org/linux-kernel/20240306080726.167338-1-herve.codina@bootlin.com/
this v7 series mainly:
- Rename a variable.
- Fix reverse xmas tree declarations.
- Add 'Acked-by' tag.

Best regards,
Hervé

[1]: https://lore.kernel.org/linux-kernel/20231115144007.478111-1-herve.codina@bootlin.com/
[2]: https://lore.kernel.org/linux-kernel/20231205152116.122512-1-herve.codina@bootlin.com/
[3]: https://lore.kernel.org/linux-kernel/20231128132534.258459-1-herve.codina@bootlin.com/

Changes v6 -> v7
  - Patch 1
    Fix reverse xmas tree declarations splitting declaration and
    initialization.

  - Patch 2
    No changes

  - Patch 3
    Add 'Acked-by: Yury Norov <yury.norov@gmail.com>'

  - Patch 4
    Rename array32 variable to slot_array.

  - Patch 5
    No changes

Changes v5 -> v6
  - Patch 1
    Add missing header file inclusion.
    Rework loop in qmc_hdlc_open() error handler.
    Add 'Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>'

  - Patch 2
    No changes.

  - Patch 3
    Avoid breaking API calls in kernel-doc to improve readability.
    Remove Andy's credit. Keep only his signed-off-by.

  - Patch 4 and 5
    Add	'Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>'.

Changes v4 -> v5
  - Patch 1
    Update QMC_HDLC_RX_ERROR_FLAGS to improve readability.
    Display an error message after releasing resources instead of
    before.
    Use 'struct device *dev' in probe().
    Use dev_err_probe() in probe().
    Do not print a message on -ENOMEM.
    Use guard() and scoped_guard().

  - Patch 3
    Use '(). See' constructing in kernel-doc instead of '() (See ...'
    Add 'Co-developed-by: Herve Codina <herve.codina@bootlin.com>'

  - Patch 4
    Use 'struct device *dev' in probe().
    Use dev_err_probe() in probe().
    Use '%64pb' instead of '%*pb' in printk formats.

  - Patch 5
    Use 'struct device *dev' in probe().
    Use guard()

Changes v3 -> v4
  - Patch 1
    Remove of.h and of_platform.h includes, add mod_devicetable.h.
    Add a blank line in the includes list.

  - Path 2
    No changes.

  - v3 patches 3 and 4 removed

  - Patch 3 (new patch in v4)
    Introduce bitmap_{scatter,gather}() based on the original patch done
    by Andy Shevchenko.
    Address comments already done on the original patch:
    https://lore.kernel.org/lkml/20230926052007.3917389-3-andriy.shevchenko@linux.intel.com/
      - Removed the returned values.
      - Used 'unsigned int' for all indexes.
      - Added a 'visual' description of the operations in kernel-doc.
      - Described the relationship between bitmap_scatter() and
        bitmap_gather().
      - Moved bitmap_{scatter,gather}() to the bitmap.h file.
      - Improved bitmap_{scatter,gather}() test.
      - Reworked the commit log.

  - Patch 4 (v3 patch 5)
    Use bitmap_{scatter,gather}()

  - Patches 5 (v3 patch 6)
    No changes.

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

Andy Shevchenko (1):
  lib/bitmap: Introduce bitmap_scatter() and bitmap_gather() helpers

Herve Codina (4):
  net: wan: Add support for QMC HDLC
  MAINTAINERS: Add the Freescale QMC HDLC driver entry
  net: wan: fsl_qmc_hdlc: Add runtime timeslots changes support
  net: wan: fsl_qmc_hdlc: Add framer support

 MAINTAINERS                    |   7 +
 drivers/net/wan/Kconfig        |  12 +
 drivers/net/wan/Makefile       |   1 +
 drivers/net/wan/fsl_qmc_hdlc.c | 797 +++++++++++++++++++++++++++++++++
 include/linux/bitmap.h         | 101 +++++
 lib/test_bitmap.c              |  42 ++
 6 files changed, 960 insertions(+)
 create mode 100644 drivers/net/wan/fsl_qmc_hdlc.c

-- 
2.43.0


