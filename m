Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211D278FD6B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 14:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242278AbjIAMlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 08:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbjIAMk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 08:40:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E927CE7F;
        Fri,  1 Sep 2023 05:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693572058; x=1725108058;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=swmpN1ufaJWNye5l6Ec1X+ib/v2NUafFZ07bfJKaegM=;
  b=I79ex6xGpD8UVjmVse/X3NrlcSbUjrlH7alYtmIGItt1TtJxVq3YWX8y
   F+M4Bzpu/A+Mh12YeNRd4KiXnRsQnO2alWeG5As3TNV5wbQuuGxJ1LWfQ
   gxUoK6YtjOg1/6tvnEltP3MsidrFql5Amlv2ACemVseiqRCPNCO5H4Pze
   FdV/jK9g0Aq2Q28QtaZ0N2C6DQEsqne5u9sBHUmb6ADnnEynIYS81I3e0
   6LuxSBDpUIObeZp038nkVGVUq+gyW+0mKJzlLvNIkBZCeaKvtnvdIuFTd
   6uVDLa7KJJwn5jn4dSVSu4tBmbp+YREdbr1R9AGkMSVqo4bNgPtSgizt5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="442604793"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="442604793"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 05:40:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="883176792"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="883176792"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.58.96])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 05:40:55 -0700
Message-ID: <3661d812-5056-3220-bcf2-279c0f3cb04c@intel.com>
Date:   Fri, 1 Sep 2023 15:40:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.0
Subject: Re: [PATCH v3] mmc: sdhci-pci-gli: fix LPM negotiation so x86/S0ix
 SoCs can suspend
Content-Language: en-US
To:     Lai Jason <jasonlai.genesyslogic@gmail.com>,
        Sven van Ashbrook <svenva@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, ulf.hansson@linaro.org,
        ben.chuang@genesyslogic.com.tw, jason.lai@genesyslogic.com.tw,
        skardach@google.com, Renius Chen <reniuschengl@gmail.com>,
        rafael.j.wysocki@intel.com, linux-mmc@vger.kernel.org,
        stable@vger.kernel.org, SeanHY.chen@genesyslogic.com.tw,
        victor.shih@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw
References: <20230831160055.v3.1.I7ed1ca09797be2dd76ca914c57d88b32d24dac88@changeid>
 <CAG0XXUE+stL_vZa4UBdm1wciWqLUfx4Yx3c7UchAB5i-SoYPFg@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAG0XXUE+stL_vZa4UBdm1wciWqLUfx4Yx3c7UchAB5i-SoYPFg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/09/23 09:33, Lai Jason wrote:
> Hi,
> 
> On Fri, Sep 1, 2023 at 12:01 AM Sven van Ashbrook <svenva@chromium.org> wrote:
>>
>> To improve the r/w performance of GL9763E, the current driver inhibits LPM
>> negotiation while the device is active.
>>
>> This prevents a large number of SoCs from suspending, notably x86 systems
>> which commonly use S0ix as the suspend mechanism - for example, Intel
>> Alder Lake and Raptor Lake processors.
>>
>> Failure description:
>> 1. Userspace initiates s2idle suspend (e.g. via writing to
>>    /sys/power/state)
>> 2. This switches the runtime_pm device state to active, which disables
>>    LPM negotiation, then calls the "regular" suspend callback
>> 3. With LPM negotiation disabled, the bus cannot enter low-power state
>> 4. On a large number of SoCs, if the bus not in a low-power state, S0ix
>>    cannot be entered, which in turn prevents the SoC from entering
>>    suspend.
>>
>> Fix by re-enabling LPM negotiation in the device's suspend callback.
>>
>> Suggested-by: Stanislaw Kardach <skardach@google.com>
>> Fixes: f9e5b33934ce ("mmc: host: Improve I/O read/write performance for GL9763E")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Sven van Ashbrook <svenva@chromium.org>
> 
> LGTM.
> But I prefer Ben's opinion "I suppose cqhci_suspend() may need to be
> done first safely, then
> gl9763e_set_low_power_negotiation(slot, true)." because it can avoid
> GL9763E entering L1
> while cmdq engine processes I/O.

The block device is a child of the host controller so must already be
suspended at this point. So there is no I/O in process.

cqhci_suspend() just turns the cmdq engine off.

So I don't think a change is needed, but please correct me if
I am wrong.

