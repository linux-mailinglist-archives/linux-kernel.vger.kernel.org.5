Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1067CB6C0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 00:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbjJPW4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 18:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjJPW4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 18:56:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54952B0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 15:56:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED871C433C8;
        Mon, 16 Oct 2023 22:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697496964;
        bh=MGp4qTs5gM9OYSsYzgnexOT01rJEoQ0MSq2pFp2PD68=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=hWLaF1VoXDt3hJj5DE45MkPfhRQjWiQcKusPcdvhnANbBS0HuliHQKswMU1SVuO3A
         ceCYNzRjQ0huJXVju25bTSAeP9hvahLQjxrMunTt7OuEdrWG5swMzgJdPGvfSDe32O
         NBCsDdly5v9TOMWJQS25QVN5VOP3ikeFJvbUi1cbN6DaUnUFKK/K8AIVw0H5gQfZ3g
         EsToPiwDT08Ui+xYC79jTS32k15Qfz9Lga2sBkaZWXWFmvtMLA0u6/AHwyFEt4x+9T
         JIBj+mW87DQAu3IJYBULuX3jTDf9MUNPejItls45bt/wniDSZK0Ugv03pnFjpdgiMZ
         Agxo8jHvbJg0Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 778B0CE126C; Mon, 16 Oct 2023 15:56:03 -0700 (PDT)
Date:   Mon, 16 Oct 2023 15:56:03 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Willy Tarreau <w@1wt.eu>, Zhangjin Wu <falcon@tinylab.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/nolibc: add tests for multi-object linkage
Message-ID: <df5de815-ad91-4ab5-beca-01714294b405@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <bfc17e76-fcbc-4ce6-97a8-c1ed72ed2a67@t-8ch.de>
 <33e9afcd-a1cd-4f67-829b-85c86500a93e@paulmck-laptop>
 <b278a643-3761-4699-bafc-df1b7245b8c2@t-8ch.de>
 <ca67eb2c-3918-4a1f-b3e6-2023fda5d6a3@paulmck-laptop>
 <6b66305f-8172-463e-a50d-324c0c33a6ea@t-8ch.de>
 <a5f1a910-dbac-44d8-b9f6-5725bea948b2@paulmck-laptop>
 <aa77a065-fcc9-4d3a-8531-fd994587c48f@t-8ch.de>
 <0c8446a7-473d-49bc-9413-d1b9176f13b1@paulmck-laptop>
 <246fe818-57a7-4cee-a11b-390df3eee101@paulmck-laptop>
 <edd7c9f6-32cb-4f5d-920d-7bd6bdb7eea0@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <edd7c9f6-32cb-4f5d-920d-7bd6bdb7eea0@t-8ch.de>
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URG_BIZ autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 12:03:41AM +0200, Thomas Weißschuh wrote:
> On 2023-10-16 09:24:19-0700, Paul E. McKenney wrote:
> > On Thu, Oct 12, 2023 at 01:18:18PM -0700, Paul E. McKenney wrote:
> > > On Thu, Oct 12, 2023 at 09:34:53PM +0200, Thomas Weißschuh wrote:
> > > > On 2023-10-12 12:06:33-0700, Paul E. McKenney wrote:
> > > > > On Thu, Oct 12, 2023 at 08:39:14PM +0200, Thomas Weißschuh wrote:
> > > > > > On 2023-10-12 11:25:02-0700, Paul E. McKenney wrote:
> > > > > > > [..]
> > > > 
> > > > > > > I have a signed tag urgent/nolibc.2023.10.12a in the -rcu tree, so
> > > > > > > please check the lead-in text for sanity.  (Everything after the digital
> > > > > > > signature is automatically generated.)
> > > > > > 
> > > > > > Looks good. But it's only a listing of the commit subjects, correct?
> > > > > 
> > > > > Pretty close, just a few added words on the last one.
> > > > > 
> > > > > So the question is whether there is some larger issue that Linus should
> > > > > be made aware of.  If these are just simple fixes for simple bugs,
> > > > > we should be good, but yes, I do need to ask.  ;-)
> > > > 
> > > > These are simple fixes for simple bugs.
> > > > 
> > > > Do you always have to ask specifically or can I just mention it in the
> > > > pull request in the future?
> > > 
> > > I would be extremely happy to simply copy text from the pull request
> > > into the signed tags.  ;-)
> > > 
> > > We would just need to agree on the format.  For example, in this case,
> > > there will eventually be two signed tags, one for the urgent pull
> > > request early next week and another for the pull request for the upcoming
> > > merge window.
> > > 
> > > Proposals for the format?
> > 
> > Actually, proposals for the signed-tag text for the urgent commits?
> > Left to myself, I would use the same text shown below that I proposed
> > last week.
> 
> Looks good.
> 
> The tags for urgent PRs seem good with one item per patch.

You got it!  urgent/nolibc.2023.10.16a

> I guess for normal PRs one item per series would be fine.

That makes a lot of sense -- with a non-urgent series, there should be
some sort of development theme.  I immediately see the list shown below.
Please let me know of any needed adjustments.

							Thanx, Paul

------------------------------------------------------------------------

Add stdarg.h.

Optimize x86 string functions and remove unused internal functions.

Adjust compiler flags to avoid accidental reliance on system header files,
to avoid false-positive warnings, and to allow building 32-bit i386 with
multi-architecture compilers.

Pass initrd to qemu separately from the kernel image to avoid needless
kernel relinks.  Make ppc64le use qemu-system-ppc64 in order to provide
bi-endian support.

Create varargs __nolibc_enosys() function to avoid false-positive
compiler warnings for unimplemented system calls.  Rely on kernel
system-call-number definitions to avoid breaking common-code userspace.
Automatrically determine whether pselect6() is required to avoid a bit of
manual coding.  Add support for C-language constructors and destructors.

Drop redundant tests.  Add tests for nolibc programs having multiple
.o files.
