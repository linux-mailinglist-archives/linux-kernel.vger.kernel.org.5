Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F125A79A42F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 09:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbjIKHKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 03:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbjIKHKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 03:10:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585D3133;
        Mon, 11 Sep 2023 00:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694416242; x=1725952242;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zygAe0g9eEkvkw9jlbTXNrao7JfvQbh1k7e620DHvt8=;
  b=lih5jCX9Aii+oyLAm1pBKNN+cbRJs9ANsgLVS9p0Mh2uA6GI557IbCUy
   JaZ4DoCSTGY4SNFbrQVHUCaw1+9zQpuMByRJCRE+ZtTALVQR5/NP1sbsR
   GaT1kmftJtv8vmRHCxxZSGLgVltfJsPoC0rWdN7qFal7OtQaCgSPW75bp
   mNBog3qOAJvEsQmxvbxaA1UOHmTpULotwjSvYwLMjvkESAygz1XbDO30N
   BYDap1lBevvi6QFITgO+T0N8wLz5zOhc6r/GIxgKG9v5+pvBWrCIOOXGQ
   6VGai49FFyQWNOjwf86KkFRlGr6ufSUf/5JTATKri6N5+qmAxHF3Mt9IU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="408980598"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="408980598"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 00:10:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="736674597"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="736674597"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.216.218])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 00:10:15 -0700
Message-ID: <fc40e4f8-6e84-9fbf-e2ca-87330c25c52a@intel.com>
Date:   Mon, 11 Sep 2023 10:10:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.0
Subject: Re: [RESEND PATCH v3 0/2] change UIC command handling
To:     Kiwoong Kim <kwmad.kim@samsung.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        jejb@linux.ibm.com, beanhuo@micron.com, sc.suh@samsung.com,
        hy50.seo@samsung.com, sh425.lee@samsung.com,
        kwangwon.min@samsung.com, junwoo80.lee@samsung.com,
        wkon.kim@samsung.com,
        "'Martin K. Petersen'" <martin.petersen@oracle.com>
References: <CGME20230904014146epcas2p37d6690a5eb3a5652571bb00e358231a3@epcas2p3.samsung.com>
 <cover.1693790060.git.kwmad.kim@samsung.com>
 <yq1jzt5j5go.fsf@ca-mkp.ca.oracle.com>
 <02b701d9e450$3e7d5ca0$bb7815e0$@samsung.com>
 <7dc56344-ee1c-43d4-9751-ded8f76d5852@intel.com>
 <001001d9e479$ac74c5d0$055e5170$@samsung.com>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <001001d9e479$ac74c5d0$055e5170$@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/09/23 09:32, Kiwoong Kim wrote:
>>>> ufs: poll HCS.UCRDY before issuing a UIC command
>>>
>>> [ 4671.226480] [3: kworker/u20:29:17140] BUG: scheduling while atomic:
>>> kworker/u20:29/17140/0x00000002
>>> ..
>>> [ 4671.228723] [3: kworker/u20:29:17140]  panic+0x16c/0x388 [
>>> 4671.228745] [3: kworker/u20:29:17140]  check_panic_on_warn+0x60/0x94
>>> [ 4671.228764] [3: kworker/u20:29:17140]  __schedule_bug+0x6c/0x94 [
>>> 4671.228786] [3: kworker/u20:29:17140]  __schedule+0x6f4/0xa64 [
>>> 4671.228806] [3: kworker/u20:29:17140]  schedule+0x7c/0xe8 [
>>> 4671.228824] [3: kworker/u20:29:17140]
>>> schedule_hrtimeout_range_clock+0x98/0x114
>>> [ 4671.228841] [3: kworker/u20:29:17140]
>>> schedule_hrtimeout_range+0x14/0x24
>>> [ 4671.228856] [3: kworker/u20:29:17140]  usleep_range_state+0x60/0x94
>>> [ 4671.228871] [3: kworker/u20:29:17140]
>>> __ufshcd_send_uic_cmd+0xa0/0x1c4 [ 4671.228893] [3:
>>> kworker/u20:29:17140]  ufshcd_uic_pwr_ctrl+0x15c/0x390 [ 4671.228908]
>>> [3: kworker/u20:29:17140] ufshcd_uic_hibern8_enter+0x9c/0x25c
>>> [ 4671.228922] [3: kworker/u20:29:17140]
>>> ufshcd_link_state_transition+0x34/0xb0
>>> [ 4671.228939] [3: kworker/u20:29:17140]
>>> __ufshcd_wl_suspend+0x3f0/0x4b4
>>
>> Do you know what is in that path that makes it an atomic context?
> 
> Hi,
> This made that.
> 
> static int ufshcd_uic_pwr_ctrl(struct ufs_hba *hba, struct uic_command *cmd)
> ..
>         bool reenable_intr = false;
> 
>         mutex_lock(&hba->uic_cmd_mutex); <<<<

It is OK to schedule while holding a mutex.  Are you sure
this is the problem?

> 
> 
> At first, I was willing to post together w/ the following patch but I've got a suggestion to split the patch set because of different topic and I split the patch set.
> - This patch removes the mutex, so it can fix the issue.
> https://lore.kernel.org/linux-scsi/1694051306-172962-1-git-send-email-kwmad.kim@samsung.com/
> 
> 
> But now I'm thinking again that simply removing the mutex could hurt atomicity of UIC command process
> that the original code intended for the first time.
> So I think this polling UCRDY should be modified rather than applying removal of the mutex.
> 
> 
> 

