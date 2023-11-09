Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA3B7E7409
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 22:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233648AbjKIVxj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 9 Nov 2023 16:53:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjKIVxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 16:53:37 -0500
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9961FDF;
        Thu,  9 Nov 2023 13:53:35 -0800 (PST)
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2801d7f46f9so1205720a91.3;
        Thu, 09 Nov 2023 13:53:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699566814; x=1700171614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VO2PgdW9dAeLdae5W6Y+jI6LaYccUG625XwfnnbXcR4=;
        b=wSIpa8neloXchw/Yx/agZTm0EPv8YawkiXmOaNfTll5ADJ2/vRsHco52w2wMiOTMCP
         3cC8ArZ1/ie/SyFBcKKBP0gvHNZPhg11K8Q8uXDaS19HMXyg02sfC/+d1iDWpwu8BRNV
         2Fxho9O8G08wgNIGOJQ9sQYdoEKREqnkSDACdm1VsfBzmnLyOotgdjRxIjvBQ/3aMUC5
         6iWUnFjQQX4bD6MLxBFB1j+1A3Mi2N7nZFITg+PbAtMwuGDbbsmXhN0/XAzhGegK0RfF
         mRMFnk1Mu1faydn3E0QXZ4Y1zz/7un7prXQR6DPykKDtazY985VYUmoBTK+W4+UXKJB/
         nxAQ==
X-Gm-Message-State: AOJu0YwzbXS/f8t/oaSOq0Vvevgu+dVIi4UpQsnQ/vbf7wzF8uGdB8BE
        0AAaK3+iAYoUxylfofSdlI506AsEuiMsa+LLyy4=
X-Google-Smtp-Source: AGHT+IEAKmWcXWBiPAryTiDUKDWtDbiQWLYwPsLJs9VeZbKzYGrpvE+vd83cZhF6SjenC1/1+6pUy4cQEbSNwQHoO4o=
X-Received: by 2002:a17:90b:33c3:b0:27d:839:52ae with SMTP id
 lk3-20020a17090b33c300b0027d083952aemr2958699pjb.32.1699566814315; Thu, 09
 Nov 2023 13:53:34 -0800 (PST)
MIME-Version: 1.0
References: <20231107083331.901-1-ravi.bangoria@amd.com>
In-Reply-To: <20231107083331.901-1-ravi.bangoria@amd.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 9 Nov 2023 13:53:22 -0800
Message-ID: <CAM9d7cgs9Wk0OFoea4jOote-drHjvCimJyt7GWdO2Giw=d7Jog@mail.gmail.com>
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ravi,

On Tue, Nov 7, 2023 at 12:34 AM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>
> By default, Perf uses precise cycles event when no explicit event is
> specified by user. Precise cycles event is forwarded to ibs_op// pmu
> on AMD. However, IBS has hw issue on certain Zen2 processors where
> it might raise NMI without sample_valid bit set, which causes Unknown
> NMI warnings. (Erratum #1215: IBS (Instruction Based Sampling) Counter
> Valid Value May be Incorrect After Exit From Core C6 (CC6) State.) So,
> use non-precise cycles as default event on affected processors.

It seems like a kernel issue, do we have a kernel patch not to forward
precise cycles or instructions events to IBS on the affected CPUs?

Thanks,
Namhyung

>
> This does not prevent user to use explicit precise cycles event or
> ibs_op// pmu directly.
>
> Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---
