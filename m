Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027267993F1
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 02:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345760AbjIIAiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 20:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345620AbjIIAiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 20:38:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7B31FE7;
        Fri,  8 Sep 2023 17:37:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EB22C116A6;
        Sat,  9 Sep 2023 00:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694219813;
        bh=c+F/Dz8vvbceFZKEWNuOjAZJHyzYGdIT1rS7HFXFq9g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LopfeFPey3u0Ju07FMgqy41hvkIPispjffxQUJ4oDwOpBuBObGnkICY06WRH/DIkw
         oxXZa/cVZVICg5RMPp/z+a0sjCc7ZMSoIP32fHe5MHUVq49tbmmRRHmhrWKIEfgj4m
         VS8V82lWEAXPEoXt1bdoOQzfe7k4fELJM5XTbV+VwGxNmfeTx86IK8WwsPItkDNKph
         F3mo2D/HfgZ0O9ovvmhsC4gs6M8S9gVsby3TrCDQU1UmIYZHSn3Avg9PiUSEqVqmN1
         W5h5nxS4MZzYYFUyds2YDem9A6gj3r/92JpTjUrTfQZEZZFtiWMvDbqqX52R/ij7aT
         W8cpqdrAmp6yg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Drown <dan-netdev@drown.org>, Oliver Neukum <oneukum@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 26/28] usb: cdc-acm: move ldisc dcd notification outside of acm's read lock
Date:   Fri,  8 Sep 2023 20:36:00 -0400
Message-Id: <20230909003604.3579407-26-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230909003604.3579407-1-sashal@kernel.org>
References: <20230909003604.3579407-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.2
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

