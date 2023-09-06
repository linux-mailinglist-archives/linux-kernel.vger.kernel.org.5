Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879E7794475
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 22:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243687AbjIFUXi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 6 Sep 2023 16:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236993AbjIFUXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 16:23:36 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A904E59;
        Wed,  6 Sep 2023 13:23:33 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-1a2dd615ddcso68662fac.0;
        Wed, 06 Sep 2023 13:23:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694031812; x=1694636612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pf2yP3P7qdvXU33CpkaxRjxknUH4REyAw53pkZuj3eY=;
        b=lhQ0Wqg6XvomGLQmaDo2XiyJlirnbmbLGPLXJtyrvivnutAbt7z4Ul9OrTdoU4kDgF
         QTHPLyO6pFsYB/nf+1Z/J1tJ26Cv2SDcqBKL3XtI6xTbPD/iSj0WGLFcIg6sog0ZDdzt
         aXi9TJUxES2szozYBt21e7rGAW+bW3EGC+vNfNk7kbOA+OKNKsBJa6htUWFdDVdEjg39
         5psx9y9KnzSXTNoTTZui87PsqCeEjQD0x4XRdcVslb6SHqH3Pj4DZBKvAR3lJqM6Jumb
         xXccBUDnbSaTghFypucFzkpeZL827wolysUfyjYloDPiH7kuWSJsaPtNO/v7VSMztnIA
         y5zg==
X-Gm-Message-State: AOJu0YwWTZw6oaW/X5ZcApUHEqTevEp0H+xSOE2QBlXFvCR8dPhqDRbf
        DhSQ6iCbvqohjXzMtOnoX5MTvfVb3tG1w2Ix/CshmBIH
X-Google-Smtp-Source: AGHT+IGziI81dKFosk5RSKfP7aVdMFvE3/AQIy6NE4AftRZQePhHb/Tnc583U76XxkY82jh+pQ80hic+7x2GUIIk1vU=
X-Received: by 2002:a4a:db8a:0:b0:573:4a72:6ec with SMTP id
 s10-20020a4adb8a000000b005734a7206ecmr15120672oou.1.1694031812473; Wed, 06
 Sep 2023 13:23:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230906190816.2966001-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20230906190816.2966001-1-srinivas.pandruvada@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 6 Sep 2023 22:23:21 +0200
Message-ID: <CAJZ5v0je4b5cTeanU3O+L79BNtEhhzykrhuPVHoV9m1UfcLodg@mail.gmail.com>
Subject: Re: [PATCH v2] powercap: intel_rapl: Fix invalid setting of Power
 Limit 4
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     rafael@kernel.org, rui.zhang@intel.com, linux-pm@vger.kernel.org,
        sumeet.r.pawnikar@intel.com, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 6, 2023 at 9:08 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> System runs at minimum performance, once powercap RAPL package domain
> enabled flag is changed from 1 to 0 to 1.
>
> Setting RAPL package domain enabled flag to 0, results in setting of
> power limit 4 (PL4) MSR 0x601 to 0. This implies disabling PL4 limit.
> The PL4 limit controls the peak power. So setting 0, results in some
> undesirable performance, which depends on hardware implementation.
>
> Even worse, when the enabled flag is set to 1 again. This will set PL4
> MSR value to 0x01, which means reduce peak power to 0.125W. This will
> force system to run at the lowest possible performance on every PL4
> supported system.
>
> Setting enabled flag should only affect the "enable" bit, not other
> bits. Here it is changing power limit.
>
> This is caused by a change which assumes that there is an enable bit in
> the PL4 MSR like other power limits. Although PL4 enable/disable bit is
> present with TPMI RAPL interface, it is not present with the MSR
> interface.
>
> There is a rapl_primitive_info defined for non existent PL4 enable bit
> and then it is used with the commit 9050a9cd5e4c ("powercap: intel_rapl:
> Cleanup Power Limits support") to enable PL4. This is wrong, hence remove
> this rapl primitive for PL4. Also in the function
> rapl_detect_powerlimit(), PL_ENABLE is used to check for the presence of
> power limits. Replace PL_ENABLE with PL_LIMIT, as PL_LIMIT must be
> present. Without this change, PL4 controls will not be available in the
> sysfs once rapl primitive for PL4 is removed.
>
> Fixes: 9050a9cd5e4c ("powercap: intel_rapl: Cleanup Power Limits support")
> Suggested-by: Zhang Rui <rui.zhang@intel.com>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Tested-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
> Cc: stable@vger.kernel.org # v6.5+
> ---
> v2
> - Remove RAPL primitive for PL4 instead as suggedted by Rui
> - Replace PL_ENABLE with PL_LIMIT for domain detect
> - Update change log and header
>
>  drivers/powercap/intel_rapl_common.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
> index 5c2e6d5eea2a..40a2cc649c79 100644
> --- a/drivers/powercap/intel_rapl_common.c
> +++ b/drivers/powercap/intel_rapl_common.c
> @@ -658,8 +658,6 @@ static struct rapl_primitive_info rpi_msr[NR_RAPL_PRIMITIVES] = {
>                             RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
>         [PL2_CLAMP] = PRIMITIVE_INFO_INIT(PL2_CLAMP, POWER_LIMIT2_CLAMP, 48,
>                             RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
> -       [PL4_ENABLE] = PRIMITIVE_INFO_INIT(PL4_ENABLE, POWER_LIMIT4_MASK, 0,
> -                               RAPL_DOMAIN_REG_PL4, ARBITRARY_UNIT, 0),
>         [TIME_WINDOW1] = PRIMITIVE_INFO_INIT(TIME_WINDOW1, TIME_WINDOW1_MASK, 17,
>                             RAPL_DOMAIN_REG_LIMIT, TIME_UNIT, 0),
>         [TIME_WINDOW2] = PRIMITIVE_INFO_INIT(TIME_WINDOW2, TIME_WINDOW2_MASK, 49,
> @@ -1458,7 +1456,7 @@ static void rapl_detect_powerlimit(struct rapl_domain *rd)
>                         }
>                 }
>
> -               if (rapl_read_pl_data(rd, i, PL_ENABLE, false, &val64))
> +               if (rapl_read_pl_data(rd, i, PL_LIMIT, false, &val64))
>                         rd->rpl[i].name = NULL;
>         }
>  }
> --

Applied as 6.6-rc material, thanks!
