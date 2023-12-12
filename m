Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54E680ED8C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 14:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346452AbjLLN2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 08:28:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232783AbjLLN1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 08:27:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AED0F2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 05:27:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A46B0C433C7;
        Tue, 12 Dec 2023 13:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702387679;
        bh=A61JJ3QepchMq+n/hTd5+pCDDReFj7GC3GGL0Fy/B70=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fZ79lRiYpPFSifS88bmIdqzYMk2u9yJzTZ5YDjGKQAqeIPuFqi/cUykVzdEfjJEr3
         HGwBR/huZUCDaNiSo0MGDAD81Ts8ow3RgoZFHWRlw3aZQRuocakNw+aMmvegaVGTKx
         eCr3i+xwKcY4TWNbnJjGU+s5l3k5y1UTYCtURVICdIBlHYqK5gJvrnh7Uu3baVCuSa
         C6RZTGXf1ZawGLX0fbo938bWA/f+MykhCONd22BJqfbdvcKMm0rv337CLe37x3siRD
         Wf6RsIxZoGePOPoXScTnQyiMPFSi7j6n8ju05rhVmxYq9/HVyQX4IhO8K/rLeTmVxY
         38iOk+lm6bzIA==
Date:   Tue, 12 Dec 2023 14:27:56 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Gianfranco Dutka <gianfranco.dutka@arista.com>
Cc:     Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
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
Message-ID: <ZXhf3A0FNjFZaZGK@lothringen>
References: <76587DD3-2A77-41A3-9807-6AEE4398EBA6@arista.com>
 <CAKfTPtAkhfAhFouCGTy7m4swCeeEsu1VdWEX_ahOVDq1U594Dg@mail.gmail.com>
 <ZXJKAnrRjBUmKx1V@slm.duckdns.org>
 <d46834f4-a490-4a4a-9e95-cca4a6316570@redhat.com>
 <25E6E1E4-DC16-490E-B907-A3236FB9317A@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <25E6E1E4-DC16-490E-B907-A3236FB9317A@arista.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2023 at 09:18:53AM -0500, Gianfranco Dutka wrote:
> 
> > The isolcpus, nohz_full and rcu_nocbs are boot-time kernel parameters. I am in the process of improving dynamic CPU isolation at runtime. Right now, we are able to do isolcpus=domain with the isolated cpuset partition functionality. Other aspects of CPU isolation are being looked at with the goal of reducing the gap of what one can do at boot time versus what can be done at run time. It will certain take time to reach that goal.
> > 
> > Cheers,
> > Longman
> > 
> 
> Thank you Waiman for the response. It would seem that getting similar
> functionality through cgroups/cpusets is the only option at the moment. Is it
> completely out of the question to possibly patch the kernel to modify these
> parameters at runtime? Or would that entail a significant change that might
> not be so trivial to accomplish? For instance, the solution wouldn’t be as
> simple as patching the kernel to make these writeable and then calling the
> same functions which run at boot-time when these parameters are originally
> written?

As for nohz_full (which implies rcu_nocb), it's certainly possible to make it
tunable at runtime via cpusets. If people really want it, I'm willing to help.

Thanks.
