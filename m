Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B64879CBB0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 11:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233648AbjILJ1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 05:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233572AbjILJ1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 05:27:39 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F87AA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 02:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sTETxm0fZeCLmoOOxUe0J5C8+eXGhdi3xWo/zenhaTI=; b=ohzN+HmYbLmiKpl4v4XIKRC8Uq
        6wxpK9b98NlBuUuFPTYVMr2wtsexjlsI9Veud3n44KiUw3eu2lfamDAvBVgdjatv4u8uep/0c5YEn
        UD6qZ74pwiCAwWPSh8qfeJQ4JOmMQ/pxSGcrkzfKfkEFbMYAeWyIhHpK/DwwmIoikp8JdmaXJ6drJ
        NHoIvnn3bFDeVD1Y7zpLyy3z3MWg3eDp6uCaA1Bei600pYEd98wMwi9CKIoekrjshmDAmPXxyskHW
        3YZfAP4eVmfX6F7iDit86QN+aAJce41CMHLZ4oiKzKbNEGrjnD+xZvRSv1jYtJMDPkBUUJaEOcn9t
        PClRFL1w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qfzfo-005zEG-1H;
        Tue, 12 Sep 2023 09:27:10 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7CDEB300348; Tue, 12 Sep 2023 11:27:09 +0200 (CEST)
Date:   Tue, 12 Sep 2023 11:27:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, jpoimboe@kernel.org,
        gregkh@linuxfoundation.org, nik.borisov@suse.com
Subject: Re: [PATCH v2 10/11] x86/alternatives: Simplify ALTERNATIVE_n()
Message-ID: <20230912092709.GE35261@noisy.programming.kicks-ass.net>
References: <20230814114426.057251214@infradead.org>
 <20230814121149.176244760@infradead.org>
 <20230907083158.GBZPmKfjarnaQk1ofB@fat_crate.local>
 <20230907110917.GA10955@noisy.programming.kicks-ass.net>
 <20230907150632.GAZPnm+Ly+Vyt8VPYr@fat_crate.local>
 <20230907153036.GBZPnsnNreLCyGpJFn@fat_crate.local>
 <20230909075009.GAZPwjsYZ4sSALN/5+@fat_crate.local>
 <20230909092554.GC2771@noisy.programming.kicks-ass.net>
 <20230910144227.GAZP3V0/mQ73C2hx/l@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230910144227.GAZP3V0/mQ73C2hx/l@fat_crate.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 10, 2023 at 04:42:27PM +0200, Borislav Petkov wrote:
> On Sat, Sep 09, 2023 at 11:25:54AM +0200, Peter Zijlstra wrote:
> > So what you end up with is:
> > 
> > 661:
> >   "one byte orig insn"
> >   "one nop because alt1 is 2 bytes"
> >   "one nop because alt2 is 3 bytes"
> > 
> > right?
> 
> Right.
> 
> > This becomes more of a problem with your example above where the
> > respective lengths are 0, 5, 16. In that case, when you patch 5, you'll
> > leave 11 single nops in there.
> 
> Well, I know what you mean but the code handles that gracefully and it
> works. Watch this:

Aah, because we run optimize_nops() for all alternatives, irrespective
of it being selected. And thus also for the longest and then that'll fix
things up.

OK, let me check on objtool.

