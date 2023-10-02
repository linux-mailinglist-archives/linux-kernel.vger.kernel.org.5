Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF7A7B5CA6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 23:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236578AbjJBVrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 17:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjJBVrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 17:47:39 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDA3C9
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 14:47:36 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99bf3f59905so31782266b.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 14:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696283255; x=1696888055; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qUXweOvL2cKobyvxITX1IMrb0VKCh7MXpsaLmhdNmMs=;
        b=GtJjQvSle0YSESu2pRvEeDzvIWnQ/iuCljF2hqMDeDrBPq+0P/CDv7s3bv6X3aZTrP
         ymW1S59OpNz497FqAXBGcy/0hN1BNgLN9I4BE7Td/3tpyJkQiAGURCxCWRNm8WixF+uq
         r++Qo2k+jIV380yRCXoFeHUf9aYuzqVQh0YUbXV16gZZExqXyTp0hQ/QKkuYXGAXgIDg
         tmTCgue/H/XoEzOOM3YS1VotX5vv00y/dxUprTpvbAahUAVddBsl2r9edakgG55lj8mC
         1Eeu0+yWCyEEUevjuGI+tI1LCkeSRWLWphjmKk3UbF6+Vqihh2fzVWjJtNua89R3shfZ
         AaLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696283255; x=1696888055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qUXweOvL2cKobyvxITX1IMrb0VKCh7MXpsaLmhdNmMs=;
        b=FzH3Gf4TkU151iurXEqCfvUzLn+lyqXESQPglp5DLwBAATQ0+2SW6WInXfg0ucvHv5
         BDBrXjsMXGY3+s+xDuwwX/kaHHV7JI5xX3/DigNcI/Go7k0WRcvd9JUcV+x0zvVHprti
         iJmExxd3O2MbtmKMCs2J2DdCfO12XrHrLwTbGi031cvpTeRPvS6QpAXxdziLv4WiYreZ
         O2tHwTkiSeNgIiJ63RET3c2/HAKI7qL8eTHsd0NZB6l6kc9pH+Zlhpthq/w47Dv4Xutp
         hrlAn6je23AUUCVxLZkFapWpgOGe3TBL+ecboquOXCMw3yZg9LE7PawKcSnijPO3ycz7
         cvFA==
X-Gm-Message-State: AOJu0YzyCnqKfnNh8S8AIQDHiVu8I/8w1+1CeLY4sEEf6Yopj+NeCGdt
        nxkMGkIYlpcJiuBCje3zhzmc0LwRpMOv3Z2KT0td8w==
X-Google-Smtp-Source: AGHT+IFExVnYQeOL0S7tUxok36j2MQuNMxoTW2y2dC+SuhEvZemflGEmbM8LblgQ7n1eNE0nIpgHLyezX2kGUrH3PyQ=
X-Received: by 2002:a17:907:b00d:b0:9ad:c763:bc7a with SMTP id
 fu13-20020a170907b00d00b009adc763bc7amr10383740ejc.23.1696283254505; Mon, 02
 Oct 2023 14:47:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230921081057.3440885-1-yosryahmed@google.com>
In-Reply-To: <20230921081057.3440885-1-yosryahmed@google.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 2 Oct 2023 14:46:58 -0700
Message-ID: <CAJD7tkYJwaKgGaDygbDwmdZSBdz8wq4MNarjhge8v9153Yh45w@mail.gmail.com>
Subject: Re: [PATCH 0/5] mm: memcg: subtree stats flushing and thresholds
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>, kernel-team@cloudflare.com,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Thu, Sep 21, 2023 at 1:11=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> This series attempts to address shortages in today's approach for memcg
> stats flushing, namely occasionally stale or expensive stat reads. The
> series does so by changing the threshold that we use to decide whether
> to trigger a flush to be per memcg instead of global (patch 3), and then
> changing flushing to be per memcg (i.e. subtree flushes) instead of
> global (patch 5).
>
> Patch 3 & 5 are the core of the series, and they include more details
> and testing results. The rest are either cleanups or prep work.
>
> This series replaces the "memcg: more sophisticated stats flushing"
> series [1], which also replaces another series, in a long list of
> attempts to improve memcg stats flushing. It is not a v2 as it is a
> completely different approach. This is based on collected feedback from
> discussions on lkml in all previous attempts. Hopefully, this is the
> final attempt.
>
> [1]https://lore.kernel.org/lkml/20230913073846.1528938-1-yosryahmed@googl=
e.com/
>
> Yosry Ahmed (5):
>   mm: memcg: change flush_next_time to flush_last_time
>   mm: memcg: move vmstats structs definition above flushing code
>   mm: memcg: make stats flushing threshold per-memcg
>   mm: workingset: move the stats flush into workingset_test_recent()
>   mm: memcg: restore subtree stats flushing
>
>  include/linux/memcontrol.h |   8 +-
>  mm/memcontrol.c            | 269 +++++++++++++++++++++----------------
>  mm/vmscan.c                |   2 +-
>  mm/workingset.c            |  37 +++--
>  4 files changed, 181 insertions(+), 135 deletions(-)
>
> --
> 2.42.0.459.ge4e396fd5e-goog
>

Friendly ping for feedback on this approach :)
