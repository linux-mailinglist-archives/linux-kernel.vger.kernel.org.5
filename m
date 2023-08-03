Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5826876E6D3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 13:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235620AbjHCL2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 07:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbjHCL2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 07:28:24 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CF2213F;
        Thu,  3 Aug 2023 04:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1691062073;
  x=1722598073;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=CWAbCO1we5B8Sov+saRxkyn+MCI47BcIO2eUN5nHl+E=;
  b=PcRsw/6/4AOp/otdDHFyvnA2ULhtRpMEPo7HlMrTAuq4VDy9rPPynRiT
   VYhkklHXVwG1D90XaSkmf+R8MVyDlMApSoUQ9JfRzAR7gW9f22X7j6RMm
   m90dsGwwxwF7JDLzPZiSrwdhGsBTWIzXPR0jqRAfm7fpzCFEvb+o3Eg5f
   sEyiDnGfbbQ34N1EasGRfiLWqXsO9zRI4T826Y4sx2pO3EC5MOdXY3bYD
   Nlvo7PyZD5bTzk9VHQZ1S8diEqQLxyGgxX9bxTFnqYwIOHKM1KLjq/ZaP
   6i5dMJBjY722tko9axMEFmjocdJbChhrdO1VQIkvro6iCf+EGuzZgf3jT
   Q==;
From:   Anton Eliasson <anton.eliasson@axis.com>
Date:   Thu, 3 Aug 2023 13:26:42 +0200
Subject: [PATCH] tty: serial: samsung: Set missing PM ops for hibernation
 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230803-samsung_tty_pm_ops-v1-1-1ea7be72194d@axis.com>
X-B4-Tracking: v=1; b=H4sIAPGOy2QC/x3MQQqAIBBA0avIrBM0g7KrRIjUVLPIxKkoorsnL
 d/i/wcYEyFDKx5IeBLTFjJ0IWBYfJhR0pgNpSqNqo2W7Fc+wuz2/XZxdVtkWQ+2mYyyvkILOYw
 JJ7r+ade/7weqG39rZAAAAA==
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>, Anton Eliasson <anton.eliasson@axis.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At least freeze, restore and thaw need to be set in order for the driver
to support system hibernation. The existing suspend/resume functions can
be reused since those functions don't touch the device's power state or
wakeup capability. Use the helper macros SET_SYSTEM_SLEEP_PM_OPS and
SET_NOIRQ_SYSTEM_SLEEP_PM_OPS for symmetry with similar drivers.

Signed-off-by: Anton Eliasson <anton.eliasson@axis.com>
---
I have not investigated the impact of adding the additional noirq
handler functions. The hardware that I tested on (Axis ARTPEC-8) appears
to work both with and without them assigned. Other similar drivers that
use noirq handlers assign them to both resume, thaw and restore so I
follow that style also.
---
 drivers/tty/serial/samsung_tty.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index b29e9dfd81a6..e2247c11067d 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -2273,9 +2273,8 @@ static int s3c24xx_serial_resume_noirq(struct device *dev)
 }
 
 static const struct dev_pm_ops s3c24xx_serial_pm_ops = {
-	.suspend = s3c24xx_serial_suspend,
-	.resume = s3c24xx_serial_resume,
-	.resume_noirq = s3c24xx_serial_resume_noirq,
+	SET_SYSTEM_SLEEP_PM_OPS(s3c24xx_serial_suspend, s3c24xx_serial_resume)
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(NULL, s3c24xx_serial_resume_noirq)
 };
 #define SERIAL_SAMSUNG_PM_OPS	(&s3c24xx_serial_pm_ops)
 

---
base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
change-id: 20230731-samsung_tty_pm_ops-7c98f309a4e9

Best regards,
-- 
Anton Eliasson <anton.eliasson@axis.com>

