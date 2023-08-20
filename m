Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B580781F36
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 20:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbjHTSQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 14:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbjHTSQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 14:16:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925C91A1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 11:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fwdMH/uqaWWYlV34IqDTp/Q2i3/nZqT1lDCE/jT/gkQ=; b=chsapUmXXN6qZUtDMrcZB3/R+h
        YQPlj/HVTDOKecHhue3y1590RFrdtiPwJ+AGtxRlWE+ycCFvWlKC78K9INMTelB9jJsoIuGs0/PO2
        IBOVeEUbcfcc9j3rixYHvEnVwvzAMSGGMOyeSy3arifysbdURmmUYiiSAsGOX6Aqmp0kFRMkvOmEm
        bR24Uke/rajnt7I1VMhiqQMjwUU3xAsSiSnKVcXC/Y+NMuoa7fMlRgCMnk1OmHsMhPbAub0/91at7
        irIA6Z0owIilOPBmHnAfF5dUWA7uevUcN2+3/sq50l04R/4RthoD75/BYhPJ2UEK6LIVGmIQTi/ic
        dSJTKRXQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qXmuO-005Toy-Pd; Sun, 20 Aug 2023 18:12:16 +0000
Date:   Sun, 20 Aug 2023 19:12:16 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm: remove unintentional voluntary preemption in
 get_mmap_lock_carefully
Message-ID: <ZOJXgFJybD1ljCHL@casper.infradead.org>
References: <20230820104303.2083444-1-mjguzik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230820104303.2083444-1-mjguzik@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2023 at 12:43:03PM +0200, Mateusz Guzik wrote:
> Found by checking off-CPU time during kernel build (like so:
> "offcputime-bpfcc -Ku"), sample backtrace:
>     finish_task_switch.isra.0
>     __schedule
>     __cond_resched
>     lock_mm_and_find_vma
>     do_user_addr_fault
>     exc_page_fault
>     asm_exc_page_fault
>     -                sh (4502)

Now I'm awake, this backtrace really surprises me.  Do we not check
need_resched on entry?  It seems terribly unlikely that need_resched
gets set between entry and getting to this point, so I guess we must
not.

I suggest the version of the patch which puts might_sleep() before the
mmap_read_trylock() is the right one to apply.  It's basically what
we've done forever, except that now we'll be rescheduling without the
mmap lock held, which just seems like an overall win.
