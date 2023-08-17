Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEFC777F34A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 11:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349615AbjHQJ3o convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 17 Aug 2023 05:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349645AbjHQJ3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 05:29:37 -0400
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389062712;
        Thu, 17 Aug 2023 02:29:36 -0700 (PDT)
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-56d75fb64a6so1195048eaf.0;
        Thu, 17 Aug 2023 02:29:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692264575; x=1692869375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fdGsfXep5TF4hCEmFfRAcBljG6Erf6EGHttd193Zeq8=;
        b=MzHFIOsZLyPsb5NH7pdfnRmFJjHBMD9u9PnIMKQaWAqcqnFeaS1spYLaf1Eu/H2xEr
         r98/q2UdoQKqQQz1UuABN8HVFJs8JCJJaBzZZmhtbOS24kuyMtKMd48yHEoOsgfJ+fLJ
         dDQnW647ZI4Un7BeP5BQs6HqyTd/zk17HdVA+DSMqP4xtF2Dz5b/gYAgyLQTLmWi+3ah
         HC9ID5mu3kBBE2mAhuRgmPBFT5J3IX+PTl8STWJwg1DXyjmIlp2Hga58e03XVwnuasAD
         x3xO35iSPIADgk/YQtJIbWlUGTYoaTzmIJH1mpFEqxV0UpS+8hReVnaaEhfruVSmY6yT
         ey4A==
X-Gm-Message-State: AOJu0Ywq1nYPZI3hsh94ZdnD+zABQ+TW6mEZPmXcO//gtQDczpvDc79Q
        4a5L76phBBZO1qa8H8GwQpCp2WqBLDsYv3OiS40=
X-Google-Smtp-Source: AGHT+IHHMot7n8mnZi5dg6ZgXEBVnOE7qsIxSFZwGJYdbsqfdyq8HYj/GzJMTugzZpYjysWQJj8WvI4L+nHNh3/MAyU=
X-Received: by 2002:a4a:c90f:0:b0:566:951e:140c with SMTP id
 v15-20020a4ac90f000000b00566951e140cmr4268028ooq.1.1692264575427; Thu, 17 Aug
 2023 02:29:35 -0700 (PDT)
MIME-Version: 1.0
References: <12275372.O9o76ZdvQC@kreacher> <CAAYoRsUYrE7gM28VCB0KrP2dCr7NmH2wuDnhT6h1D=S7go6fJA@mail.gmail.com>
In-Reply-To: <CAAYoRsUYrE7gM28VCB0KrP2dCr7NmH2wuDnhT6h1D=S7go6fJA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 17 Aug 2023 11:29:15 +0200
Message-ID: <CAJZ5v0ggvvSnV8qvoOhOKBAMkmERzr22rqgqKV--fny1q35M+g@mail.gmail.com>
Subject: Re: [RFT] [PATCH v2] cpuidle: menu: Skip tick_nohz_get_sleep_length()
 call in some cases
To:     Doug Smythies <dsmythies@telus.net>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Kajetan Puchalski <kajetan.puchalski@arm.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
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

On Mon, Aug 14, 2023 at 4:52 PM Doug Smythies <dsmythies@telus.net> wrote:
>
> On Thu, Aug 10, 2023 at 11:38 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Subject: [PATCH] cpuidle: menu: Skip tick_nohz_get_sleep_length() call in some cases
> >
> > Because the cost of calling tick_nohz_get_sleep_length() may increase
> > in the future, reorder the code in menu_select() so it first uses the
> > statistics to determine the expected idle duration.  If that value is
> > higher than RESIDENCY_THRESHOLD_NS, tick_nohz_get_sleep_length() will
> > be called to obtain the time till the closest timer and refine the
> > idle duration prediction if necessary.
> >
> > This causes the governor to always take the full overhead of
> > get_typical_interval() with the assumption that the cost will be
> > amortized by skipping the tick_nohz_get_sleep_length() call in the
> > cases when the predicted idle duration is relatively very small.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> I ran the same tests as I did for the teo governor changes.
> Nothing of significance to report (well, some minor improvements
> in records per second at the long interval end of the sleeping
> ebizzy test, with a corresponding slight increase in processor
> package power).
>
> Tested-by: Doug Smythies <dsmythies@telus.net>

Thank you!
