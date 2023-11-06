Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D313D7E2179
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 13:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbjKFM1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 07:27:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjKFM05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 07:26:57 -0500
Received: from out28-2.mail.aliyun.com (out28-2.mail.aliyun.com [115.124.28.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E750BBB;
        Mon,  6 Nov 2023 04:26:52 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07470094|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0336601-0.000693695-0.965646;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047211;MF=michael@allwinnertech.com;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.VGP97NC_1699273606;
Received: from 192.168.220.129(mailfrom:michael@allwinnertech.com fp:SMTPD_---.VGP97NC_1699273606)
          by smtp.aliyun-inc.com;
          Mon, 06 Nov 2023 20:26:48 +0800
Message-ID: <aa657a1d-a25d-21a8-4093-ec8fbe298ca2@allwinnertech.com>
Date:   Mon, 6 Nov 2023 20:26:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] mmc: core: Add new flag to force hardware reset
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Wenchao Chen <wenchao.chen666@gmail.com>
Cc:     adrian.hunter@intel.com, jinpu.wang@ionos.com,
        victor.shih@genesyslogic.com.tw, avri.altman@wdc.com,
        asuk4.q@gmail.com, f.fainelli@gmail.com, beanhuo@micron.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sarthak Garg <quic_sartgarg@quicinc.com>
References: <20230914000348.25790-1-michael@allwinnertech.com>
 <CA+Da2qzr0SBu-kUtFTnBqT+OObFOSTFgmU30L3B-Rjv3rYbGKw@mail.gmail.com>
 <CAPDyKFpHw+6vovHRWbhsDwre81U4Uu_X-Wy_viQCZp6nj=5Jkw@mail.gmail.com>
From:   Michael Wu <michael@allwinnertech.com>
In-Reply-To: <CAPDyKFpHw+6vovHRWbhsDwre81U4Uu_X-Wy_viQCZp6nj=5Jkw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/25/2023 9:59 PM, Ulf Hansson wrote:
> - trimmed cc-list, + Sartak Garg
> 
> On Thu, 14 Sept 2023 at 10:00, Wenchao Chen <wenchao.chen666@gmail.com> wrote:
>>
>> On Thu, 14 Sept 2023 at 08:04, Michael Wu <michael@allwinnertech.com> wrote:
>>>
>>> Entering the recovery system itself indicates a transmission error.
>>> In this situation, we intend to execute the mmc_blk_reset function
>>> to clear any anomalies that may be caused by errors. We have previously
>>> discussed with several MMC device manufacturers, and they expressed
>>> their desire for us to reset the device when errors occur to ensure
>>> stable operation. We aim to make this code compatible with all devices
>>> and ensure its stable performance, so we would like to add this patch
>>>
>>> Signed-off-by: Michael Wu <michael@allwinnertech.com>
>>
>> like: https://lore.kernel.org/linux-mmc/20220603051534.22672-1-quic_sartgarg@quicinc.com/
> 
> Looks like this series didn't make it. I was awaiting a rebase from
> Sartak to apply it, but apparently something got in his way for a new
> submission.
> 
>>
>> You should enable it in the vendor host.
> 
> Yes! We don't want unused code in the core. We need a user of it too.
> 
> May I suggest that you pick up Sartak's patch for the core and thus
> add another patch for the host driver you care about and then
> re-submit it as a small series.
> 
> Kind regards
> Uffe
> 
>>
>>> ---
>>>   drivers/mmc/core/block.c | 2 +-
>>>   include/linux/mmc/host.h | 1 +
>>>   2 files changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
>>> index b5b414a71e0b..29fbe0ddeadb 100644
>>> --- a/drivers/mmc/core/block.c
>>> +++ b/drivers/mmc/core/block.c
>>> @@ -1503,7 +1503,7 @@ void mmc_blk_cqe_recovery(struct mmc_queue *mq)
>>>          pr_debug("%s: CQE recovery start\n", mmc_hostname(host));
>>>
>>>          err = mmc_cqe_recovery(host);
>>> -       if (err)
>>> +       if (err || host->cqe_recovery_reset_always)
>>>                  mmc_blk_reset(mq->blkdata, host, MMC_BLK_CQE_RECOVERY);
>>>          mmc_blk_reset_success(mq->blkdata, MMC_BLK_CQE_RECOVERY);
>>>
>>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
>>> index 62a6847a3b6f..f578541a06b5 100644
>>> --- a/include/linux/mmc/host.h
>>> +++ b/include/linux/mmc/host.h
>>> @@ -518,6 +518,7 @@ struct mmc_host {
>>>          int                     cqe_qdepth;
>>>          bool                    cqe_enabled;
>>>          bool                    cqe_on;
>>> +       bool                    cqe_recovery_reset_always;
>>>
>>>          /* Inline encryption support */
>>>   #ifdef CONFIG_MMC_CRYPTO
>>> --
>>> 2.29.0
>>>
Dear Ulf,
I have tested Sartak's patch and it is also able to resolve the issue we 
are currently facing. Therefore, I would like to inquire about the 
expected timeline for merging Sartak's patch.

-- 
Regards,
Michael Wu
