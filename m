Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3214808F40
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 19:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443582AbjLGR4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 12:56:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235208AbjLGR4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 12:56:18 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF4610E6;
        Thu,  7 Dec 2023 09:56:24 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 336B8E0008;
        Thu,  7 Dec 2023 17:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701971782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=f7QhMvDMdDHwd2i4TN/STlvk7XqwuOQIbGdCqZZY83g=;
        b=QweOYOmu+F9nkC+quKa+cSKIKyscbTlEO3s86r3h+qjAkMZhswNLuy5xnEpOnQK83nblDi
        ehD8zpOHHfS0sy0PuJIr1SSjhzWmPp+RTgzI8rNdO1U+1Gx3K1dTqLzTWihV6u3yR/0M6D
        tcUXU5dlymQMjrQzY4dBdXTbxoCd8GpvJmPJYIsh4f32DxpF6qwMJKWsTYWehKV21A1Yg5
        hnnapGHUaUDrCpuSb0DVeCfax6bS65h7RtYC0TitZhvGi7Zt0c7VqYM+/8PHXRFgeKZYLF
        aS7q1uJHbq35IQHMZN1pzNuSOHY5/kZV2kvp21oNppiGCi3HDiWiFepWirMRag==
From:   =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: [PATCH v6 0/8] Cleanup AMBA PL011 driver
Date:   Thu, 07 Dec 2023 18:56:05 +0100
Message-Id: <20231207-mbly-uart-v6-0-e384afa5e78c@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADUHcmUC/2XPz2oDIRAG8FcJnmNQZ/3XU9+j9KBGEyFZg7uVh
 rDv3kmgxGUPHj6Z3zfMg0yx5jiRj92D1NjylMuIQe13JJzdeIo0HzETwQRwfPTqL3f64+pMXQo
 ueG9NMp7g/K3GlH9fXV/fmM95mku9v6obf/7+t6iupXHKqBXSxOiE1Uf49KXMlzweQrmSZ08Tb
 8v5ygq0RkFSSoYoBdta6KxgvQW0TLsI0mqbeNraobf95W1Aq5Pl4PSQkrFbKzsLq70SrZJKaQa
 ODV6u7bIsf6zhzDeUAQAA
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
X-Mailer: b4 0.12.4
X-GND-Sasl: theo.lebrun@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

v6 drops [PATCH v5 1/9] as it has been applied by Greg KH. It also fixes
[PATCH v5 2/9] that broke on ARCH=arm ep93xx_defconfig because the header file
is included from assembly.

[1]: https://lore.kernel.org/all/202310050726.GDpZbMDO-lkp@intel.com/T/

Have a nice day,
Théo Lebrun

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
Changes in v6:
- Address kernel test robot failure; amba/serial.h is included from assembly.
- Drop [PATCH v5 1/9] as it has been applied by Greg KH.
- Link to v5: https://lore.kernel.org/r/20231130-mbly-uart-v5-0-6566703a04b5@bootlin.com

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
Théo Lebrun (8):
      tty: serial: amba: Use linux/{bits,bitfield}.h macros
      tty: serial: amba-pl011: fix whitespace formatting
      tty: serial: amba-pl011: replace TIOCMBIT macros by static functions
      tty: serial: amba-pl011: avoid quoted string split across lines
      tty: serial: amba-pl011: fix formatting of conditions
      tty: serial: amba-pl011: fix miscellaneous checkpatch warnings
      tty: serial: amba-pl011: unindent pl011_console_get_options function body
      tty: serial: amba-pl011: factor QDF2400 SoC erratum 44 out of probe

 drivers/tty/serial/amba-pl011.c | 261 +++++++++++++++++++++-------------------
 include/linux/amba/serial.h     | 251 +++++++++++++++++++-------------------
 2 files changed, 264 insertions(+), 248 deletions(-)
---
base-commit: bfc1fa3f077a32febb518c1df54e1ee922eee05d
change-id: 20231023-mbly-uart-afcacbb98f8b

Best regards,
-- 
Théo Lebrun <theo.lebrun@bootlin.com>

