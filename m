Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADD27AF63A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 00:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjIZWRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 18:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbjIZWPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 18:15:50 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0139711657B
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 14:39:19 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c5bf7871dcso76025695ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 14:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695764358; x=1696369158; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y/yEtlXtVxm4kjBMlSVby9WafwRCEzcrWM1EGka6xJY=;
        b=VQu93rpDRTTEvebpSLZIigaMG9WblREm9dAK6jQablFsuy2gcMDlecoElod02wdUnO
         Qhe5Nx5ercFzvCVWGJ1fNNgifnGWMg4meS/wSyIe3z2Y71xaCvY7SXQrBIMA8KezsBka
         g1Zak57AtLcm2tPEuaMuqr88l/dECBjucDwIQhj9srZUXfeXJXQuOr4863tzPM06PA0X
         Y6S/1ZEHCZSEWduSxq1xMbTOaif8Wegrq2npQg7cnEllNEivwJPp98vpjLs0bA2sfazc
         U6dnGIFRnIKZ2roGog976Lzmh/mcES8SnVStvlfPQNgjSCUSxDpbnADUZIsryhbsLWaH
         Tmow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695764358; x=1696369158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y/yEtlXtVxm4kjBMlSVby9WafwRCEzcrWM1EGka6xJY=;
        b=ILWAFjF+3d8u+LPWIJmHmIKFd4qgAGhWfZhwO54z00H6tj8jxrOzPS+4wIA1c/OLes
         UCxKZyLFAEksQ+fe5iq1pmSyvZI8VLi4G2q44poUnwW0DKw07u7mTr/emXHsQc1zC1Z4
         IT6d8K7fkgC1cFdJf5ZAtrUZba7fPLPSJH+GR+LMJgpPEe1HQaydpM5U7tuMYIZXbEFy
         asCothyys9i2RZZhFyVCj81Drvpkz9gacyeUr/jvl0hoS1CleY55fEwF8E8WPk0cKOv0
         sORg8HAatggq0xkWtzia/vvfShLXpTpYyRWvqfOV+h5EHiB0i1/Fo7vDueHHoN9atOxV
         CzKg==
X-Gm-Message-State: AOJu0YxU5uy8WE0+ObFp+9dEbiqY0C519dTP62p+p8YLv5xLKfTbZyeM
        YRc/OrlQ8lkGhbDhVgBWpO5kQ2R75XlImjViTPQ=
X-Google-Smtp-Source: AGHT+IEYSKgDeyLNfepkexfRwh2z3vtZbnxmtLL6nlWDaFrd5K34ugg6dGSh45/zU0RvC0+WovaHBgCMMPfg8B+qWKo=
X-Received: by 2002:a17:90a:7f8c:b0:274:6839:6a89 with SMTP id
 m12-20020a17090a7f8c00b0027468396a89mr8054307pjl.27.1695764358364; Tue, 26
 Sep 2023 14:39:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230925200110.1979606-1-zokeefe@google.com>
In-Reply-To: <20230925200110.1979606-1-zokeefe@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 26 Sep 2023 14:39:06 -0700
Message-ID: <CAHbLzkp_+y6BS_VfrG+Mqvw0jUfYRF=1x9LX_s3ix+1FXF6emQ@mail.gmail.com>
Subject: Re: [PATCH v4] mm/thp: fix "mm: thp: kill __transhuge_page_enabled()"
To:     "Zach O'Keefe" <zokeefe@google.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 1:01=E2=80=AFPM Zach O'Keefe <zokeefe@google.com> w=
rote:
>
> The 6.0 commits:
>
> commit 9fec51689ff6 ("mm: thp: kill transparent_hugepage_active()")
> commit 7da4e2cb8b1f ("mm: thp: kill __transhuge_page_enabled()")
>
> merged "can we have THPs in this VMA?" logic that was previously done
> separately by fault-path, khugepaged, and smaps "THPeligible" checks.
>
> During the process, the semantics of the fault path check changed in two
> ways:
>
> 1) A VM_NO_KHUGEPAGED check was introduced (also added to smaps path).
> 2) We no longer checked if non-anonymous memory had a vm_ops->huge_fault
>    handler that could satisfy the fault.  Previously, this check had been
>    done in create_huge_pud() and create_huge_pmd() routines, but after
>    the changes, we never reach those routines.
>
> During the review of the above commits, it was determined that in-tree
> users weren't affected by the change; most notably, since the only releva=
nt
> user (in terms of THP) of VM_MIXEDMAP or ->huge_fault is DAX, which is
> explicitly approved early in approval logic. However, this was a bad
> assumption to make as it assumes the only reason to support ->huge_fault
> was for DAX (which is not true in general).
>
> Remove the VM_NO_KHUGEPAGED check when not in collapse path and give
> any ->huge_fault handler a chance to handle the fault.  Note that we
> don't validate the file mode or mapping alignment, which is consistent
> with the behavior before the aforementioned commits.

