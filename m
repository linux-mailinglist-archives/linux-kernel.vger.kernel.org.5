Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6698E752CB6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 00:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbjGMWEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 18:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbjGMWEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 18:04:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C6C26B7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 15:04:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92BA961B7D
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 22:04:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D996C433C8;
        Thu, 13 Jul 2023 22:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689285889;
        bh=D/qWx366/grQZB6JpvGMiTdaCdiECJ62L0mKndmW+P0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DLTEu1MwSREm9tHW683jNvnqoVBKnZPNqVIW6KLWIwyFxj7UlQP4pcB0IUtZ4HZY6
         1DJHG79RkFnG/BvKN01VaujCCiHM25ueUyJHMaWxsS7qOhx3iCSOEAST1Io+iZvnT2
         El7bGziDxVAgxkbVRnsZwLXEilCOIW4rpNU8rqe4=
Date:   Fri, 14 Jul 2023 00:04:46 +0200
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
Message-ID: <2023071429-decibel-amazingly-0185@gregkh>
References: <20230711154449.1378385-1-eesposit@redhat.com>
 <2023071237-private-overhang-7f86@gregkh>
 <875y6o429i.fsf@redhat.com>
 <2023071329-persevere-pursuant-e631@gregkh>
 <87wmz33j36.fsf@redhat.com>
 <2023071356-royal-charter-a647@gregkh>
 <5e7716de-ffce-e89d-0aa3-45eed4804652@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e7716de-ffce-e89d-0aa3-45eed4804652@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 10:49:31PM +0200, Emanuele Giuseppe Esposito wrote:
> >> I replied to the thread not to defend the idea as after the discussion
> >> it is clear there's a lot to take into consideration if anyone decides
> >> to pursue the SBAT idea ever again (and the discussion is now well
> >> preserved in the archive!). I replied to disagree with "get sign-offs
> >> from senior people before sending RFCs" idea, I believe that asking
> >> questions by sending a not-fully-ready patch as "RFC" should not be
> >> discouraged. 
> > 
> > On the contrary, this is EXACTLY what needs to happen here.
> > 
> > This developer (I'm not picking on them at all, it's not their fault),
> > should be taking advantage of the resources of their company when
> > dealing with core, critical, functionality of the kernel.
> > 
> > To just "throw them at the wolves" like Red Hat did, is a total
> > disservice to them, AND it wastes the time and resources of the
> > community, as it is not our job to train and teach them, it is the job
> > of the senior people at your company to do so.
> > 
> > We have a non-zero number of companies that right now who are in the
> > "penalty box" because their developers have had a history of throwing
> > crud over the wall, or having inexperienced developers submit changes
> > that are obviously wrong, which waste the time and energy of the kernel
> > community.  For companies that do this, we have instituted the
> > requirement that they get review and acceptance of kernel changes from
> > the experienced developers within the company BEFORE submitting their
> > changes to the community, for the basic fact that this actually saves
> > EVERYONE time and energy.
> > 
> > It allows the developer to grow and learn more quickly, it saves the
> > energy and time of the reviewers (which is our most valuable resource
> > right now) and it provides a solid path forward on the corporate ladder
> > of using mentors well, and lifting up your own employees.
> > 
> > I don't think you want us to put Red Hat into this type of policy at
> > this point in time, but if you all keep insisting that you can just "let
> > loose" inexperienced developers who wish to change the core
> > functionality of how we operate, that can easily change.
> 
> Wow, I was not aware of these policies O.O.
> What you say makes sense, but what about developers not working in a
> company? Then they are completely ignored?

Not at all, they are not ignored and are treated as someone who probably
needs help.

> Otherwise a simple way to trick you is to actually use my gmail address
> and you won't ever know that I work for RH.

If RH finds out you are misrepresenting yourself like this, I don't
think it will go over very well :)

Also, we know who almost everyone works for, this isn't a secret.  And
it would turn out to be worse overall for that developer if they were to
attempt that.

Remember, kernel development works on trusting other people.  If someone
looses their trust in you, it's very hard to get it back.

thanks,

greg k-h
