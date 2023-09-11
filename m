Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E0379C0A2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242450AbjIKVkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236945AbjIKLoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 07:44:07 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06BBCEB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 04:44:01 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-401da71b83cso49297275e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 04:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694432640; x=1695037440; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FdxNots/ZdhIISnEaFRRuK2rgiRRh92V2Io2TUdmEu4=;
        b=O9NAji9aimG+1hVXB0nHFXsXCZlWElY+LzqgsJ0wSoBAF+g7mztpAL/aZajd7Deun6
         /pd8rGAIIPBZxEiB+JtpbKJKhMlEaaESsqqwGgMrR3HPglnSTRZjow9vn2y4TcUoN9g5
         K+bTRejhwoHPBbr2VqHo23uJ6j19UyV2nnMRUnYF2wnts7bYXMubN02Us2nHr1qjlZE/
         5kiYMSCkVssXJVXfzLAY2o3olEENWXsvAUVofrVtkPkfbGgiu3/j9i4FFRocSmSwhzzA
         RWBHO9f74ZIpUfV9vkLCWSG5+HIkl0at5sXucLKk815Z9hMes714504civIq7Kn9+k0U
         4w4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694432640; x=1695037440;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FdxNots/ZdhIISnEaFRRuK2rgiRRh92V2Io2TUdmEu4=;
        b=ZqgCHqIMGNW0L7kOA1L/akf3IPBMpT7HpJwGHIlqks1kffpGIAQIdKH0JeMjqPOJEw
         c6E/KKih70d1TxIbdaw7fkegfKHhSak8hXw1PQyztbsR0O7XhPm02dhMPB2K3HjFTmQ/
         ta0TojbwSSwD72s254S/HyiA2dH9cdcVv6YP8I2nHUpaHH0JXZeejIXO7bMYcD2Cdrs4
         HgBLKAt+svYMSUb0H3eUtOHfh3RBKBEeSaanYpeI6hWwJ4w2kg4/79ICM8wUBbGF+ZCY
         sYKXi4tPeM0fw47dQgQceAkCkwDXstQ5GdP/aG53cml9u9fd7OamM2Ul7wYmShPBxFPN
         TKFA==
X-Gm-Message-State: AOJu0YyxJg0FSumYPfS6b/EyimB19STZb1GrroxjHqX68QPcQsSLubGh
        yWA4T3FFMv61StHOe63wD8BAOwOfYoXiOWzsy+UoHw==
X-Google-Smtp-Source: AGHT+IGODvX6beJZ5zvdfH+VxLt6+uAABmMvCiPydjYPQlmKzfiXP8yxNJSdULc9CFhOjcKGcex8m7OJN69MT8ZxIhM=
X-Received: by 2002:a7b:c389:0:b0:401:d947:c8a9 with SMTP id
 s9-20020a7bc389000000b00401d947c8a9mr7855842wmj.19.1694432640069; Mon, 11 Sep
 2023 04:44:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230907130642.245222-1-glider@google.com>
In-Reply-To: <20230907130642.245222-1-glider@google.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 11 Sep 2023 13:43:23 +0200
Message-ID: <CANpmjNOO+LUgCWHPg4OXLzm9c7N3SNfLm1MsgME_ms07Ad5L=A@mail.gmail.com>
Subject: Re: [PATCH 1/2] kmsan: simplify kmsan_internal_memmove_metadata()
To:     Alexander Potapenko <glider@google.com>
Cc:     dvyukov@google.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
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

On Thu, 7 Sept 2023 at 15:06, Alexander Potapenko <glider@google.com> wrote:
>
> kmsan_internal_memmove_metadata() is the function that implements
> copying metadata every time memcpy()/memmove() is called.
> Because shadow memory stores 1 byte per each byte of kernel memory,
> copying the shadow is trivial and can be done by a single memmove()
> call.
> Origins, on the other hand, are stored as 4-byte values corresponding
> to every aligned 4 bytes of kernel memory. Therefore, if either the
> source or the destination of kmsan_internal_memmove_metadata() is
> unaligned, the number of origin slots corresponding to the source or
> destination may differ:
>
>   1) memcpy(0xffff888080a00000, 0xffff888080900000, 4)
>      copies 1 origin slot into 1 origin slot:
>
>      src (0xffff888080900000): xxxx
>      src origins:              o111
>      dst (0xffff888080a00000): xxxx
>      dst origins:              o111
>
>   2) memcpy(0xffff888080a00001, 0xffff888080900000, 4)
>      copies 1 origin slot into 2 origin slots:
>
>      src (0xffff888080900000): xxxx
>      src origins:              o111
>      dst (0xffff888080a00000): .xxx x...
>      dst origins:              o111 o111
>
>   3) memcpy(0xffff888080a00000, 0xffff888080900001, 4)
>      copies 2 origin slots into 1 origin slot:
>
>      src (0xffff888080900000): .xxx x...
>      src origins:              o111 o222
>      dst (0xffff888080a00000): xxxx
>      dst origins:              o111
>                            (or o222)
>
> Previously, kmsan_internal_memmove_metadata() tried to solve this
> problem by copying min(src_slots, dst_slots) as is and cloning the
> missing slot on one of the ends, if needed.
> This was error-prone even in the simple cases where 4 bytes were copied,
> and did not account for situations where the total number of nonzero
> origin slots could have increased by more than one after copying:
>
>   memcpy(0xffff888080a00000, 0xffff888080900002, 8)
>
>   src (0xffff888080900002): ..xx .... xx..
>   src origins:              o111 0000 o222
>   dst (0xffff888080a00000): xx.. ..xx
>                             o111 0000
>                         (or 0000 o222)
>
> The new implementation simply copies the shadow byte by byte, and
> updates the corresponding origin slot, if the shadow byte is nonzero.
> This approach can handle complex cases with mixed initialized and
> uninitialized bytes. Similarly to KMSAN inline instrumentation, latter
> writes to bytes sharing the same origin slots take precedence.
>
> Signed-off-by: Alexander Potapenko <glider@google.com>

