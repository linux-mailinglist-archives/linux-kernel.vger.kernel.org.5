Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD2B7C4C65
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 09:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjJKHvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 03:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjJKHvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 03:51:47 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81382AC;
        Wed, 11 Oct 2023 00:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=eEZSBqQ9YE3ctS4Sdh5+G5TGt1bwrC3NMuUntiLTjDc=; b=U+D6mGCOtudlQUAgOIxYO06sJz
        6B0x59BEEsecpZUeqv+G1JWrosSgqaKl2oG5sB0TJR2FIRlRqDP16whkJ3GWvdURPqeYPgEX7jJwm
        41cu24VbG6F8HwNtwD++tolSUacaRiAvL5u8wzX11VbdRY3cGihDvXKpVaI8HKRJsfVvsdRBWSuC4
        g5bmHnYNUX92dHsd2m1IDbwdch0TVveVbzdMwRr4eJPmos94dt/+fXkddeNFZmB3j3Ex94BcVNi39
        QKNqlhPo4MKDGy3FdGcdV3ODF35gkrMt4NLKlCfuYDB5cYGCajGyIjxihDyJ8edDVoYRwACI7/qvW
        ycaLzMfw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qqU0F-0003xP-0c;
        Wed, 11 Oct 2023 07:51:36 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4F3E530026F; Wed, 11 Oct 2023 09:51:36 +0200 (CEST)
Date:   Wed, 11 Oct 2023 09:51:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>, stable@vger.kernel.org
Subject: Re: [PATCH] perf/core: Introduce cpuctx->cgrp_ctx_list
Message-ID: <20231011075136.GM14330@noisy.programming.kicks-ass.net>
References: <20231004040844.797044-1-namhyung@kernel.org>
 <20231004160224.GB6307@noisy.programming.kicks-ass.net>
 <CAM9d7cizC0J85ByuF5fBmc_Bqi=wpNJpiVsw+3F1Avusn2aQog@mail.gmail.com>
 <20231009210425.GC6307@noisy.programming.kicks-ass.net>
 <CAM9d7cigs9mWuYiE=MYNg-xVhXzDu5FF6GdMGJi=D_zP1zJoCQ@mail.gmail.com>
 <CAM9d7cjxSd9QJzTs1_s6Nh7c38FZ7_2FGPoCunvnmjX_y-+Dyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7cjxSd9QJzTs1_s6Nh7c38FZ7_2FGPoCunvnmjX_y-+Dyg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 08:45:03PM -0700, Namhyung Kim wrote:
> On Mon, Oct 9, 2023 at 9:57 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hi Peter,
> >
> > On Mon, Oct 9, 2023 at 2:04 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Wed, Oct 04, 2023 at 09:32:24AM -0700, Namhyung Kim wrote:
> > >
> > > > Yeah, I know.. but I couldn't come up with a better solution.
> > >
> > > Not been near a compiler, and haven't fully thought it through, but
> > > could something like the work work?
> >
> > Thanks for the patch, I think it'd work.  Let me test it
> > and get back to you.
> 
> I worked well but contained a typo.  See below.

Ha, typing hard ;-) I did say it hadn't been near a compiler ...

> Which way do you want to process this change?  Do I send it again
> with your S-o-b or will you apply it by yourself?  Either is fine, just
> let me know.  In case of latter, you can add

I'll go write me a Changelog and apply the thing, then we can forget
about things.
