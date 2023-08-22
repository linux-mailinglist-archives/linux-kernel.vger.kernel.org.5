Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27FA3784A01
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 21:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjHVTLW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 22 Aug 2023 15:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjHVTLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 15:11:20 -0400
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6651CCFC;
        Tue, 22 Aug 2023 12:11:12 -0700 (PDT)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-68bbd45d0d5so106543b3a.1;
        Tue, 22 Aug 2023 12:11:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692731472; x=1693336272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lz2e1mvvdxZXFPReu3GXvWGTqdMFsbCnxoB/bFwtJmM=;
        b=XggKg1hbxtVzHL5dwBiPoQPo4nqKfL4feJRLEphFo7VVoJxIhUCRnQZISqMduTp7Eb
         XY3JJswhySuX1E7v+i/tBkeVYAxcTCap+N0ZtiVbabGGkUx+m1r9XXsCmTvxQL9PhKEr
         euqxSH0PjJnnJQH7bvhQei2vjUZ0aYg7sQ61VR+3RYpMVOB9QxchZqwJMRgwnVYeRZ5o
         xg7/YQv3BKK2KGVrskI0UBOZw0lD9PnChQte61GyRC9TTn6YSvDf/OR33My5JPRHxrvQ
         ptOSUOe4wbI+Nx+og79CIyEyGhalSwNGv/njo9PY88PQR8mPwDtg/ebt5zLkfZC63Z1k
         B+Xw==
X-Gm-Message-State: AOJu0Yz+iBrUeB2Q65HCvS5I9JEbVNWd5mcOYLLZPT7ldKsHFBj8dlYI
        j33hRlqaDlZdQAc257pWTC6+iI1co/X+C8biGjg=
X-Google-Smtp-Source: AGHT+IFFwXVB1r7EoBPbnbE8ziIOn0Iod0CU42evFU9L9K0QWS8YN4WX5qd1mD8B7zlzI3lKExZ/BFDmsJgDqK14NoA=
X-Received: by 2002:a05:6a00:1892:b0:68a:61fb:8025 with SMTP id
 x18-20020a056a00189200b0068a61fb8025mr4451893pfh.1.1692731471673; Tue, 22 Aug
 2023 12:11:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230719011636.2893238-1-peng.fan@oss.nxp.com>
In-Reply-To: <20230719011636.2893238-1-peng.fan@oss.nxp.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 22 Aug 2023 21:10:59 +0200
Message-ID: <CAJZ5v0hH29C3_XQGt+ndb9dxgc3JZXYfwaN_5qXS0sVPY1xhig@mail.gmail.com>
Subject: Re: [PATCH 1/2] thermal/core: fix potential memory leak
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 3:12 AM Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> thermal_set_governor may allocate memory for tz->governor_data, so
> need free it in failure handling path.
>
> Addresses-Coverity: 25777220 ("Memory leak")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/thermal/thermal_core.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 842f678c1c3e..f633924406ad 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1355,6 +1355,9 @@ thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *t
>         return tz;
>
>  unregister:
> +       if (tz->governor && tz->governor->unbind_from_tz)
> +               tz->governor->unbind_from_tz(tz);

It looks like thermal_governor_lock should be held around this, shouldn't it?

> +
>         device_del(&tz->device);
>  release_device:
>         put_device(&tz->device);
> --
> 2.37.1
>
