Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAC8677EA23
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 21:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345971AbjHPT5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 15:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346045AbjHPT44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 15:56:56 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83AD72D5D;
        Wed, 16 Aug 2023 12:56:26 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-686be3cbea0so153571b3a.0;
        Wed, 16 Aug 2023 12:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692215786; x=1692820586;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=4vxmzu6lc7JjIoq+nTSEdJoxgezdUcawpidVrUY+UWQ=;
        b=Gw4+wwjU4xbUEDpd2AwdLpWFqceigsg69EcM89/lCqx5uKI/LU6ZLki9ULmvH8fB5z
         9mXJYphrXcPrMwmpyCZADbJAWZIN8miPBenho/l6oyIOE6/eYVFpmlNjrp1JFDOAFY1j
         zd9v0VzSOFQQruhwa3d1egHZ4H1IDa7RwDSCF4P1RBzpH/19KlpVmM6zsCDV5KXEBmFJ
         WPjoQ6oQ91FCEckATE43spvEviQQrnK4YWji8Ua8UZKYrrLbOxJS5zvNrABOqo+iJanU
         GHgbtD7svgPxBUMa5k3e9hTpZA+/jGJeE4YirQSOOFR6fH5d3nPN4oaEudUClH9npLn6
         6y1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692215786; x=1692820586;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4vxmzu6lc7JjIoq+nTSEdJoxgezdUcawpidVrUY+UWQ=;
        b=ffgztIAUYNOfPTMMnXhnw2mOxPAhY/iBj1GTFfLs7TahlshndACUUGgIw8javGFUHG
         DA0b0B3EvtkbQQdW+0tQcTk8gh5rlzBS63u5rWMCpSvREaUeO2+MvOqJcMVCCqsgJeLq
         DaMrhbfwNQcUw7GxvFXHC4ZBy67V45EP/vIssg10vaWs0rmPan2ht5w7pJTY9zg8OtuN
         nBxJsFkcu4x6gyFQ9Xn7erYU6QfvfUVzy5LcCc4tDwi1NGq5CKEizYjoUUjevs8RSCf/
         5DXCDOC6PPlY38ooJn+ld/cx2RRUIg6DrfDA2y8o7xqs982NqvALr63hvFajeMNLNBcl
         6j9A==
X-Gm-Message-State: AOJu0YxvDE0k6hFHM+S0Mn+DGuO5tJbnNhw1q58XRKVzxfC49iqbQKpz
        yY3hp0LrzBNAr8ERjjVFNaxj9pH6EWk=
X-Google-Smtp-Source: AGHT+IFv5TicirQzTeFeX8zGMlAHIn+ehTuXLjg1oSjBnDytRyjOjEtOQQ3fM+oVnV4Noc+ODjOzGA==
X-Received: by 2002:a05:6a00:139e:b0:688:79c6:1c13 with SMTP id t30-20020a056a00139e00b0068879c61c13mr776107pfg.9.1692215785858;
        Wed, 16 Aug 2023 12:56:25 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:93bd])
        by smtp.gmail.com with ESMTPSA id f15-20020aa782cf000000b00686a80f431dsm11387304pfn.126.2023.08.16.12.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 12:56:25 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 16 Aug 2023 09:56:23 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Breno Leitao <leitao@debian.org>, kernel-team@meta.com
Subject: [PATCH for-6.6/block] blk-cgroup: Fix NULL deref caused by
 blkg_policy_data being installed before init
Message-ID: <ZN0p5_W-Q9mAHBVY@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

blk-iocost sometimes causes the following crash:

  BUG: kernel NULL pointer dereference, address: 00000000000000e0
  ...
  RIP: 0010:_raw_spin_lock+0x17/0x30
  Code: be 01 02 00 00 e8 79 38 39 ff 31 d2 89 d0 5d c3 0f 1f 00 0f 1f 44 00 00 55 48 89 e5 65 ff 05 48 d0 34 7e b9 01 00 00 00 31 c0 <f0> 0f b1 0f 75 02 5d c3 89 c6 e8 ea 04 00 00 5d c3 0f 1f 84 00 00
  RSP: 0018:ffffc900023b3d40 EFLAGS: 00010046
  RAX: 0000000000000000 RBX: 00000000000000e0 RCX: 0000000000000001
  RDX: ffffc900023b3d20 RSI: ffffc900023b3cf0 RDI: 00000000000000e0
  RBP: ffffc900023b3d40 R08: ffffc900023b3c10 R09: 0000000000000003
  R10: 0000000000000064 R11: 000000000000000a R12: ffff888102337000
  R13: fffffffffffffff2 R14: ffff88810af408c8 R15: ffff8881070c3600
  FS:  00007faaaf364fc0(0000) GS:ffff88842fdc0000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00000000000000e0 CR3: 00000001097b1000 CR4: 0000000000350ea0
  Call Trace:
   <TASK>
   ioc_weight_write+0x13d/0x410
   cgroup_file_write+0x7a/0x130
   kernfs_fop_write_iter+0xf5/0x170
   vfs_write+0x298/0x370
   ksys_write+0x5f/0xb0
   __x64_sys_write+0x1b/0x20
   do_syscall_64+0x3d/0x80
   entry_SYSCALL_64_after_hwframe+0x46/0xb0

