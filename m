Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9CC7AA2EE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbjIUVnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbjIUVmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:42:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723AD72A0;
        Thu, 21 Sep 2023 10:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695317320; x=1726853320;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=DUAFX+JNi4nRkne3bhKFanmYulDhmk2cpGuyh+eKgqo=;
  b=FEmp4GMi5sFXuNeAppelkM4neNxsBpk/C6B4yuDpgTd5oUe3CNmu1EbS
   Pz+EcVdT1/DRTcw6s0vEXitgkkJ8lF9LHY11wH7AULNQ2KKkRP8PcEuAF
   oUBo99iTsSotQyjgzPcxxlHlz48gz8RKuKxw1G8No9VpmekvfAz6XRyF9
   DdMqTcvbMa7MpUdw58MiQAdpqog6xMvVV+sgodfOWwAFSge2K7DPtBeUs
   CKPi0nZPuAl4SzPzNVB8t+00xzoZiHeodnCW0qlLxa3s/DriJoGcBDd42
   86fUxClvwgS/ANCDD8rDMKqvpEMRC8oDrxjQCJYd7Vqokp7rJzfZRKw+u
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="411422757"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="411422757"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 03:14:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="723688411"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="723688411"
Received: from asilke-mobl2.ger.corp.intel.com (HELO [10.213.199.249]) ([10.213.199.249])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 03:14:29 -0700
Message-ID: <6b9c8566-926d-40ff-7907-228d317fab3d@linux.intel.com>
Date:   Thu, 21 Sep 2023 11:14:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v6 6/6] drm/drm-file: Show finer-grained BO sizes in
 drm_show_memory_stats
Content-Language: en-US
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
To:     =?UTF-8?Q?Adri=c3=a1n_Larumbe?= <adrian.larumbe@collabora.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, sean@poorly.run,
        marijn.suijten@somainline.org, robh@kernel.org,
        steven.price@arm.com
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, healych@amazon.com,
        Boris Brezillon <boris.brezillon@collabora.com>,
        kernel@collabora.com, freedreno@lists.freedesktop.org
References: <20230919233556.1458793-1-adrian.larumbe@collabora.com>
 <20230919233556.1458793-7-adrian.larumbe@collabora.com>
 <ccfa3697-b015-ff35-fb92-0efcbd1d7d7c@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <ccfa3697-b015-ff35-fb92-0efcbd1d7d7c@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 20/09/2023 16:32, Tvrtko Ursulin wrote:
> 
> On 20/09/2023 00:34, Adrián Larumbe wrote:
>> The current implementation will try to pick the highest available size
>> display unit as soon as the BO size exceeds that of the previous
>> multiplier. That can lead to loss of precision in contexts of low memory
>> usage.
>>
>> The new selection criteria try to preserve precision, whilst also
>> increasing the display unit selection threshold to render more accurate
>> values.
>>
>> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
>> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
>> Reviewed-by: Steven Price <steven.price@arm.com>
>> ---
>>   drivers/gpu/drm/drm_file.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
>> index 762965e3d503..34cfa128ffe5 100644
>> --- a/drivers/gpu/drm/drm_file.c
>> +++ b/drivers/gpu/drm/drm_file.c
>> @@ -872,6 +872,8 @@ void drm_send_event(struct drm_device *dev, struct 
>> drm_pending_event *e)
>>   }
>>   EXPORT_SYMBOL(drm_send_event);
>> +#define UPPER_UNIT_THRESHOLD 100
>> +
>>   static void print_size(struct drm_printer *p, const char *stat,
>>                  const char *region, u64 sz)
>>   {
>> @@ -879,7 +881,8 @@ static void print_size(struct drm_printer *p, 
>> const char *stat,
>>       unsigned u;
>>       for (u = 0; u < ARRAY_SIZE(units) - 1; u++) {
>> -        if (sz < SZ_1K)
>> +        if ((sz & (SZ_1K - 1)) &&
> 
> IS_ALIGNED worth it at all?
> 
>> +            sz < UPPER_UNIT_THRESHOLD * SZ_1K)
>>               break;
> 
> Excuse me for a late comment (I was away). I did not get what what is 
> special about a ~10% threshold? Sounds to me just going with the lower 
> unit, when size is not aligned to the higher one, would be better than 
> sometimes precision-sometimes-not.

FWIW both current and the threshold option make testing the feature very 
annoying.

So I'd really propose we simply use smaller unit when unaligned.

Regards,

Tvrtko
