Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5E0784B31
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 22:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbjHVUNA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 22 Aug 2023 16:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbjHVUM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 16:12:59 -0400
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A000CF2;
        Tue, 22 Aug 2023 13:12:51 -0700 (PDT)
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-564670fad4bso390861a12.1;
        Tue, 22 Aug 2023 13:12:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692735170; x=1693339970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=siLUU7UI21mtrF8XjGqquGwWwBmXNv2duIOgwsdbXFY=;
        b=SdoPRnFR0gPQ8LgLwXG8Vz8W1SUtI2EELMupegEovWpr/qyRWuTmrChqf9C6sIvBMS
         dxrMPLCtre0igZVlBiNbmth9ntQz3u0YfknObQyX5LKhbUgGWpCemqQKJHjI3GrznxdX
         MeQ6H17SrE5T2DFee9tA2qJWW9BXOilCyggFXGQ1uOLB2UJC5qmX3wnNpjaECcBP4xwK
         f6VAVDJ4gDTri0GV+toS1SNCxYAiNhSQ11Zp73bo9ILczJ0tS9b/fbAB3CEDiwGEFfRR
         FDejOAtAUcCR7m0MqPAxqCsUGMMpWQIQs7+y99M/KFwmWcCj83BTw+35dIyaVIaio/t4
         Z66w==
X-Gm-Message-State: AOJu0Yyn4ZGmlh0s+aNI6EW7xJfzBc95+97TS4hR3q2bqixXu/3NW+mJ
        +lxMiozuYzat9m2L0AhISsHR6+lq749DcZFG/JanZbBU
X-Google-Smtp-Source: AGHT+IEF8qO0OLSmYdUOVvoponXXRc10qcPC1HbOP0TCjZjNBEd99A1VYJCP4YaSf4W/njAKoK46oZKO8JXo2fATNeU=
X-Received: by 2002:a17:90a:9e2:b0:26d:1eff:619f with SMTP id
 89-20020a17090a09e200b0026d1eff619fmr9494145pjo.2.1692735170564; Tue, 22 Aug
 2023 13:12:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230816015853.849426-1-liaochang1@huawei.com>
In-Reply-To: <20230816015853.849426-1-liaochang1@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 22 Aug 2023 22:12:39 +0200
Message-ID: <CAJZ5v0jVUjXNZ+03QBXkyjCbDnB7LAOUwKSeVt95LqkeiK33BQ@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Use clamp helper macro to improve the code readability
To:     Liao Chang <liaochang1@huawei.com>
Cc:     rafael@kernel.org, viresh.kumar@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Wed, Aug 16, 2023 at 4:00 AM Liao Chang <liaochang1@huawei.com> wrote:
>
> The valid values of policy.{min, max} should be between 'min' and 'max',
> so use clamp() helper macro to makes cpufreq_verify_within_limits() more
> readable.
>
> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> ---
>  include/linux/cpufreq.h | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
>
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 99da27466b8f..43b363a99215 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -19,6 +19,7 @@
>  #include <linux/pm_qos.h>
>  #include <linux/spinlock.h>
>  #include <linux/sysfs.h>
> +#include <linux/minmax.h>
>
>  /*********************************************************************
>   *                        CPUFREQ INTERFACE                          *
> @@ -467,17 +468,8 @@ static inline void cpufreq_verify_within_limits(struct cpufreq_policy_data *poli
>                                                 unsigned int min,
>                                                 unsigned int max)
>  {
> -       if (policy->min < min)
> -               policy->min = min;
> -       if (policy->max < min)
> -               policy->max = min;
> -       if (policy->min > max)
> -               policy->min = max;
> -       if (policy->max > max)
> -               policy->max = max;
> -       if (policy->min > policy->max)
> -               policy->min = policy->max;
> -       return;
> +       policy->max = clamp(policy->max, min, max);
> +       policy->min = clamp(policy->min, min, policy->max);
>  }
>
>  static inline void
> --

Applied (with minor edits in the subject and changelog) as 6.6 material, thanks!
