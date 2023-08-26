Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C918178949A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 10:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbjHZIAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 04:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjHZIAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 04:00:12 -0400
Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com [203.205.221.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8D110EF;
        Sat, 26 Aug 2023 01:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1693036505;
        bh=yLUzFJjhb3rHZwHXuc55nQDUf3m7AuJZLDcqiQ2yCBg=;
        h=From:To:Cc:Subject:Date;
        b=SFU+xvWJ1V47dFuXlPU2GqPk7ZhK2/Oo3x8qUKGO4BMAGZJSAMxvrZ/kBOfz5gtaP
         gvx2qWVBny9EOz6AEv137w0jcdhQ8/F6H1fecCd6uhMFVFm2nyH6MsVpwKr674cwMT
         LS+hj/9wtUfw043MwJxVlSpgrUckemrNcp1Ev5e4=
Received: from KernelDevBox.byted.org ([180.184.51.134])
        by newxmesmtplogicsvrszc2-1.qq.com (NewEsmtp) with SMTP
        id DC294ED4; Sat, 26 Aug 2023 15:55:02 +0800
X-QQ-mid: xmsmtpt1693036502ts34msnz1
Message-ID: <tencent_7E9B9A5A97AD3B30550F1A8553D44F09C607@qq.com>
X-QQ-XMAILINFO: Ma+X2EIxQOjIZcymB7zCRGDdTTnOkkGUf5BGQvsbS7+cfu0SncJvLRqSz2IPI+
         sv/urg7BBb/heK54IuZm1CP3AcfAn/ADKjrsnzyrHQ7BZ+GadAx6N61rQD2IpvmNZwcYy0af7GJ0
         6Gc34F/8/wcVeSKcUwqHhwQJeSqw9C/Brq+pvdB+3nzB6W8/zd9fl3NyyeMzwqrOKa3nqlyc3Kf2
         LDBuOzLsVcsJQ/YUgWf41cFXO25W8Mq8N0ntDlyYUIMvc/al+ticrGfajZtdB+Ao66S98ZV4LZTj
         JjeFCqIkfzglczHdPTiVXlne7sucLhY+BXHa4j79W1E4hhP8/DJ8VdGDxSj3DsuVOWlZmfYL6OCq
         t02MaJywZTxrh6BAz8CWyu+yEDpqJZbHzVtrWNNupdSNgO4PSE1VxvLbBh9/KYvGL18hpLrRrl8l
         /a5NqgSkw6k2zbjh10UOJzJ9ZGcb+jx+H4UFpmpdU/E44Zr/gZQm6E6qcvWYnOmh3Epvn5B+j1Nk
         IEGQHGwDKO1T9hxDifsbmEKYjbVwkjz9wq8xBxPjEesDXeYs1KOfJtKSRx+AYVt0eVIvlvsMvuwo
         Tcec/EQU4Mt/h+mjUi6Pe6BfbpOHK6QVTijOO5XMlse5EnTslvxpBO07Qtw1bFcvRN3OUwxMldTE
         v2KzsTc5dTRlZIRCjRV73irAT9xuRuhYeQHZ/bn+OaoZw8tzqstqfQOYD9kwEQ0tTwH5mZXJxmrx
         iK4GQynoQkCzVjbjvYrEGDiVBCqv5PlHLMs3CubAKSKxQtM+FoZLyDj3Rx4Y+hLq1AbV5kKboUB4
         bAWzmdsMt2CZjSogzmC6lu4F/+J7JPLPQkHDlUmWwz7lMhx7B8Q+q8XpWxz1LeSDZnD9D7Ge4z9I
         Y2TQ7pa0Lz9ujt1BvjCHvYTmk9+pTxEj3IegbZ80NhkG1fpi2DMehd2/ZePgTCJUE7ucJmCNTUL+
         X/Z8QuAwuCJD4XLG2VHHmCjjTHpYWvvyKZvTMNbID+Qi8PPzR+BojAKmISI0nM
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From:   Zhang Shurong <zhang_shurong@foxmail.com>
To:     patrice.chotard@st.com
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Zhang Shurong <zhang_shurong@foxmail.com>
Subject: [PATCH v2] serial: st-asc: Fix to check return value of platform_get_irq() in asc_init_port()
Date:   Sat, 26 Aug 2023 15:54:59 +0800
X-OQ-MSGID: <20230826075459.2014059-1-zhang_shurong@foxmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The platform_get_irq might be failed and return a negative result. So
there should have an error handling code.

Fixed this by adding an error handling code.

Fixes: c4b058560762 ("serial:st-asc: Add ST ASC driver.")
Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
---
v1->v2: generated patch based on tty-next tree.

 drivers/tty/serial/st-asc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
index e7048515a79c..3d60ab6e9581 100644
--- a/drivers/tty/serial/st-asc.c
+++ b/drivers/tty/serial/st-asc.c
@@ -723,9 +723,13 @@ static int asc_init_port(struct asc_port *ascport,
 	port->ops	= &asc_uart_ops;
 	port->fifosize	= ASC_FIFO_SIZE;
 	port->dev	= &pdev->dev;
-	port->irq	= platform_get_irq(pdev, 0);
 	port->has_sysrq = IS_ENABLED(CONFIG_SERIAL_ST_ASC_CONSOLE);
 
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0)
+		return ret;
+	port->irq = ret;
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	port->membase = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(port->membase))
-- 
2.30.2

