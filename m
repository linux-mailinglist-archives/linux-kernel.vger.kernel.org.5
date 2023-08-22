Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A9A783BF9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 10:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233936AbjHVImi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 04:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbjHVImh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 04:42:37 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E64A1AD
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 01:42:34 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-4036bd4fff1so240871cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 01:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692693754; x=1693298554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1PXCFLASfJlT7ja16AErMWXIgdvK45LzPWsFlilW9d0=;
        b=Hvjikz1DwEdurExJUH4lVB78CkWEB8M7GqBjTR7Pqz0G4LDKphJzMK7KYSlo6hytM3
         wInAw8AY2gwX1Gs5aoGw43mJOmp68d1VgZ6g/Y9FVQH+IQKkKhwDnLnQavYT+RJ0eeg8
         rxJmpVz569LjMrovdRL5cfOueaeJI5cibhgUe4RC4zd7LdBw+XFnN58G/OOu9ZorRdg3
         PczBASPzaobkDmedlLYAFO3AaPphHKg99xaa5np9nuk/E2Dt3vzJ1yS5JAZGMSWTt+5Z
         PVMs9bPESCIpXk5vqzc8in+xVbFEr3y67Xfvj+xvE+tg6FWiMK0NZk5/6zJPVPmNpEpH
         ji2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692693754; x=1693298554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1PXCFLASfJlT7ja16AErMWXIgdvK45LzPWsFlilW9d0=;
        b=P6cuNPg/Le0W6YO5l1NdVPabgg1nciQ6JcduqmKiNW05JiPHO8Pq1v8fCfI45SBACC
         ixxWcnlGgU41RQBT8e+9lcdh8QdJtGX8DXryW+2yjKL7/0ksJuwsL/tm6bEOrTShZvmD
         PXFw8GpkAtUJgf0mn5U+QFugl9yLE0mubn9ZdzqgkCf1OpbMl9z049XLEULJn1xaLly/
         fBUW61qjditXJd1pnBA9CCw9A5rMpGiWlXrvKUYF8d7i9IewjCRSIK/hnPhTCb3Y1pTO
         VJLGO1Y0vTQCfbwgeDw2vd3684pUfPjh5I6nhVXgVQM+6UImvxv4JLXIHdLhJdO+oupl
         ZkKw==
X-Gm-Message-State: AOJu0Ywh6Pg8IlCz2Og0GjLjOQPeg9b4JEKWu29sFOJLdncTLfJXzMoC
        wTHRkC1erNCaiqBMne/OoHeIBm+uAiqJpW08JRYPC4fOjt81/xpZzc+OsQ==
X-Google-Smtp-Source: AGHT+IF8vxVmCuBjlZVGbQq9tIVljLxfZluYhz+ttfrRMk0jZB8+FSqHIijpzJk7RdoG6A1jcAgD/QcNNEAwMKXudWY=
X-Received: by 2002:a05:622a:1a13:b0:410:9855:ac6 with SMTP id
 f19-20020a05622a1a1300b0041098550ac6mr208299qtb.14.1692693753705; Tue, 22 Aug
 2023 01:42:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230728164254.27562-1-james.morse@arm.com>
In-Reply-To: <20230728164254.27562-1-james.morse@arm.com>
From:   Peter Newman <peternewman@google.com>
Date:   Tue, 22 Aug 2023 10:42:22 +0200
Message-ID: <CALPaoCgyOKS4mURO2RGTnDoocoAf65xqNYLipAXHkNJXdPJV_Q@mail.gmail.com>
Subject: Re: [PATCH v5 00/24] x86/resctrl: monitored closid+rmid together,
 separate arch/fs locking
To:     James Morse <james.morse@arm.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        carl@os.amperecomputing.com, lcherian@marvell.com,
        bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
        xingxin.hx@openanolis.org, baolin.wang@linux.alibaba.com,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, dfustini@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Fri, Jul 28, 2023 at 6:43=E2=80=AFPM James Morse <james.morse@arm.com> w=
rote:
> James Morse (24):
>   x86/resctrl: Track the closid with the rmid
>   x86/resctrl: Access per-rmid structures by index
>   x86/resctrl: Create helper for RMID allocation and mondata dir
>     creation
>   x86/resctrl: Move rmid allocation out of mkdir_rdt_prepare()
>   x86/resctrl: Allow RMID allocation to be scoped by CLOSID
>   x86/resctrl: Track the number of dirty RMID a CLOSID has
>   x86/resctrl: Use set_bit()/clear_bit() instead of open coding
>   x86/resctrl: Allocate the cleanest CLOSID by searching
>     closid_num_dirty_rmid
>   x86/resctrl: Move CLOSID/RMID matching and setting to use helpers
>   tick/nohz: Move tick_nohz_full_mask declaration outside the #ifdef
>   x86/resctrl: Add cpumask_any_housekeeping() for limbo/overflow
>   x86/resctrl: Make resctrl_arch_rmid_read() retry when it is
>     interrupted
>   x86/resctrl: Queue mon_event_read() instead of sending an IPI
>   x86/resctrl: Allow resctrl_arch_rmid_read() to sleep
>   x86/resctrl: Allow arch to allocate memory needed in
>     resctrl_arch_rmid_read()
>   x86/resctrl: Make resctrl_mounted checks explicit
>   x86/resctrl: Move alloc/mon static keys into helpers
>   x86/resctrl: Make rdt_enable_key the arch's decision to switch
>   x86/resctrl: Add helpers for system wide mon/alloc capable
>   x86/resctrl: Add cpu online callback for resctrl work
>   x86/resctrl: Allow overflow/limbo handlers to be scheduled on any-but
>     cpu
>   x86/resctrl: Add cpu offline callback for resctrl work
>   x86/resctrl: Move domain helper migration into resctrl_offline_cpu()
>   x86/resctrl: Separate arch and fs resctrl locks
>
>  arch/x86/include/asm/resctrl.h            |  90 +++++
>  arch/x86/kernel/cpu/resctrl/core.c        |  78 ++--
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  45 ++-
>  arch/x86/kernel/cpu/resctrl/internal.h    |  82 +++-
>  arch/x86/kernel/cpu/resctrl/monitor.c     | 440 ++++++++++++++++------
>  arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  15 +-
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 340 ++++++++++++-----
>  include/linux/resctrl.h                   |  43 ++-
>  include/linux/tick.h                      |   9 +-
>  9 files changed, 870 insertions(+), 272 deletions(-)

I ran this series successfully against our internal test suites on the
following processors:

- Intel(R) Xeon(R) Platinum 8173M CPU @ 2.00GHz
- AMD EPYC 7B12 64-Core Processor

Tested-By: Peter Newman <peternewman@google.com>

Thanks!
-Peter
