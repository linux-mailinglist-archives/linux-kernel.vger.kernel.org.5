Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A05779F9F1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 07:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234722AbjINFQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 01:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234197AbjINFQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 01:16:38 -0400
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9721BCF
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 22:16:33 -0700 (PDT)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202309140516316b578876157cef1ed1
        for <linux-kernel@vger.kernel.org>;
        Thu, 14 Sep 2023 07:16:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=gZzddzoCMxHTB8tXxt4nFUsRH1Ri6FrsG2SDJTbPMf8=;
 b=KYKJ7ov/T2XaL6vsynXP+1JVPCCad16UuTf2C1IZQxkQeA69EG9YgLEtKlMD/ey9UPJ+PY
 68a1TYHo1CcrJxYrDXbJaOfr3WKjv94RJvM/+pbnDNRvhPvEdNi8hMgTMVOeAWoo7qKoSSHW
 sQOAEqymDHOaLNqWRsxEGSz8mvYIo=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, hedonistsmith@gmail.com,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH 1/1] Revert "tty: n_gsm: fix UAF in gsm_cleanup_mux"
Date:   Thu, 14 Sep 2023 07:15:07 +0200
Message-Id: <20230914051507.3240-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Starke <daniel.starke@siemens.com>

This reverts commit 9b9c8195f3f0d74a826077fc1c01b9ee74907239.

The commit above is reverted as it did not solve the original issue.

gsm_cleanup_mux() tries to free up the virtual ttys by calling
gsm_dlci_release() for each available DLCI. There, dlci_put() is called to
decrease the reference counter for the DLCI via tty_port_put() which
finally calls gsm_dlci_free(). This already clears the pointer which is
being checked in gsm_cleanup_mux() before calling gsm_dlci_release().
Therefore, it is not necessary to clear this pointer in gsm_cleanup_mux()
as done in the reverted commit. The commit introduces a null pointer
dereference:
 <TASK>
 ? __die+0x1f/0x70
 ? page_fault_oops+0x156/0x420
 ? search_exception_tables+0x37/0x50
 ? fixup_exception+0x21/0x310
 ? exc_page_fault+0x69/0x150
 ? asm_exc_page_fault+0x26/0x30
 ? tty_port_put+0x19/0xa0
 gsmtty_cleanup+0x29/0x80 [n_gsm]
 release_one_tty+0x37/0xe0
 process_one_work+0x1e6/0x3e0
 worker_thread+0x4c/0x3d0
 ? __pfx_worker_thread+0x10/0x10
 kthread+0xe1/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x2f/0x50
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1b/0x30
 </TASK>

The actual issue is that nothing guards dlci_put() from being called
multiple times while the tty driver was triggered but did not yet finished
calling gsm_dlci_free().

Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

I plan to create a bug report for this issue around next month as I have no
solution for this at hand.

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index b3550ff9c494..1f3aba607cd5 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -3097,10 +3097,8 @@ static void gsm_cleanup_mux(struct gsm_mux *gsm, bool disc)
 		gsm->has_devices = false;
 	}
 	for (i = NUM_DLCI - 1; i >= 0; i--)
-		if (gsm->dlci[i]) {
+		if (gsm->dlci[i])
 			gsm_dlci_release(gsm->dlci[i]);
-			gsm->dlci[i] = NULL;
-		}
 	mutex_unlock(&gsm->mutex);
 	/* Now wipe the queues */
 	tty_ldisc_flush(gsm->tty);
-- 
2.34.1

