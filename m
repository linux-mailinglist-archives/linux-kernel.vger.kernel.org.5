Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72B9877184E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 04:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjHGCYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 22:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjHGCYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 22:24:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A0D95
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 19:24:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8DDF761314
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 02:24:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB74AC433CC
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 02:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691375053;
        bh=1MFl7Wv7VFkUx/QWQVYQvf/6x85DYdfMcBs4zfrrnW0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=m1Sq3ud3OviOGriP+zAdwCQB6bgxPDW64rzClJqCl8vsklPyQHGINxwl2j6cJ+uj7
         nl3Mhx3Vfut40Z8b86jQH9Se5EsB3VzCGv5/Szp9obqh0SnLx06aiFhpG3lVapOpzQ
         sG1k2hVsc9wB4fv4HMa5wVHEmRaKJMNolTDqcU1r8eozS+/Xii4c7N/AtQqcM4BhKo
         UQlsCrBjCAGh/i66hvT+t9Ll8gCS0Wdo4anfpkAG3yGx/Sp+WN+6tIb6AiWvtarIpl
         Z4dCpSLJIWTNTvFJwagUxMlVWUBZ5SKL5z5udVi09CB+BG8z1GBAvuSjxCbSv4uhMG
         7xzbXw7W4FEHQ==
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3a5a7e7cd61so2681279b6e.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Aug 2023 19:24:12 -0700 (PDT)
X-Gm-Message-State: AOJu0YxztXlENKB/Hf/aB2jXlcNaM8JxZ13gxKs69efp4+vQAoNfJcyu
        qeP3nA8lhmiz8+gG8iuS322WEQBT7AW6RDGFA4Y=
X-Google-Smtp-Source: AGHT+IETw1PnCwbrYlsqpVY2SotYy1SJb6VNvtE87x6rpcGYDadehdL1gW0P4xsCXxcejyz+lgKWCruIwbMq4YffGgY=
X-Received: by 2002:a05:6808:1997:b0:3a7:5346:fcee with SMTP id
 bj23-20020a056808199700b003a75346fceemr5152219oib.0.1691375052213; Sun, 06
 Aug 2023 19:24:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230321193341.87997-1-sshedi@vmware.com> <0ae37bcc-4398-644b-a295-1245d73e5450@gmail.com>
 <2023053135-bubbling-commodore-3a7b@gregkh> <cefc1a42-725a-8afa-c222-f4df085ba6a2@gmail.com>
 <2023053148-ahead-overbite-863d@gregkh> <730c8712-1553-63e5-ffa1-d75a922f4a42@gmail.com>
 <2023060155-mustard-mating-32b7@gregkh>
In-Reply-To: <2023060155-mustard-mating-32b7@gregkh>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 7 Aug 2023 11:23:36 +0900
X-Gmail-Original-Message-ID: <CAK7LNASUmc1nFEkEvmd9VKbD6VjOs2HhpwLY-GsduRFDFGOfvg@mail.gmail.com>
Message-ID: <CAK7LNASUmc1nFEkEvmd9VKbD6VjOs2HhpwLY-GsduRFDFGOfvg@mail.gmail.com>
Subject: Re: [PATCH v6 0/7] refactor file signing program
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Shreenidhi Shedi <yesshedi@gmail.com>, dhowells@redhat.com,
        dwmw2@infradead.org, linux-kernel@vger.kernel.org,
        sshedi@vmware.com
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

On Thu, Jun 1, 2023 at 6:08=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Thu, Jun 01, 2023 at 02:33:23PM +0530, Shreenidhi Shedi wrote:
> > On Wed, 31-May-2023 22:20, Greg KH wrote:
> > > On Wed, May 31, 2023 at 09:01:24PM +0530, Shreenidhi Shedi wrote:
> > > > On Wed, 31-May-2023 20:08, Greg KH wrote:
> > > > > On Tue, Apr 25, 2023 at 04:14:49PM +0530, Shreenidhi Shedi wrote:
> > > > > > On Wed, 22-Mar-2023 01:03, Shreenidhi Shedi wrote:
> > > > > > Can you please review the latest patch series? I think I have a=
ddressed your
> > > > > > concerns. Thanks.
> > > > >
> > > > > The big question is, "who is going to use these new features"?  T=
his
> > > > > tool is only used by the in-kernel build scripts, and if they do =
not
> > > > > take advantage of these new options you have added, why are they =
needed?
> > > > >
> > > > > thanks,
> > > > >
> > > > > greg k-h
> > > >
> > > > Hi Greg,
> > > >
> > > > Thanks for the response.
> > > >
> > > > We use it in VMware Photon OS. Following is the link for the same.
> > > > https://github.com/vmware/photon/blob/master/SPECS/linux/spec_insta=
ll_post.inc#L4
> > > >
> > > > If this change goes in, it will give a slight push to our build per=
formance.
> > >
> > > What exactly do you mean by "slight push"?
> >
> > Instead of invoking the signing tool binary for each module, we can pas=
s
> > modules in bulk and it will reduce the build time by couple of seconds.
>
> Then why not modify the in-kernel build system to also do this, allowing
> everyone to save time and money (i.e. energy)?
>
> Why keep the build savings to yourself?
>
> thanks,
>
> greg k-h


If I understand correctly,
"sign-file: add support to sign modules in bulk"
is the only benefit in the patchset.

I tested the bulk option, but I did not see build savings.



My evaluation:
1.  'make allmodconfig all', then 'make modules_install'.
        (9476 modules installed)

2.  I ran 'perf stat' for single signing vs bulk signing
      (5 runs for each).
      I changed the -n option in scripts/signfile.sh




A.  single sign

Sign one module per scripts/sign-file invocation.

find "${MODULES_PATH}" -name *.ko -type f -print0 | \
        xargs -r -0 -P$(nproc) -x -n1 sh -c "..."



 Performance counter stats for './signfile-single.sh' (5 runs):

             22.33 +- 2.26 seconds time elapsed  ( +- 10.12% )




B. bulk sign

Sign 32 modules per scripts/sign-file invocation

find "${MODULES_PATH}" -name *.ko -type f -print0 | \
        xargs -r -0 -P$(nproc) -x -n32 sh -c "..."


 Performance counter stats for './signfile-bulk.sh' (5 runs):

             24.78 +- 3.01 seconds time elapsed  ( +- 12.14% )




The bulk option decreases the process forks of scripts/sign-file
but I did not get even "slight push".



--=20
Best Regards
Masahiro Yamada
