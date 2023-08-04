Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D64876FCBC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 11:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjHDJBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 05:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjHDJBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 05:01:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F9E65B7
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 01:55:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BAEB161F54
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 08:55:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21EB0C433C7
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 08:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691139336;
        bh=gIb5pPyU6hzvK3+2ycEARpvIiQ/V08O4nOswJIcFEig=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Mo0BW2Y+sJ4Q7R2SQ/FYzUm7L+4NWEeDWDuxBM2DPZhqUOFmEBjUsJg3WQEFnntXQ
         cHmH2MsmVQQABotaiydJj2I3wrV5lxSgyhOrN1vZ2XdDzaVwFOq6AvTi+92oAgkq9W
         3irWunfRcFDUvclkhdyoPqFeNb6xKDydgJmrHMldKrH2wG3GEnnjX17EJxFOVphNME
         GAnESilcOmcLmuTGMSq6s7uJPOHj57QIBf7mMJIJ0so6yte1k2VZK0ZNH7m9V96rah
         wcXguhRxnoLqIz0KVttyDlhAM2luvYsdUkAOKtLo6a0An85JQGUdyXYkZvSYsVz2KA
         +4TB4QsDdBd+Q==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-1bba1816960so1232553fac.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 01:55:36 -0700 (PDT)
X-Gm-Message-State: AOJu0YwluSsrwU3dCnczKMLMgrWvGqIrlttkNaQbBK8zIiMqxsM3S/wh
        kSALcr4q39NgPrSPTEcMQASrtQq9hP6/Bhbx2PI=
X-Google-Smtp-Source: AGHT+IHgrPjn+1s2Txe5CL4eVwuZ+NpNJsNNenD09anoYSz1JOMnb3ixvLreN2bp0iMj0bsW5nD3+ptXGJl26U/MYn4=
X-Received: by 2002:a05:6870:c155:b0:1bf:8c9a:9a2f with SMTP id
 g21-20020a056870c15500b001bf8c9a9a2fmr1392559oad.25.1691139335359; Fri, 04
 Aug 2023 01:55:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230803112042.2277172-1-linux@rasmusvillemoes.dk>
In-Reply-To: <20230803112042.2277172-1-linux@rasmusvillemoes.dk>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 4 Aug 2023 17:54:59 +0900
X-Gmail-Original-Message-ID: <CAK7LNASxy0rPmSQtvhG_2-=KENTi0AnxPLVVyZqzCh9s6PYKvA@mail.gmail.com>
Message-ID: <CAK7LNASxy0rPmSQtvhG_2-=KENTi0AnxPLVVyZqzCh9s6PYKvA@mail.gmail.com>
Subject: Re: [PATCH] scripts/setlocalversion: also consider annotated tags of
 the form vx.y.z-${file_localversion}
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Nicolas Schier <nicolas@fjasle.eu>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 3, 2023 at 8:20=E2=80=AFPM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> Commit 6ab7e1f95e96 ("setlocalversion: use only the correct release
> tag for git-describe") was absolutely correct to limit which annotated
> tags would be used to compute the -01234-gabcdef suffix. Otherwise, if
> some random annotated tag exists closer to HEAD than the vX.Y.Z one,
> the commit count would be too low.
>
> However, since the version string always includes the
> ${file_localversion} part, now the problem is that the count can be
> too high. For example, building an 6.4.6-rt8 kernel with a few patches
> on top, I currently get
>
> $ make -s kernelrelease
> 6.4.6-rt8-00128-gd78b7f406397
>
> But those 128 commits include the 100 commits that are in
> v6.4.6..v6.4.6-rt8, so this is somewhat misleading.
>
> Amend the logic so that, in addition to the linux-next consideration,
> the script also looks for a tag corresponding to the 6.4.6-rt8 part of
> what will become the `uname -r` string. With this patch (so 29 patches
> on top of v6.4.6-rt8), one instead gets
>
> $ make -s kernelrelease
> 6.4.6-rt8-00029-gd533209291a2
>
> While there, note that the line
>
>   git describe --exact-match --match=3D$tag $tag 2>/dev/null
>
> obviously asks if $tag is an annotated tag, but it does not actually
> tell if the commit pointed to has any relation to HEAD. So remove both
> uses of --exact-match, and instead just ask if the description
> generated is identical to the tag we provided. Since we then already
> have the result of
>
>   git describe --match=3D$tag
>
> we also end up reducing the number of times we invoke "git describe".
>
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  scripts/setlocalversion | 35 +++++++++++++++++++++++++----------
>  1 file changed, 25 insertions(+), 10 deletions(-)


Very nice. Just a nit.


Please initialize 'desc' to empty before ${desc} is referenced.

   desc=3D




Thank you.







--=20
Best Regards
Masahiro Yamada
