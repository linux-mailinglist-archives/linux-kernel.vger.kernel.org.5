Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 923EC79A1E7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 05:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbjIKDkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 23:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjIKDkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 23:40:37 -0400
X-Greylist: delayed 542 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 10 Sep 2023 20:40:31 PDT
Received: from mail-m3137.qiye.163.com (mail-m3137.qiye.163.com [103.74.31.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F215B11A;
        Sun, 10 Sep 2023 20:40:31 -0700 (PDT)
DKIM-Signature: a=rsa-sha256;
        b=ZWP9zoHe+DX5RxpMpCDvktXejZkc/mXd3WUzK83Kb/0HH9PEdF6I4ISrT5GZ5hjMgh289NLHxa6K4VCxPpPGda3Uy/H35COe2M8xCqyXKBZCRj62AF/ctCqP5OO2ZPJAnRH5fzOjCNG2Woeg+Q9l+SYP499fNofGzzFm9c3qW84=;
        s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
        bh=yTyYR259NicqyaHlLq9RVb03xhYZ/gDfQr/E+onC0KM=;
        h=date:mime-version:subject:message-id:from;
Received: from localhost.localdomain (unknown [58.22.7.114])
        by mail-m11880.qiye.163.com (Hmail) with ESMTPA id 976BC204F6;
        Mon, 11 Sep 2023 11:31:16 +0800 (CST)
From:   William Wu <william.wu@rock-chips.com>
To:     Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        william.wu@rock-chips.com, frank.wang@rock-chips.com,
        jianwei.zheng@rock-chips.com, yangbin@rock-chips.com
Subject: [PATCH v2] usb: dwc3: core: Avoid resume dwc3 if already suspended in pm resume
Date:   Mon, 11 Sep 2023 11:31:12 +0800
Message-Id: <20230911033112.3321-1-william.wu@rock-chips.com>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGRhCHlYZQhkdQkJPGUNMSExVEwETFh
        oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSkpLQ0hJVUpLS1VLWQ
        Y+
X-HM-Tid: 0a8a824b22c72eb6kusn976bc204f6
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PUk6Mzo5Hz0CQhYPGj8YFzMQ
        Mi4wCwNVSlVKTUJPT0tIS0xMSEJJVTMWGhIXVQwSFxcSGhZVDA47CRQYEFYYExILCFUYFBZFWVdZ
        EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJQkpLNwY+
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we enable PM runtime auto suspend for dwc3 on rockchip
platforms (e.g. RK3562), it allows the dwc3 controller to
enter runtime suspend if usb cable detached and power off
the power domain of the controller. When system resume, if
the dwc3 already in runtime suspended, it Shouldn't access
the dwc3 registers in dwc3_resume() because its power domain
maybe power off.

Test on RK3562 tablet, this patch can help to avoid kernel
panic when accessing the dwc3 registers in dwc3_resume() if
the dwc3 is in runtime suspended and it's power domain is
power off.

Kernel panic - not syncing: Asynchronous SError Interrupt
Hardware name: Rockchip RK3562 RK817 TABLET LP4 Board (DT)
Call trace:
dump_backtrace.cfi_jt+0x0/0x8
  dump_stack_lvl+0xc0/0x13c
  panic+0x174/0x468
  arm64_serror_panic+0x1b0/0x200
  do_serror+0x184/0x1e4
  el1_error+0x94/0x118
  el1_abort+0x40/0x68
  el1_sync_handler+0x58/0x88
  el1_sync+0x8c/0x140
  dwc3_readl+0x30/0x1a0
  dwc3_phy_setup+0x38/0x510
  dwc3_core_init+0x68/0xcd4
  dwc3_core_init_for_resume+0x10c/0x25c
  dwc3_resume_common+0x44/0x3d0
  dwc3_resume+0x5c/0xb8
  dpm_run_callback+0x70/0x488
  device_resume+0x250/0x2f8
  dpm_resume+0x258/0x9dc

Signed-off-by: William Wu <william.wu@rock-chips.com>
---
Changes in v2:
- Remove Change-Id.

 drivers/usb/dwc3/core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 9c6bf054f15d..8274a44f2d6a 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -2185,9 +2185,11 @@ static int dwc3_resume(struct device *dev)
 
 	pinctrl_pm_select_default_state(dev);
 
-	ret = dwc3_resume_common(dwc, PMSG_RESUME);
-	if (ret)
-		return ret;
+	if (!pm_runtime_suspended(dwc->dev)) {
+		ret = dwc3_resume_common(dwc, PMSG_RESUME);
+		if (ret)
+			return ret;
+	}
 
 	pm_runtime_disable(dev);
 	pm_runtime_set_active(dev);
-- 
2.17.1

