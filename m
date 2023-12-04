Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0844A803F1D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 21:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbjLDUPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 15:15:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbjLDUPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 15:15:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86272D2
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 12:15:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E85EDC433C7;
        Mon,  4 Dec 2023 20:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1701720925;
        bh=Oa+AKNnfNJKYaj5c5DLXMZSQbG2uQbsRvEdWdjOKPxE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pvZROeSiPwT0U9Ds4tzHhAfzYiGa8TlQ8YX3RHsa7xnOqpQNt6rX2SdCG53uQ0Ax5
         rOE+cr/D7DDykyuEdJQg3wsmj56gubbWf+APhs1arrAJqJW/sGzZf4Za3UVDl/kORY
         WDvtLe1kGvWVrHW+rMQ4ZMZ9H2Tr/8IFN3pQAx/E=
Date:   Mon, 4 Dec 2023 12:15:24 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Dmytro Maluka <dmaluka@chromium.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/thp: add CONFIG_TRANSPARENT_HUGEPAGE_NEVER option
Message-Id: <20231204121524.dfa9f98e809c91b353968d34@linux-foundation.org>
In-Reply-To: <ZW4vLV_LDFLf1cJQ@google.com>
References: <20231204163254.2636289-1-dmaluka@chromium.org>
        <20231204111301.7e087b2f851b30121561e8fc@linux-foundation.org>
        <ZW4vLV_LDFLf1cJQ@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Dec 2023 20:57:33 +0100 Dmytro Maluka <dmaluka@chromium.org> wrote:

> On Mon, Dec 04, 2023 at 11:13:01AM -0800, Andrew Morton wrote:
> > On Mon,  4 Dec 2023 17:32:54 +0100 Dmytro Maluka <dmaluka@chromium.org> wrote:
> > 
> > > Add an option to disable transparent hugepages by default, in line with
> > > the existing transparent_hugepage=never command line setting.
> > > 
> > > Rationale: khugepaged has its own non-negligible memory cost even if it
> > > is not used by any applications, since it bumps up vm.min_free_kbytes to
> > > its own required minimum in set_recommended_min_free_kbytes(). For
> > > example, on a machine with 4GB RAM, with 3 mm zones and pageblock_order
> > > == MAX_ORDER, starting khugepaged causes vm.min_free_kbytes increase
> > > from 8MB to 132MB.
> > > 
> > > So if we use THP on machines with e.g. >=8GB of memory for better
> > > performance, but avoid using it on lower-memory machines to avoid its
> > > memory overhead, then for the same reason we also want to avoid even
> > > starting khugepaged on those <8GB machines. So with
> > > CONFIG_TRANSPARENT_HUGEPAGE_NEVER we can use the same kernel image on
> > > both >=8GB and <8GB machines, with THP support enabled but khugepaged
> > > not started by default. The userspace can then decide to enable THP
> > > (i.e. start khugepaged) via sysfs if needed, based on the total amount
> > > of memory.
> > > 
> > > This could also be achieved with the existing transparent_hugepage=never
> > > setting in the kernel command line instead. But it seems cleaner to
> > > avoid tweaking the command line for such a basic setting.
> > > 
> > > P.S. I see that CONFIG_TRANSPARENT_HUGEPAGE_NEVER was already proposed
> > > in the past [1] but without an explanation of the purpose.
> > > 
> > > ...
> > >
> > > --- a/mm/Kconfig
> > > +++ b/mm/Kconfig
> > > @@ -859,6 +859,12 @@ choice
> > >  	  madvise(MADV_HUGEPAGE) but it won't risk to increase the
> > >  	  memory footprint of applications without a guaranteed
> > >  	  benefit.
> > > +
> > > +	config TRANSPARENT_HUGEPAGE_NEVER
> > > +		bool "never"
> > > +	help
> > > +	  Disabling Transparent Hugepage by default. It can still be
> > 
> > s/Disabling/Disable/
> 
> It is in line with the descriptions of TRANSPARENT_HUGEPAGE_ALWAYS and
> TRANSPARENT_HUGEPAGE_MADVISE: "Enabling Transparent Hugepage ..."

Those are incorrect also.

> > > +	  enabled at runtime via sysfs.
> > >  endchoice
> > 
> > The patch adds the config option but doesn't use it?
> 
> I should have been more precise: it is not a new option but a new choice
> for CONFIG_TRANSPARENT_HUGEPAGE, in addition to the existing ALWAYS and
> MADVISE choices. In mm/huge_memory.c in the declaration of the
> transparent_hugepage_flags variable, if either ALWAYS or MADVISE is
> chosen, transparent_hugepage_flags is initialized with such a value
> that makes khugepaged being started by default during bootup. This patch
> allows enabling CONFIG_TRANSPARENT_HUGEPAGE without setting either
> ALWAYS or MADVISE, so that transparent_hugepage_flags is initialized
> with such a value that khugepaged is not started by default.

OK, thanks.
