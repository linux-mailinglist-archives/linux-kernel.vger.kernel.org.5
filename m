Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E335D7858BF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 15:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235629AbjHWNQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 09:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235619AbjHWNQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:16:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4461E58
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 06:15:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D90266219
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 13:15:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96869C433C9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 13:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692796521;
        bh=ITiJW3pew9ske5WY6kVIe2IstP+LoVkUUlpTWStaXq0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=h7vhpCA5AFJLhJRvAyKHmUbxcT9PcThTSGwi6zf2AbLwEoFjb08jOgSa0YxL/29I0
         x2cn9lVPkteBoSiVwY/KMP4IJ1PMVWP/Nbsi/vOi2GLyfnvrvDUuwGmwIjgJgGuXSK
         PG+JTS0qVvRsrv3KZo3QSSuv7c2u3umaZZmbVIl/uylPbBDHuvB+CRc7xprL27+pMt
         0r1o1FMqnGTOfrESAGGsJrmwpX9Nckojm1OFX8yjEpM7FQSZqf2QQDguOLEoNZMe/C
         0rq3XJyAut25FrOTMOOP0K+HPYuM7tMBxPxU8RP2WzB539XsWlVNxUgApwzKVNGM7b
         dP/tcWvijHmoQ==
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-565403bda57so3203429a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 06:15:21 -0700 (PDT)
X-Gm-Message-State: AOJu0Yxkv2cSGwwy0iFrbrgP1DkHit5AWxsjAAK7vXyVebRLDAlZ7ksM
        Htaxq2cSboOgOxGP33om5XB7hV4ollcehROk0NWyOA==
X-Google-Smtp-Source: AGHT+IG/2lCn3UCoPUMzbblVb6t98DntYQj2ckCtGDHkgKfGgOYcfr9y25dpVx3OcXP1WI8Nmon6ksgJboKH2pjL29g=
X-Received: by 2002:a17:90b:108d:b0:267:fc61:5a37 with SMTP id
 gj13-20020a17090b108d00b00267fc615a37mr9367966pjb.39.1692796520714; Wed, 23
 Aug 2023 06:15:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230821160849.531668-1-david@redhat.com> <20230821160849.531668-3-david@redhat.com>
In-Reply-To: <20230821160849.531668-3-david@redhat.com>
From:   Chris Li <chrisl@kernel.org>
Date:   Wed, 23 Aug 2023 06:15:08 -0700
X-Gmail-Original-Message-ID: <CAF8kJuP9E0AmWQ3_-ay_rt0NxhCihTDA+hvx+YLnWeuY=kp+uw@mail.gmail.com>
Message-ID: <CAF8kJuP9E0AmWQ3_-ay_rt0NxhCihTDA+hvx+YLnWeuY=kp+uw@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v1 2/4] mm/swap: use dedicated entry for swap
 in folio
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Xu <peterx@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Hugh Dickins <hughd@google.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Chris Li <chrisl@kernel.org>

Chris

On Mon, Aug 21, 2023 at 9:09=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> From: Matthew Wilcox <willy@infradead.org>
>
> Let's stop working on the private field and use an explicit swap field.
> We have to move the swp_entry_t typedef.
>
> Signed-off-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  include/linux/mm_types.h | 23 +++++++++++++----------
>  include/linux/swap.h     |  5 ++---
>  2 files changed, 15 insertions(+), 13 deletions(-)
>
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 61361f1750c3..438a07854f8c 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -259,6 +259,14 @@ static inline struct page *encoded_page_ptr(struct e=
ncoded_page *page)
>   */
>  #define  TAIL_MAPPING_REUSED_MAX  (2)
>
> +/*
> + * A swap entry has to fit into a "unsigned long", as the entry is hidde=
n
> + * in the "index" field of the swapper address space.
> + */
> +typedef struct {
> +       unsigned long val;
> +} swp_entry_t;
> +
>  /**
>   * struct folio - Represents a contiguous set of bytes.
>   * @flags: Identical to the page flags.
> @@ -269,7 +277,7 @@ static inline struct page *encoded_page_ptr(struct en=
coded_page *page)
>   * @index: Offset within the file, in units of pages.  For anonymous mem=
ory,
>   *    this is the index from the beginning of the mmap.
>   * @private: Filesystem per-folio data (see folio_attach_private()).
> - *    Used for swp_entry_t if folio_test_swapcache().
> + * @swap: Used for swp_entry_t if folio_test_swapcache().
>   * @_mapcount: Do not access this member directly.  Use folio_mapcount()=
 to
>   *    find out how many times this folio is mapped by userspace.
>   * @_refcount: Do not access this member directly.  Use folio_ref_count(=
)
> @@ -312,7 +320,10 @@ struct folio {
>                         };
>                         struct address_space *mapping;
>                         pgoff_t index;
> -                       void *private;
> +                       union {
> +                               void *private;
> +                               swp_entry_t swap;
> +                       };
>                         atomic_t _mapcount;
>                         atomic_t _refcount;
>  #ifdef CONFIG_MEMCG
> @@ -1220,14 +1231,6 @@ enum tlb_flush_reason {
>         NR_TLB_FLUSH_REASONS,
>  };
>
> - /*
> -  * A swap entry has to fit into a "unsigned long", as the entry is hidd=
en
> -  * in the "index" field of the swapper address space.
> -  */
> -typedef struct {
> -       unsigned long val;
> -} swp_entry_t;
> -
>  /**
>   * enum fault_flag - Fault flag definitions.
>   * @FAULT_FLAG_WRITE: Fault was a write fault.
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 84fe0e94f5cd..82859a1944f5 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -335,8 +335,7 @@ struct swap_info_struct {
>
>  static inline swp_entry_t folio_swap_entry(struct folio *folio)
>  {
> -       swp_entry_t entry =3D { .val =3D page_private(&folio->page) };
> -       return entry;
> +       return folio->swap;
>  }
>
>  static inline swp_entry_t page_swap_entry(struct page *page)
> @@ -350,7 +349,7 @@ static inline swp_entry_t page_swap_entry(struct page=
 *page)
>
>  static inline void folio_set_swap_entry(struct folio *folio, swp_entry_t=
 entry)
>  {
> -       folio->private =3D (void *)entry.val;
> +       folio->swap =3D entry;
>  }
>
>  /* linux/mm/workingset.c */
> --
> 2.41.0
>
>