This happens because iocg->ioc is NULL. The field is initialized by
ioc_pd_init() and never cleared. The NULL deref is caused by
blkcg_activate_policy() installing blkg_policy_data before initializing it.

blkcg_activate_policy() was doing the following:

1. Allocate pd's for all existing blkg's and install them in blkg->pd[].
2. Initialize all pd's.
3. Online all pd's.

blkcg_activate_policy() only grabs the queue_lock and may release and
re-acquire the lock as allocation may need to sleep. ioc_weight_write()
grabs blkcg->lock and iterates all its blkg's. The two can race and if
ioc_weight_write() runs during #1 or between #1 and #2, it can encounter a
pd which is not initialized yet, leading to crash.

The crash can be reproduced with the following script:

  #!/bin/bash

  echo +io > /sys/fs/cgroup/cgroup.subtree_control
  systemd-run --unit touch-sda --scope dd if=/dev/sda of=/dev/null bs=1M count=1 iflag=direct
  echo 100 > /sys/fs/cgroup/system.slice/io.weight
  bash -c "echo '8:0 enable=1' > /sys/fs/cgroup/io.cost.qos" &
  sleep .2
  echo 100 > /sys/fs/cgroup/system.slice/io.weight

with the following patch applied:

> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index fc49be622e05..38d671d5e10c 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -1553,6 +1553,12 @@ int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
> 		pd->online = false;
> 	}
> 
> +       if (system_state == SYSTEM_RUNNING) {
> +               spin_unlock_irq(&q->queue_lock);
> +               ssleep(1);
> +               spin_lock_irq(&q->queue_lock);
> +       }
> +
> 	/* all allocated, init in the same order */
> 	if (pol->pd_init_fn)
> 		list_for_each_entry_reverse(blkg, &q->blkg_list, q_node)

I don't see a reason why all pd's should be allocated, initialized and
onlined together. The only ordering requirement is that parent blkgs to be
initialized and onlined before children, which is guaranteed from the
walking order. Let's fix the bug by allocating, initializing and onlining pd
for each blkg and holding blkcg->lock over initialization and onlining. This
ensures that an installed blkg is always fully initialized and onlined
removing the the race window.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Breno Leitao <leitao@debian.org>
Fixes: 9d179b865449 ("blkcg: Fix multiple bugs in blkcg_activate_policy()")
---
Hello,

This is a bug fix but I targetted it for for-6.6 and skipped tagging stable.
The bug has been there for a long time, the occurrence rate for the bug is
pretty low, and this area has been a source of repeated subtle issues, so I
think it'd be better to be a bit more careful before forwarding the patch to
stable.

Thanks.

 block/blk-cgroup.c |   32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1509,7 +1509,7 @@ int blkcg_activate_policy(struct gendisk
 retry:
 	spin_lock_irq(&q->queue_lock);
 
-	/* blkg_list is pushed at the head, reverse walk to allocate parents first */
+	/* blkg_list is pushed at the head, reverse walk to initialize parents first */
 	list_for_each_entry_reverse(blkg, &q->blkg_list, q_node) {
 		struct blkg_policy_data *pd;
 
@@ -1547,21 +1547,20 @@ retry:
 				goto enomem;
 		}
 
-		blkg->pd[pol->plid] = pd;
+		spin_lock(&blkg->blkcg->lock);
+
 		pd->blkg = blkg;
 		pd->plid = pol->plid;
-		pd->online = false;
-	}
+		blkg->pd[pol->plid] = pd;
 
-	/* all allocated, init in the same order */
-	if (pol->pd_init_fn)
-		list_for_each_entry_reverse(blkg, &q->blkg_list, q_node)
-			pol->pd_init_fn(blkg->pd[pol->plid]);
+		if (pol->pd_init_fn)
+			pol->pd_init_fn(pd);
 
-	list_for_each_entry_reverse(blkg, &q->blkg_list, q_node) {
 		if (pol->pd_online_fn)
-			pol->pd_online_fn(blkg->pd[pol->plid]);
-		blkg->pd[pol->plid]->online = true;
+			pol->pd_online_fn(pd);
+		pd->online = true;
+
+		spin_unlock(&blkg->blkcg->lock);
 	}
 
 	__set_bit(pol->plid, q->blkcg_pols);
@@ -1578,14 +1577,19 @@ out:
 	return ret;
 
 enomem:
-	/* alloc failed, nothing's initialized yet, free everything */
+	/* alloc failed, take down everything */
 	spin_lock_irq(&q->queue_lock);
 	list_for_each_entry(blkg, &q->blkg_list, q_node) {
 		struct blkcg *blkcg = blkg->blkcg;
+		struct blkg_policy_data *pd;
 
 		spin_lock(&blkcg->lock);
-		if (blkg->pd[pol->plid]) {
-			pol->pd_free_fn(blkg->pd[pol->plid]);
+		pd = blkg->pd[pol->plid];
+		if (pd) {
+			if (pd->online && pol->pd_offline_fn)
+				pol->pd_offline_fn(pd);
+			pd->online = false;
+			pol->pd_free_fn(pd);
 			blkg->pd[pol->plid] = NULL;
 		}
 		spin_unlock(&blkcg->lock);

