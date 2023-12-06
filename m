Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBC58079A2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 21:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjLFUlN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 6 Dec 2023 15:41:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbjLFUlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 15:41:11 -0500
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964B3135;
        Wed,  6 Dec 2023 12:41:17 -0800 (PST)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-1fb00ea5e5fso36422fac.1;
        Wed, 06 Dec 2023 12:41:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701895277; x=1702500077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FlhVPOODXTOWxGwKg9e3DDYoZLed8F9HR5wooT/tC2c=;
        b=QLC4wXqyj/T8ERSCaT7olfK+3lA8UwpoXB7yz0AAwp9s41jtJEIZ0nGNDNqkf9IKaX
         pO3DYMFWoN/hEYFHyxxsxn70XMsvBAewB85IPXIkiGG6HsDQBxyouDKpANkE8mG/e01z
         F9UZoa186LfyntFwwBseS4ZLUyI4Tgl2H8sYOXmY/Icn/dXAtxPfcx6Vpar6/snBLd/9
         EXghDuJcMZUaMRdow4CBWUDhevVBzJ5L7RXdTn/xd0sFhZwxq+PqerIUYOi7RVDcDj6Q
         YBu5M469OzMmEuVSMVjo6G0BTlPOKjKhYNPWPPVP24aB3yhSAYVbkGZDozU53PFSIUar
         qCtA==
X-Gm-Message-State: AOJu0YyC/X50n+EwCgqqu/iNslLDPh4wo3dUVPTCzL8KXtxzKldPFF2Z
        gzcURKA5Dz9s8ldd9QO4yGjlnJ5z/MfxR/SJ5gs=
X-Google-Smtp-Source: AGHT+IH29a0cqz8yIEZIWDtTFVH9l0IVy1IzNJ+5GfLNckU6RPGEogazu+hpKFXH3CqXxC153jfnqv5q+7dvgNmnksA=
X-Received: by 2002:a05:6870:b4a0:b0:1fb:5e42:5096 with SMTP id
 y32-20020a056870b4a000b001fb5e425096mr2586685oap.5.1701895276869; Wed, 06 Dec
 2023 12:41:16 -0800 (PST)
MIME-Version: 1.0
References: <20231127160838.1403404-1-beata.michalska@arm.com> <20231127160838.1403404-3-beata.michalska@arm.com>
In-Reply-To: <20231127160838.1403404-3-beata.michalska@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 6 Dec 2023 21:41:05 +0100
Message-ID: <CAJZ5v0jh3mG3hyFS6war=0bk3PvsVtTwZ1_YwwWov36Bmz7q0w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] cpufreq: Wire-up arch-flavored freq info into cpufreq_verify_current_freq
To:     Beata Michalska <beata.michalska@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, sumitg@nvidia.com, sudeep.holla@arm.covm,
        will@kernel.org, catalin.marinas@arm.com, viresh.kumar@linaro.org,
        rafael@kernel.org, ionela.voinescu@arm.com,
        yang@os.amperecomputing.com, linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 5:09 PM Beata Michalska <beata.michalska@arm.com> wrote:
>
> From: Sumit Gupta <sumitg@nvidia.com>
>
> When available, use arch_freq_get_on_cpu to obtain current frequency
> (usually an average reported over given period of time)
> to better align the cpufreq's view on the current state of affairs.

And why is this a good idea?

Any problem statement?

> This also automatically pulls in the update for cpuinfo_cur_freq sysfs
> attribute, aligning it with the scaling_cur_freq one, and thus providing
> consistent view on relevant platforms.

I have no idea what the above is supposed to mean, sorry.

> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> [BM: Subject & commit msg]
> Signed-off-by: Beata Michalska <beata.michalska@arm.com>
> ---
>  drivers/cpufreq/cpufreq.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 8c4f9c2f9c44..109559438f45 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1756,7 +1756,8 @@ static unsigned int cpufreq_verify_current_freq(struct cpufreq_policy *policy, b
>  {
>         unsigned int new_freq;
>
> -       new_freq = cpufreq_driver->get(policy->cpu);
> +       new_freq = arch_freq_get_on_cpu(policy->cpu);
> +       new_freq = new_freq ?: cpufreq_driver->get(policy->cpu);

Please don't use ?: in general and it is not even useful here AFAICS.

What would be wrong with

new_freq = arch_freq_get_on_cpu(policy->cpu);
if (!new_freq)
        new_freq = cpufreq_driver->get(policy->cpu);

?

>         if (!new_freq)
>                 return 0;
>
> --
