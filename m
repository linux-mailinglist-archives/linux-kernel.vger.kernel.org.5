Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9BAE773FEC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbjHHQ4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233721AbjHHQzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:55:48 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF311A2AD
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:59:28 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-586a3159588so66103027b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 08:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691510362; x=1692115162;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jUmsLzGlT/3ajSSxcA4F7f9F7ELiIgL969vcB3E0/EU=;
        b=AzGcjYja4I1n4ffbumo+Y1WLiKPRPMfEeIv+ZkgEJij2oCnFMOgxM8k5NzeLFdaig6
         VAZHvkvSbxdZ28syFhkjcB+3LWYckpIE9r/U02ozIAiAv1n1deXrOf/OVxb3vdKp/RdM
         m5iKpwBd3mam8rGY6P7oUlS2alobzKAErOiMvyU4H3twopazsLMCLRb3/VEqlIwhJr5Y
         jj5nMut2e+uYzHmAFpvSE54vpe+NE0spabXjG2I8du/q0ToH9WaAqqpLxOEqgM+bYU6X
         BnJaU7We9Jd80QQkT286EhAZeraaDXoQBxQhqh+IDY/5R7MjmcrQGssC9Rj54s7TZ+cP
         bLLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691510362; x=1692115162;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jUmsLzGlT/3ajSSxcA4F7f9F7ELiIgL969vcB3E0/EU=;
        b=LTusi4rGlbqG0Hn2TdVt61FIW7K9a6efnc+q2RVd7uzTy+1+2zDpawYD1OYmfvfaY2
         9YdsaHxdxeiMNlh6W3M05b0NBCdO8Hu5ab3ifH1FgfHLxpBmXbuNd2hwSnhQ3B8HR6na
         uWs4t6LdN/8/XskTNUhlB5AMK/HIaxRbVhZ4+ITX+ltT04IfFguu4KSr16lW2FrKta2u
         zLuL3D8EkW/c/FeE1tmE59axtSutph/hxVshsIF04J7xomFAqci1ysKHvIS6Cy0ic8Hz
         No6Ts8Wayer/l/DFbc7b7+zNwUjP+kvxXkEo5bltExtMIgsGJ1Vb4b53nK25VGkaF2a8
         UYtw==
X-Gm-Message-State: AOJu0Ywt7QJSnFkJvs52Uk2tUrVgt3/8sR5r3sC/tBYjjw7UKcbaNvGD
        ObDQ++NsviOMkX7diKOEzIfqzeAvYa6GtE3oq6wgV6BnO/Z9at5KpbM=
X-Google-Smtp-Source: AGHT+IFdh3n0Z+Nb2sYnL4rKbZf1o/9zxM/XYPxxA8QKFr+qWALfdNbRf73dZ8pKAo+LLZDyLigVO5A5FbAEFvDYU34=
X-Received: by 2002:a17:90a:940e:b0:268:266a:1ab with SMTP id
 r14-20020a17090a940e00b00268266a01abmr11695191pjo.5.1691489964555; Tue, 08
 Aug 2023 03:19:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230808074533.380537-1-anshuman.khandual@arm.com>
In-Reply-To: <20230808074533.380537-1-anshuman.khandual@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Tue, 8 Aug 2023 11:19:13 +0100
Message-ID: <CAJ9a7Vgs6nP+KEPhjuj4BtWRZrRt-byz1xsa-JRzk3cFGJ+d8w@mail.gmail.com>
Subject: Re: [PATCH] coresight: etm: Make cycle count threshold user configurable
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, Al.Grant@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman

On Tue, 8 Aug 2023 at 08:45, Anshuman Khandual
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
> Changes in V2:
>

Please ensure that the e-mail title reflects the "v2" nature of this.
e.g. [PATCH v2] ....


> - s/treshhold/threshhold
>
> Changes in V1:
>
> https://lore.kernel.org/all/20230804044720.1478900-1-anshuman.khandual@arm.com/
>
>  Documentation/trace/coresight/coresight.rst        |  2 ++
>  drivers/hwtracing/coresight/coresight-etm-perf.c   |  2 ++
>  drivers/hwtracing/coresight/coresight-etm4x-core.c | 12 ++++++++++--
>  3 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/trace/coresight/coresight.rst b/Documentation/trace/coresight/coresight.rst
> index 4a71ea6cb390..a698b07206b5 100644
> --- a/Documentation/trace/coresight/coresight.rst
> +++ b/Documentation/trace/coresight/coresight.rst
> @@ -624,6 +624,8 @@ They are also listed in the folder /sys/bus/event_source/devices/cs_etm/format/
>     * - timestamp
>       - Session local version of the system wide setting: :ref:`ETMv4_MODE_TIMESTAMP
>         <coresight-timestamp>`
> +   * - cc_threshold
> +     - Cycle count threshold value
>
>  How to use the STM module
>  -------------------------

The doc elements here need to be in a separate patch in the set and
additionally sent to doc list and maintainer
(linux-doc@vger.kernel.org and corbet@lwn.net) to be picked up.

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
> index 9d186af81ea0..a353c0784bab 100644
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
> +               }
>         }
>         if (attr->config & BIT(ETM_OPT_TS)) {
>                 /*
> --
> 2.25.1
>

As we are using ccitmin - which I think we must - then we need an
additional patch in the set that implements the errata workaround
mentioned by Al, when setting ccitmin in etm4_init_arch_data().
Perhaps a helper function called from there to read the ID reg unless
one of the errata cores in which case set to 0x4.

Regards

Mike


-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
