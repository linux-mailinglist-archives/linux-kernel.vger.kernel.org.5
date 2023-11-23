Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C847F5ECC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 13:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345242AbjKWMM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 07:12:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345215AbjKWMM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 07:12:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3C691
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 04:13:02 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30465C433C7;
        Thu, 23 Nov 2023 12:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700741582;
        bh=42j8yCIGOIsdbYfWKArHt6YgWjhLYwGUak0TSa8oLCU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UlJdv0lXQ6T1VSpJnR8JE9zxFg2rCDgSn8m0Ep2KHp6YA9n8T4Tzs1xiNMSiYdOD/
         sRjRA+4T8cyH5auQADLfeXR+nmphrtH+ZVwkl0yhbBinRdYGvhiQ6X4TrC+Kge1Xmf
         UiEyAUy5ylyXgPcmIho7+QBePr4SPpzNAbDTpeRM=
Date:   Thu, 23 Nov 2023 12:12:56 +0000
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Matthew Maurer <mmaurer@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, linux-kbuild@vger.kernel.org,
        rust-for-linux@vger.kernel.org, Laura Abbott <laura@labbott.name>
Subject: Re: [PATCH v2 0/5] MODVERSIONS + RUST Redux
Message-ID: <2023112312-certified-substance-007c@gregkh>
References: <20231118025748.2778044-1-mmaurer@google.com>
 <CAK7LNAQt8fy5+vSwpd1aXfzjzeZ5hiyW7EW9SW7pbG2eTJZAOA@mail.gmail.com>
 <CAGSQo00hyCTVsqHtrzKBBPvuH38z5yRm_4jzdi00C0RV+8APwQ@mail.gmail.com>
 <2023112314-tubby-eligibly-007a@gregkh>
 <CAK7LNAT-OcaCi6tqPRgZxPXOV6u+YbaO_0RxtfmrVXPzdrio0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNAT-OcaCi6tqPRgZxPXOV6u+YbaO_0RxtfmrVXPzdrio0Q@mail.gmail.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 08:38:45PM +0900, Masahiro Yamada wrote:
> On Thu, Nov 23, 2023 at 6:05 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Nov 22, 2023 at 01:04:09PM -0800, Matthew Maurer wrote:
> > > > So, even if you enable CONFIG_MODVERSIONS,
> > > > nothing is checked for Rust.
> > > > Genksyms computes a CRC from "int foo", and
> > > > the module subsystem confirms it is a "int"
> > > > variable.
> > > >
> > > > We know this check always succeeds.
> > > >
> > > > Why is this useful?
> > > The reason this is immediately useful is that it allows us to have Rust
> > > in use with a kernel where C modules are able to benefit from MODVERSIONS
> > > checking. The check would effectively be a no-op for now, as you have correctly
> > > determined, but we could refine it to make it more restrictive later.
> > > Since the
> > > existing C approach errs on the side of "it could work" rather than "it will
> > > work", I thought being more permissive was the correct initial solution.
> >
> > But it's just providing "fake" information to the CRC checker, which
> > means that the guarantee of a ABI check is not true at all.
> >
> > So the ask for the user of "ensure that the ABI checking is correct" is
> > being circumvented here, and any change in the rust side can not be
> > detected at all.
> >
> > The kernel is a "whole", either an option works for it, or it doesn't,
> > and you are splitting that guarantee here by saying "modversions will
> > only work for a portion of the kernel, not the whole thing" which is
> > going to cause problems for when people expect it to actually work
> > properly.
> >
> > So, I'd strongly recommend fixing this for the rust code if you wish to
> > allow modversions to be enabled at all.
> >
> > > With regards to future directions that likely won't work for loosening it:
> > > Unfortunately, the .rmeta format itself is not stable, so I wouldn't want to
> > > teach genksyms to open it up and split out the pieces for specific functions.
> > > Extending genksyms to parse Rust would also not solve the situation -
> > > layouts are allowed to differ across compiler versions or even (in rare
> > > cases) seemingly unrelated code changes.
> >
> > What do you mean by "layout" here?  Yes, the crcs can be different
> > across compiler versions and seemingly unrelated code changes (genksyms
> > is VERY fragile) but that's ok, that's not what you are checking here.
> > You want to know if the rust function signature changes or not from the
> > last time you built the code, with the same compiler and options, that's
> > all you are verifying.
> >
> > > Future directions that might work for loosening it:
> > > * Generating crcs from debuginfo + compiler + flags
> > > * Adding a feature to the rust compiler to dump this information. This
> > > is likely to
> > >   get pushback because Rust's current stance is that there is no ability to load
> > >   object code built against a different library.
> >
> > Why not parse the function signature like we do for C?
> >
> > > Would setting up Rust symbols so that they have a crc built out of .rmeta be
> > > sufficient for you to consider this useful? If not, can you help me understand
> > > what level of precision would be required?
> >
> > What exactly does .rmeta have to do with the function signature?  That's
> > all you care about here.
> 
> 
> 
> 
> rmeta is generated per crate.
> 
> CRC is computed per symbol.
> 
> They have different granularity.
> It is weird to refuse a module for incompatibility
> of a symbol that it is not using at all.

I agree, this should be on a per-symbol basis, so the Rust
infrastructure in the kernel needs to be fixed up to support this
properly, not just ignored like this patchset does.

thanks,

greg k-h
