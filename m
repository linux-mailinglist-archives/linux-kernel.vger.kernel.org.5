Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A1A7A0D8E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 20:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241612AbjINSx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 14:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241928AbjINSxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:53:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BFAAB26B5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 11:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694717519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Iu+JS5SuMu+Jb9YHdE7JVS58pPUJ1Oe641flT3ImSMA=;
        b=hfUsnhQWUjmY7kl/SYtglmTCTwzv3zmMTLzfx9066rFocU49F5a1vIiobPSTzvXcvJowVw
        V81ABgsPs5m5ixyUJm2OrxshN3k6ZGmOrvm6UaLLsXoIM3ujZKpqqkGx7vFl6ndZRQewUf
        Q2b8YFp0KmHhNMgUmofwvkDPTG5I7f8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-202-FJE1Tg3ROKupQEIU_u9tlA-1; Thu, 14 Sep 2023 14:51:56 -0400
X-MC-Unique: FJE1Tg3ROKupQEIU_u9tlA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1C86D9700AF;
        Thu, 14 Sep 2023 18:51:54 +0000 (UTC)
Received: from rotkaeppchen (unknown [10.39.194.190])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C5C2640C6EA8;
        Thu, 14 Sep 2023 18:51:51 +0000 (UTC)
Date:   Thu, 14 Sep 2023 20:51:49 +0200
From:   Philipp Rudo <prudo@redhat.com>
To:     Lennart Poettering <mzxreary@0pointer.de>
Cc:     Jan Hendrik Farr <kernel@jfarr.cc>, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, x86@kernel.org, tglx@linutronix.de,
        dhowells@redhat.com, vgoyal@redhat.com, keyrings@vger.kernel.org,
        akpm@linux-foundation.org, bhe@redhat.com, bhelgaas@google.com,
        bluca@debian.org
Subject: Re: [PATCH v2 0/2] x86/kexec: UKI Support
Message-ID: <20230914205149.51031bc9@rotkaeppchen>
In-Reply-To: <ZQLTJFb3S/xn5CWo@gardel-login>
References: <20230911052535.335770-1-kernel@jfarr.cc>
        <20230913160045.40d377f9@rotkaeppchen>
        <ZQLTJFb3S/xn5CWo@gardel-login>
Organization: Red Hat inc.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lennart,

On Thu, 14 Sep 2023 11:32:20 +0200
Lennart Poettering <mzxreary@0pointer.de> wrote:

> On Mi, 13.09.23 16:00, Philipp Rudo (prudo@redhat.com) wrote:
> 
> > For example there are two definitions for the UKI which contradict each other.
> > The dedicated one [1] you have cited earlier and the one in the BLS for type #2
> > entries [2]. In [1] the .linux and .initrd sections are mandatory and the
> > .osrel and .cmdline sections are optional while in [2] it is the other way
> > round. Which definition should the kernel follow?
> >
> > Furthermore, I absolutely don't understand how the spec should be read. All
> > the spec does is defining some file formats. There is no word about which
> > component in the boot chain is supposed to handle them and what exactly this
> > component is supposed to do with it. But that is crucial if we want to add UKI
> > support for kexec as the kexec systemcall will replace the stub. So we need to
> > know what tasks the stub is supposed to perform. Currently this is only some
> > implementation detail of the systemd-stub [3] that can change any moment and I
> > strongly oppose to base any uapi on it.
> >
> > In the end the only benefit this series brings is to extend the signature
> > checking on the whole UKI except of just the kernel image. Everything else can
> > also be done in user space. Compared to the problems described above this is a
> > very small gain for me.
> >
> > Until the spec got fixed I don't see a chance to add UKI support for kexec.  
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

Thanks for the explanation. I know that writing a spec isn't easy and
no matter how hard you try it will never be "perfect". That's why I
think it's important to have a proper Introduction at the beginning of
the spec that gives a context to the reader on the problem the spec is
trying to solve, the different use cases/environments considered
while writing the spec, the different components involved and how they
interact with each other, which limitations there are, etc.. The BLS
sort of has it (if you also consider the "Additional discussion") but
for the UKI the introduction basically boils down to "it's a file that
contains stuff", which isn't very helpful. Having such a context not
only makes it easier to understand where such contradictions come from
but also help to prevent problems where people from different
backgrounds interpret the spec differently because they look at it from
their context.

An other thing I don't understand is, why the Extension Images (I
assume describe the "Companion Files" in the systmd-stub man pages) are
a separate spec. With the initrd and cmdline being part of the UKI and
thus fixed you take away a lot of flexibility users have today. These
extensions bring back part of the flexibility which IMHO is needed by
general purpose distros as for them a simple one-size-fits-all solution
doesn't work. That's why for me both belong together and thus should be
described in the same spec.

The extensions are also a good example why you need to properly define
the different components and their responsibility. In a secureboot
environment these extensions need to be signed and verified during
boot. But wich component is responsible to check the signature? Is it
the stub? The kernel? or even the initrd? If you don't define that in
the spec you will eventually end up in situations where nobody checks
the signature because everybody is sure it's "someone else's job".

> Ultimately, I think a spec written as description with a single
> implementation in mind (i.e. systemd) is a generally a bad spec. Hence
> if kexec in the Linux kernel wants to add support for it, that'd be
> great but I'd see that as an opportunity to adjust the spec to the
> needs of the Linux kernel in this area, so that it reflects well more
> than just one backend implementation.

Fully agree. I must admit my first mail sounds pretty negative. But I
don't oppose the UKI. All I wanted to say that at the moment the spec
doesn't work for the kernel. But it can (and should) be fixed.

In this context I hope it is also clear to you that when more and more
people rely on the spec you need a more formal process when including
changes. Especially when the change might break the implementation of
others. So no more making the .cmdline optional and allowing it to be
overwritten all on the same day.

Having that said, what does "local override" exactly mean? Does that
mean a distro can allow a user to freely choose the cmdline without
checking any signatures? I.e. does that mean we can get rid of this
https://github.com/systemd/systemd/issues/24539

> Hence, seeing the spec as set in stone and as inherently low quality
> is the wrong way to see it I am sure. Instead, the goal here is to
> adjust the spec to make it work really nicely for *both* systemd and
> the kernel.

Sorry, I never wanted to intend that the spec inherently low quality.
Just that it doesn't meat my expectations, yet. But that is fine. The
spec isn't even a year old and there's only a single implementation,
yet. So it's more documentation rather than a spec.

Furthermore I don't expect the spec to be ever "set in stone". A spec
always needs to adjust to an ever changing world. If it doesn't it's
dead. But once other people rely on it you mustn't break backward
compatibility. Meaning the more people rely on it the more careful you
have to be which changes you make.

Anyway, I hope I could make clear what my pain points are and by
that help to make it work for both sides.

Thanks
Philipp

> Lennart
> 
> --
> Lennart Poettering, Berlin
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

