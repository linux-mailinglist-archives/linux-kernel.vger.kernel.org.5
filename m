Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC3380A79A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 16:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574374AbjLHPjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 10:39:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574350AbjLHPjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 10:39:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739AEFB
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 07:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702049999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QVNp5yABNZJprMXFRXBef0K1nSQmZiO4SNxd+eql7bc=;
        b=cloKEpw5QIymDPebOPsP7ekNk4uvEATv/K4y8B9Kq2RwRzoneqVI6TPx4KRoy4fbrE1jcb
        EDsp7k9EfGTFvilInkz7KeTRF7WAKPN5vkly8R9HiVezhvKH5YGXIs5kx1eDhX0rtOCWjc
        /A/ZqPe2pNdxLWa4fbm+/kizTNDdQgc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-pWPxv9W-NpqHHxYh55Bchw-1; Fri, 08 Dec 2023 10:39:53 -0500
X-MC-Unique: pWPxv9W-NpqHHxYh55Bchw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 73A0585A589;
        Fri,  8 Dec 2023 15:39:52 +0000 (UTC)
Received: from [10.22.9.55] (unknown [10.22.9.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6862140C6EB9;
        Fri,  8 Dec 2023 15:39:51 +0000 (UTC)
Message-ID: <4cddddc3-699b-44d6-97a4-9964ca2e60b2@redhat.com>
Date:   Fri, 8 Dec 2023 10:39:50 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Modifying isolcpus, nohz_full, and rcu_nocb kernel parameters at
 runtime
Content-Language: en-US
To:     Gianfranco Dutka <gianfranco.dutka@arista.com>
Cc:     Tejun Heo <tj@kernel.org>,
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
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>
References: <76587DD3-2A77-41A3-9807-6AEE4398EBA6@arista.com>
 <CAKfTPtAkhfAhFouCGTy7m4swCeeEsu1VdWEX_ahOVDq1U594Dg@mail.gmail.com>
 <ZXJKAnrRjBUmKx1V@slm.duckdns.org>
 <d46834f4-a490-4a4a-9e95-cca4a6316570@redhat.com>
 <25E6E1E4-DC16-490E-B907-A3236FB9317A@arista.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <25E6E1E4-DC16-490E-B907-A3236FB9317A@arista.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/8/23 09:18, Gianfranco Dutka wrote:
>
>> The isolcpus, nohz_full and rcu_nocbs are boot-time kernel 
>> parameters. I am in the process of improving dynamic CPU isolation at 
>> runtime. Right now, we are able to do isolcpus=domain with the 
>> isolated cpuset partition functionality. Other aspects of CPU 
>> isolation are being looked at with the goal of reducing the gap of 
>> what one can do at boot time versus what can be done at run time. It 
>> will certain take time to reach that goal.
>>
>> Cheers, Longman
>>
>
> Thank you Waiman for the response. It would seem that getting similar 
> functionality through cgroups/cpusets is the only option at the 
> moment. Is it completely out of the question to possibly patch the 
> kernel to modify these parameters at runtime? Or would that entail a 
> significant change that might not be so trivial to accomplish? For 
> instance, the solution wouldn’t be as simple as patching the kernel to 
> make these writeable and then calling the same functions which run at 
> boot-time when these parameters are originally written?

I would say that using cgroup/cpusets is probably the most you can do 
with dynamic CPU isolation at the moment. OTOH, it may not be a good 
idea to have more than one way of doing the same thing as it will lead 
to code duplication and inconsistency. I don't think it is that easy to 
make CPU isolation fully dynamic and we must be careful not to introduce 
any regression.

Cheers,
Longman

