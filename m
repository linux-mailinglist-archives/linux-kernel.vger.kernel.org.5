Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91FE07C54F4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 15:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234995AbjJKNJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 09:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346062AbjJKNJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 09:09:46 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7CA92
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 06:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sEhqy0TQjUTKPfqjjab4EcmG1KGuaOike/qRtcSt+kw=; b=mBTDAkVDZXX5dRBDyZo5R4bfix
        w8z6rh0I6kZRDBgXNKpz/jMZamWi6/5IV3Bec1OT6WHs7BZabIxYh3m7pG3iE3JnOnxR6S30D6GaN
        oY2qGx7mZha1jWNjnyFCP966wO8cRNOrfwWrfAyHcL3ubrqGgOUpnHbtjWtxK5UuJnAfYZEgBO7Er
        vyvWOPSCbjc561MFpapD5cKmUJcjX5Rf+srqltUZFVmhhmzKSdoIVlYE5ibKu7BZ/Ta3tUnzyChzh
        h0sUZu3+6xnVXYI1jb/DlhUmUE2JNCC4akPvSIXPrh0jewp5kmohVsGxij4hgugxp2hn3oHQPIvZ3
        erPqxtpg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qqYxG-000ETA-1X;
        Wed, 11 Oct 2023 13:08:52 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 917BD30036C; Wed, 11 Oct 2023 15:08:51 +0200 (CEST)
Date:   Wed, 11 Oct 2023 15:08:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     mingo@kernel.org, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, corbet@lwn.net,
        qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, pjt@google.com, pavel@ucw.cz,
        qperret@google.com, tim.c.chen@linux.intel.com, joshdon@google.com,
        timj@gnu.org, kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org, efault@gmx.de,
        tglx@linutronix.de
Subject: Re: [PATCH 01/15] sched/fair: Add avg_vruntime
Message-ID: <20231011130851.GF6337@noisy.programming.kicks-ass.net>
References: <20230531115839.089944915@infradead.org>
 <20230531124603.654144274@infradead.org>
 <75adcb1a-c02f-4d7c-bd9c-ab4f403af3e8@bytedance.com>
 <20231011073001.GI14330@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011073001.GI14330@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 09:30:01AM +0200, Peter Zijlstra wrote:
> On Wed, Oct 11, 2023 at 12:15:28PM +0800, Abel Wu wrote:
> > On 5/31/23 7:58 PM, Peter Zijlstra wrote:
> > > +/*
> > > + * Compute virtual time from the per-task service numbers:
> > > + *
> > > + * Fair schedulers conserve lag:
> > > + *
> > > + *   \Sum lag_i = 0
> > > + *
> > > + * Where lag_i is given by:
> > > + *
> > > + *   lag_i = S - s_i = w_i * (V - v_i)
> > 
> > Since the ideal service time S is task-specific, should this be:
> > 
> > 	lag_i = S_i - s_i = w_i * (V - v_i)
> 

Yes, it should be. Clearly I was delusional this morning.
