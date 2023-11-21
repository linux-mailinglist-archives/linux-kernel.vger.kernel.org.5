Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89DB7F2C9C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 13:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234666AbjKUMLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 07:11:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234661AbjKUMLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 07:11:34 -0500
Received: from m126.mail.126.com (m126.mail.126.com [220.181.12.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0AA36116;
        Tue, 21 Nov 2023 04:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
        Content-Type; bh=FCWStczsfyAWLbSfL661JtoGpKP+BaIpUbnsuGK+ciQ=;
        b=D3C5OcYweQZDQ67aSyGCzBkmHbJjiE0lUVpN+YKokhkU/IRNzYQWjZZyut2tae
        Dt0ucgAMvxqRc45L1rs2c+SjAPBEcMC3c5DjOWEVIWpw+eckFME8hepBFUNmUV1m
        ywFgLjab9RoZQSQ/x/px5FWxVe14u9STpCpXfh/cXP2Pw=
Received: from [172.23.69.7] (unknown [121.32.254.146])
        by zwqz-smtp-mta-g4-1 (Coremail) with SMTP id _____wDX38GRm1xlbIudCw--.32777S2;
        Tue, 21 Nov 2023 19:59:15 +0800 (CST)
Message-ID: <1369c19f-006f-4747-a089-06fdaaf6baea@126.com>
Date:   Tue, 21 Nov 2023 19:59:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] RDMA/irdma: Fix UAF in irdma_sc_ccq_get_cqe_info()
To:     Leon Romanovsky <leon@kernel.org>
Cc:     mustafa.ismail@intel.com, shiraz.saleem@intel.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        dinghui@sangfor.com.cn
References: <20231120024940.17321-1-lishifeng1992@126.com>
 <20231120131312.GC15293@unreal>
From:   Shifeng Li <lishifeng1992@126.com>
In-Reply-To: <20231120131312.GC15293@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: _____wDX38GRm1xlbIudCw--.32777S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCw1rCFy8Xw48Xr1rArWDJwb_yoW5Zw1Upa
        y3G3yUtr4Dtw1Igayxu3WUtF98GF4YyrnF9a4Fyw1fCr47Z3WSvw42kr109ay5Za47Kr1x
        JFyUWFn7ur43G3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UyHqcUUUUU=
X-Originating-IP: [121.32.254.146]
X-CM-SenderInfo: xolvxx5ihqwiqzzsqiyswou0bp/1tbi1xovr153c2IemQAAsy
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/11/20 21:13, Leon Romanovsky wrote:
> On Sun, Nov 19, 2023 at 06:49:40PM -0800, Shifeng Li wrote:
>> When removing the irdma driver or unplugging its aux device, the ccq
>> queue is released before destorying the cqp_cmpl_wq queue.
>> But in the window, there may still be completion events for wqes. That
>> will cause a UAF in irdma_sc_ccq_get_cqe_info().
>>
>> [34693.333191] BUG: KASAN: use-after-free in irdma_sc_ccq_get_cqe_info+0x82f/0x8c0 [irdma]
>> [34693.333194] Read of size 8 at addr ffff889097f80818 by task kworker/u67:1/26327
>> [34693.333194]
>> [34693.333199] CPU: 9 PID: 26327 Comm: kworker/u67:1 Kdump: loaded Tainted: G           O     --------- -t - 4.18.0 #1
>> [34693.333200] Hardware name: SANGFOR Inspur/NULL, BIOS 4.1.13 08/01/2016
>> [34693.333211] Workqueue: cqp_cmpl_wq cqp_compl_worker [irdma]
>> [34693.333213] Call Trace:
>> [34693.333220]  dump_stack+0x71/0xab
>> [34693.333226]  print_address_description+0x6b/0x290
>> [34693.333238]  ? irdma_sc_ccq_get_cqe_info+0x82f/0x8c0 [irdma]
>> [34693.333240]  kasan_report+0x14a/0x2b0
>> [34693.333251]  irdma_sc_ccq_get_cqe_info+0x82f/0x8c0 [irdma]
>> [34693.333264]  ? irdma_free_cqp_request+0x151/0x1e0 [irdma]
>> [34693.333274]  irdma_cqp_ce_handler+0x1fb/0x3b0 [irdma]
>> [34693.333285]  ? irdma_ctrl_init_hw+0x2c20/0x2c20 [irdma]
>> [34693.333290]  ? __schedule+0x836/0x1570
>> [34693.333293]  ? strscpy+0x83/0x180
>> [34693.333296]  process_one_work+0x56a/0x11f0
>> [34693.333298]  worker_thread+0x8f/0xf40
>> [34693.333301]  ? __kthread_parkme+0x78/0xf0
>> [34693.333303]  ? rescuer_thread+0xc50/0xc50
>> [34693.333305]  kthread+0x2a0/0x390
>> [34693.333308]  ? kthread_destroy_worker+0x90/0x90
>> [34693.333310]  ret_from_fork+0x1f/0x40
>>
>> Fixes: 44d9e52977a1 ("RDMA/irdma: Implement device initialization definitions")
>> Signed-off-by: Shifeng Li <lishifeng1992@126.com>
>> Acked-by: Shiraz Saleem <shiraz.saleem@intel.com>
>> ---
>>   drivers/infiniband/hw/irdma/hw.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>> ---
>> v1->v2: add Fixes line.
> 
> This patch doesn't apply cleanly due to this patch.
> https://lore.kernel.org/all/20230725155505.1069-3-shiraz.saleem@intel.com/
> 
> Thanks
> 
I have submitted the v3 patch.

Thanks
>>
>> diff --git a/drivers/infiniband/hw/irdma/hw.c b/drivers/infiniband/hw/irdma/hw.c
>> index ab246447520b..de7337a6a874 100644
>> --- a/drivers/infiniband/hw/irdma/hw.c
>> +++ b/drivers/infiniband/hw/irdma/hw.c
>> @@ -570,8 +570,6 @@ static void irdma_destroy_cqp(struct irdma_pci_f *rf, bool free_hwcqp)
>>   	struct irdma_cqp *cqp = &rf->cqp;
>>   	int status = 0;
>>   
>> -	if (rf->cqp_cmpl_wq)
>> -		destroy_workqueue(rf->cqp_cmpl_wq);
>>   	if (free_hwcqp)
>>   		status = irdma_sc_cqp_destroy(dev->cqp);
>>   	if (status)
>> @@ -737,6 +735,8 @@ static void irdma_destroy_ccq(struct irdma_pci_f *rf)
>>   	struct irdma_ccq *ccq = &rf->ccq;
>>   	int status = 0;
>>   
>> +	if (rf->cqp_cmpl_wq)
>> +		destroy_workqueue(rf->cqp_cmpl_wq);
>>   	if (!rf->reset)
>>   		status = irdma_sc_ccq_destroy(dev->ccq, 0, true);
>>   	if (status)
>> -- 
>> 2.25.1
>>

