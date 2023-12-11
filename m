Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD5580CA73
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 14:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343589AbjLKNEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 08:04:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343502AbjLKNEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 08:04:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FED9AF
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 05:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702299876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6+FXF6FtRGXzXSfZqfDd6orRiVmldhaVk3zyYliH12s=;
        b=T0FU+OBLZ7gDo2SqpGBl4fe6msTfJR/Hbh+lvg2s+WMSGob39NHISsy2tSxvwHne45SRof
        trZPrCxTqDa8OHMU9gTnEQGsxQ7kCaOrjZlaP63Rv5KjR7JqbT/98a8o8nLFwzWgDrhXb6
        6qtqURRWY0ShwuBtFAEgdCwfMrnSJyI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-v5LhRUDeNfe9V6iiU7CV2A-1; Mon, 11 Dec 2023 08:04:33 -0500
X-MC-Unique: v5LhRUDeNfe9V6iiU7CV2A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AFEB7101A52A;
        Mon, 11 Dec 2023 13:04:32 +0000 (UTC)
Received: from metal.redhat.com (unknown [10.45.224.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0FF311C060B1;
        Mon, 11 Dec 2023 13:04:30 +0000 (UTC)
From:   Daniel Vacek <neelx@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Vacek <neelx@redhat.com>,
        Yuya Fujita-bishamonten <fj-lsoft-rh-driver@dl.jp.fujitsu.com>
Subject: [PATCH 1/2] IB/ipoib: Fix mcast list locking
Date:   Mon, 11 Dec 2023 14:04:24 +0100
Message-ID: <20231211130426.1500427-2-neelx@redhat.com>
In-Reply-To: <20231211130426.1500427-1-neelx@redhat.com>
References: <20231211130426.1500427-1-neelx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need an additional protection against list removal between ipoib_mcast_join_task()
and ipoib_mcast_dev_flush() in case the &priv->lock needs to be dropped while
iterating the &priv->multicast_list in ipoib_mcast_join_task(). If the mcast
is removed while the lock was dropped, the for loop spins forever resulting
in a hard lockup (as was reported on RHEL 4.18.0-372.75.1.el8_6 kernel):

    Task A (kworker/u72:2 below)       | Task B (kworker/u72:0 below)
    -----------------------------------+-----------------------------------
    ipoib_mcast_join_task(work)        | ipoib_ib_dev_flush_light(work)
      spin_lock_irq(&priv->lock)       | __ipoib_ib_dev_flush(priv, ...)
      list_for_each_entry(mcast,       | ipoib_mcast_dev_flush(dev = priv->dev)
          &priv->multicast_list, list) |   mutex_lock(&priv->mcast_mutex)
        ipoib_mcast_join(dev, mcast)   |
          spin_unlock_irq(&priv->lock) |
                                       |   spin_lock_irqsave(&priv->lock, flags)
                                       |   list_for_each_entry_safe(mcast, tmcast,
                                       |                  &priv->multicast_list, list)
                                       |     list_del(&mcast->list);
                                       |     list_add_tail(&mcast->list, &remove_list)
                                       |   spin_unlock_irqrestore(&priv->lock, flags)
          spin_lock_irq(&priv->lock)   |
                                       |   ipoib_mcast_remove_list(&remove_list)
   (Here, mcast is no longer on the    |     list_for_each_entry_safe(mcast, tmcast,
    &priv->multicast_list and we keep  |                            remove_list, list)
    spinning on the &remove_list of the \ >>>  wait_for_completion(&mcast->done)
    other thread which is blocked and the|
    list is still valid on it's stack.)  | mutex_unlock(&priv->mcast_mutex)

Fix this by adding mutex_lock(&priv->mcast_mutex) to ipoib_mcast_join_task().
Unfortunately we could not reproduce the lockup and confirm this fix but
based on the code review I think this fix should address such lockups.

crash> bc 31
PID: 747      TASK: ff1c6a1a007e8000  CPU: 31   COMMAND: "kworker/u72:2"
--
    [exception RIP: ipoib_mcast_join_task+0x1b1]
    RIP: ffffffffc0944ac1  RSP: ff646f199a8c7e00  RFLAGS: 00000002
    RAX: 0000000000000000  RBX: ff1c6a1a04dc82f8  RCX: 0000000000000000
                                  work (&priv->mcast_task{,.work})
    RDX: ff1c6a192d60ac68  RSI: 0000000000000286  RDI: ff1c6a1a04dc8000
           &mcast->list
    RBP: ff646f199a8c7e90   R8: ff1c699980019420   R9: ff1c6a1920c9a000
    R10: ff646f199a8c7e00  R11: ff1c6a191a7d9800  R12: ff1c6a192d60ac00
                                                         mcast
    R13: ff1c6a1d82200000  R14: ff1c6a1a04dc8000  R15: ff1c6a1a04dc82d8
           dev                    priv (&priv->lock)     &priv->multicast_list (aka head)
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
--- <NMI exception stack> ---
 #5 [ff646f199a8c7e00] ipoib_mcast_join_task+0x1b1 at ffffffffc0944ac1 [ib_ipoib]
 #6 [ff646f199a8c7e98] process_one_work+0x1a7 at ffffffff9bf10967

crash> rx ff646f199a8c7e68
ff646f199a8c7e68:  ff1c6a1a04dc82f8 <<< work = &priv->mcast_task.work

crash> list -hO ipoib_dev_priv.multicast_list ff1c6a1a04dc8000
(empty)

crash> ipoib_dev_priv.mcast_task.work.func,mcast_mutex.owner.counter ff1c6a1a04dc8000
  mcast_task.work.func = 0xffffffffc0944910 <ipoib_mcast_join_task>,
  mcast_mutex.owner.counter = 0xff1c69998efec000

crash> b 8
PID: 8        TASK: ff1c69998efec000  CPU: 33   COMMAND: "kworker/u72:0"
--
 #3 [ff646f1980153d50] wait_for_completion+0x96 at ffffffff9c7d7646
 #4 [ff646f1980153d90] ipoib_mcast_remove_list+0x56 at ffffffffc0944dc6 [ib_ipoib]
 #5 [ff646f1980153de8] ipoib_mcast_dev_flush+0x1a7 at ffffffffc09455a7 [ib_ipoib]
 #6 [ff646f1980153e58] __ipoib_ib_dev_flush+0x1a4 at ffffffffc09431a4 [ib_ipoib]
 #7 [ff646f1980153e98] process_one_work+0x1a7 at ffffffff9bf10967

crash> rx ff646f1980153e68
ff646f1980153e68:  ff1c6a1a04dc83f0 <<< work = &priv->flush_light

crash> ipoib_dev_priv.flush_light.func,broadcast ff1c6a1a04dc8000
  flush_light.func = 0xffffffffc0943820 <ipoib_ib_dev_flush_light>,
  broadcast = 0x0,

The mcast(s) on the &remove_list (the remaining part of the ex &priv->multicast_list):

crash> list -s ipoib_mcast.done.done ipoib_mcast.list -H ff646f1980153e10 | paste - -
ff1c6a192bd0c200	  done.done = 0x0,
ff1c6a192d60ac00	  done.done = 0x0,

Reported-by: Yuya Fujita-bishamonten <fj-lsoft-rh-driver@dl.jp.fujitsu.com>
Signed-off-by: Daniel Vacek <neelx@redhat.com>
---
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
index 5b3154503bf4..8e4f2c8839be 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
@@ -580,6 +580,7 @@ void ipoib_mcast_join_task(struct work_struct *work)
 	}
 	netif_addr_unlock_bh(dev);
 
+	mutex_lock(&priv->mcast_mutex);
 	spin_lock_irq(&priv->lock);
 	if (!test_bit(IPOIB_FLAG_OPER_UP, &priv->flags))
 		goto out;
@@ -634,6 +635,7 @@ void ipoib_mcast_join_task(struct work_struct *work)
 				/* Found the next unjoined group */
 				if (ipoib_mcast_join(dev, mcast)) {
 					spin_unlock_irq(&priv->lock);
+					mutex_unlock(&priv->mcast_mutex);
 					return;
 				}
 			} else if (!delay_until ||
@@ -655,6 +657,7 @@ void ipoib_mcast_join_task(struct work_struct *work)
 		ipoib_mcast_join(dev, mcast);
 
 	spin_unlock_irq(&priv->lock);
+	mutex_unlock(&priv->mcast_mutex);
 }
 
 void ipoib_mcast_start_thread(struct net_device *dev)
-- 
2.43.0

