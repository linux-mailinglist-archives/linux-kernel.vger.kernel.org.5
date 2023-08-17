Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED0477FBF7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 18:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353639AbjHQQW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 12:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353612AbjHQQV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 12:21:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A4C358D;
        Thu, 17 Aug 2023 09:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692289315; x=1723825315;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=Bv6xL5qkb79fBPG084R3pJENvc5/Ahe+5p+9JBEEGBI=;
  b=LKHreA7M2M3niCYNMEJIqPdc6scOwJ3c2HYi/yRmxM/6rJ4FW+UKSS+2
   voZmGsvAAaI8DCCaUPzQsFKwzziYfRv0/dWcEat5y2Hohen2g4kMJus4X
   0uPvIgKnJRBou2uc3JSMCXK5FNw7ai/t3yWOqVa3OB3OWlNCkPb+XY6ZT
   jvMmjFwyDn+xn3FC6MoH9kobi96nKGMQRi0IRvqLU2EcP6jF3VP/+qVHO
   u59MRjh46u9pdceIIcxsY5d2AjmDEDbbrn4JuQxyZlK4k9tXScqBllC4p
   7C7xfrnvrItr+pJ1MDuHonNzLBiUL04XHUw16zZTzEctDI9M/7BLKalsd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="370325515"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="370325515"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 09:17:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="737774313"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="737774313"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.40.107])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 09:16:59 -0700
Message-ID: <817a6dda-c227-8f90-97f3-204c7d03fb54@intel.com>
Date:   Thu, 17 Aug 2023 19:16:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [RESEND PATCH v3 2/2] ufs: poll HCS.UCRDY before issuing a UIC
 command
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, beanhuo@micron.com, sc.suh@samsung.com,
        hy50.seo@samsung.com, sh425.lee@samsung.com,
        kwangwon.min@samsung.com, junwoo80.lee@samsung.com,
        wkon.kim@samsung.com
References: <cover.1690939662.git.kwmad.kim@samsung.com>
 <CGME20230802013852epcas2p2334d33036d7d1a0bdbefaf5bb844928e@epcas2p2.samsung.com>
 <9c7ccbfb8fe05c29ab3e31d9cd14e6b91065b8b0.1690939662.git.kwmad.kim@samsung.com>
 <f1e154c4-bbb3-18a2-cb7a-41adae292b48@intel.com>
 <b9ade5d5-a160-5ecb-8dc5-777e8a586d51@acm.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <b9ade5d5-a160-5ecb-8dc5-777e8a586d51@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/08/23 18:02, Bart Van Assche wrote:
> On 8/14/23 04:26, Adrian Hunter wrote:
>> And perhaps the following is neater:
>>
>>     u32 val;
>>
>>     return !read_poll_timeout(ufshcd_readl, val, val & UIC_COMMAND_READY,
>>                   500, UIC_CMD_TIMEOUT * 1000, false, hba,
>>                   REG_CONTROLLER_STATUS);
> 
> Would the above make readers of that code wonder whether read_poll_timeout()
> perhaps returns a boolean? Wouldn't it be better to test the
> read_poll_timeout() return value as follows?
> 
>      return read_poll_timeout(ufshcd_readl, val, val & UIC_COMMAND_READY,
>                    500, UIC_CMD_TIMEOUT * 1000, false, hba,
>                    REG_CONTROLLER_STATUS) == 0;
> 

Either is fine, otherwise:

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

