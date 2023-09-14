Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D2E7A0955
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 17:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241014AbjINPeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 11:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240810AbjINPeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 11:34:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F39CE;
        Thu, 14 Sep 2023 08:33:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D029BC433C8;
        Thu, 14 Sep 2023 15:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694705636;
        bh=1KeR15MR0lzhn5Kwe9u+YNeU4/nutLkkCZN5KZakWas=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=rPamIDWjidl9aoOdYu4538eyG1jHEMWZEg2hgseAtAW4443e47amuR6bw/Z9KkHUn
         gA88wNMgwOUjCzTKID4ynAYNOFuqz3SbokqFHhFMuvZKopusr9QQXjsY3RkU60FNki
         A0mreV9IOF68fihVtB9m67vAE7uJbSfi73xxxKFnZv7jO1owPQEKT3yszKrZWsSBkw
         1/gJJcuJNndyGRRLwtpQ5mVVSVZ6M6EddjOl2CF6S3+3WWXutNxsYzWJOqYPpEi3yG
         XJkH6wkft6EOtfyYZP6VFdP4+sOSL2oApCfjPC5BsXAV/gGyXN7gZFPMqP6468h9R8
         M8EItT4mbi1Vw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 14 Sep 2023 18:33:51 +0300
Message-Id: <CVIR0BGHX3VS.39FY5QL8KXR0F@suppilovahvero>
Cc:     "Jan Hendrik Farr" <kernel@jfarr.cc>,
        <linux-kernel@vger.kernel.org>, <kexec@lists.infradead.org>,
        <x86@kernel.org>, <tglx@linutronix.de>, <dhowells@redhat.com>,
        <vgoyal@redhat.com>, <keyrings@vger.kernel.org>,
        <akpm@linux-foundation.org>, <bhe@redhat.com>,
        <bhelgaas@google.com>, <bluca@debian.org>
Subject: Re: [PATCH v2 0/2] x86/kexec: UKI Support
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Jarkko Sakkinen" <jarkko@kernel.org>,
        "Lennart Poettering" <mzxreary@0pointer.de>,
        "Philipp Rudo" <prudo@redhat.com>
X-Mailer: aerc 0.14.0
References: <20230911052535.335770-1-kernel@jfarr.cc>
 <20230913160045.40d377f9@rotkaeppchen> <ZQLTJFb3S/xn5CWo@gardel-login>
 <CVIN0M3IHRKL.3U005Y5QTOJL5@suppilovahvero>
In-Reply-To: <CVIN0M3IHRKL.3U005Y5QTOJL5@suppilovahvero>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Sep 14, 2023 at 3:26 PM EEST, Jarkko Sakkinen wrote:
> On Thu Sep 14, 2023 at 12:32 PM EEST, Lennart Poettering wrote:
> > On Mi, 13.09.23 16:00, Philipp Rudo (prudo@redhat.com) wrote:
> >
> > > For example there are two definitions for the UKI which contradict ea=
ch other.
> > > The dedicated one [1] you have cited earlier and the one in the BLS f=
or type #2
> > > entries [2]. In [1] the .linux and .initrd sections are mandatory and=
 the
> > > .osrel and .cmdline sections are optional while in [2] it is the othe=
r way
> > > round. Which definition should the kernel follow?
> > >
> > > Furthermore, I absolutely don't understand how the spec should be rea=
d. All
> > > the spec does is defining some file formats. There is no word about w=
hich
> > > component in the boot chain is supposed to handle them and what exact=
ly this
> > > component is supposed to do with it. But that is crucial if we want t=
o add UKI
> > > support for kexec as the kexec systemcall will replace the stub. So w=
e need to
> > > know what tasks the stub is supposed to perform. Currently this is on=
ly some
> > > implementation detail of the systemd-stub [3] that can change any mom=
ent and I
> > > strongly oppose to base any uapi on it.
> > >
> > > In the end the only benefit this series brings is to extend the signa=
ture
> > > checking on the whole UKI except of just the kernel image. Everything=
 else can
> > > also be done in user space. Compared to the problems described above =
this is a
> > > very small gain for me.
> > >
> > > Until the spec got fixed I don't see a chance to add UKI support for =
kexec.
> >
> > So that spec is initially just a generalization of what
> > systemd-stub/systemd-boot/ukify does. The descrepancies between the
> > cited specs mostly come from the that generalization. If you want to
> > enumerate kernels and order them the ".osrel" stuff for example is
> > necessary, hence the boot loader spec really wants it. If you don't
> > care about the boot loader spec though and just want to register the
> > kernel UKI PE directly in BootXXX efi vars for example, then there's
> > no need to include .osrel. That all said we should certainly make the
> > two specs align better, and clarify the situation. Suggestions/patches
> > more than welcome.
> >
> > Ultimately, I think a spec written as description with a single
> > implementation in mind (i.e. systemd) is a generally a bad spec. Hence
> > if kexec in the Linux kernel wants to add support for it, that'd be
> > great but I'd see that as an opportunity to adjust the spec to the
> > needs of the Linux kernel in this area, so that it reflects well more
> > than just one backend implementation.
> >
> > Hence, seeing the spec as set in stone and as inherently low quality
> > is the wrong way to see it I am sure. Instead, the goal here is to
> > adjust the spec to make it work really nicely for *both* systemd and
> > the kernel.
>
> Bringing better backing story [1] would also help the spec. Immeditaly
> when there's some reflection surface, also the possible faults it the
> spec become more apparent. Also this makes spec refinement less boring,
> which can be boring and tedious if you write it isolated by yourself or
> in a small group :-)
>
> I need to check if I could with some effort extend my current testing
> environment for UKI [2]. Need to study this better at some point.
>
> > Lennart
> >
> > --
> > Lennart Poettering, Berlin
>
> [1] https://social.kernel.org/notice/AZklKOsIYBZXDL9Bya
> [2] https://github.com/jarkkojs/buildroot-tpmdd/compare/master...linux-6.=
5.y
>
> BR, JKarkko

I need to revisit one some months olds patch set from Matthew Garrett.
It was about encrypted hibernate.

I don't recall exactly what was the problem with PCR sealing but want
to check. This is not hunch that this would affect the current patch
set in review. Just want to revisit to remember why it did not go
through in the end.

BTW, would not be a bad idea to extend CC list to at least Matthew and
James Bottomley on this patch.

BR, Jarkko
