Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9CD7ADD56
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 18:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbjIYQnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 12:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjIYQnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 12:43:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09833EE;
        Mon, 25 Sep 2023 09:43:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D39D3C433C7;
        Mon, 25 Sep 2023 16:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695660223;
        bh=iptOd//4GXzFCwWM9L7SD9q66r8M+qbkCRBfCuZ7Lpk=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=Uvf/hphfDgJaZQyn421/HgoOCcUfj4eh11ZR8eHsjXR8AgyYeLMVz7vpkGE0/CnJa
         G7MJ/WUDsM+rHitk9O2s31pM7V17eIhVWAiGffpXh2u5YB5mgSSRB+Y7CJJTmFt0iT
         D8ZRphEtpfdkL3mW5IHg8/UOR4rBCxb8LrMsQeRno24Jw2qXjJ1tFihK2ZFHoyu4z+
         +1Dy71DHUw5FkD2D01dmlJN+bhGmpeLYEb34paru+Qsvt+vFNgxFCQX4frsUIMMnI2
         MvwBfc2D0hqmNsYgUfZjvlDTBXLQwUsVkI5Q+05rP3A8w8BAHBck/xY3Ayx5JpcvmC
         h6cDJWho5QTcQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 25 Sep 2023 19:43:38 +0300
Message-Id: <CVS5DQME8XMT.2DEPELDXBPGIX@suppilovahvero>
Subject: Re: [systemd-devel] [PATCH 0/1] x86/kexec: UKI support
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Dimitri John Ledkov" <dimitri.ledkov@canonical.com>
Cc:     "Neal Gompa" <ngompa13@gmail.com>,
        <systemd-devel@lists.freedesktop.org>, <x86@kernel.org>,
        <kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <dhowells@redhat.com>, <keyrings@vger.kernel.org>,
        <bhelgaas@google.com>, "Jan Hendrik Farr" <kernel@jfarr.cc>,
        <tglx@linutronix.de>, <akpm@linux-foundation.org>,
        <bluca@debian.org>
X-Mailer: aerc 0.14.0
References: <20230909161851.223627-1-kernel@jfarr.cc>
 <CVGFE6FRWFHR.DVG9NUQID4EA@suppilovahvero>
 <CAEg-Je9GF5S+QcsspM_CzDSxzCN8h2eRp7BbctC1x7-rH8j68g@mail.gmail.com>
 <CVGVGJIQPIZ2.WN97L6BV5S97@suppilovahvero>
 <CADWks+bRm9LnujBo1SiATDfC1sCNU0vvCy_r=YBpYLXcQrbQeA@mail.gmail.com>
