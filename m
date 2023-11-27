Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11EB67FAC6C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 22:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbjK0VOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 16:14:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjK0VOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 16:14:15 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC4D19D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 13:14:22 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-a02ba1f500fso680697766b.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 13:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701119661; x=1701724461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lHlTCHe4/wBQkktFnIHXqkfvwqIEOSM2fmKEpfUC8HU=;
        b=dHSIUL4rRZ6f19icYJRQNs51qpzdk3wy2c0iYfBTxg66Ap7w0M6ZYosnXJ4NnN0I9O
         /7MP54+NYoFkBapHyc4rY+1w1NT37A0tYLG8lDV8K4VuDVREbPyPghhUKgFpJNMhiQn0
         wFpcJ6JyZ10aQ9tQbcigTBLljk8bSn7joHW+E124pxPeldsjV4whny2kqiE4Pk8Abr/o
         gXvHb8Dg70kHD4n7cNjlBE6mxiOUym51CYQnYvs/ei3qCTvmBJYvyyd5OPM+WWN46AgG
         T/UcxPhscFL745cjEW3iI2LEAnI67K70VQSu5q54h5RNyrXaC+TCX7bT5JPF/3pbRbxD
         vYug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701119661; x=1701724461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lHlTCHe4/wBQkktFnIHXqkfvwqIEOSM2fmKEpfUC8HU=;
        b=Q7ZRL/h+YuQCbUN6Xmnkxb+0Xb5Qjtc90UYJ9i2UZlV8//rSED0OLv3bbYjicD75Wv
         5ZmXOxzT99zc46irRNXzimjzQpxX/THb/s28C7sFoFmUVjvvLKSum/FkndwpJ2lodSCd
         +l0VRXvTyhlAA+yiVbbl35AT4gNC7J31RnMpLWhH4L2xkB2M5RrXU+oo6eGwRiNP1/a5
         IWgA1ymcPZa/QFiNCFxz16WMRR7mraZykWnslx8cOKrholjYekv01xdosggcqt44qRci
         X87Vh6IVfH9iwk/1shFNi4SPEsix01amPShATmraPJ7W7R+0KQ+CfMVJZSk6ydsOVPqb
         /HmQ==
X-Gm-Message-State: AOJu0Yx/fPLPdX5xY/+SzjuTyP3BNFc79urhnl1IbiMigH1cgUynC+UB
        ONQXvD7muO5MkthMsI7tvT+EGYl3gPzst2r7fbCAdg==
X-Google-Smtp-Source: AGHT+IGYi8xwqFfFpe0niiToCpHsvm1q+RbChDCT3xccMv3sRc/JIp2SCfG7mrEYNfGO5KtCN7bAv2jFI4lPCGF/kbg=
X-Received: by 2002:a17:906:2088:b0:a12:72eb:8f64 with SMTP id
 8-20020a170906208800b00a1272eb8f64mr544654ejq.30.1701119660661; Mon, 27 Nov
 2023 13:14:20 -0800 (PST)
MIME-Version: 1.0
References: <20231116022411.2250072-4-yosryahmed@google.com> <202311221542.973f16ad-oliver.sang@intel.com>
In-Reply-To: <202311221542.973f16ad-oliver.sang@intel.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 27 Nov 2023 13:13:44 -0800
Message-ID: <CAJD7tkYnn6CxSJdo0QJ1hc6cFY_qWLuJ0=S6g_Pm=GBV+Ss-jw@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] mm: memcg: make stats flushing threshold per-memcg
To:     kernel test robot <oliver.sang@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        Johannes Weiner <hannes@cmpxchg.org>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org, ying.huang@intel.com,
        feng.tang@intel.com, fengwei.yin@intel.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>, kernel-team@cloudflare.com,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 5:54=E2=80=AFAM kernel test robot <oliver.sang@inte=
l.com> wrote:
>
>
>
> Hello,
>
> kernel test robot noticed a -30.2% regression of will-it-scale.per_thread=
_ops on:
>
>
> commit: c7fbfc7b4e089c4a9b292b1973a42a5761c1342f ("[PATCH v3 3/5] mm: mem=
cg: make stats flushing threshold per-memcg")
> url: https://github.com/intel-lab-lkp/linux/commits/Yosry-Ahmed/mm-memcg-=
change-flush_next_time-to-flush_last_time/20231116-103300
> base: https://git.kernel.org/cgit/linux/kernel/git/akpm/mm.git mm-everyth=
ing
> patch link: https://lore.kernel.org/all/20231116022411.2250072-4-yosryahm=
ed@google.com/
> patch subject: [PATCH v3 3/5] mm: memcg: make stats flushing threshold pe=
r-memcg
>
> testcase: will-it-scale
> test machine: 104 threads 2 sockets (Skylake) with 192G memory
> parameters:
>
>         nr_task: 50%
>         mode: thread
>         test: fallocate2
>         cpufreq_governor: performance
>
>

This regression was also reported in v2, and I explicitly mention it
in the cover letter here:
https://lore.kernel.org/lkml/20231116022411.2250072-1-yosryahmed@google.com=
/

In a nutshell, I think this microbenchmark regression does not
represent real workloads. On the other hand, there are demonstrated
benefits on real workloads from this series in terms of stats reading
time.
