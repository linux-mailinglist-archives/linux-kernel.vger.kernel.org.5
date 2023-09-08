Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C8B797FF8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 03:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238417AbjIHBEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 21:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjIHBEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 21:04:04 -0400
Received: from mail-m127155.qiye.163.com (mail-m127155.qiye.163.com [115.236.127.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55EB01BD7;
        Thu,  7 Sep 2023 18:03:58 -0700 (PDT)
Received: from [0.0.0.0] (unknown [IPV6:240e:3b7:3272:3e30:6019:3b45:b56:d340])
        by mail-m15581.qiye.163.com (Hmail) with ESMTPA id 15C42720193;
        Fri,  8 Sep 2023 09:03:55 +0800 (CST)
Message-ID: <8dcc39ab-be6d-6bb8-9f43-ff8695908f15@sangfor.com.cn>
Date:   Fri, 8 Sep 2023 09:03:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] scsi: scsi_dh_rdac: Avoid crash when a disk attach failed
Content-Language: en-US
From:   Ding Hui <dinghui@sangfor.com.cn>
To:     Mike Christie <michael.christie@oracle.com>,
        Huang Cun <huangcun@sangfor.com.cn>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     pengdonglin@sangfor.com.cn
References: <20230803112841.588822-1-huangcun@sangfor.com.cn>
 <d2f486dc-c987-4b8a-a694-825305f0cba0@oracle.com>
 <77e3e206-fbc7-04ca-41f7-13d6b8435b45@sangfor.com.cn>
In-Reply-To: <77e3e206-fbc7-04ca-41f7-13d6b8435b45@sangfor.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCQh9JVktJTEMfHUIZTUJCGlUTARMWGhIXJBQOD1
        lXWRgSC1lBWUlPSx5BSBlMQUhJTElBSB5IS0FNS0pCQUgZT05BGU5NQR9IT0tZV1kWGg8SFR0UWU
        FZT0tIVUpNT0lMTlVKS0tVSkJLS1kG
X-HM-Tid: 0a8a725126332e9ekusn15c42720193
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pi46Nio6Nj0BGRM3FT9DMD04
        KxAKCRVVSlVKTUJPSkhOS0hOQ0JMVTMWGhIXVR8SFRwTDhI7CBoVHB0UCVUYFBZVGBVFWVdZEgtZ
        QVlJT0seQUgZTEFISUxJQUgeSEtBTUtKQkFIGU9OQRlOTUEfSE9LWVdZCAFZQU5LT003Bg++
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/9/7 9:45, Ding Hui wrote:
> On 2023/9/6 23:51, Mike Christie wrote:
>> On 8/3/23 6:28 AM, Huang Cun wrote:
>>> When a disk fails to attach, the struct rdac_dh_data is released,
>>> but it is not removed from the ctlr->dh_list. When attaching another
>>> disk, the released rdac_dh_data will be accessed and the following
>>> BUG_ON() may be observed:
>>>
>>> [  414.696167] scsi 5:0:0:7: rdac: Attach failed (8)
>>> ...
>>> [  423.615364] kernel BUG at drivers/scsi/device_handler/scsi_dh_rdac.c:427!
>>> [  423.615731] invalid opcode: 0000 [#1] SMP NOPTI
>>> ...
>>> [  423.623247] Call Trace:
>>> [  423.623598]  rdac_bus_attach+0x203/0x4c0
>>> [  423.623949]  ? scsi_dh_handler_attach+0x2d/0x90
>>> [  423.624300]  scsi_dh_handler_attach+0x2d/0x90
>>> [  423.624652]  scsi_sysfs_add_sdev+0x88/0x270
>>> [  423.625004]  scsi_probe_and_add_lun+0xc47/0xd50
>>> [  423.625354]  scsi_report_lun_scan+0x339/0x3b0
>>> [  423.625705]  __scsi_scan_target+0xe9/0x220
>>> [  423.626056]  scsi_scan_target+0xf6/0x100
>>> [  423.626404]  fc_scsi_scan_rport+0xa5/0xb0
>>> [  423.626757]  process_one_work+0x15e/0x3f0
>>> [  423.627106]  worker_thread+0x4c/0x440
>>> [  423.627453]  ? rescuer_thread+0x350/0x350
>>> [  423.627804]  kthread+0xf8/0x130
>>> [  423.628153]  ? kthread_destroy_worker+0x40/0x40
>>> [  423.628509]  ret_from_fork+0x1f/0x40
>>>
>>> Fixes: 1a5dc166cd88 ("scsi_dh_rdac: update 'access_state' field")
>>> Signed-off-by: Huang Cun <huangcun@sangfor.com.cn>
>>> Signed-off-by: Ding Hui <dinghui@sangfor.com.cn>
>>> Cc: Donglin Peng <pengdonglin@sangfor.com.cn>
>>> ---
>>>   drivers/scsi/device_handler/scsi_dh_rdac.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/scsi/device_handler/scsi_dh_rdac.c b/drivers/scsi/device_handler/scsi_dh_rdac.c
>>> index c5538645057a..9d487c2b7708 100644
>>> --- a/drivers/scsi/device_handler/scsi_dh_rdac.c
>>> +++ b/drivers/scsi/device_handler/scsi_dh_rdac.c
>>> @@ -762,8 +762,10 @@ static int rdac_bus_attach(struct scsi_device *sdev)
>>>   clean_ctlr:
>>>       spin_lock(&list_lock);
>>> +    list_del_rcu(&h->node);
>>>       kref_put(&h->ctlr->kref, release_controller);
>>>       spin_unlock(&list_lock);
>>> +    synchronize_rcu();
>>
>> Should this be:
>>
>> spin_lock(&list_lock);
>> list_del_rcu(&h->node);
>> spin_unlock(&list_lock);
>>
>> synchronize_rcu();
>>
>> kref_put(&h->ctlr->kref, release_controller);
>>
>>
>> ?
>>
>> If you do the synchronize_rcu after the kref_put, then the kref_put
>> could free the rdac_dh_data, while check_ownership is still
>> accessing the rdac_dh_data, right?
>>
> 
> You are right.
> 
> But I think we should keep the kref_put() and release callback be protected by list_lock, and only free
> the ctlr after synchronize_rcu().
> 

Sorry, I thought again, maybe we don't need to worry about it.

The ctlr->kref is protected by list_lock, and release_controller() DO free the ctlr, NOT rdac_dh_data,
kfree(rdac_dh_data) is already after synchronize_rcu().

If check_ownership() shared the same ctlr, the kref must be greater than or equal to 2, so the ctlr will
not be released by kref_put(). On the other hand, if the ctlr is different, releasing it will not affect
others.

-- 
Thanks,
- Ding Hui

