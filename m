Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9483F7D925A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 10:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbjJ0InF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 04:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235097AbjJ0Imi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 04:42:38 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFC82119;
        Fri, 27 Oct 2023 01:41:40 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39R4f3Pp026579;
        Fri, 27 Oct 2023 08:41:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=9Lg+HC3HxZbfMqa9w1qVkIMR4KTD/CZun/O7wvUawIk=;
 b=Ud/OInqYEHhFpKss54qcL3BUBVeHYfUSRUsVTld+U8InyfMuznVjnhU21mO4xcdKfVMQ
 +lQK0zsB/mA3sdUn2xGAK6v+rVNFOtWQLlkGrCuWeeXy2VHrk8wSeHceTon0o9MeLMJQ
 zkD1K0HpHHGgoVzL2y480V9+KDBzTbFpOOSU+wisIE+F1alrpVp1Bef2aj40svVaQw1s
 xxFC37UrdiDVmAKHwBCPupA5qixetvIC+zGwGQL7OH/gOqFlEGLzifsJyFVYpEilJnrN
 R3B++Ov0Q7TqjqTlsLSAZMe4pMApF0QOulDkyX7xjD1RzcLtqVaR8xmsdtfQay8K8uW1 dQ== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tyx3u9h27-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Oct 2023 08:41:37 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39R8farW011009
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Oct 2023 08:41:36 GMT
Received: from [10.110.26.71] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Fri, 27 Oct
 2023 01:41:26 -0700
Message-ID: <21208de0-79bc-42c7-b32f-355daf5b09f0@quicinc.com>
Date:   Fri, 27 Oct 2023 14:11:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Sarthak Garg <quic_sartgarg@quicinc.com>
Subject: Re: [PATCH V3 1/3] mmc: core: Add partial initialization support
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <quic_cang@quicinc.com>,
        <quic_nguyenb@quicinc.com>, <quic_rampraka@quicinc.com>,
        <quic_pragalla@quicinc.com>, <quic_sayalil@quicinc.com>,
        <quic_nitirawa@quicinc.com>, <quic_sachgupt@quicinc.com>,
        <quic_bhaskarv@quicinc.com>, <quic_narepall@quicinc.com>,
        <kernel@quicinc.com>,
        Veerabhadrarao Badiganti <quic_vbadigan@quicinc.com>
References: <20231019054612.9192-1-quic_sartgarg@quicinc.com>
 <20231019054612.9192-2-quic_sartgarg@quicinc.com>
 <CAPDyKFofS16AsQeTVNiDi_PHUatGoQ3no-1+Azo+yqG0SPTe4Q@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAPDyKFofS16AsQeTVNiDi_PHUatGoQ3no-1+Azo+yqG0SPTe4Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: uDnqH_689gUq2XTtVnum5VNAMvWBXvSH
X-Proofpoint-GUID: uDnqH_689gUq2XTtVnum5VNAMvWBXvSH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_06,2023-10-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 mlxscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 clxscore=1011
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310270074
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/19/2023 8:30 PM, Ulf Hansson wrote:
> On Thu, 19 Oct 2023 at 07:46, Sarthak Garg <quic_sartgarg@quicinc.com> wrote:
>>
>> Add the ability to partially initialize the MMC device by
>> using device sleep/awake sequence (CMD5).
>> Device will be sent to sleep state during mmc runtime/system suspend
>> and will be woken up during mmc runtime/system resume.
>> By using this sequence the device doesn't need full initialization
>> which gives 25% time reduction in system/runtime resume path.
>>
>> 1) Micron eMMC (ManfID 0x13)
>>
>> Partial init                            Full Init
>>
>> a) _mmc_resume:                         _mmc_resume :
>>
>> Total time : 62ms                       Total time : 84ms
>> (Improvement % from full init = ~26%)
>>
>> 2) Kingston eMMC (ManfID 0x70)
>>
>> Partial init                            Full Init
>>
>> a) _mmc_resume:                 _mmc_resume :
>> Total time : 46ms                       Total time : 62ms
>> (Improvement % from full init = ~25%).
>>
>> Co-developed-by: Veerabhadrarao Badiganti <quic_vbadigan@quicinc.com>
>> Signed-off-by: Veerabhadrarao Badiganti <quic_vbadigan@quicinc.com>
>> Signed-off-by: Sarthak Garg <quic_sartgarg@quicinc.com>
>> ---
>>   drivers/mmc/core/mmc.c   | 163 ++++++++++++++++++++++++++++++++++++---
>>   include/linux/mmc/card.h |   4 +
>>   include/linux/mmc/host.h |   2 +
>>   3 files changed, 160 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index 8180983bd402..fb33bcf6d360 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -1956,7 +1956,28 @@ static int mmc_sleep_busy_cb(void *cb_data, bool *busy)
>>          return 0;
>>   }
>>
>> -static int mmc_sleep(struct mmc_host *host)
>> +/*
>> + * Returns true if card supports sleep/awake command and host can simply do
>> + * sleep/awake instead of full card initialization as part of resume.
>> + */
>> +static inline int mmc_can_sleepawake(struct mmc_host *host)
> 
> Nitpick: Please rename to mmc_can_sleep_awake() to make the name more clear.

