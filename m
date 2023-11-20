Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB197F1D35
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 20:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjKTTSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 14:18:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232525AbjKTTKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 14:10:42 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB06F9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 11:10:38 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9ffb5a4f622so134890966b.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 11:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700507437; x=1701112237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m2uesSr1RZAG/avk1Qh8AUkPhBEOaB3euOWyklILHFo=;
        b=TdY+gnjLRFrp6ovIbujZESoLWWIu19mMJo7qQIsMen8NeJ5HKVfP/vvCWGO3TzDUsH
         eBQmUPzXriW2+yC5nBjmRiRDcjmpjVbefM+ry2/JJOaCURBpCUVc8qzIMzATGN/JYpR/
         WsJF7ZY/1vH735csc1fcFpChEzu8Tt1u7kgBiN932M27iCc66i4AnzU2aC0h46r3Kd1n
         Q/tQzV6jR1Q6nTiwYeMOoxG+p4S4xHvkKhMHbWynCuEv22Sqf8yuH/b2Sn6SXWdU3Sjo
         Ul/hUwcUP+cHp/+3+g4E7QmuuL+sda2xo7uOsezvVW9+c2HqrftG6SxEo4Z87lWsLzSy
         Ax4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700507437; x=1701112237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m2uesSr1RZAG/avk1Qh8AUkPhBEOaB3euOWyklILHFo=;
        b=k/D4oJCL5UPDS+GrWNLi8IjEiQk6EV/AE5OWbzGDvAScp9WX8e96ahnKtZ3V3MaHi4
         AL5uw5Y91xTAJVdgnMPHqLXjSsqTDLkIzPy+t2lDB0tAFyZrUvOOmLMDCYAkyvBR9V58
         D/TJxt46bKw6FS76k7RsqLGpG10jrlaju2drYQXLivL3zAX1LS2EB8vGl58EbMxO6auf
         Mp11AoFLV8w49lodzBj/U2Ua26lDAYMzINUXBIpnJ5TNwzpIIbDC84hhYgMlGL8itFnH
         bWy1V5WIL0cEgrL+iJxNY5aCMRT/fXKWuSv+jM3pf81ANisZueQr3/ml2idQBwsSkxsk
         Ub6w==
X-Gm-Message-State: AOJu0Yx2iGZ3Etrn4GyoUffeGK7qiIciQ4PxpvOcpJPyB3XPqTlT8pIB
        4aGILVCT49CGKvVywQOI03qC5ncvMX8tZIluZg29pQ==
X-Google-Smtp-Source: AGHT+IGN3CuWMRbRGYyiy4VguhASYZXTkUCRpw8AZsUGWsrdAUs4cau/J/ydxAbEfu7eBcEbxLbMo80RdseTX4rHVlY=
X-Received: by 2002:a17:906:5619:b0:9c4:b8c9:1bf4 with SMTP id
 f25-20020a170906561900b009c4b8c91bf4mr6269527ejq.19.1700507436601; Mon, 20
 Nov 2023 11:10:36 -0800 (PST)
MIME-Version: 1.0
References: <20231119194740.94101-1-ryncsn@gmail.com>
In-Reply-To: <20231119194740.94101-1-ryncsn@gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 20 Nov 2023 11:09:58 -0800
Message-ID: <CAJD7tkYXcQkTZkUnAz89dR0O1YmEUr29UFeg3142t6Y09aaSpg@mail.gmail.com>
Subject: Re: [PATCH 00/24] Swapin path refactor for optimization and bugfix
To:     Kairui Song <kasong@tencent.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
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

On Sun, Nov 19, 2023 at 11:48=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wro=
te:
>
> From: Kairui Song <kasong@tencent.com>
>
> This series tries to unify and clean up the swapin path, fixing a few
> issues with optimizations:
>
> 1. Memcg leak issue: when a process that previously swapped out some
>    migrated to another cgroup, and the origianl cgroup is dead. If we
>    do a swapoff, swapped in pages will be accounted into the process
>    doing swapoff instead of the new cgroup. This will allow the process
>    to use more memory than expect easily.
>
>    This can be easily reproduced by:
>    - Setup a swap.
>    - Create memory cgroup A, B and C.
>    - Spawn process P1 in cgroup A and make it swap out some pages.
>    - Move process P1 to memory cgroup B.
>    - Destroy cgroup A.
>    - Do a swapoff in cgroup C
>    - Swapped in pages is accounted into cgroup C.
>
>    This patch will fix it make the swapped in pages accounted in cgroup B=
.
>

I guess this only works for anonymous memory and not shmem, right?

I think tying memcg charges to a process is not something we usually
do. Charging the pages to the memcg of the faulting process if the
previous owner is dead makes sense, it's essentially recharging the
memory to the new owner. Swapoff is indeed a special case, since the
faulting process is not the new owner, but an admin process or so. I
am guessing charging to the new memcg of the previous owner might make
sense in this case, but it is a change of behavior.
