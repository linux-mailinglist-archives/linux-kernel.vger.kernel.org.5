Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92DF7765B3E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 20:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbjG0SPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 14:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjG0SPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 14:15:08 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9882D64
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 11:15:07 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-98de21518fbso168389866b.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 11:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690481706; x=1691086506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cDXv3GJoBhlQr8pJG4ewngE2yTfvQ54xOjhSQv72UGM=;
        b=riHjHppP5NEozcwiEl5iB7KyWW+jJ8XGwJB6AaeCCX81SAoydQGvrnLtUth9zm28kg
         GdNWiC0B3pWMzmKZC9XzE89drFEXtLyLZT70sTmA+Jf2ch+1jmAib07EusGuLCLhpdkw
         5GiYJ1Qa4av/NDXOrUdR2bK2twvH88e5Q1/Blqaq8asjz+9TvTon2hkoC2BQTe5UcIt7
         Q2Qas0SyPR8GUaQyFP040jmAp/PN8srIJDDhqvkYmfODXqGVi16LL+ZyhUSFgb49KFey
         HR0fvNYdpn/suObjC7F2359RSzItBB8iqPCm1h/39mSqel1YrrOu7CrNrUOamyd7v/AR
         nA6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690481706; x=1691086506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cDXv3GJoBhlQr8pJG4ewngE2yTfvQ54xOjhSQv72UGM=;
        b=F/hFxqI8PD/3sySwrp14Bm7/mgdR/saIWkCFG/5zpxNqlXLqV9h7GKp3EqBNcVzYGE
         taKJoetAs9USXlQYhGiwKbjfPhbUkZ24lkhCwNyeZWAZzYKrhtT61lQ43tyKjRU2nbCX
         p/QMvtpjOSLq98Bl4dxcc2jcMkvPc2i9L81E1b83w06EHjqDKLhrLtVfJ5iyjVnRC36F
         t64NHM+vGv0xv3ATC/mVgTCdmLnmC/wAtsvA+FQ73p4BrHNvTDfap1JjDeZdcQlhgIG8
         l0AddO8KYkjkWbxM3O3QUX88Yusvm0uPV68oiwz1HjcLRQeCPNvA/OGVH2SYdTXq2hDf
         Ymyw==
X-Gm-Message-State: ABy/qLbnhO3MSyH8Rk0OEuuuMuBRL7vuGMLVqoav8I0/m4Xqwb6Q7o49
        o6QRDdY9T6/aeOeByGpZYEq3OW1AeT83YXp2tgtVxQ==
X-Google-Smtp-Source: APBJJlEVxmSgSqqQ8XGRbfXYOgqCkt9UjQRI0/mK5ZuVzQyFMrcfTJN87jfsvbkdR97fG3091Oa9xERnN3FI3L9gjow=
X-Received: by 2002:a17:906:59:b0:993:dd1d:8251 with SMTP id
 25-20020a170906005900b00993dd1d8251mr2807834ejg.28.1690481705936; Thu, 27 Jul
 2023 11:15:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230727162343.1415598-1-hannes@cmpxchg.org> <20230727162343.1415598-3-hannes@cmpxchg.org>
In-Reply-To: <20230727162343.1415598-3-hannes@cmpxchg.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 27 Jul 2023 11:14:29 -0700
Message-ID: <CAJD7tkbiYMjricUHA_H5JEMOd7KkJvPDfU5ML1R8sVZXkS9CPg@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm: zswap: tighten up entry invalidation
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nhat Pham <nphamcs@gmail.com>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
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

On Thu, Jul 27, 2023 at 9:23=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> Removing a zswap entry from the tree is tied to an explicit operation
> that's supposed to drop the base reference: swap invalidation,
> exclusive load, duplicate store. Don't silently remove the entry on
> final put, but instead warn if an entry is in tree without reference.
>
> While in that diff context, convert a BUG_ON to a WARN_ON_ONCE. No
> need to crash on a refcount underflow.
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

I have always found it confusing that we explicitly remove the zswap
entry from the entry in the contexts you mentioned, yet we have
zswap_rb_erase() called in zswap_entry_put(). In fact, I think in some
contexts this leads to zswap_rb_erase() being called unnecessarily
twice on the same entry (e.g. once from invalidation, then once again
when an outstanding local ref is dropped). It's probably harmless with
the current implementation, but such a design can easily go wrong.

Thanks for the cleanup, it would be interesting to see if this warning
is actually fired.

Reviewed-by: Yosry Ahmed <yosryahmed@google.com>

> ---
>  mm/zswap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index e123b1c7981c..e34ac89e6098 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -402,9 +402,9 @@ static void zswap_entry_put(struct zswap_tree *tree,
>  {
>         int refcount =3D --entry->refcount;
>
> -       BUG_ON(refcount < 0);
> +       WARN_ON_ONCE(refcount < 0);
>         if (refcount =3D=3D 0) {
> -               zswap_rb_erase(&tree->rbroot, entry);
> +               WARN_ON_ONCE(!RB_EMPTY_NODE(&entry->rbnode));
>                 zswap_free_entry(entry);
>         }
>  }
> --
> 2.41.0
>
