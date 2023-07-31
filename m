Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBFAA768972
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 03:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjGaBDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 21:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjGaBDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 21:03:31 -0400
Received: from mgamail.intel.com (unknown [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BDC4A8;
        Sun, 30 Jul 2023 18:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690765410; x=1722301410;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=H4f2pgcHPDppOpMIhE5jfAiRkV8P22+qE6ZHE70YtNw=;
  b=KXK43aXHn6mqY3u/l1TzQQpbWTUQimqcwR4y1wLOJUXyPJpatmzE37lQ
   b0yLqApOGpDiR7AhHbowEfLbXp6ZQIFoNM0bsWEx3CbNNiDiRQf+NquoJ
   MFUDE1KMJVaAb3gG1jxaPsEZqaIFEnRCUhuGBZbqXGXvy9R+L+UMvC2ls
   TwNsWqSlw7aRbH9CTqMTEK1Cr+Y3sOOv4IBRBYlHCKkd9vR1CEmYAskO8
   EpHsFxo/PrTcbYv+ibK+ssyTa8mdLwdOHYNWeBxYlPBVvhFwRSzn0P6Ly
   MyJ7J9za/WFitcu54pKi6GfbfHMbDO045XSxPhCtr2pirRppbPZFGXl+o
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="371599899"
X-IronPort-AV: E=Sophos;i="6.01,243,1684825200"; 
   d="scan'208";a="371599899"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2023 18:03:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="757759101"
X-IronPort-AV: E=Sophos;i="6.01,243,1684825200"; 
   d="scan'208";a="757759101"
Received: from yungchua-mobl2.ccr.corp.intel.com (HELO [10.92.2.114]) ([10.92.2.114])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2023 18:03:25 -0700
Message-ID: <502d8316-1630-5818-5ffe-e094788d847a@linux.intel.com>
Date:   Mon, 31 Jul 2023 09:03:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 1/6] soundwire: bus: Allow SoundWire peripherals to
 register IRQ handlers
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Lee Jones <lee@kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     broonie@kernel.org, vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linus.walleij@linaro.org, lgirdwood@gmail.com,
        sanyog.r.kale@intel.com, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230725102532.2567580-1-ckeepax@opensource.cirrus.com>
 <20230725102532.2567580-2-ckeepax@opensource.cirrus.com>
 <20230728151818.GL8175@google.com>
 <db5f1478-8aca-fb57-c3fc-aa09071a0829@linux.intel.com>
Content-Language: en-US
From:   "Liao, Bard" <yung-chuan.liao@linux.intel.com>
In-Reply-To: <db5f1478-8aca-fb57-c3fc-aa09071a0829@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/29/2023 12:44 AM, Pierre-Louis Bossart wrote:
>
> On 7/28/23 17:18, Lee Jones wrote:
>> Vinod, Bard, Pierre-Louis, Sanyog,
>>
>> This has been on the list for some time now.
>>
>> Would one of you please review this, so we can get it merged?
> Sorry, I thought I provided my tag on an earlier version, but apparently
> that never reached the ML. All my earlier feedback was taken into
> account so no objections from me - just one typo below...
>
> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>


The patch looks good to me.

Acked-by: Bard Liao <yung-chuan.liao@linux.intel.com>

>> On Tue, 25 Jul 2023, Charles Keepax wrote:
>>
>>> From: Lucas Tanure <tanureal@opensource.cirrus.com>
>>>
>>> Currently the in-band alerts for SoundWire peripherals can only
>>> be communicated to the driver through the interrupt_callback
>>> function. This however is slightly inconvient for devices that wish to
> inconvenient
>
>>> share IRQ handling code between SoundWire and I2C/SPI, the later would
>>> normally register an IRQ handler with the IRQ subsystem. However there
>>> is no reason the SoundWire in-band IRQs can not also be communicated
>>> as an actual IRQ to the driver.
