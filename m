Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D74267E1A48
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 07:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjKFGjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 01:39:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbjKFGi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 01:38:59 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183DAF2;
        Sun,  5 Nov 2023 22:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699252737; x=1730788737;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wvdbe6zVR8rZcC9nQE2AwaoKXs2J2UvptwC3bmJCfP0=;
  b=alK7wG2wLBbrNywBuHIIwE84JlTcaeiEDTEjC+yXmoxAfPrcYD+Mnwzn
   E9PoDByvjxeB7Q7CCwsMQv/7CMU/a+gmOpfFSq/CygvWF8QQHx8v0ZdT8
   Kzv2D3q93HZHSp8EHXShkp1nZxErzTLdjHyOm6ivzDV8zLOmFtXnt/D4z
   9damhoKkkdNSA6RFkpfbSJkHa7QHxFPztlQgGckbj2aYsbDpMdV/HZRGA
   adX0o+sBr9wEUg4vqT28CqGO9DAq7K8URtW+NdyoX8Ag1NlaL08eZao58
   Ea6ScNaPRuszyf2JmC9w2UY/hDLq+1mE8R+7qwQVwt5VkSRu9bEYLiOhA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="388099119"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; 
   d="scan'208";a="388099119"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2023 22:38:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="1093683958"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; 
   d="scan'208";a="1093683958"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.215.231])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2023 22:38:50 -0800
Message-ID: <34fde333-411a-4345-b940-4a34d45b499e@intel.com>
Date:   Mon, 6 Nov 2023 08:38:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 0/6] mmc: block: Fixes for CQE error recovery recovery
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
 <DM6PR04MB65758B72F1260C13951C83FCFCA5A@DM6PR04MB6575.namprd04.prod.outlook.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <DM6PR04MB65758B72F1260C13951C83FCFCA5A@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/11/23 12:10, Avri Altman wrote:
> Does the double "recovery"  in the subject intentional?

No, must be an echo in here

> 
> Thanks,
> Avri
>  
>> Hi
>>
>> Some issues have been found with CQE error recovery.  Here are some fixes.
>>
>> As of V2, the alternative implementation for the patch from Kornel Dulęba:
>>
>>         https://lore.kernel.org/linux-mmc/e7c12e07-7540-47ea-8891-
>> 2cec73d58df1@intel.com/T/#u
>>
>> is now included, see patch 6 "mmc: cqhci: Fix task clearing in CQE error
>> recovery")
>>
>> Please also note ->post_disable() seems to be missing from
>> cqhci_recovery_start().  It would be good if ->post_disable() users could
>> check if this needs attention.
>>
>>
>> Changes in V2:
>>
>>       mmc: cqhci: Fix task clearing in CQE error recovery
>>             New patch
>>
>>       mmc: cqhci: Warn of halt or task clear failure
>>             Add fixes and stable tags
>>
>>
>> Adrian Hunter (6):
>>       mmc: block: Do not lose cache flush during CQE error recovery
>>       mmc: cqhci: Increase recovery halt timeout
>>       mmc: block: Be sure to wait while busy in CQE error recovery
>>       mmc: block: Retry commands in CQE error recovery
>>       mmc: cqhci: Warn of halt or task clear failure
>>       mmc: cqhci: Fix task clearing in CQE error recovery
>>
>>  drivers/mmc/core/block.c      |  2 ++
>>  drivers/mmc/core/core.c       |  9 +++++++--
>>  drivers/mmc/host/cqhci-core.c | 44 +++++++++++++++++++++-----------------
>> -----
>>  3 files changed, 31 insertions(+), 24 deletions(-)
>>
>>
>> Regards
>> Adrian

