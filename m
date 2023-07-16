Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC43A755057
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 20:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjGPS2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 14:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGPS2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 14:28:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0041B1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 11:28:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 363F260DFF
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 18:28:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16C58C433C7;
        Sun, 16 Jul 2023 18:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689532093;
        bh=TvSLpSoyWHgy9Op/xWVPjCIyr4yFCkIKFdtCM5zapDA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j4UTepLBcgQjpmKzy8qyTMVTz0M5JN4EgwuH4PPMsaaagVtPYAGNzOHQrER/Buddy
         D8BBmlTmdQskdtGrD/nM1hG8GWqfItj2R4DWroeH7UBLsEQlmejUlSDGko6mG9szV/
         X4zQ9UAHFagv5NPNblONUXaPNAi7Jr/03ltwgtiI=
Date:   Sun, 16 Jul 2023 20:28:10 +0200
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
Message-ID: <2023071643-broiler-level-afbf@gregkh>
References: <2023071229-dusk-repacking-da3a@gregkh>
 <CAMw=ZnSmZTBs+bJsQ_Y2CVO8K3OTuHOZDKW4cbxKpGbo4Vgs7Q@mail.gmail.com>
 <2023071226-crafty-deviator-12e2@gregkh>
 <CAMw=ZnRjnxWnmoFuw2prxFS55vAGQ1hpfKeHYFfG5Oa0LB_jYA@mail.gmail.com>
 <2023071233-empirical-overturn-744c@gregkh>
 <CAMw=ZnRRviBNi_LK9VOSUV9PNHe3jurUcLfgLpbTOsp_eE4WyA@mail.gmail.com>
 <2023071350-specked-botanist-6ba8@gregkh>
 <CAMw=ZnQZ9ds3xsa2AZv_F13dB6rR4XzGPrBjJHSga1oU5xRezQ@mail.gmail.com>
 <2023071552-quilt-tranquil-b7bf@gregkh>
 <CAMw=ZnROWgDOiAr1iikTWa7Qm81HoE17NuEdLt8hwGnkKSnoCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMw=ZnROWgDOiAr1iikTWa7Qm81HoE17NuEdLt8hwGnkKSnoCg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 16, 2023 at 06:41:04PM +0100, Luca Boccassi wrote:
> On Sat, 15 Jul 2023 at 07:52, Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Fri, Jul 14, 2023 at 01:29:20AM +0100, Luca Boccassi wrote:
> > > On Thu, 13 Jul 2023 at 07:09, Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Wed, Jul 12, 2023 at 10:50:45PM +0100, Luca Boccassi wrote:
> > > > > > Who is going to be responsible for determining that this number needs to
> > > > > > be updated?
> > > > >
> > > > > Most likely those who understand the problem space - largely the group
> > > > > of people maintaining the EFI stack, with various inputs, I imagine.
> > > > > That's how it currently works for various bootloaders.
> > > >
> > > > We need specifics and to have people agree to do this, otherwise, again,
> > > > this patch is useless.
> > >
> > > Not really, as this is about mechanism, not process.
> >
> > And this right here is why everyone is both so mad at this patch from
> > our side, and so confused about patch from the developer's side.
> >
> > To think that "let's add a security canary to the kernel image" is
> > anything other than a process issue, shows a lack of understanding about
> > exactly how the kernel is released, how the existing kernel security
> > response team works, and who does any of this work.  To ignore that
> > means that there is no way in the world this can ever be accepted.
> 
> This _question_ was about mechanism, not process. As already
> mentioned, nobody asked you to sign up for any extra work.

And that is the disconnect.  To think that this magic "security canary
number" is somehow not going to affect my work is not correct.  See
below for details...

> > > > > > How long will this feature have to be maintained?
> > > > >
> > > > > Until something else supplants EFI, I'd imagine
> > > >
> > > > So 40+ years, great, who is going to fund that?
> > >
> > > Who funds EFI work?
> >
> > UEFI the spec is funded by various companies (Intel, et-all).  So you
> > are saying that these companies also need to do this development too?
> > Have you got them to agree to this?  If so, great, let's get their
> > signed-off-by on it please.
> >
> > Otherwise you all are saying "someone else will do all of this process
> > work", which frankly, is totally insulting to those of us who _do_ do
> > all of the process work for security issues and kernel releases.
> 
> Nobody asked you to do any process work.

Great, so who will be doing this process work?

Seriously, we have to know this before we could accept this type of
thing.  To not do so would mean this value means nothing.

> > > > > > We have a plethora of kernel changes in our history to learn from here,
> > > > > > please do so and show how this will affect us going forward based on our
> > > > > > past, otherwise we have no way of knowing how any of this is going to
> > > > > > work.
> > > > >
> > > > > I am not aware of anything similar enough, but please do point those
> > > > > out if you are.
> > > >
> > > > Audit our past history and document when the number would have changed
> > > > please.
> > >
> > > Sure, where do I send the invoice?
> >
> > If you are not willing to take the time to determine how this proposed
> > change will affect the kernel developers and infrastructure by doing
> > some modeling based on our past history, then we have no reason to even
> > consider accepting this change as you are stating that you have no idea
> > how it will affect us.
> 
> There's no need for that to tell you how this will affect you: it will
> not. Every now and then you'll receive a one-liner patch to apply.
> What's so terrible about that?

And who will be sending that to me?  For what releases?  For how long
will they be agreeing to do this work for?  How will it be tracked?
What will they be using to determine when the number will be changed?
How will they know it should be changed?

None of this has been answered, and that's the real issue here.  This
"magic number" is saying it is going to reflect some specific "security
issue" yet no one is saying how those issues are going to be determined,
or anything else about it.

Again, as I've repeated numerous times, tell us how often this number
would have changed in the past X years to give us an idea of how you
will be changing it going forward.  To not provide any of this means
this patch adding this magic number means nothing as no one knows what
it actually means.

thanks,

greg k-h
