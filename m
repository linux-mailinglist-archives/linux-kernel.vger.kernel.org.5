Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA0C77F608D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 14:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345556AbjKWNmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 08:42:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345546AbjKWNmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 08:42:40 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4F31B2;
        Thu, 23 Nov 2023 05:42:45 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0EF5D20003;
        Thu, 23 Nov 2023 13:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700746964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=F3vy/7nYCWRbhMHcnBSAXEvJuRy+JCkeE1T969XcgXs=;
        b=EkSlzJf7KMRw3tUD8Gv4zxMd4mwSBvmtT+Hx7gxjuojsxn3tFD+awUJ81nONCOPSl/+zul
        LbHCrwJjCIw9LIFTRNzn16ILq4EeOWJLdseqh+Ws1LgQmYdOZg2FlT3kHCGSmqECzUf8PJ
        JgA/e7T/wAeuBbll6jVsyiMcoprv9nw3zbb+SJ6tciFSePw4lbwsU84JEmGvhaRdM9TA73
        BJUslWyqdH7ZcGl+W+x6d0gsQzL8zbPshy46X82KfSWZyR5JUNAXe/xsCgb7Mlt1+dJr0x
        dVvErZGvY11HE+NxK4oIkdF8687N/daz0Wb2SwpDpyyn1bzI+lRb93s2HmaNNw==
From:   =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: [PATCH v4 0/6] Cleanup AMBA PL011 driver
Date:   Thu, 23 Nov 2023 14:42:38 +0100
Message-Id: <20231123-mbly-uart-v4-0-7f913a74ff89@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAM5WX2UC/2XM3w6CIBiH4VtxHEfjTyJ01H20DgA/ks2kgbmc8
 95Dt5auAw5+7HveCSWIHhI6FxOKMPjkQ5fH6VAg2+juDtjXeSNGGKf54YdpR/zSscfaWW2NUdJ
 Jg/L9M4Lz77V1veXd+NSHOK7pgS6/34rYVAaKCVaslACaqarmFxNC3/ruaMMDLZ2B/SylO8uyl
 YI7IUoLJSP/lm8sI1vLsyWVBl6qSjnq9nae5w8mPG+xHAEAAA==
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
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

We can thank Ilpo Järvinen for the V3 & V4. V4 fixes an inversed if
expression bug added in [PATCH V3 6/6].

[1]: https://lore.kernel.org/all/202310050726.GDpZbMDO-lkp@intel.com/T/

Have a nice day,
Théo Lebrun

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
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

