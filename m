Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7287F71CB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 11:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345667AbjKXKl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 05:41:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345372AbjKXKlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 05:41:55 -0500
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C809D1A8;
        Fri, 24 Nov 2023 02:42:01 -0800 (PST)
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
        by mail5.25mail.st (Postfix) with ESMTPSA id 053E6604D9;
        Fri, 24 Nov 2023 10:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
        s=25mailst; t=1700822520;
        bh=EvV+8V5WehTEzKe/Wr+A4+PdH+JfHp240DufQNX02/s=;
        h=From:To:Cc:Subject:Date:From;
        b=t/2H36ys8+MpW4QyMj941pP0+/2MD7iURoyzXQIy2sgqgAPQdLvr5BYDS6D2BYThA
         zn4rrMFdlQcnpQcRJktrFss8wGWC13fMECO+xfUVHSRzHbzjUQst0GqKFt6TtwFMNW
         4TU6w8kG+1lmerZ/2kjWsDVCtoH7OX1dXxTYkWyh5kCU9iMaRmUerKB0HrS2cadqrX
         0lYAlVKwFxxdxOKMAxlWCCpxlgxSVGwKZDk9baG/oz1eU4OSDmm4Ef6JeOkPgrDyOI
         FWAgSGRhglCCo+30c1Iz6+qJuda3wURrTII3cEMCMNc+5YJmhnKDpjC95ez+rTLlXq
         fqwYVZM9VvjGA==
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     Dhruva Gole <d-gole@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Keerthy <j-keerthy@ti.com>, Kevin Hilman <khilman@baylibre.com>,
        Nishanth Menon <nm@ti.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] bus: ti-sysc: Flush posted write only after srst_udelay
Date:   Fri, 24 Nov 2023 12:41:33 +0200
Message-ID: <20231124104133.19100-1-tony@atomide.com>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 34539b442b3b ("bus: ti-sysc: Flush posted write on enable before
reset") caused a regression reproducable on omap4 duovero where the ISS
target module can produce interconnect errors on boot. Turns out the
registers are not accessible until after a delay for devices needing
a ti,sysc-delay-us value.

Let's fix this by flushing the posted write only after the reset delay.
We do flushing also for ti,sysc-delay-us using devices as that should
trigger an interconnect error if the delay is not properly configured.

Let's also add some comments while at it.

Fixes: 34539b442b3b ("bus: ti-sysc: Flush posted write on enable before reset")
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -2158,13 +2158,23 @@ static int sysc_reset(struct sysc *ddata)
 		sysc_val = sysc_read_sysconfig(ddata);
 		sysc_val |= sysc_mask;
 		sysc_write(ddata, sysc_offset, sysc_val);
-		/* Flush posted write */
+
+		/*
+		 * Some devices need a delay before reading registers
+		 * after reset. Presumably a srst_udelay is not needed
+		 * for devices that use a rstctrl register reset.
+		 */
+		if (ddata->cfg.srst_udelay)
+			fsleep(ddata->cfg.srst_udelay);
+
+		/*
+		 * Flush posted write. For devices needing srst_udelay
+		 * this should trigger an interconnect error if the
+		 * srst_udelay value is needed but not configured.
+		 */
 		sysc_val = sysc_read_sysconfig(ddata);
 	}
 
-	if (ddata->cfg.srst_udelay)
-		fsleep(ddata->cfg.srst_udelay);
-
 	if (ddata->post_reset_quirk)
 		ddata->post_reset_quirk(ddata);
 
-- 
2.42.1
