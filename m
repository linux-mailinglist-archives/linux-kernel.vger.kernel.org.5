Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7925762FCA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 10:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233238AbjGZIZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 04:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbjGZIZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:25:08 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2141097;
        Wed, 26 Jul 2023 01:14:39 -0700 (PDT)
Received: from ubuntu.localdomain (unknown [124.236.128.36])
        by mail-app3 (Coremail) with SMTP id cC_KCgA36JzP1cBk53O_Cw--.42286S2;
        Wed, 26 Jul 2023 16:14:16 +0800 (CST)
From:   Duoming Zhou <duoming@zju.edu.cn>
To:     linux-kernel@vger.kernel.org
Cc:     linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
        davem@davemloft.net, UNGLinuxDriver@microchip.com,
        woojung.huh@microchip.com, Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH net] net: usb: lan78xx: reorder cleanup operations to avoid UAF bugs
Date:   Wed, 26 Jul 2023 16:14:07 +0800
Message-Id: <20230726081407.18977-1-duoming@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: cC_KCgA36JzP1cBk53O_Cw--.42286S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCr1kJFyDuFWrKr48Jw1UKFg_yoW5Zr4Dpa
        95XF98Gr1kWr45KF13ZF48XFyrurs2yw4DGryfKw4vq3Z5tFyaq3srJ397WFW3CFWDZFsx
        Zw1jqan3XFs5uaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
        JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
        n2kIc2xKxwCY02Avz4vE14v_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
        0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
        17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
        C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
        6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
        73UjIFyTuYvjfUOnmRUUUUU
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAwQIAWTAePoKggA3sX
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The timer dev->stat_monitor can schedule the delayed work dev->wq and
the delayed work dev->wq can also arm the dev->stat_monitor timer.

When the device is detaching, the net_device will be deallocated. but
the net_device private data could still be dereferenced in delayed work
or timer handler. As a result, the UAF bugs will happen.

One racy situation is shown below:

      (Thread 1)                 |      (Thread 2)
lan78xx_stat_monitor()           |
 ...                             |  lan78xx_disconnect()
 lan78xx_defer_kevent()          |    ...
  ...                            |    cancel_delayed_work_sync(&dev->wq);
  schedule_delayed_work()        |    ...
  (wait some time)               |    free_netdev(net); //free net_device
  lan78xx_delayedwork()          |
  //use net_device private data  |
  dev-> //use                    |

Although we use cancel_delayed_work_sync() to cancel the delayed work
in lan78xx_disconnect(), it could still be scheduled in timer handler
lan78xx_stat_monitor().

Another racy situation is shown below:

      (Thread 1)                |      (Thread 2)
lan78xx_delayedwork             |
 mod_timer()                    |  lan78xx_disconnect()
                                |   cancel_delayed_work_sync()
 (wait some time)               |   if (timer_pending(&dev->stat_monitor))
             	                |       del_timer_sync(&dev->stat_monitor);
 lan78xx_stat_monitor()         |   ...
  lan78xx_defer_kevent()        |   free_netdev(net); //free
   //use net_device private data|
   dev-> //use                  |

Although we use del_timer_sync() to delete the timer, the function
timer_pending() returns 0 when the timer is activated. As a result,
the del_timer_sync() will not be executed and the timer could be
re-armed.

In order to mitigate this bug, We use timer_shutdown_sync() to shutdown
the timer and then use cancel_delayed_work_sync() to cancel the delayed
work. As a result, the net_device could be deallocated safely.

What's more, the dev->flags is set to EVENT_DEV_DISCONNECT in
lan78xx_disconnect(). But it could still be set to EVENT_STAT_UPDATE
in lan78xx_stat_monitor(). So this patch put the set_bit() behind
timer_shutdown_sync().

Fixes: 77dfff5bb7e2 ("lan78xx: Fix race condition in disconnect handling")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
 drivers/net/usb/lan78xx.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index c458c030fad..59cde06aa7f 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -4224,8 +4224,6 @@ static void lan78xx_disconnect(struct usb_interface *intf)
 	if (!dev)
 		return;
 
-	set_bit(EVENT_DEV_DISCONNECT, &dev->flags);
-
 	netif_napi_del(&dev->napi);
 
 	udev = interface_to_usbdev(intf);
@@ -4233,6 +4231,8 @@ static void lan78xx_disconnect(struct usb_interface *intf)
 
 	unregister_netdev(net);
 
+	timer_shutdown_sync(&dev->stat_monitor);
+	set_bit(EVENT_DEV_DISCONNECT, &dev->flags);
 	cancel_delayed_work_sync(&dev->wq);
 
 	phydev = net->phydev;
@@ -4247,9 +4247,6 @@ static void lan78xx_disconnect(struct usb_interface *intf)
 
 	usb_scuttle_anchored_urbs(&dev->deferred);
 
-	if (timer_pending(&dev->stat_monitor))
-		del_timer_sync(&dev->stat_monitor);
-
 	lan78xx_unbind(dev, intf);
 
 	lan78xx_free_tx_resources(dev);
-- 
2.17.1

