Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D826A7DDAA2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 02:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377022AbjKABdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 21:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjKABdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 21:33:40 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6D5103
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 18:33:38 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9c53e8b7cf4so934539566b.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 18:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698802417; x=1699407217; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I6ffa7A3wLh3lHfjxCgqrmzuSoes0eWTG/5nW8WNz6A=;
        b=UyrJRwHgbrpbPNO7fDvSWbXc6z2SoNGhCnsT1TBzS9iRKGQS5/kSPfNNFS1+P79t+c
         2I86dmGiq8N3qK9rAM0t8wOzHGaBYNyG//imqlOGsSg5x//aga8R91NCKH/FMDteluWp
         eMWb6eMaST1/39n6HnjosqbZ66fZiTT91wgNDJtVjFn4aJ8QgGywa7YReNiMCXJnWghY
         nrrhyEB5STyURG1QOVLiYDOAvpw3vGaLgcgbawNeGTU5ZG71lcaO5VWpF5WRcDaiDgbW
         GDfRCc/feE/QT5TkHShzSIKQwgyCEL39kRQSAdhjkEq2/BwRh4NPwEIjmVZX8B+lzqTF
         Skow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698802417; x=1699407217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I6ffa7A3wLh3lHfjxCgqrmzuSoes0eWTG/5nW8WNz6A=;
        b=Us+z+7huSI773inEWuifY3EXMm5QqazlIugtpJMbGsCshO1ailZZsN1QT1NHt2StyY
         wDGdz80Q/oBRxQORkbQjArPssxFLSm8BkI9iDoFtuo428cDwphhjR/SeaJERP2TDjfzB
         UgFwnnK2xhVnIZeeZk/ZHjH9OqBb0ncCgXDAHQRWt9rG69539tb+5JG+e4WAy7JkrLaP
         VwfXYelXob1c6F4qsu2XvC49mUdF2Ya3WtTUaKe1Kzsbz3dKBXOZJU3N/HxnKWdKdCck
         NAtJ34fPJBaJnXyJrHC5vRW9qacvIQthm8VZjixlMfLGLfcea4Dftp9BXutKmf1Qk+A3
         Ekdg==
X-Gm-Message-State: AOJu0YwpjvlDEY5SINv63vuJTrDAjgxLO1Xo9LheMxgAIXCi7FLG07ED
        lBQMnKL+X8PMY2PKEpNWYo2n4NQbgZja2s7OxzZfaywuUUVLtNCPZw8=
X-Google-Smtp-Source: AGHT+IFp5uWOCDd+y49W4YB9NUjprY7zYweWsg72q+o0MprOTzFU+1QnJYpY+WSiq89COnmHW+8N/Moykp41iaDxscE=
X-Received: by 2002:a17:907:a44:b0:9d5:d900:400 with SMTP id
 be4-20020a1709070a4400b009d5d9000400mr709796ejc.76.1698802416560; Tue, 31 Oct
 2023 18:33:36 -0700 (PDT)
MIME-Version: 1.0
References: <20231024203302.1920362-3-nphamcs@gmail.com> <20231101012614.186996-1-nphamcs@gmail.com>
In-Reply-To: <20231101012614.186996-1-nphamcs@gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 31 Oct 2023 18:32:57 -0700
Message-ID: <CAJD7tkZV9NaPUzjZYQAx=D-vDEXZH46=Dn5zEuMHnsybT+HLAw@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] zswap: make shrinking memcg-aware
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org,
        cerasuolodomenico@gmail.com, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, chrisl@kernel.org, linux-mm@kvack.org,
        kernel-team@meta.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 6:26=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> cc-ing Johannes, Roman, Shakeel, Muchun since you all know much more
> about memory controller + list_lru reparenting logic than me.
>
> There seems to be a race between memcg offlining and zswap=E2=80=99s
> cgroup-aware LRU implementation:
>
> CPU0                            CPU1
> zswap_lru_add()                 mem_cgroup_css_offline()
>     get_mem_cgroup_from_objcg()
>                                     memcg_offline_kmem()
>                                         memcg_reparent_objcgs()
>                                         memcg_reparent_list_lrus()
>                                             memcg_reparent_list_lru()
>                                                 memcg_reparent_list_lru_n=
ode()
>     list_lru_add()
>                                                 memcg_list_lru_free()
>
>
> Essentially: on CPU0, zswap gets the memcg from the entry's objcg
> (before the objcgs are reparented). Then it performs list_lru_add()
> after the list_lru entries reparenting (memcg_reparent_list_lru_node())
> step. If the list_lru of the memcg being offlined has not been freed
> (i.e before the memcg_list_lru_free() call), then the list_lru_add()
> call would succeed - but the list will be freed soon after. The new
> zswap entry as a result will not be subjected to future reclaim
> attempt. IOW, this list_lru_add() call is effectively swallowed. And
> worse, there might be a crash when we invalidate the zswap_entry in the
> future (which will perform a list_lru removal).
>
> Within get_mem_cgroup_from_objcg(), none of the following seem
> sufficient to prevent this race:
>
>     1. Perform the objcg-to-memcg lookup inside a rcu_read_lock()
>     section.
>     2. Checking if the memcg is freed yet (with css_tryget()) (what
>     we're currently doing in this patch series).
>     3. Checking if the memcg is still online (with css_tryget_online())
>     The memcg can still be offlined down the line.
>
>
> I've discussed this privately with Johannes, and it seems like the
> cleanest solution here is to move the reparenting logic down to release
> stage. That way, when get_mem_cgroup_from_objcg() returns,
> zswap_lru_add() is given an memcg that is reparenting-safe (until we
> drop the obtained reference).

The objcgs hold refs to the memcg, which are dropped during
reparenting. How can we do reparenting in the release stage, which
IIUC happens after all refs are dropped?
