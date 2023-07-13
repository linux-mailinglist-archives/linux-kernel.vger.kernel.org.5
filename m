Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5AE47519E5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 09:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234316AbjGMH0a convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 13 Jul 2023 03:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234195AbjGMH0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 03:26:14 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B9C2116;
        Thu, 13 Jul 2023 00:25:55 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1qJqhp-0013fl-2P; Thu, 13 Jul 2023 09:25:41 +0200
Received: from p57bd9f0d.dip0.t-ipconnect.de ([87.189.159.13] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1qJqho-001eww-Qr; Thu, 13 Jul 2023 09:25:41 +0200
Message-ID: <90e6042f3a82d5e9b4cf475603dcb73ca5e821d8.camel@physik.fu-berlin.de>
Subject: [GIT PULL] sh fixes for v6.5
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Artur Rojek <contact@artur-rojek.eu>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Thu, 13 Jul 2023 09:25:39 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.159.13
X-ZEDAT-Hint: PO
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus!

The sh updates for v6.5 introduced multiple regressions that this pull request addresses.
In particular, the change a8ac2961148e ("sh: Avoid using IRQ0 on SH3 and SH4") causes
several boards to hang during boot due to incorrect IRQ numbers.

Geert Uytterhoeven has contributed patches that handle the virq offset in the IRQ code
for the dreamcast, highlander and r2d boards while Artur Rojek has contributed a patch
which handles the virq offset for the hd64461 companion chip.

With the series applied, the affected boards will boot the kernel again without issues.

The following changes since commit 7497840d462c8f54c4888c22ab3726a8cde4b9a2:

  sh: Provide unxlate_dev_mem_ptr() in asm/io.h (2023-07-05 19:04:51 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/glaubitz/sh-linux.git tags/sh-for-v6.5-tag2

for you to fetch changes up to 7c28a35e19fafa1d3b367bcd3ec4021427a9397b:

  sh: hd64461: Handle virq offset for offchip IRQ base and HD64461 IRQ (2023-07-13 08:37:53 +0200)

Thanks for pulling!

Adrian

----------------------------------------------------------------
sh fixes for v6.5

- sh: hd64461: Handle virq offset for offchip IRQ base and HD64461 IRQ
- sh: mach-dreamcast: Handle virq offset in cascaded IRQ demux
- sh: mach-highlander: Handle virq offset in cascaded IRL demux
- sh: mach-r2d: Handle virq offset in cascaded IRL demux

----------------------------------------------------------------
Artur Rojek (1):
      sh: hd64461: Handle virq offset for offchip IRQ base and HD64461 IRQ

Geert Uytterhoeven (3):
      sh: mach-r2d: Handle virq offset in cascaded IRL demux
      sh: mach-highlander: Handle virq offset in cascaded IRL demux
      sh: mach-dreamcast: Handle virq offset in cascaded IRQ demux

 arch/sh/boards/mach-dreamcast/irq.c    | 6 +++---
 arch/sh/boards/mach-highlander/setup.c | 4 ++--
 arch/sh/boards/mach-r2d/irq.c          | 4 ++--
 arch/sh/cchips/Kconfig                 | 4 ++--
 arch/sh/include/asm/hd64461.h          | 2 +-
 5 files changed, 10 insertions(+), 10 deletions(-)

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
