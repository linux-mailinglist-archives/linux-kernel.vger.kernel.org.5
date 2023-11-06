Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E217E1A8D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 07:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbjKFG6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 01:58:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjKFG6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 01:58:07 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04FCCA4;
        Sun,  5 Nov 2023 22:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699253885; x=1730789885;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=d/1uCOzy63KPya2fh5wdWCSdQMv4USuUbMlWjMlQ4EE=;
  b=WCRSfy5jCKnakdsywufSVJFh7zTRlmeLcqy73FlNTw4Ufwo7PYgFn36R
   x1u86eKmaEoQBuj9Lo1MCDrXMhudCUjwT6FPrS/Sm7pVhQB7ZpXONZjdO
   pXCXsUCWkhJ0K57SS3DTbdfKZsyLo1pBGRrgJB3HdA60JM1E4LOcbqPXK
   bUtImtOAGsk6s5ShajCKjhv/p3eq29biyeDWgF+zuoXoAxgx8V4NYRqTq
   9gFIyDTw7438D4D5qbW1X35lULKFZC7RwmQsNkE9uWrfdwJOP/+Y4vbBl
   NaqYxKZJeQu7CLfOg6UCKZzq4uACbBofZLrI+mdvcZXukXFeXS8R3lFpD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="368554212"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; 
   d="scan'208";a="368554212"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2023 22:58:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="738719602"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; 
   d="scan'208";a="738719602"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.215.231])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2023 22:57:59 -0800
Message-ID: <0c36eb5d-d703-47e2-963f-619cb542ba3f@intel.com>
Date:   Mon, 6 Nov 2023 08:57:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/6] mmc: cqhci: Increase recovery halt timeout
Content-Language: en-US
To:     Avri Altman <Avri.Altman@wdc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        =?UTF-8?Q?Kornel_Dul=C4=99ba?= <korneld@chromium.org>,
        Radoslaw Biernacki <biernacki@google.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Asutosh Das <quic_asutoshd@quicinc.com>
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Bhavya Kapoor <b-kapoor@ti.com>,
        Kamal Dasu <kamal.dasu@broadcom.com>,
        Al Cooper <alcooperx@gmail.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>,
        Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
        Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Thierry Reding <thierry.reding@gmail.com>,
        Aniruddha Tvs Rao <anrao@nvidia.com>,
        Chun-Hung Wu <chun-hung.wu@mediatek.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20231103084720.6886-1-adrian.hunter@intel.com>
 <20231103084720.6886-3-adrian.hunter@intel.com>
 <DM6PR04MB65752D6E30DFE006E2CD5632FCA5A@DM6PR04MB6575.namprd04.prod.outlook.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <DM6PR04MB65752D6E30DFE006E2CD5632FCA5A@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/11/23 12:37, Avri Altman wrote:
>> Failing to halt complicates the recovery. Additionally, unless the card or
>> controller are stuck, which is expected to be very rare, then the halt should
>> succeed, so it is better to wait. Set a large timeout.
> Maybe also explain that If task queuing is in progress, CQE needs to complete the operation, sending both commands and processing the responses.

True, although those commands should be quite quick.

> 
>>
>> Fixes: a4080225f51d ("mmc: cqhci: support for command queue enabled
>> host")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> Reviewed-by: Avri Altman <avri.altman@wdc.com>
> 
>> ---
>>  drivers/mmc/host/cqhci-core.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
>> index b3d7d6d8d654..15f5a069af1f 100644
>> --- a/drivers/mmc/host/cqhci-core.c
>> +++ b/drivers/mmc/host/cqhci-core.c
>> @@ -984,10 +984,10 @@ static bool cqhci_halt(struct mmc_host *mmc,
>> unsigned int timeout)
>>  /*
>>   * After halting we expect to be able to use the command line. We interpret
>> the
>>   * failure to halt to mean the data lines might still be in use (and the upper
>> - * layers will need to send a STOP command), so we set the timeout based
>> on a
>> - * generous command timeout.
>> + * layers will need to send a STOP command), however failing to halt
>> + complicates
>> + * the recovery, so set a timeout that would reasonably allow I/O to
>> complete.
>>   */
>> -#define CQHCI_START_HALT_TIMEOUT       5
>> +#define CQHCI_START_HALT_TIMEOUT       500
>>
>>  static void cqhci_recovery_start(struct mmc_host *mmc)  {
>> --
>> 2.34.1
> 

