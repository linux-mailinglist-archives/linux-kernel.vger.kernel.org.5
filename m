Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFEB278CBEB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 20:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235145AbjH2STH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 29 Aug 2023 14:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234416AbjH2SSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 14:18:37 -0400
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D083910E;
        Tue, 29 Aug 2023 11:18:34 -0700 (PDT)
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-57328758a72so1115580eaf.1;
        Tue, 29 Aug 2023 11:18:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693333114; x=1693937914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+7fcb3E58Om8i3dJ1EB/0lExawi74wQ7tMQjyd1wRZ0=;
        b=HO/bMsZ2gMKoDh1WDzJcxl4+VBmqQRrwjNBEiOBUxeD7uAXWmql50znE1G8o0YYZnE
         fvfLDtRY9dqcLfd8NBSZUdP+vec6vibT7Ljq76C8q+kn/ukp2sRvZoA+fR7BKIpDx497
         zWGR6wpKK3yn551slR3DtKSOHIx5BQTXs8E3TPnvvwfqIfPgnVsGf2imIASl5WOFZ2Hp
         U6Ii+Rs1ZOv1Wm01q3rl/bV1egLl27AdJq+qKl5KP/XWdfDRYwGv3E6XnJkr4PHBQz4p
         P6bvl1d0OYZTbLNmTXYUuLF6QxJoYHep/+RAhFTuOUUdMYuuHNDFzLyvhBmKP6rq9+TB
         +k8w==
X-Gm-Message-State: AOJu0Yxdl34VT9yaT3UqHU5lQoKpaBXDPpg5ESVvZpOSV4oaJXPmVNcn
        CZR8Wm/7i0b7V5e9DfnNlw873uDMTJ7+ORqj6+Y1ASeR
X-Google-Smtp-Source: AGHT+IEHdc/VssiiGL1sdc37M6ppkXr34y9BXYbRRmN6UD0MyAmIS/f7Yp1j2+41sS4SeHy0Urvw7sBLDAck2HbmKpI=
X-Received: by 2002:a4a:c3cb:0:b0:573:2a32:6567 with SMTP id
 e11-20020a4ac3cb000000b005732a326567mr14907382ooq.0.1693333114099; Tue, 29
 Aug 2023 11:18:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230829070150.1217624-1-liaochang1@huawei.com> <20230829071338.6y5ng2g34vdiigve@vireshk-i7>
In-Reply-To: <20230829071338.6y5ng2g34vdiigve@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 29 Aug 2023 20:18:23 +0200
Message-ID: <CAJZ5v0hh1jDnX-TowNCSNBT+LCcYcXa7e1E=LPPqktxJhgCTHg@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq: Avoid printing kernel addresses in cpufreq_resume()
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Liao Chang <liaochang1@huawei.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Tue, Aug 29, 2023 at 9:13 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 29-08-23, 07:01, Liao Chang wrote:
> > The pointer value of policy and driver structure are currently printed
> > in the error messages of cpufreq_resume(), this is not recommended and
> > helpful. In order to be consistent with the error message in
> > cpufreq_suspend() and easier to understand, print the name of driver
> > strcture and the manage CPU of policy structure individually in the
> > error messages of cpufreq_resume().
> >
> > Link: https://lore.kernel.org/all/b7be717c-41d8-bbbf-3e97-3799948ab757@huawei.com
> > Signed-off-by: Liao Chang <liaochang1@huawei.com>
> > ---
> >  drivers/cpufreq/cpufreq.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 50bbc969ffe5..26fa99d46684 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -1943,16 +1943,16 @@ void cpufreq_resume(void)
> >
> >       for_each_active_policy(policy) {
> >               if (cpufreq_driver->resume && cpufreq_driver->resume(policy)) {
> > -                     pr_err("%s: Failed to resume driver: %p\n", __func__,
> > -                             policy);
> > +                     pr_err("%s: Failed to resume driver: %s\n", __func__,
> > +                             cpufreq_driver->name);
> >               } else if (has_target()) {
> >                       down_write(&policy->rwsem);
> >                       ret = cpufreq_start_governor(policy);
> >                       up_write(&policy->rwsem);
> >
> >                       if (ret)
> > -                             pr_err("%s: Failed to start governor for policy: %p\n",
> > -                                    __func__, policy);
> > +                             pr_err("%s: Failed to start governor for CPU%u's policy\n",
> > +                                    __func__, policy->cpu);
> >               }
> >       }
> >  }
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied as 6.6-rc material, thanks!
