Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1F678CBFC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 20:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237770AbjH2SXW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 29 Aug 2023 14:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237289AbjH2SWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 14:22:51 -0400
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17DF2110;
        Tue, 29 Aug 2023 11:22:49 -0700 (PDT)
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-56e280cc606so920751eaf.1;
        Tue, 29 Aug 2023 11:22:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693333368; x=1693938168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t+xAJt8Azjegio0fu891jbBQQpF7e1QHHRYr0YD3/Bw=;
        b=JYVJluGFvLlLgbCbPavUlK2/j1nNWGEr4D6pijwJDpltXh0DyFpDjAcTiSKAG4GBvM
         UXGiJrk75O8QIOmz8INKTT8rRxrEsQBYwDo8AATSBTbHwEDE3HZmiO9yMc88kJbLc1lW
         +To7/zwpxszZNp/uwh7lIc0fAne+FbGrLGfGzlC920/KRIT2IID1z7T+9/6y0bqbvJWV
         Qp5lxuKwEhuOttyI5wImugUay8YhMa1fNmg9n2cx/1bBxfgfybJOnAgShi52NUex/Bko
         TcIJwOqaoj5cbr8bNySng3Gfw2Hy1cOm2Ayb1BSIOur48J60qZNh3lHEYa6LqDpRvjgq
         0eqg==
X-Gm-Message-State: AOJu0YzD695OGtBDZIA9rQuSKH9QLCHQuMIdbT2oxUetR+mvia0hF7o7
        zWVpVzzAt391GnTnNYe4TsiZOG8kX9IpIW02kbE=
X-Google-Smtp-Source: AGHT+IE1AHvMnrq96ezCb81GBM18IxOU3BuBw/UYdKNlAf/R/zcNtuy2fRbuv8XwET82tesxQNl0WW82FtBCThonxYY=
X-Received: by 2002:a4a:a681:0:b0:573:3a3b:594b with SMTP id
 f1-20020a4aa681000000b005733a3b594bmr14064774oom.1.1693333368395; Tue, 29 Aug
 2023 11:22:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230829070346.1217699-1-liaochang1@huawei.com> <20230829071402.o5prtd3ww42hfffb@vireshk-i7>
In-Reply-To: <20230829071402.o5prtd3ww42hfffb@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 29 Aug 2023 20:22:37 +0200
Message-ID: <CAJZ5v0iEV3s7QbngGv9Agq1VYO2bXUg3-kqdNeyUEN+N1sDV6g@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq: governor: Free dbs_data directly when
 gov->init() fails
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

On Tue, Aug 29, 2023 at 9:14 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 29-08-23, 07:03, Liao Chang wrote:
> > Due to the kobject embedded in the dbs_data doest not has a release()
> > method yet, it needs to use kfree() to free dbs_data directly when
> > governor fails to allocate the tunner field of dbs_data.
> >
> > Signed-off-by: Liao Chang <liaochang1@huawei.com>
> > ---
> >  drivers/cpufreq/cpufreq_governor.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
> > index 85da677c43d6..af44ee6a6430 100644
> > --- a/drivers/cpufreq/cpufreq_governor.c
> > +++ b/drivers/cpufreq/cpufreq_governor.c
> > @@ -439,7 +439,7 @@ int cpufreq_dbs_governor_init(struct cpufreq_policy *policy)
> >
> >       ret = gov->init(dbs_data);
> >       if (ret)
> > -             goto free_policy_dbs_info;
> > +             goto free_dbs_data;
> >
> >       /*
> >        * The sampling interval should not be less than the transition latency
> > @@ -474,6 +474,8 @@ int cpufreq_dbs_governor_init(struct cpufreq_policy *policy)
> >       if (!have_governor_per_policy())
> >               gov->gdbs_data = NULL;
> >       gov->exit(dbs_data);
> > +
> > +free_dbs_data:
> >       kfree(dbs_data);
> >
> >  free_policy_dbs_info:
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied as 6.6-rc material, thanks!