I think this needs a Fixes tag.
Also, is this corner case exercised by one of the KMSAN KUnit test cases?

Otherwise,

Acked-by: Marco Elver <elver@google.com>

> ---
>  mm/kmsan/core.c | 127 ++++++++++++------------------------------------
>  1 file changed, 31 insertions(+), 96 deletions(-)
>
> diff --git a/mm/kmsan/core.c b/mm/kmsan/core.c
> index 3adb4c1d3b193..c19f47af04241 100644
> --- a/mm/kmsan/core.c
> +++ b/mm/kmsan/core.c
> @@ -83,131 +83,66 @@ depot_stack_handle_t kmsan_save_stack_with_flags(gfp_t flags,
>  /* Copy the metadata following the memmove() behavior. */
>  void kmsan_internal_memmove_metadata(void *dst, void *src, size_t n)
>  {
> +       depot_stack_handle_t prev_old_origin = 0, prev_new_origin = 0;
> +       int i, iter, step, src_off, dst_off, oiter_src, oiter_dst;
>         depot_stack_handle_t old_origin = 0, new_origin = 0;
> -       int src_slots, dst_slots, i, iter, step, skip_bits;
>         depot_stack_handle_t *origin_src, *origin_dst;
> -       void *shadow_src, *shadow_dst;
> -       u32 *align_shadow_src, shadow;
> +       u8 *shadow_src, *shadow_dst;
> +       u32 *align_shadow_dst;
>         bool backwards;
>
>         shadow_dst = kmsan_get_metadata(dst, KMSAN_META_SHADOW);
>         if (!shadow_dst)
>                 return;
>         KMSAN_WARN_ON(!kmsan_metadata_is_contiguous(dst, n));
> +       align_shadow_dst =
> +               (u32 *)ALIGN_DOWN((u64)shadow_dst, KMSAN_ORIGIN_SIZE);
>
>         shadow_src = kmsan_get_metadata(src, KMSAN_META_SHADOW);
>         if (!shadow_src) {
> -               /*
> -                * @src is untracked: zero out destination shadow, ignore the
> -                * origins, we're done.
> -                */
> -               __memset(shadow_dst, 0, n);
> +               /* @src is untracked: mark @dst as initialized. */
> +               kmsan_internal_unpoison_memory(dst, n, /*checked*/ false);
>                 return;
>         }
>         KMSAN_WARN_ON(!kmsan_metadata_is_contiguous(src, n));
>
> -       __memmove(shadow_dst, shadow_src, n);
> -
>         origin_dst = kmsan_get_metadata(dst, KMSAN_META_ORIGIN);
>         origin_src = kmsan_get_metadata(src, KMSAN_META_ORIGIN);
>         KMSAN_WARN_ON(!origin_dst || !origin_src);
> -       src_slots = (ALIGN((u64)src + n, KMSAN_ORIGIN_SIZE) -
> -                    ALIGN_DOWN((u64)src, KMSAN_ORIGIN_SIZE)) /
> -                   KMSAN_ORIGIN_SIZE;
> -       dst_slots = (ALIGN((u64)dst + n, KMSAN_ORIGIN_SIZE) -
> -                    ALIGN_DOWN((u64)dst, KMSAN_ORIGIN_SIZE)) /
> -                   KMSAN_ORIGIN_SIZE;
> -       KMSAN_WARN_ON((src_slots < 1) || (dst_slots < 1));
> -       KMSAN_WARN_ON((src_slots - dst_slots > 1) ||
> -                     (dst_slots - src_slots < -1));
>
>         backwards = dst > src;
> -       i = backwards ? min(src_slots, dst_slots) - 1 : 0;
> -       iter = backwards ? -1 : 1;
> -
> -       align_shadow_src =
> -               (u32 *)ALIGN_DOWN((u64)shadow_src, KMSAN_ORIGIN_SIZE);
> -       for (step = 0; step < min(src_slots, dst_slots); step++, i += iter) {
> -               KMSAN_WARN_ON(i < 0);
> -               shadow = align_shadow_src[i];
> -               if (i == 0) {
> -                       /*
> -                        * If @src isn't aligned on KMSAN_ORIGIN_SIZE, don't
> -                        * look at the first @src % KMSAN_ORIGIN_SIZE bytes
> -                        * of the first shadow slot.
> -                        */
> -                       skip_bits = ((u64)src % KMSAN_ORIGIN_SIZE) * 8;
> -                       shadow = (shadow >> skip_bits) << skip_bits;
> +       step = backwards ? -1 : 1;
> +       iter = backwards ? n - 1 : 0;
> +       src_off = (u64)src % KMSAN_ORIGIN_SIZE;
> +       dst_off = (u64)dst % KMSAN_ORIGIN_SIZE;
> +
> +       /* Copy shadow bytes one by one, updating the origins if necessary. */
> +       for (i = 0; i < n; i++, iter += step) {
> +               oiter_src = (iter + src_off) / KMSAN_ORIGIN_SIZE;
> +               oiter_dst = (iter + dst_off) / KMSAN_ORIGIN_SIZE;
> +               if (!shadow_src[iter]) {
> +                       shadow_dst[iter] = 0;
> +                       if (!align_shadow_dst[oiter_dst])
> +                               origin_dst[oiter_dst] = 0;
> +                       continue;
>                 }
> -               if (i == src_slots - 1) {
> -                       /*
> -                        * If @src + n isn't aligned on
> -                        * KMSAN_ORIGIN_SIZE, don't look at the last
> -                        * (@src + n) % KMSAN_ORIGIN_SIZE bytes of the
> -                        * last shadow slot.
> -                        */
> -                       skip_bits = (((u64)src + n) % KMSAN_ORIGIN_SIZE) * 8;
> -                       shadow = (shadow << skip_bits) >> skip_bits;
> -               }
> -               /*
> -                * Overwrite the origin only if the corresponding
> -                * shadow is nonempty.
> -                */
> -               if (origin_src[i] && (origin_src[i] != old_origin) && shadow) {
> -                       old_origin = origin_src[i];
> -                       new_origin = kmsan_internal_chain_origin(old_origin);
> +               shadow_dst[iter] = shadow_src[iter];
> +               old_origin = origin_src[oiter_src];
> +               if (old_origin == prev_old_origin)
> +                       new_origin = prev_new_origin;
> +               else {
>                         /*
>                          * kmsan_internal_chain_origin() may return
>                          * NULL, but we don't want to lose the previous
>                          * origin value.
>                          */
> +                       new_origin = kmsan_internal_chain_origin(old_origin);
>                         if (!new_origin)
>                                 new_origin = old_origin;
>                 }
> -               if (shadow)
> -                       origin_dst[i] = new_origin;
> -               else
> -                       origin_dst[i] = 0;
> -       }
> -       /*
> -        * If dst_slots is greater than src_slots (i.e.
> -        * dst_slots == src_slots + 1), there is an extra origin slot at the
> -        * beginning or end of the destination buffer, for which we take the
> -        * origin from the previous slot.
> -        * This is only done if the part of the source shadow corresponding to
> -        * slot is non-zero.
> -        *
> -        * E.g. if we copy 8 aligned bytes that are marked as uninitialized
> -        * and have origins o111 and o222, to an unaligned buffer with offset 1,
> -        * these two origins are copied to three origin slots, so one of then
> -        * needs to be duplicated, depending on the copy direction (@backwards)
> -        *
> -        *   src shadow: |uuuu|uuuu|....|
> -        *   src origin: |o111|o222|....|
> -        *
> -        * backwards = 0:
> -        *   dst shadow: |.uuu|uuuu|u...|
> -        *   dst origin: |....|o111|o222| - fill the empty slot with o111
> -        * backwards = 1:
> -        *   dst shadow: |.uuu|uuuu|u...|
> -        *   dst origin: |o111|o222|....| - fill the empty slot with o222
> -        */
> -       if (src_slots < dst_slots) {
> -               if (backwards) {
> -                       shadow = align_shadow_src[src_slots - 1];
> -                       skip_bits = (((u64)dst + n) % KMSAN_ORIGIN_SIZE) * 8;
> -                       shadow = (shadow << skip_bits) >> skip_bits;
> -                       if (shadow)
> -                               /* src_slots > 0, therefore dst_slots is at least 2 */
> -                               origin_dst[dst_slots - 1] =
> -                                       origin_dst[dst_slots - 2];
> -               } else {
> -                       shadow = align_shadow_src[0];
> -                       skip_bits = ((u64)dst % KMSAN_ORIGIN_SIZE) * 8;
> -                       shadow = (shadow >> skip_bits) << skip_bits;
> -                       if (shadow)
> -                               origin_dst[0] = origin_dst[1];
> -               }
> +               origin_dst[oiter_dst] = new_origin;
> +               prev_new_origin = new_origin;
> +               prev_old_origin = old_origin;
>         }
>  }
>
> --
> 2.42.0.283.g2d96d420d3-goog
>
