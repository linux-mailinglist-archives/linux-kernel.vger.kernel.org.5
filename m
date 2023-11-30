Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A30227FFE7D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 23:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377137AbjK3Wb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 17:31:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjK3Wb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 17:31:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4873F10FA
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 14:32:03 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7115C433C8;
        Thu, 30 Nov 2023 22:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1701383522;
        bh=15PK2iNoEdJqQGu4Y59xZHRAisUs8d1YcFlFM7D9rm4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=C+OuN7+yM+sxavjVw4ZrcIBrT0DvHOfPbhPXXrX/U19VBrV2Ee89qctdK6Xk3Mc76
         64IbiuxS/dQSrMry0JwhugX5ynF6MKtviT1+UEppQDdD+p6YalkV2n1DjzlZFnmRB6
         R0qK8DvoAPQld9ht5Mg/WLLCleifoU+Gb2lBMmt4=
Date:   Thu, 30 Nov 2023 14:32:02 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>
Subject: Re: linux-next: build failure after merge of the mm tree
Message-Id: <20231130143202.70d56b3818ee48b0e4edd213@linux-foundation.org>
In-Reply-To: <20231201090439.7ae92c13@canb.auug.org.au>
References: <20231127132809.45c2b398@canb.auug.org.au>
        <20231127144852.069b2e7e@canb.auug.org.au>
        <20231201090439.7ae92c13@canb.auug.org.au>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Dec 2023 09:04:39 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> > > diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s64/pgtable.c
> > > index be229290a6a7..3438ab72c346 100644
> > > --- a/arch/powerpc/mm/book3s64/pgtable.c
> > > +++ b/arch/powerpc/mm/book3s64/pgtable.c
> > > @@ -542,6 +542,7 @@ void ptep_modify_prot_commit(struct vm_area_struct *vma, unsigned long addr,
> > >  	set_pte_at(vma->vm_mm, addr, ptep, pte);
> > >  }
> > >  
> > > +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > >  /*
> > >   * For hash translation mode, we use the deposited table to store hash slot
> > >   * information and they are stored at PTRS_PER_PMD offset from related pmd
> > > @@ -563,6 +564,7 @@ int pmd_move_must_withdraw(struct spinlock *new_pmd_ptl,
> > >  
> > >  	return true;
> > >  }
> > > +#endif
> > >  
> > >  /*
> > >   * Does the CPU support tlbie?
> > > -- 
> > > 2.40.1  
> 
> I am still carrying this patch (it should probably go into the mm
> tree).  Is someone going to pick it up (assuming it is correct)?

AFAIK we're still awaiting input from the ppc team.

I'll grab it.  If it breaks things then we-told-you-so!