Sure will take care in V4.

> 
>> +{
>> +       return mmc_can_sleep(host->card) && (host->caps2 & MMC_CAP2_SLEEP_AWAKE);
>> +}
>> +
>> +/**
>> + * mmc_sleepawake - function to sleep or awake the device
>> + * @host: MMC host
>> + * @sleep: if true then sleep command is sent else awake
>> + *
>> + * This function first deselects the card and then sends the sleep command
>> + * in case of sleep whereas in case of awake first awake command is send
>> + * and then the card is selected.
>> + *
>> + * Returns 0 on success, non-zero value on failure
>> + */
>> +
>> +static int mmc_sleepawake(struct mmc_host *host, bool sleep)
> 
> Nitpick: Please rename into mmc_sleep_awake()

Sure will take care in V4.

> 
>>   {
>>          struct mmc_command cmd = {};
>>          struct mmc_card *card = host->card;
>> @@ -1967,14 +1988,17 @@ static int mmc_sleep(struct mmc_host *host)
>>          /* Re-tuning can't be done once the card is deselected */
>>          mmc_retune_hold(host);
>>
>> -       err = mmc_deselect_cards(host);
>> -       if (err)
>> -               goto out_release;
>> +       if (sleep) {
>> +               err = mmc_deselect_cards(host);
>> +               if (err)
>> +                       goto out_release;
>> +       }
>>
>>          cmd.opcode = MMC_SLEEP_AWAKE;
>>          cmd.arg = card->rca << 16;
>> -       cmd.arg |= 1 << 15;
>>          use_r1b_resp = mmc_prepare_busy_cmd(host, &cmd, timeout_ms);
>> +       if (sleep)
>> +               cmd.arg |= BIT(15);
> 
> Please move this above the call to mmc_prepare_busy_cmd(). For consistency.
>

Sure will take care in V4.

>>
>>          err = mmc_wait_for_cmd(host, &cmd, 0);
>>          if (err)
>> @@ -1997,6 +2021,9 @@ static int mmc_sleep(struct mmc_host *host)
>>          err = __mmc_poll_for_busy(host, 0, timeout_ms, &mmc_sleep_busy_cb, host);
>>
>>   out_release:
>> +       if (!sleep)
>> +               err = mmc_select_card(card);
>> +
>>          mmc_retune_release(host);
>>          return err;
>>   }
>> @@ -2094,6 +2121,73 @@ static int _mmc_flush_cache(struct mmc_host *host)
>>                          pr_err("%s: cache flush error %d\n",
>>                                 mmc_hostname(host), err);
>>          }
>> +       return err;
>> +}
>> +
>> +/*
>> + * Save read/write fields of ext_csd register that the sw changes
>> + * as part of suspend.
>> + */
>> +static int mmc_save_card_ext_csd(struct mmc_host *host)
>> +{
>> +       int err;
>> +       u8 *ext_csd;
>> +       struct mmc_card *card = host->card;
>> +
>> +       err = mmc_get_ext_csd(card, &ext_csd);
>> +       if (err || !ext_csd) {
>> +               pr_err("%s: %s: mmc_get_ext_csd failed (%d)\n",
>> +                       mmc_hostname(host), __func__, err);
>> +               return err;
>> +       }
>> +
>> +       card->ext_csd.raw_ext_csd_cmdq = ext_csd[EXT_CSD_CMDQ_MODE_EN];
>> +       card->ext_csd.raw_ext_csd_cache_ctrl = ext_csd[EXT_CSD_CACHE_CTRL];
>> +       card->ext_csd.raw_ext_csd_bus_width = ext_csd[EXT_CSD_BUS_WIDTH];
>> +       card->ext_csd.raw_ext_csd_hs_timing = ext_csd[EXT_CSD_HS_TIMING];
>> +
>> +       kfree(ext_csd);
>> +
>> +       return 0;
>> +}
>> +
>> +/*
>> + * Get the ext_csd register from the card post resume and compare with
>> + * read/write fields of ext_csd register that the sw changes.
>> + */
>> +static int mmc_test_awake_ext_csd(struct mmc_host *host)
>> +{
>> +       struct mmc_card *card = host->card;
>> +       u8 *ext_csd;
>> +       int err;
>> +
>> +       err = mmc_get_ext_csd(card, &ext_csd);
>> +       if (err) {
>> +               pr_err("%s: %s: mmc_get_ext_csd failed (%d)\n",
>> +                       mmc_hostname(host), __func__, err);
>> +               return err;
>> +       }
>> +
>> +       pr_debug("%s: %s: type(cached:current) cmdq(%d:%d) cache_ctrl(%d:%d) bus_width (%d:%d) timing(%d:%d)\n",
>> +               mmc_hostname(host), __func__,
>> +               card->ext_csd.raw_ext_csd_cmdq,
>> +               ext_csd[EXT_CSD_CMDQ_MODE_EN],
>> +               card->ext_csd.raw_ext_csd_cache_ctrl,
>> +               ext_csd[EXT_CSD_CACHE_CTRL],
>> +               card->ext_csd.raw_ext_csd_bus_width,
>> +               ext_csd[EXT_CSD_BUS_WIDTH],
>> +               card->ext_csd.raw_ext_csd_hs_timing,
>> +               ext_csd[EXT_CSD_HS_TIMING]);
>> +       err = !((card->ext_csd.raw_ext_csd_cmdq ==
>> +                       ext_csd[EXT_CSD_CMDQ_MODE_EN]) &&
>> +               (card->ext_csd.raw_ext_csd_cache_ctrl ==
>> +                       ext_csd[EXT_CSD_CACHE_CTRL]) &&
>> +               (card->ext_csd.raw_ext_csd_bus_width ==
>> +                       ext_csd[EXT_CSD_BUS_WIDTH]) &&
>> +               (card->ext_csd.raw_ext_csd_hs_timing ==
>> +                       ext_csd[EXT_CSD_HS_TIMING]));
>> +
>> +       kfree(ext_csd);
>>
>>          return err;
>>   }
>> @@ -2117,9 +2211,15 @@ static int _mmc_suspend(struct mmc_host *host, bool is_suspend)
>>              ((host->caps2 & MMC_CAP2_FULL_PWR_CYCLE) || !is_suspend ||
>>               (host->caps2 & MMC_CAP2_FULL_PWR_CYCLE_IN_SUSPEND)))
>>                  err = mmc_poweroff_notify(host->card, notify_type);
>> -       else if (mmc_can_sleep(host->card))
>> -               err = mmc_sleep(host);
>> -       else if (!mmc_host_is_spi(host))
>> +       else if (mmc_can_sleep(host->card)) {
>> +               if (mmc_can_sleepawake(host)) {
>> +                       memcpy(&host->cached_ios, &host->ios, sizeof(host->cached_ios));
>> +                       err = mmc_save_card_ext_csd(host);
> 
> I understand that you want to read/save the ext_csd at suspend to
> read/compare it at resume.
> 
> Although, I don't understand *why* this is needed, can you please clarify?
> 
>> +                       if (err)
>> +                               goto out;
>> +               }
>> +               err = mmc_sleepawake(host, true);
>> +       } else if (!mmc_host_is_spi(host))
>>                  err = mmc_deselect_cards(host);
>>
>>          if (!err) {
>> @@ -2131,6 +2231,39 @@ static int _mmc_suspend(struct mmc_host *host, bool is_suspend)
>>          return err;
>>   }
>>
>> +static int mmc_partial_init(struct mmc_host *host)
> 
> Nitpick: Please rename this into mmc_restore_ios().
> 

