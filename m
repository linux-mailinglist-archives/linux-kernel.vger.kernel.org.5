Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA0087FF144
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 15:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345864AbjK3OHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 09:07:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345768AbjK3OHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 09:07:31 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE578D46;
        Thu, 30 Nov 2023 06:07:34 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 623B540007;
        Thu, 30 Nov 2023 14:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701353253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=6n5y5Y4ag6lEhCM60JkkPOe9LhwwAQaW6l5XEjQba18=;
        b=jiiBmXTxD+R0K1mUExooYO3IQW+9FJFg+tOT9rjRayt8ZhNqrwP6xB6YpdpAi69Mw1Sb/G
        NQr2h8nGRHljYmWDhj6fwlNLYLaHYqpM1b3ZZY1I3tcvW26dCxky5M35rzn4xxLE1TMlvx
        sBzwOWLihAlJQqkg6teyknxp2+ZdMYQeIvU2Fa8CxXPXvB+dCNJ2GLqpAkoIo7dST+3INU
        QJsFaEXkOZ9H0yESKKBPCT2wBz+EuwC4BWqlTZt5VIXz7wAdJN/de5upg8CszjttvVtZyy
        shicLGyppULTXyItSqKl/uzzbVEdr/qJfh83WmfCp4eCus/NwbKoN+IIU3G7IQ==
From:   =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: [PATCH v5 0/9] Cleanup AMBA PL011 driver
Date:   Thu, 30 Nov 2023 15:07:12 +0100
Message-Id: <20231130-mbly-uart-v5-0-6566703a04b5@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABCXaGUC/2XPzQoCIRSG4VsJ1xn+jKO26j6ihdo5JdQYziRFz
 L1nQWS0cPGJzws+yAg5wkjWiwfJUOIY01CHWi5IOLrhADTu6yaCCcnroWd/utOryxN1GFzw3ho
 0ntT3lwwYb+/Wdlf3MY5Tyvd3uvDX7afSN5XCKaNWKAPghNV7ufEpTac4rEI6k1eniK/l/MeKa
 k0vse9VACXYv5WNFay1slqmHUhltUWO/7Zrbfvz0lWr0XLpdIdo7K+d5/kJXPbCQFgBAAA=
To:     Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.12.3
X-GND-Sasl: theo.lebrun@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

While adding upstream support to a new platform (Mobileye EyeQ5[1]) that
uses the AMBA PL011 driver, I took some time to look at the PL011
driver and ended up with a few patches that cleanup parts of it. The
line-diff is big mostly because of the checkpatch-fixing commits.

The driver hadn't received any love for quite some time. See commit
messages for more information.

v5 has been rebased upon v6.7-rc1, with [PATCH v4 3/6] split into many
small commits and a header include in [PATCH v4 2/6] to fix a kernel
test robot report.

[1]: https://lore.kernel.org/all/202310050726.GDpZbMDO-lkp@intel.com/T/

Have a nice day,
Théo Lebrun

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
Changes in v5:
- Rebase upon v6.7-rc1.
- Add #include <linux/bitfield.h> in include/linux/amba/serial.h.
- Split [PATCH v4 3/6] into 5 manageable commits.
- Link to v4: https://lore.kernel.org/r/20231123-mbly-uart-v4-0-7f913a74ff89@bootlin.com

Changes in v4:
- Fix reverse if logic bug in [PATCH V3 6/6].
- Link to v3: https://lore.kernel.org/r/20231120-mbly-uart-v3-0-07ae35979f1f@bootlin.com

Changes in v3:
- Replace magic constants in linux/amba/serial.h by FIELD_PREP_CONST calls
- Refactor QDF2400 SoC erratum 44 handling out of probe in a new patch
- A nit in "unindent pl011_console_get_options function body"
- Link to v2: https://lore.kernel.org/r/20231116-mbly-uart-v2-0-863f665ce520@bootlin.com

Changes in v2:
- [PATCH 2]: add #include <linux/bits.h> in include/linux/amba/serial.h
  as we use the BIT() macro.
- Move one whitespace cleanup from [PATCH 4/6] to [PATCH v2 3/5] where
  it belongs.
- Drop [PATCH 6/6]: console will never have a word length of 5 or 6.
- Link to v1: https://lore.kernel.org/r/20231026-mbly-uart-v1-0-9258eea297d3@bootlin.com

---
Théo Lebrun (9):
      tty: serial: amba: cleanup whitespace
      tty: serial: amba: Use linux/{bits,bitfield}.h macros
      tty: serial: amba-pl011: fix whitespace formatting
      tty: serial: amba-pl011: replace TIOCMBIT macros by static functions
      tty: serial: amba-pl011: avoid quoted string split across lines
      tty: serial: amba-pl011: fix formatting of conditions
      tty: serial: amba-pl011: fix miscellaneous checkpatch warnings
      tty: serial: amba-pl011: unindent pl011_console_get_options function body
      tty: serial: amba-pl011: factor QDF2400 SoC erratum 44 out of probe

 drivers/tty/serial/amba-pl011.c | 261 +++++++++++++++++++++-------------------
 include/linux/amba/serial.h     | 258 ++++++++++++++++++++-------------------
 2 files changed, 266 insertions(+), 253 deletions(-)
---
base-commit: 9e47ce5c186d8364f4de3e879a148121b37e5216
change-id: 20231023-mbly-uart-afcacbb98f8b

Best regards,
-- 
Théo Lebrun <theo.lebrun@bootlin.com>

