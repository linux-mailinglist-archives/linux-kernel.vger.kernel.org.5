Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A701C77893C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 10:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234549AbjHKIwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 04:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234546AbjHKIwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 04:52:38 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C11D2712
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 01:52:35 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-268030e1be7so1068427a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 01:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691743954; x=1692348754;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ciuvylFLt40nUwwQMMcqMZdRsHInhkPtm9WId32Gs7Y=;
        b=TK6PtBkIpxvWO81/TUSlD95vGNbfiopHF+BKz5lARN8QZ1HDbdR6tqNhd0CYo7aR06
         MHIkmL70dWeId8avYcfi8/z1YEtYfsp4E3oBSmS0niHgRSeRu/bh6fCWwqBDrq6L6aA/
         VKoZzGC2JU4Iszr2ka4ygA9ve3rNkGjhokSd4ucU4H5S1HYxCVQr960TgCpofjhI+Bcl
         veQMgroCvBequ2JKWXRjCJdFzzPEnO+sCXVOdYTBbcw+ur6ipoGqWwFvV7PV8l6tJjPT
         fI3TPWNBAFy5Y1y+w/WlGlC+Jf6+PySsBndqmkY99Oa3y3hVsz5WK36tawlnqyEisCEk
         z8lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691743954; x=1692348754;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ciuvylFLt40nUwwQMMcqMZdRsHInhkPtm9WId32Gs7Y=;
        b=MnT4okMvKPSif7ON006WPMPXQsV7bwe1swLD43U6eixM9okMlX40I9BR37+tQTAD0X
         5qxi+v3gtJMfAQ800mj9xmIOVkHSptSXoy5aOb4L30qcfv2yKZUY1RFNqymkqw4PcSyN
         QuB17hTbf78AbaA8OR+RhBQsUhdEPVSszG0ZXUj1/2ImBaqHQJoU5kFMxuiPPLcMcWmA
         3Avh3FthokOwRPmUlpk66MoK2qemcbV3Q39NMHHAoUcOXrCAVD3di8d6tsnYbkqRsqyF
         Yjs2FLIQOveFPJIHAsHRJw4lZZL+wT2UFDn8OVXVOi1Rkq/RHDU9Q9PJ97dHEOI1FRbH
         xWXA==
X-Gm-Message-State: AOJu0YzUIcAMFJZmq3jvrqtC38sOaFJwvRuA0TDq9h3Pnr1YWo6ap7KW
        qqJWEz0P6QLWqrxps8tvwuYHHM+dppS0t6FS/jKM3Q==
X-Google-Smtp-Source: AGHT+IH2NeH57ry0ioiuihn3FHaW1i/ldXs7AMUUWUREzQJRivncrEoICVZjJ+LI7c/5UhsdHTu5n+KurTXTC76Py8Q=
X-Received: by 2002:a17:90b:17cb:b0:268:21f0:65e7 with SMTP id
 me11-20020a17090b17cb00b0026821f065e7mr544673pjb.49.1691743954568; Fri, 11
 Aug 2023 01:52:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230811034600.944386-1-anshuman.khandual@arm.com> <20230811034600.944386-3-anshuman.khandual@arm.com>
In-Reply-To: <20230811034600.944386-3-anshuman.khandual@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Fri, 11 Aug 2023 09:52:23 +0100
Message-ID: <CAJ9a7VgNmY0_vPfRfz=+hSjbFqnsOAzBgHtZva9fkG04mRaeaQ@mail.gmail.com>
Subject: Re: [PATCH V3 2/3] coresight: etm: Make cycle count threshold user configurable
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Aug 2023 at 04:46, Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
> Cycle counting is enabled, when requested and supported but with a default
> threshold value ETM_CYC_THRESHOLD_DEFAULT i.e 0x100 getting into TRCCCCTLR,
> representing the minimum interval between cycle count trace packets.
>
> This makes cycle threshold user configurable, from the user space via perf
> event attributes. Although it falls back using ETM_CYC_THRESHOLD_DEFAULT,
> in case no explicit request. As expected it creates a sysfs file as well.
>
> /sys/bus/event_source/devices/cs_etm/format/cc_threshold
>
> New 'cc_threshold' uses 'event->attr.config3' as no more space is available
> in 'event->attr.config1' or 'event->attr.config2'.
>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: James Clark <james.clark@arm.com>
> Cc: Leo Yan <leo.yan@linaro.org>
> Cc: coresight@lists.linaro.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-etm-perf.c   |  2 ++
>  drivers/hwtracing/coresight/coresight-etm4x-core.c | 12 ++++++++++--
>  2 files changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> index 5ca6278baff4..09f75dffae60 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> @@ -68,6 +68,7 @@ PMU_FORMAT_ATTR(preset,               "config:0-3");
>  PMU_FORMAT_ATTR(sinkid,                "config2:0-31");
>  /* config ID - set if a system configuration is selected */
>  PMU_FORMAT_ATTR(configid,      "config2:32-63");
> +PMU_FORMAT_ATTR(cc_threshold,  "config3:0-11");
>
>
>  /*
> @@ -101,6 +102,7 @@ static struct attribute *etm_config_formats_attr[] = {
>         &format_attr_preset.attr,
>         &format_attr_configid.attr,
>         &format_attr_branch_broadcast.attr,
> +       &format_attr_cc_threshold.attr,
>         NULL,
>  };
>
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 1f3d29a639ff..ad28ee044cba 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -644,7 +644,7 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
>         struct etmv4_config *config = &drvdata->config;
>         struct perf_event_attr *attr = &event->attr;
>         unsigned long cfg_hash;
> -       int preset;
> +       int preset, cc_threshold;
>
>         /* Clear configuration from previous run */
>         memset(config, 0, sizeof(struct etmv4_config));
> @@ -667,7 +667,15 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
>         if (attr->config & BIT(ETM_OPT_CYCACC)) {
>                 config->cfg |= TRCCONFIGR_CCI;
>                 /* TRM: Must program this for cycacc to work */
> -               config->ccctlr = ETM_CYC_THRESHOLD_DEFAULT;
> +               cc_threshold = attr->config3 & ETM_CYC_THRESHOLD_MASK;
> +               if (cc_threshold) {
> +                       if (cc_threshold < drvdata->ccitmin)
> +                               config->ccctlr = drvdata->ccitmin;
> +                       else
> +                               config->ccctlr = cc_threshold;
> +               } else {
> +                       config->ccctlr = ETM_CYC_THRESHOLD_DEFAULT;

Don't normally have {} round a single statement else clause - did
checkpatch.pl not object here?


Otherwise

Reviewed-by: Mike Leach <mike.leach@linaro.org>

> +               }
>         }
>         if (attr->config & BIT(ETM_OPT_TS)) {
>                 /*
> --
> 2.25.1
>


-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
