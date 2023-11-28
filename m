Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1397FC1F8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345696AbjK1RbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 12:31:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345622AbjK1RbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 12:31:22 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F20C10F6;
        Tue, 28 Nov 2023 09:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TcNNfdi3KsAPDdxCjTj68O8PLD2CqbFi0ErmX0VMdVk=; b=XKMB56KL8bYqu43xummWVXIF3E
        8ryO6YWJJGoCy0bzflD5VWV5xxOItsOPC9cRyaHTAreOUA4AjWxTkD2r3D9x/NLWaEznM57QPM1Af
        /W4tyRPNYtmuiEK/9UJJ1CTCgGOwqaYmsV5c4liup7Bz1g+IY9JAWrQlE4S9Rw9ycJL4XwAInjHyx
        cH2vE8J/bEbU02zXo8zhCe219qcvi6FVSh1LyRTGOH3zUD8LkmkZ5YKn8+cj/iKKnrZwWelUgJmav
        wmfW5Aj2A66Se2L5X4JyNydg7lxZgHJ9QHzxS+AtcHUSqM0IteCnHmBYHRba8a2xMfuaqQLOCC6JS
        7gqxfO6w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r81vc-00Gg2z-0D;
        Tue, 28 Nov 2023 17:31:20 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id B371C3004AB; Tue, 28 Nov 2023 18:31:19 +0100 (CET)
Date:   Tue, 28 Nov 2023 18:31:19 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Aiqun(Maria) Yu" <quic_aiquny@quicinc.com>
Cc:     Elliot Berman <quic_eberman@quicinc.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Ingo Molnar <mingo@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Pavan Kondeti <quic_pkondeti@quicinc.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abhijeet Dharmapurikar <quic_adharmap@quicinc.com>
Subject: Re: [PATCH 0/2] freezer,sched: do not restore saved_state of a
 thawed task
Message-ID: <20231128173119.GC3818@noisy.programming.kicks-ass.net>
References: <20231120-freezer-state-multiple-thaws-v1-0-f2e1dd7ce5a2@quicinc.com>
 <a86228f5-c1ae-4afe-87bd-5144633a9601@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a86228f5-c1ae-4afe-87bd-5144633a9601@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 05:12:00PM +0800, Aiqun(Maria) Yu wrote:
> On 11/21/2023 1:36 AM, Elliot Berman wrote:
> > This series applies couple fixes to commit 8f0eed4a78a8 ("freezer,sched:
> > Use saved_state to reduce some spurious wakeups") which was found while
> > testing with legacy cgroup freezer. My original testing was only with
> > system-wide freezer. We found that thaw_task could be called on a task
> > which was already frozen. Prior to commit 8f0eed4a78a8 ("freezer,sched:
> > Use saved_state to reduce some spurious wakeups"), this wasn't an issue
> > as kernel would try to wake up TASK_FROZEN, which wouldn't match the
> > thawed task state, and no harm done to task. After commit 8f0eed4a78a8
> > ("freezer,sched: Use saved_state to reduce some spurious wakeups"), it
> > was possible to overwrite the state of thawed task.
> > 
> > To: Rafael J. Wysocki <rafael@kernel.org>
> > To: Pavel Machek <pavel@ucw.cz>
> > To: Ingo Molnar <mingo@kernel.org>
> > To: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Cc:  <linux-arm-msm@vger.kernel.org>
> > Cc: Pavan Kondeti <quic_pkondeti@quicinc.com>
> > Cc: Aiqun Yu (Maria) <quic_aiquny@quicinc.com>
> > Cc:  <linux-pm@vger.kernel.org>
> > Cc:  <linux-kernel@vger.kernel.org>
> > Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> Shall we add Fixed tag and Cc: stable@vger.kernel.org ?
> Since it is fixing a stable user thread hung issue.

If you want this routed through urgent, then yes.
