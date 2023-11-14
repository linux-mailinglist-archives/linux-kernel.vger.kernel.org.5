Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 147057EAFCC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 13:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbjKNMZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 07:25:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjKNMZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 07:25:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD3513D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 04:24:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 195FAC433C8;
        Tue, 14 Nov 2023 12:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699964697;
        bh=ncW1jlc+LZFs2wFuphiZQkOpBz6QX6RiQ1j55px9Kao=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l99rIvbLUJu13ZV4yN+aLpcFrZXEL5au01dh2KnmkkAuL8rJz0BX/tmQCk6CcI85I
         K1eORMZkp/Ga3PsGp0pR5FNMk5DFRzzLY+VQZvBD3Vc4Ovg0W9CKVihkTbZ/b6e2NY
         zZzg8Yvo8jAh0Q5Bc+kFMBrZ6SG+4IFYbJJ9yDTg=
Date:   Tue, 14 Nov 2023 07:24:55 -0500
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     John Moon <quic_johmoo@quicinc.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Jonathan Corbet <corbet@lwn.net>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, kernel@quicinc.com,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Todd Kjos <tkjos@google.com>,
        Matthias Maennich <maennich@google.com>,
        Giuliano Procida <gprocida@google.com>,
        kernel-team@android.com, libabigail@sourceware.org,
        Dodji Seketeli <dodji@redhat.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Jordan Crouse <jorcrous@amazon.com>
Subject: Re: [PATCH v6 1/3] check-uapi: Introduce check-uapi.sh
Message-ID: <2023111421-parish-juice-1932@gregkh>
References: <20231027193016.27516-1-quic_johmoo@quicinc.com>
 <20231027193016.27516-2-quic_johmoo@quicinc.com>
 <CAK7LNATWk8psXZvsHXNwxNt9=sUi3J0qOA-P4ceOKqBuS1_VJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNATWk8psXZvsHXNwxNt9=sUi3J0qOA-P4ceOKqBuS1_VJQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2023 at 07:10:51PM +0900, Masahiro Yamada wrote:
> On Sat, Oct 28, 2023 at 4:31 AM John Moon <quic_johmoo@quicinc.com> wrote:
> >
> > While the kernel community has been good at maintaining backwards
> > compatibility with kernel UAPIs, it would be helpful to have a tool
> > to check if a commit introduces changes that break backwards
> > compatibility.
> >
> > To that end, introduce check-uapi.sh: a simple shell script that
> > checks for changes to UAPI headers using libabigail.
> >
> > libabigail is "a framework which aims at helping developers and
> > software distributors to spot some ABI-related issues like interface
> > incompatibility in ELF shared libraries by performing a static
> > analysis of the ELF binaries at hand."
> >
> > The script uses one of libabigail's tools, "abidiff", to compile the
> > changed header before and after the commit to detect any changes.
> >
> > abidiff "compares the ABI of two shared libraries in ELF format. It
> > emits a meaningful report describing the differences between the two
> > ABIs."
> >
> > The script also includes the ability to check the compatibility of
> > all UAPI headers across commits. This allows developers to inspect
> > the stability of the UAPIs over time.
> >
> > Signed-off-by: John Moon <quic_johmoo@quicinc.com>
> > ---
> >     - Add abidiff suppressions to filter out common things like enum
> >       variants named .*_MAX being changed and expansion into padding
> >       fields.
> >     - Bump minimum abidiff version to 2.4 to accomodate new
> >       suppressions.
> >     - Add option (-i) to suppress ambiguous breaking changes.
> >     - Remove printing of full file diffs when ABI breakage is found
> >       as this was too noisy.
> >     - Wait for all files to be checked before printing results as
> >       printing from parallel threads was garbling output.
> >     - Suppress all output when -q is passed.
> >     - Avoid messing up user's git tree by using "git archive" instead
> >       of checking out references.
> 
> 
> 
> The code looks almost good to me.
> 
> (I left some more comments below, but they are minor).
> 
> 
> 
> Greg,
> Could you check the output from the tool?

I will, give me a chance to catch up after the merge window and this
week at Plumbers....  Should be a week or so, thanks.

greg k-h
