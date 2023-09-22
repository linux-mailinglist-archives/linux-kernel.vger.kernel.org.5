Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D1F7AB01F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 13:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbjIVLCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 07:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjIVLCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 07:02:00 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEA4AC;
        Fri, 22 Sep 2023 04:01:54 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a02:8010:65b5:0:1ac0:4dff:feee:236a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: alarumbe)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4003F6607298;
        Fri, 22 Sep 2023 12:01:53 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695380513;
        bh=DH0CgaoapBhQcnFaMJV2Rkn3poFia6kb9FUwld5Yr2E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dJ6zNgz1saDEIBBf1GHZ23CbSGegBUGIrVNb+i9AEu7qR7jYz7IFXRRwOXFkniNu1
         6W2QvGETHn3Hg4eV1rtjcfRLwntU5BFH9z16vwMG+INRFoLhmsK/hyd038lOzee5MG
         AN5V2N/xLwAz9WcUkPcDs6BjqK6OhUIl4L7Oiv8GEkueYje3z+Q9DexAffumG3TVZw
         AhdiIfJS9WhrfHrzWBCT03jT0+u2Kj7Rjw6R8BqH5Q/t+b9YaeI+e9gBQBq8NqVkU0
         LT3OV+n/GPDdwshll/UEVl7U9WRMwpbWzK0dG0oxPb9ao1Z+1dfAzXG49BGOpBPbUh
         /+nO2CcbzXwbg==
Date:   Fri, 22 Sep 2023 12:01:51 +0100
From:   =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
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
Subject: Re: [PATCH v6 6/6] drm/drm-file: Show finer-grained BO sizes in
 drm_show_memory_stats
Message-ID: <3l4prybv2bhyd5s3s7vkfo3k42cjndl2db53sntduqeuwjquld@tfop5o5p6gez>
References: <20230919233556.1458793-1-adrian.larumbe@collabora.com>
 <20230919233556.1458793-7-adrian.larumbe@collabora.com>
 <ccfa3697-b015-ff35-fb92-0efcbd1d7d7c@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ccfa3697-b015-ff35-fb92-0efcbd1d7d7c@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.09.2023 16:32, Tvrtko Ursulin wrote:
>
>On 20/09/2023 00:34, Adrián Larumbe wrote:
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
>>   drivers/gpu/drm/drm_file.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
>> index 762965e3d503..34cfa128ffe5 100644
>> --- a/drivers/gpu/drm/drm_file.c
>> +++ b/drivers/gpu/drm/drm_file.c
>> @@ -872,6 +872,8 @@ void drm_send_event(struct drm_device *dev, struct drm_pending_event *e)
>>   }
>>   EXPORT_SYMBOL(drm_send_event);
>> +#define UPPER_UNIT_THRESHOLD 100
>> +
>>   static void print_size(struct drm_printer *p, const char *stat,
>>   		       const char *region, u64 sz)
>>   {
>> @@ -879,7 +881,8 @@ static void print_size(struct drm_printer *p, const char *stat,
>>   	unsigned u;
>>   	for (u = 0; u < ARRAY_SIZE(units) - 1; u++) {
>> -		if (sz < SZ_1K)
>> +		if ((sz & (SZ_1K - 1)) &&
>
>IS_ALIGNED worth it at all?

This could look better, yeah.

>> +		    sz < UPPER_UNIT_THRESHOLD * SZ_1K)
>>   			break;
>
>Excuse me for a late comment (I was away). I did not get what what is special
>about a ~10% threshold? Sounds to me just going with the lower unit, when size
>is not aligned to the higher one, would be better than sometimes
>precision-sometimes-not.

We had a bit of a debate over this in previous revisions of the patch. It all began
when a Panfrost user complained that for relatively small BOs, they were losing
precision in the fdinfo file because the sum of the sizes of all BOs for a drm file
was in the order of MiBs, but not big enough to warrant losing accuracy when
plotting them on nvtop or gputop.

At first I thought of letting drivers pick their own preferred unit, but this would
lead to inconsistency in the units presented in the fdinfo file across different
DRM devices. Rob then suggested imposing a unit multiple threshold, while Boris
made the suggestion of checking for unit size alignment to lessen precision loss.

In the end Rob thought that minding both constraints was a good solution of compromise.

The unit threshold was picked sort of arbitrarily, and suggested by Rob himself. The
point of having it is avoiding huge number representations for BO size tallies that
aren't aligned to the next unit, and also because BO size sums are scaled when
plotting them on a Y axis, so complete accuracy isn't a requirement.

>Regards,
>
>Tvrtko
>
>>   		sz = div_u64(sz, SZ_1K);
>>   	}

Adrian Larumbe
