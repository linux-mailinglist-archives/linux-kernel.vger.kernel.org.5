Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7B07D3F6D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 20:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjJWSmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 14:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjJWSmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 14:42:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD96FD
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 11:42:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C0A6C433C8;
        Mon, 23 Oct 2023 18:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698086569;
        bh=hrmsA8N5KMYG1BNaGTU3gWjxtFW+5h+S/xOgcGAddMc=;
        h=From:Date:Subject:To:Cc:From;
        b=oA2afsj7jrVccWVEXOEttY1lFuGzquYWrvW6NgzGal+6Cw/a1+rz2Lx4Yiel9S4lg
         egCsIcNoLBB2SVQWXleFMDXbuy7aoNtHYWInzYPnnFeqMYELDb/kZK8VEsjDMYPzoZ
         ufmYBljwGkguIhusb8V/P5m7FgS8qld9+x7eG//H+CECti89D34N2irPJmsBRvVw6n
         Eyr+rqcgqADK5CY1O56ADGth0bn3wDBTE28cW3t+qTaGte2JPKWC40lVuDKzZa3Tgw
         FLupM9NpUbqub3go0VBpTNIDKThiKT7o1IJjE4A1acFo4QV3p/zkR+ndgtP9A0Fa5k
         uBgWmpQvEqaEw==
From:   Mark Brown <broonie@kernel.org>
Date:   Mon, 23 Oct 2023 19:42:45 +0100
Subject: [PATCH v2] tools/nolibc: Use linux/wait.h rather than duplicating
 it
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231023-nolibc-waitpid-flags-v2-1-b09d096f091f@kernel.org>
X-B4-Tracking: v=1; b=H4sIAKW+NmUC/4WNQQ6CMBBFr0Jm7Zi2aIquuIdhUehQJpKWtKRqC
 He3cgGX7yX//Q0SRaYE92qDSJkTB19AnSoYJuMdIdvCoISqpVACfZi5H/BleF3Y4jgbl7ARZhD
 6avqbbqBMl0gjv4/soys8cVpD/BwvWf7sn2CWKLGRtRZaWUPy0j4peprPITro9n3/AmwsCBq5A
 AAA
To:     Willy Tarreau <w@1wt.eu>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1413; i=broonie@kernel.org;
 h=from:subject:message-id; bh=hrmsA8N5KMYG1BNaGTU3gWjxtFW+5h+S/xOgcGAddMc=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlNr6nyKLc40k46owa7+65dXV4UeF+5KVF7rh0qW3E
 +8JBQ0iJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZTa+pwAKCRAk1otyXVSH0BioB/
 9W1W7Ji6jQaGClhyqyR2HzbajM+VdQ48VO/YSCx4FrGZIfmvKCL1cZypwBrKr27hMSuiMsXLp3WtFC
 zEWBoH1p3r7qLZ6fJGWk6urqaZexXElp99Wq4KwsHuW125Sk7uywOmpoamnQLZsmuAvXfkFjAsrYmB
 h1Jup9MZuP6S21wTAwFFjYBDO9H9WYaBBguFEK8tmBCKhMIBQHJG+sEUDFB71PQiQmBPnbFitCOix0
 2Aq6zbwCjk+IbJ8JcnbX9IgbNMlqM90nUhZ0yHEpRtYbdkmDhP2+JPavl7IJS9m8PHH+yboxZzBkXd
 xzStTL42eluduDev4NfQ4OpvYXbVvm
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux defines a few custom flags for waitpid() which aren't currently
provided by nolibc, make them available to nolibc based programs by just
including linux/wait.h where they are defined instead of defining our
own copy of the flags.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v2:
- Use linux/wait.h rather than defining things locally.
- Link to v1: https://lore.kernel.org/r/20231020-nolibc-waitpid-flags-v1-1-8137072dae14@kernel.org
---
 tools/include/nolibc/types.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/include/nolibc/types.h b/tools/include/nolibc/types.h
index 8cfc4c860fa4..ad0ddaa89e50 100644
--- a/tools/include/nolibc/types.h
+++ b/tools/include/nolibc/types.h
@@ -12,6 +12,7 @@
 #include <linux/reboot.h> /* for LINUX_REBOOT_* */
 #include <linux/stat.h>
 #include <linux/time.h>
+#include <linux/wait.h>
 
 
 /* Only the generic macros and types may be defined here. The arch-specific
@@ -108,9 +109,6 @@
 #define WTERMSIG(status)    ((status) & 0x7f)
 #define WIFSIGNALED(status) ((status) - 1 < 0xff)
 
-/* waitpid() flags */
-#define WNOHANG      1
-
 /* standard exit() codes */
 #define EXIT_SUCCESS 0
 #define EXIT_FAILURE 1

---
base-commit: 6465e260f48790807eef06b583b38ca9789b6072
change-id: 20231020-nolibc-waitpid-flags-80ac075ab978

Best regards,
-- 
Mark Brown <broonie@kernel.org>

