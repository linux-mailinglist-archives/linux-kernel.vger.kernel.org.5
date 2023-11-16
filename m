Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA1F7EE90B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 22:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233968AbjKPV5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 16:57:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232932AbjKPV5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 16:57:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B95181
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 13:57:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 152A3C433BA
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 21:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700171871;
        bh=Y5SKnI8KWiPUqCAShlWpsNDBct9rlzSkcftG0eIw8Fw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qc23cTZXcHOVIEqQaLp6ZVyfhJoeY1rsCLG/MzL+cA5SJAemc9peMWygss3ZG+4Th
         gvJ0Gb8gqNgz4b3RpnG9fDGY8EhfQsWAuKlyoJeUn1WrCQDFzfTe9Jz1NNiHRXT+ZO
         LZXlYCQRacirg7KEs2svI+9DfBgQ6RiyzWupa2bU/XsDNpA+HDrVV3MtBv9V4Qcp52
         5gKpNpQAxCTHGOL54Novu4ODcrEXzpM/sGSYiqB3EM5mtzL7YqcwcGm30TOzr0DpwU
         sQbxGj8omQHD2JiIurije/ApTrP5AFXpjuXQfc6nIfZI50ecPSRc8EqXph+CyqYmeY
         EwXBoGCIeSoSQ==
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2809414efa9so1093277a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 13:57:51 -0800 (PST)
X-Gm-Message-State: AOJu0YzgWNkJEQRnyNrt35MfshBYtsRKgpnDaINYTzlOw/TOinqdlg3d
        Q++2GaQZEwe0A0opoYTJbg/lZaV9b1RsnRHiqnguVA==
X-Google-Smtp-Source: AGHT+IHQj9Vs+x71xRCK4U1CEmrgLgW3GcU2zfeirQPqpe+dAj0kYj5GZ49GtAN9LiWFuD3fPynnNTVXOQDoFvL1gj4=
X-Received: by 2002:a17:90b:1e4c:b0:27d:5cca:9b69 with SMTP id
 pi12-20020a17090b1e4c00b0027d5cca9b69mr17169313pjb.45.1700171870173; Thu, 16
 Nov 2023 13:57:50 -0800 (PST)
MIME-Version: 1.0
References: <20231106183159.3562879-1-nphamcs@gmail.com> <CAF8kJuMsXUm9=kiL8qPNVfYPzfyq-JWYSH3KraZadjF+myW-2A@mail.gmail.com>
 <CAKEwX=MNKY0UHbxi6Zfwf0KkepYavFaZo8F6LGe5GyyE3U35Jg@mail.gmail.com>
 <CAF8kJuMx4KT9z2RPy8z+snhM6YUtK=kZ1+BdHjKua2jhwFo-XQ@mail.gmail.com>
 <CAKEwX=OpQZhDmCr-a+O0=c8LfPoO0r8y=abpQoKXWcOP+V6yYg@mail.gmail.com> <CAF8kJuNnM_0jDCaAueseiNA1264-MtA0QiQtfjEN1E6aY56MKQ@mail.gmail.com>
In-Reply-To: <CAF8kJuNnM_0jDCaAueseiNA1264-MtA0QiQtfjEN1E6aY56MKQ@mail.gmail.com>
From:   Chris Li <chrisl@kernel.org>
Date:   Thu, 16 Nov 2023 13:57:39 -0800
X-Gmail-Original-Message-ID: <CAF8kJuN5fBBmpOzmR72B5NBmjPNCNk4DALqz=+PKBwQrjvHH2w@mail.gmail.com>
Message-ID: <CAF8kJuN5fBBmpOzmR72B5NBmjPNCNk4DALqz=+PKBwQrjvHH2w@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] workload-specific and memory pressure-driven zswap writeback
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>, mhocko@kernel.org,
        roman.gushchin@linux.dev, Shakeel Butt <shakeelb@google.com>,
        muchun.song@linux.dev, linux-mm <linux-mm@kvack.org>,
        kernel-team@meta.com, LKML <linux-kernel@vger.kernel.org>,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nhat,

I want want to share the high level feedback we discussed here in the
mailing list as well.

It is my observation that each memcg LRU list can't compare the page
time order with other memcg.
It works great when the leaf level memcg hits the memory limit and you
want to reclaim from that memcg.
It works less well on the global memory pressure you need to reclaim
from all memcg. You kind of have to
scan each all child memcg to find out the best page to shrink from. It
is less effective to get to the most desirable page quickly.

This can benefit from a design similar to MGLRU. This idea is
suggested by Yu Zhao, credit goes to him not me.
In other words, the current patch is similar to the memcg page list
pre MGLRU world. We can have a MRLRU
like per memcg zswap shrink list.


Chris

On Wed, Nov 8, 2023 at 6:10=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote:
>
> On Wed, Nov 8, 2023 at 4:28=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrot=
e:
> >
> > Hmm my guess is that I probably sent this out based on an outdated
> > mm-unstable. There has since been a new zswap selftest merged
> > to mm-unstable (written by no other than myself - oh the irony), so
> > maybe it does not apply cleanly anymore with git am.
>
> $ git am -3 patches/zswap-pool-lru/0005
> Applying: selftests: cgroup: update per-memcg zswap writeback selftest
> Using index info to reconstruct a base tree...
> M       tools/testing/selftests/cgroup/test_zswap.c
> Falling back to patching base and 3-way merge...
> Auto-merging tools/testing/selftests/cgroup/test_zswap.c
> $ git am -3 patches/zswap-pool-lru/0006
> Applying: zswap: shrinks zswap pool based on memory pressure
> error: sha1 information is lacking or useless (mm/zswap.c).
> error: could not build fake ancestor
> Patch failed at 0001 zswap: shrinks zswap pool based on memory pressure
> hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
>
> I was able to resolve the conflict on patch 6 by hand though. So I am goo=
d now.
>
> Thanks
>
> Chris
