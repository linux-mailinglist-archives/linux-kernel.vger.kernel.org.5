Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E95A776EC3F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 16:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235794AbjHCOUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 10:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbjHCOUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 10:20:12 -0400
X-Greylist: delayed 1385 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 03 Aug 2023 07:20:10 PDT
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1A8F7;
        Thu,  3 Aug 2023 07:20:10 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4RGr4j2Llbz9t3X;
        Thu,  3 Aug 2023 15:57:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id beVGL-Nghc2H; Thu,  3 Aug 2023 15:57:09 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4RGr4d4ktdz9t3r;
        Thu,  3 Aug 2023 15:57:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9DFD58B773;
        Thu,  3 Aug 2023 15:57:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id lUIReUQR1OXM; Thu,  3 Aug 2023 15:57:05 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.144])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D52448B763;
        Thu,  3 Aug 2023 15:57:03 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 373Duvd4494154
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 3 Aug 2023 15:56:57 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 373DuupZ494121;
        Thu, 3 Aug 2023 15:56:56 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Timur Tabi <timur@kernel.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-serial@vger.kernel.org
Subject: [PATCH v1 00/12] serial: cpm_uart: Cleanup and refactoring
Date:   Thu,  3 Aug 2023 15:56:41 +0200
Message-ID: <cover.1691068700.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691071000; l=2546; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=NoHIes4UmbMh0Oj+iKdKyDPU6aye+Gd+j7FfhzwC+rk=; b=FtnkdgyOm6dJ9NlFSzUc3f1zMzVhr+5VxwoZ/EnqjmBY6ncNnyG+0RepY+yLb9QQEuJ1mHBBS tEe2dXaVxGLBUd4lNrfdfDUklUD/x/QFbRA1Pq0TyiE7UNeN8MjMuZO
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is a dust removal and cleanup of cpm_uart serial driver.

After cleaning up things we see that CPM1 and CPM2 have so much in
common that it is not worth keeping separate code.

Once refactoring is done, there is only one .c and one .h in cpm_uart/
subdirectory so its worth getting rid of cpm_uart/ subdir.

The last part leads to the complete removal of include/linux/fs_uart_pd.h

Christophe Leroy (12):
  serial: cpm_uart: Avoid suspicious locking
  serial: cpm_uart: Remove stale prototypes and table and macros
  serial: cpm_uart: Stop using fs_uart_id enum
  serial: cpm_uart: Use get_baudrate() instead of uart_baudrate()
  serial: cpm_uart: Deduplicate cpm_set_{brg/smc_fcr/scc_fcr}()
  serial: cpm_uart: Deduplicate cpm_line_cr_cmd()
  serial: cpm_uart: Refactor cpm_uart_allocbuf()/cpm_uart_freebuf()
  serial: cpm_uart: Refactor cpm_uart_[un]map_pram()
  serial: cpm_uart: Remove cpm_uart/ subdirectory
  serial: cpm_uart: Remove stale prototype in powerpc/fsl_soc.c
  serial: cpm_uart: Don't include fs_uart_pd.h when not needed
  serial: cpm_uart: Remove linux/fs_uart_pd.h

 arch/powerpc/include/asm/fs_pd.h              |  10 --
 arch/powerpc/platforms/8xx/mpc885ads_setup.c  |   1 -
 arch/powerpc/platforms/8xx/tqm8xx_setup.c     |   1 -
 arch/powerpc/sysdev/fsl_soc.c                 |   2 -
 drivers/tty/serial/Makefile                   |   2 +-
 .../{cpm_uart/cpm_uart_core.c => cpm_uart.c}  | 157 ++++++++++++++++--
 drivers/tty/serial/{cpm_uart => }/cpm_uart.h  |  38 +----
 drivers/tty/serial/cpm_uart/Makefile          |  12 --
 drivers/tty/serial/cpm_uart/cpm_uart_cpm1.c   | 122 --------------
 drivers/tty/serial/cpm_uart/cpm_uart_cpm1.h   |  33 ----
 drivers/tty/serial/cpm_uart/cpm_uart_cpm2.c   | 156 -----------------
 drivers/tty/serial/cpm_uart/cpm_uart_cpm2.h   |  33 ----
 drivers/tty/serial/ucc_uart.c                 |   1 -
 include/linux/fs_uart_pd.h                    |  71 --------
 14 files changed, 145 insertions(+), 494 deletions(-)
 rename drivers/tty/serial/{cpm_uart/cpm_uart_core.c => cpm_uart.c} (90%)
 rename drivers/tty/serial/{cpm_uart => }/cpm_uart.h (64%)
 delete mode 100644 drivers/tty/serial/cpm_uart/Makefile
 delete mode 100644 drivers/tty/serial/cpm_uart/cpm_uart_cpm1.c
 delete mode 100644 drivers/tty/serial/cpm_uart/cpm_uart_cpm1.h
 delete mode 100644 drivers/tty/serial/cpm_uart/cpm_uart_cpm2.c
 delete mode 100644 drivers/tty/serial/cpm_uart/cpm_uart_cpm2.h
 delete mode 100644 include/linux/fs_uart_pd.h

-- 
2.41.0

