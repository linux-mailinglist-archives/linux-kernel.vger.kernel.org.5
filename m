Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3847FD263
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 10:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjK2JYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 04:24:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjK2JYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 04:24:10 -0500
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8148710E2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 01:24:15 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=yaoma@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VxNaj96_1701249851;
Received: from 30.178.67.199(mailfrom:yaoma@linux.alibaba.com fp:SMTPD_---0VxNaj96_1701249851)
          by smtp.aliyun-inc.com;
          Wed, 29 Nov 2023 17:24:12 +0800
Message-ID: <7a1a6a34-019a-3ecc-3aee-1a92d29eb6e9@linux.alibaba.com>
Date:   Wed, 29 Nov 2023 17:24:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
From:   yaoma <yaoma@linux.alibaba.com>
Subject: Re: [PATCH] nvme: fix deadlock between reset and scan
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     axboe@kernel.dk, hch@lst.de, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, kanie@linux.alibaba.com,
        Keith Busch <kbusch@kernel.org>, yaoma@linux.alibaba.com
References: <1700737213-110685-1-git-send-email-yaoma@linux.alibaba.com>
 <ZWTa0DJmcLKHRWWC@kbusch-mbp.dhcp.thefacebook.com>
 <65b0c372-b308-46dd-c2f2-a5ddb50adb10@linux.alibaba.com>
 <c47a0edd-7437-4c21-b7cf-f969ff85bf78@grimberg.me>
Content-Language: en-US
In-Reply-To: <c47a0edd-7437-4c21-b7cf-f969ff85bf78@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.3 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Sagi Grimberg

I revised my code following your advice and carried out tests.

Test Scripts:
	for ((t=1;t<=128;t++))
	do
     	nsid=`nvme create-ns /dev/nvme0 -s 1453772 -c 1453772 -f 0\
	-m 0 -d 0 | awk -F:  '{print($NF);}'`
     	nvme attach-ns /dev/nvme0 -n $nsid -c 0
	done

	echo "resetting"
	nvme reset /dev/nvme0
	lsblk | grep nvme0 | wc -l
	sleep 2
	lsblk | grep nvme0 | wc -l

Results:
	...
	attach-ns: Success, nsid:128
	resetting
	23
	128

After the fix, we will not be deadlocked.

I find a minor issue. In the resetting state, the scan may not recognize 
all ns, but since a scan work is queued at the end of reset, so the 
impact is not significant. After the reset is completed, all ns can 
eventually be recognized.

---
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 21783aa2e..e361aba39 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3630,6 +3630,10 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, 
struct nvme_ns_info *info)
                 goto out_unlink_ns;

         down_write(&ctrl->namespaces_rwsem);
+       if (test_bit(NVME_CTRL_FROZEN, &ctrl->flags)) {
+               up_write(&ctrl->namespaces_rwsem);
+               goto out_unlink_ns;
+       }
         nvme_ns_add_to_ctrl_list(ns);
         up_write(&ctrl->namespaces_rwsem);
         nvme_get_ctrl(ctrl);
@@ -4539,6 +4543,7 @@ void nvme_unfreeze(struct nvme_ctrl *ctrl)
         list_for_each_entry(ns, &ctrl->namespaces, list)
                 blk_mq_unfreeze_queue(ns->queue);
         up_read(&ctrl->namespaces_rwsem);
+       clear_bit(NVME_CTRL_FROZEN, &ctrl->flags);
  }
  EXPORT_SYMBOL_GPL(nvme_unfreeze);

@@ -4572,6 +4577,7 @@ void nvme_start_freeze(struct nvme_ctrl *ctrl)
  {
         struct nvme_ns *ns;

+       set_bit(NVME_CTRL_FROZEN, &ctrl->flags);
         down_read(&ctrl->namespaces_rwsem);
         list_for_each_entry(ns, &ctrl->namespaces, list)
                 blk_freeze_queue_start(ns->queue);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index f35647c47..755319b0d 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -251,6 +251,7 @@ enum nvme_ctrl_flags {
         NVME_CTRL_STOPPED               = 3,
         NVME_CTRL_SKIP_ID_CNS_CS        = 4,
         NVME_CTRL_DIRTY_CAPABILITY      = 5,
+       NVME_CTRL_FROZEN                = 6,
  };

  struct nvme_ctrl {
--

On 2023/11/28 18:13, Sagi Grimberg wrote:
> 
> 
> On 11/28/23 08:22, yaoma wrote:
>> Hi Keith Busch
>>
>> Thanks for your reply.
>>
>> The idea to avoid such a deadlock between nvme_reset and nvme_scan is 
>> to ensure that no namespace can be added to ctrl->namespaces after 
>> nvme_start_freeze has already been called. We can achieve this goal by 
>> assessing the ctrl->state after we have already acquired the 
>> ctrl->namespaces_rwsem lock, to decide whether to add the namespace to 
>> the list or not.
>> 1. After we determine that ctrl->state is LIVE, it may be immediately 
>> changed to another state. However, since we have already acquired the 
>> lock, other tasks cannot access ctrl->namespace, so we can still 
>> safely add the namespace to the list. After acquiring the lock, 
>> nvme_start_freeze will freeze all ns->q in the list, including any 
>> newly added namespaces.
>> 2. Before the completion of nvme_reset, ctrl->state will not be 
>> changed to LIVE, so we will not add any more namespaces to the list. 
>> All ns->q in the list is frozen, so nvme_wait_freeze can exit normally.
> 
> I agree with the analysis, there is a hole between start_freeze and
> freeze_wait that a scan may add a ns to the ctrl ns list.
> 
> However the fix should be to mark the ctrl with say NVME_CTRL_FROZEN
> flag set in nvme_freeze_start and cleared in nvme_unfreeze (similar
> to what we did with quiesce). Then the scan can check it before adding
> the new namespace (under the namespaces_rwsem).
