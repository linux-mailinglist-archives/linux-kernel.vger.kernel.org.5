Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED4980DF22
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 00:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345236AbjLKXCC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 11 Dec 2023 18:02:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345166AbjLKXCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 18:02:01 -0500
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96619A;
        Mon, 11 Dec 2023 15:02:07 -0800 (PST)
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-58d18c224c7so2644818eaf.2;
        Mon, 11 Dec 2023 15:02:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702335727; x=1702940527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZzAtMvelZEhbKh45bRc76zp7HAJfBcphLeBiuFGz8KE=;
        b=kdnwIZMoLWSUtx9MK2XxYNTE/kpzkUED8UPdL5KVAguznnYThi/PAuDhwBTpAiw8RC
         ZH11+sqrL4Q0vtYnIWHu7GF+lLy8Q0wZDShHITYt6ejOdsyl8SjEx2LYgAr0ULwOZIj6
         hpblz31PvCONHGShDAYz2UNH1UBwdy8Y7hnrBX8/rz0QlQnwT/Mgn9miej43MBOwGyZR
         8/kUaNfK6f2cSOwsejqCsWRxHl11pOkL6LXt/cuo+kRKf2+m4OEgEzJJ/K633pH8Pa0G
         prISvDM4DK5RrtZVZOp99cr77XodNYDh2687n9lbRsgQ60RWvmOmtSVNa7pjhiC6MlsN
         ar8w==
X-Gm-Message-State: AOJu0YwedWa+g3sF9JyhJqUY4E1tR+WXHGsZGMNFDb82W/2FNyETBpiB
        M6vnCczKhvvsSRITdq0gNuoQpFUitAvtd82Ar0c=
X-Google-Smtp-Source: AGHT+IEZv+C9XGXi4ZZ+IS1I5twWj3QQ9yafN7rmJezcHw0HUxmUGG+4usD+b6G7sld4rHVbriSH4uwcAUQ9mY35EqQ=
X-Received: by 2002:a05:6358:248b:b0:170:6ed7:3148 with SMTP id
 m11-20020a056358248b00b001706ed73148mr2916226rwc.22.1702335726809; Mon, 11
 Dec 2023 15:02:06 -0800 (PST)
MIME-Version: 1.0
References: <20231107083331.901-1-ravi.bangoria@amd.com> <CAM9d7cgs9Wk0OFoea4jOote-drHjvCimJyt7GWdO2Giw=d7Jog@mail.gmail.com>
 <f42bf6b7-75b8-124b-c79e-ad7a9b706990@amd.com> <CAM9d7cijrZzp=5m+BcQ77WFOSHT7e5vO-RCUTUp5Pevmz2wbtg@mail.gmail.com>
 <53374e41-d1e0-aa8f-d001-5e89783b962c@amd.com>
In-Reply-To: <53374e41-d1e0-aa8f-d001-5e89783b962c@amd.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 11 Dec 2023 15:01:55 -0800
Message-ID: <CAM9d7cgNsXVpFDsUt01TwxF3B=7G9TWZWoNU2dP_RGtQdQAJPQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf tool AMD: Use non-precise cycles as default
 event on certain Zen2 processors
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     acme@kernel.org, kim.phillips@amd.com, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com,
        kan.liang@linux.intel.com, changbin.du@huawei.com,
        yangjihong1@huawei.com, zwisler@chromium.org,
        wangming01@loongson.cn, chenhuacai@kernel.org,
        kprateek.nayak@amd.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, sandipan.das@amd.com,
        ananth.narayan@amd.com, santosh.shukla@amd.com
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

On Mon, Dec 11, 2023 at 5:54 AM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>
> Hi Namhyung,
>
> >>>> By default, Perf uses precise cycles event when no explicit event is
> >>>> specified by user. Precise cycles event is forwarded to ibs_op// pmu
> >>>> on AMD. However, IBS has hw issue on certain Zen2 processors where
> >>>> it might raise NMI without sample_valid bit set, which causes Unknown
> >>>> NMI warnings. (Erratum #1215: IBS (Instruction Based Sampling) Counter
> >>>> Valid Value May be Incorrect After Exit From Core C6 (CC6) State.) So,
> >>>> use non-precise cycles as default event on affected processors.
> >>>
> >>> It seems like a kernel issue, do we have a kernel patch not to forward
> >>> precise cycles or instructions events to IBS on the affected CPUs?
> >>
> >> I'm not sure how it's a kernel issue. User can use ibs_op// pmu directly
> >> and might hit the hw bug.
> >
> > Sorry for the late reply.  I know it's the user's fault when using ibs_op//
> > directly but I think the kernel should not forward cycles:pp to IBS.
>
> For all AMD zen uarchs, cycles:p is same as ibs_op// (man perf-list has
> more detail). It's confusing if ibs_op// works but cycles:p fails on the
> same machine.

Make sense.  Probably perf tools can provide a more detailed message
about the situation.

>
> No strong opinion though. I can prepare a kernel patch, if you want.

I have a report that these unknown NMI messages caused some
performance issues.  So maybe we need to be safe by not using
IBS automatically.  I've also posted a patch to rate-limit the message
itself.

Thanks,
Namhyung
