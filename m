Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F077A0BD9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 19:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238974AbjINRgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 13:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjINRgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 13:36:45 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F295B1BFE
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 10:36:40 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c382f23189so13235ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 10:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694713000; x=1695317800; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ljbrHfpo2IKe26opU5ehmoNQnl15X51TY3BJK0gEGYU=;
        b=qmReZO2Bb4EeDD8PD3bNjkvqwYj4p9DvDkLEd0v88Rlhw60VWyPmfHMZe2xl7GnwVv
         zTLHAnXZit7yew1KB+QXuasZRjmbdfZB8MJwBG/dt6+VJydPqJ90RlMULPiU23He9Wvk
         0xWofpItOubu4YAq15TgH3CxGohX16qekNcKm2wz8KFfXdA2vv5zg2dXsgiaPINlsoxC
         PyJQmeLDu50whdZZM4U/9KZKq1x9gfXXoFgkMImQ1BcWbshnWMvffbE7Zdi6rNgJY01g
         d8QtehQ3t8KbqlT9II//3izlGw88QwDw4eg2lSWugnxCeSoaThv1QDsqpsuRo2zjZjP5
         eE2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694713000; x=1695317800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ljbrHfpo2IKe26opU5ehmoNQnl15X51TY3BJK0gEGYU=;
        b=YcX2jsnuail5BByrCXloCvq/27wiGnzMarPMjuSHFYT2R8ijHjydOSQDHHhWZM1O0i
         j84npTfuda7elCvM+hWPF+xZlIqZdmNzlI6ko51tWY2cMgRZHGJjfEQilRXlZ0QNCCU0
         wghxcXefTBVgO72EMcrk1cFcc/oHu2vUhpCpo8xvR33GTFd4CVriWFAry8FC3tcNJg/+
         k6X660Lw4m88quDRf3aYXOZ3d9H+Rij1RQGYH+VW6umzskNcnZNRIJqie+uAZ+GFbH9a
         moqckelUujcXGOxIczV/e/Gn/p7ER7XbEcNtBzz0PSsOnCoHmQho6E+/+2MOgLEq7cFI
         YjSA==
X-Gm-Message-State: AOJu0YwBUUBfS6Rft/dxDWgdSmyq/amuLd313eChRoo7pRwlMfNkHN83
        mTTl9eUEus33oG8CpLRoR+Q9qiph1WeFSo9M/UZxFilfTyQ1leO8SHs=
X-Google-Smtp-Source: AGHT+IEnHyABp75QjIESjqQSDnfuRNqfnRAKK6pkWDxjKA8uSqkrYfi89QWWeiyMVyuDLuMgaNM2S1TAk6qoO1Sctss=
X-Received: by 2002:a17:902:a3c8:b0:1c1:efe5:ccf8 with SMTP id
 q8-20020a170902a3c800b001c1efe5ccf8mr9658plb.17.1694713000337; Thu, 14 Sep
 2023 10:36:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230913073846.1528938-1-yosryahmed@google.com> <20230913073846.1528938-4-yosryahmed@google.com>
In-Reply-To: <20230913073846.1528938-4-yosryahmed@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 14 Sep 2023 10:36:28 -0700
Message-ID: <CALvZod6j5E2MXFz463LRcrP6XY8FedzLUKW88c=ZY39B6mYyMA@mail.gmail.com>
Subject: Re: [PATCH 3/3] mm: memcg: optimize stats flushing for latency and accuracy
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>, kernel-team@cloudflare.com,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 12:38=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
> Stats flushing for memcg currently follows the following rules:
> - Always flush the entire memcg hierarchy (i.e. flush the root).
> - Only one flusher is allowed at a time. If someone else tries to flush
>   concurrently, they skip and return immediately.
> - A periodic flusher flushes all the stats every 2 seconds.
>
> The reason this approach is followed is because all flushes are
> serialized by a global rstat spinlock. On the memcg side, flushing is
> invoked from userspace reads as well as in-kernel flushers (e.g.
> reclaim, refault, etc). This approach aims to avoid serializing all
> flushers on the global lock, which can cause a significant performance
> hit under high concurrency.
>
> This approach has the following problems:
> - Occasionally a userspace read of the stats of a non-root cgroup will
>   be too expensive as it has to flush the entire hierarchy [1].

This is a real world workload exhibiting the issue which is good.

> - Sometimes the stats accuracy are compromised if there is an ongoing
>   flush, and we skip and return before the subtree of interest is
>   actually flushed. This is more visible when reading stats from
>   userspace, but can also affect in-kernel flushers.

Please provide similar data/justification for the above. In addition:

1. How much delayed/stale stats have you observed on real world workload?

2. What is acceptable staleness in the stats for your use-case?

3. What is your use-case?

4. Does your use-case care about staleness of all the stats in
memory.stat or some specific stats?

5. If some specific stats in memory.stat, does it make sense to
decouple them from rstat and just pay the price up front to maintain
them accurately?

Most importantly please please please be concise in your responses.

I know I am going back on some of the previous agreements but this
whole locking back and forth has made in question the original
motivation.

thanks,
Shakeel
