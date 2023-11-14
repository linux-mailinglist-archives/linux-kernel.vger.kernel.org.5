Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD7B7EB572
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 18:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbjKNRU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 12:20:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjKNRU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 12:20:28 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FC4F1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 09:20:24 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9c2a0725825so885333066b.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 09:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699982423; x=1700587223; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3rKlcLic1qzOex60qzBrHqaG9Vs5/tn6fuZtH/qFUOA=;
        b=VjEf0JiOpZoFwHFLqXzORodvUwts2fxJT6cldHtqnid3lXj2yjyzUBUV24i+9/Gxzw
         jzPGi3VxjM6KOaqgrMvTNp+ONMZsAzOsGpFSMYS9LJKXkuFcua4cgTsYZwR+QZam6Wrf
         ZGZhgx2lScHxMOnoI7GUw3BakiveKKVPoJ6BFr710P1aYh7bSuXUJDieHfCGBkHq/zCL
         XSpSJRyWJsdyeihHp8yomZsRkx855QAnw0vtryonCsgOxAc8zRTFt6rN9SoaahLZ1Qcp
         YXUyzbbDatgw3VK58kWEfIoGsiim5+2TJP7lOLP+S9LHWIAk6q2THbhca+RLPz5z6ewU
         REwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699982423; x=1700587223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3rKlcLic1qzOex60qzBrHqaG9Vs5/tn6fuZtH/qFUOA=;
        b=S2xLwUmsLCOBjq2FwIauzYzuq1xeGKnC32ZBLT1DdtYKkrhZNrAStgUKgGFIYmLjud
         67tZj5pUVNtN7VabtFrjF7D/oRYMNTPOmIYVK1V+5w7IJ/CTvQJWMOgmXSskEDoYCUju
         Gh9mjFjtxphNWs41LoNIKnHAqb+j8Pf0yV1RNF7G5jLYJ33056NWMQoW6YjqBwzo7wUP
         bFpBgH3Pe3tmW/DSQzzlPLXxKKmUhuOBHKmdtgqVIXdRyiHC0XsOWYpMNBv3tyItSjBa
         CF+0qV4qi0S3U4Z1MHGz5cM0+zuYwHWjXIPSiuyILFD2MlxAAfKrcW45QA0ZIHSkbOve
         nMxQ==
X-Gm-Message-State: AOJu0YxnlZ5Dv3QQCf2Ph0YMGr4KJDOA6VnerqErHGtXoi3Ls0sC4xr/
        fMUWJWx6nTdGRA/RNDWvl5LDIyTZcJQDubxpAMRLHA==
X-Google-Smtp-Source: AGHT+IGhSisnarNys5lTyq4VL5Encb5qZA5tBioOvi7RCHTSdUTNkv1pqYrWuCzXMyZa6ml0jbKaDxtpHidMHyJEskc=
X-Received: by 2002:a17:906:c56:b0:9db:e46c:569 with SMTP id
 t22-20020a1709060c5600b009dbe46c0569mr6783787ejf.45.1699982422867; Tue, 14
 Nov 2023 09:20:22 -0800 (PST)
MIME-Version: 1.0
References: <20231106231158.380730-1-nphamcs@gmail.com>
In-Reply-To: <20231106231158.380730-1-nphamcs@gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 14 Nov 2023 09:19:47 -0800
Message-ID: <CAJD7tkbbkk1anw06fNpkHB==dmVPfDOja+Bae3uB3y7U_NaJnA@mail.gmail.com>
Subject: Re: [PATCH v4] zswap: memcontrol: implement zswap writeback disabling
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, tj@kernel.org, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, cerasuolodomenico@gmail.com,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, hughd@google.com, corbet@lwn.net,
        konrad.wilk@oracle.com, senozhatsky@chromium.org, rppt@kernel.org,
        linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        david@ixit.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 6, 2023 at 3:12=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote:
>
> During our experiment with zswap, we sometimes observe swap IOs due to
> occasional zswap store failures and writebacks-to-swap. These swapping
> IOs prevent many users who cannot tolerate swapping from adopting zswap
> to save memory and improve performance where possible.
>
> This patch adds the option to disable this behavior entirely: do not
> writeback to backing swapping device when a zswap store attempt fail,
> and do not write pages in the zswap pool back to the backing swap
> device (both when the pool is full, and when the new zswap shrinker is
> called).
>
> This new behavior can be opted-in/out on a per-cgroup basis via a new
> cgroup file. By default, writebacks to swap device is enabled, which is
> the previous behavior. Initially, writeback is enabled for the root
> cgroup, and a newly created cgroup will inherit the current setting of
> its parent.
>
> Note that this is subtly different from setting memory.swap.max to 0, as
> it still allows for pages to be stored in the zswap pool (which itself
> consumes swap space in its current form).
>
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>

LGTM,
Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
