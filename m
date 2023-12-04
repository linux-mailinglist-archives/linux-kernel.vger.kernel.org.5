Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0AA3802DFA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234758AbjLDIf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 03:35:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjLDIfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 03:35:55 -0500
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C81D8
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 00:35:58 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Vxlvrv8_1701678954;
Received: from 30.178.83.103(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0Vxlvrv8_1701678954)
          by smtp.aliyun-inc.com;
          Mon, 04 Dec 2023 16:35:55 +0800
Message-ID: <45ebdf06-81f9-420c-9490-3d28fd514e68@linux.alibaba.com>
Date:   Mon, 4 Dec 2023 16:35:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme: fix deadlock between reset and scan
To:     Bitao Hu <yaoma@linux.alibaba.com>, sagi@grimberg.me,
        kbusch@kernel.org
Cc:     axboe@kernel.dk, hch@lst.de, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <c47a0edd-7437-4c21-b7cf-f969ff85bf78@grimberg.me>
 <1701310417-301-1-git-send-email-yaoma@linux.alibaba.com>
Content-Language: en-GB
From:   Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <1701310417-301-1-git-send-email-yaoma@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good to me.

Reviewed-by: Guixin Liu <kanie@linux.alibaba.com>

My thanks for the advise Sagi given.

在 2023/11/30 10:13, Bitao Hu 写道:
> If controller reset occurs when allocating namespace, both
> nvme_reset_work and nvme_scan_work will hang, as shown below.
>
> Test Scripts:
>
>      for ((t=1;t<=128;t++))
>      do
>      nsid=`nvme create-ns /dev/nvme1 -s 14537724 -c 14537724 -f 0 -m 0 \
>      -d 0 | awk -F: '{print($NF);}'`
>      nvme attach-ns /dev/nvme1 -n $nsid -c 0
>      done
>      nvme reset /dev/nvme1
>
> We will find that both nvme_reset_work and nvme_scan_work hung:
>
>      INFO: task kworker/u249:4:17848 blocked for more than 120 seconds.
>      "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
>      message.
>      task:kworker/u249:4  state:D stack:    0 pid:17848 ppid:     2
>      flags:0x00000028
>      Workqueue: nvme-reset-wq nvme_reset_work [nvme]
>      Call trace:
>      __switch_to+0xb4/0xfc
>      __schedule+0x22c/0x670
>      schedule+0x4c/0xd0
>      blk_mq_freeze_queue_wait+0x84/0xc0
>      nvme_wait_freeze+0x40/0x64 [nvme_core]
>      nvme_reset_work+0x1c0/0x5cc [nvme]
>      process_one_work+0x1d8/0x4b0
>      worker_thread+0x230/0x440
>      kthread+0x114/0x120
>      INFO: task kworker/u249:3:22404 blocked for more than 120 seconds.
>      "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
>      message.
>      task:kworker/u249:3  state:D stack:    0 pid:22404 ppid:     2
>      flags:0x00000028
>      Workqueue: nvme-wq nvme_scan_work [nvme_core]
>      Call trace:
>      __switch_to+0xb4/0xfc
>      __schedule+0x22c/0x670
>      schedule+0x4c/0xd0
>      rwsem_down_write_slowpath+0x32c/0x98c
>      down_write+0x70/0x80
>      nvme_alloc_ns+0x1ac/0x38c [nvme_core]
>      nvme_validate_or_alloc_ns+0xbc/0x150 [nvme_core]
>      nvme_scan_ns_list+0xe8/0x2e4 [nvme_core]
>      nvme_scan_work+0x60/0x500 [nvme_core]
>      process_one_work+0x1d8/0x4b0
>      worker_thread+0x260/0x440
>      kthread+0x114/0x120
>      INFO: task nvme:28428 blocked for more than 120 seconds.
>      "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
>      message.
>      task:nvme            state:D stack:    0 pid:28428 ppid: 27119
>      flags:0x00000000
>      Call trace:
>      __switch_to+0xb4/0xfc
>      __schedule+0x22c/0x670
>      schedule+0x4c/0xd0
>      schedule_timeout+0x160/0x194
>      do_wait_for_common+0xac/0x1d0
>      __wait_for_common+0x78/0x100
>      wait_for_completion+0x24/0x30
>      __flush_work.isra.0+0x74/0x90
>      flush_work+0x14/0x20
>      nvme_reset_ctrl_sync+0x50/0x74 [nvme_core]
>      nvme_dev_ioctl+0x1b0/0x250 [nvme_core]
>      __arm64_sys_ioctl+0xa8/0xf0
>      el0_svc_common+0x88/0x234
>      do_el0_svc+0x7c/0x90
>      el0_svc+0x1c/0x30
>      el0_sync_handler+0xa8/0xb0
>      el0_sync+0x148/0x180
>
> The reason for the hang is that nvme_reset_work occurs while nvme_scan_work
> is still running. nvme_scan_work may add new ns into ctrl->namespaces
> list after nvme_reset_work frozen all ns->q in ctrl->namespaces list.
> The newly added ns is not frozen, so nvme_wait_freeze will wait forever.
> Unfortunately, ctrl->namespaces_rwsem is held by nvme_reset_work, so
> nvme_scan_work will also wait forever. Now we are deadlocked!
>
> PROCESS1                         PROCESS2
> ==============                   ==============
> nvme_scan_work
>    ...                            nvme_reset_work
>    nvme_validate_or_alloc_ns        nvme_dev_disable
>      nvme_alloc_ns                    nvme_start_freeze
>       down_write                      ...
>       nvme_ns_add_to_ctrl_list        ...
>       up_write                      nvme_wait_freeze
>      ...                              down_read
>      nvme_alloc_ns                    blk_mq_freeze_queue_wait
>       down_write
>
> Fix by marking the ctrl with say NVME_CTRL_FROZEN flag set in
> nvme_start_freeze and cleared in nvme_unfreeze. Then the scan can check
> it before adding the new namespace (under the namespaces_rwsem).
>
> Signed-off-by: Bitao Hu <yaoma@linux.alibaba.com>
> ---
> v1 -> v2:
> As per the review comments given by Sagi Grimberg and Keith Busch,
> did below changes in v2,
> - Add NVME_CTRL_FROZEN nvme_ctrl_flags
> - Check ctrl->flags before adding the new namespace (under the namespaces_rwsem), rather than rely on ctrl->state
> ---
>   drivers/nvme/host/core.c | 10 ++++++++++
>   drivers/nvme/host/nvme.h |  1 +
>   2 files changed, 11 insertions(+)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 62612f8..89181c7 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3631,6 +3631,14 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
>   		goto out_unlink_ns;
>   
>   	down_write(&ctrl->namespaces_rwsem);
> +	/*
> +	 * Ensure that no namespaces are added to the ctrl list after the queues
> +	 * are frozen, thereby avoiding a deadlock between scan and reset.
> +	 */
> +	if (test_bit(NVME_CTRL_FROZEN, &ctrl->flags)) {
> +		up_write(&ctrl->namespaces_rwsem);
> +		goto out_unlink_ns;
> +	}
>   	nvme_ns_add_to_ctrl_list(ns);
>   	up_write(&ctrl->namespaces_rwsem);
>   	nvme_get_ctrl(ctrl);
> @@ -4540,6 +4548,7 @@ void nvme_unfreeze(struct nvme_ctrl *ctrl)
>   	list_for_each_entry(ns, &ctrl->namespaces, list)
>   		blk_mq_unfreeze_queue(ns->queue);
>   	up_read(&ctrl->namespaces_rwsem);
> +	clear_bit(NVME_CTRL_FROZEN, &ctrl->flags);
>   }
>   EXPORT_SYMBOL_GPL(nvme_unfreeze);
>   
> @@ -4573,6 +4582,7 @@ void nvme_start_freeze(struct nvme_ctrl *ctrl)
>   {
>   	struct nvme_ns *ns;
>   
> +	set_bit(NVME_CTRL_FROZEN, &ctrl->flags);
>   	down_read(&ctrl->namespaces_rwsem);
>   	list_for_each_entry(ns, &ctrl->namespaces, list)
>   		blk_freeze_queue_start(ns->queue);
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 39a90b7..07b57df 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -251,6 +251,7 @@ enum nvme_ctrl_flags {
>   	NVME_CTRL_STOPPED		= 3,
>   	NVME_CTRL_SKIP_ID_CNS_CS	= 4,
>   	NVME_CTRL_DIRTY_CAPABILITY	= 5,
> +	NVME_CTRL_FROZEN		= 6,
>   };
>   
>   struct nvme_ctrl {
