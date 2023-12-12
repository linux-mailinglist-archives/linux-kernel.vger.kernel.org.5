Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6770380F475
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 18:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376670AbjLLRXL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 12 Dec 2023 12:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235110AbjLLRXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 12:23:07 -0500
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F4E9F;
        Tue, 12 Dec 2023 09:23:14 -0800 (PST)
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5c66bbb3d77so3358750a12.0;
        Tue, 12 Dec 2023 09:23:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702401794; x=1703006594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MRd+wrGx+k+oAJrYQSPEsfD9HTn2kU5M5FOxDmNsBgY=;
        b=O7z1lIgfPX48Vdt4fsfEJWkCmz4oFY73H1URp+LEz2nOwwCZYH1v90TRpJiRpekXnG
         alxovRFc53K+ZQd913RZrrdshVWfDm4vtpCZkbprlB3lFr99KdHAJAgRfBjZYxj4NSIJ
         m5qJrzHJPa4hB4I8Katn5C7kaSE8+T3MSusytF8mMUygu//hnlbL71Fi4NetxeN6eBf4
         PmcW3G044cSdAX1LtSDbpsJlr9OpQnxBhoU37dB7FH/M5IRmMsf/mtcmLI6uQ4y9SsrZ
         EzWvl56SYa6cChUGoX2KSJsj0lL9lnE6xPUdoHy1+uIsEYR4rA4aIQEJU7VbxErFt19p
         E2Ng==
X-Gm-Message-State: AOJu0Yymjz8m40qk5mNpArABBdu6vlpOKk2SpE/YtnyhYVcXoRUmdVPm
        rSWJEGapF7MPT3IdrHjI29B6ibrx/Yywa9Ybthk=
X-Google-Smtp-Source: AGHT+IExbrs5lqY7fnplXxqrzF+7Vs19tgpgAqWbiPeO70uFzyG2Qj1UA/Wz+HXmu5f88stuTXz/85XmTnW7AbGmd34=
X-Received: by 2002:a17:90a:71c3:b0:286:6cc1:2cac with SMTP id
 m3-20020a17090a71c300b002866cc12cacmr3610905pjs.54.1702401793553; Tue, 12 Dec
 2023 09:23:13 -0800 (PST)
MIME-Version: 1.0
References: <20231208210855.407580-1-kan.liang@linux.intel.com>
 <ZXd7ZuxbNNsjAyqm@kernel.org> <07677ab2-c29b-499b-b473-f7535fb27a8c@linux.intel.com>
In-Reply-To: <07677ab2-c29b-499b-b473-f7535fb27a8c@linux.intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 12 Dec 2023 09:23:01 -0800
Message-ID: <CAM9d7ci-VVhubefMqkSQgK-B2e2z4QU1=TLJtC49wbWW=VNc8g@mail.gmail.com>
Subject: Re: [PATCH] perf top: Use evsel's cpus to replace user_requested_cpus
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>, irogers@google.com,
        mark.rutland@arm.com, maz@kernel.org, marcan@marcan.st,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 7:56 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>
>
>
> On 2023-12-11 4:13 p.m., Arnaldo Carvalho de Melo wrote:
> > Em Fri, Dec 08, 2023 at 01:08:55PM -0800, kan.liang@linux.intel.com escreveu:
> >> From: Kan Liang <kan.liang@linux.intel.com>
> >>
> >> perf top errors out on a hybrid machine
> >>  $perf top
> >>
> >>  Error:
> >>  The cycles:P event is not supported.
> >>
> >> The user_requested_cpus may contain CPUs that are invalid for a hybrid
> >> PMU. It causes perf_event_open to fail.
> >
> > ?
> >
> > All perf top expects is that the "cycles", the most basic one, be
> > collected, on all CPUs in the system.
> >
>
> Yes, but for hybrid there is no single "cycles" event which can cover
> all CPUs.

Does that mean the kernel would reject the legacy "cycles" event
on hybrid CPUs?

Thanks,
Namhyung
