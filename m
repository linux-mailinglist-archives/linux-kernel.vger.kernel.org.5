Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22CC7672FE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 19:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbjG1RLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 13:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbjG1RLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 13:11:36 -0400
Received: from mgamail.intel.com (unknown [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0672D71;
        Fri, 28 Jul 2023 10:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690564294; x=1722100294;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eoQ6QIQA0eurvt4IsYsxuOVhy6X7PCzpPdYc+so7TII=;
  b=XaAEnlDgxiXc9lkLldOBzQmFX88Y9j6PzRW2k+UyYvYnmzyF/u+0cKjc
   KCsKzoeqoaGmZ8j5CLjfcpdbq1MMSGK16bAtLmmvdLsJuK7qvTPvDaKN5
   VNLT98P28mRWZ1LUBJfZ5uZu3urVoPewU6t1p/ui/u0FFCW3p5pmQIlU6
   PPUf6WTpnxrpSSpJ+KGYyN+KtcsO8V9LJkcrg6sriZ7SHkoiKcrs5QG8v
   y16KMbn2qoeNV94uZMK7tWOSwOp691M1jBILHtqB0rnH+yem+r+Rx3wz1
   UiXZJdkaRuRyuXwGgukfKdAwUAa2FBUAMYcXkhitPu+HmPcoSn9eY6DR1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="399580352"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="399580352"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 10:11:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="841384724"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="841384724"
Received: from shuaibah-mobl.amr.corp.intel.com (HELO [10.212.30.166]) ([10.212.30.166])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 10:11:33 -0700
Message-ID: <db5f1478-8aca-fb57-c3fc-aa09071a0829@linux.intel.com>
Date:   Fri, 28 Jul 2023 18:44:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v6 1/6] soundwire: bus: Allow SoundWire peripherals to
 register IRQ handlers
Content-Language: en-US
To:     Lee Jones <lee@kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     broonie@kernel.org, vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linus.walleij@linaro.org, lgirdwood@gmail.com,
        yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230725102532.2567580-1-ckeepax@opensource.cirrus.com>
 <20230725102532.2567580-2-ckeepax@opensource.cirrus.com>
 <20230728151818.GL8175@google.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230728151818.GL8175@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/28/23 17:18, Lee Jones wrote:
> Vinod, Bard, Pierre-Louis, Sanyog,
> 
> This has been on the list for some time now.
> 
> Would one of you please review this, so we can get it merged?

Sorry, I thought I provided my tag on an earlier version, but apparently
that never reached the ML. All my earlier feedback was taken into
account so no objections from me - just one typo below...

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> On Tue, 25 Jul 2023, Charles Keepax wrote:
> 
>> From: Lucas Tanure <tanureal@opensource.cirrus.com>
>>
>> Currently the in-band alerts for SoundWire peripherals can only
>> be communicated to the driver through the interrupt_callback
>> function. This however is slightly inconvient for devices that wish to

inconvenient

>> share IRQ handling code between SoundWire and I2C/SPI, the later would
>> normally register an IRQ handler with the IRQ subsystem. However there
>> is no reason the SoundWire in-band IRQs can not also be communicated
>> as an actual IRQ to the driver.
