Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF797F61E0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 15:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345928AbjKWOrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 09:47:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345905AbjKWOrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 09:47:40 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3AF3D4A;
        Thu, 23 Nov 2023 06:47:45 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2CEEAE0002;
        Thu, 23 Nov 2023 14:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700750864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=MZPJxfvoysVpxIWKBdmpAvA0+UBzj52BEZXDkonKlNQ=;
        b=TcENdRs3kz8fi6vTvuiHsyqu9OJv6uHiR+bRPRhy8PQDSLgM2G0CWPJNjDggo9N67ByqMp
        KUcURLficapDrJ+MR6fO0R6raSrIkzwIbKKpzLy83l44CYmItZTfHz8lefwAtq+5U30oQv
        llDWdphYiFVsHbPtO84+JgZDJlFbGZ/hqIKwUM02DG0I7Car4ma43yF2tdTCPxGT52jQpe
        pf2dMrOQdC6mozfR1EIeBIdxnroShqdZ+3+q2oLB7MWLxJH7BRlY8n0nDzwQY0Pka3AueG
        d8xSZQvcZox56d4/r3djwELkwtb9f4RKaav38RqfGD4LUNbgR86+TPUm/UmApQ==
From:   Luca Ceresoli <luca.ceresoli@bootlin.com>
Date:   Thu, 23 Nov 2023 15:47:18 +0100
Subject: [PATCH] of: dynamic: Fix of_reconfig_get_state_change() return
 value documentation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231123-fix-of_reconfig_get_state_change-docs-v1-1-f51892050ff9@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAPVlX2UC/y2NywrDIBBFf0VmXcFHAm1+pRQJzmhmo8GREgj59
 0jp8sA995wg1JgEFnVCoy8L1zLAPhTEbS2ZNONgcMZ5a53XiQ9dU2gUa0mcQ6YepK+dwn+PNYp
 G88RpRovTy8P42hsN8dd5f67rBmhAxBN3AAAA
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Grant Likely <grant.likely@linaro.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.12.3
X-GND-Sasl: luca.ceresoli@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The documented numeric return values do not match the actual returned
values. Fix them by using the enum names instead of raw numbers.

Fixes: b53a2340d0d3 ("of/reconfig: Add of_reconfig_get_state_change() of notifier helper.")
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/of/dynamic.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index 0a3483e247a8..a5afe14eef28 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -98,8 +98,9 @@ int of_reconfig_notify(unsigned long action, struct of_reconfig_data *p)
  *
  * Returns the new state of a device based on the notifier used.
  *
- * Return: 0 on device going from enabled to disabled, 1 on device
- * going from disabled to enabled and -1 on no change.
+ * Return: OF_RECONFIG_CHANGE_REMOVE on device going from enabled to
+ * disabled, OF_RECONFIG_CHANGE_ADD on device going from disabled to
+ * enabled and OF_RECONFIG_NO_CHANGE on no change.
  */
 int of_reconfig_get_state_change(unsigned long action, struct of_reconfig_data *pr)
 {

---
base-commit: f364a65e37ec9e57809642b00b39e7a530d9cbde
change-id: 20231123-fix-of_reconfig_get_state_change-docs-d08d45d1d493

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>

