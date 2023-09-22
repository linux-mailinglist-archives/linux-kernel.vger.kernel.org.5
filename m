Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16AA47AB340
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 16:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbjIVOER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 10:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbjIVOEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 10:04:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40C2136;
        Fri, 22 Sep 2023 07:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695391449; x=1726927449;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BTfvrs5EOPQJfVJYIu6aaO3NsW53LRV0R0jYG09hQ3Y=;
  b=Gsr0XRxk7MmVs/cpHbgDI60b6qRbwq9NOnYuuvepp27O5qFrokEq0qf9
   xhY/02rR5miG2+AvmtLna9kr+9NHySIFcgeRWPtt0SAnFvqmp949lO5wk
   dTEcuXwbtUatU6XtLUKaKMGQGHHsaEXdty8fKI89rni+yPC1UUTqtjulY
   3CJJygM98IZwfkn933WZ2G+dk9pWoU80LmBNXg+GKCGeGpIQnyrZD/5b+
   aUBGlsAai+SvDiG1ZVxg/ADjWqHK2ZObpVnLAtoUy2l3CmbOY7hpItgWL
   VO1o3dTIW34V7+QyzpA08U5mVAsEdOl8TUeldUZscxELoncs/4+GyDeNC
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="378122882"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="378122882"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 07:03:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="871253379"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="871253379"
Received: from placki-mobl.ger.corp.intel.com (HELO [10.213.200.149]) ([10.213.200.149])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 07:02:32 -0700
Message-ID: <5a92b93c-6c6c-059a-c07b-a8b0b4b2b364@linux.intel.com>
Date:   Fri, 22 Sep 2023 15:02:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v6 6/6] drm/drm-file: Show finer-grained BO sizes in
 drm_show_memory_stats
Content-Language: en-US
To:     =?UTF-8?Q?Adri=c3=a1n_Larumbe?= <adrian.larumbe@collabora.com>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, sean@poorly.run,
        marijn.suijten@somainline.org, robh@kernel.org,
        steven.price@arm.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        healych@amazon.com,
        Boris Brezillon <boris.brezillon@collabora.com>,
        kernel@collabora.com, freedreno@lists.freedesktop.org
References: <20230919233556.1458793-1-adrian.larumbe@collabora.com>
 <20230919233556.1458793-7-adrian.larumbe@collabora.com>
 <ccfa3697-b015-ff35-fb92-0efcbd1d7d7c@linux.intel.com>
 <6b9c8566-926d-40ff-7907-228d317fab3d@linux.intel.com>
 <rn5metso2yr2kyxix3fh2ub77jpjf6avs754eshgpd2lu33bkw@33way22pozgh>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <rn5metso2yr2kyxix3fh2ub77jpjf6avs754eshgpd2lu33bkw@33way22pozgh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 22/09/2023 12:03, Adrián Larumbe wrote:
> On 21.09.2023 11:14, Tvrtko Ursulin wrote:
>>
>> On 20/09/2023 16:32, Tvrtko Ursulin wrote:
>>>
>>> On 20/09/2023 00:34, Adrián Larumbe wrote:
>>>> The current implementation will try to pick the highest available size
>>>> display unit as soon as the BO size exceeds that of the previous
>>>> multiplier. That can lead to loss of precision in contexts of low memory
>>>> usage.
>>>>
>>>> The new selection criteria try to preserve precision, whilst also
>>>> increasing the display unit selection threshold to render more accurate
>>>> values.
>>>>
>>>> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
>>>> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
>>>> Reviewed-by: Steven Price <steven.price@arm.com>
>>>> ---
>>>>    drivers/gpu/drm/drm_file.c | 5 ++++-
>>>>    1 file changed, 4 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
>>>> index 762965e3d503..34cfa128ffe5 100644
>>>> --- a/drivers/gpu/drm/drm_file.c
>>>> +++ b/drivers/gpu/drm/drm_file.c
>>>> @@ -872,6 +872,8 @@ void drm_send_event(struct drm_device *dev, struct
>>>> drm_pending_event *e)
>>>>    }
>>>>    EXPORT_SYMBOL(drm_send_event);
>>>> +#define UPPER_UNIT_THRESHOLD 100
>>>> +
>>>>    static void print_size(struct drm_printer *p, const char *stat,
>>>>                   const char *region, u64 sz)
>>>>    {
>>>> @@ -879,7 +881,8 @@ static void print_size(struct drm_printer *p,
>>>> const char *stat,
>>>>        unsigned u;
>>>>        for (u = 0; u < ARRAY_SIZE(units) - 1; u++) {
>>>> -        if (sz < SZ_1K)
>>>> +        if ((sz & (SZ_1K - 1)) &&
>>>
>>> IS_ALIGNED worth it at all?
>>>
>>>> +            sz < UPPER_UNIT_THRESHOLD * SZ_1K)
>>>>                break;
>>>
>>> Excuse me for a late comment (I was away). I did not get what what is
>>> special about a ~10% threshold? Sounds to me just going with the lower
>>> unit, when size is not aligned to the higher one, would be better than
>>> sometimes precision-sometimes-not.
>>
>> FWIW both current and the threshold option make testing the feature very
>> annoying.
> 
> How so?

I have to build in the knowledge of implementation details of 
print_size() into my IGT in order to use the right size BOs, so test is 
able to verify stats move as expected. It just feels wrong.

>> So I'd really propose we simply use smaller unit when unaligned.
> 
> Like I said in the previous reply, for drm files whose overall BO size sum is enormous
> but not a multiple of a MiB, this would render huge number representations in KiB.
> I don't find this particularly comfortable to read, and then this extra precision
> would mean nothing to nvtop or gputop, which would have to scale the size to their
> available screen dimensions when plotting them.

I don't think numbers in KiB are so huge.

And I don't think people will end up reading them manually a lot anyway, 
since you have to hunt the pid, and fd, etc.. It is much more realistic 
that some tool like gputop will be used.

And I don't think consistency of units across drivers or whatever 
matters. Even better to keep userspace parser on their toes and make 
then follow drm-usage-stats.rst and not any implementations, at some 
point in time.

Regards,

Tvrtko
