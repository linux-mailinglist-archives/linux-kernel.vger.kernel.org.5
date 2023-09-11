Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8014779A308
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 07:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234142AbjIKFz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 01:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjIKFzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 01:55:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03CD1AE;
        Sun, 10 Sep 2023 22:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694411718; x=1725947718;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0fEjm1jxb/Olj2n6jCIvrQL41MREZC1zbfwkGBtQ4h8=;
  b=U3XPwj9vuWzGn3TamGMvVsVoxo/e/18K000j7duRRUXrljoVsx0xp3/s
   tFVCcJY1xzLowMFQZaqK1pz9D8NV6pRmuxUxebNOR3YtZIPeY/DQWmYlN
   G3uZbIcCDHWEGeArLVqFJzlb8hA0/KUJeZtCHcIzLuQUBqFZLEZdwEO+/
   NkLy6IOhdPBqTQg1Nq8hyJvcSd8brHOi7wC0V2ZBGYlCSp+cq2RCtXoZ0
   5s8koVwu2wWI10t7K5QxuEAVgTZKd3iLRP26ROFsbe0Dvt8T9ad+4WcMM
   7xjQeiTPJcPseHGHx2mE3I+5ZcqkKNlYQ7GntipK48541HmhiI7TAgoRE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="464377985"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="464377985"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2023 22:55:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="916912259"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="916912259"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.216.218])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2023 22:55:13 -0700
Message-ID: <7dc56344-ee1c-43d4-9751-ded8f76d5852@intel.com>
Date:   Mon, 11 Sep 2023 08:55:10 +0300
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
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <02b701d9e450$3e7d5ca0$bb7815e0$@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/09/23 04:35, Kiwoong Kim wrote:
>>> v2 -> v3: rule out the change of polling w/ pmc from this thread.
>>> (I'll post the change later)
>>> v1 -> v2: remove an unused variable in __ufshcd_send_uic_cmd
>>>
>>> Kiwoong Kim (2):
>>>   ufs: make __ufshcd_send_uic_cmd not wrapped by host_lock
>>>   ufs: poll HCS.UCRDY before issuing a UIC command
>>
>> Applied to 6.6/scsi-staging, thanks!
>>
>> --
>> Martin K. Petersen	Oracle Linux Engineering
> 
> Hi, Martin
> 
> The following patch seems to make trouble because of using
> read_poll_timeout.
> Its initial version used udelay and after discussion it's been changed.
> Could you revert this patch set?
> 
>> ufs: poll HCS.UCRDY before issuing a UIC command
> 
> [ 4671.226480] [3: kworker/u20:29:17140] BUG: scheduling while atomic:
> kworker/u20:29/17140/0x00000002
> ..
> [ 4671.228723] [3: kworker/u20:29:17140]  panic+0x16c/0x388
> [ 4671.228745] [3: kworker/u20:29:17140]  check_panic_on_warn+0x60/0x94
> [ 4671.228764] [3: kworker/u20:29:17140]  __schedule_bug+0x6c/0x94
> [ 4671.228786] [3: kworker/u20:29:17140]  __schedule+0x6f4/0xa64
> [ 4671.228806] [3: kworker/u20:29:17140]  schedule+0x7c/0xe8
> [ 4671.228824] [3: kworker/u20:29:17140]
> schedule_hrtimeout_range_clock+0x98/0x114
> [ 4671.228841] [3: kworker/u20:29:17140]  schedule_hrtimeout_range+0x14/0x24
> [ 4671.228856] [3: kworker/u20:29:17140]  usleep_range_state+0x60/0x94
> [ 4671.228871] [3: kworker/u20:29:17140]  __ufshcd_send_uic_cmd+0xa0/0x1c4
> [ 4671.228893] [3: kworker/u20:29:17140]  ufshcd_uic_pwr_ctrl+0x15c/0x390
> [ 4671.228908] [3: kworker/u20:29:17140]
> ufshcd_uic_hibern8_enter+0x9c/0x25c
> [ 4671.228922] [3: kworker/u20:29:17140]
> ufshcd_link_state_transition+0x34/0xb0
> [ 4671.228939] [3: kworker/u20:29:17140]  __ufshcd_wl_suspend+0x3f0/0x4b4

Do you know what is in that path that makes it an atomic context?

