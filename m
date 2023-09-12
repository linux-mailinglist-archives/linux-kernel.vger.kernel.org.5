Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6436D79CE82
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 12:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233257AbjILKiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 06:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234297AbjILKh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 06:37:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E385171B;
        Tue, 12 Sep 2023 03:37:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEDECC433C8;
        Tue, 12 Sep 2023 10:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694515072;
        bh=dxP4B+yMelLzCrvZ7SL2av9sUsV6Kpduc789X1rtOVc=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=EPXRQ9TdnHqdeF5sFt3tTrzUsBlm6Q/olAvgVQ2rMTpPetLVuUzhQPUKSQ1so1hLG
         v9Vc1UxTq77QYGhGTxQsi9yfa9vTh+zty9gpG9qa1da0L0j1EEWZmMFnkEUpOBxt4U
         p2YHCVwvVxaufhJs5g/rYd/KgunZc9g8F6kXGnMnEPiL3zYvaneh/+kIk5g9krGA0+
         lI2jHl6f1lvPHzMkR5hOIIeHfiuIg88fzcQoTCngedWKSoHfTCf/cEUCfojyASNPFt
         /bn9KlFLocBmIK9pmIJis366CIhYuRIoEmk1qvF+DS5Q2U8AQn06PeGmnGB6kUbSXT
         eGtLs4oOfee+w==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 12 Sep 2023 13:37:47 +0300
Message-Id: <CVGVGJIQPIZ2.WN97L6BV5S97@suppilovahvero>
Cc:     "Jan Hendrik Farr" <kernel@jfarr.cc>,
        <linux-kernel@vger.kernel.org>,
        <systemd-devel@lists.freedesktop.org>, <x86@kernel.org>,
        <kexec@lists.infradead.org>, <dhowells@redhat.com>,
        <keyrings@vger.kernel.org>, <bluca@debian.org>,
        <bhelgaas@google.com>, <tglx@linutronix.de>,
        <akpm@linux-foundation.org>
Subject: Re: [systemd-devel] [PATCH 0/1] x86/kexec: UKI support
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Neal Gompa" <ngompa13@gmail.com>
X-Mailer: aerc 0.14.0
References: <20230909161851.223627-1-kernel@jfarr.cc>
 <CVGFE6FRWFHR.DVG9NUQID4EA@suppilovahvero>
 <CAEg-Je9GF5S+QcsspM_CzDSxzCN8h2eRp7BbctC1x7-rH8j68g@mail.gmail.com>
In-Reply-To: <CAEg-Je9GF5S+QcsspM_CzDSxzCN8h2eRp7BbctC1x7-rH8j68g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Sep 12, 2023 at 2:20 AM EEST, Neal Gompa wrote: > On Mon, Sep 11, 20=
23 at 7:15=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > On Sat Sep 9, 2023 at 7:18 PM EEST, Jan Hendrik Farr wrote:
> > > Hello,
> > >
> > > this patch implements UKI support for kexec_file_load. It will requir=
e support
> > > in the kexec-tools userspace utility. For testing purposes the follow=
ing can be used:
> > > https://github.com/Cydox/kexec-test/
> > >
> > > There has been discussion on this topic in an issue on GitHub that is=
 linked below
> > > for reference.
> > >
> > >
> > > Some links:
> > > - Related discussion: https://github.com/systemd/systemd/issues/28538
> > > - Documentation of UKIs: https://uapi-group.org/specifications/specs/=
unified_kernel_image/
> > >
> > > Jan Hendrik Farr (1):
> > >   x86/kexec: UKI support
> > >
> > >  arch/x86/include/asm/kexec-uki.h       |   7 ++
> > >  arch/x86/include/asm/parse_pefile.h    |  32 +++++++
> > >  arch/x86/kernel/Makefile               |   2 +
> > >  arch/x86/kernel/kexec-uki.c            | 113 +++++++++++++++++++++++=
++
> > >  arch/x86/kernel/machine_kexec_64.c     |   2 +
> > >  arch/x86/kernel/parse_pefile.c         | 110 +++++++++++++++++++++++=
+
> > >  crypto/asymmetric_keys/mscode_parser.c |   2 +-
> > >  crypto/asymmetric_keys/verify_pefile.c | 110 +++--------------------=
-
> > >  crypto/asymmetric_keys/verify_pefile.h |  16 ----
> > >  9 files changed, 278 insertions(+), 116 deletions(-)
> > >  create mode 100644 arch/x86/include/asm/kexec-uki.h
> > >  create mode 100644 arch/x86/include/asm/parse_pefile.h
> > >  create mode 100644 arch/x86/kernel/kexec-uki.c
> > >  create mode 100644 arch/x86/kernel/parse_pefile.c
> > >
> > > --
> > > 2.40.1
> >
> > What the heck is UKI?
>
> Unified Kernel Images. More details available here:
> https://uapi-group.org/specifications/specs/unified_kernel_image/
>
> It's a way of creating initramfs-style images as fully generic,
> reproducible images that can be built server-side.

You can build today a kernel with these compiled in:

1. EFI stub
2. initeramfs
3. cmdline

Why another way (and label 'UKI') for a pre-existing feature?

BR, Jarkko
