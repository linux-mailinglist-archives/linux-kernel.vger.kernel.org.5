Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABEE7AE5FC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 08:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbjIZGdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 02:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjIZGdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 02:33:32 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F2CDF;
        Mon, 25 Sep 2023 23:33:23 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38Q5YaRT017583;
        Tue, 26 Sep 2023 06:32:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=6r74SF/MEkn3vHAj01ANhBz+/YVAiGxoIyM6nqnZiSk=;
 b=G27kQ4fLN+gIwiOyoMZcupOQFVqV4xlPxa40CPZa1+dDBFWpVRDfcS5Gpzj3bMhgcLKy
 hOqESVQbTJJQwdmTeGgvunTGex7BdZjSjgo4JwNZ9vSi1Qy+XCoAMnXidA8+1oNWWwg0
 rKExWmvulHnXbqWMjHh1oxy0X86A+5lt8Lpfc88AxjlVCOR3mqtcboCMpvd8Qz3l4/MH
 F1W4jO5QpPe3yD0i6AJmQo4O/P1j4JsfixZxo71eb50g05PFnTztG/ltGNQ7fI/TL2PO
 b7E1rKDOQQRiQ3DR5kmcuYcZxFbw83KZSuEjOqBFXb91YSkY6nBp+SaJG0NXOVNbLieW YQ== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tb7re2atj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 06:32:31 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38Q6WTQA002406
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 06:32:29 GMT
Received: from [10.217.218.207] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 25 Sep
 2023 23:32:24 -0700
Message-ID: <f32214ce-850c-428f-95a5-12d68358b47c@quicinc.com>
Date:   Tue, 26 Sep 2023 12:01:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] mmc: core: Add partial initialization support
Content-Language: en-US
To:     Ben Chuang <benchuanggli@gmail.com>,
        "Kamasali Satyanarayan (Consultant) (QUIC)" 
        <quic_kamasali@quicinc.com>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>,
        "merez@codeaurora.org" <merez@codeaurora.org>,
        "s.shtylyov@omp.ru" <s.shtylyov@omp.ru>,
        "huijin.park@samsung.com" <huijin.park@samsung.com>,
        "briannorris@chromium.org" <briannorris@chromium.org>,
        "digetx@gmail.com" <digetx@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Veerabhadrarao Badiganti" <vbadigan@codeaurora.org>,
        Shaik Sajida Bhanu <sbhanu@codeaurora.org>,
        "quic_spathi@quicinc.com" <quic_spathi@quicinc.com>
References: <1650963852-4173-1-git-send-email-quic_spathi@quicinc.com>
 <CAPDyKFo7H=fOiX49gttrKO3gwe=ddYMjdgrO_xSnnZjZh7P7ZA@mail.gmail.com>
 <MWHPR0201MB3466C629ECABC8FD6B009276E3D79@MWHPR0201MB3466.namprd02.prod.outlook.com>
 <CACT4zj8knKUUsafZ_r5cL50DQDw+vSa_RBi_QCnAS5Y1hB47yw@mail.gmail.com>
From:   Sarthak Garg <quic_sartgarg@quicinc.com>
In-Reply-To: <CACT4zj8knKUUsafZ_r5cL50DQDw+vSa_RBi_QCnAS5Y1hB47yw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: dulO9-b3duc5F6xxAAqvPJzr-mpJu0G6
X-Proofpoint-GUID: dulO9-b3duc5F6xxAAqvPJzr-mpJu0G6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_04,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 priorityscore=1501 phishscore=0 clxscore=1011 spamscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309260057
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/2/2022 1:26 PM, Ben Chuang wrote:
> Hi Sarthak and others,
>
> I like your patch, I'm not familiar with the whole sleep/wake flow.
> But I have a question.
>
> Regarding mmc_poweroff_notify() , there is a parameter notify_type.
> In the spec., it has a value 0x04: SLEEP_NOTIFICATION (host is going
> to put the device in sleep mode.)
> Is there anything that needs to be changed in _mmc_suspend() before
> calling mmc_sleepawake(host, true)/mmc_power_off(host)?
> Thanks in advance.
>
> Best regards,
> Ben


