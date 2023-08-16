Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C265177E75A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 19:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345103AbjHPRN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 13:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345167AbjHPRNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 13:13:11 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B642701
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 10:13:06 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fe2d620d17so5915e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 10:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692205985; x=1692810785;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZYUypjySzrAs8GAD7XVdfOM4s0Fcr0Thimjx1ALtpVI=;
        b=KXJiRmmYEO/zdoFBPp/YAhd426XdPnK00YUWC+8mkii6PtisTHWhvdS5tkZ0xGKMtk
         fHk3BqdfOMpgwYwuvAG7FpL6rospMidGIxerCPzwoKvxbDBU52MX5lF2D+nBY+DLtxyt
         RGc50o7vFONOM/2TNGQJZm/lk5P8AsD35hpJq5XVbrBE1Ilo8NJOHBJmqZgsKQnU+Vca
         NyIi10ieIOHkI/bcXrFIuBgptWq1ow8nONf3bVOFUoJYTlIlX/8kLhNEBNd/TlzqpO4S
         BYd6LC7im3QYFcDRiwfebjrzs6KxRqPOsGcTpyx/CZSBFCa8HnsEsGT1vbz6hssLcPnb
         E2oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692205985; x=1692810785;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZYUypjySzrAs8GAD7XVdfOM4s0Fcr0Thimjx1ALtpVI=;
        b=Hy9JWCUDc16JFaQ8MLbbrVbYceu3eMtvllee7q9jZPxB2ODBnprB0uLuE/yIB6yPSN
         FGtDycMroNVC0lItZr4XxmU8kSafTBJvO1K2QQ0gdsb1ChoXkVMk1QZetwgex79p8xL7
         VUx91ALYkgde28mJ6EJ9xfGDaULMw1PMwaxkQtGLLLXTbM2ZK+7EWR2+YCXRVT0vZgf3
         raxWgF5Y/T61qYQ6yinF7pEjq3YPqQiy7gufC3KniymURVjjBFcf41Squ8Tg4Q4yNyxH
         GMVALgBvq8luUY5I64EaZ+1PA5n/I859wQqjoUPMbdj+DqLt3UeYhb3Y6TBGPUj43pje
         tMjw==
X-Gm-Message-State: AOJu0Yw1fKl+TDgSiHU3trVpJOy8yLO7AmhUWhCsQeJKQNNH9AqHyZU+
        YPfM4UGCkt9Ken7c6zhmpUcPUVBGwuzGJ6m5Zr58zg==
X-Google-Smtp-Source: AGHT+IHSaO6WGnDE0QP8Hi7+3CkXN+E8BSEciMIfec2sBc4o6XMsWSHcwRcMePlTHR9KIDKgQ2howap+w7lK11I/LCc=
X-Received: by 2002:a05:600c:5119:b0:3f4:fb7:48d4 with SMTP id
 o25-20020a05600c511900b003f40fb748d4mr4622wms.3.1692205984767; Wed, 16 Aug
 2023 10:13:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAG48ez12VN1JAOtTNMY+Y2YnsU45yL5giS-Qn=ejtiHpgJAbdQ@mail.gmail.com>
 <20230816161758.avedpxvqpwngzmut@revolver>
In-Reply-To: <20230816161758.avedpxvqpwngzmut@revolver>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 16 Aug 2023 19:12:27 +0200
Message-ID: <CAG48ez3mcH-ms0piv7iMcB_ap+WDgkE_ex6VHSZw_Aw30-Ox8g@mail.gmail.com>
Subject: Re: maple tree change made it possible for VMA iteration to see same
 VMA twice due to late vma_merge() failure
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
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

On Wed, Aug 16, 2023 at 6:18=E2=80=AFPM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
> * Jann Horn <jannh@google.com> [230815 15:37]:
> > commit 18b098af2890 ("vma_merge: set vma iterator to correct
> > position.") added a vma_prev(vmi) call to vma_merge() at a point where
> > it's still possible to bail out. My understanding is that this moves
> > the VMA iterator back by one VMA.
> >
> > If you patch some extra logging into the kernel and inject a fake
> > out-of-memory error at the vma_iter_prealloc() call in vma_split() (a
> > real out-of-memory error there is very unlikely to happen in practice,
> > I think - my understanding is that the kernel will basically kill
> > every process on the system except for init before it starts failing
> > GFP_KERNEL allocations that fit within a single slab, unless the
> > allocation uses GFP_ACCOUNT or stuff like that, which the maple tree
> > doesn't):
[...]
> > then you'll get this fun log output, showing that the same VMA
> > (ffff88810c0b5e00) was visited by two iterations of the VMA iteration
> > loop, and on the second iteration, prev=3D=3Dvma:
> >
> > [  326.765586] userfaultfd_register: begin vma iteration
> > [  326.766985] userfaultfd_register: prev=3Dffff88810c0b5ef0,
> > vma=3Dffff88810c0b5e00 (0000000000101000-0000000000102000)
> > [  326.768786] userfaultfd_register: vma_merge returned 000000000000000=
0
> > [  326.769898] userfaultfd_register: prev=3Dffff88810c0b5e00,
> > vma=3Dffff88810c0b5e00 (0000000000101000-0000000000102000)
> >
> > I don't know if this can lead to anything bad but it seems pretty
> > clearly unintended?
>
> Yes, unintended.
>
> So we are running out of memory, but since vma_merge() doesn't
> differentiate between failure and 'nothing to merge', we end up in a
> situation that we will revisit the same VMA.
>
> I've been thinking about a way to work this into the interface and I
> don't see a clean way because we (could) do different things before the
> call depending on the situation.
>
> I think we need to undo any vma iterator changes in the failure
> scenarios if there is a chance of the iterator continuing to be used,
> which is probably not limited to just this case.

I don't fully understand the maple tree interface - in the specific
case of vma_merge(), could you move the vma_prev() call down below the
point of no return, after vma_iter_prealloc()? Or does
vma_iter_prealloc() require that the iterator is already in the insert
position?

> I will audit these areas and CC you on the result.

Thanks!
