Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9717D61DF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 08:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbjJYGzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 02:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjJYGzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 02:55:04 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25288E5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 23:55:02 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6bee11456baso4394335b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 23:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698216901; x=1698821701; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y5dui3OIhxBVatDTTZ5Hf8HfCYDRD2Zxo6QlZVP8Vrc=;
        b=yEoBY53H3+Qmi34C06XUKBnG3Ce6w3dfnKGolkF35zhFPnbtaszryWtfJFO7qHPwvT
         irOjyc98eskUXHpoCoNm2ot/8va0oeRdr0gP4mqkb/FTdL2BjfepjQ9RDp8Sz9Tqh7X+
         l33eGhFTNlfA8YGxwRsn2FKySpRgTKIqfyAUarY8qUBg4B0AtvOgS7kvWV8VBP6an5iW
         rqGKpz9+ZvSyDxagdodptuTwhzwO2/Y1wz6kO0m60vqqgVElP2vlZWEmpPO8lp9yBOj3
         I2zpBXr013xzha6XimQrN+WNLnH1y4iQvccevdaLHJE2/UCTDFX1YnVPtL+AIaCoIpPs
         drbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698216901; x=1698821701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y5dui3OIhxBVatDTTZ5Hf8HfCYDRD2Zxo6QlZVP8Vrc=;
        b=UqOPrlFBGUCUNRJVEqpKqTPGJPfg4RBwpxe56YTrG5Lr156HjUwMkhjXki8O0fKYko
         hk1AEY7NRjbhmQ+Prs5Mw8egblOHeMpZLZG3bOtMvq2yyxX08XkAJ75gz/r//kGrxyA1
         LN0jiFJ1DgJhIzlGSa3wypATaGijDjnER0bNLF4uoG1+y6MsZJL6v5q47RT1IuCBr+IY
         Mbu6Mc2t60z3er27cPOain4u2YbVPkPfcE9zy8dzWnkpWDtw2HhlRkuebX0/RNX9INcX
         ypoSJfXTT64Yxx8eCPKU6zBoj4UJPhZPHZy6u5LQX0epd/Xn3nh25Jtb0dTSDYgnULix
         4cqw==
X-Gm-Message-State: AOJu0Yx37Zr8QEEEjgkqYVIHn9xK5TOLR5MllwBTE7TnjECnsTWJsRWy
        xNOJCGobnOQy+uilreNMIyXkUQ==
X-Google-Smtp-Source: AGHT+IGiBGcFTbqUF8uqCvsX/8xoVFFIwZb+WJMflR1Tq9mvTNDjmFTBuZ/uNMHY47fdPzOHlkBrgA==
X-Received: by 2002:a05:6a00:1389:b0:68f:d35d:217e with SMTP id t9-20020a056a00138900b0068fd35d217emr13140695pfg.2.1698216901494;
        Tue, 24 Oct 2023 23:55:01 -0700 (PDT)
Received: from localhost ([122.172.80.14])
        by smtp.gmail.com with ESMTPSA id o67-20020a634146000000b005742092c211sm8119201pga.64.2023.10.24.23.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 23:55:00 -0700 (PDT)
Date:   Wed, 25 Oct 2023 12:24:58 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] OPP: Use _set_opp_level() for single genpd case
Message-ID: <20231025065458.z3klmhahrcqh6qyw@vireshk-i7>
References: <cover.1697710527.git.viresh.kumar@linaro.org>
 <f709e9e273004be43efe3a2854a7e7b51a777f99.1697710527.git.viresh.kumar@linaro.org>
 <CAPDyKFqbnsdT0nqKwQhai875CwwpW_vepr816fL+i8yLh=YQhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFqbnsdT0nqKwQhai875CwwpW_vepr816fL+i8yLh=YQhw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-10-23, 13:16, Ulf Hansson wrote:
> On Thu, 19 Oct 2023 at 12:22, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > +static int _link_required_opps(struct dev_pm_opp *opp, struct opp_table *opp_table,
> >                                struct opp_table *required_table, int index)
> >  {
> >         struct device_node *np;
> > @@ -314,6 +314,25 @@ static int _link_required_opps(struct dev_pm_opp *opp,
> >                 return -ENODEV;
> >         }
> >
> > +       /*
> > +        * There are two genpd (as required-opp) cases that we need to handle,
> > +        * devices with a single genpd and ones with multiple genpds.
> > +        *
> > +        * The single genpd case requires special handling as we need to use the
> > +        * same `dev` structure (instead of a virtual one provided by genpd
> > +        * core) for setting the performance state. Lets treat this as a case
> > +        * where the OPP's level is directly available without required genpd
> > +        * link in the DT.
> > +        *
> > +        * Just update the `level` with the right value, which
> > +        * dev_pm_opp_set_opp() will take care of in the normal path itself.
> > +        */
> > +       if (required_table->is_genpd && opp_table->required_opp_count == 1 &&
> > +           !opp_table->genpd_virt_devs) {
> > +               if (!WARN_ON(opp->level))
> 
> Hmm. Doesn't this introduce an unnecessary limitation?
> 
> An opp node that has a required-opps phande, may have "opp-hz",
> "opp-microvolt", etc. Why would we not allow the "opp-level" to be
> used too?

Coming back to this, why would we ever want a device to have "opp-level" and
"required-opp" (set to genpd's table) ? That would mean we will call:

dev_pm_domain_set_performance_state() twice to set different level values.

And so it should be safe to force that if required-opp table is set to a genpd,
then opp-level shouldn't be set. Maybe we should fail in that case, which isn't
happening currently.

-- 
viresh
