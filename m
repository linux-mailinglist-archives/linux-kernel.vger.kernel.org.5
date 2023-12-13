Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8665E811068
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 12:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377788AbjLMLp3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 13 Dec 2023 06:45:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233322AbjLMLp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 06:45:28 -0500
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19013CD;
        Wed, 13 Dec 2023 03:45:34 -0800 (PST)
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5909156aea9so773207eaf.0;
        Wed, 13 Dec 2023 03:45:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702467933; x=1703072733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NpqiUE1rCVD9KEKdSK+xznPQhDDJCbxhKfU/ASPm290=;
        b=Dff1DiCQ3TccTQMKkOtwIM5yj7tAv+JUxMniIVyM84IXS9xPlFCpgxwjthPaF2fR7i
         6rFiRpP3b4J0Mw0xNuT8SRVc1IFmfMIDbnqA9q79LufTk3zjkbxX2Hez3OuFJTa7zvy+
         1Vtc23k9wfJgk5mj0RjYWu1TruAIMFiX/9Ewu41oYH7AwndEYo5RUMmUmHqdrfLzt/aC
         hnQ8RcOuawqgzAULKSDPrSCYUNnNOpr9TrOKxvYpceCiNfoExkNHsvDRipWxaYabEseV
         fcEKT3kRnN7D7ZqMNVngBvoOTqEkKcVmw4SyqibiCOb9/hP1KY3H15Y6C/dWa/wofZ+q
         gbfw==
X-Gm-Message-State: AOJu0YzZ6CWxMsKT3JGveFqxFmv3o5RrBzAcB4PSvsbEdM88zVrNW9FH
        SfDCDnVwXp1WT4A8LoyoE24QKEdOR3/Q/OagR7E=
X-Google-Smtp-Source: AGHT+IFUU7BahAFBDXrDSrDmO5l82cs54f9YqvgWEGVACjxillp6Aaml8AIUQCA3FTFOroKyTdGndFJSdPpS/wdRO2c=
X-Received: by 2002:a05:6870:1484:b0:1fa:f0ee:ba9c with SMTP id
 k4-20020a056870148400b001faf0eeba9cmr15010871oab.2.1702467933244; Wed, 13 Dec
 2023 03:45:33 -0800 (PST)
MIME-Version: 1.0
References: <20231129110853.94344-1-lukasz.luba@arm.com> <d920867d-5572-48c3-bd54-b9e989ab6bd5@arm.com>
 <ec8dc77f-364c-443b-a63d-35a2e37d2ccc@arm.com> <0640a9bf-b864-45ef-ab39-14b0e85ff9ad@arm.com>
In-Reply-To: <0640a9bf-b864-45ef-ab39-14b0e85ff9ad@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 13 Dec 2023 12:45:21 +0100
Message-ID: <CAJZ5v0g7u3uQOBeKbinut58GO64NBe=y2Zojn0tow3_KWg_4iQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/23] Introduce runtime modifiable Energy Model
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Lukasz Luba <lukasz.luba@arm.com>, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, linux-pm@vger.kernel.org,
        amit.kachhap@gmail.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, len.brown@intel.com, pavel@ucw.cz,
        mhiramat@kernel.org, qyousef@layalina.io, wvw@google.com,
        linux-kernel@vger.kernel.org, rafael@kernel.org
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

On Wed, Dec 13, 2023 at 12:34 PM Dietmar Eggemann
<dietmar.eggemann@arm.com> wrote:
>
> On 13/12/2023 10:23, Lukasz Luba wrote:
> > Hi Dietmar,
> >
> > Thank you for the review, I will go one-by-one to respond
> > your comments in patches as well. First comments are below.
> >
> > On 12/12/23 18:48, Dietmar Eggemann wrote:
> >> On 29/11/2023 12:08, Lukasz Luba wrote:
>
> [...]
>
> >>> Changelog:
> >>> v5:
> >>> - removed 2 tables design
> >>> - have only one table (runtime_table) used also in thermal (Wei, Rafael)
> >>
> >> Until v4 you had 2 EM's, the static and the modifiable (runtime). Now in
> >> v5 this changed to only have one, the modifiable. IMHO it would be
> >> better to change the existing table to be modifiable rather than staring
> >> with two EM's and then removing the static one. I assume you end up with
> >> way less code changes and the patch-set will become easier to digest for
> >> reviewers.
> >
> > The patches are structured in this way following Daniel's recommendation
> > I got when I was adding similar big changes to EM in 2020 (support all
> > devices in kernel). The approach is as follows:
> > 0. Do some basic clean-up/refactoring if needed for a new feature, to
> >    re-use some code if possible in future
> > 1. Introduce new feature next to the existing one
> > 2. Add API and all needed infrastructure (structures, fields) for
> >    drivers
> > 3. Re-wire the existing drivers/frameworks to the new feature via new
> >    API; ideally keep 1 patch per driver so the maintainer can easily
> >    grasp the changes and ACK it, because it will go via different tree
> >    (Rafael's tree); in case of some code clash in the driver's code
> >    during merge - it will be a single driver so easier to handle
> > 4. when all drivers and frameworks are wired up with the new feature
> >    remove the old feature (structures, fields, APIs, etc)
> > 5. Update the documentation with new latest state of desing
> >
> > In this approach the patches are less convoluted. Because if I remove
> > the old feature and add new in a single patch (e.g. the main structure)
> > that patch will have to modify all drivers to still compile. It
> > would be a big messy patch for this re-design.
> >
> > I can see in some later comment from Rafael that he is OK with current
> > patch set structure.
>
> OK, in case Rafael and Daniel prefer this, then it's fine.
>
> I just find it weird that we now have
>
> 70 struct em_perf_domain {
> 71         struct em_perf_table __rcu *runtime_table;
>                                        ^^^^^^^^^^^^^
>
> as the only EM table.

I agree that it would be better to call it something like em_table.
