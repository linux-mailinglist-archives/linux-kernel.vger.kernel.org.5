Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBA080B0D0
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 01:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574835AbjLIAKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 19:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235946AbjLIAKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 19:10:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFB6172A
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 16:10:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77563C433CB
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 00:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702080624;
        bh=/Qd28qU1g2yFEdsp9oZ9RTK5j/CkVtLWfnrYw6TNGj8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=arQKWW0Xght4tVmWubvLmZ0/ug1w2OA6AOoxvtcZChqOQ40oE69Amlwx129XAtXXI
         YousS0uGwx2Qx5yIfciZjxIuqmYtqRqvPWeNL75CcV+/bPIlfh/5PmZWTSsnkC8TuD
         VZdYjptuGdnuTMYdpg3cio0Du2sL7tI5/ufJUrj7zBvGh8JgY4zUXYdSpOFswNNFt3
         MlAB/nzi0mtk8ZsqCl5otmER1XnoP0idbx93zhaog/YVMoAgKTznaAxIBroiqU++MP
         AS46vr1/rTLIWyzpaoo72j1x2ehWSdLgNB3HvoD0i9112wsNO5eaHIhy8/JQqoJGUj
         PCPeUHKJtTgUw==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-58d18c224c7so1371812eaf.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 16:10:24 -0800 (PST)
X-Gm-Message-State: AOJu0Yy2Xionp4tsskZzL7Q38KRyl6CqtXsoFia2D6sFJfIwWpGMZGsl
        0FfayNlnJ/yyAhN3XNU4RGHu9R6B1skroFXdDhNuSg==
X-Google-Smtp-Source: AGHT+IEYanmJJoWkVANumIUyBx+OGbV82E6jJc+vDfUEfLnIWaO7PYxpB1AkcvdAEM9L0SFnAgCCql0eYfg2GAui5DU=
X-Received: by 2002:a17:90b:1c11:b0:288:4719:75c3 with SMTP id
 oc17-20020a17090b1c1100b00288471975c3mr676015pjb.45.1702080602635; Fri, 08
 Dec 2023 16:10:02 -0800 (PST)
MIME-Version: 1.0
References: <20231207192406.3809579-1-nphamcs@gmail.com> <CAF8kJuPEKWbr_1a-OzqrYKSPmuty==KhC2vbTPAmm9xcJHo4cg@mail.gmail.com>
 <CAKEwX=Oj0Rur8i9Oo7y2Py7svx-g11sEj3GKQfMVL62x=4hvdA@mail.gmail.com> <CAJD7tkaHaji=0sVobJKajc4hOmOui2U+bZK+1DQ6gbAsQgGLRw@mail.gmail.com>
In-Reply-To: <CAJD7tkaHaji=0sVobJKajc4hOmOui2U+bZK+1DQ6gbAsQgGLRw@mail.gmail.com>
From:   Chris Li <chrisl@kernel.org>
Date:   Fri, 8 Dec 2023 16:09:51 -0800
X-Gmail-Original-Message-ID: <CAF8kJuMt7_6_8JTNA5UJkhy3Drw6=802wbwXbvUn+hafmsFA7Q@mail.gmail.com>
Message-ID: <CAF8kJuMt7_6_8JTNA5UJkhy3Drw6=802wbwXbvUn+hafmsFA7Q@mail.gmail.com>
Subject: Re: [PATCH v6] zswap: memcontrol: implement zswap writeback disabling
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cerasuolodomenico@gmail.com, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, hughd@google.com, corbet@lwn.net,
        konrad.wilk@oracle.com, senozhatsky@chromium.org, rppt@kernel.org,
        linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        david@ixit.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yosry,

On Thu, Dec 7, 2023 at 5:12=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com> =
wrote:
> > I briefly summarized my recent discussion with Johannes here:
> >
> > https://lore.kernel.org/all/CAKEwX=3DNwGGRAtXoNPfq63YnNLBCF0ZDOdLVRsvzU=
mYhK4jxzHA@mail.gmail.com/
> >
> > TL;DR is we acknowledge the potential usefulness of swap.tiers
> > interface, but the use case is not quite there yet, so it does not
> > make too much sense to build up that heavy machinery now.
> > zswap.writeback is a more urgent need, and does not prevent swap.tiers
> > if we do decide to implement it.
>
> I am honestly not convinced by this. There is no heavy machinery here.
> The interface is more generic and extensible, but the implementation
> is roughly the same. Unless we have a reason to think a swap.tiers
> interface may make it difficult to extend this later or will not
> support some use cases, I think we should go ahead with it. If we are
> worried that "tiers" may not accurately describe future use cases, we
> can be more generic and call it swap.types or something.
>
+100.

Chris
