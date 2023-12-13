Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2EF28107F3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 03:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378243AbjLMCGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 21:06:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235189AbjLMCGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 21:06:08 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4B7CE
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 18:06:14 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-42598c2b0b7so93731cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 18:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702433173; x=1703037973; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8w1+yfAr2SPzVB4dpYvx6YaKAjN+fhfuOqchPg5V3ac=;
        b=G/PYG8LCOvc9QQHCceMnLZDqLs9MpWjTZ0PC84E1dM01lSAK2XCB/tQ1lj8oyXfVjv
         60R42JaFPPlFKDwwS3Y2DrfxHgE651pHMIyFTSonTgfXjdp9MRgIpIzq8HIGru3Hohv6
         OgiTzefahr7uAlaUARWiOYJx/IxtibKhg9C1CsSV2QzMVCVU+KtW9EAjKfJWDyjI5CFU
         5DzUxwTluj3PHQsCuisrfyD71XFgdKSUq9gaFmNi0V4ZwBan5HIburBCx7VkdjnZ/TnA
         5fQQd8F2lwOAZLPAMWi5nqst9wT8SLlPzhAV14Jga3v0rUVqKG62yHnGjMxhM63QX4Yl
         dXHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702433173; x=1703037973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8w1+yfAr2SPzVB4dpYvx6YaKAjN+fhfuOqchPg5V3ac=;
        b=WuPJfeKw4FRIAEWP8KOU0oHS/DJEIft0BPM3Kl2rCbzF06BuUORbhvsSBgDZNkRLaZ
         dfFN/hHEPMPPBjylnXVBMI3D6UzWUTDYzyRa1wrx7QgDFevh72HXNmyu1jUqnD/Ig9ZE
         QI/s2QMCjVdqUXt8BDwHQFq0ct5DjfVh5zj4Eb93M66DMzPeg5PYre5FCqUfPH3CrN8b
         mSzcsj+YdSFEKxXywrB1wKOkLlMJgEbf+D+jLnFsN9hf1nxL1l3HiYckXjV4K0kmawjQ
         ztOuyziWCq82bjBjYCUissqjQipZXMyyhi0Sy1ztjq8/j0Si29+XPFGK847v8SWdJboo
         vsKg==
X-Gm-Message-State: AOJu0YzBoOtIJ61yZ5QDGV+mbbZr0XHnAD/HTDYy02pBRWbdzPHZkWxF
        8xmsMJ0uCzXgFgpO9WbHfti3nlTVTGzENJ4+Pgbutg==
X-Google-Smtp-Source: AGHT+IG3y4UdjpV0X9gFbF4eOb8+BdZkR190RHWRGUNro5VSrV3slPFDuCaeH/KRi7c4WLSMSpvCPYZ95Vd4vDp2clc=
X-Received: by 2002:a05:622a:303:b0:41e:36cd:4284 with SMTP id
 q3-20020a05622a030300b0041e36cd4284mr1355674qtw.6.1702433173482; Tue, 12 Dec
 2023 18:06:13 -0800 (PST)
MIME-Version: 1.0
References: <20231213013807.897742-1-schatzberg.dan@gmail.com> <20231213013807.897742-3-schatzberg.dan@gmail.com>
In-Reply-To: <20231213013807.897742-3-schatzberg.dan@gmail.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Tue, 12 Dec 2023 19:05:36 -0700
Message-ID: <CAOUHufarKA5-NGErYzvqeKKJze1XSUcMx4ntBHx2jmAUeqAioA@mail.gmail.com>
Subject: Re: [PATCH V4 2/2] mm: add swapiness= arg to memory.reclaim
To:     Dan Schatzberg <schatzberg.dan@gmail.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Yosry Ahmed <yosryahmed@google.com>, Huan Yang <link@vivo.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Yue Zhao <findns94@gmail.com>, Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 6:39=E2=80=AFPM Dan Schatzberg <schatzberg.dan@gmai=
l.com> wrote:
>
> Allow proactive reclaimers to submit an additional swappiness=3D<val>
> argument to memory.reclaim. This overrides the global or per-memcg
> swappiness setting for that reclaim attempt.
>
> For example:
>
> echo "2M swappiness=3D0" > /sys/fs/cgroup/memory.reclaim
>
> will perform reclaim on the rootcg with a swappiness setting of 0 (no
> swap) regardless of the vm.swappiness sysctl setting.
>
> Signed-off-by: Dan Schatzberg <schatzberg.dan@gmail.com>

NAK.

Please initialize new variables properly and test code changes
thoroughly before submission.
