Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836F575189C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 08:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbjGMGJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 02:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbjGMGJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 02:09:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F74919B9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 23:09:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDE6B61A2B
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 06:09:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E5ECC433C7;
        Thu, 13 Jul 2023 06:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689228577;
        bh=rfOkl54Av3vOEI6WfHV9ZGbKTxzAbh3FVWO0o2JesBc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CRSvCqKbyKXNKAZnBZPzldYm5iaG+CqwcDvBS1gs9q0vnXaEqCGJ2Q/jNXUQ3ptu7
         SjDEmG7AHQxH+BzskAi2swDcvkZoDBUEv9xTZKzg906ke5sS/mI1o+bnqkY+JhBj8M
         q/FrVVTz8Aef17lvrk9JhF1vAhenZPnkzEhixhnw=
Date:   Thu, 13 Jul 2023 08:09:33 +0200
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
Message-ID: <2023071350-specked-botanist-6ba8@gregkh>
References: <2023071200-unopposed-unbuckled-cde8@gregkh>
 <CAMw=ZnTVRaqRmtz+sDj7AeAS7xivSu+56UgKbzmuW9+K6TTx1A@mail.gmail.com>
 <2023071239-progress-molasses-3b3d@gregkh>
 <CAMw=ZnRheXk7W_r-32bGymbHKdXc7aKUpwGAOX+k7DJkN+DiCQ@mail.gmail.com>
 <2023071229-dusk-repacking-da3a@gregkh>
 <CAMw=ZnSmZTBs+bJsQ_Y2CVO8K3OTuHOZDKW4cbxKpGbo4Vgs7Q@mail.gmail.com>
 <2023071226-crafty-deviator-12e2@gregkh>
 <CAMw=ZnRjnxWnmoFuw2prxFS55vAGQ1hpfKeHYFfG5Oa0LB_jYA@mail.gmail.com>
 <2023071233-empirical-overturn-744c@gregkh>
 <CAMw=ZnRRviBNi_LK9VOSUV9PNHe3jurUcLfgLpbTOsp_eE4WyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMw=ZnRRviBNi_LK9VOSUV9PNHe3jurUcLfgLpbTOsp_eE4WyA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 10:50:45PM +0100, Luca Boccassi wrote:
> > > There is no 'single identifier for individual issues' nor CVE involved
> > > here. The purpose of the generation id (which is per EFI component,
> > > not per bug) is to let the boot process know whether an EFI component
> > > should be accepted or rejected, in a way that doesn't exhaust nvram.
> > > Issues are not individually singled out, and there is no direct
> > > correlation with CVEs. It doesn't matter how many fixes there are, or
> > > how many bugs, if a generation of a component is vulnerable in any way
> > > that matters, then it gets denied.
> >
> > What does "in any way that matters" mean exactly?
> 
> It means what it says. If you don't know what matters, then it won't
> be you issuing revocations (and that's ok, it won't be me either,
> thank goodness).

Then who will it be?

And we need to know exactly what this means before we can properly even
evaluate this patch, to think otherwise is odd.

> > And are you treating the whole kernel as an "EFI component" here?
> 
> Yes, that's the scope of this problem, again this is about having a
> usable alternative to DBX, it concerns signed PE payloads, and the
> kernel is one of them, as a single component.

Ok, a big component :)

> > Who is going to be responsible for determining that this number needs to
> > be updated?
> 
> Most likely those who understand the problem space - largely the group
> of people maintaining the EFI stack, with various inputs, I imagine.
> That's how it currently works for various bootloaders.

We need specifics and to have people agree to do this, otherwise, again,
this patch is useless.

> > How are they going to determine this?
> 
> Again, very coarsely: does the current generation allow a secure boot
> bypass -> revoked, else -> no change

And how are you going to do that testing?  Who is going to do that?
Does it happen today?

> > What is their response time?
> >
> > Who will they be submitting the patch to this string in order to have it
> > change?
> 
> A bit too soon for exact details on processes given where we are, I think.

Not at all, this is a proposal for a "security flag" for the kernel,
getting this all decided now is the only correct way to determine if
this is actually something that can work properly.

To just go "we are going to randomly add a number that will sometimes be
incremented in the future to determine the buggyness of the kernel
without saying who will control this, or how it will be done" is crazy.

Would other operating systems or projects accept such a change without
this information?

Would you take this patch if you were responsible for kernel releases?

> > And how is any of this going to interact with stable kernel releases,
> > long term kernel releases and end-of-life kernel releases?
> 
> As above: does the current generation allow a secure boot bypass ->
> revoked, else -> no change

For all stable releases?

> > How long will this feature have to be maintained?
> 
> Until something else supplants EFI, I'd imagine

So 40+ years, great, who is going to fund that?

> > > The only thing that matters is, "if we had infinite space in DBX and
> > > sensible ways to service it and nvram didn't wear down, would we
> > > blocklist this component version" - if the answer is no, then nothing
> > > happens. If the answer is yes, then the counter goes up.
> >
> > I suggest you all take a look at the past 10 years of kernel releases
> > and changes (to pick a simple number) and determine what the number
> > would be now if you were to start counting then.  Is it 10?  100?
> > 10000?  What do you think it will be in the next 40 years?
> 
> What do you think that would look like if it was all individual hashes
> blocklisted in DBX instead? Because this is what we are talking about.
> And, for the nth time, this is not about identifying individual bugs.
> You do what, 3 releases a year? So 10 years time 3,

I do a release or two a week across multiple stable kernel versions.
For you to not notice that means that either the process is working
really well, or that this type of function does not match how we do
development and releases at all.

> then assuming
> every single release you have made is completely and hopelessly broken
> in different ways, but each is only discovered one at a time exactly
> once per release, then the generation counter would be 30. That's your
> absolutely worst case scenario. Now try to think about how hash
> entries we'd need in DBX for the exact same worst case scenario, and
> the reason SBAT has been implemented should become very obvious, very
> quickly.

I'm not saying "individual hashes" anymore, sure, I'll give you your one
number, but even then, I don't see how it makes any sense at all in our
current ecosystem of releases.

So I need to see this documented very very well to even be able to
consider it.

> > We have a plethora of kernel changes in our history to learn from here,
> > please do so and show how this will affect us going forward based on our
> > past, otherwise we have no way of knowing how any of this is going to
> > work.
> 
> I am not aware of anything similar enough, but please do point those
> out if you are.

Audit our past history and document when the number would have changed
please.

thanks,

greg k-h