> 
> Best regards,
> Jason Lai
> 
>> ---
>>
>> Changes in v3:
>> - applied maintainer feedback from https://lore.kernel.org/lkml/CACT4zj-BaX4tHji8B8gS5jiKkd-2BcwfzHM4fS-OUn0f8DSxcw@mail.gmail.com/T/#m7cea7b6b987d1ab1ca95feedf2c6f9da5783da5c
>>
>> Changes in v2:
>> - improved symmetry and error path in s2idle suspend callback (internal review)
>>
>>  drivers/mmc/host/sdhci-pci-gli.c | 104 ++++++++++++++++++++-----------
>>  1 file changed, 66 insertions(+), 38 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
>> index 1792665c9494a..a4ccb6c3e27a6 100644
>> --- a/drivers/mmc/host/sdhci-pci-gli.c
>> +++ b/drivers/mmc/host/sdhci-pci-gli.c
>> @@ -745,42 +745,6 @@ static u32 sdhci_gl9750_readl(struct sdhci_host *host, int reg)
>>         return value;
>>  }
>>
>> -#ifdef CONFIG_PM_SLEEP
>> -static int sdhci_pci_gli_resume(struct sdhci_pci_chip *chip)
>> -{
>> -       struct sdhci_pci_slot *slot = chip->slots[0];
>> -
>> -       pci_free_irq_vectors(slot->chip->pdev);
>> -       gli_pcie_enable_msi(slot);
>> -
>> -       return sdhci_pci_resume_host(chip);
>> -}
>> -
>> -static int sdhci_cqhci_gli_resume(struct sdhci_pci_chip *chip)
>> -{
>> -       struct sdhci_pci_slot *slot = chip->slots[0];
>> -       int ret;
>> -
>> -       ret = sdhci_pci_gli_resume(chip);
>> -       if (ret)
>> -               return ret;
>> -
>> -       return cqhci_resume(slot->host->mmc);
>> -}
>> -
>> -static int sdhci_cqhci_gli_suspend(struct sdhci_pci_chip *chip)
>> -{
>> -       struct sdhci_pci_slot *slot = chip->slots[0];
>> -       int ret;
>> -
>> -       ret = cqhci_suspend(slot->host->mmc);
>> -       if (ret)
>> -               return ret;
>> -
>> -       return sdhci_suspend_host(slot->host);
>> -}
>> -#endif
>> -
>>  static void gl9763e_hs400_enhanced_strobe(struct mmc_host *mmc,
>>                                           struct mmc_ios *ios)
>>  {
>> @@ -1029,6 +993,70 @@ static int gl9763e_runtime_resume(struct sdhci_pci_chip *chip)
>>  }
>>  #endif
>>
>> +#ifdef CONFIG_PM_SLEEP
>> +static int sdhci_pci_gli_resume(struct sdhci_pci_chip *chip)
>> +{
>> +       struct sdhci_pci_slot *slot = chip->slots[0];
>> +
>> +       pci_free_irq_vectors(slot->chip->pdev);
>> +       gli_pcie_enable_msi(slot);
>> +
>> +       return sdhci_pci_resume_host(chip);
>> +}
>> +
>> +static int gl9763e_resume(struct sdhci_pci_chip *chip)
>> +{
>> +       struct sdhci_pci_slot *slot = chip->slots[0];
>> +       int ret;
>> +
>> +       ret = sdhci_pci_gli_resume(chip);
>> +       if (ret)
>> +               return ret;
>> +
>> +       ret = cqhci_resume(slot->host->mmc);
>> +       if (ret)
>> +               return ret;
>> +
>> +       /*
>> +        * Disable LPM negotiation to bring device back in sync
>> +        * with its runtime_pm state.
>> +        */
>> +       gl9763e_set_low_power_negotiation(slot, false);
>> +
>> +       return 0;
>> +}
>> +
>> +static int gl9763e_suspend(struct sdhci_pci_chip *chip)
>> +{
>> +       struct sdhci_pci_slot *slot = chip->slots[0];
>> +       int ret;
>> +
>> +       /*
>> +        * Certain SoCs can suspend only with the bus in low-
>> +        * power state, notably x86 SoCs when using S0ix.
>> +        * Re-enable LPM negotiation to allow entering L1 state
>> +        * and entering system suspend.
>> +        */
>> +       gl9763e_set_low_power_negotiation(slot, true);
>> +
>> +       ret = cqhci_suspend(slot->host->mmc);
>> +       if (ret)
>> +               goto err_suspend;
>> +
>> +       ret = sdhci_suspend_host(slot->host);
>> +       if (ret)
>> +               goto err_suspend_host;
>> +
>> +       return 0;
>> +
>> +err_suspend_host:
>> +       cqhci_resume(slot->host->mmc);
>> +err_suspend:
>> +       gl9763e_set_low_power_negotiation(slot, false);
>> +       return ret;
>> +}
>> +#endif
>> +
>>  static int gli_probe_slot_gl9763e(struct sdhci_pci_slot *slot)
>>  {
>>         struct pci_dev *pdev = slot->chip->pdev;
>> @@ -1113,8 +1141,8 @@ const struct sdhci_pci_fixes sdhci_gl9763e = {
>>         .probe_slot     = gli_probe_slot_gl9763e,
>>         .ops            = &sdhci_gl9763e_ops,
>>  #ifdef CONFIG_PM_SLEEP
>> -       .resume         = sdhci_cqhci_gli_resume,
>> -       .suspend        = sdhci_cqhci_gli_suspend,
>> +       .resume         = gl9763e_resume,
>> +       .suspend        = gl9763e_suspend,
>>  #endif
>>  #ifdef CONFIG_PM
>>         .runtime_suspend = gl9763e_runtime_suspend,
>> --
>> 2.42.0.283.g2d96d420d3-goog
>>

