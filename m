Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4177FC173
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346747AbjK1SAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 13:00:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346520AbjK1SA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 13:00:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4AE8D5B
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 10:00:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08EC0C433C8;
        Tue, 28 Nov 2023 18:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701194433;
        bh=/gFbOX4F6s+/kOnZpinHF5H/p/09WqRtksDYYY0r3d0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HYV2VFHp/dijSQG9xQiRQATmwkzl/4Q4UefhRaedMHB4yKrhw/ZKm5CobKmeG5+Jz
         WXnTWvJDKtiFYaU5pl6sYW+wRbzlMWIcFMu8f7bnPXuIQ4JgmodElqyeR7rn8M7oaM
         i7YMRYf4Vc/C4A2eSFT15X0gu4XfPoCWmkpoJVNVdWyM5Id/7KxX4PIcZ04rP++n8G
         UfPsOnalrMVyYiv7aM8jnmFSjmZXBTVmhTpdvyENerqqoASAbTunzYeQxzTQbLaCSl
         E6vdSel6v6OhKJ8Lz0fBOvbk12LJbgoBaCNMMAVh1drSNy/gh33KBODAQ400OV6sg5
         Hcm6wctJ6LKOg==
Date:   Tue, 28 Nov 2023 11:00:30 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     yaoma <yaoma@linux.alibaba.com>, axboe@kernel.dk, hch@lst.de,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        kanie@linux.alibaba.com
Subject: Re: [PATCH] nvme: fix deadlock between reset and scan
Message-ID: <ZWYqvo86PI6iHoXV@kbusch-mbp.dhcp.thefacebook.com>
References: <1700737213-110685-1-git-send-email-yaoma@linux.alibaba.com>
 <ZWTa0DJmcLKHRWWC@kbusch-mbp.dhcp.thefacebook.com>
 <65b0c372-b308-46dd-c2f2-a5ddb50adb10@linux.alibaba.com>
 <c47a0edd-7437-4c21-b7cf-f969ff85bf78@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c47a0edd-7437-4c21-b7cf-f969ff85bf78@grimberg.me>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 12:13:59PM +0200, Sagi Grimberg wrote:
> 
> 
> On 11/28/23 08:22, yaoma wrote:
> > Hi Keith Busch
> > 
> > Thanks for your reply.
> > 
> > The idea to avoid such a deadlock between nvme_reset and nvme_scan is to
> > ensure that no namespace can be added to ctrl->namespaces after
> > nvme_start_freeze has already been called. We can achieve this goal by
> > assessing the ctrl->state after we have already acquired the
> > ctrl->namespaces_rwsem lock, to decide whether to add the namespace to
> > the list or not.
> > 1. After we determine that ctrl->state is LIVE, it may be immediately
> > changed to another state. However, since we have already acquired the
> > lock, other tasks cannot access ctrl->namespace, so we can still safely
> > add the namespace to the list. After acquiring the lock,
> > nvme_start_freeze will freeze all ns->q in the list, including any newly
> > added namespaces.
> > 2. Before the completion of nvme_reset, ctrl->state will not be changed
> > to LIVE, so we will not add any more namespaces to the list. All ns->q
> > in the list is frozen, so nvme_wait_freeze can exit normally.
> 
> I agree with the analysis, there is a hole between start_freeze and
> freeze_wait that a scan may add a ns to the ctrl ns list.
> 
> However the fix should be to mark the ctrl with say NVME_CTRL_FROZEN
> flag set in nvme_freeze_start and cleared in nvme_unfreeze (similar
> to what we did with quiesce). Then the scan can check it before adding
> the new namespace (under the namespaces_rwsem).

Could we just make sure that scan_work isn't running? If we reset a live
controller, then we're not depending on reset_work to unblock scan_work,
and can let scan_work end gracefully. The scan_work can't be rescheduled
again while in the resetting state.

---
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index fad4cccce745c..5d6305475bad5 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2701,8 +2701,10 @@ static void nvme_reset_work(struct work_struct *work)
         * If we're called to reset a live controller first shut it down before
         * moving on.
         */
-       if (dev->ctrl.ctrl_config & NVME_CC_ENABLE)
+       if (dev->ctrl.ctrl_config & NVME_CC_ENABLE) {
+               flush_work(&dev->ctrl.scan_work);
                nvme_dev_disable(dev, false);
+       }
        nvme_sync_queues(&dev->ctrl);

        mutex_lock(&dev->shutdown_lock);
--
