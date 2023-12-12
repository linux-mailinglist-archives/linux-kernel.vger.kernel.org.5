Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F43480F7BC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 21:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377266AbjLLUSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 15:18:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbjLLUSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 15:18:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580E998
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 12:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702412328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dD7n4FEhzaAZ3ePERhfLjk9v1ddSq1XthivNhDJYrVY=;
        b=IR/lIuIyLoucviVm7tZGFK51DIm2NvwIwHkDUe4vhQzuI9CkYgLa+VpSyl70Nbevre7+v2
        yc+NrAN4uz5uNv83xslqraXf8qoTdVPh8yG3tPOmSndqwux+gyOY8E44jBuy1i6M/9RPrM
        e6salYjcemXmH6v2T1gaU4B1yxwc6wE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-314-XU9fbFpjPayyDVyzQr9e8Q-1; Tue,
 12 Dec 2023 15:18:45 -0500
X-MC-Unique: XU9fbFpjPayyDVyzQr9e8Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ACD8D1C0BB42;
        Tue, 12 Dec 2023 20:18:44 +0000 (UTC)
Received: from [10.22.10.183] (unknown [10.22.10.183])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BD1EE1121306;
        Tue, 12 Dec 2023 20:18:43 +0000 (UTC)
Message-ID: <7e3bf653-d3ea-48b0-b808-d92a3c5f2c5b@redhat.com>
Date:   Tue, 12 Dec 2023 15:18:43 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Modifying isolcpus, nohz_full, and rcu_nocb kernel parameters at
 runtime
Content-Language: en-US
To:     Frederic Weisbecker <frederic@kernel.org>,
        Gianfranco Dutka <gianfranco.dutka@arista.com>
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
        Phil Auld <pauld@redhat.com>,
        Cestmir Kalina <ckalina@redhat.com>
References: <76587DD3-2A77-41A3-9807-6AEE4398EBA6@arista.com>
 <CAKfTPtAkhfAhFouCGTy7m4swCeeEsu1VdWEX_ahOVDq1U594Dg@mail.gmail.com>
 <ZXJKAnrRjBUmKx1V@slm.duckdns.org>
 <d46834f4-a490-4a4a-9e95-cca4a6316570@redhat.com>
 <25E6E1E4-DC16-490E-B907-A3236FB9317A@arista.com>
 <ZXhf3A0FNjFZaZGK@lothringen>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <ZXhf3A0FNjFZaZGK@lothringen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
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


On 12/12/23 08:27, Frederic Weisbecker wrote:
> On Fri, Dec 08, 2023 at 09:18:53AM -0500, Gianfranco Dutka wrote:
>>> The isolcpus, nohz_full and rcu_nocbs are boot-time kernel parameters. I am in the process of improving dynamic CPU isolation at runtime. Right now, we are able to do isolcpus=domain with the isolated cpuset partition functionality. Other aspects of CPU isolation are being looked at with the goal of reducing the gap of what one can do at boot time versus what can be done at run time. It will certain take time to reach that goal.
>>>
>>> Cheers,
>>> Longman
>>>
>> Thank you Waiman for the response. It would seem that getting similar
>> functionality through cgroups/cpusets is the only option at the moment. Is it
>> completely out of the question to possibly patch the kernel to modify these
>> parameters at runtime? Or would that entail a significant change that might
>> not be so trivial to accomplish? For instance, the solution wouldn’t be as
>> simple as patching the kernel to make these writeable and then calling the
>> same functions which run at boot-time when these parameters are originally
>> written?
> As for nohz_full (which implies rcu_nocb), it's certainly possible to make it
> tunable at runtime via cpusets. If people really want it, I'm willing to help.

As said by Phil, your help in in enabling dynamic rcu_nocb will be 
greatly appreciated. My current thought is to have a root level 
cpuset.cpus.isolation_control file to enable additional CPU isolation 
like rcu_nocb to be applied to CPUs in isolated partitions.

Cheers,
Longman

