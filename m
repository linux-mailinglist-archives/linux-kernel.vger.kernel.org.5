Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D32607FC1C4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346728AbjK1PRM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 28 Nov 2023 10:17:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346712AbjK1PRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 10:17:10 -0500
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4ED10D2;
        Tue, 28 Nov 2023 07:17:16 -0800 (PST)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1d542f05b9aso848519fac.1;
        Tue, 28 Nov 2023 07:17:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701184635; x=1701789435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iEkj8M4mMYU4cH7Z21tsJI4k0QP7SojOHiRyJb1hJ0I=;
        b=GH3I69rfOjvaEPmWQZ+42r0t2fjX1WkF6cVT+4W+jOJ3ya57Tzat2uBcxtkbSJARJh
         98Z3rfBhxV3LLEJyMlmCBni7ihaeTtK/BAi8Xaug3gd6s3OqCl9za8pb1w0zoKJlh9+g
         NpXcx75FBH4JkdiQZSdcMpkGzOdUr7Up6b81bBjAjwV/XMycv+Ke76aGlSCOJg6ZbOMG
         6hqTNYGwiRMNc1ln629QTBw/pImUTJsQ4JKN31FV9Ta7VKvMktp+rFSThygWeN8Kym+K
         l9ppGVUF0s3dLzOq1dPwZtsJooLUrPTPF5A3yvfYrq2zVs5Uaddr8gnG2daMnqBDSSS2
         p7Ug==
X-Gm-Message-State: AOJu0YzZ1hwest/yAQ4e6fOQ+mzadJ3Jcb5R0u4+P1onzwedgYpVNj/z
        5uyvQhL8ErbUj4yA8IkmewvQyxcA8Xg3/LbU+SYi8tNj
X-Google-Smtp-Source: AGHT+IGO6lVuufssgJxlHErLx8cNfkoXVgmPyzhZzoNhZHiM1fyrnI3WgBFl895DPfO4iwj+fOtLradnhm1C0E/x8Q0=
X-Received: by 2002:a05:6871:e710:b0:1fa:3480:bf2c with SMTP id
 qa16-20020a056871e71000b001fa3480bf2cmr13343158oac.0.1701184635409; Tue, 28
 Nov 2023 07:17:15 -0800 (PST)
MIME-Version: 1.0
References: <20231025192225.468228-1-lukasz.luba@arm.com> <CAJZ5v0gniBtFduwjhDku+OZzjvkCaFK7ew0uJTfW254XKTOyyw@mail.gmail.com>
 <ce8f1a13-b56f-4419-a954-8d987af44112@arm.com> <5fd9ce52-9216-47ae-9ed3-fabb0f3b02fd@arm.com>
 <CAJZ5v0jL38PgFYVXFj2Py5NvUU0xFGU45w=TdcBXqr7v+xToag@mail.gmail.com> <49344fb7-78c0-4fc8-9687-22d039b5318f@arm.com>
In-Reply-To: <49344fb7-78c0-4fc8-9687-22d039b5318f@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 28 Nov 2023 16:17:04 +0100
Message-ID: <CAJZ5v0iq7sbNdxfVd1HAKKHpqHWSzcHE3EH9hK3s65OLDQFeEQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] Minor cleanup for thermal gov power allocator
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org, rui.zhang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 8:44 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
>
>
> On 11/23/23 19:50, Rafael J. Wysocki wrote:
> > Hi Lukasz,
> >
> > On Thu, Nov 23, 2023 at 4:19 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
> >>
> >> Hi Rafael,
> >>
> >> Gentle ping
> >>
> >> On 10/26/23 13:22, Lukasz Luba wrote:
> >>>
> >>>
> >>> On 10/26/23 09:54, Rafael J. Wysocki wrote:
> >>>> On Wed, Oct 25, 2023 at 9:21 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
> >>>>>
> >>>>> Hi all,
> >>>>>
> >>>>> The patch set does some small clean up for Intelligent Power Allocator.
> >>>>> Those changes are not expected to alter the general functionality.
> >>>>> They just
> >>>>> improve the code reading. Only patch 3/7 might improve the use case for
> >>>>> binding the governor to thermal zone (very unlikely in real products,
> >>>>> but
> >>>>> it's needed for correctness).
> >>>>>
> >>>>> The changes are based on top of current PM thermal branch, so with the
> >>>>> new trip points.
> >>>>>
> >>>>> Regards,
> >>>>> Lukasz
> >>>>>
> >>>>> Lukasz Luba (7):
> >>>>>     thermal: gov_power_allocator: Rename trip_max_desired_temperature
> >>>>>     thermal: gov_power_allocator: Setup trip points earlier
> >>>>>     thermal: gov_power_allocator: Check the cooling devices only for
> >>>>>       trip_max
> >>>>>     thermal: gov_power_allocator: Rearrange the order of variables
> >>>>>     thermal: gov_power_allocator: Use shorter variable when possible
> >>>>>     thermal: gov_power_allocator: Remove unneeded local variables
> >>>>>     thermal: gov_power_allocator: Clean needed variables at the beginning
> >>>>>
> >>>>>    drivers/thermal/gov_power_allocator.c | 123 ++++++++++++++------------
> >>>>>    1 file changed, 64 insertions(+), 59 deletions(-)
> >>>>>
> >>>>> --
> >>>>
> >>>> The series looks good to me overall, but I'd prefer to make these
> >>>> changes in the 6.8 cycle, because the 6.7 merge window is around the
> >>>> corner and there is quite a bit of thermal material in this cycle
> >>>> already.
> >>>
> >>> Thanks for having a look! Yes, I agree, we can wait after the
> >>> merge window. It just have to be cleaned one day a bit and I postponed
> >>> this a few times, so no rush ;)
> >>
> >> I've seen you've created the new pm/thermal. Could you consider to take
> >> those in, please?
> >
> > Sure, I'll get to them presumably tomorrow and if not then early next week.
>
> OK, thank you Rafael!

I've queued up the whole lot for 6.8 and in the process I've edited
all of the changelogs and some subjects for clarity and English
grammar improvements.

Thanks!
