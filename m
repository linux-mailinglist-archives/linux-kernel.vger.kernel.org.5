Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F2D78154C
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 00:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241409AbjHRWPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 18:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241225AbjHRWOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 18:14:42 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4AA3ABC
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 15:14:41 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-529fa243739so402a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 15:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692396880; x=1693001680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=15MJ5r20Bc4OUa0urOYZvVtRB9hu6WE3eNsvEWDgJeE=;
        b=5MUOAio1GCuin9twjXzSt3qHZogjdPaIs9sL7dopMb0fkuVWC0I1ywYPczk/X/Kh6R
         Yu8KeX9gGhlSVhhyffLnKfNhLMxFjMqZVCzMRNggP8Dr+Ggms3IpFwGVya6qPSpwUGMS
         qv1zJG24TacICwYclybBDvvbSnYZoUAUmG1xLslxkqU1CLH6daJGpWQhG0DuYde3MxYc
         MgpoRnvPriDnEOfgYXorhnJXu/zWze4H8VkHZQMZC/Vz679EBsJNbOPDRjBoomTyUoq3
         eX3DMXi9DDI88trw4xTncXTHnGMJx9pKEd2V9kLvzs9gMnOn9+qol75n9JJSLg+nJNPD
         5JZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692396880; x=1693001680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=15MJ5r20Bc4OUa0urOYZvVtRB9hu6WE3eNsvEWDgJeE=;
        b=J6WHPzWN1mRGc1LYWCK3n8jhGgJF1S4/VTDjNCrMNOMatXjNJ1nEB/BWyjotJl6YVY
         5KDa4wsnv2vXxmVMHBmiBG5AFNIL2ub9dLrX6NQ81KEtpRVWKdKblvOq2nVa7XaFUYZx
         2u5Bv+VTljVllcTBh6Ls1Gg85id3C6A+XSWed0FBidwTKYpUK+7lbSP0wqWC4z6KAyZq
         Ape6M04rX+Jwg+a2agpdNsSqhN1NYQweH48ofvSQMEQjZVIio0GcDT/W0aGTAwRmK/Gp
         w2yBJTtkbyB8snIjDc7+B+AB1ebxHOXHm6zkcXdj3/2cs8NCNiZP432Ivd5km/MXX229
         TX2g==
X-Gm-Message-State: AOJu0YxUxJ29ESJKFftmfBW2C9QnO8a4hyh+s5kr2POgtT/buamw3dEZ
        IhD349Oh+Lly2HV0L6NzA1x10pk4KiyKsxAaMBkkweVc/FD3gcd4ArY=
X-Google-Smtp-Source: AGHT+IFl+/v9+ILj228ARnLnSiE3V94KsI4Cb5UlE6k9q8RncZUCKRO3FWE8WYSip2TE1gy/wCoqCgSF6PEYMY8P+/E=
X-Received: by 2002:a50:d5c2:0:b0:522:4741:d992 with SMTP id
 g2-20020a50d5c2000000b005224741d992mr140781edj.4.1692396879764; Fri, 18 Aug
 2023 15:14:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230818211533.2523697-1-zokeefe@google.com> <20230818211533.2523697-2-zokeefe@google.com>
In-Reply-To: <20230818211533.2523697-2-zokeefe@google.com>
From:   "Zach O'Keefe" <zokeefe@google.com>
Date:   Fri, 18 Aug 2023 15:14:02 -0700
Message-ID: <CAAa6QmSN+7zWTMhYY9rEBf8U5xZ3kwfZXUuvT=ZGmEXLpNm0Kg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] smaps: set THPeligible if file mapping supports
 large folios
To:     linux-mm@kvack.org, Yang Shi <shy828301@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
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

Sorry -- noticed only too late that there are still many
false-negatives for THPeligible, since by this point in the function
we've already applied sysfs and prctl restrictions, which file-fault
ignores. VM_HUGEPAGE also needs to be checked for the file-fault case.

On Fri, Aug 18, 2023 at 2:15=E2=80=AFPM Zach O'Keefe <zokeefe@google.com> w=
rote:
>
> File-backed memory can be backed by THPs either through collapse, when
> CONFIG_READ_ONLY_THP_FOR_FS is enabled, or through fault, when the
> filesystem supports large folio mappings.
>
> Currently, smaps only knows about the former, so teach it about the
> latter.
>
> Signed-off-by: Zach O'Keefe <zokeefe@google.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> ---
>  mm/huge_memory.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index cd379b2c077b..d8d6e83820f3 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -136,7 +136,16 @@ bool hugepage_vma_check(struct vm_area_struct *vma, =
unsigned long vm_flags,
>                          */
>                         !!vma->vm_ops->huge_fault :
>                         /* Only regular file is valid in collapse path */
> -                       file_thp_enabled(vma);
> +                       file_thp_enabled(vma) ||
> +                        /*
> +                         * THPeligible bit of smaps should surface the
> +                         * possibility of THP through fault if the files=
ystem
> +                         * supports it.  We don't check this in fault pa=
th,
> +                         * because we want to fallback to the actual ->f=
ault()
> +                         * handler to make the decision.
> +                         */
> +                        (smaps && vma->vm_file &&
> +                        mapping_large_folio_support(vma->vm_file->f_mapp=
ing));
>
>         if (vma_is_temporary_stack(vma))
>                 return false;
> --
> 2.42.0.rc1.204.g551eb34607-goog
>
