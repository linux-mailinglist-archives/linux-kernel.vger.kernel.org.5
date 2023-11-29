Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566D17FCD71
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 04:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234807AbjK2DXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 22:23:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbjK2DXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 22:23:12 -0500
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A6A1BD0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 19:23:18 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R781e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=yaoma@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VxMecw4_1701228195;
Received: from 30.178.67.199(mailfrom:yaoma@linux.alibaba.com fp:SMTPD_---0VxMecw4_1701228195)
          by smtp.aliyun-inc.com;
          Wed, 29 Nov 2023 11:23:16 +0800
Message-ID: <6430641c-0db3-d9c2-4b75-51c179c52e8d@linux.alibaba.com>
Date:   Wed, 29 Nov 2023 11:23:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] nvme: fix deadlock between reset and scan
Content-Language: en-US
To:     Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>
Cc:     axboe@kernel.dk, hch@lst.de, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, kanie@linux.alibaba.com
References: <1700737213-110685-1-git-send-email-yaoma@linux.alibaba.com>
 <ZWTa0DJmcLKHRWWC@kbusch-mbp.dhcp.thefacebook.com>
 <65b0c372-b308-46dd-c2f2-a5ddb50adb10@linux.alibaba.com>
 <c47a0edd-7437-4c21-b7cf-f969ff85bf78@grimberg.me>
 <ZWYqvo86PI6iHoXV@kbusch-mbp.dhcp.thefacebook.com>
From:   yaoma <yaoma@linux.alibaba.com>
In-Reply-To: <ZWYqvo86PI6iHoXV@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.3 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have previously tried the method that you proposed, and it could solve 
the deadlock issue. My worry is that if an I/O timeout occurs during the 
scan, it will trigger a reset. However, the reset will wait for the scan 
to end, which could introduce a new risk of deadlock.
I agree with the suggestion made by Sagi Grimberg that this approach 
does not introduce new problems.

On 2023/11/29 02:00, Keith Busch wrote:
> On Tue, Nov 28, 2023 at 12:13:59PM +0200, Sagi Grimberg wrote:
>>
>>
>> On 11/28/23 08:22, yaoma wrote:
>>> Hi Keith Busch
>>>
>>> Thanks for your reply.
>>>
>>> The idea to avoid such a deadlock between nvme_reset and nvme_scan is to
>>> ensure that no namespace can be added to ctrl->namespaces after
>>> nvme_start_freeze has already been called. We can achieve this goal by
>>> assessing the ctrl->state after we have already acquired the
>>> ctrl->namespaces_rwsem lock, to decide whether to add the namespace to
>>> the list or not.
>>> 1. After we determine that ctrl->state is LIVE, it may be immediately
>>> changed to another state. However, since we have already acquired the
>>> lock, other tasks cannot access ctrl->namespace, so we can still safely
>>> add the namespace to the list. After acquiring the lock,
>>> nvme_start_freeze will freeze all ns->q in the list, including any newly
>>> added namespaces.
>>> 2. Before the completion of nvme_reset, ctrl->state will not be changed
>>> to LIVE, so we will not add any more namespaces to the list. All ns->q
>>> in the list is frozen, so nvme_wait_freeze can exit normally.
>>
>> I agree with the analysis, there is a hole between start_freeze and
>> freeze_wait that a scan may add a ns to the ctrl ns list.
>>
>> However the fix should be to mark the ctrl with say NVME_CTRL_FROZEN
>> flag set in nvme_freeze_start and cleared in nvme_unfreeze (similar
>> to what we did with quiesce). Then the scan can check it before adding
>> the new namespace (under the namespaces_rwsem).
> 
> Could we just make sure that scan_work isn't running? If we reset a live
> controller, then we're not depending on reset_work to unblock scan_work,
> and can let scan_work end gracefully. The scan_work can't be rescheduled
> again while in the resetting state.
> 
> ---
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index fad4cccce745c..5d6305475bad5 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2701,8 +2701,10 @@ static void nvme_reset_work(struct work_struct *work)
>           * If we're called to reset a live controller first shut it down before
>           * moving on.
>           */
> -       if (dev->ctrl.ctrl_config & NVME_CC_ENABLE)
> +       if (dev->ctrl.ctrl_config & NVME_CC_ENABLE) {
> +               flush_work(&dev->ctrl.scan_work);
>                  nvme_dev_disable(dev, false);
> +       }
>          nvme_sync_queues(&dev->ctrl);
> 
>          mutex_lock(&dev->shutdown_lock);
> --
