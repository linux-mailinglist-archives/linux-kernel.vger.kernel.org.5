Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD53B7BBFE7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 21:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233312AbjJFT4d convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 6 Oct 2023 15:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbjJFT4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 15:56:32 -0400
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D9883;
        Fri,  6 Oct 2023 12:56:31 -0700 (PDT)
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-57f137dffa5so83709eaf.1;
        Fri, 06 Oct 2023 12:56:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696622191; x=1697226991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zuH3Tw4fen4D1M93ft5MZsxFUkMeRUk3S1NbLm3ZB30=;
        b=ED68XWTaCX5gqVa49jZ9yPpFLk7SBfxHBjIwCP8w9Lu7bt6+MQrkvFUnXq/nLPCEtN
         EhJj+DVx8h6lJrAdgJ8CT04vgQt0J9zlecb9fXiSc0586ckQ+HOTQazsnvwm9lPH6bpP
         4lh+ns4+IMAKkC7+wAlNSLzQMjtvXpzyVNDTgxn8YTS8pS/y8TEGFe3Hu3mZ+NUg6Rm/
         DasMjlOoiJn2WnyAuP06Uhtrik6RIQd+noO6uyY/+K43aUNNmMqQ166PoSZFsCj/n7nt
         YX9M9CmXaIDeEAtM7Hs0scUVtaOQZoFIdFbuQjYTy+8KLdrZjGZ/8hy1eblpwLxDfBYz
         aWoQ==
X-Gm-Message-State: AOJu0YyFfed+w1f9qEttTL7UOg5fxC5wTnAt1YSKf2sDYuPeC5Iy5Oby
        0iMd1pwK/9WUXIeLllGkVJzEHqnfCBH4lhdeEDk=
X-Google-Smtp-Source: AGHT+IEmYteY5fm/L4VaFUHXBOcUx8zIZutONFiLHdyxLmUmn8CsGEIGTvoHRL7YlgNe1aQrroaQ2ZGCM1oVRTNbFHI=
X-Received: by 2002:a4a:de08:0:b0:56e:94ed:c098 with SMTP id
 y8-20020a4ade08000000b0056e94edc098mr8890564oot.0.1696622190997; Fri, 06 Oct
 2023 12:56:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230912060942.2516761-1-liaochang1@huawei.com> <20231005105900.uctt4jna4wovt5g6@vireshk-i7>
In-Reply-To: <20231005105900.uctt4jna4wovt5g6@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 6 Oct 2023 21:56:20 +0200
Message-ID: <CAJZ5v0jP0m2WT5LGtFSyMXhcotoKfptB206vHrr63BAeqyxdug@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: conservative: Simplify the condition of storing 'down_threshold'
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Liao Chang <liaochang1@huawei.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 5, 2023 at 12:59 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 12-09-23, 06:09, Liao Chang wrote:
> > The governor currently checks if the input new down_threshold is less
> > than 100 before storing it. However, the up_threshold field of dbs_data
> > structure is also limited to be less than 100, so this check is
> > unnecessary and remove it.
> >
> > Signed-off-by: Liao Chang <liaochang1@huawei.com>
> > ---
> >  drivers/cpufreq/cpufreq_conservative.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
> > index b6bd0ff35323..56500b25d77c 100644
> > --- a/drivers/cpufreq/cpufreq_conservative.c
> > +++ b/drivers/cpufreq/cpufreq_conservative.c
> > @@ -187,8 +187,7 @@ static ssize_t down_threshold_store(struct gov_attr_set *attr_set,
> >       ret = sscanf(buf, "%u", &input);
> >
> >       /* cannot be lower than 1 otherwise freq will not fall */
> > -     if (ret != 1 || input < 1 || input > 100 ||
> > -                     input >= dbs_data->up_threshold)
> > +     if (ret != 1 || input < 1 || input >= dbs_data->up_threshold)
> >               return -EINVAL;
> >
> >       cs_tuners->down_threshold = input;
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied as 6.7 material, thanks!
