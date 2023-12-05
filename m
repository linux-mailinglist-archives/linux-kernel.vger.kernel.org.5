Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 905D68054FC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 13:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235132AbjLEMnV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 5 Dec 2023 07:43:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbjLEMnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 07:43:20 -0500
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91215C6
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 04:43:27 -0800 (PST)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-1fae54afb66so508065fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 04:43:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701780207; x=1702385007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JGsDskLbtr8yeU+Ls6PXtLcKmUVWMqdHJkv5ZXnV+Lo=;
        b=j+u8yf3i/GNAvVgTJqeKsi99HosiZN/rKPaN5mkttIiL5usLT8/GP9jMghDWF5khJr
         dD8zZ+Uz7ewoKow1oWiZk1Zt/ey9UNrh2k636Ei8dmeeSqDKkSMsvt3re4W1XjMdcZNn
         vpHIpHIluXwwwHeLEwQMdYhg7uu5KHVcyrzTcg0Uky+YtsZFwUIqy72NssDsX/ozb52L
         e3C73UDcU7UAPi85CcRgprxk4ozE+L9G0w/x2clDRI4Q7fZz+dPKVelEB/DosYu34gN6
         2hXVj2oMmYn7uKl7IUW+CAaFRW0f9dkw4/H6E0tAaGMkl1IrLLH23ZDuqmqYclxc5cPV
         Vi6Q==
X-Gm-Message-State: AOJu0YxonsEThOkYRfB688esz5VqTksKLIHc4f2mC10t+HAtA11woMPp
        AFTn3TtuFCOFKM+2A5yMD7eotipA9M+2qHlVyXQ=
X-Google-Smtp-Source: AGHT+IETysh2vfN2RS7YALJ9g/zZ49bj0GcvlR2jBwTh9oi5kuNCB25hpo6fgNEWKnE5NcKPPf/nt6uRzeP8ZpWl0+g=
X-Received: by 2002:a05:6870:6490:b0:1fa:f0ee:ba9c with SMTP id
 cz16-20020a056870649000b001faf0eeba9cmr13670250oab.2.1701780206786; Tue, 05
 Dec 2023 04:43:26 -0800 (PST)
MIME-Version: 1.0
References: <53bce76c5c60463eba1372df426a64b9@amazon.co.uk>
 <1D71D218-5EB6-47DE-A01B-3A66F9F4C74E@infradead.org> <CAJZ5v0iVvMLK_VcPRJ4sW1eOh0EtfcFvKjH5j1y1GbA0Y6q--Q@mail.gmail.com>
 <5322CF05-344D-4ADE-B38C-7DCE7F076E0C@infradead.org> <CAJZ5v0i-+9VwccRLGDcQdhz_UyBbw8k0LR9GbdvaRxs8PxP=0g@mail.gmail.com>
 <35268BBA-E97F-4ACB-A1C1-04C94AFDEA65@infradead.org>
In-Reply-To: <35268BBA-E97F-4ACB-A1C1-04C94AFDEA65@infradead.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 5 Dec 2023 13:43:15 +0100
Message-ID: <CAJZ5v0js3mA=9Rg4ki74Y1FNKzVo85OK9-oyVbOgukZ25wH3yw@mail.gmail.com>
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

On Tue, Dec 5, 2023 at 1:32 PM David Woodhouse <dwmw2@infradead.org> wrote:
>
> On 5 December 2023 12:31:19 GMT, "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> >On Tue, Dec 5, 2023 at 1:15 PM David Woodhouse <dwmw2@infradead.org> wrote:
> >>
> >> On 5 December 2023 12:12:09 GMT, "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> >> >On Tue, Dec 5, 2023 at 1:00 PM David Woodhouse <dwmw2@infradead.org> wrote:
> >> >>
> >> >>
> >> >> Paul writes:
> >> >> > The problem is that this will take effect even on a kexec and hence it is throttling
> >> >> > a system that set ENERGY_PERF_BIAS_PERFORMANCE prior to the kexec.  We use kexec to
> >> >> > live update the host kernel of our systems whilst leaving virtual machines running.
> >> >> > This resetting of the perf bias is having a very detrimental effect on the downtime
> >> >> > of our systems across the live update - about a 7 fold increase.
> >> >>
> >> >> It isn't just about kexec, is it? Even in a clean boot why wouldn't we want to stay in performance mode until the kernel has *finished* booting?
> >> >
> >> >Because it may overheat during that period.
> >> >
> >> >> It's literally adding seconds to the startup time in some cases.
> >> >>
> >> >> And yes, we *particularly* care in the kexec case because guests experience it as excessive steal time. But it ain't great in the general case either, surely?
> >> >
> >> >So IMV it would be perfectly fine to add a command line arg to provide
> >> >the initial value of energy_perf_bias for the ones who know what they
> >> >are doing.
> >>
> >> We don't even care about setting it to an "initial value" during boot. We just want to leave it how it was already set up.
> >
> >Which does not work on some systems.
> >
> >The problem here is that the BIOS cannot be trusted to set the initial
> >value that makes sense for the given platform and that's why the code
> >is the way it is.
>
> Yeah, I understand why we have the existing hack. We just need a way to disable it when it's doing the wrong thing.

Fair enough.

So the patch as is makes sense, but I would change the name of the
command line switch to something like intel_epb_no_override.
