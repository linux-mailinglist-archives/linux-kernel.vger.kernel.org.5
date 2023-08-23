Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDDBA786109
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 21:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238400AbjHWTxD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 23 Aug 2023 15:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238428AbjHWTxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 15:53:00 -0400
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81005CC7;
        Wed, 23 Aug 2023 12:52:55 -0700 (PDT)
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-570e8bee8b5so476318eaf.1;
        Wed, 23 Aug 2023 12:52:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692820374; x=1693425174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JSk/7E/rTmVy54qULMkQ8kbJLW+iQiD+8RRV7vO8Hd0=;
        b=iUVYKciCScl42d8TiIoBjGN0jLtPTKvK3BgZDeJ2cl6EakxYw3wwgx4im5rEb/4+7B
         8Q0Np0tgsW8vsVqs8JkX6wWaFhsB0/n+1rmgqvq6ZDPWKz3ErBTSaXLAq9iYk/jUKbut
         g1COhwNJVDj4CN3gWCyANNbJyW4kKO1ySy6bQmKaDnq/EbE0mZf0i9+ZLSFVW3St/Rgl
         YxhIGGsNVnNLAkdsQmFcqzb1rNKyoro339F47vypp2XtK/ALPFjoRuFuHgl6ykrkiVHx
         dyYnk6zo5FHRLXAK79D5DshcVnjTB2a2Pp+usPO4PaqMTdUnD1twTUI1YxgNLm+qaF8t
         rYOQ==
X-Gm-Message-State: AOJu0YxPOO2uvKTWGBPTQ6uW/mWksQwZ7kgj0mJUflmgMP06EPEUUtSU
        Q0DS5Qs6sDoZNb1MjIYzftffY//V2ofNyXOeBXk=
X-Google-Smtp-Source: AGHT+IFYRx/+X/l6djNLFTilRf2ceV7n65aIs/YjVG5EJI8tCJm+x70uVhFe4BcriKvwPz1wuIDjQl6E6yFzt/cj2LQ=
X-Received: by 2002:a4a:bc85:0:b0:560:b01a:653d with SMTP id
 m5-20020a4abc85000000b00560b01a653dmr13102153oop.0.1692820374698; Wed, 23 Aug
 2023 12:52:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230822124837.3016641-1-zhanjie9@hisilicon.com>
In-Reply-To: <20230822124837.3016641-1-zhanjie9@hisilicon.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 23 Aug 2023 21:52:43 +0200
Message-ID: <CAJZ5v0gNZ_Uw4fLH00tzPtvY3GWu2qBAvQ=y2Bjwreqa=3kuuQ@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq: Support per-policy performance boost
To:     Jie Zhan <zhanjie9@hisilicon.com>, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, xuwei5@huawei.com, wanghuiqiang@huawei.com,
        jonathan.cameron@huawei.com, wangxiongfeng2@huawei.com
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

On Tue, Aug 22, 2023 at 2:51 PM Jie Zhan <zhanjie9@hisilicon.com> wrote:
>
> The boost control currently applies to the whole system.  However, users
> may prefer to boost a subset of cores in order to provide prioritized
> performance to workloads running on the boosted cores.
>
> Enable per-policy boost by adding a 'boost' sysfs interface under each
> policy path.  This can be found at:
>
>         /sys/devices/system/cpu/cpufreq/policy<*>/boost
>
> Same to the global boost switch, writing 1/0 to the per-policy 'boost'
> enables/disables boost on a cpufreq policy respectively.
>
> The user view of global and per-policy boost controls should be:
>
> 1. Enabling global boost initially enables boost on all policies, and
> per-policy boost can then be enabled or disabled individually, given that
> the platform does support so.
>
> 2. Disabling global boost makes the per-policy boost interface illegal.
>
> Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
> Reviewed-by: Wei Xu <xuwei5@hisilicon.com>

Viresh, you had comments on the previous version of this.  Does it
look better now?

