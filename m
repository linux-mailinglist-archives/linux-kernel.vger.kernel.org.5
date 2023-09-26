Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB7D67AF15D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 18:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235426AbjIZQzD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 26 Sep 2023 12:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235382AbjIZQzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 12:55:02 -0400
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72889139;
        Tue, 26 Sep 2023 09:54:55 -0700 (PDT)
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6c0ab18e084so1237985a34.1;
        Tue, 26 Sep 2023 09:54:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695747294; x=1696352094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jflAhsbcPuF32WJ8I8+1JTlxMGuvqUT2OezR2dcitbM=;
        b=HCH/YHlnm1MwL1OoX8+DBDzV8IiWuj211MumTShkABjjgwWxPezVFNSJQ3DRpjNTLh
         EBIjfYouyE9AR6sDtOI/LCAMhqvlfuCO0pHayBN3acX1i9S3bBBb+PTglPjApJmgNU8p
         ruC1MquDcgLVoTqSNXlb6NGSc1WgAMXi6yGNlNe7JGpZwvx/SZlxkYvh3yQtOpJdBFih
         QdmpDNgYERJiKiV4EZ6/M8YvO11hdp7vh9IOTscJSGgSfleciXZgm1XaluHiCA2k1Yty
         stWjhHi5gy3p58lIk+/V9tZYCz/eJS+nDwWMMwYwwcOIywdtkVWVApeLKYykM+Hp2+Cs
         HUJA==
X-Gm-Message-State: AOJu0YwY7p5yBhD5o6msVjaQEeOHBzA9uj6cB4T6yU4w8YnkcYyK4RMQ
        FaasGnBRjo0ytRtNZUe8tJ5zlWJn+hIzO0LuLX0=
X-Google-Smtp-Source: AGHT+IG+WlNQV2IMQ3g41eoAm8JgyJmX+HeGzZkadWbnCY8b9Zl5DWEsspn63OElbVrLAYwHzSbNpZTt5y4gIV/o7vY=
X-Received: by 2002:a4a:e8c4:0:b0:57b:73f6:6f80 with SMTP id
 h4-20020a4ae8c4000000b0057b73f66f80mr9302789ooe.0.1695747294604; Tue, 26 Sep
 2023 09:54:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230925131715.138411-1-ulf.hansson@linaro.org>
In-Reply-To: <20230925131715.138411-1-ulf.hansson@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 26 Sep 2023 18:54:43 +0200
Message-ID: <CAJZ5v0gTQ1mtb68GCieKOofuqQZg55mjikPwTbVm533cnB61qQ@mail.gmail.com>
Subject: Re: [PATCH 0/9] PM: domains/opp/arm_scmi: Extend performance scaling support
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <vireshk@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
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

On Mon, Sep 25, 2023 at 3:17 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> Consumer drivers for devices that are attached to the SCMI performance domain,
> are currently not able to use the OPP library to scale performance. This series
> is enabling the support for this.
>
> The OPPs for SCMI performance domain are encoded in the FW, rather than being
> described through DT. To better support this, some changes have also been done
> to the OPP library and for PM domains in general. More details are available in
> the commit messages.
>
> I have based the series on the scmi tree and the for-next/scmi/updates branch,
> so the OPP and PM domain changes would require acks from Viresh and Rafael to
> be allow to be picked up and funneled through the scmi tree. Or, let's just
> discuss what works best for us in this regards.
>
> Note that, I am running this on the Qemu virt platform with Optee running an
> SCMI server. If you want some more details about my test setup, I can certainly
> share this with you, just let me know.
>
> Looking forward to your feedback!
>
> Kind regards
> Ulf Hansson
>
>
> Ulf Hansson (9):
>   PM: domains: Introduce dev_pm_domain_set_performance_state()
>   PM: domains: Implement the ->set_performance_state() callback for
>     genpd

I have no strong opinion regarding the two patches above, so if you
need ACKs from me on them, please feel free to add them.

>   OPP: Add dev_pm_opp_add_dynamic() to allow more flexibility
>   OPP: Extend dev_pm_opp_data with a level
>   OPP: Switch to use dev_pm_domain_set_performance_state()
>   OPP: Extend support for the opp-level beyond required-opps
>   firmware: arm_scmi: Simplify error path in scmi_dvfs_device_opps_add()
>   firmware: arm_scmi: Specify the performance level when adding an OPP
>   firmware: arm_scmi: Add generic OPP support to the SCMI performance
>     domain
>
>  drivers/base/power/common.c             | 21 ++++++++++
>  drivers/base/power/domain.c             | 33 +++++++++------
>  drivers/firmware/arm_scmi/perf.c        | 22 +++++-----
>  drivers/opp/core.c                      | 54 +++++++++++++++++++------
>  drivers/opp/of.c                        | 10 +++--
>  drivers/opp/opp.h                       |  2 +-
>  drivers/pmdomain/arm/scmi_perf_domain.c | 34 ++++++++++++++++
>  include/linux/pm.h                      |  2 +
>  include/linux/pm_domain.h               |  6 +++
>  include/linux/pm_opp.h                  | 31 ++++++++++++--
>  10 files changed, 168 insertions(+), 47 deletions(-)
>
> --
