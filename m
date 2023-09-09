Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4577479945F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 02:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346055AbjIIAmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 20:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345614AbjIIAkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 20:40:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEAD130EC;
        Fri,  8 Sep 2023 17:39:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE6F8C43397;
        Sat,  9 Sep 2023 00:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694219976;
        bh=/ovUxM6sIikuvmFQUva+A4HDXCUuG48oVpDePzHxYeg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GiuPZVXBEKd+FZefMbNHiJG3ZX5EHPW3uUJuipbG2lGHrRIH72wbHauktKLqY6TzV
         tHKE3OUdyvttZ0VE+p35DleCK14M1kvI7d0Cb6C7YkvOL0u57OSMSHIp4wOcd7RTX6
         HSVeGD2ZA6bbrFP3UMVFPUYknQUb+C4lAheDd+raAZW288d2+CrB33gZ5HrWyEG/PU
         w4kgcvmgiNCZkTwnbqZME3wsM/8pVr2xru4cAZNpaCNr77DpFxADnQEq/QWTkovJa2
         Ge8rW+k4DDnNDN592uP6oGIHZt7QpUolyk10p0dF45SNzItdU3pbPjYrT0rOjMkSMh
         ZzQq7ZJVO/usA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Xu Yang <xu.yang_2@nxp.com>, Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, stern@rowland.harvard.edu,
        linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 16/19] usb: ehci: add workaround for chipidea PORTSC.PEC bug
Date:   Fri,  8 Sep 2023 20:39:00 -0400
Message-Id: <20230909003903.3580394-16-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230909003903.3580394-1-sashal@kernel.org>
References: <20230909003903.3580394-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.131
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

From: Xu Yang <xu.yang_2@nxp.com>

[ Upstream commit dda4b60ed70bd670eefda081f70c0cb20bbeb1fa ]

Some NXP processor using chipidea IP has a bug when frame babble is
detected.

As per 4.15.1.1.1 Serial Bus Babble:
  A babble condition also exists if IN transaction is in progress at
High-speed SOF2 point. This is called frame babble. The host controller
must disable the port to which the frame babble is detected.

The USB controller has disabled the port (PE cleared) and has asserted
USBERRINT when frame babble is detected, but PEC is not asserted.
Therefore, the SW isn't aware that port has been disabled. Then the
SW keeps sending packets to this port, but all of the transfers will
fail.

This workaround will firstly assert PCD by SW when USBERRINT is detected
and then judge whether port change has really occurred or not by polling
roothub status. Because the PEC doesn't get asserted in our case, this
patch will also assert it by SW when specific conditions are satisfied.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
Acked-by: Peter Chen <peter.chen@kernel.org>
Link: https://lore.kernel.org/r/20230809024432.535160-1-xu.yang_2@nxp.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/ehci-hcd.c |  8 ++++++--
 drivers/usb/host/ehci-hub.c | 10 +++++++++-
 drivers/usb/host/ehci.h     | 10 ++++++++++
 3 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index 1440803216297..02044d45edded 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -755,10 +755,14 @@ static irqreturn_t ehci_irq (struct usb_hcd *hcd)
 
 	/* normal [4.15.1.2] or error [4.15.1.1] completion */
 	if (likely ((status & (STS_INT|STS_ERR)) != 0)) {
-		if (likely ((status & STS_ERR) == 0))
+		if (likely ((status & STS_ERR) == 0)) {
 			INCR(ehci->stats.normal);
-		else
+		} else {
+			/* Force to check port status */
+			if (ehci->has_ci_pec_bug)
+				status |= STS_PCD;
 			INCR(ehci->stats.error);
+		}
 		bh = 1;
 	}
 
diff --git a/drivers/usb/host/ehci-hub.c b/drivers/usb/host/ehci-hub.c
index c4f6a2559a987..0350c03dc97a1 100644
--- a/drivers/usb/host/ehci-hub.c
+++ b/drivers/usb/host/ehci-hub.c
@@ -674,7 +674,8 @@ ehci_hub_status_data (struct usb_hcd *hcd, char *buf)
 
 		if ((temp & mask) != 0 || test_bit(i, &ehci->port_c_suspend)
 				|| (ehci->reset_done[i] && time_after_eq(
-					jiffies, ehci->reset_done[i]))) {
+					jiffies, ehci->reset_done[i]))
+				|| ehci_has_ci_pec_bug(ehci, temp)) {
 			if (i < 7)
 			    buf [0] |= 1 << (i + 1);
 			else
@@ -874,6 +875,13 @@ int ehci_hub_control(
 		if (temp & PORT_PEC)
 			status |= USB_PORT_STAT_C_ENABLE << 16;
 
+		if (ehci_has_ci_pec_bug(ehci, temp)) {
+			status |= USB_PORT_STAT_C_ENABLE << 16;
+			ehci_info(ehci,
+				"PE is cleared by HW port:%d PORTSC:%08x\n",
+				wIndex + 1, temp);
+		}
+
 		if ((temp & PORT_OCC) && (!ignore_oc && !ehci->spurious_oc)){
 			status |= USB_PORT_STAT_C_OVERCURRENT << 16;
 
diff --git a/drivers/usb/host/ehci.h b/drivers/usb/host/ehci.h
index fdd073cc053b8..9888ca5f5f36f 100644
--- a/drivers/usb/host/ehci.h
+++ b/drivers/usb/host/ehci.h
@@ -207,6 +207,7 @@ struct ehci_hcd {			/* one per controller */
 	unsigned		has_fsl_port_bug:1; /* FreeScale */
 	unsigned		has_fsl_hs_errata:1;	/* Freescale HS quirk */
 	unsigned		has_fsl_susp_errata:1;	/* NXP SUSP quirk */
+	unsigned		has_ci_pec_bug:1;	/* ChipIdea PEC bug */
 	unsigned		big_endian_mmio:1;
 	unsigned		big_endian_desc:1;
 	unsigned		big_endian_capbase:1;
@@ -706,6 +707,15 @@ ehci_port_speed(struct ehci_hcd *ehci, unsigned int portsc)
  */
 #define ehci_has_fsl_susp_errata(e)	((e)->has_fsl_susp_errata)
 
+/*
+ * Some Freescale/NXP processors using ChipIdea IP have a bug in which
+ * disabling the port (PE is cleared) does not cause PEC to be asserted
+ * when frame babble is detected.
+ */
+#define ehci_has_ci_pec_bug(e, portsc) \
+	((e)->has_ci_pec_bug && ((e)->command & CMD_PSE) \
+	 && !(portsc & PORT_PEC) && !(portsc & PORT_PE))
+
 /*
  * While most USB host controllers implement their registers in
  * little-endian format, a minority (celleb companion chip) implement
-- 
2.40.1