Hi Ben,

I went through the sleep notification in the eMMC spec. This sleep 
notification seems optional as per this statement in spec: "It *may* use 
to a power notification (SLEEP_NOTIFICATION) if it intends to turn-off 
VCC after moving the device to sleep state". So it doesn't seem to be a 
good club this with my change. We can revisit and take this separately.

Thanks,
Sarthak

>
> On Wed, May 25, 2022 at 12:31 AM Kamasali Satyanarayan (Consultant)
> (QUIC) <quic_kamasali@quicinc.com> wrote:
>> Hi,
>>
>> These patches will be further taken by Sarthak.
>>
>> Thanks,
>> Satya
>>
>> -----Original Message-----
>> From: Ulf Hansson <ulf.hansson@linaro.org>
>> Sent: Wednesday, April 27, 2022 1:06 PM
>> To: quic_spathi <quic_spathi@quicinc.com>
>> Cc: avri.altman@wdc.com; linus.walleij@linaro.org; shawn.lin@rock-chips.com; merez@codeaurora.org; s.shtylyov@omp.ru; huijin.park@samsung.com; briannorris@chromium.org; digetx@gmail.com; linux-mmc@vger.kernel.org; linux-kernel@vger.kernel.org; Veerabhadrarao Badiganti <vbadigan@codeaurora.org>; Shaik Sajida Bhanu <sbhanu@codeaurora.org>; Kamasali Satyanarayan (Consultant) (QUIC) <quic_kamasali@quicinc.com>
>> Subject: Re: [PATCH V1] mmc: core: Add partial initialization support
>>
>> On Tue, 26 Apr 2022 at 11:04, Srinivasarao Pathipati <quic_spathi@quicinc.com> wrote:
>>> From: Maya Erez <merez@codeaurora.org>
>>>
>>> This change adds the ability to partially initialize the MMC card by
>>> using card Sleep/Awake sequence (CMD5).
>>> Card will be sent to Sleep state during runtime/system suspend and
>>> will be woken up during runtime/system resume.
>>> By using this sequence the card doesn't need full initialization which
>>> gives time reduction in system/runtime resume path.
>>>
>>> Signed-off-by: Maya Erez <merez@codeaurora.org>
>>> Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
>>> Signed-off-by: Shaik Sajida Bhanu <sbhanu@codeaurora.org>
>>> Signed-off-by: kamasali <quic_kamasali@quicinc.com>
>>> Signed-off-by: Srinivasarao Pathipati <quic_spathi@quicinc.com>
>> It seems like this patch has been posted before [1]. Let me repeat my question sent back then.
>>
>> It would be nice if you could provide some more exact numbers of what the gain is for a couple of different eMMCs, to justify the change.
>> Can you please do that?
>>
>> Kind regards
>> Uffe
>>
>> [1]
>> https://patchwork.kernel.org/project/linux-mmc/patch/1591277381-7734-1-git-send-email-vbadigan@codeaurora.org/
>>
>>> ---
>>>   drivers/mmc/core/mmc.c   | 149 ++++++++++++++++++++++++++++++++++++++++++++---
>>>   include/linux/mmc/card.h |   4 ++
>>>   include/linux/mmc/host.h |   2 +
>>>   3 files changed, 146 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c index
>>> 9ab915b..8691c00 100644
>>> --- a/drivers/mmc/core/mmc.c
>>> +++ b/drivers/mmc/core/mmc.c
>>> @@ -1942,7 +1942,14 @@ static int mmc_sleep_busy_cb(void *cb_data, bool *busy)
>>>          return 0;
>>>   }
>>>
>>> -static int mmc_sleep(struct mmc_host *host)
>>> +static int mmc_can_sleepawake(struct mmc_host *host) {
>>> +       return host && (host->caps2 & MMC_CAP2_SLEEP_AWAKE) && host->card &&
>>> +               (host->card->ext_csd.rev >= 3);
>>> +
>>> +}
>>> +
>>> +static int mmc_sleepawake(struct mmc_host *host, bool sleep)
>>>   {
>>>          struct mmc_command cmd = {};
>>>          struct mmc_card *card = host->card; @@ -1953,14 +1960,17 @@
>>> static int mmc_sleep(struct mmc_host *host)
>>>          /* Re-tuning can't be done once the card is deselected */
>>>          mmc_retune_hold(host);
>>>
>>> -       err = mmc_deselect_cards(host);
>>> -       if (err)
>>> -               goto out_release;
>>> +       if (sleep) {
>>> +               err = mmc_deselect_cards(host);
>>> +               if (err)
>>> +                       goto out_release;
>>> +       }
>>>
>>>          cmd.opcode = MMC_SLEEP_AWAKE;
>>>          cmd.arg = card->rca << 16;
>>> -       cmd.arg |= 1 << 15;
>>>          use_r1b_resp = mmc_prepare_busy_cmd(host, &cmd, timeout_ms);
>>> +       if (sleep)
>>> +               cmd.arg |= 1 << 15;
>>>
>>>          err = mmc_wait_for_cmd(host, &cmd, 0);
>>>          if (err)
>>> @@ -1982,6 +1992,9 @@ static int mmc_sleep(struct mmc_host *host)
>>>
>>>          err = __mmc_poll_for_busy(host, 0, timeout_ms,
>>> &mmc_sleep_busy_cb, host);
>>>
>>> +       if (!sleep)
>>> +               err = mmc_select_card(card);
>>> +
>>>   out_release:
>>>          mmc_retune_release(host);
>>>          return err;
>>> @@ -2080,6 +2093,66 @@ static int _mmc_flush_cache(struct mmc_host *host)
>>>                          pr_err("%s: cache flush error %d\n",
>>>                                 mmc_hostname(host), err);
>>>          }
>>> +       return err;
>>> +}
>>> +
>>> +static int mmc_cache_card_ext_csd(struct mmc_host *host) {
>>> +       int err;
>>> +       u8 *ext_csd;
>>> +       struct mmc_card *card = host->card;
>>> +
>>> +       err = mmc_get_ext_csd(card, &ext_csd);
>>> +       if (err || !ext_csd) {
>>> +               pr_err("%s: %s: mmc_get_ext_csd failed (%d)\n",
>>> +                       mmc_hostname(host), __func__, err);
>>> +               return err;
>>> +       }
>>> +       /* only cache read/write fields that the sw changes */
>>> +       card->ext_csd.raw_ext_csd_cmdq = ext_csd[EXT_CSD_CMDQ_MODE_EN];
>>> +       card->ext_csd.raw_ext_csd_cache_ctrl = ext_csd[EXT_CSD_CACHE_CTRL];
>>> +       card->ext_csd.raw_ext_csd_bus_width = ext_csd[EXT_CSD_BUS_WIDTH];
>>> +       card->ext_csd.raw_ext_csd_hs_timing =
>>> + ext_csd[EXT_CSD_HS_TIMING];
>>> +
>>> +       kfree(ext_csd);
>>> +
>>> +       return 0;
>>> +}
>>> +
>>> +static int mmc_test_awake_ext_csd(struct mmc_host *host) {
>>> +       int err;
>>> +       u8 *ext_csd;
>>> +       struct mmc_card *card = host->card;
>>> +
>>> +       err = mmc_get_ext_csd(card, &ext_csd);
>>> +       if (err) {
>>> +               pr_err("%s: %s: mmc_get_ext_csd failed (%d)\n",
>>> +                       mmc_hostname(host), __func__, err);
>>> +               return err;
>>> +       }
>>> +
>>> +       /* only compare read/write fields that the sw changes */
>>> +       pr_debug("%s: %s: type(cached:current) cmdq(%d:%d) cache_ctrl(%d:%d) bus_width (%d:%d) timing(%d:%d)\n",
>>> +               mmc_hostname(host), __func__,
>>> +               card->ext_csd.raw_ext_csd_cmdq,
>>> +               ext_csd[EXT_CSD_CMDQ_MODE_EN],
>>> +               card->ext_csd.raw_ext_csd_cache_ctrl,
>>> +               ext_csd[EXT_CSD_CACHE_CTRL],
>>> +               card->ext_csd.raw_ext_csd_bus_width,
>>> +               ext_csd[EXT_CSD_BUS_WIDTH],
>>> +               card->ext_csd.raw_ext_csd_hs_timing,
>>> +               ext_csd[EXT_CSD_HS_TIMING]);
>>> +       err = !((card->ext_csd.raw_ext_csd_cmdq ==
>>> +                       ext_csd[EXT_CSD_CMDQ_MODE_EN]) &&
>>> +               (card->ext_csd.raw_ext_csd_cache_ctrl ==
>>> +                       ext_csd[EXT_CSD_CACHE_CTRL]) &&
>>> +               (card->ext_csd.raw_ext_csd_bus_width ==
>>> +                       ext_csd[EXT_CSD_BUS_WIDTH]) &&
>>> +               (card->ext_csd.raw_ext_csd_hs_timing ==
>>> +                       ext_csd[EXT_CSD_HS_TIMING]));
>>> +
>>> +       kfree(ext_csd);
>>>
>>>          return err;
>>>   }
>>> @@ -2103,8 +2176,12 @@ static int _mmc_suspend(struct mmc_host *host, bool is_suspend)
>>>              ((host->caps2 & MMC_CAP2_FULL_PWR_CYCLE) || !is_suspend ||
>>>               (host->caps2 & MMC_CAP2_FULL_PWR_CYCLE_IN_SUSPEND)))
>>>                  err = mmc_poweroff_notify(host->card, notify_type);
>>> -       else if (mmc_can_sleep(host->card))
>>> -               err = mmc_sleep(host);
>>> +       if (mmc_can_sleepawake(host)) {
>>> +               memcpy(&host->cached_ios, &host->ios, sizeof(host->cached_ios));
>>> +                mmc_cache_card_ext_csd(host);
>>> +       }
>>> +       if (mmc_can_sleep(host->card))
>>> +               err = mmc_sleepawake(host, true);
>>>          else if (!mmc_host_is_spi(host))
>>>                  err = mmc_deselect_cards(host);
>>>
>>> @@ -2117,6 +2194,48 @@ static int _mmc_suspend(struct mmc_host *host, bool is_suspend)
>>>          return err;
>>>   }
>>>
>>> +static int mmc_partial_init(struct mmc_host *host) {
>>> +       int err = 0;
>>> +       struct mmc_card *card = host->card;
>>> +
>>> +       mmc_set_bus_width(host, host->cached_ios.bus_width);
>>> +       mmc_set_timing(host, host->cached_ios.timing);
>>> +       if (host->cached_ios.enhanced_strobe) {
>>> +               host->ios.enhanced_strobe = true;
>>> +               if (host->ops->hs400_enhanced_strobe)
>>> +                       host->ops->hs400_enhanced_strobe(host, &host->ios);
>>> +       }
>>> +       mmc_set_clock(host, host->cached_ios.clock);
>>> +       mmc_set_bus_mode(host, host->cached_ios.bus_mode);
>>> +
>>> +       if (!mmc_card_hs400es(card) &&
>>> +                       (mmc_card_hs200(card) || mmc_card_hs400(card))) {
>>> +               err = mmc_execute_tuning(card);
>>> +               if (err) {
>>> +                       pr_err("%s: %s: Tuning failed (%d)\n",
>>> +                               mmc_hostname(host), __func__, err);
>>> +                       goto out;
>>> +               }
>>> +       }
>>> +       /*
>>> +        * The ext_csd is read to make sure the card did not went through
>>> +        * Power-failure during sleep period.
>>> +        * A subset of the W/E_P, W/C_P register will be tested. In case
>>> +        * these registers values are different from the values that were
>>> +        * cached during suspend, we will conclude that a Power-failure occurred
>>> +        * and will do full initialization sequence.
>>> +        */
>>> +       err = mmc_test_awake_ext_csd(host);
>>> +       if (err) {
>>> +               pr_debug("%s: %s: fail on ext_csd read (%d)\n",
>>> +                       mmc_hostname(host), __func__, err);
>>> +               goto out;
>>> +       }
>>> +out:
>>> +       return err;
>>> +}
>>> +
>>>   /*
>>>    * Suspend callback
>>>    */
>>> @@ -2139,7 +2258,7 @@ static int mmc_suspend(struct mmc_host *host)
>>>    */
>>>   static int _mmc_resume(struct mmc_host *host)  {
>>> -       int err = 0;
>>> +       int err = -EINVAL;
>>>
>>>          mmc_claim_host(host);
>>>
>>> @@ -2147,7 +2266,19 @@ static int _mmc_resume(struct mmc_host *host)
>>>                  goto out;
>>>
>>>          mmc_power_up(host, host->card->ocr);
>>> -       err = mmc_init_card(host, host->card->ocr, host->card);
>>> +
>>> +       if (mmc_can_sleepawake(host)) {
>>> +               err = mmc_sleepawake(host, false);
>>> +               if (!err)
>>> +                       err = mmc_partial_init(host);
>>> +               else
>>> +                       pr_err("%s: %s: awake failed (%d), fallback to full init\n",
>>> +                               mmc_hostname(host), __func__, err);
>>> +       }
>>> +
>>> +       if (err)
>>> +               err = mmc_init_card(host, host->card->ocr, host->card);
>>> +
>>>          mmc_card_clr_suspended(host->card);
>>>
>>>   out:
>>> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
>>> index 37f9758..ed7f6f7 100644
>>> --- a/include/linux/mmc/card.h
>>> +++ b/include/linux/mmc/card.h
>>> @@ -86,6 +86,8 @@ struct mmc_ext_csd {
>>>          unsigned int            data_tag_unit_size;     /* DATA TAG UNIT size */
>>>          unsigned int            boot_ro_lock;           /* ro lock support */
>>>          bool                    boot_ro_lockable;
>>> +       u8                      raw_ext_csd_cmdq;       /* 15 */
>>> +       u8                      raw_ext_csd_cache_ctrl; /* 33 */
>>>          bool                    ffu_capable;    /* Firmware upgrade support */
>>>          bool                    cmdq_en;        /* Command Queue enabled */
>>>          bool                    cmdq_support;   /* Command Queue supported */
>>> @@ -96,7 +98,9 @@ struct mmc_ext_csd {
>>>          u8                      raw_partition_support;  /* 160 */
>>>          u8                      raw_rpmb_size_mult;     /* 168 */
>>>          u8                      raw_erased_mem_count;   /* 181 */
>>> +       u8                      raw_ext_csd_bus_width;  /* 183 */
>>>          u8                      strobe_support;         /* 184 */
>>> +       u8                      raw_ext_csd_hs_timing;  /* 185 */
>>>          u8                      raw_ext_csd_structure;  /* 194 */
>>>          u8                      raw_card_type;          /* 196 */
>>>          u8                      raw_driver_strength;    /* 197 */
>>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
>>> index c38072e..a9ddf7a 100644
>>> --- a/include/linux/mmc/host.h
>>> +++ b/include/linux/mmc/host.h
>>> @@ -422,6 +422,7 @@ struct mmc_host {
>>>   #else
>>>   #define MMC_CAP2_CRYPTO                0
>>>   #endif
>>> +#define MMC_CAP2_SLEEP_AWAKE   (1 << 29)       /* Use Sleep/Awake (CMD5) */
>>>   #define MMC_CAP2_ALT_GPT_TEGRA (1 << 28)       /* Host with eMMC that has GPT entry at a non-standard location */
>>>
>>>          int                     fixed_drv_type; /* fixed driver type for non-removable media */
>>> @@ -441,6 +442,7 @@ struct mmc_host {
>>>          spinlock_t              lock;           /* lock for claim and bus ops */
>>>
>>>          struct mmc_ios          ios;            /* current io bus settings */
>>> +       struct mmc_ios          cached_ios;
>>>
>>>          /* group bitfields together to minimize padding */
>>>          unsigned int            use_spi_crc:1;
>>> --
>>> 2.7.4
>>>
