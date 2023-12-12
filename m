Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E017180F79A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 21:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377231AbjLLUNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 15:13:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235047AbjLLUNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 15:13:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8136AA5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 12:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702412006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t4fxZP/IYisq2zbUjkaIJd5qdWpjoCmKZbuHhpCTTSE=;
        b=iT55Q9GTYpFkkiSRBDDr/QxZCx+AgCzc6B3TmU4V7gpLTdpCeDsYPMR9f1HAzU78eayOmX
        G7GrtMQRU+xk0KVr7ra+L7Do1IMWo5thHyN+ukfaYf714Ci+d0Nt2AqNUgJkxy1yyFJ62/
        MDrLuwJ3+k9Xvee0enUo+xoCdIo0jOI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-sOQM5YlMMJCYBc6bHvcaYA-1; Tue, 12 Dec 2023 15:13:23 -0500
X-MC-Unique: sOQM5YlMMJCYBc6bHvcaYA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A68C3185A783;
        Tue, 12 Dec 2023 20:13:22 +0000 (UTC)
Received: from [10.22.10.183] (unknown [10.22.10.183])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9035F492BE6;
        Tue, 12 Dec 2023 20:13:21 +0000 (UTC)
Message-ID: <64589863-d878-4daf-9eac-00717f317022@redhat.com>
Date:   Tue, 12 Dec 2023 15:13:21 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Modifying isolcpus, nohz_full, and rcu_nocb kernel parameters at
 runtime
Content-Language: en-US
To:     "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "Dutka, Gianfranco" <gianfranco.dutka@arista.com>
Cc:     "bsegall@google.com" <bsegall@google.com>,
        "vschneid@redhat.com" <vschneid@redhat.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "vincent.guittot@linaro.com" <vincent.guittot@linaro.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "bristot@redhat.com" <bristot@redhat.com>
References: <76587DD3-2A77-41A3-9807-6AEE4398EBA6@arista.com>
 <CAKfTPtAkhfAhFouCGTy7m4swCeeEsu1VdWEX_ahOVDq1U594Dg@mail.gmail.com>
 <ZXJKAnrRjBUmKx1V@slm.duckdns.org>
 <d46834f4-a490-4a4a-9e95-cca4a6316570@redhat.com>
 <25E6E1E4-DC16-490E-B907-A3236FB9317A@arista.com>
 <ZXhf3A0FNjFZaZGK@lothringen>
 <2059341ff4189c8828a41082248f11712edd2b9e.camel@intel.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <2059341ff4189c8828a41082248f11712edd2b9e.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
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

On 12/12/23 09:04, Pandruvada, Srinivas wrote:
> Hi Fredric,
> On Tue, 2023-12-12 at 14:27 +0100, Frederic Weisbecker wrote:
>> On Fri, Dec 08, 2023 at 09:18:53AM -0500, Gianfranco Dutka wrote:
>>>> The isolcpus, nohz_full and rcu_nocbs are boot-time kernel
>>>> parameters. I am in the process of improving dynamic CPU
>>>> isolation at runtime. Right now, we are able to do
>>>> isolcpus=domain with the isolated cpuset partition functionality.
>>>> Other aspects of CPU isolation are being looked at with the goal
>>>> of reducing the gap of what one can do at boot time versus what
>>>> can be done at run time. It will certain take time to reach that
>>>> goal.
>>>>
>>>> Cheers,
>>>> Longman
>>>>
>>> Thank you Waiman for the response. It would seem that getting
>>> similar
>>> functionality through cgroups/cpusets is the only option at the
>>> moment. Is it
>>> completely out of the question to possibly patch the kernel to
>>> modify these
>>> parameters at runtime? Or would that entail a significant change
>>> that might
>>> not be so trivial to accomplish? For instance, the solution
>>> wouldn’t be as
>>> simple as patching the kernel to make these writeable and then
>>> calling the
>>> same functions which run at boot-time when these parameters are
>>> originally
>>> written?
>> As for nohz_full (which implies rcu_nocb), it's certainly possible to
>> make it
>> tunable at runtime via cpusets. If people really want it, I'm willing
>> to help.
>>
> We have a case for dynamically isolating CPUs at run time.
>
> https://lore.kernel.org/lkml/ZNM5qoUSCdBwNTuH@chenyu5-mobl2/
>
> It was suggested by Vincent to use house keeping cpumask for solving
> unnecessary wake ups on isolated CPUs. Can this house keeping cpu mask
> and type be updated at runtime?

The house keeping cpumasks are statically set up at boot time. The 
cpuset code will have an internal isolated_cpus cpumask that lists all 
the CPUs that are in isolated partitions. It will also expose it with a 
new cpuset_cpu_is_isolated() function. The code is currently in the 
cgroup tree and will be merged into the upcoming v6.8 kernel. As the new 
isolated_cpus mask can be changed at run time, some synchronization may 
be needed depending on how it is being used. So the cpumask itself will 
not be exported, new API can be provided to copy out the cpumask if needed.

Cheers,
Longman

