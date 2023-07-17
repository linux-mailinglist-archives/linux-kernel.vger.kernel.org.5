Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 240E07565E8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 16:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbjGQOKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 10:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbjGQOKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 10:10:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37C1D1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 07:10:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A57361088
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 14:10:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10639C433C8;
        Mon, 17 Jul 2023 14:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689603047;
        bh=GaCjDbm8BGVyFoWWFMaRUbmE4kDGTOr2+jeccbvLvUk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gKyFtm8EP0/o+53tGmRObZvSfoDqeCaVfBm+anEUjklUyLOZC+MCUHWLGMzxEmNVV
         7rRTGKX4hu8ux9ZgbfuNdp++goSSZUimd2D2Fz239zny44Fp4B8tcA79G4c5KjSsGV
         HXzHQKYTMPhhAx8EtDWjdjN3+g4xWg8B9M8kSs6U=
Date:   Mon, 17 Jul 2023 16:10:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Luca Boccassi <bluca@debian.org>,
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
Message-ID: <2023071717-undead-amiable-3427@gregkh>
References: <2023071233-empirical-overturn-744c@gregkh>
 <CAMw=ZnRRviBNi_LK9VOSUV9PNHe3jurUcLfgLpbTOsp_eE4WyA@mail.gmail.com>
 <2023071350-specked-botanist-6ba8@gregkh>
 <CAMw=ZnQZ9ds3xsa2AZv_F13dB6rR4XzGPrBjJHSga1oU5xRezQ@mail.gmail.com>
 <2023071552-quilt-tranquil-b7bf@gregkh>
 <CAMw=ZnROWgDOiAr1iikTWa7Qm81HoE17NuEdLt8hwGnkKSnoCg@mail.gmail.com>
 <2023071643-broiler-level-afbf@gregkh>
 <ZLUIViihakhyPV1N@redhat.com>
 <20230717110631.GH4253@hirez.programming.kicks-ass.net>
 <ZLUqSf1AwN9tC8S8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZLUqSf1AwN9tC8S8@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 12:47:21PM +0100, Daniel P. Berrangé wrote:
> On Mon, Jul 17, 2023 at 01:06:31PM +0200, Peter Zijlstra wrote:
> > On Mon, Jul 17, 2023 at 10:22:51AM +0100, Daniel P. Berrangé wrote:
> > > I'm not aware of any kernel CVEs since that point in time that
> > > would have implied SBAT changes, but admittedly I've not paid
> > > close enough attention to be entirely confident. Is going back
> > > through 2 years of kernel CVEs (to the point where SBAT was
> > > invented) a long enough timeframe to satisfy this request for
> > > info on the frequency of changes ?
> > 
> > Many *MANY* security bugs never get a CVE. CVE is meaningless when it
> > comes to kernel bugs. Why does it make sense to review CVEs ?
> 
> Yes, I know many security bugs gets fixed without a CVE being
> assigned, but in the context of the question that doesn't
> matter.

"most" security bugs never get a CVE, and by "most" I mean "almost all".

> The SBAT version number will be incremented in response to an
> identified security bug. Even if upstream has not assigned a
> CVE to an issue, downstream vendors are likely to have done
> so *if* they identified the security issue.

So this is yet-another-pointless number that only would kick in if
someone took the time to fill out a form and bump the number because
they either wanted to pad their CV, or they wanted to grease the wheels
of a broken engineering process.

This is going to ensure that actual bugs that do fix issues that should
have "bumped" this number, never cause it to actually be changed, so
people will have a total false sense of security, which is EXACTLY what
is wrong with CVEs today (among many other things as mentionted.)

If you do this this way, you will be signalling to people the exact
oposite thing you want to signal, namely "don't update this kernel
because no real problem has been found in it", which is NOT the real
thing to be saying as we have documented numberous times in the past.

> If neither upstream, nor downstream, publically identified a
> fix as a security issue, then by extension they would also
> not have identified a need to change to the SBAT version info
> either.

So all the known security bugs that we fix on a weekly basis and get
merged into the kernel trees and stable updates and pushed out to
people's machines would never actually bump this number, which means
that this number is meaningless.

Great, so we don't need it at all then :)

> Thus looking at publically identified security issues via
> CVEs is a reasonable proxy to guage how many times SBAT
> would have been incremented, which is what Greg asked for.

Again, not at all given my previous responses.  If you actually think
that CVEs represent ANYTHING regarding security fixes or not for the
kernel, I have a bridge to sell you :)

thanks,

greg k-h