Sure will take care in V4.

>> +{
>> +       int err = 0;
>> +       struct mmc_card *card = host->card;
>> +
>> +       mmc_set_bus_width(host, host->cached_ios.bus_width);
>> +       mmc_set_timing(host, host->cached_ios.timing);
>> +       if (host->cached_ios.enhanced_strobe) {
>> +               host->ios.enhanced_strobe = true;
>> +               if (host->ops->hs400_enhanced_strobe)
>> +                       host->ops->hs400_enhanced_strobe(host, &host->ios);
>> +       }
>> +       mmc_set_clock(host, host->cached_ios.clock);
>> +       mmc_set_bus_mode(host, host->cached_ios.bus_mode);
>> +
> 
> Rather than re-using the above APIs and the ->set_ios() callback in
> the host, I believe it would be better to add a new host ops to manage
> all of the above at once instead. Something along the lines of the
> below, would then replace all of the above.
> 
> host->ops->restore_ios(host, &host->cached_ios)
> memcpy(&host->ios, &host->cached_ios, sizeof(host->ios));
> 
> Would that make sense to you too?
> 


I didn't get this completely. Do you mean that we should implement a new 
restore_ios callback (e.g. sdhci_restore_ios) similar to sdhci_set_ios 
and removing all the redundant code from sdhci_set_ios which should 
achieve the behaviour same as calling all the above mmc_set_* API's ?


>> +       if (!mmc_card_hs400es(card) &&
>> +                       (mmc_card_hs200(card) || mmc_card_hs400(card))) {
>> +               err = mmc_execute_tuning(card);
>> +               if (err) {
>> +                       pr_err("%s: %s: Tuning failed (%d)\n",
>> +                               mmc_hostname(host), __func__, err);
> 
> There is already a print being done in mmc_execute_tuning() at
> failure. So, let's drop the above print.
> 

Sure will take care in V4.

>> +                       goto out;
>> +               }
>> +       }
>> +
>> +       err = mmc_test_awake_ext_csd(host);
> 
> Again, I don't get why this is needed, so let's discuss this more.
> 

This is just a safety check added because ext_csd has some W/E_P or
W/C_P registers which gets reset if any HW reset happens to the card.
So this will check for those cases if any other vendor is doing reset as 
part of suspend and compare a subset of those W/E_P and W/C_P registers 
and if they are changed then we will bail out of this partial init 
feature and go for full initialization.
We are also fine with removing this function but just added for the 
above mentioned case.

>> +       if (err)
>> +               pr_debug("%s: %s: fail on ext_csd read (%d)\n",
>> +                       mmc_hostname(host), __func__, err);
>> +out:
>> +       return err;
>> +}
>> +
>>   /*
>>    * Suspend callback
>>    */
>> @@ -2161,7 +2294,19 @@ static int _mmc_resume(struct mmc_host *host)
>>                  goto out;
>>
>>          mmc_power_up(host, host->card->ocr);
>> -       err = mmc_init_card(host, host->card->ocr, host->card);
>> +
>> +       if (mmc_can_sleepawake(host)) {
>> +               err = mmc_sleepawake(host, false);
>> +               if (!err)
>> +                       err = mmc_partial_init(host);
>> +               else
>> +                       pr_err("%s: %s: awake failed (%d), fallback to full init\n",
>> +                               mmc_hostname(host), __func__, err);
> 
> We don't print other errors during resume - and I don't think there is
> any special reason to do it for this case only. Please drop it.
> 

Sure will take care in V4.

>> +       }
>> +
>> +       if (!mmc_can_sleepawake(host) || err)
>> +               err = mmc_init_card(host, host->card->ocr, host->card);
>> +
>>          mmc_card_clr_suspended(host->card);
>>
>>   out:
>> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
>> index daa2f40d9ce6..fbc832ec6d57 100644
>> --- a/include/linux/mmc/card.h
>> +++ b/include/linux/mmc/card.h
>> @@ -86,6 +86,8 @@ struct mmc_ext_csd {
>>          unsigned int            data_tag_unit_size;     /* DATA TAG UNIT size */
>>          unsigned int            boot_ro_lock;           /* ro lock support */
>>          bool                    boot_ro_lockable;
>> +       u8                      raw_ext_csd_cmdq;       /* 15 */
>> +       u8                      raw_ext_csd_cache_ctrl; /* 33 */
>>          bool                    ffu_capable;    /* Firmware upgrade support */
>>          bool                    cmdq_en;        /* Command Queue enabled */
>>          bool                    cmdq_support;   /* Command Queue supported */
>> @@ -96,7 +98,9 @@ struct mmc_ext_csd {
>>          u8                      raw_partition_support;  /* 160 */
>>          u8                      raw_rpmb_size_mult;     /* 168 */
>>          u8                      raw_erased_mem_count;   /* 181 */
>> +       u8                      raw_ext_csd_bus_width;  /* 183 */
>>          u8                      strobe_support;         /* 184 */
>> +       u8                      raw_ext_csd_hs_timing;  /* 185 */
>>          u8                      raw_ext_csd_structure;  /* 194 */
>>          u8                      raw_card_type;          /* 196 */
>>          u8                      raw_driver_strength;    /* 197 */
>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
>> index 2f445c651742..836382a0b2e9 100644
>> --- a/include/linux/mmc/host.h
>> +++ b/include/linux/mmc/host.h
>> @@ -427,6 +427,7 @@ struct mmc_host {
>>   #define MMC_CAP2_CRYPTO                0
>>   #endif
>>   #define MMC_CAP2_ALT_GPT_TEGRA (1 << 28)       /* Host with eMMC that has GPT entry at a non-standard location */
>> +#define MMC_CAP2_SLEEP_AWAKE   (1 << 29)       /* Use Sleep/Awake (CMD5) */
>>
>>          int                     fixed_drv_type; /* fixed driver type for non-removable media */
>>
>> @@ -445,6 +446,7 @@ struct mmc_host {
>>          spinlock_t              lock;           /* lock for claim and bus ops */
>>
>>          struct mmc_ios          ios;            /* current io bus settings */
>> +       struct mmc_ios          cached_ios;
>>
>>          /* group bitfields together to minimize padding */
>>          unsigned int            use_spi_crc:1;
> 
> Kind regards
> Uffe
