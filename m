Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217377FE183
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 22:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234254AbjK2VGj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 29 Nov 2023 16:06:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjK2VGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 16:06:37 -0500
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EE4D67;
        Wed, 29 Nov 2023 13:06:43 -0800 (PST)
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6d8572850d3so33630a34.0;
        Wed, 29 Nov 2023 13:06:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701292003; x=1701896803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CHRmRPtF9D4nRminD67tB3n7RvHkt7lPmAjYFdqVXkI=;
        b=nFSa5jFKpN/+nD3bKwHE2ACeVyJOEPeYX1+tPM6riYxo67fYiz1k/KYGx96QZEkU/y
         OXx19Mjjp5ox1S7B3nUkSh42+81VCyCgUogaP2dk6eCa6oDR8bwbQctqoI1JqjCypUbs
         Vc4XsYYjXGtm0x6gBg73ndrtge4M8Fg+YT06wiTv+KhNAHPS5Llup+R221o+Gjluw2ha
         uxRzXldP2BU0sO2Fse33lWFkYGXKoQaEUM615908izE5lFoj3HuZQ2xDFBy+3kG5IniD
         1fgAEbcr2JmZlSvoRlUQl438T++JtW1glcvVDWnBOpPcR9d6P78l91ksVIqALpeyu4pO
         TXgg==
X-Gm-Message-State: AOJu0YwLJQJJJ0kRA1jGRtuTtZM9nWaCgyUWPM69lRN2aHISDR8molM3
        RrvNi2gQiChK8Ay5b+A4W8ukJV1NndnXVOZla0vdSWx5
X-Google-Smtp-Source: AGHT+IGwyfMzZjKTdJY4xh9sk9EhES/5kV1h/HBOm7BFnvM4b89jcHmt2KzdaDWF0SY6YavpL8ByJfhMclEBpl+XLHA=
X-Received: by 2002:a4a:d4c4:0:b0:58d:e3d3:ec72 with SMTP id
 r4-20020a4ad4c4000000b0058de3d3ec72mr563003oos.0.1701292002971; Wed, 29 Nov
 2023 13:06:42 -0800 (PST)
MIME-Version: 1.0
References: <20231103094815.16141-1-ayush.jain3@amd.com> <ZUTEnneqNcosb/1R@amd.com>
In-Reply-To: <ZUTEnneqNcosb/1R@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 29 Nov 2023 22:06:31 +0100
Message-ID: <CAJZ5v0jdy+L-2+WH8sOVdM4WrUek5atqUohqj0MJRzwHi2w9Qw@mail.gmail.com>
Subject: Re: [RESEND PATCH] amd-pstate: Only print supported epp values for
 performance governor
To:     Huang Rui <ray.huang@amd.com>, "Jain, Ayush" <ayush.jain3@amd.com>
Cc:     "rafael@kernel.org" <rafael@kernel.org>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        "Karny, Wyes" <Wyes.Karny@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 3, 2023 at 11:00 AM Huang Rui <ray.huang@amd.com> wrote:
>
> On Fri, Nov 03, 2023 at 05:48:15PM +0800, Jain, Ayush wrote:
> > show_energy_performance_available_preferences() to show only supported
> > values which is performance in performance governor policy.
> >
> > -------Before--------
> > $ cat /sys/devices/system/cpu/cpu1/cpufreq/scaling_driver
> > amd-pstate-epp
> > $ cat /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
> > performance
> > $ cat /sys/devices/system/cpu/cpu1/cpufreq/energy_performance_preference
> > performance
> > $ cat /sys/devices/system/cpu/cpu1/cpufreq/energy_performance_available_preferences
> > default performance balance_performance balance_power power
> >
> > -------After--------
> > $ cat /sys/devices/system/cpu/cpu1/cpufreq/scaling_driver
> > amd-pstate-epp
> > $ cat /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
> > performance
> > $ cat /sys/devices/system/cpu/cpu1/cpufreq/energy_performance_preference
> > performance
> > $ cat /sys/devices/system/cpu/cpu1/cpufreq/energy_performance_available_preferences
> > performance
> >
> > Fixes: ffa5096a7c33 ("cpufreq: amd-pstate: implement Pstate EPP support for the AMD processors")
> >
> > Suggested-by: Wyes Karny <wyes.karny@amd.com>
> > Signed-off-by: Ayush Jain <ayush.jain3@amd.com>
> > Reviewed-by: Wyes Karny <wyes.karny@amd.com>
>
> Nice catch, thanks for the fix.
>
> Acked-by: Huang Rui <ray.huang@amd.com>

Applied as 6.7-rc material, thanks!

> >
> > ---
> >  drivers/cpufreq/amd-pstate.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> > index 9a1e194d5cf8..e6c5a57662e4 100644
> > --- a/drivers/cpufreq/amd-pstate.c
> > +++ b/drivers/cpufreq/amd-pstate.c
> > @@ -850,11 +850,16 @@ static ssize_t show_energy_performance_available_preferences(
> >  {
> >       int i = 0;
> >       int offset = 0;
> > +     struct amd_cpudata *cpudata = policy->driver_data;
> > +
> > +     if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
> > +             return sysfs_emit_at(buf, offset, "%s\n",
> > +                             energy_perf_strings[EPP_INDEX_PERFORMANCE]);
> >
> >       while (energy_perf_strings[i] != NULL)
> >               offset += sysfs_emit_at(buf, offset, "%s ", energy_perf_strings[i++]);
> >
> > -     sysfs_emit_at(buf, offset, "\n");
> > +     offset += sysfs_emit_at(buf, offset, "\n");
> >
> >       return offset;
> >  }
> > --
> > 2.34.1
> >
