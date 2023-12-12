Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563BA80ECDF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 14:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376536AbjLLNJq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 12 Dec 2023 08:09:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376531AbjLLNJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 08:09:43 -0500
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF9FF4;
        Tue, 12 Dec 2023 05:09:50 -0800 (PST)
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6d9db92bd71so762850a34.1;
        Tue, 12 Dec 2023 05:09:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702386590; x=1702991390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lAqdKm0EKgBcxE4mTrx8v0yfSJhP1XzxWLOd6J96gro=;
        b=PgCgL2mhf9YSWfl7kVX/RsNplqW8QzyWVZBqVK3BHUGlrc9Ch4QT1jhE1Rc8vFC7DW
         2k6CWKR5mVaoy3dMx8TDoMVKkxpDqDpzi6IA6iREGOvi/DmDobGd7SKwxMpep5qvuEZ+
         TaI1CJqCb4rnfIWaI36o5Lxn/40b5LYKPOwEWygw0+RCEUO2gCWl/Lb9v9tbOXWYvoOm
         k69XCs7lK2oqbq1pog0lZQgo238putL6c6DC0NMkMA8YhEKGeoiCpxMbH9LWaAb8qHAy
         /2y+q0QHVF+FVa4Ln6dmxV0ytis/ZBb8cqKYcNakihjpUj5jJcGjQQtSIc11SOvxrsnp
         mbGA==
X-Gm-Message-State: AOJu0YzGirGriDseSU43hLkf34Q3iqn8xFvLPBF/jLDDs0+mGJ/7FZ1E
        3cnB38uhGfv73y/JR7ePYLGGHl8gX8bjwy8FZC5CbqfJLL0=
X-Google-Smtp-Source: AGHT+IHLfzGUAAnaJfxtVuphP3ffds6u7IRMNEbo1BSNizPMYveg8tZYJegMpmdSons2fjLjTENixKhoYazZJqKvQrg=
X-Received: by 2002:a05:6820:220d:b0:58d:5302:5b18 with SMTP id
 cj13-20020a056820220d00b0058d53025b18mr12505756oob.1.1702386589661; Tue, 12
 Dec 2023 05:09:49 -0800 (PST)
MIME-Version: 1.0
References: <20231124223226.24249-1-frederic@kernel.org> <20231124223226.24249-5-frederic@kernel.org>
In-Reply-To: <20231124223226.24249-5-frederic@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 12 Dec 2023 14:09:38 +0100
Message-ID: <CAJZ5v0jBzqa8UVbarJbFDcqyLsMEVYSuCtcxKk6PUSv3TDnUOQ@mail.gmail.com>
Subject: Re: [PATCH 4/7] cpuidle: s/CPUIDLE_FLAG_POLLING/CPUIDLE_FLAG_POLLING_SOFT
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
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

On Fri, Nov 24, 2023 at 11:32 PM Frederic Weisbecker
<frederic@kernel.org> wrote:
>
> In order to further distinguish software and hardware TIF_NEED_RESCHED
> polling cpuidle states, rename CPUIDLE_FLAG_POLLING to
> CPUIDLE_FLAG_POLLING_SOFT before introducing CPUIDLE_FLAG_POLLING_HARD
> and tag mwait users with it.

Well, if MWAIT users are the only category that will be tagged with
the new flag, it can be called CPUIDLE_FLAG_POLLING_MWAIT or even
CPUIDLE_FLAG_MWAIT for that matter and the $subject patch won't be
necessary any more AFAICS.

> This will allow cpuidle core to manage TIF_NR_POLLING on behalf of all
> kinds of TIF_NEED_RESCHED polling states while keeping a necessary
> distinction for the governors between software loops polling on
> TIF_NEED_RESCHED and hardware monitored writes to thread flags.

Fair enough, but what about using a different name for the new flag
and leaving the old one as is?
