Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B10E7565ED
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 16:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbjGQOLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 10:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbjGQOLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 10:11:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECE6D3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 07:11:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80F9A61086
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 14:11:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 355FCC433C8;
        Mon, 17 Jul 2023 14:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689603098;
        bh=NBAtgqkXsx9MlBOLbsCOWBayr2Tw0LXviJU91cNfA08=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1xgaXhbuRMyrEPHSh+WJqK37o1UtHFuuYV/rP7DY8qfi3Zw2amnhNkq/lzdM6G6EL
         JtDK/PMv0rOqS54lR7OAs7gMxuEyRJ5HWWMq7DITuJZYa13SIQkJbfhx8IatMMgXxM
         chfSRzq46riRGaQJg+ZUZDVoIf3N9pGeFic+QCh8=
Date:   Mon, 17 Jul 2023 16:11:36 +0200
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
Message-ID: <2023071700-blot-angular-cf6f@gregkh>
References: <CAMw=ZnRjnxWnmoFuw2prxFS55vAGQ1hpfKeHYFfG5Oa0LB_jYA@mail.gmail.com>
 <2023071233-empirical-overturn-744c@gregkh>
 <CAMw=ZnRRviBNi_LK9VOSUV9PNHe3jurUcLfgLpbTOsp_eE4WyA@mail.gmail.com>
 <2023071350-specked-botanist-6ba8@gregkh>
 <CAMw=ZnQZ9ds3xsa2AZv_F13dB6rR4XzGPrBjJHSga1oU5xRezQ@mail.gmail.com>
 <2023071552-quilt-tranquil-b7bf@gregkh>
 <CAMw=ZnROWgDOiAr1iikTWa7Qm81HoE17NuEdLt8hwGnkKSnoCg@mail.gmail.com>
 <2023071643-broiler-level-afbf@gregkh>
 <ZLUIViihakhyPV1N@redhat.com>
 <CAMw=ZnTOgGcQ70E57H1GEr9yZVG-FVHZZ69JYMFqvsO9mgxdDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMw=ZnTOgGcQ70E57H1GEr9yZVG-FVHZZ69JYMFqvsO9mgxdDg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 12:12:18PM +0100, Luca Boccassi wrote:
> On Mon, 17 Jul 2023 at 10:23, Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > On Sun, Jul 16, 2023 at 08:28:10PM +0200, Greg KH wrote:
> > > On Sun, Jul 16, 2023 at 06:41:04PM +0100, Luca Boccassi wrote:
> > > > On Sat, 15 Jul 2023 at 07:52, Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > If you are not willing to take the time to determine how this proposed
> > > > > change will affect the kernel developers and infrastructure by doing
> > > > > some modeling based on our past history, then we have no reason to even
> > > > > consider accepting this change as you are stating that you have no idea
> > > > > how it will affect us.
> > > >
> > > > There's no need for that to tell you how this will affect you: it will
> > > > not. Every now and then you'll receive a one-liner patch to apply.
> > > > What's so terrible about that?
> >
> > I think that's not entirely accurate, as this *will* have an impact on
> > anyone involved in backporting fixes for the kernel stable trees, when
> > they need to resolve conflicts on the SBAT file. It shouldn't have a
> > big impact, but we should be honest that it will be a non-zero impact.
> >
> > Lets say mainline branch has had 2 security vulnerabilities A and B,
> > each of which was associated with an increment of the SBAT version
> > number. The first flaw A changed SBAT from 7 to 8,and then the second
> > flaw B changed SBAT from 8 to 9.
> >
> > If someone wants to backport the fix for bug "B" they will get a
> > conflict on the SBAT file when cherry-picking the patch. When that
> > happens they must decide:
> >
> >   * It is acceptable to ignore issue A, because it didn't affect
> >     that branch. The conflict is resolved by having the backported
> >     patch increase SBAT version from 7 to 9 directly.
> >
> >   * It is required to first backport issue A, because that also
> >     affects that branch. The conflict is resolved by first backporting
> >     the code fix & SBAT change for A, and then backporting the code
> >     fix and SBAT change for B. SBAT changes from 7 to 8 to 9 just
> >     like on master.
> >
> > IOW whomever is doing backport patches for stable needs to understand
> > the semantics of SBAT and how to resolve conflicts on it. If they get
> > this wrong, then it breaks the protection offered by SBAT, which would
> > then require a 3rd SBAT change to fix the mistake.
> >
> > This likely means that stable tree maintainers themselves need to
> > understand the SBAT change rules, so they can review conflict resolution
> > for any proposed changes, to sanity check what is being proposed.
> 
> This can be solved by just not changing the generation id in the same
> patch that fixes a bug, but as the last step in a series, which
> doesn't add the cc: stable nor the other tags. If we want to bump the
> generation id in a stable branch, we'll then have to send an
> appropriately crafted patch targeted at the right place. That way even
> if the fixes get backported, there is no additional burden on any
> kernel maintainer.

Who exactly will be "we" in this process and who will be funding this
effort to ensure that they keep doing this work for the next 20+ years?

thanks,

greg k-h
