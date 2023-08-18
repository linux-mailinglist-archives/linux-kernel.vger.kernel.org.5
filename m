Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE0B8780F61
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 17:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378236AbjHRPif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 11:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378222AbjHRPiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 11:38:02 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 543C52D65;
        Fri, 18 Aug 2023 08:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=S86pG
        VvG1ilS8xvZNzcsHKbjpsGoOlDvIT+3HF+Qhyo=; b=FZA0jw+CgogS1+ec42Dof
        emhAkmVlCn7QCMuLOBhSQLgyLv3j4SVutoUjYcio0Q8ssV151YIflKBR31Vs93I6
        KqPwEQ48P3JO8zqtgZ/kxGgAsxUHrQnpSlopCcdj1/qwy/RCCj8+XdPYsKvvKL1x
        g6jlmRRo9+aAL1UldRFA2E=
Received: from sc9-mailhost2.vmware.com (unknown [114.250.138.216])
        by zwqz-smtp-mta-g5-3 (Coremail) with SMTP id _____wD3JXLCj99kfq+CDQ--.24616S2;
        Fri, 18 Aug 2023 23:35:30 +0800 (CST)
From:   Dingyan Li <18500469033@163.com>
To:     gregkh@linuxfoundation.org, stern@rowland.harvard.edu
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] USB: add new speed value to USB debugfs
Date:   Fri, 18 Aug 2023 23:35:09 +0800
Message-Id: <20230818153509.38814-1-18500469033@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3JXLCj99kfq+CDQ--.24616S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZr4ftFWrWF4UXryftFWrXwb_yoWfZwbEkr
        1Uuw17Za1YyFyIqF1xu34FyryFv34I939YgFn5trn5WFZFv34kArsrWryqvr15CFy7WFs7
        A3W8G3WqyF4xKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0q9aDUUUUU==
X-Originating-IP: [114.250.138.216]
X-CM-SenderInfo: jprykiiquwmiitt6il2tof0z/xtbB5xXPy2BHLUmpwgAAse
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L4,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current max speed supported in USB debugfs is 10000.
Since USB 3.2 GEN_2x2 has reached 20000, it's better
to add it. The idea is borrowed from USB sysfs, with
a combination of USB_SPEED_SUPER_PLUS and
USB_SSP_GEN_2x2, the actual speed should be 20000.

Signed-off-by: Dingyan Li <18500469033@163.com>
---
 drivers/usb/core/devices.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/devices.c b/drivers/usb/core/devices.c
index a247da73f34d..78ebcb657dce 100644
--- a/drivers/usb/core/devices.c
+++ b/drivers/usb/core/devices.c
@@ -429,7 +429,11 @@ static ssize_t usb_device_dump(char __user **buffer, size_t *nbytes,
 	case USB_SPEED_SUPER:
 		speed = "5000"; break;
 	case USB_SPEED_SUPER_PLUS:
-		speed = "10000"; break;
+		if (usbdev->ssp_rate == USB_SSP_GEN_2x2)
+			speed = "20000";
+		else
+			speed = "10000";
+		break;
 	default:
 		speed = "??";
 	}
-- 
2.25.1

