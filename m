Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E01680F5AE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 19:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376617AbjLLSsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 13:48:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232815AbjLLSst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 13:48:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2F6CE
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 10:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702406934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MlLCC9svnl50XjxVcSD4zVNUv5xUFa+AQPJOzT5s4w8=;
        b=FdKLRMypnOgKVVvCPpTb9mvqQa9mgTPlx6AAhq0i0nfy3xtpKoZJepqXa6aUq/M01qVtqG
        3qWtpFGic3N0cy9JJzOzZpa1LlVyjAOGXD3pQzCuD4GzpdlgIG2mQfzkA5boDlxD6P7Fnv
        oyyZbKdO3TNoKqL4VWDUJ3mhkCKIFKU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-IZAOMrK8PY61ihlC7Jnu5Q-1; Tue, 12 Dec 2023 13:48:48 -0500
X-MC-Unique: IZAOMrK8PY61ihlC7Jnu5Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 157F4833946;
        Tue, 12 Dec 2023 18:48:48 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.9.61])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 30DE82026D66;
        Tue, 12 Dec 2023 18:48:47 +0000 (UTC)
Date:   Tue, 12 Dec 2023 13:48:45 -0500
From:   Phil Auld <pauld@redhat.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Gianfranco Dutka <gianfranco.dutka@arista.com>,
        Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, vincent.guittot@linaro.com,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Subject: Re: Modifying isolcpus, nohz_full, and rcu_nocb kernel parameters at
 runtime
Message-ID: <20231212184845.GA392327@lorien.usersys.redhat.com>
References: <76587DD3-2A77-41A3-9807-6AEE4398EBA6@arista.com>
 <CAKfTPtAkhfAhFouCGTy7m4swCeeEsu1VdWEX_ahOVDq1U594Dg@mail.gmail.com>
 <ZXJKAnrRjBUmKx1V@slm.duckdns.org>
 <d46834f4-a490-4a4a-9e95-cca4a6316570@redhat.com>
 <25E6E1E4-DC16-490E-B907-A3236FB9317A@arista.com>
 <ZXhf3A0FNjFZaZGK@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZXhf3A0FNjFZaZGK@lothringen>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 02:27:56PM +0100 Frederic Weisbecker wrote:
> On Fri, Dec 08, 2023 at 09:18:53AM -0500, Gianfranco Dutka wrote:
> > 
> > > The isolcpus, nohz_full and rcu_nocbs are boot-time kernel parameters. I am in the process of improving dynamic CPU isolation at runtime. Right now, we are able to do isolcpus=domain with the isolated cpuset partition functionality. Other aspects of CPU isolation are being looked at with the goal of reducing the gap of what one can do at boot time versus what can be done at run time. It will certain take time to reach that goal.
> > > 
> > > Cheers,
> > > Longman
> > > 
> > 
> > Thank you Waiman for the response. It would seem that getting similar
> > functionality through cgroups/cpusets is the only option at the moment. Is it
> > completely out of the question to possibly patch the kernel to modify these
> > parameters at runtime? Or would that entail a significant change that might
> > not be so trivial to accomplish? For instance, the solution wouldn’t be as
> > simple as patching the kernel to make these writeable and then calling the
> > same functions which run at boot-time when these parameters are originally
> > written?
> 
> As for nohz_full (which implies rcu_nocb), it's certainly possible to make it
> tunable at runtime via cpusets. If people really want it, I'm willing to help.

That is certainly where we'd like to end up. The ask for this is coming from
our container management side so cpusets would fit that well (along with the
isolation stuff Waiman has been working on).


Thanks,
Phil


> 
> Thanks.
> 

-- 

