Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 772EA765DD3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 23:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjG0VQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 17:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjG0VQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 17:16:02 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DD930E3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 14:16:01 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3a5ad6087a1so988213b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 14:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690492560; x=1691097360;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6D1dKbMUyuMxqTeEeSi4spRio8knbrwzUbIZXRfX+hw=;
        b=IOAM7fcKQP3AJZ1G53VvO+FMwupcfbqVzToDOoQiJYud3dWdDmJb6Jtd760kWvOUgI
         rl+NquP649J9eHU2kyBq4oFVRVj0tR8rPhz7Ji7xDfcWHJ1ifnhjAhjxOV2uG+bw/7Y2
         dhwWvtJk+kyNFnZzLO8zhXzuFxNS2EeGA+AGfxAVI6WEUk/WYGvd5wsxpCZjV7O4d6Uf
         VL7boBq6vz3GeQ1VQXFX917WhcDwNXpDH0FGGDw6OKSSdcizMPmxExSB+58GXYbTCyFP
         qXqtahtcdKYTb8JUnOHa3XGxA5clJ6igdYnXEvscYlpAvzLLdDk7vHbm1dF/wJiivo1Y
         aLNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690492560; x=1691097360;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6D1dKbMUyuMxqTeEeSi4spRio8knbrwzUbIZXRfX+hw=;
        b=P/TuqWH6+7JJsBCGA5nhZgr5K9Ns2KlUKCG55RuPbjfYV7b8DPZJh30MjrFa/zDj4r
         416D+3eGhoentKXZ43SyQ3GD5K5EFGGDxc8Qrhmf05tLtqCK3m8KG4hD8T04qqDIw8rX
         yCecwIFGo4ilbO7lbbwBwI+RjBHRhxCy3rxa20VGecCZgV+MhKgCSCAXXxruokblXJk2
         J/1CPoYn0PpCdUtTKmE3kFQOgdnlahd01v2TBVgThiY7OfeSzsLRZHpoFCakzu7uzEk1
         Ol+893iKNmmbUtIzavZICspJq6UPZqi2GwFhX2cmxqlFEccALFuBirVGcLQmCKwrtFTl
         NLWw==
X-Gm-Message-State: ABy/qLYnqNvUxznJFbqv+vDw9uoVVq5WKy4tnhSROs5c7f2d9gN7oxbQ
        5WOJ6wc9XQhT1xpFZX0nBjTgRiy+eNmhpaKUf8s6j8Xk
X-Google-Smtp-Source: APBJJlEDDP8mK0hZ5SSzXDsSCp3U0EVYi57aUTLxXKqR+DlsxeNchSLZb4HqSXKBKuyr3p3G0Qt+ujscvg7RD1LQiwY=
X-Received: by 2002:a05:6808:140b:b0:3a4:3f74:3bd6 with SMTP id
 w11-20020a056808140b00b003a43f743bd6mr500196oiv.47.1690492560354; Thu, 27 Jul
 2023 14:16:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230727183745.682880-1-ppbuk5246@gmail.com> <20230727195453.67611-1-sj@kernel.org>
In-Reply-To: <20230727195453.67611-1-sj@kernel.org>
From:   Yun Levi <ppbuk5246@gmail.com>
Date:   Thu, 27 Jul 2023 22:15:49 +0100
Message-ID: <CAM7-yPQp-3BRcuFjOfEfdsMzUNU2bswKWAdQpOe_3gV1TyH5AQ@mail.gmail.com>
Subject: Re: [PATCH] damon: Use pmdp_get instead of drect dereferencing pmd.
To:     SeongJae Park <sj@kernel.org>
Cc:     akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi SJ.

Thanks for looking into this.

> Nit for the subject, what about s/drect/directly/?  Also, let's remove the
> period at the end.
>
> On Fri, 28 Jul 2023 03:37:45 +0900 Levi Yun <ppbuk5246@gmail.com> wrote:

Thanks. But I don't know why period is added thou I sent via git send-email ..

> > -     if (pmd_trans_huge(*pmd)) {
> > +     if (pmd_trans_huge(pmdp_get_lockless(pmd))) {
>
> I don't think we really need to use pmdp_get_lockless() here, since we will do
> this check again with the lock, and we have the fallback for the intermediate
> changes.

Agree. I'll change. Thanks :)

> > @@ -434,26 +437,29 @@ static int damon_young_pmd_entry(pmd_t *pmd, unsigned long addr,
> >  {
> >       pte_t *pte;
> >       pte_t ptent;
> > +     pmd_t pmde;
>
> This would cause below build warning if CONFIG_TRANSPARENT_HUGEPAGE is not
> defined.
>
> .../mm/damon/vaddr.c:440:8: warning: unused variable 'pmde' [-Wunused-variable]
>   440 |  pmd_t pmde;
>       |        ^~~~
>
>
> >       spinlock_t *ptl;
> >       struct folio *folio;
> >       struct damon_young_walk_private *priv = walk->private;
> >
> >  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > -     if (pmd_trans_huge(*pmd)) {
> > +     if (pmd_trans_huge(pmdp_get_lockless(pmd))) {

Oh.. I miss this. Many thanks..!

> Thanks,
> SJ

Many Thanks..!

---------
Sincerely,
Levi.
