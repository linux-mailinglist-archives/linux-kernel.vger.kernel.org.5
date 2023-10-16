Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C63C7CAE3F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 17:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233630AbjJPPxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 11:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjJPPxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 11:53:01 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63673AD
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 08:53:00 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c9c145bb5bso301715ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 08:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697471580; x=1698076380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1TOWBV0+RIkpT8pcDO7Atd39X0kSbmghLXKRHM4kosQ=;
        b=dICZq4t0cexqn4kJRHeFjfmU8wr4q5lpjU0pU2PFdZ+erHfJQbHDqsdbV2XmVUEE7O
         PiZXmQnRWx4nswFMjqiKha+2rKxYr/6JxfTXIsqwT3BJYlO6n/Xv/2KEKIHWBD5KVeDW
         +2xqfM6xFudZ+vmwVtBXvuTzp50zCdb9pxit9r88PlJMUTvzVyCm2kMasaw/PuTkJJvZ
         U5DTPjiSO/vRpFY3qAarZbJk5QSk9JPhVBdxX7Iovxz++gU0rVB0mSQdqGEL3hrhsmEp
         jx6474ML2hj/1MQbwu6paHKbylqGSKPrPYvYfMosnDTeZhV3nJeLkM3R3ZkYbqnE9ZZE
         WoYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697471580; x=1698076380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1TOWBV0+RIkpT8pcDO7Atd39X0kSbmghLXKRHM4kosQ=;
        b=Miew2eMbvSXKZhiZW4hFUSAsCm5th6tWysxMb6/qDdfLPFqz+/IbjyJLqK23Df4yYY
         W+NtNAx2H639TW+/6msdLnGaOu/waboSrs3oFyW/2ayD4ttHWq9vWGseQg4SKC80f6ye
         E9WxN/sL2c6SSG7gOp74mXg2ONC3ixGYw2KuPSahwiq9yB32+VMGUosHZfTl4LgNBB8X
         0PA+IMCCL1n7drUq0S48+k3qr3XN29OXfIoIuaBaQxIjwIQ1v0KBS+lRmnNaS6W7gMYK
         kqSgfTCBrWoUjnJzHbepoy/JxsXIW4fcuIT3UI0nfeBQY8zCKjp+CJnlwlRKNqt56awH
         KBjw==
X-Gm-Message-State: AOJu0YzsxKtCSIsrM3a2cWSFzpTWU9TD45ovzwhjnVKqLW4R+/UuR1QO
        DC00PmWo+rHtWTJwYeT66yCbhWn5bd3lPe/Vax4SsA==
X-Google-Smtp-Source: AGHT+IEbEyhGEmjYoHfOOvp0Vt7UUlKejUZXs3gj8zZDD8hpTlCKeFfpkArI07dmgi5mznFED9mqXBEHa8/KQbXw238=
X-Received: by 2002:a17:902:f70b:b0:1c1:efe5:ccf8 with SMTP id
 h11-20020a170902f70b00b001c1efe5ccf8mr277015plo.17.1697471579647; Mon, 16 Oct
 2023 08:52:59 -0700 (PDT)
MIME-Version: 1.0
References: <20231016132812.63703-1-wuyun.abel@bytedance.com> <20231016132812.63703-3-wuyun.abel@bytedance.com>
In-Reply-To: <20231016132812.63703-3-wuyun.abel@bytedance.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 16 Oct 2023 08:52:48 -0700
Message-ID: <CALvZod6FRH2cp2D2uECeAesGY575+mE_iyFwaXVJMbfk1jvcgQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/3] sock: Fix improper heuristic on raising memory
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
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

On Mon, Oct 16, 2023 at 6:28=E2=80=AFAM Abel Wu <wuyun.abel@bytedance.com> =
wrote:
>
> Before sockets became aware of net-memcg's memory pressure since
> commit e1aab161e013 ("socket: initial cgroup code."), the memory
> usage would be granted to raise if below average even when under
> protocol's pressure. This provides fairness among the sockets of
> same protocol.
>
> That commit changes this because the heuristic will also be
> effective when only memcg is under pressure which makes no sense.
> Fix this by reverting to the behavior before that commit.
>
> After this fix, __sk_mem_raise_allocated() no longer considers
> memcg's pressure. As memcgs are isolated from each other w.r.t.
> memory accounting, consuming one's budget won't affect others.
> So except the places where buffer sizes are needed to be tuned,
> allow workloads to use the memory they are provisioned.
>
> Fixes: e1aab161e013 ("socket: initial cgroup code.")
> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>

Acked-by: Shakeel Butt <shakeelb@google.com>
