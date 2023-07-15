Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C8475471F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 08:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjGOGv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 02:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjGOGvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 02:51:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3396C30D8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 23:51:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 827D160A1D
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 06:51:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB30EC433C8;
        Sat, 15 Jul 2023 06:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689403910;
        bh=QNB2DkyjfqzOQ8iY3jTAhBsjHcFetBFasqwW+R88GSM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ju08qcERhBrEiGxj/CMEt86NXAKuG8e3c24DQaPQxqGYF0lDAqUktk23kOCQFaTJ0
         Bt2wOa6xz6tjVrm38a1cbjzNWQ5+5AbMpgF9ZpDygmgO8Eg5AYpBWOhtDp4GhWGH8S
         ht122J5HZP8VANSo351rBf52MF63hR8HzrxqLz6Q=
Date:   Sat, 15 Jul 2023 08:51:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luca Boccassi <bluca@debian.org>
Cc:     Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, lennart@poettering.net,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2] x86/boot: add .sbat section to the bzImage
Message-ID: <2023071552-quilt-tranquil-b7bf@gregkh>
References: <2023071239-progress-molasses-3b3d@gregkh>
 <CAMw=ZnRheXk7W_r-32bGymbHKdXc7aKUpwGAOX+k7DJkN+DiCQ@mail.gmail.com>
 <2023071229-dusk-repacking-da3a@gregkh>
 <CAMw=ZnSmZTBs+bJsQ_Y2CVO8K3OTuHOZDKW4cbxKpGbo4Vgs7Q@mail.gmail.com>
 <2023071226-crafty-deviator-12e2@gregkh>
 <CAMw=ZnRjnxWnmoFuw2prxFS55vAGQ1hpfKeHYFfG5Oa0LB_jYA@mail.gmail.com>
 <2023071233-empirical-overturn-744c@gregkh>
 <CAMw=ZnRRviBNi_LK9VOSUV9PNHe3jurUcLfgLpbTOsp_eE4WyA@mail.gmail.com>
 <2023071350-specked-botanist-6ba8@gregkh>
 <CAMw=ZnQZ9ds3xsa2AZv_F13dB6rR4XzGPrBjJHSga1oU5xRezQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMw=ZnQZ9ds3xsa2AZv_F13dB6rR4XzGPrBjJHSga1oU5xRezQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 01:29:20AM +0100, Luca Boccassi wrote:
> On Thu, 13 Jul 2023 at 07:09, Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Jul 12, 2023 at 10:50:45PM +0100, Luca Boccassi wrote:
> > > > Who is going to be responsible for determining that this number needs to
> > > > be updated?
> > >
> > > Most likely those who understand the problem space - largely the group
> > > of people maintaining the EFI stack, with various inputs, I imagine.
> > > That's how it currently works for various bootloaders.
> >
> > We need specifics and to have people agree to do this, otherwise, again,
> > this patch is useless.
> 
> Not really, as this is about mechanism, not process.

And this right here is why everyone is both so mad at this patch from
our side, and so confused about patch from the developer's side.

To think that "let's add a security canary to the kernel image" is
anything other than a process issue, shows a lack of understanding about
exactly how the kernel is released, how the existing kernel security
response team works, and who does any of this work.  To ignore that
means that there is no way in the world this can ever be accepted.

> > > > What is their response time?
> > > >
> > > > Who will they be submitting the patch to this string in order to have it
> > > > change?
> > >
> > > A bit too soon for exact details on processes given where we are, I think.
> >
> > Not at all, this is a proposal for a "security flag" for the kernel,
> > getting this all decided now is the only correct way to determine if
> > this is actually something that can work properly.
> 
> No, the question here was about mechanism and storage. And it already
> works btw, it's just the kernel that's lagging behind, as usual.

Perhaps this is on purpose as many of us consider this type of thing
nothing more than "security theatre" that will not work for a project
like ours?

> > To just go "we are going to randomly add a number that will sometimes be
> > incremented in the future to determine the buggyness of the kernel
> > without saying who will control this, or how it will be done" is crazy.
> >
> > Would other operating systems or projects accept such a change without
> > this information?
> >
> > Would you take this patch if you were responsible for kernel releases?
> 
> I think you are still missing one tiny bit of information: it is
> already used in other projects
> 
> $ sudo objcopy -O binary --only-section=.sbat
> /boot/efi/EFI/Debian/grubx64.efi /dev/stdout
> sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
> grub,3,Free Software Foundation,grub,2.06,https://www.gnu.org/software/grub/
> grub.debian,4,Debian,grub2,2.06-13,https://tracker.debian.org/pkg/grub2

Nice, and what describes the process that the grub team uses to set that
number?  Where is that document and team that does this work?

And frankly, grub is nothing more than a tiny project compared to the
kernel, with the huge majority of the world's users of Linux not even
using grub at all.  So of course the use of grub for this might just be
a bit different as to how Linux should be using it.

> > > > How long will this feature have to be maintained?
> > >
> > > Until something else supplants EFI, I'd imagine
> >
> > So 40+ years, great, who is going to fund that?
> 
> Who funds EFI work?

UEFI the spec is funded by various companies (Intel, et-all).  So you
are saying that these companies also need to do this development too?
Have you got them to agree to this?  If so, great, let's get their
signed-off-by on it please.

Otherwise you all are saying "someone else will do all of this process
work", which frankly, is totally insulting to those of us who _do_ do
all of the process work for security issues and kernel releases.

> > > > We have a plethora of kernel changes in our history to learn from here,
> > > > please do so and show how this will affect us going forward based on our
> > > > past, otherwise we have no way of knowing how any of this is going to
> > > > work.
> > >
> > > I am not aware of anything similar enough, but please do point those
> > > out if you are.
> >
> > Audit our past history and document when the number would have changed
> > please.
> 
> Sure, where do I send the invoice?

If you are not willing to take the time to determine how this proposed
change will affect the kernel developers and infrastructure by doing
some modeling based on our past history, then we have no reason to even
consider accepting this change as you are stating that you have no idea
how it will affect us.

sorry,

greg k-h
