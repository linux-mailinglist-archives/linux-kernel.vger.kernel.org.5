Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6AD77A30B
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 23:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjHLVZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 17:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjHLVZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 17:25:16 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81AB10DB
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 14:25:19 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-5223910acf2so6362a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 14:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691875518; x=1692480318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fIkJNnjCHIva7eW5XOc9OnqV+TWjSZmrTdIxtleonMA=;
        b=x7hBhhjWv+n0Z/yNLPhzcEKJq1h9dVabSiSgku37NtjW+HihEkdYVY9FiUUUEY2h0A
         NW4AgjXzutQYWtKCDiuAZubZTY3focjSjNMTmCFiWQilkU5IW2EehZKnT/4vFCtGGa36
         7gC4u6XgZ1SGrT4Qc+7u4/KF6n7e1qqf1IVcKb5DybKh7JPjEWhv3ibCmdNbhdX19dAQ
         aQZ6kVq2Pl+/Z207jnXLq752y40n5qe4RKfNaVFTRPl+TXThDgysxR5BtEK399eflB6V
         whk9caveEL2Gh+GwfViKf9ZTPDC8dGPd/tBYwWLolxY1/gMhAEhFbyjDOP7G0IQOQjxE
         rqoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691875518; x=1692480318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fIkJNnjCHIva7eW5XOc9OnqV+TWjSZmrTdIxtleonMA=;
        b=c+xEXMJU2DhHTIQsffyGRZWgBy9/rtC0ijtlxG+wJp/VIdQGQRmYF3gVOn1PIM3PJt
         yOUimgmCjA6hWsx+x2DkPmZFcCvhbVtkRjwPsx7GCpeEGUOCBfzMnWy6QE2+DlXFbmQK
         MPJiwIEE4/upQtlA2v45XkBRdUxzkMFve+Az3WdN5JuuhgvZr1CDQXk9aBIqt+T3F6jJ
         avgo95TrI1e0K2Wq4Ihsli4wMdiNxlHU8nRTFKM2pOd5616dFxZPAFho7q82l4pO+lwq
         2nb/J2+JSXs6XlcIZGvr88ocq96T68GWERhcEvtoGsWNu7Hin9/DBmgzLVefVRJlYqP5
         TcBg==
X-Gm-Message-State: AOJu0Yx1B8SUNWKy7WZ8/frneo/4EKLhJNq7e86h+R2yE6nURO3vl7SU
        IzOsifdcNAGZKDWrca2c2RHpqMwnVPQSaQsBBrOCsw==
X-Google-Smtp-Source: AGHT+IEd1EXlNBvPhlOK9iSVv2k4j73Gs334nV9HL4a5TDQlB4Io2Wgu/3WDoXotJl53dcFPG4s0rtncTsTZzsm3sYs=
X-Received: by 2002:a50:c30e:0:b0:523:193b:5587 with SMTP id
 a14-20020a50c30e000000b00523193b5587mr189433edb.6.1691875518004; Sat, 12 Aug
 2023 14:25:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230812210053.2325091-1-zokeefe@google.com>
In-Reply-To: <20230812210053.2325091-1-zokeefe@google.com>
From:   "Zach O'Keefe" <zokeefe@google.com>
Date:   Sat, 12 Aug 2023 14:24:40 -0700
Message-ID: <CAAa6QmQw+F=o6htOn=6ADD6mwvMO=Ow_67f3ifBv3GpXx9Xg_g@mail.gmail.com>
Subject: Re: [PATCH] mm/thp: fix "mm: thp: kill __transhuge_page_enabled()"
To:     linux-mm@kvack.org, Yang Shi <shy828301@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Saurabh Singh Sengar <ssengar@microsoft.com>
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

On Sat, Aug 12, 2023 at 2:01=E2=80=AFPM Zach O'Keefe <zokeefe@google.com> w=
rote:
>
> The 6.0 commits:
>
> commit 9fec51689ff6 ("mm: thp: kill transparent_hugepage_active()")
> commit 7da4e2cb8b1f ("mm: thp: kill __transhuge_page_enabled()")
>
> merged "can we have THPs in this VMA?" logic that was previously done
> separately by fault-path, khugepaged, and smaps "THPeligible".
>
> During the process, the check on VM_NO_KHUGEPAGED from the khugepaged
> path was accidentally added to fault and smaps paths.  Certainly the
> previous behavior for fault should be restored, and since smaps should
> report the union of THP eligibility for fault and khugepaged, also opt
> smaps out of this constraint.
>
> Fixes: 7da4e2cb8b1f ("mm: thp: kill __transhuge_page_enabled()")
> Reported-by: Saurabh Singh Sengar <ssengar@microsoft.com>
> Signed-off-by: Zach O'Keefe <zokeefe@google.com>
> Cc: Yang Shi <shy828301@gmail.com>
> ---
>  mm/huge_memory.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index eb3678360b97..e098c26d5e2e 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -96,11 +96,11 @@ bool hugepage_vma_check(struct vm_area_struct *vma, u=
nsigned long vm_flags,
>                 return in_pf;
>
>         /*
> -        * Special VMA and hugetlb VMA.
> +        * khugepaged check for special VMA and hugetlb VMA.
>          * Must be checked after dax since some dax mappings may have
>          * VM_MIXEDMAP set.
>          */
> -       if (vm_flags & VM_NO_KHUGEPAGED)
> +       if (!in_pf && !smaps && (vm_flags & VM_NO_KHUGEPAGED))
>                 return false;
>
>         /*
> --
> 2.41.0.694.ge786442a9b-goog
>

I should note that this was discussed before[1], and VM_MIXEDMAP was
called out then, but we didn't have any use cases.

What was reported broken by Saurabh was an out-of-tree driver that
relies on being able to fault in THPs over VM_HUGEPAGE|VM_MIXEDMAP
VMAs. We mentioned back then we could always opt fault-path out of
this check in the future, and it seems like we should.

To that extent, should this be added to stable?

Apologies, I should have added this context to the commit log.

Best,
Zach

[1] https://lore.kernel.org/linux-mm/YqdPmitColnzlXJ0@google.com/
