Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841F27FB1F3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 07:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343615AbjK1GWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 01:22:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbjK1GW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 01:22:29 -0500
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC9E183
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 22:22:35 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=yaoma@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VxJbmTM_1701152551;
Received: from 30.178.66.233(mailfrom:yaoma@linux.alibaba.com fp:SMTPD_---0VxJbmTM_1701152551)
          by smtp.aliyun-inc.com;
          Tue, 28 Nov 2023 14:22:33 +0800
Message-ID: <65b0c372-b308-46dd-c2f2-a5ddb50adb10@linux.alibaba.com>
Date:   Tue, 28 Nov 2023 14:22:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] nvme: fix deadlock between reset and scan
Content-Language: en-US
To:     Keith Busch <kbusch@kernel.org>
Cc:     axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        kanie@linux.alibaba.com
References: <1700737213-110685-1-git-send-email-yaoma@linux.alibaba.com>
 <ZWTa0DJmcLKHRWWC@kbusch-mbp.dhcp.thefacebook.com>
From:   yaoma <yaoma@linux.alibaba.com>
In-Reply-To: <ZWTa0DJmcLKHRWWC@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.8 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keith Busch

Thanks for your reply.

The idea to avoid such a deadlock between nvme_reset and nvme_scan is to 
ensure that no namespace can be added to ctrl->namespaces after 
nvme_start_freeze has already been called. We can achieve this goal by 
assessing the ctrl->state after we have already acquired the 
ctrl->namespaces_rwsem lock, to decide whether to add the namespace to 
the list or not.
1. After we determine that ctrl->state is LIVE, it may be immediately 
changed to another state. However, since we have already acquired the 
lock, other tasks cannot access ctrl->namespace, so we can still safely 
add the namespace to the list. After acquiring the lock, 
nvme_start_freeze will freeze all ns->q in the list, including any newly 
added namespaces.
2. Before the completion of nvme_reset, ctrl->state will not be changed 
to LIVE, so we will not add any more namespaces to the list. All ns->q 
in the list is frozen, so nvme_wait_freeze can exit normally.


On 2023/11/28 02:07, Keith Busch wrote:
> On Thu, Nov 23, 2023 at 07:00:13PM +0800, Bitao Hu wrote:
>> @@ -3631,6 +3631,11 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
>>   		goto out_unlink_ns;
>>   
>>   	down_write(&ctrl->namespaces_rwsem);
>> +	/* preventing adding ns during resetting */
>> +	if (unlikely(ctrl->state != NVME_CTRL_LIVE)) {
> 
> We can't rely on ctrl->state for preventing deadlocks. Reading unlocked
> ctrl->state is often used, but should be considered advisory-only since
> the state could change immediatly after reading it.
> 
>> +		up_write(&ctrl->namespaces_rwsem);
>> +		goto out_unlink_ns;
>> +	}
>>   	nvme_ns_add_to_ctrl_list(ns);
>>   	up_write(&ctrl->namespaces_rwsem);
>>   	nvme_get_ctrl(ctrl);
