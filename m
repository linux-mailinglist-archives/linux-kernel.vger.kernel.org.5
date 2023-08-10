Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF4C7778C4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 14:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbjHJMot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 08:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234757AbjHJMor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 08:44:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 045E2EA;
        Thu, 10 Aug 2023 05:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691671487; x=1723207487;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tm/ehkerVlnsVnyp3jgTYgLbj1MAQl9vx0LYOWLJiDQ=;
  b=YT+PwpWkHdxDGrHs3C5O3Uj63n7tleT8vtlG675AL+/aSrwWO7v6rbLB
   qMXetSxJGeu7ebBfd0ZWnTtrqaRsCJrYrv9PHU7qFW3ddB6rlkiDFbDXR
   e1C9KinIncyN6URKHCyu4wGypMAAxl7CKmsIigjwsZQGkvn0bmOxqk9va
   QKdMMR4jEv2uj9Ra1yZWpkE0rsMbuwZ5hX+mp5ycvll8pUtpqLe6u/Q28
   ZsiZWR0IAqPvIPELUf1NVCr87jUoqs7dD6WQSZYYmymTNJAAIXcCIfMcz
   kct7OLdFU0j7vTMmFV7IjcyPbgUHcI54AuygU5o9tGQet39rXHvHvUDBL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="350972552"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="350972552"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 05:44:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="732212189"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="732212189"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.49.88])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 05:44:44 -0700
Message-ID: <a2f6cd0e-8429-3468-9dcf-a5022717e2ae@intel.com>
Date:   Thu, 10 Aug 2023 15:44:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v7] mmc: sdhci-of-dwcmshc: Add runtime PM operations
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Liming Sun <limings@nvidia.com>,
        David Thompson <davthompson@nvidia.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <79137159a833c164ea8ea3f05d8d6d9537db2f42.1683747334.git.limings@nvidia.com>
 <20230808202319.191434-1-limings@nvidia.com>
 <16047c7a-5bd1-868c-e6eb-e5f415e77fdd@intel.com>
 <CAPDyKFp28mmbRAGf14u8KTO3v7H=SFAYbwcz7xeb1m4tD_G2vQ@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAPDyKFp28mmbRAGf14u8KTO3v7H=SFAYbwcz7xeb1m4tD_G2vQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/23 13:21, Ulf Hansson wrote:
> On Thu, 10 Aug 2023 at 10:13, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 8/08/23 23:23, Liming Sun wrote:
>>> This commit implements the runtime PM operations to disable eMMC
>>> card clock when idle.
>>>
>>> Reviewed-by: David Thompson <davthompson@nvidia.com>
>>> Signed-off-by: Liming Sun <limings@nvidia.com>
>>> ---
>>> v6->v7:
>>>     - Address Ulf's comment;
>>> v5->v6:
>>>     - Address Adrian's more comments and add coordination between
>>>       runtime PM and system PM;
>>> v4->v5:
>>>     - Address Adrian's comment to move the pm_enable to the end to
>>>       avoid race;
>>> v3->v4:
>>>     - Fix compiling reported by 'kernel test robot';
>>> v2->v3:
>>>     - Revise the commit message;
>>> v1->v2:
>>>     Updates for comments from Ulf:
>>>     - Make the runtime PM logic generic for sdhci-of-dwcmshc;
>>> v1: Initial version.
>>> ---
>>>  drivers/mmc/host/sdhci-of-dwcmshc.c | 72 ++++++++++++++++++++++++++++-
>>>  1 file changed, 70 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
>>> index e68cd87998c8..c8e145031429 100644
>>> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
>>> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
>>> @@ -15,6 +15,7 @@
>>>  #include <linux/module.h>
>>>  #include <linux/of.h>
>>>  #include <linux/of_device.h>
>>> +#include <linux/pm_runtime.h>
>>>  #include <linux/reset.h>
>>>  #include <linux/sizes.h>
>>>
>>> @@ -548,9 +549,13 @@ static int dwcmshc_probe(struct platform_device *pdev)
>>>
>>>       host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
>>>
>>> +     pm_runtime_get_noresume(dev);
>>> +     pm_runtime_set_active(dev);
>>> +     pm_runtime_enable(dev);
>>> +
>>>       err = sdhci_setup_host(host);
>>>       if (err)
>>> -             goto err_clk;
>>> +             goto err_rpm;
>>>
>>>       if (rk_priv)
>>>               dwcmshc_rk35xx_postinit(host, priv);
>>> @@ -559,10 +564,15 @@ static int dwcmshc_probe(struct platform_device *pdev)
>>>       if (err)
>>>               goto err_setup_host;
>>>
>>> +     pm_runtime_put(dev);
>>> +
>>>       return 0;
>>>
>>>  err_setup_host:
>>>       sdhci_cleanup_host(host);
>>> +err_rpm:
>>> +     pm_runtime_disable(dev);
>>> +     pm_runtime_put_noidle(dev);
>>>  err_clk:
>>>       clk_disable_unprepare(pltfm_host->clk);
>>>       clk_disable_unprepare(priv->bus_clk);
>>> @@ -606,6 +616,12 @@ static int dwcmshc_suspend(struct device *dev)
>>>       if (ret)
>>>               return ret;
>>>
>>> +     ret = pm_runtime_force_suspend(dev);
>>> +     if (ret) {
>>> +             sdhci_resume_host(host);
>>> +             return ret;
>>> +     }
>>
>> Since you are only using the runtime PM callbacks to turn off the card
>> clock via SDHCI_CLOCK_CONTROL, pm_runtime_force_suspend() and
>> pm_runtime_force_resume() are not needed at all.
> 
> Right, it can be done without these too.
> 
>>
>> sdhci_suspend_host() does not care if SDHCI_CLOCK_CARD_EN is on or off.
>> (And you are disabling pltfm_host->clk and priv->bus_clk, so presumably
>> the result is no clock either way)
>>
>> sdhci_resume_host() does not restore state unless
>> SDHCI_QUIRK2_HOST_OFF_CARD_ON is used, it just resets, so the internal clock
>> SDHCI_CLOCK_INT_EN is off which is consistent with either runtime suspended
>> or runtime resumed.
> 
> Even if this may work, to me, it doesn't look like good practice for
> how to use runtime PM in combination with system wide suspend/resume.
> 
> The point is, sdhci_suspend|resume_host() may end up reading/writing
> to sdhci registers - and we should *not* allow that (because it may
> not always work), unless the sdhci controller has been runtime resumed
> first, right?

I am OK with drivers that just want to use runtime PM to turn off a
functional clock.  sdhci-tegra.c is also doing that although using the
clock framework.

Certainly that approach assumes that the host controller's power state
is not changed due to runtime PM.

To ensure that the host controller is runtime resumed before calling
sdhci_suspend_host(), we can just call pm_runtime_resume() I think.

