Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3A37A0019
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 11:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235938AbjINJcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 05:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235935AbjINJc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 05:32:28 -0400
X-Greylist: delayed 2603 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 14 Sep 2023 02:32:23 PDT
Received: from gardel.0pointer.net (gardel.0pointer.net [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA281BF2;
        Thu, 14 Sep 2023 02:32:23 -0700 (PDT)
Received: from gardel-login.0pointer.net (gardel-mail [85.214.157.71])
        by gardel.0pointer.net (Postfix) with ESMTP id 1A4E2E801F5;
        Thu, 14 Sep 2023 11:32:21 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
        id A2B45160258; Thu, 14 Sep 2023 11:32:20 +0200 (CEST)
Date:   Thu, 14 Sep 2023 11:32:20 +0200
From:   Lennart Poettering <mzxreary@0pointer.de>
To:     Philipp Rudo <prudo@redhat.com>
Cc:     Jan Hendrik Farr <kernel@jfarr.cc>, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, x86@kernel.org, tglx@linutronix.de,
        dhowells@redhat.com, vgoyal@redhat.com, keyrings@vger.kernel.org,
        akpm@linux-foundation.org, bhe@redhat.com, bhelgaas@google.com,
        bluca@debian.org
Subject: Re: [PATCH v2 0/2] x86/kexec: UKI Support
Message-ID: <ZQLTJFb3S/xn5CWo@gardel-login>
References: <20230911052535.335770-1-kernel@jfarr.cc>
 <20230913160045.40d377f9@rotkaeppchen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913160045.40d377f9@rotkaeppchen>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mi, 13.09.23 16:00, Philipp Rudo (prudo@redhat.com) wrote:

> For example there are two definitions for the UKI which contradict each other.
> The dedicated one [1] you have cited earlier and the one in the BLS for type #2
> entries [2]. In [1] the .linux and .initrd sections are mandatory and the
> .osrel and .cmdline sections are optional while in [2] it is the other way
> round. Which definition should the kernel follow?
>
> Furthermore, I absolutely don't understand how the spec should be read. All
> the spec does is defining some file formats. There is no word about which
> component in the boot chain is supposed to handle them and what exactly this
> component is supposed to do with it. But that is crucial if we want to add UKI
> support for kexec as the kexec systemcall will replace the stub. So we need to
> know what tasks the stub is supposed to perform. Currently this is only some
> implementation detail of the systemd-stub [3] that can change any moment and I
> strongly oppose to base any uapi on it.
>
> In the end the only benefit this series brings is to extend the signature
> checking on the whole UKI except of just the kernel image. Everything else can
> also be done in user space. Compared to the problems described above this is a
> very small gain for me.
>
> Until the spec got fixed I don't see a chance to add UKI support for kexec.

So that spec is initially just a generalization of what
systemd-stub/systemd-boot/ukify does. The descrepancies between the
cited specs mostly come from the that generalization. If you want to
enumerate kernels and order them the ".osrel" stuff for example is
necessary, hence the boot loader spec really wants it. If you don't
care about the boot loader spec though and just want to register the
kernel UKI PE directly in BootXXX efi vars for example, then there's
no need to include .osrel. That all said we should certainly make the
two specs align better, and clarify the situation. Suggestions/patches
more than welcome.

Ultimately, I think a spec written as description with a single
implementation in mind (i.e. systemd) is a generally a bad spec. Hence
if kexec in the Linux kernel wants to add support for it, that'd be
great but I'd see that as an opportunity to adjust the spec to the
needs of the Linux kernel in this area, so that it reflects well more
than just one backend implementation.

Hence, seeing the spec as set in stone and as inherently low quality
is the wrong way to see it I am sure. Instead, the goal here is to
adjust the spec to make it work really nicely for *both* systemd and
the kernel.

Lennart

--
Lennart Poettering, Berlin
