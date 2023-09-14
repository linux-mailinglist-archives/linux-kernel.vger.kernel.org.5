Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E52737A03B7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 14:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237750AbjINM0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 08:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233171AbjINM0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 08:26:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0C81FC8;
        Thu, 14 Sep 2023 05:26:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A3A2C433C8;
        Thu, 14 Sep 2023 12:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694694375;
        bh=uwlERtgcIl0boGXES+0Lt7l/GYtqRgkvwlIpXYuTrm8=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=YMGgoK0vFJEZoIZLtjMUT/xcAi3HPriqpw9cgkjwNFEh6vBAofPrJ8v0/yo0uOC7i
         XWHuPDy/xbSvaK8C6WgylQQPRgD11XSQZOPvPV2nyKDynKecvnmcmvICbUgC0GSl0b
         olHpjVrfOBE+v/pzfg6/Fpt/BDA2ydU1f2W6xVJYWNrEhFYN+N8SluW9NSyfFRJ4hw
         WdL+XNAlkrdZWstCts+UpCRGFritbMLgy3VClfw5T7vB1QsUN/VefDbGATVrz3dAfT
         fNb3B4xndSvJUymSfj8S/H4Se7SG+Jxtq46MQqTUsm3QitAbhVnl4NYIwGpPEIHCCA
         Ul/gVfgqDt2nA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 14 Sep 2023 15:26:10 +0300
Message-Id: <CVIN0M3IHRKL.3U005Y5QTOJL5@suppilovahvero>
Cc:     "Jan Hendrik Farr" <kernel@jfarr.cc>,
        <linux-kernel@vger.kernel.org>, <kexec@lists.infradead.org>,
        <x86@kernel.org>, <tglx@linutronix.de>, <dhowells@redhat.com>,
        <vgoyal@redhat.com>, <keyrings@vger.kernel.org>,
        <akpm@linux-foundation.org>, <bhe@redhat.com>,
        <bhelgaas@google.com>, <bluca@debian.org>
Subject: Re: [PATCH v2 0/2] x86/kexec: UKI Support
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Lennart Poettering" <mzxreary@0pointer.de>,
        "Philipp Rudo" <prudo@redhat.com>
X-Mailer: aerc 0.14.0
References: <20230911052535.335770-1-kernel@jfarr.cc>
 <20230913160045.40d377f9@rotkaeppchen> <ZQLTJFb3S/xn5CWo@gardel-login>
In-Reply-To: <ZQLTJFb3S/xn5CWo@gardel-login>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Sep 14, 2023 at 12:32 PM EEST, Lennart Poettering wrote:
> On Mi, 13.09.23 16:00, Philipp Rudo (prudo@redhat.com) wrote:
>
> > For example there are two definitions for the UKI which contradict each=
 other.
> > The dedicated one [1] you have cited earlier and the one in the BLS for=
 type #2
> > entries [2]. In [1] the .linux and .initrd sections are mandatory and t=
he
> > .osrel and .cmdline sections are optional while in [2] it is the other =
way
> > round. Which definition should the kernel follow?
> >
> > Furthermore, I absolutely don't understand how the spec should be read.=
 All
> > the spec does is defining some file formats. There is no word about whi=
ch
> > component in the boot chain is supposed to handle them and what exactly=
 this
> > component is supposed to do with it. But that is crucial if we want to =
add UKI
> > support for kexec as the kexec systemcall will replace the stub. So we =
need to
> > know what tasks the stub is supposed to perform. Currently this is only=
 some
> > implementation detail of the systemd-stub [3] that can change any momen=
t and I
> > strongly oppose to base any uapi on it.
> >
> > In the end the only benefit this series brings is to extend the signatu=
re
> > checking on the whole UKI except of just the kernel image. Everything e=
lse can
> > also be done in user space. Compared to the problems described above th=
is is a
> > very small gain for me.
> >
> > Until the spec got fixed I don't see a chance to add UKI support for ke=
xec.
>
> So that spec is initially just a generalization of what
> systemd-stub/systemd-boot/ukify does. The descrepancies between the
> cited specs mostly come from the that generalization. If you want to
> enumerate kernels and order them the ".osrel" stuff for example is
> necessary, hence the boot loader spec really wants it. If you don't
> care about the boot loader spec though and just want to register the
> kernel UKI PE directly in BootXXX efi vars for example, then there's
> no need to include .osrel. That all said we should certainly make the
> two specs align better, and clarify the situation. Suggestions/patches
> more than welcome.
>
> Ultimately, I think a spec written as description with a single
> implementation in mind (i.e. systemd) is a generally a bad spec. Hence
> if kexec in the Linux kernel wants to add support for it, that'd be
> great but I'd see that as an opportunity to adjust the spec to the
> needs of the Linux kernel in this area, so that it reflects well more
> than just one backend implementation.
>
> Hence, seeing the spec as set in stone and as inherently low quality
> is the wrong way to see it I am sure. Instead, the goal here is to
> adjust the spec to make it work really nicely for *both* systemd and
> the kernel.

Bringing better backing story [1] would also help the spec. Immeditaly
when there's some reflection surface, also the possible faults it the
spec become more apparent. Also this makes spec refinement less boring,
which can be boring and tedious if you write it isolated by yourself or
in a small group :-)

I need to check if I could with some effort extend my current testing
environment for UKI [2]. Need to study this better at some point.

> Lennart
>
> --
> Lennart Poettering, Berlin

[1] https://social.kernel.org/notice/AZklKOsIYBZXDL9Bya
[2] https://github.com/jarkkojs/buildroot-tpmdd/compare/master...linux-6.5.=
y

BR, JKarkko
