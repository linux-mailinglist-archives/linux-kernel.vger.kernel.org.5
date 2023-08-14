Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E60F377BC29
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 16:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbjHNOzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 10:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232590AbjHNOyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 10:54:40 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26094E73
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 07:54:39 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fe2a116565so110875e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 07:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692024877; x=1692629677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sKON9RDaScjGyJlMzY6Qx826LRT8/zffIKtU7zyiPnc=;
        b=t9ssYAID4AzcztXn9fRIzHlvvbCvKGdLjqI4eYoG5qE2tV7hGAxmD5R3IcF8ne0e7q
         d2cFuSJg/VSNLxwrrjJNm0gRRsrd/WXYoXra3rwlzOjVVZtVB5DQwBwkmZPScWgjiS72
         CzyzpSQ+d2WVilgK8MVuxzu8sHHY8vy6tirE2Iqt6IeFc50jyoHyLNNbzZPqBECpFdWc
         UzM1h54YjUzG6oNDEotDRXtV/T7+V5yGwvq8Upi4G38AU/20v/SGbrDQNCidXhXy3b48
         p4hCaqgSlX70G/RN9Iu8Rk3lF/d32n+PiPnuDZyQQuS9i3eUs9r+Iw3a7XkSQAIBm3np
         5i5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692024877; x=1692629677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sKON9RDaScjGyJlMzY6Qx826LRT8/zffIKtU7zyiPnc=;
        b=NGm/FIt3x1S8BK5vgtLXh2cN68FgYodzvx2jfB7DvfT4Rp246MBawgoKxuZUxm+hlU
         2RPWdwfyQr9ehHl3LPksWtgtVWIepvZT0IEkoASWMyHq0/2XE4ZMG3djsS0r1126VpK3
         PJ4GpeHSSWo8W/VaElAkkgGlmi+HvkRGB31oPMfUwVvzPaWX7CGEXB3z1LXJKM0IBLku
         8S5NzQGcMHObE9V0fbeWcbSoKq7HjH1dRx5FFXOs53m9fJTDu8FKgPIUrQlETHnswwMo
         Y/RHAif8SZsC/LnCd35x0riBWnDV3IIy62oTwlG8r9muWKq9xbddrkUFjSK1dJNqbBzX
         R4nA==
X-Gm-Message-State: AOJu0Yz4UVawtctCU1CdPsDhr6wyxsbZtGfWDNdJ029LVRIL+u8vVvP0
        e7SATd3Iqu/7gSlI2PIIaKkq9/7zLbL7nfdY+EOLUw==
X-Google-Smtp-Source: AGHT+IE4tx6o8syIvoDqdJLVxHW3S88gMW5FwmcDjIQBdeuYWnxrmLjIue+8/doww4aFJWiCZhNpOFtYDMG9lfLWWF4=
X-Received: by 2002:a05:600c:3ba2:b0:3f7:3e85:36a with SMTP id
 n34-20020a05600c3ba200b003f73e85036amr268017wms.7.1692024877559; Mon, 14 Aug
 2023 07:54:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230804152724.3090321-1-surenb@google.com> <20230804152724.3090321-6-surenb@google.com>
In-Reply-To: <20230804152724.3090321-6-surenb@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 14 Aug 2023 16:54:01 +0200
Message-ID: <CAG48ez0XCXoXbSR6dyX7GUQYJKRFKQsHuye5q-PLU3-gR5of5A@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] mm: always lock new vma before inserting into vma tree
To:     akpm@linux-foundation.org, Suren Baghdasaryan <surenb@google.com>
Cc:     torvalds@linux-foundation.org, willy@infradead.org,
        liam.howlett@oracle.com, david@redhat.com, peterx@redhat.com,
        ldufour@linux.ibm.com, vbabka@suse.cz, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, hannes@cmpxchg.org,
        dave@stgolabs.net, hughd@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

@akpm can you fix this up?

On Fri, Aug 4, 2023 at 5:27=E2=80=AFPM Suren Baghdasaryan <surenb@google.co=
m> wrote:
> While it's not strictly necessary to lock a newly created vma before
> adding it into the vma tree (as long as no further changes are performed
> to it), it seems like a good policy to lock it and prevent accidental
> changes after it becomes visible to the page faults. Lock the vma before
> adding it into the vma tree.
>
> Suggested-by: Jann Horn <jannh@google.com>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>  mm/mmap.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 3937479d0e07..850a39dee075 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -412,6 +412,8 @@ static int vma_link(struct mm_struct *mm, struct vm_a=
rea_struct *vma)
>         if (vma_iter_prealloc(&vmi))
>                 return -ENOMEM;
>
> +       vma_start_write(vma);
> +
>         if (vma->vm_file) {
>                 mapping =3D vma->vm_file->f_mapping;
>                 i_mmap_lock_write(mapping);

Something went wrong when this part of the patch was applied, because
of a conflict with "mm/mmap: move vma operations to mm_struct out of
the critical section of file mapping lock"; see how this patch ended
up in the mm tree:
https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?id=3D26=
cb4dafc13871ab68a4fb480ca1e19381cff392

> @@ -403,6 +403,8 @@ static int vma_link(struct mm_struct *mm, struct vm_a=
rea_struct *vma)
>
>   vma_iter_store(&vmi, vma);
>
> + vma_start_write(vma);
> +
>   if (vma->vm_file) {
>  mapping =3D vma->vm_file->f_mapping;
>  i_mmap_lock_write(mapping);

The "vma_start_write()" has to be ordered before the
"vma_iter_store(&vmi, vma)".
