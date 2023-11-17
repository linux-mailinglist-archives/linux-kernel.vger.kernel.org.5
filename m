Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D85BD7EF548
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 16:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbjKQP2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 10:28:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbjKQP16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 10:27:58 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68B8D57
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 07:27:53 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c6efcef4eeso27822971fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 07:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700234872; x=1700839672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WmKxE7AQnOU7KXybCy/9YJt3zqy4mGTqUK/bK6QTE/Y=;
        b=Sy1HeT2+lere+WaserZQqgfPsp2arXPABSErGOGacUMPwh2N2bf0t86G99iumfkJPE
         89RyxdkeVMeDEyZy8+OpCrJNwjo0tW5cXzv8at1pEjATGGwLW7ddcQo6oosIu9SkMEI6
         TI3OlT///ymb6ilohWCQSbGkS2X6rpFCfm4WH+usvSRHY1JWjYKfsL60k2kqYlNn+IIK
         3JWxLbUuEWwQQVeW1t485wIQ8ow73MaI+H2Bju1Y1KAUyNO4CzWh49SPqEaDMedYr8Uv
         dRtsSXJXfSNOclKQX0UEpVzJUadKM30GP2Ry9Upk5diu7V1GRx3DkGamAWLln1FtZxKw
         8k6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700234872; x=1700839672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WmKxE7AQnOU7KXybCy/9YJt3zqy4mGTqUK/bK6QTE/Y=;
        b=rl2jR6G4oZsccZA9vwiCc/753S8/E05YOYQ+fYICrluNLPYPW3RRpIS6PfdgJgIQ0h
         c+6X81PR1uhU/Fp6fIl+EojNGk0zmQGD2WuUaz1eAaIhugUi5kGBDHFQKlYHLI6Fo7q6
         3Nmjl9jLFNqwiUOn9Sag9sHRRRF6YfarzdRMExCxr+s3Dju/iKnyoMdWn4PQm3mRecQ5
         RAN+XjHMlyQaehSW9dZ59YenWKxB/KMkThLGKQNM/XyP/FIVMCJiBoBu31WienaBlE+0
         QcMJJ8ZuavjUzbCRVLK+SBp8ypnbYiNfUpJhAmftDFkhk0hU5Ur/G308Q85n5wbcGlNd
         VEMQ==
X-Gm-Message-State: AOJu0Yzi0pYhlYn/sZ4pMVO9YQYtruC8aNg23cUghTh6Cr4Xz6H9wdBm
        oikSdZZb7exItTd8aBUM4Io2F3INqK1F8Y6iPng=
X-Google-Smtp-Source: AGHT+IGt+7evUR92SaoSqVq16sbeqKBfYtxYZ3FYS+i0ZIg1hJTonJ3OxqZIVwn9P3HocloR0zBtdy0WyUkdBJSxQLI=
X-Received: by 2002:a05:651c:b28:b0:2c8:6f66:27a7 with SMTP id
 b40-20020a05651c0b2800b002c86f6627a7mr1323835ljr.23.1700234871330; Fri, 17
 Nov 2023 07:27:51 -0800 (PST)
MIME-Version: 1.0
References: <20231116201547.536857-1-peterx@redhat.com> <20231116201547.536857-3-peterx@redhat.com>
In-Reply-To: <20231116201547.536857-3-peterx@redhat.com>
From:   Andrei Vagin <avagin@gmail.com>
Date:   Fri, 17 Nov 2023 07:27:40 -0800
Message-ID: <CANaxB-yUQsnAVu6_Tv_Kqf8HKTcg7z_7g28VoVaF=c-hWuHU9g@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm/pagemap: Fix wr-protect even if
 PM_SCAN_WP_MATCHING not set
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        syzbot+7ca4b2719dc742b8d0a4@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 12:15=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote=
:
>
> The new pagemap ioctl contains a fast path for wr-protections without
> looking into category masks.  It forgets to check PM_SCAN_WP_MATCHING
> before applying the wr-protections.  It can cause, e.g., pte markers
> installed on archs that do not even support uffd wr-protect.
>
> WARNING: CPU: 0 PID: 5059 at mm/memory.c:1520 zap_pte_range mm/memory.c:1=
520 [inline]
>
> Fixes: 12f6b01a0bcb ("fs/proc/task_mmu: add fast paths to get/clear PAGE_=
IS_WRITTEN flag")
> Reported-by: syzbot+7ca4b2719dc742b8d0a4@syzkaller.appspotmail.com
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Andrei Vagin <avagin@gmail.com>

> ---
>  fs/proc/task_mmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index e91085d79926..d19924bf0a39 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -2171,7 +2171,7 @@ static int pagemap_scan_pmd_entry(pmd_t *pmd, unsig=
ned long start,
>                 return 0;
>         }
>
> -       if (!p->vec_out) {
> +       if ((p->arg.flags & PM_SCAN_WP_MATCHING) && !p->vec_out) {
>                 /* Fast path for performing exclusive WP */
>                 for (addr =3D start; addr !=3D end; pte++, addr +=3D PAGE=
_SIZE) {
>                         if (pte_uffd_wp(ptep_get(pte)))
> --
> 2.41.0
>
