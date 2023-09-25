Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C01AE7AD10C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 09:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbjIYHGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 03:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232353AbjIYHGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 03:06:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2BCBC;
        Mon, 25 Sep 2023 00:06:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1728C433C9;
        Mon, 25 Sep 2023 07:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695625572;
        bh=TTDK7Zmf03yl+dmjIqFNQYtRIfdHLTb5AwQJJMW/zdA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UvTXQ8O2v2WCIuSiD3YtW867B12zqSN+ZfvKJgYoFYUbS6RPeehL79EXjZpUqV7+A
         UqzL20btkmoR1/+3ZcH4Sf/wlksrMpETZQJ8TgdOiRu0/IBWwa7NBA210tjFoMPlY+
         PARa1MnumtZ8D3yykbsunGJqaW5LrKoKLJbwpM5nzi+qaqz9C/6bn1LZEBzxj0fyns
         NPqJynU0fNIlv3e0knUHK/p4fTtIMcwM/CWBOULuimeoJhkQ8SKMXtj7+DVz8WoiWY
         /zC5mlo4CyGOR9CgISTO/3i33focxJWmlqEsNGTJrhmwJ2wopIX+h2dK9ZS19Sa5jV
         1TU9rou+NsTDA==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-57bbb38d5d4so972958eaf.2;
        Mon, 25 Sep 2023 00:06:12 -0700 (PDT)
X-Gm-Message-State: AOJu0YzJeURcxZ/aQg+b77YigwnzD5Hkl1DGQw0jPefV73QLEkP1HWDC
        3vpgte/2HaIuGIuu775LDuVxhtn+cDchUhCEEt8=
X-Google-Smtp-Source: AGHT+IGI3lC4C49LN60RC9+EwUh4h9zC8sfV5QdyxOlzFnDL0/pbcVNmsrc757XG7ZHIPlX6Zh44+/4AZp/sllXMnas=
X-Received: by 2002:a05:6870:a986:b0:1c8:b715:6c81 with SMTP id
 ep6-20020a056870a98600b001c8b7156c81mr7247538oab.55.1695625572240; Mon, 25
 Sep 2023 00:06:12 -0700 (PDT)
MIME-Version: 1.0
References: <3d34a965-ab9c-d549-0c63-c717ab5d2edc@tweek.dk>
 <c2b92ff2-d077-4588-9d5c-93dfec0037ee@mailbox.org> <b85bf040-f6be-ef12-5b33-6d41991e4d97@tweek.dk>
 <CAK7LNAQVuKQ34xK8AA9M0dytb1zNpE+rUYDhi6kGDO60SYBpyw@mail.gmail.com>
 <d0016504-af19-eab5-8898-f51a8c8abdcd@tweek.dk> <CAK7LNARKiu54dRK9y8aRRFC_UrurE_qumXdv6TRJpzQ_AS1dwQ@mail.gmail.com>
In-Reply-To: <CAK7LNARKiu54dRK9y8aRRFC_UrurE_qumXdv6TRJpzQ_AS1dwQ@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 25 Sep 2023 16:05:35 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQf6YVF6yCi3tRHE9Rf0o3g2MLqfiLxyJg4-fiM6ZmBZQ@mail.gmail.com>
Message-ID: <CAK7LNAQf6YVF6yCi3tRHE9Rf0o3g2MLqfiLxyJg4-fiM6ZmBZQ@mail.gmail.com>
Subject: Re: [PATCH] Use CRC32 and a 1MiB dictionary for XZ compressed modules
To:     Martin Nybo Andersen <tweek@tweek.dk>
Cc:     Tor Vic <torvic9@mailbox.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Nick Terrell <terrelln@fb.com>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lucas De Marchi <lucas.de.marchi@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 10:34=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.=
org> wrote:
>
> On Fri, Sep 22, 2023 at 8:04=E2=80=AFPM Martin Nybo Andersen <tweek@tweek=
.dk> wrote:
> >
> >
> > On Fri, 22 Sep 2023, Masahiro Yamada wrote:
> >
> > [...]
> >
> > > Hello, sorry for the delay.
> > >
> > > I am OK with picking the patch to my tree.
> >
> > Hi,
> >
> > That sound great :)
> >
> > > I think we can use --check=3Dcrc32 --lzma2=3Ddict=3D1MiB
> > > unconditionally.
> > >
> > > (But, if the in-kernel decompressor is improved
> > > to understand CRC64 in the future, we can loosen
> > > this restriction again.)
> >
> > Of course.
> >
> > > Just small change requests.
> > >
> > > Please do not use the Fixes tag to point at the Debian bug tracker.
> > >
> > >
> > > Instead, you can do
> > >
> > > Link: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1050582
> > >
> > >   or
> > >
> > > Closes: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1050582
> > >
> > >
> > >
> > > Also, mention that this change happened in
> > >
> > > kmod commit 09c9f8c5df04 ("libkmod: Use kernel decompression when ava=
ilable")
> > >
> > > in the commit description might be helpful.
> > >
> > >
> > >
> > >
> > > I added Lukas to CC.
> > > He is the author of the change on kmod side.
> >
> > Is this ok?
>
>
> Yes, perfect!
>
> Thanks.
>


Applied to linux-kbuild. Thanks.




--=20
Best Regards
Masahiro Yamada
