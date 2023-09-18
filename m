Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD65A7A469B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 12:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234767AbjIRKEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 06:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241109AbjIRKD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 06:03:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 68B6F187;
        Mon, 18 Sep 2023 03:03:19 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 589551FB;
        Mon, 18 Sep 2023 03:03:56 -0700 (PDT)
Received: from [10.57.64.210] (unknown [10.57.64.210])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 70ADB3F67D;
        Mon, 18 Sep 2023 03:03:15 -0700 (PDT)
Message-ID: <3785093c-0237-05fa-3c96-2239ce2417b3@arm.com>
Date:   Mon, 18 Sep 2023 11:03:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v5 6/6] drm/drm-file: Show finer-grained BO sizes in
 drm_show_memory_stats
Content-Language: en-GB
To:     =?UTF-8?Q?Adri=c3=a1n_Larumbe?= <adrian.larumbe@collabora.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, sean@poorly.run,
        marijn.suijten@somainline.org, robh@kernel.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        healych@amazon.com, kernel@collabora.com
References: <20230914223928.2374933-1-adrian.larumbe@collabora.com>
 <20230914223928.2374933-7-adrian.larumbe@collabora.com>
From:   Steven Price <steven.price@arm.com>
In-Reply-To: <20230914223928.2374933-7-adrian.larumbe@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/2023 23:38, Adrián Larumbe wrote:
> The current implementation will try to pick the highest available size
> display unit as soon as the BO size exceeds that of the previous
> multiplier. That can lead to loss of precision in contexts of low memory
> usage.
> 
> The new selection criteria try to preserve precision, whilst also
> increasing the display unit selection threshold to render more accurate
> values.
> 
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>

I have to admit I find it odd to be "pretty printing" this value in the
first place. But this is clearly an improvement.

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  drivers/gpu/drm/drm_file.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
> index 762965e3d503..34cfa128ffe5 100644
> --- a/drivers/gpu/drm/drm_file.c
> +++ b/drivers/gpu/drm/drm_file.c
> @@ -872,6 +872,8 @@ void drm_send_event(struct drm_device *dev, struct drm_pending_event *e)
>  }
>  EXPORT_SYMBOL(drm_send_event);
>  
> +#define UPPER_UNIT_THRESHOLD 100
> +
>  static void print_size(struct drm_printer *p, const char *stat,
>  		       const char *region, u64 sz)
>  {
> @@ -879,7 +881,8 @@ static void print_size(struct drm_printer *p, const char *stat,
>  	unsigned u;
>  
>  	for (u = 0; u < ARRAY_SIZE(units) - 1; u++) {
> -		if (sz < SZ_1K)
> +		if ((sz & (SZ_1K - 1)) &&
> +		    sz < UPPER_UNIT_THRESHOLD * SZ_1K)
>  			break;
>  		sz = div_u64(sz, SZ_1K);
>  	}

