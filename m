Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA56777F02
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 19:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234037AbjHJRUr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 10 Aug 2023 13:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235056AbjHJRUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 13:20:45 -0400
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7B9270D;
        Thu, 10 Aug 2023 10:20:44 -0700 (PDT)
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-56d0deeca09so192225eaf.0;
        Thu, 10 Aug 2023 10:20:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691688043; x=1692292843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EN9CM2qX1siO8TjAIXptEtELwVlMdfBhvADZW0USjiQ=;
        b=XJFtTVHImkVNd43//LCfurB2MOZCQwuXBx6/qlkcvBzQufxvSUEuVhuubFq7latYOm
         uCFvzvN9KN9zMxbBpED4A5qJVcCitbG26hVwPRJll1VClUQFn05LSL32COnSTVknBQm+
         1uqdPDjRECC26pnsksygSsaYAtUOMawIPCKYGWJx1wqkpsXOTJ5uPm09IRUfSsSWsoiQ
         CNwnfJeAKtJ6gLb5rAM8eYyHL4r0XpLKpNaeOexhniByIk0NJDpgKd4VOSOh2p2HXSpk
         s1lYnTADw9or5IBhwoPa0o8YIqdN8zb/7q0O6P0WpHL4M8ebJljW71n4UcwAoTFoGjDp
         u2WQ==
X-Gm-Message-State: AOJu0YwC0owmI4CYuPl5VN+Mejuthv8StdRKh/ZAxRn5BjyeuRoDGc+I
        7Tl/ekWvedFE1Zv7j2RU3aVWVQsul7RCME/T9HU=
X-Google-Smtp-Source: AGHT+IH90WY2EO+TOpQKXPs3Rn1gvvHhZ9UpilovXxKReuAulONNLA1zvQaGilvH6Edwh8lX2BdrA//IeimnAWYoHUA=
X-Received: by 2002:a4a:d689:0:b0:56c:484a:923d with SMTP id
 i9-20020a4ad689000000b0056c484a923dmr2534551oot.1.1691688043155; Thu, 10 Aug
 2023 10:20:43 -0700 (PDT)
MIME-Version: 1.0
References: <5708364.DvuYhMxLoT@kreacher> <CAJZ5v0hNZLvt+bJLvvibmk3dw_u5XnYNS020r7QLWLiiWLZSgQ@mail.gmail.com>
 <CAAYoRsVHFLpQ91DqUZygZETsYC31rhmgFru=19C-veXSH+dy5w@mail.gmail.com>
In-Reply-To: <CAAYoRsVHFLpQ91DqUZygZETsYC31rhmgFru=19C-veXSH+dy5w@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 10 Aug 2023 19:20:32 +0200
Message-ID: <CAJZ5v0iYCwAaMgpD=_M+Ynwx50UpQDV5GU4Lj1tkTKKAEt5xoA@mail.gmail.com>
Subject: Re: [RFT] [PATCH v1] cpuidle: menu: Skip tick_nohz_get_sleep_length()
 call in some cases
To:     Doug Smythies <dsmythies@telus.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Kajetan Puchalski <kajetan.puchalski@arm.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
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

Hi Doug,

On Thu, Aug 10, 2023 at 6:28 PM Doug Smythies <dsmythies@telus.net> wrote:
>
> On Wed, Aug 9, 2023 at 11:16 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > On Wed, Aug 9, 2023 at 4:53 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > >
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > Because the cost of calling tick_nohz_get_sleep_length() may increase
> > > in the future, reorder the code in menu_select() so it first uses the
> > > statistics to determine the expected idle duration.  If that value is
> > > higher than RESIDENCY_THRESHOLD_NS, tick_nohz_get_sleep_length() will
> > > be called to obtain the time till the closest timer and refine the
> > > idle duration prediction if necessary.
> > >
> > > This causes the governor to always take the full overhead of
> > > get_typical_interval() with the assumption that the cost will be
> > > amortized by skipping the tick_nohz_get_sleep_length() call in the
> > > cases when the predicted idle duration is relatively very small.
> > >
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> ... deleted...
> >
> > This patch is now present in the git branch at
> >
> > git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
> >  pm-cpuidle-gov
> >
> > along with the previous teo governor changes.
>
> Hi Rafael,
>
> Thanks for the branch and adding it to the previous 6.5-rc4 code,
> as now I can re-use the menu baseline tests already done.
>
> My test computer boots by default to use the teo idle governor.
> When I change to the menu governor, my system becomes
> unresponsive and I have to re-boot.
>
> Is anyone else having this difficulty?

There is a missing check it get_typical_interval(), my bad.

I'll send a v2 of the menu governor patch shortly and I'll update the
pm-cpuidle-gov branch accordingly.

Thanks!
