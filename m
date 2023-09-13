Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D26E79E1C1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 10:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238799AbjIMIPq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 13 Sep 2023 04:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbjIMIPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 04:15:43 -0400
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80D0DA;
        Wed, 13 Sep 2023 01:15:39 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-1a2dd615ddcso1883282fac.0;
        Wed, 13 Sep 2023 01:15:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694592939; x=1695197739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sPRE4yk+prnW+5k5MNZC6JcZxfgppCicb6DWP07tpq0=;
        b=xHwgU9x0uTqV2qSEMJbutSA5mX2kwOBe8DzOPY/I40jsK+1BN7izsHOXJxrLEWKJhs
         rJrByaDi3zGwJ6WxiW/Tm28gKKUonSiUaWnorJB14CeZan7M1x1KQWQEIs+ruUqM7SvC
         sWnhDdBnyVxxl+JyitnFey2BW7d3+3TFMZ/sxuOOB9we84M2WGT18OuF/aVXDuN05aZw
         L6CQq+DJp+LoXloqcXho5Ca2VgW7F1tiZkmZ0k/K2KNoLhypgc3OHRL27y0lkTjgTl1c
         JeKhK6dZW38/CK3MeD2wiWLoAyPNPHzXqFUvEMJgYrSfjYmhsLZtwxQ24ncwGiyl2LYk
         9R3Q==
X-Gm-Message-State: AOJu0YyVUBHiCcoIgmUTDRVZZcVOMREzQ1k2xMomLWkqapyiVZ0Y/z4G
        Z+Z/uDoUg7d0CfJ9j5UvorRDhkm7BC0ShlQ5E6o=
X-Google-Smtp-Source: AGHT+IG5Q2z6Sv8LLbImvaAeMv6mk0zCwM4ngapHNGNv4KRlhkAnqotHMsa36/nAJ1PGhXROO8P4kUDlp6lWu8TXiyk=
X-Received: by 2002:a05:6870:1493:b0:1d5:f814:56a3 with SMTP id
 k19-20020a056870149300b001d5f81456a3mr2131916oab.2.1694592938219; Wed, 13 Sep
 2023 01:15:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230829002346.2104251-1-srinivas.pandruvada@linux.intel.com>
 <CAJZ5v0jrKSUOGG72w-EdzhQqC==CA7zYUofNSEW1wV-58TOnLw@mail.gmail.com> <275e34c2e67a85c087ff983354bf74b5257b2fc4.camel@linux.intel.com>
In-Reply-To: <275e34c2e67a85c087ff983354bf74b5257b2fc4.camel@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 13 Sep 2023 10:15:26 +0200
Message-ID: <CAJZ5v0j7hBxprVN0vamaF74Ns3+hZk0qSQfPJqEROBbk1K4g-g@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] thermal: processor_thermal: Suport workload hint
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, daniel.lezcano@linaro.org,
        rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 9:44 PM srinivas pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> Hi Rafael,
>
> On Tue, 2023-09-12 at 16:09 +0200, Rafael J. Wysocki wrote:
> > On Tue, Aug 29, 2023 at 2:23 AM Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com> wrote:
> > >
> > >
>
> [...]
>
> > > --
> >
> > There is a slight issue with the patch ordering in this series,
> > because the interface to enable the interrupt should only be provided
> > after implementing the interrupt handlers.  I don't think that anyone
> > will apply the series partially and try to enable the feature,
> > though.
> Thanks!
>
> >
> > Also, I'm not actually sure if proc_thermal_wt_intr_callback() can
> > run
> > safely against the work item scheduled in proc_thermal_irq_handler()
> > in case the workload hint one triggers along with a thermal threshold
> > one.  I think that the access to MMIO is cached, so what if they both
> > try to update the same cache line at the same time?  Or are they
> > guaranteed to be different cache lines?
> These two registers are 90 cache lines apart. Looking at all the
> registers on this bar for status offsets, they are several cache lines
> apart. Also this bar is non prefetchable, so continuous data can't be
> fetched ahead.

OK

> >
> > Anyway, tentatively applied as 6.7 material, but I've changed the
> > second patch somewhat, because I couldn't convince myself that the
> > implicit type conversions in
> > processor_thermal_mbox_interrupt_config()
> > would always do the right thing regardless of the numbers involved,
> > so
> > please check the result in my bleeding-edge branch.
> >
> If I diff, there is only one change in processor_thermal_mbox.c. Tested
> that change and works fine.

Good, thanks!
