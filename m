Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111BE7E5347
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 11:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235613AbjKHKZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 05:25:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235548AbjKHKZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 05:25:34 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CF11BE1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 02:25:31 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-66d13ac2796so42370396d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 02:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699439131; x=1700043931; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hFXE5I7HOXwk7JlqroxccHiG3T2FgVcx/4HWNGNDYno=;
        b=Td/h/pfyi39u9U5N8HIUN2pFbhGMtxnxw633suED/De2QrA288rPpGMza4a+uEC0sN
         WpbJPcqm+flKsYECB+tmSiRNPZIYt/cPgJ2eYe9o2yNgPw7rKJOQ7kqoSCt6md2IrLHR
         CxZ2IR6kmvBUtJsv9msnlJTZwKgoAPqZAbH6c1UExVjU4577kCfDfIFVfNLukjbAqUFu
         Eds9tx8AHKH3VOAdC3sDuTRD2cntrhiBzwzA0NhihbtTsKi2WfkM/roPyjT+qMY4gXe/
         dLctd9upzrPSAJ1UJxX3HJp462nRyaPPB11M/n8MqrFdt+E3lqxFMJiZ5zrxavFP5lql
         0mdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699439131; x=1700043931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hFXE5I7HOXwk7JlqroxccHiG3T2FgVcx/4HWNGNDYno=;
        b=T85bWzTSIvMd7g5ZEbxap1f4iNxBXq2WeU97w6yiKIrxhh62d+OsEoCSYmgKc5jSNE
         89JydWEtJdKub8Afd5/auwKPVvafbZsQuKPUTkYZd8jDOQuluVHyKYHwV7PFh49WH6L+
         DRv5jfWVkt2TUIIRMz1LZxIkZUAryuDjC6cSxAbIXUlRMuEWUQhK1X8bsJillDee31Zd
         ZNfjgz5eAeE5pemQVzZOjVD26z4Z7Py+nK7j+OGW8WK5LOwyJJUIEQGMA9hU+7NCYO3J
         eveMfbV2McUj5RrtsCSwSPpRXYkclhM0NynD31SoCEdlywtDtTPuitjiU1itWG96OB4l
         Tpug==
X-Gm-Message-State: AOJu0YykeveGop8OOW8SWIToSfeyCdhQ+QTLZo08kFiL4CRaAkDrHZdv
        hHjL2YG5FEsyfrkrYtnJ970CGUhp5MebyAz96sM=
X-Google-Smtp-Source: AGHT+IHNNOHtGCXD2GgHsAGVo8PEr+xcrarRfQjOLc7FMs2GWdsXCu9D1EiQgz93poU1hSs0YMflOJ0EQyJeLNKglSI=
X-Received: by 2002:a05:6214:c8c:b0:66f:bb3f:2e1 with SMTP id
 r12-20020a0562140c8c00b0066fbb3f02e1mr1367244qvr.19.1699439130908; Wed, 08
 Nov 2023 02:25:30 -0800 (PST)
MIME-Version: 1.0
References: <1691402476-4838-1-git-send-email-hyeongtak.ji@gmail.com> <20231107183346.GA3789583@cmpxchg.org>
In-Reply-To: <20231107183346.GA3789583@cmpxchg.org>
From:   Hyeongtak Ji <hyeongtak.ji@gmail.com>
Date:   Wed, 8 Nov 2023 19:25:20 +0900
Message-ID: <CAFY0u4Q3oo6SUt1nmVaoHDT0OL=pB0OjmRUiXAFw-jdjdWqsBQ@mail.gmail.com>
Subject: Re: [PATCH] mm/vmscan: consider previously reclaimed pages in shrink_lruvec()
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Hyeongtak Ji <hyeongtak.ji@sk.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Thank you for your reply.

On Wed, Nov 8, 2023 at 3:33=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org>=
 wrote:
>
> On Mon, Aug 07, 2023 at 07:01:16PM +0900, Hyeongtak Ji wrote:
> > shrink_lruvec() currently ignores previously reclaimed pages in
> > scan_control->nr_reclaimed.  This can lead shrink_lruvec() to reclaimin=
g
> > more pages than expected.
> >
> > This patch fixes shrink_lruvec() to take into account the previously
> > reclaimed pages.
>
> Do you run into real world issues from this? The code has been like
> this for at least a decade.
>

I believed this was merely a misinitialization that resulted in
shrink_lruvec() reclaiming more pages than intended. However, I do
acknowledge that there have not been any real world issues arising from
this behavior.

> It's an intentional choice to ensure fairness across all visited
> cgroups. sc->nr_to_reclaim is 32 pages or less - it's only to guard

sc->nr_to_reclaim can be larger than 32 (e.g., about 5K) in the case that I
was worrying about. kswapd_shrink_node() in mm/vmscan.c sets the value
and it is passed down to shrink_lruvec().

> against extreme overreclaim. But we want to make sure we reclaim a bit
> from all cgroups, rather than always hit the first one and then bail.
