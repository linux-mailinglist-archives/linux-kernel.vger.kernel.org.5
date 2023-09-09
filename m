Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A5779945C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 02:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbjIIAjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 20:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345763AbjIIAjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 20:39:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B895826B9;
        Fri,  8 Sep 2023 17:38:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE88AC4AF76;
        Sat,  9 Sep 2023 00:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694219879;
        bh=c+F/Dz8vvbceFZKEWNuOjAZJHyzYGdIT1rS7HFXFq9g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AdKb+SoSoYMmuJuiMpuFD66mi12B+Z/FgWFTg6j2pVy+ifENbkoyFLhaLvZS4OXJL
         AxxV/QmcPBTvNJVmzjoH67Q5uQTsZXLd9mlqJcBBrRjwJjzs9l/n2KGbJd67wCXzUy
         jnGLdv9YeAuVSJymuNlbnT1SwRcXAbSUH6vhwIHa+Qto4/5cUTYTHkNFQKYQb2/m1L
         qbewEHJjeaHIfXjMsdc8NPIzLffUy/dHq4OM1nTuJdSpSmqznjxvAbcqcAxSd8TVQQ
         j8twLnoIrJCE2ho8L0tkrKIxaIiHNEV0yttSDF4z77qu01ak5+QjL9o9N1UUXrQlD2
         Hfacn74N42K+Q==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Drown <dan-netdev@drown.org>, Oliver Neukum <oneukum@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 24/25] usb: cdc-acm: move ldisc dcd notification outside of acm's read lock
Date:   Fri,  8 Sep 2023 20:37:12 -0400
Message-Id: <20230909003715.3579761-24-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230909003715.3579761-1-sashal@kernel.org>
References: <20230909003715.3579761-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.15
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

From: Dan Drown <dan-netdev@drown.org>

[ Upstream commit f72ae60881ff685004d7de7152517607fcd9968f ]

dcd_change notification call moved outside of the acm->read_lock
to protect any future tty ldisc that calls wait_serial_change()

Signed-off-by: Dan Drown <dan-netdev@drown.org>
Acked-by: Oliver Neukum <oneukum@suse.com>
Link: https://lore.kernel.org/r/ZN1zV/zjPgpGlHXo@vps3.drown.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/class/cdc-acm.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index 11da5fb284d0a..ca51230f44409 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -318,6 +318,16 @@ static void acm_process_notification(struct acm *acm, unsigned char *buf)
 		}
 
 		difference = acm->ctrlin ^ newctrl;
+
+		if ((difference & USB_CDC_SERIAL_STATE_DCD) && acm->port.tty) {
+			struct tty_ldisc *ld = tty_ldisc_ref(acm->port.tty);
+			if (ld) {
+				if (ld->ops->dcd_change)
+					ld->ops->dcd_change(acm->port.tty, newctrl & USB_CDC_SERIAL_STATE_DCD);
+				tty_ldisc_deref(ld);
+			}
+		}
+
 		spin_lock_irqsave(&acm->read_lock, flags);
 		acm->ctrlin = newctrl;
 		acm->oldcount = acm->iocount;
-- 
2.40.1