In-Reply-To: <CADWks+bRm9LnujBo1SiATDfC1sCNU0vvCy_r=YBpYLXcQrbQeA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Sep 18, 2023 at 6:41 PM EEST, Dimitri John Ledkov wrote:
> On Tue, 12 Sept 2023 at 11:38, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >
> > On Tue Sep 12, 2023 at 2:20 AM EEST, Neal Gompa wrote: > On Mon, Sep 11=
, 2023 at 7:15=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > > > On Sat Sep 9, 2023 at 7:18 PM EEST, Jan Hendrik Farr wrote:
> > > > > Hello,
> > > > >
> > > > > this patch implements UKI support for kexec_file_load. It will re=
quire support
> > > > > in the kexec-tools userspace utility. For testing purposes the fo=
llowing can be used:
> > > > > https://github.com/Cydox/kexec-test/
> > > > >
> > > > > There has been discussion on this topic in an issue on GitHub tha=
t is linked below
> > > > > for reference.
> > > > >
> > > > >
> > > > > Some links:
> > > > > - Related discussion: https://github.com/systemd/systemd/issues/2=
8538
> > > > > - Documentation of UKIs: https://uapi-group.org/specifications/sp=
ecs/unified_kernel_image/
> > > > >
> > > > > Jan Hendrik Farr (1):
> > > > >   x86/kexec: UKI support
> > > > >
> > > > >  arch/x86/include/asm/kexec-uki.h       |   7 ++
> > > > >  arch/x86/include/asm/parse_pefile.h    |  32 +++++++
> > > > >  arch/x86/kernel/Makefile               |   2 +
> > > > >  arch/x86/kernel/kexec-uki.c            | 113 +++++++++++++++++++=
++++++
> > > > >  arch/x86/kernel/machine_kexec_64.c     |   2 +
> > > > >  arch/x86/kernel/parse_pefile.c         | 110 +++++++++++++++++++=
+++++
> > > > >  crypto/asymmetric_keys/mscode_parser.c |   2 +-
> > > > >  crypto/asymmetric_keys/verify_pefile.c | 110 +++----------------=
-----
> > > > >  crypto/asymmetric_keys/verify_pefile.h |  16 ----
> > > > >  9 files changed, 278 insertions(+), 116 deletions(-)
> > > > >  create mode 100644 arch/x86/include/asm/kexec-uki.h
> > > > >  create mode 100644 arch/x86/include/asm/parse_pefile.h
> > > > >  create mode 100644 arch/x86/kernel/kexec-uki.c
> > > > >  create mode 100644 arch/x86/kernel/parse_pefile.c
> > > > >
> > > > > --
> > > > > 2.40.1
> > > >
> > > > What the heck is UKI?
> > >
> > > Unified Kernel Images. More details available here:
> > > https://uapi-group.org/specifications/specs/unified_kernel_image/
> > >
> > > It's a way of creating initramfs-style images as fully generic,
> > > reproducible images that can be built server-side.
> >
> > You can build today a kernel with these compiled in:
> >
> > 1. EFI stub
> > 2. initeramfs
> > 3. cmdline
> >
> > Why another way (and label 'UKI') for a pre-existing feature?
> >
>
> In Ubuntu, we have considered to use the existing kernel features
> before going off to use UKI. Here are some of the reasons why we
> didn't opt to use the kernel builtin things:
> 1) we wanted to have ability to have TPM measured kernel commandline
> performed before kernel is being executed, which is what sd-stub
> provides us

OK this does make a lot of sense.

> 2) we wanted to have ability to update / regenerate initrd, without
> rebuilding kernel. Thus whenever userspace in the initrd needs
> updating, we can generate new initrd for existing kernel build, create
> new kernel.efi, whilst using existing .linux / vmlinuz build. I don't
> believe it is currently trivial to relink vmlinuz with builtin initrd.
> 3) licensing wise it was not clear if initrd has to be GPLv2
> compatible when linked inside vmlinuz, or if it can contain GPLv3 /
> LGPLv3 userspace code - with UKI it is believed unambigiously true,
> because vmlinuz boots by itself standalone and is compiled separately
> of the UKI.

Right UKI wraps kernel and kernel is a "leaf object".

> 4) we wanted to have ability to override cmdline via kernel args
> without secureboot, and use stock cmdline args under secureboot, to
> allow debugging & production behaviour from a single signed kernel.efi
> (that was custom development, and could be done in the stock vmlinuz
> too).
> 5) obvious mention, the intention here is to have TPM PCR measurements
> and Secureboot signature for vmlinuz and initrd and cmdline and dtb.
> There is otherwise no support for standalone signed initrd, cmdline,
> dtb today. Nor does vendoring it into vmlinuz achieves this to the
> same extent (and ease of predicting for sealing / resealing purposes).

ok

> 6) in Ubuntu kernel.efi also has sbat section for targeted revocations
> (discussed separately elsewhere)
>
> Overall, it is mostly about flexibility to be able to reuse the same
> initrd against multiple kernel builds, or update use multiple initrd
> against the same kernel build. This is imho the biggest issue with
> using initrd built-into the vmlinuz itself.
> Resource wise, the initrd passed in via kernel.efi can be freed, as
> far as I understand. I don't know if the one built-into the vmlinuz is
> freeable.
>
> Improving design to do something else instead of UKI would be
> welcomed. Or for example improving the zimg linus upstream format to
> be a partial or a valid UKI would help as well. For example, building
> the kernel built-in initrd as a .initrd section that is replacable
> would be nice, or allowing to preload zimg with .dtb or .cmdline
> sections would help, and appropriately improve the linux efi stab to
> do measurements and loading of .dtb / .initrd from itself would be
> nice. Because then all the benefits / requirements described above
> could be made available out of the box and be trivially updatable. The
> biggest one being splitting out things into sections that can be
> updated with objcopy.

BR, Jarkko
