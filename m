Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD44753349
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 09:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234841AbjGNHkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 03:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232656AbjGNHkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 03:40:20 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4ED2D75;
        Fri, 14 Jul 2023 00:40:19 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-666e64e97e2so1091061b3a.1;
        Fri, 14 Jul 2023 00:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689320419; x=1691912419;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U6ZgXRAxHZ9WXrqUR0OWVukrZRS3EcS4g4Ru3FHXwWU=;
        b=WjhlPjIgw59KQBvZoYx8J85XUYtpKdoK23LxK3g+Cl/Ft4iqUBh9UnXdvcGE8O3K+o
         PpQGNYWv3D457Px1B+KiESQYc4Bi7gwKQbF8TWuRCYiiaV+RKmZnHHctgyovExJ4JHLW
         dXubtfLeDryKGhhlgJlMIdmjPcDfqdbcGVWXkTrnvVx7gi8GqNL0UukcYIUDrwM+zAVd
         EZlRP/k5ZV6PwSV3rDJWrJR5nTqWy9W0v3wiW2iAwEPfTi8L3T0v+VJToizdCGlgWfYk
         +YHkubKJHB53rcVc71KqkpwPcf9zR4vEJ6Jd4naCmTbll83PtninrjwlJYpI7ycRX+4t
         gZww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689320419; x=1691912419;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U6ZgXRAxHZ9WXrqUR0OWVukrZRS3EcS4g4Ru3FHXwWU=;
        b=SENFsTs1tPCKbU7u3W9IWnR0qBjSZ5PoTWM0v3oqaUUphDQ/Wz8q4/3TKt+u0L3h9O
         Tbylw8NFOxbOPARqJFiff7rweN5PN3GY6nJ6K7cZ6hpl6Rs6voCPHGEZ5FTI1AyYDPZ1
         bxSzb0GUTnnTeR+4xob/8r5PMJ9+e1FNujIY0kFjBqzSQaNUesxLF4i/8ONZQNUPyrHy
         YSY2/VJHWJ7jEUhBR1QG9ZesMcUXL50I0HGflkWXU/xgaWPeSa3UkCA6MflFnvp9MBy9
         4Da8hRaidIlWtY+Pnq9FNO0Ukf9aim/TywyEYcuGpsoMElXQO4K6tnFpM+zYupB111lr
         26Aw==
X-Gm-Message-State: ABy/qLa9wZ040AIWLVRhJoDZp3SBRlk5L/+N9v/qAZyFIBuEMSkOXPC0
        vhKIPtsbcIT2q/EktmXw6Ps/Qg4lsG0=
X-Google-Smtp-Source: APBJJlFHmVuWEuEYlPkdKQ1p2BbEXSYGuy613pWjJ0KiAj8YFelqqeenWFZfKpZN5feCSqlGgJwI1A==
X-Received: by 2002:a05:6a00:c87:b0:641:d9b:a444 with SMTP id a7-20020a056a000c8700b006410d9ba444mr4240602pfv.31.1689320419337;
        Fri, 14 Jul 2023 00:40:19 -0700 (PDT)
Received: from MSCND1355B05.fareast.nevint.com ([183.242.39.186])
        by smtp.gmail.com with ESMTPSA id s15-20020a62e70f000000b00682ba300cd1sm6536336pfh.29.2023.07.14.00.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 00:40:18 -0700 (PDT)
From:   Zqiang <qiang.zhang1211@gmail.com>
To:     andreyknvl@gmail.com, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        qiang.zhang1211@gmail.com
Subject: [PATCH] USB: gadget: Fix the memory leak in raw_gadget driver
Date:   Fri, 14 Jul 2023 15:40:11 +0800
Message-Id: <20230714074011.20989-1-qiang.zhang1211@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, increasing raw_dev->count happens before invoke the
raw_queue_event(), if the raw_queue_event() return error, invoke
raw_release() will not trigger the dev_free() to be called.

[  268.905865][ T5067] raw-gadget.0 gadget.0: failed to queue event
[  268.912053][ T5067] udc dummy_udc.0: failed to start USB Raw Gadget: -12
[  268.918885][ T5067] raw-gadget.0: probe of gadget.0 failed with error -12
[  268.925956][ T5067] UDC core: USB Raw Gadget: couldn't find an available UDC or it's busy
[  268.934657][ T5067] misc raw-gadget: fail, usb_gadget_register_driver returned -16

BUG: memory leak

[<ffffffff8154bf94>] kmalloc_trace+0x24/0x90 mm/slab_common.c:1076
[<ffffffff8347eb55>] kmalloc include/linux/slab.h:582 [inline]
[<ffffffff8347eb55>] kzalloc include/linux/slab.h:703 [inline]
[<ffffffff8347eb55>] dev_new drivers/usb/gadget/legacy/raw_gadget.c:191 [inline]
[<ffffffff8347eb55>] raw_open+0x45/0x110 drivers/usb/gadget/legacy/raw_gadget.c:385
[<ffffffff827d1d09>] misc_open+0x1a9/0x1f0 drivers/char/misc.c:165

[<ffffffff8154bf94>] kmalloc_trace+0x24/0x90 mm/slab_common.c:1076
[<ffffffff8347cd2f>] kmalloc include/linux/slab.h:582 [inline]
[<ffffffff8347cd2f>] raw_ioctl_init+0xdf/0x410 drivers/usb/gadget/legacy/raw_gadget.c:460
[<ffffffff8347dfe9>] raw_ioctl+0x5f9/0x1120 drivers/usb/gadget/legacy/raw_gadget.c:1250
[<ffffffff81685173>] vfs_ioctl fs/ioctl.c:51 [inline]

[<ffffffff8154bf94>] kmalloc_trace+0x24/0x90 mm/slab_common.c:1076
[<ffffffff833ecc6a>] kmalloc include/linux/slab.h:582 [inline]
[<ffffffff833ecc6a>] kzalloc include/linux/slab.h:703 [inline]
[<ffffffff833ecc6a>] dummy_alloc_request+0x5a/0xe0 drivers/usb/gadget/udc/dummy_hcd.c:665
[<ffffffff833e9132>] usb_ep_alloc_request+0x22/0xd0 drivers/usb/gadget/udc/core.c:196
[<ffffffff8347f13d>] gadget_bind+0x6d/0x370 drivers/usb/gadget/legacy/raw_gadget.c:292

This commit therefore invoke kref_get() under the condition that
raw_queue_event() return success.

Reported-by: syzbot+feb045d335c1fdde5bf7@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=feb045d335c1fdde5bf7
Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
---
 drivers/usb/gadget/legacy/raw_gadget.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/legacy/raw_gadget.c b/drivers/usb/gadget/legacy/raw_gadget.c
index 2acece16b890..e549022642e5 100644
--- a/drivers/usb/gadget/legacy/raw_gadget.c
+++ b/drivers/usb/gadget/legacy/raw_gadget.c
@@ -310,13 +310,15 @@ static int gadget_bind(struct usb_gadget *gadget,
 	dev->eps_num = i;
 	spin_unlock_irqrestore(&dev->lock, flags);
 
-	/* Matches kref_put() in gadget_unbind(). */
-	kref_get(&dev->count);
-
 	ret = raw_queue_event(dev, USB_RAW_EVENT_CONNECT, 0, NULL);
-	if (ret < 0)
+	if (ret < 0) {
 		dev_err(&gadget->dev, "failed to queue event\n");
+		set_gadget_data(gadget, NULL);
+		return ret;
+	}
 
+	/* Matches kref_put() in gadget_unbind(). */
+	kref_get(&dev->count);
 	return ret;
 }
 
-- 
2.17.1