> ---
> A possible question could be: why not just limiting 'scaling_max_freq'?
> Well, the fundamental difference is that per-policy boost could be more
> user-friendly.  When global boost is enabled, it is not straightforward
> to figure out the base frequency for setting 'scaling_max_freq' to a
> non-boost value. Also, this is supposed to take effect on the physical
> upper frequency limit, reflected through 'cpuinfo_max_freq'.
>
> v1->v2:
> - Rename the interface from 'local_boost' to 'boost'.
> - Illegalize writing 0 to per-policy even if global boost is off.
> - Show the per-policy 'boost' file only when ->set_boost() is available.
>
> v1: https://lore.kernel.org/linux-pm/20230724075827.4160512-1-zhanjie9@hisilicon.com/
>
>  drivers/cpufreq/cpufreq.c | 43 +++++++++++++++++++++++++++++++++++++++
>  include/linux/cpufreq.h   |  3 +++
>  2 files changed, 46 insertions(+)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 50bbc969ffe5..81e21fa070e1 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -86,6 +86,7 @@ static void cpufreq_governor_limits(struct cpufreq_policy *policy);
>  static int cpufreq_set_policy(struct cpufreq_policy *policy,
>                               struct cpufreq_governor *new_gov,
>                               unsigned int new_pol);
> +static bool cpufreq_boost_supported(void);
>
>  /*
>   * Two notifier lists: the "policy" list is involved in the
> @@ -621,6 +622,40 @@ static ssize_t store_boost(struct kobject *kobj, struct kobj_attribute *attr,
>  }
>  define_one_global_rw(boost);
>
> +static ssize_t show_local_boost(struct cpufreq_policy *policy, char *buf)
> +{
> +       return sysfs_emit(buf, "%d\n", policy->boost_enabled);
> +}
> +
> +static ssize_t store_local_boost(struct cpufreq_policy *policy,
> +                                const char *buf, size_t count)
> +{
> +       int ret, enable;
> +
> +       ret = kstrtoint(buf, 10, &enable);
> +       if (ret || enable < 0 || enable > 1)
> +               return -EINVAL;
> +
> +       if (!cpufreq_driver->boost_enabled)
> +               return -EINVAL;
> +
> +       if (policy->boost_enabled == enable)
> +               return count;
> +
> +       cpus_read_lock();
> +       ret = cpufreq_driver->set_boost(policy, enable);
> +       cpus_read_unlock();
> +
> +       if (ret)
> +               return ret;
> +
> +       policy->boost_enabled = enable;
> +
> +       return count;
> +}
> +
> +static struct freq_attr local_boost = __ATTR(boost, 0644, show_local_boost, store_local_boost);
> +
>  static struct cpufreq_governor *find_governor(const char *str_governor)
>  {
>         struct cpufreq_governor *t;
> @@ -1055,6 +1090,12 @@ static int cpufreq_add_dev_interface(struct cpufreq_policy *policy)
>                         return ret;
>         }
>
> +       if (cpufreq_boost_supported()) {
> +               ret = sysfs_create_file(&policy->kobj, &local_boost.attr);
> +               if (ret)
> +                       return ret;
> +       }
> +
>         return 0;
>  }
>
> @@ -2716,6 +2757,8 @@ int cpufreq_boost_trigger_state(int state)
>                 ret = cpufreq_driver->set_boost(policy, state);
>                 if (ret)
>                         goto err_reset_state;
> +
> +               policy->boost_enabled = state;
>         }
>         cpus_read_unlock();
>
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 172ff51c1b2a..fa02f2fa88c4 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -140,6 +140,9 @@ struct cpufreq_policy {
>          */
>         bool                    dvfs_possible_from_any_cpu;
>
> +       /* Per policy boost enabled flag. */
> +       bool                    boost_enabled;
> +
>          /* Cached frequency lookup from cpufreq_driver_resolve_freq. */
>         unsigned int cached_target_freq;
>         unsigned int cached_resolved_idx;
> --
> 2.30.0
>
