Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBDF7F24EC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 05:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbjKUEtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 23:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKUEts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 23:49:48 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872A9CF
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 20:49:44 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1cf5ceadfd8so130865ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 20:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700542184; x=1701146984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ci0fDn2VKn2ROb4P5+ApgEIrDRCxD8DQOtt7YsYQPr8=;
        b=Su4WUHIMCW5vgmjCrvzfT1brcn69WD4tmllN/No3RpWiu/dY+VIm69olbgkXfqmL8/
         gOJpYAs43dvdKXRxpkrVCt+OmvyRdF4Tui4hhE3VHIHKe/rb7SbhPYtfgMN/I1YSHbJH
         PG+L+lS2ynwiZ6Vu3ABEUDoF0vNHqWTuM5ALk4AhSCFqvoo2qMipExgbJKOecAyq6hb6
         5GBmYqhpr6MjNVsy2cRWILQQxFlUcfPtw6yTX2u5KPcas+jcwU8OKDaqc/cXDPaKHWD6
         URg/b4ZfloAQTGexxpDjAiOCsQWpDeirCYzurENszf+fHTaGDiBj1KfK/2CwDsAbggBP
         P/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700542184; x=1701146984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ci0fDn2VKn2ROb4P5+ApgEIrDRCxD8DQOtt7YsYQPr8=;
        b=R/l7x/xvGeGxHhNcLjSvot0z1HoTmbz8QZmN2Za0WdbAWIgVUskksqNKice/yrAyam
         JYoIfxfJFjiHY1jHiYy9CPa0gXx3dxMydgJ+ioeDF13do/0iiNkqfJr6+gNm5A1m0p1E
         DkJ52DqjRwsn54a6Ns+j6sOAewFiicp4xMIUc523nCnhFFnoIPCubipV0lsaeYoOxWg/
         azeyeCccQ1CgRUGyKVhFMAE474iaslq+vyeW2G+4DgAF+ixXGi3yvMFqVLlM0cdE0hZ0
         fVOvIGvX130c1T/oaHbqB1V5dP9Yx8n/9Gnm8SDmHYJUY+j5gvXOzVdXYrBGTIVTqLYE
         nTLA==
X-Gm-Message-State: AOJu0YwBP4CfgybE+Ywl0x21d/RLoxbMElHcBtnPgNJF+LOLLFaXknPd
        EF05wB5Zc1x5fCIJbCBV0lYEqjLGeYEC2ip14oj9Yg==
X-Google-Smtp-Source: AGHT+IEjrSf5kIzKqR8y96cakBbXvSTNzic/DeMBLkOBk4msBIIG12CS40E/lkAesfcKoKMOnN0ye5jmEfxbmJlxJ94=
X-Received: by 2002:a17:902:c454:b0:1cf:6d46:9f2b with SMTP id
 m20-20020a170902c45400b001cf6d469f2bmr136702plm.23.1700542183669; Mon, 20 Nov
 2023 20:49:43 -0800 (PST)
MIME-Version: 1.0
References: <20230823131350.114942-1-alexandru.elisei@arm.com> <20230823131350.114942-21-alexandru.elisei@arm.com>
In-Reply-To: <20230823131350.114942-21-alexandru.elisei@arm.com>
From:   Peter Collingbourne <pcc@google.com>
Date:   Mon, 20 Nov 2023 20:49:32 -0800
Message-ID: <CAMn1gO67Lz_Xw5SCrq3fF4rOCSw3sXYK8qC77TTGnJeWd0b0Sg@mail.gmail.com>
Subject: Re: [PATCH RFC 20/37] mm: compaction: Reserve metadata storage in compaction_alloc()
To:     Alexandru Elisei <alexandru.elisei@arm.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev,
        maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
        yuzenghui@huawei.com, arnd@arndb.de, akpm@linux-foundation.org,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, mhiramat@kernel.org,
        rppt@kernel.org, hughd@google.com, steven.price@arm.com,
        anshuman.khandual@arm.com, vincenzo.frascino@arm.com,
        david@redhat.com, eugenis@google.com, kcc@google.com,
        hyesoo.yu@samsung.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org
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

Hi Alexandru,

On Wed, Aug 23, 2023 at 6:16=E2=80=AFAM Alexandru Elisei
<alexandru.elisei@arm.com> wrote:
>
> If the source page being migrated has metadata associated with it, make
> sure to reserve the metadata storage when choosing a suitable destination
> page from the free list.
>
> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> ---
>  mm/compaction.c | 9 +++++++++
>  mm/internal.h   | 1 +
>  2 files changed, 10 insertions(+)
>
> diff --git a/mm/compaction.c b/mm/compaction.c
> index cc0139fa0cb0..af2ee3085623 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -570,6 +570,7 @@ static unsigned long isolate_freepages_block(struct c=
ompact_control *cc,
>         bool locked =3D false;
>         unsigned long blockpfn =3D *start_pfn;
>         unsigned int order;
> +       int ret;
>
>         /* Strict mode is for isolation, speed is secondary */
>         if (strict)
> @@ -626,6 +627,11 @@ static unsigned long isolate_freepages_block(struct =
compact_control *cc,
>
>                 /* Found a free page, will break it into order-0 pages */
>                 order =3D buddy_order(page);
> +               if (metadata_storage_enabled() && cc->reserve_metadata) {
> +                       ret =3D reserve_metadata_storage(page, order, cc-=
>gfp_mask);

At this point the zone lock is held and preemption is disabled, which
makes it invalid to call reserve_metadata_storage.

Peter

> +                       if (ret)
> +                               goto isolate_fail;
> +               }
>                 isolated =3D __isolate_free_page(page, order);
>                 if (!isolated)
>                         break;
> @@ -1757,6 +1763,9 @@ static struct folio *compaction_alloc(struct folio =
*src, unsigned long data)
>         struct compact_control *cc =3D (struct compact_control *)data;
>         struct folio *dst;
>
> +       if (metadata_storage_enabled())
> +               cc->reserve_metadata =3D folio_has_metadata(src);
> +
>         if (list_empty(&cc->freepages)) {
>                 isolate_freepages(cc);
>
> diff --git a/mm/internal.h b/mm/internal.h
> index d28ac0085f61..046cc264bfbe 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -492,6 +492,7 @@ struct compact_control {
>                                          */
>         bool alloc_contig;              /* alloc_contig_range allocation =
*/
>         bool source_has_metadata;       /* source pages have associated m=
etadata */
> +       bool reserve_metadata;
>  };
>
>  /*
> --
> 2.41.0
>
