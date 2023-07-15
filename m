Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B7E754726
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 08:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjGOG7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 02:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjGOG7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 02:59:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544421FDB
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 23:59:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA341600BE
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 06:59:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AC74C433C8;
        Sat, 15 Jul 2023 06:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689404392;
        bh=2SKRLuEjl0BMBgwPCUiO1DulKoG6Gcn4JpWpPlwfQCU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MKB/HH1rt++2kBhhi3a1KJrL/Rb4f7WgRhbkMDGxgdtscm00i6FU9H2QTVh3jlvO4
         ac939eiM2VPYYUO0M4Z9/qLd4a7wJ2qxxjJsB6Bw3+Ezkld0WQSP6XW752l/eLo5g0
         A27w74xVBrej4J/GWnKOLWNNy8AWY1Qe+gykLgQM=
Date:   Sat, 15 Jul 2023 08:59:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Emanuele Giuseppe Esposito <eesposit@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, bluca@debian.org,
        lennart@poettering.net, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2] x86/boot: add .sbat section to the bzImage
Message-ID: <2023071555-cultural-splice-b41a@gregkh>
References: <20230711154449.1378385-1-eesposit@redhat.com>
 <2023071237-private-overhang-7f86@gregkh>
 <875y6o429i.fsf@redhat.com>
 <2023071329-persevere-pursuant-e631@gregkh>
 <87wmz33j36.fsf@redhat.com>
 <2023071356-royal-charter-a647@gregkh>
 <5e7716de-ffce-e89d-0aa3-45eed4804652@redhat.com>
 <2023071429-decibel-amazingly-0185@gregkh>
 <e495599a-7a5c-15d0-34b1-3470ad0986ca@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e495599a-7a5c-15d0-34b1-3470ad0986ca@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 08:57:03AM +0200, Emanuele Giuseppe Esposito wrote:
> Am 14/07/2023 um 00:04 schrieb Greg KH:
> > On Thu, Jul 13, 2023 at 10:49:31PM +0200, Emanuele Giuseppe Esposito wrote:
> >>>> I replied to the thread not to defend the idea as after the discussion
> >>>> it is clear there's a lot to take into consideration if anyone decides
> >>>> to pursue the SBAT idea ever again (and the discussion is now well
> >>>> preserved in the archive!). I replied to disagree with "get sign-offs
> >>>> from senior people before sending RFCs" idea, I believe that asking
> >>>> questions by sending a not-fully-ready patch as "RFC" should not be
> >>>> discouraged. 
> >>>
> >>> On the contrary, this is EXACTLY what needs to happen here.
> >>>
> >>> This developer (I'm not picking on them at all, it's not their fault),
> >>> should be taking advantage of the resources of their company when
> >>> dealing with core, critical, functionality of the kernel.
> >>>
> >>> To just "throw them at the wolves" like Red Hat did, is a total
> >>> disservice to them, AND it wastes the time and resources of the
> >>> community, as it is not our job to train and teach them, it is the job
> >>> of the senior people at your company to do so.
> >>>
> >>> We have a non-zero number of companies that right now who are in the
> >>> "penalty box" because their developers have had a history of throwing
> >>> crud over the wall, or having inexperienced developers submit changes
> >>> that are obviously wrong, which waste the time and energy of the kernel
> >>> community.  For companies that do this, we have instituted the
> >>> requirement that they get review and acceptance of kernel changes from
> >>> the experienced developers within the company BEFORE submitting their
> >>> changes to the community, for the basic fact that this actually saves
> >>> EVERYONE time and energy.
> >>>
> >>> It allows the developer to grow and learn more quickly, it saves the
> >>> energy and time of the reviewers (which is our most valuable resource
> >>> right now) and it provides a solid path forward on the corporate ladder
> >>> of using mentors well, and lifting up your own employees.
> >>>
> >>> I don't think you want us to put Red Hat into this type of policy at
> >>> this point in time, but if you all keep insisting that you can just "let
> >>> loose" inexperienced developers who wish to change the core
> >>> functionality of how we operate, that can easily change.
> >>
> >> Wow, I was not aware of these policies O.O.
> >> What you say makes sense, but what about developers not working in a
> >> company? Then they are completely ignored?
> > 
> > Not at all, they are not ignored and are treated as someone who probably
> > needs help.
> > 
> >> Otherwise a simple way to trick you is to actually use my gmail address
> >> and you won't ever know that I work for RH.
> > 
> > If RH finds out you are misrepresenting yourself like this, I don't
> > think it will go over very well :)
> 
> By "my gmail address" I mean any potential employee of any company
> reading this thread of course. I think after this you'll remember my
> name for a while ;) So no way to hide for me. Also my private email
> address has my name and surname in it, so it won't be hard to identify me.
> 
> Anyways, I think you need to clarify better what you mean with
> "inexperienced developers submit changes that are obviously wrong", more
> specifically the "obviously wrong" part.
> If you refer to the commit message wrongly made, ok you have a point. I
> take responsibility on this, it already happened that I wrote non clear
> commits and I am working on this. Working on different communities that
> have less commit rules and rarely sending stuff to kernel doesn't help
> though (my only excuse). If it's that, the issue can be closed here and
> I will definitely be more careful in the future, as well as all I work with.
> 
> If you refer to the fact that the patch is wrong technically, 1) as I
> wrote it is indeed not working properly, I have clearly documented in
> the commit message that if you run make twice with this patch it won't
> work, and 2) the aim of this patch that we thought was clear with RFC
> and "Important:..." was to ask opinions because we don't have experts on
> this matter, the technology is new and would like to hear opinions from
> outside. You gave the opinion we were looking for, it's just that the
> whole thing escalated dramatically because IMHO intentions were
> misunderstood and again IMHO the wrong tones and wordings were used.

The main disconnect here is that you are confusing "technical" from
"process".  This small "technical change" has a HUGE influence on our
processes and procedures.

The people responsible for those processes and procedures are the ones
going "oh hell no!" right now, and they are correct to do so as you are
saying "we don't care about the process" which can be considered as both
a "there is no need for process" naive idea, or a "we are going to be
expecting you to do more work for us without even asking", both of which
are being extremely rude to those of us responsible for ensuring that
process works for every user of Linux.

This doesn't always come up in kernel patches, so I can understand your
confusion when it happened.  But the fact that "adding a security bit"
was not at documented for the potential workflow changes is not
acceptable for any group/developer who would propose such a thing.

Maintainers always are right to say "no" when patches are proposed if
the acceptance of that patch is going to cause them extra work, as
maintainer's time is our most precious resource.  Normally that extra
work is "just" additional code to maintain, but sometimes it involves
workflow changes, as you are proposing here.

So again, please work with the more experienced developers at your
company to come up with just how this workflow changes are going to be
accommodated if you wish for this change to be accepted.

thanks,

greg k-h
