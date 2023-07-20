Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6816B75A851
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 09:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbjGTHzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 03:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbjGTHzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 03:55:07 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB4D2137
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 00:55:06 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-993d1f899d7so89815866b.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 00:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689839705; x=1692431705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aHFb36iaYbmIQpiaPjY1UsgrNY9Yir9dWsTpsYfsO/Y=;
        b=PEqe4ruHyk32s21hEI0BYSGI6sM5iPgLa9g7fazDCUfq/8uXwcy036XW35VUrzu6Eq
         VXHAwzavoJtdW7C0bSscjTBpx07pSovrWIhIqi0kVx6xGxsXFhwbYetpPVtsoUDV+fK7
         EtYkbOi6lTAUSGwFlw/l5Azr3/OHJ5AZ7e5R4wYSyathAw/3qTEb3mnu50bWywbFaSd3
         GbTCNQZnVhRtocELnalPPASEBmbAR5Yt1hkej5BmlywhRX+NxVoKgtcSlzTbgXk8lQnl
         CzE7M1qRMMO4wUaOfRoAZIJajIZdM1GKrPLXvCNo9IvBBkqJ2FvRjNdFf1yNwQo8LvD9
         0ghw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689839705; x=1692431705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aHFb36iaYbmIQpiaPjY1UsgrNY9Yir9dWsTpsYfsO/Y=;
        b=eSs8tVcLtuePZCqiagM2mYUndjjPJfsTNO7DfhlFEWwP0DrZ+i+tG6bY1pNCHeKwaV
         vAMIi1AqBG4Ru9G5BmdbUtAAbRpjEyG3q10uxZ7PzZIIygrSFdKsKIN/r+8cI/K8b2yC
         uV6l3+c/MMj24bsu6TEzi0hohdIw2jcSUwH5KLyJiP8L/KoLAzWUai5MIEyMyh5ZxnFc
         jXgfWann2B2Q2y7vsmuIL2PqBO5e8KY4Mczp+873XhEuJFw9ZE/iqS0BN/810jHDWGDc
         O2sNlcOq7Mxgflqw1HBnRgl1UeeH4cWX8OdE0OnQU1W6rk5YnXw2tN3sLEnkxtwi5XH1
         Fjlw==
X-Gm-Message-State: ABy/qLZ5NaezMrZeBO+BopQ/7Suw+suxo26kUxbmWlQiX04TU5Vr7hZj
        twBdHXIGFwKKaWXUg58+jhxHC0GlimA7B2jNXJOv/A==
X-Google-Smtp-Source: APBJJlHu9ulUHUn1s+ZKubnNUSYxo9LVzXPP42dxf6KOMU2NhlqVM9AN85wAjF4ioyRYLg5xhwF/BPR+nRLbLykBBp0=
X-Received: by 2002:a17:906:7e5a:b0:974:55a2:cb0b with SMTP id
 z26-20020a1709067e5a00b0097455a2cb0bmr3828672ejr.55.1689839704756; Thu, 20
 Jul 2023 00:55:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230713042037.980211-1-42.hyeyoo@gmail.com> <20230720071826.GE955071@google.com>
In-Reply-To: <20230720071826.GE955071@google.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 20 Jul 2023 00:54:28 -0700
Message-ID: <CAJD7tka2b-VsLJRrwfdbFAwvfKV+sHvNyRBJsG+81EmQ-=MkyA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/21] mm/zsmalloc: Split zsdesc from struct page
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 12:18=E2=80=AFAM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (23/07/13 13:20), Hyeonggon Yoo wrote:
> > The purpose of this series is to define own memory descriptor for zsmal=
loc,
> > instead of re-using various fields of struct page. This is a part of th=
e
> > effort to reduce the size of struct page to unsigned long and enable
> > dynamic allocation of memory descriptors.
> >
> > While [1] outlines this ultimate objective, the current use of struct p=
age
> > is highly dependent on its definition, making it challenging to separat=
ely
> > allocate memory descriptors.
>
> I glanced through the series and it all looks pretty straight forward to
> me. I'll have a closer look. And we definitely need Minchan to ACK it.
>
> > Therefore, this series introduces new descriptor for zsmalloc, called
> > zsdesc. It overlays struct page for now, but will eventually be allocat=
ed
> > independently in the future.
>
> So I don't expect zsmalloc memory usage increase. On one hand for each
> physical page that zspage consists of we will allocate zsdesc (extra byte=
s),
> but at the same time struct page gets slimmer. So we should be even, or
> am I wrong?

Well, it depends. Here is my understanding (which may be completely wrong):

The end goal would be to have an 8-byte memdesc for each order-0 page,
and then allocate a specialized struct per-folio according to the use
case. In this case, we would have a memdesc and a zsdesc for each
order-0 page. If sizeof(zsdesc) is 64 bytes (on 64-bit), then it's a
net loss. The savings only start kicking in with higher order folios.
As of now, zsmalloc only uses order-0 pages as far as I can tell, so
the usage would increase if I understand correctly.

It seems to me though the sizeof(zsdesc) is actually 56 bytes (on
64-bit), so sizeof(zsdesc) + sizeof(memdesc) would be equal to the
current size of struct page. If that's true, then there is no loss,
and there's potential gain if we start using higher order folios in
zsmalloc in the future.

(That is of course unless we want to maintain cache line alignment for
the zsdescs, then we might end up using 64 bytes anyway).
