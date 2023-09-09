Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4BDE79951C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 02:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344958AbjIIApW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 20:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346218AbjIIAo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 20:44:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99A549E2;
        Fri,  8 Sep 2023 17:41:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A8A3C433B6;
        Sat,  9 Sep 2023 00:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694220103;
        bh=fLcu8UD3puOiy/FNqxKckIm+B6L/u469GwTcpJBu9r0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tkIGUXTY0oya4HKgrbToszic7fpzDIDW4lJo0K057BkXyr6Jj0EHzn8dDiyXAZA7P
         8AmZeZyHEDWj8HSWnGZxAjBLnjMTW1q6v6WS+pw6wZYqDGqTnDNL4HIxSlcaUgLkgJ
         tcgEWyjGxtN+7/7DVH3ZPVfTlf5g0H8Qn+LbxsJ0VFifQkksk2ACHeh6cRysMjBh8G
         B3pBWT2keIK/1ciQau6sJH8nN+UBav/SzheKImsk4gX6lj+KNaBBKtxER1j4f36lii
         6otSq/8c8cxqymsdweKduOzi1SECQtSrBDrH8hQR4U2sCS+7JY33r04rmgWLRiJ+Ec
         yMsHEivgMUYRw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com, u.kleine-koenig@pengutronix.de,
        linux-serial@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 11/12] serial: cpm_uart: Avoid suspicious locking
Date:   Fri,  8 Sep 2023 20:41:14 -0400
Message-Id: <20230909004115.3581195-11-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230909004115.3581195-1-sashal@kernel.org>
References: <20230909004115.3581195-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.14.325
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe Leroy <christophe.leroy@csgroup.eu>

[ Upstream commit 36ef11d311f405e55ad8e848c19b212ff71ef536 ]

  CHECK   drivers/tty/serial/cpm_uart/cpm_uart_core.c
drivers/tty/serial/cpm_uart/cpm_uart_core.c:1271:39: warning: context imbalance in 'cpm_uart_console_write' - unexpected unlock

Allthough 'nolock' is not expected to change, sparse find the following
form suspicious:

	if (unlikely(nolock)) {
		local_irq_save(flags);
	} else {
		spin_lock_irqsave(&pinfo->port.lock, flags);
	}

	cpm_uart_early_write(pinfo, s, count, true);

	if (unlikely(nolock)) {
		local_irq_restore(flags);
	} else {
		spin_unlock_irqrestore(&pinfo->port.lock, flags);
	}

Rewrite it a more obvious form:

	if (unlikely(oops_in_progress)) {
		local_irq_save(flags);
		cpm_uart_early_write(pinfo, s, count, true);
		local_irq_restore(flags);
	} else {
		spin_lock_irqsave(&pinfo->port.lock, flags);
		cpm_uart_early_write(pinfo, s, count, true);
		spin_unlock_irqrestore(&pinfo->port.lock, flags);
	}

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Link: https://lore.kernel.org/r/f7da5cdc9287960185829cfef681a7d8614efa1f.1691068700.git.christophe.leroy@csgroup.eu
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/cpm_uart/cpm_uart_core.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/cpm_uart/cpm_uart_core.c b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
index 8f5a5a16cb3b2..f0af8a6de0aae 100644
--- a/drivers/tty/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
@@ -1283,19 +1283,14 @@ static void cpm_uart_console_write(struct console *co, const char *s,
 {
 	struct uart_cpm_port *pinfo = &cpm_uart_ports[co->index];
 	unsigned long flags;
-	int nolock = oops_in_progress;
 
-	if (unlikely(nolock)) {
+	if (unlikely(oops_in_progress)) {
 		local_irq_save(flags);
-	} else {
-		spin_lock_irqsave(&pinfo->port.lock, flags);
-	}
-
-	cpm_uart_early_write(pinfo, s, count, true);
-
-	if (unlikely(nolock)) {
+		cpm_uart_early_write(pinfo, s, count, true);
 		local_irq_restore(flags);
 	} else {
+		spin_lock_irqsave(&pinfo->port.lock, flags);
+		cpm_uart_early_write(pinfo, s, count, true);
 		spin_unlock_irqrestore(&pinfo->port.lock, flags);
 	}
 }
-- 
2.40.1

