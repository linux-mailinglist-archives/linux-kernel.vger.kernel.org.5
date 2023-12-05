Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A751804882
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 05:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343945AbjLEEVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 23:21:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343907AbjLEEVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 23:21:16 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0288D3
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 20:21:21 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-db5e692d4e0so3576016276.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 20:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701750081; x=1702354881; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UKPY7I/BsmvEHiTV9VZgArxhYwb6iAeMRALPYz2PTVE=;
        b=JDoyVH0kv670bjfdUrN+dKVE5OpZklTqkcMwQnglkZVvAoVxAOToRZb1wjM3VmzEe7
         l7VaM0XTiQ4qnbx4P5I8w9Ic2TCld2VLNvBJxcWqXzAxK0UBrv2W7kyQ1C81kgPK2yQZ
         8lS8+i+9ucyyRVnNnBMz6M4feyTQ2Jv9In9SYvdXInASQPqcmfIrB+rqqSjdtaUjNrmb
         bA5znVmyBHrfW5CGICNMl6Wm+c36kp5hj3CihPAMoyxEWH316t8JTmoiBJq8feDNG0Mc
         XaICq5sxh38obWqq3A0On8lR2gdg1QxJp6/RP9ccKc590Hea28egyy4v9q+990WXnYbG
         cTkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701750081; x=1702354881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UKPY7I/BsmvEHiTV9VZgArxhYwb6iAeMRALPYz2PTVE=;
        b=XT70wkmA3xL/Ts1igfnydoukbwmyawLtXWQNS3LvaRICDFn3YFE/FvxIcKt/0Qzi9f
         V+b1UiVfhzTWZW1VricDSkUajUW40v66Ofdh0kdy9dcx8eJDpE9n1mAQtEhQugX3VOwx
         Dw3+lp02k7mihUzLM7Z+f3bj57/cjtEttrk2+UmLgDhxGBMPOKujjUVRtu76xyAiBKw7
         DG5RCWPnUjXEMqJUbLjCVQGTfQ4Q7JA046VwSJBHKhs6nt09cy2iO0oJtFQ5z3jPoWVi
         UZi/4yqXrKkGAMGVB0Fh2ouxk1r3LspiYw//RTHPIH9JcqO+ZamhHEp49QYKohfX0DM3
         H0xQ==
X-Gm-Message-State: AOJu0YxKxgbjmzjVS7Tuq43IbdzeDQDApGbsgfVKbtSz8e+nbcz86pzk
        vXsCYWTqz/x0FYc2AzC+IoEhTuxLFUhzIAuIDi4=
X-Google-Smtp-Source: AGHT+IHFC+Zd+F9MUmTooN0Zh6iSGmcwziQ5UT44nFubCZ6yoFoNb4QNIwEmycBpE5EgCtpokXDQMsL6UlRH+2pRMPE=
X-Received: by 2002:a25:cc82:0:b0:d9a:fd65:f97f with SMTP id
 l124-20020a25cc82000000b00d9afd65f97fmr4187738ybf.17.1701750081129; Mon, 04
 Dec 2023 20:21:21 -0800 (PST)
MIME-Version: 1.0
References: <20231204102027.57185-1-ryan.roberts@arm.com> <20231204102027.57185-4-ryan.roberts@arm.com>
In-Reply-To: <20231204102027.57185-4-ryan.roberts@arm.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Tue, 5 Dec 2023 17:21:09 +1300
Message-ID: <CAGsJ_4zU6pHOwEzCQxo9UWUFmHZp0pvfgF4pKbkFfDPCRyFwyw@mail.gmail.com>
Subject: Re: [PATCH v8 03/10] mm: thp: Introduce multi-size THP sysfs interface
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Mon, Dec 4, 2023 at 11:21=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> In preparation for adding support for anonymous multi-size THP,
> introduce new sysfs structure that will be used to control the new
> behaviours. A new directory is added under transparent_hugepage for each
> supported THP size, and contains an `enabled` file, which can be set to
> "inherit" (to inherit the global setting), "always", "madvise" or
> "never". For now, the kernel still only supports PMD-sized anonymous
> THP, so only 1 directory is populated.
>
> The first half of the change converts transhuge_vma_suitable() and
> hugepage_vma_check() so that they take a bitfield of orders for which
> the user wants to determine support, and the functions filter out all
> the orders that can't be supported, given the current sysfs
> configuration and the VMA dimensions. If there is only 1 order set in
> the input then the output can continue to be treated like a boolean;
> this is the case for most call sites. The resulting functions are
> renamed to thp_vma_suitable_orders() and thp_vma_allowable_orders()
> respectively.
>
> The second half of the change implements the new sysfs interface. It has
> been done so that each supported THP size has a `struct thpsize`, which
> describes the relevant metadata and is itself a kobject. This is pretty
> minimal for now, but should make it easy to add new per-thpsize files to
> the interface if needed in future (e.g. per-size defrag). Rather than
> keep the `enabled` state directly in the struct thpsize, I've elected to
> directly encode it into huge_anon_orders_[always|madvise|inherit]
> bitfields since this reduces the amount of work required in
> thp_vma_allowable_orders() which is called for every page fault.
>
> See Documentation/admin-guide/mm/transhuge.rst, as modified by this
> commit, for details of how the new sysfs interface works.
>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

Reviewed-by: Barry Song <v-songbaohua@oppo.com>

> -khugepaged will be automatically started when
> -transparent_hugepage/enabled is set to "always" or "madvise, and it'll
> -be automatically shutdown if it's set to "never".
> +khugepaged will be automatically started when one or more hugepage
> +sizes are enabled (either by directly setting "always" or "madvise",
> +or by setting "inherit" while the top-level enabled is set to "always"
> +or "madvise"), and it'll be automatically shutdown when the last
> +hugepage size is disabled (either by directly setting "never", or by
> +setting "inherit" while the top-level enabled is set to "never").
>
>  Khugepaged controls
>  -------------------
>
> +.. note::
> +   khugepaged currently only searches for opportunities to collapse to
> +   PMD-sized THP and no attempt is made to collapse to other THP
> +   sizes.

For small-size THP, collapse is probably a bad idea. we like a one-shot
try in Android especially we are using a 64KB and less large folio size. if
PF succeeds in getting large folios, we map large folios, otherwise we
give up as those memories can be quite unstably swapped-out, swapped-in
and madvised to be DONTNEED.

too many compactions will increase power consumption and decrease UI
response.

Thanks
Barry
