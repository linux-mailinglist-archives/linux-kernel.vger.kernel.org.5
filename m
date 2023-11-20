Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716577F0F58
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 10:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbjKTJsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 04:48:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbjKTJsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 04:48:39 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB5194;
        Mon, 20 Nov 2023 01:48:35 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id DE1BD20009;
        Mon, 20 Nov 2023 09:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700473713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Hj6bwwF80hCVZud43IrkasSpNlgaA1s6m8gFcAg5NDQ=;
        b=FyFIFaXjQ6txcrROLo8Ssy+cqZO+RllOLJDyzBDojGSZFv/KGC6tyOHLOCu+yx9Egd2HkR
        6wtBSQZQU+BNUZlE3BMNtvUw4Dvt8T1NoxfloL3itClKLMv1lPvJ6MPLf56SB+1nw6phkX
        5G6LF3UZXlIfnkoqJmiYP2sfPQENjyU24l4Qe+kcWPV8jWiLeld9hp83ioYXZbKLxs6g2F
        d0V+3Bzs6RB8RCHtPwoDpseHVJH8UK0NLR2DwGPX7OGOJLIJZHowYShyMfKBAdUnfsk/QV
        KtrVHjOzv7bENrdKV0nLd7FGxiUKke3QdIrC+61IFsecu12+HvOqL8aVyox+pg==
From:   =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: [PATCH v3 0/6] Cleanup AMBA PL011 driver
Date:   Mon, 20 Nov 2023 10:48:23 +0100
Message-Id: <20231120-mbly-uart-v3-0-07ae35979f1f@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAGgrW2UC/1WMQQ6DIBBFr2JmXRqBSLGr3qPpAnCoJCoGLKkx3
 r1o0rQuZvEm/70FIgaHEa7FAgGTi84PGfipANOq4YnENZmBlYzTfKTX3UxeKkxEWaOM1rW0UkP
 ejwGte++t+yNz6+Lkw7ynE92+34r4qyRKSlKzSiIqVl8aftPeT50bzsb3sHUS+7mUHlyWXSm4F
 aIyWLHy6K7r+gHdREx14AAAAA==
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
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
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

We can thank Ilpo Järvinen for this V3! See below for changes compared
to V2.

[1]: https://lore.kernel.org/all/202310050726.GDpZbMDO-lkp@intel.com/T/

Have a nice day,
Théo Lebrun

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
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
Théo Lebrun (6):
      tty: serial: amba: cleanup whitespace
      tty: serial: amba: Use linux/bits.h macros for constant declarations
      tty: serial: amba-pl011: cleanup driver
      tty: serial: amba-pl011: replace TIOCMBIT macros by static functions
      tty: serial: amba-pl011: unindent pl011_console_get_options function body
      tty: serial: amba-pl011: factor QDF2400 SoC erratum 44 out of probe

 drivers/tty/serial/amba-pl011.c | 260 +++++++++++++++++++++-------------------
 include/linux/amba/serial.h     | 257 ++++++++++++++++++++-------------------
 2 files changed, 265 insertions(+), 252 deletions(-)
---
base-commit: 82251bf0515a7c32121b0e833922708d4dd70da9
change-id: 20231023-mbly-uart-afcacbb98f8b

Best regards,
-- 
Théo Lebrun <theo.lebrun@bootlin.com>

