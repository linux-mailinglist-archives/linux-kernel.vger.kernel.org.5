Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 109DE79EE23
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 18:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjIMQS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 12:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjIMQS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 12:18:26 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687FBB8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 09:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=nH3tgwOP9WbDbQOtNlqhn5VbCSgqMUKGst97brz4uEs=; b=UksTaDZb0xtgrxsJn3QTMrNZoH
        5V7PBXWwzahrQzYEcqrCwvHymeYZnbiDEn74Dmrc8GMVHaXxT1wLKX/sxL7YAzreVscX7ZnPYUTXQ
        6lu4CKdVUZOsI306vUGV7LulZQ5eIAaO8zsMXUj7i4idfLtr1ht6l3sc924LF3YcOuVOQ3DtcgY6Y
        6qPbRaPN9RoJv8J0sZeyHZzkTIQh3wnf+dMBfBdPYAGSLVe3MudSljiUTvEJjRX2UC7/j3ecLJfRX
        U2zrXLLJbBZQE7l0L2vYbhA5Jin2eXbroE79rzvlvHOCA2iMCF6MjvjrSxSns7W+wTmYNVn6xfT66
        Aijvo+JQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qgSYm-00796t-30;
        Wed, 13 Sep 2023 16:17:50 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0E386300348; Wed, 13 Sep 2023 18:17:50 +0200 (CEST)
Date:   Wed, 13 Sep 2023 18:17:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH,RFC] smp,csd: throw an error if a CSD lock is stuck for
 too long
Message-ID: <20230913161749.GK692@noisy.programming.kicks-ass.net>
References: <20230821160409.663b8ba9@imladris.surriel.com>
 <20230913132251.GE22758@noisy.programming.kicks-ass.net>
 <2189326aaca37487b17eb1103830156ff1684c27.camel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2189326aaca37487b17eb1103830156ff1684c27.camel@surriel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 10:33:51AM -0400, Rik van Riel wrote:
> On Wed, 2023-09-13 at 15:22 +0200, Peter Zijlstra wrote:
> > On Mon, Aug 21, 2023 at 04:04:09PM -0400, Rik van Riel wrote:
> > > 
> > > +       /* How long since this CSD lock was stuck. */
> > > +       ts_delta = ts2 - ts0;
> > > 
> > > +       /*
> > > +        * If the CSD lock is still stuck after 5 minutes, it is
> > > unlikely
> > > +        * to become unstuck. Use a signed comparison to avoid
> > > triggering
> > > +        * on underflows when the TSC is out of sync between
> > > sockets.
> > > +        */
> > > +       BUG_ON((s64)ts_delta > 300000000000LL);
> > >         if (cpu_cur_csd && csd != cpu_cur_csd) {
> > >                 pr_alert("\tcsd: CSD lock (#%d) handling prior
> > > %pS(%ps) request.\n",
> > >                          *bug_id, READ_ONCE(per_cpu(cur_csd_func,
> > > cpux)),
> > 
> > How are you guys still seeing this? I thought the KVM APIC thing was
> > fixed a while ago?
> > 
> It's more fun than that. We're seeing this on bare metal.

Oh, 'fun' indeed, *groan*.

> Unfortunately, when a system gets wedged that way currently,
> it ends up being power cycled automatically, and we aren't
> getting crash dumps with clues on what causes the issue.
> 
> Doing a BUG_ON() + panic, followed by a kexec into the kdump
> kernel will hopefully give us some clues on what might be
> causing the issue.

I'm conflicted on the need to push such a debug patch upstream, otoh.
given the amount of debug code already in csd, why not.

But yeah, curious hear what comes out of this.
