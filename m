Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C047FA89C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 19:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbjK0SHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 13:07:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbjK0SHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 13:07:44 -0500
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1B718F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 10:07:51 -0800 (PST)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1fa619735c1so491544fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 10:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701108470; x=1701713270; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B2Zx7+enx863bwmh/iEYdDd6JfbUcNFrDrlMu0iGHc8=;
        b=FoQycJQrQ6GO2SBUCHDLVgUWC1GnPpU9D9cZs/k8Gr9dfv6E9mC0E215odUZ5OAAln
         j7duhsj8Bw00bFYB3PND/t7qKrK9FHM1zwURLKws9SNWUZ5lqOA+w0zTJMBSW4iqHNPY
         jUQCcytpleuHz4yhdjLoeXBEGEiai8qPuvBKOmz+uVBRvFa2fQFvM/a++RZ5+txosBXZ
         /ddTlZI2DZ5IhSGGWDD297Caw8bK4fZZlD9b2kNnzaQ5tkbkq6jRHhO3VOk6uNf5YctX
         giSQYrLEQQ5e0DswljMAYgNycP39SOMbjMJA/1I1EvAXcDsT9X8vk8Z4L6IAnEBUz1sc
         qRqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701108470; x=1701713270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B2Zx7+enx863bwmh/iEYdDd6JfbUcNFrDrlMu0iGHc8=;
        b=KuS1TthAMZIYJKC53h/ZcogztvQNDBGGElbLz39ehYIKBZ35CDzJkJBDAbaU1HRY0s
         kFfw+783pmsNBo6E12D2yNNvHVzdRoEvLGIkKgkl5wHkyX4YZehSDS90pWA/eBV+Sfjv
         24cfZka8xTWR2zhX3tkLnT1q4qFN3pR2ix6454L1UOWHscg5wK7cX/X1pqENdGaarNz/
         VLLhGYyZxmX4MK4vu1y2/TxrIVb6xltNHBFSITERie3yHRYzwIGGrunQiyz/u+wkgIXe
         DAJC3afc69kTf9KfY2ea1QlLZ4XIH7oUX8v2afV/SOMZmt7NWwcYyIPii2KfAKRas2xX
         w0gw==
X-Gm-Message-State: AOJu0YyrYfXT6WFM0/q/wc4mk3y5MGPal2AhaqHWoGVpcU+crIc8v0X1
        cAc5tVkZ3J5822NV6lF+SIDmib06P3+OJUvZNXo=
X-Google-Smtp-Source: AGHT+IHZheWzSgUj6Nx54FwEWkHS5hNieuFiWxjAC6eF5fSVB5/vXjRhdjESt+NUB3dXc93KVCgKswIjXCRWfGhbH8c=
X-Received: by 2002:a05:6870:1d06:b0:1fa:26e7:c428 with SMTP id
 pa6-20020a0568701d0600b001fa26e7c428mr10124465oab.19.1701108469637; Mon, 27
 Nov 2023 10:07:49 -0800 (PST)
MIME-Version: 1.0
References: <20231127160058.586446-1-fabio.maria.de.francesco@linux.intel.com>
In-Reply-To: <20231127160058.586446-1-fabio.maria.de.francesco@linux.intel.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Mon, 27 Nov 2023 10:07:38 -0800
Message-ID: <CAKEwX=OvnNH0TSHYtfBKABVu=RpecjBDWuY56EDa24oWpydQLQ@mail.gmail.com>
Subject: Re: [PATCH] mm/zswap: Replace kmap_atomic() with kmap_local_page()
To:     "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
Cc:     Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 8:03=E2=80=AFAM Fabio M. De Francesco
<fabio.maria.de.francesco@linux.intel.com> wrote:
>
> kmap_atomic() has been deprecated in favor of kmap_local_page().
>
> Therefore, replace kmap_atomic() with kmap_local_page() in
> zswap.c.
>
> kmap_atomic() is implemented like a kmap_local_page() which also
> disables page-faults and preemption (the latter only in !PREEMPT_RT
> kernels). The kernel virtual addresses returned by these two API are
> only valid in the context of the callers (i.e., they cannot be handed to
> other threads).
>
> With kmap_local_page() the mappings are per thread and CPU local like
> in kmap_atomic(); however, they can handle page-faults and can be called
> from any context (including interrupts). The tasks that call
> kmap_local_page() can be preempted and, when they are scheduled to run
> again, the kernel virtual addresses are restored and are still valid.
>
> In mm/zswap.c, the blocks of code between the mappings and un-mappings
> do not depend on the above-mentioned side effects of kmap_atomic(), so
> that the mere replacements of the old API with the new one is all that is
> required (i.e., there is no need to explicitly call pagefault_disable()
> and/or preempt_disable()).
>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fabio.maria.de.francesco@linux.inte=
l.com>
> ---
>  mm/zswap.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 74411dfdad92..699c6ee11222 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1267,16 +1267,16 @@ bool zswap_store(struct folio *folio)
>         }
>
>         if (zswap_same_filled_pages_enabled) {
> -               src =3D kmap_atomic(page);
> +               src =3D kmap_local_page(page);
>                 if (zswap_is_page_same_filled(src, &value)) {
> -                       kunmap_atomic(src);
> +                       kunmap_local(src);
>                         entry->swpentry =3D swp_entry(type, offset);
>                         entry->length =3D 0;
>                         entry->value =3D value;
>                         atomic_inc(&zswap_same_filled_pages);
>                         goto insert_entry;
>                 }
> -               kunmap_atomic(src);
> +               kunmap_local(src);
>         }
>
>         if (!zswap_non_same_filled_pages_enabled)
> @@ -1422,9 +1422,9 @@ bool zswap_load(struct folio *folio)
>         spin_unlock(&tree->lock);
>
>         if (!entry->length) {
> -               dst =3D kmap_atomic(page);
> +               dst =3D kmap_local_page(page);
>                 zswap_fill_page(dst, entry->value);
> -               kunmap_atomic(dst);
> +               kunmap_local(dst);
>                 ret =3D true;
>                 goto stats;
>         }
> --
> 2.42.0
>
>
Probably worth running a couple rounds of stress tests, but otherwise
LGTM. FWIW, I've wanted to do this ever since I worked on the
storing-uncompressed-pages patch.


Reviewed-by: Nhat Pham <nphamcs@gmail.com>
