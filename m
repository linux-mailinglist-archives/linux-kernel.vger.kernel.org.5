Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC347E6250
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 03:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbjKICmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 21:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjKICmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 21:42:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7CD2590
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 18:42:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBF8EC433C7
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 02:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699497731;
        bh=TS4NArmNX08QlaEz4GZTMc0gnSDo8pxfWNHZHMsNNlk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=E1/PhaLRfJf+zxfg9ScH+/8bdDuFGGbkbizoW9oCiRkj5alN2svu6m/17pXKGv6WL
         DnchPn3iFBVM0HDAh4+F3Dt3vRFMIaX1snqQEZSKmNBnV6NDtwfG0f6KbXpfZBnWs0
         /ohx4fPRGkIrc2BPwVUzIr7FyWkjnI4/THZoMbeVOIhSFASSsCyJfEan5cTTWbFUkx
         3gr6BROLw/aP4F/uwrTCf2LHW2o6LRjY03t+Foz4pPUn7+r2A2GwZOX4xXA7zLFIZZ
         EcAW/EnTknByLUCYqFkECMha+EC4o2etMF80zzAqLDnbechjSGWaRTgedajl78xJ0A
         Rf3NigEOk/nhw==
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-7ba6fa81aabso143616241.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 18:42:11 -0800 (PST)
X-Gm-Message-State: AOJu0Yyjt4yIp6NRKi5+6r2tv/I4sGxt0CBwjILb8Ijuba4wypAd4VEJ
        MRmdQwQcB4PG/wCPz5UvhgcNLmVKQJwiJ2wBrCSdDg==
X-Google-Smtp-Source: AGHT+IGcIFSAFrs0qInF0exuNbYq2osAesSeB/kePPuC9Ov8rDxwXdDduiIXr8vTvgnCEBXZl0IY9dxfmxJYahnastI=
X-Received: by 2002:a17:90b:1c88:b0:27c:f80a:2c8a with SMTP id
 oo8-20020a17090b1c8800b0027cf80a2c8amr374608pjb.0.1699497709899; Wed, 08 Nov
 2023 18:41:49 -0800 (PST)
MIME-Version: 1.0
References: <20231102234236.1784543-1-nphamcs@gmail.com> <CAJD7tkapfHVvF1KCm4iUDWGP0n5zV3GBcNAGDiYNHrpuODPPqQ@mail.gmail.com>
 <CAKEwX=MunYMKQXsV58vBXROKnJFDhViCpQgC7RnrLExa_U=n2g@mail.gmail.com>
In-Reply-To: <CAKEwX=MunYMKQXsV58vBXROKnJFDhViCpQgC7RnrLExa_U=n2g@mail.gmail.com>
From:   Chris Li <chrisl@kernel.org>
Date:   Wed, 8 Nov 2023 18:41:38 -0800
X-Gmail-Original-Message-ID: <CAF8kJuPgWjim82+HmEgkkWrDNwi2co-3ay-35fjoLb8-k9rNXQ@mail.gmail.com>
Message-ID: <CAF8kJuPgWjim82+HmEgkkWrDNwi2co-3ay-35fjoLb8-k9rNXQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3] zswap: memcontrol: implement zswap writeback disabling
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>, akpm@linux-foundation.org,
        tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cerasuolodomenico@gmail.com, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, hughd@google.com, corbet@lwn.net,
        konrad.wilk@oracle.com, senozhatsky@chromium.org, rppt@kernel.org,
        linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        david@ixit.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nhant,

On Fri, Nov 3, 2023 at 12:24=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote=
:
> >
> > Would it be more convenient if the initial value is inherited from the
> > parent (the root starts with true)?
> >
> > I can see this being useful if we want to set it to false on the
> > entire machine or one a parent cgroup, we can set it before creating
> > any children instead of setting it to 0 every time we create a new
> > cgroup.
>
> I'm not 100% sure about the benefit or have a strong opinion one way
> or another, but this sounds like a nice-to-have detail to me, and a relat=
ively
> low cost one (both in effort and at runtime) at that too.
>
> Propagating the change everytime we modify the memory.zswap.writeback
> value of the ancestor might be data race-prone (and costly, depending on
> how big the cgroup subtree is), but this is just a one-time-per-cgroup
> propagation (at the new cgroup creation time).

I think Yosary was suggesting inheriting the initial value from
parents. That is just one level look up when you create the new
cgroup, using the parent value as default. No recursive.
What you described above seems different to me. I understand what you
are suggesting is that writing to the parent cgroup will recursively
write to all child cgroup.
>
> Can anyone come up with a failure case for this change, or why it might b=
e
> a bad idea?

I would suggest against recursive changing value behavior.
What if you want the parent but also want the child to keep its value
not changed? Every change to the parent will have to go through the
child to flip it back.
Inherit from the parent seems fine.

Chris