Looks good to me. Reviewed-by: Yang Shi <shy828301@gmail.com>

>
> Fixes: 7da4e2cb8b1f ("mm: thp: kill __transhuge_page_enabled()")
> Reported-by: Saurabh Singh Sengar <ssengar@microsoft.com>
> Signed-off-by: Zach O'Keefe <zokeefe@google.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: David Hildenbrand <david@redhat.com>
> ---
> I've updated the changelog to reflect discussions in [1] -- leaving
> ack to David / Matthew on whether to take the patch.
>
> Changed from v3[1]:
>         - [akpm / David H. / M. Wilcox] Updated log to capture email disc=
ussion
> Changed from v2[2]:
>         - Fixed false negative in smaps check when !dax && ->huge_fault
> Changed from v1[3]:
>         - [Saurabhi] Allow ->huge_fault handler to handle fault, if it ex=
ists
>
> [1] https://lore.kernel.org/linux-mm/20230821234844.699818-1-zokeefe@goog=
le.com/
> [2] https://lore.kernel.org/linux-mm/20230818211533.2523697-1-zokeefe@goo=
gle.com/
> [3] https://lore.kernel.org/linux-mm/CAAa6QmQw+F=3Do6htOn=3D6ADD6mwvMO=3D=
Ow_67f3ifBv3GpXx9Xg_g@mail.gmail.com/
>
> ---
>  mm/huge_memory.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 0f93a73115f73..797fe617e51ab 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -100,11 +100,11 @@ bool hugepage_vma_check(struct vm_area_struct *vma,=
 unsigned long vm_flags,
>                 return in_pf;
>
>         /*
> -        * Special VMA and hugetlb VMA.
> +        * khugepaged special VMA and hugetlb VMA.
>          * Must be checked after dax since some dax mappings may have
>          * VM_MIXEDMAP set.
>          */
> -       if (vm_flags & VM_NO_KHUGEPAGED)
> +       if (!in_pf && !smaps && (vm_flags & VM_NO_KHUGEPAGED))
>                 return false;
>
>         /*
> @@ -132,12 +132,18 @@ bool hugepage_vma_check(struct vm_area_struct *vma,=
 unsigned long vm_flags,
>                                            !hugepage_flags_always())))
>                 return false;
>
> -       /* Only regular file is valid */
> -       if (!in_pf && file_thp_enabled(vma))
> -               return true;
> -
> -       if (!vma_is_anonymous(vma))
> +       if (!vma_is_anonymous(vma)) {
> +               /*
> +                * Trust that ->huge_fault() handlers know what they are =
doing
> +                * in fault path.
> +                */
> +               if (((in_pf || smaps)) && vma->vm_ops->huge_fault)
> +                       return true;
> +               /* Only regular file is valid in collapse path */
> +               if (((!in_pf || smaps)) && file_thp_enabled(vma))
> +                       return true;
>                 return false;
> +       }
>
>         if (vma_is_temporary_stack(vma))
>                 return false;
> --
> 2.42.0.515.g380fc7ccd1-goog
>
