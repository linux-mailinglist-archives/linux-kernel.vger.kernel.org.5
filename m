Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54A2079F2BE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 22:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbjIMUSL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 13 Sep 2023 16:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjIMUSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 16:18:10 -0400
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9331BC6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 13:18:06 -0700 (PDT)
Received: from imladris.home.surriel.com ([10.0.13.28] helo=imladris.surriel.com)
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <riel@shelob.surriel.com>)
        id 1qgWIo-0006uU-18;
        Wed, 13 Sep 2023 16:17:34 -0400
Message-ID: <925761974f452b3f7afa98f96cf6762dc8d89dba.camel@surriel.com>
Subject: Re: [PATCH,RFC] smp,csd: throw an error if a CSD lock is stuck for
 too long
From:   Rik van Riel <riel@surriel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Juergen Gross <jgross@suse.com>
Date:   Wed, 13 Sep 2023 16:17:34 -0400
In-Reply-To: <20230913161749.GK692@noisy.programming.kicks-ass.net>
References: <20230821160409.663b8ba9@imladris.surriel.com>
         <20230913132251.GE22758@noisy.programming.kicks-ass.net>
         <2189326aaca37487b17eb1103830156ff1684c27.camel@surriel.com>
         <20230913161749.GK692@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
Sender: riel@surriel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-09-13 at 18:17 +0200, Peter Zijlstra wrote:
> On Wed, Sep 13, 2023 at 10:33:51AM -0400, Rik van Riel wrote:
> > > 
> > It's more fun than that. We're seeing this on bare metal.
> 
> Oh, 'fun' indeed, *groan*.
> 
> > Unfortunately, when a system gets wedged that way currently,
> > it ends up being power cycled automatically, and we aren't
> > getting crash dumps with clues on what causes the issue.
> > 
> > Doing a BUG_ON() + panic, followed by a kexec into the kdump
> > kernel will hopefully give us some clues on what might be
> > causing the issue.
> 
> I'm conflicted on the need to push such a debug patch upstream, otoh.
> given the amount of debug code already in csd, why not.
> 
> But yeah, curious hear what comes out of this.
> 
Oh, there's more to it than just debugging the issue.

This will also help recover systems faster, since they
will end up panicking, kdumping, and rebooting, faster
than the "hey, that system looks like it's stuck"
power cycling scripts can get to it.

-- 
All Rights Reversed.
