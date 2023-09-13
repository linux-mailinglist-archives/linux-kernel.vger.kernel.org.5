Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF6D79EB2B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 16:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241065AbjIMOed convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 13 Sep 2023 10:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235721AbjIMOed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 10:34:33 -0400
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE75991
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 07:34:28 -0700 (PDT)
Received: from imladris.home.surriel.com ([10.0.13.28] helo=imladris.surriel.com)
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <riel@shelob.surriel.com>)
        id 1qgQwB-0003ew-2k;
        Wed, 13 Sep 2023 10:33:51 -0400
Message-ID: <2189326aaca37487b17eb1103830156ff1684c27.camel@surriel.com>
Subject: Re: [PATCH,RFC] smp,csd: throw an error if a CSD lock is stuck for
 too long
From:   Rik van Riel <riel@surriel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Juergen Gross <jgross@suse.com>
Date:   Wed, 13 Sep 2023 10:33:51 -0400
In-Reply-To: <20230913132251.GE22758@noisy.programming.kicks-ass.net>
References: <20230821160409.663b8ba9@imladris.surriel.com>
         <20230913132251.GE22758@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
Sender: riel@surriel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-09-13 at 15:22 +0200, Peter Zijlstra wrote:
> On Mon, Aug 21, 2023 at 04:04:09PM -0400, Rik van Riel wrote:
> > 
> > +       /* How long since this CSD lock was stuck. */
> > +       ts_delta = ts2 - ts0;
> > 
> > +       /*
> > +        * If the CSD lock is still stuck after 5 minutes, it is
> > unlikely
> > +        * to become unstuck. Use a signed comparison to avoid
> > triggering
> > +        * on underflows when the TSC is out of sync between
> > sockets.
> > +        */
> > +       BUG_ON((s64)ts_delta > 300000000000LL);
> >         if (cpu_cur_csd && csd != cpu_cur_csd) {
> >                 pr_alert("\tcsd: CSD lock (#%d) handling prior
> > %pS(%ps) request.\n",
> >                          *bug_id, READ_ONCE(per_cpu(cur_csd_func,
> > cpux)),
> 
> How are you guys still seeing this? I thought the KVM APIC thing was
> fixed a while ago?
> 
It's more fun than that. We're seeing this on bare metal.

Unfortunately, when a system gets wedged that way currently,
it ends up being power cycled automatically, and we aren't
getting crash dumps with clues on what causes the issue.

Doing a BUG_ON() + panic, followed by a kexec into the kdump
kernel will hopefully give us some clues on what might be
causing the issue.

-- 
All Rights Reversed.
