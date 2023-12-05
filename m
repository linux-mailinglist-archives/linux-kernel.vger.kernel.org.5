Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A2080542B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 13:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345056AbjLEMb1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 5 Dec 2023 07:31:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbjLEMbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 07:31:25 -0500
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8058C6
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 04:31:31 -0800 (PST)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-1faf1ba2219so484813fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 04:31:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701779491; x=1702384291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d2l658lAAB8UER6owiPHSWpp2VkIA+Dz5LPSsaJSpPQ=;
        b=pL3z9MDSlRDQ9ltyYEB2tRYwwoQkrt7YiPari6BaGj16UU3tySF3St9yM5i2+IWi8j
         yRDkhQf7mgjS+J/61l+GGKw7HD1qvRq1rUPT8xVLHV5Et8qBVR4PRZiI+rN0OxmCPIT8
         SQnzt6JEBPeYmgF8UIZ+hR5HM4UAhNAFNFeIKA4txRpTDz8gbuEAWTE55r7EetQI4RAY
         4HxTBjCYyirG6poZ6FY5lO/KHqiLF1yhFBv/uDnprH9ooZitspjhNtzXh8mP6I9nH+xU
         T/0pOSXwCm5vSKftiw3CrZ68ZLXhPCn0IE5uofKdcB8Y1JCZZuyqepdA/l+OnUSlxvxy
         MtUw==
X-Gm-Message-State: AOJu0YzkvkLe+m4WCpEZKMFKSCO1jfRyi30Jhtvpcx2cL2/uyLuorTOG
        Vs/z0xKLU59injOkhNVOfvRYWgO6XGJ6IRXPzfg=
X-Google-Smtp-Source: AGHT+IHgNVlB9IwQAntCfXV2O3Ev5PwbJbE0uG68WvNiwtVL2fGbYHb7YBZ04tcdSlYQkujLszQBgZC2jZVN07KbprM=
X-Received: by 2002:a05:6870:4d09:b0:1fb:19d6:8715 with SMTP id
 pn9-20020a0568704d0900b001fb19d68715mr10526151oab.4.1701779491026; Tue, 05
 Dec 2023 04:31:31 -0800 (PST)
MIME-Version: 1.0
References: <53bce76c5c60463eba1372df426a64b9@amazon.co.uk>
 <1D71D218-5EB6-47DE-A01B-3A66F9F4C74E@infradead.org> <CAJZ5v0iVvMLK_VcPRJ4sW1eOh0EtfcFvKjH5j1y1GbA0Y6q--Q@mail.gmail.com>
 <5322CF05-344D-4ADE-B38C-7DCE7F076E0C@infradead.org>
In-Reply-To: <5322CF05-344D-4ADE-B38C-7DCE7F076E0C@infradead.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 5 Dec 2023 13:31:19 +0100
Message-ID: <CAJZ5v0i-+9VwccRLGDcQdhz_UyBbw8k0LR9GbdvaRxs8PxP=0g@mail.gmail.com>
Subject: Re: [PATCH] x86: intel_epb: Add earlyparam option to keep bias at performance
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, pdurrant@amazon.co.uk,
        bp@alien8.de, dave.hansen@intel.com, dave.hansen@linux.intel.com,
        hdegoede@redhat.com, hpa@zytor.com, jalliste@amazon.co.uk,
        juew@amazon.com, len.brown@intel.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org, rafael.j.wysocki@intel.com,
        tglx@linutronix.de, usama.arif@bytedance.com, x86@kernel.org
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

On Tue, Dec 5, 2023 at 1:15 PM David Woodhouse <dwmw2@infradead.org> wrote:
>
> On 5 December 2023 12:12:09 GMT, "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> >On Tue, Dec 5, 2023 at 1:00 PM David Woodhouse <dwmw2@infradead.org> wrote:
> >>
> >>
> >> Paul writes:
> >> > The problem is that this will take effect even on a kexec and hence it is throttling
> >> > a system that set ENERGY_PERF_BIAS_PERFORMANCE prior to the kexec.  We use kexec to
> >> > live update the host kernel of our systems whilst leaving virtual machines running.
> >> > This resetting of the perf bias is having a very detrimental effect on the downtime
> >> > of our systems across the live update - about a 7 fold increase.
> >>
> >> It isn't just about kexec, is it? Even in a clean boot why wouldn't we want to stay in performance mode until the kernel has *finished* booting?
> >
> >Because it may overheat during that period.
> >
> >> It's literally adding seconds to the startup time in some cases.
> >>
> >> And yes, we *particularly* care in the kexec case because guests experience it as excessive steal time. But it ain't great in the general case either, surely?
> >
> >So IMV it would be perfectly fine to add a command line arg to provide
> >the initial value of energy_perf_bias for the ones who know what they
> >are doing.
>
> We don't even care about setting it to an "initial value" during boot. We just want to leave it how it was already set up.

Which does not work on some systems.

The problem here is that the BIOS cannot be trusted to set the initial
value that makes sense for the given platform and that's why the code
is the way it is.
