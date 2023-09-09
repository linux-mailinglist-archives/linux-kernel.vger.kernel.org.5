Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E9E7994C8
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 02:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345979AbjIIAlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 20:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345921AbjIIAj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 20:39:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9BC2D48;
        Fri,  8 Sep 2023 17:39:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15836C116B0;
        Sat,  9 Sep 2023 00:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694219942;
        bh=wJ6xfI5wtwNtpNIc8qhqMs2gIRhyZ8ARzS3NOYLcKek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HsMR9Qvshq2mAEDSokyIIbDJFza2PEIudME2EaulrBv0jPTH4t7Cj8nCX3WtLXBH4
         yJcyCiCzOymFULZu/lcW+ya5Wv6xJluqYEs0tzJPQl2FJ+4fb6kMFjTFuAWcy3qSyW
         HdzovnwVoow0jR+WgAEkpYmm2qphgmPotWVyZPQZbpiDDGLZY4uSdvrbcAdJ+boj7h
         /5aCxeKn7rUHCmiRkF5v5U2j2Ntcbi96kLrAoRMPun5MX0Qznq0qs9EiY27PnA86q8
         G63t8TkQXmPyFtd77cBWTOetnUreyRnfpo0wrX/73gReKbNPTIWeiMaeioOZF0Rs3i
         3QX2cV6o251aA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Drown <dan-netdev@drown.org>, Oliver Neukum <oneukum@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 24/24] usb: cdc-acm: move ldisc dcd notification outside of acm's read lock
Date:   Fri,  8 Sep 2023 20:38:16 -0400
Message-Id: <20230909003818.3580081-24-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230909003818.3580081-1-sashal@kernel.org>
References: <20230909003818.3580081-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.52
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
index 36bf051b345b8..630669a27ef5e 100644
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

