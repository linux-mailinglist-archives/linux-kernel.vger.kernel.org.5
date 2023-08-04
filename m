Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B43FF76FC04
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 10:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234725AbjHDI3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 04:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234673AbjHDI25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 04:28:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170551FCF
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 01:28:32 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691137711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nG9NMi09qPiIVhfxyVq6fbFzAi3GlRiV5e3SNDBnopg=;
        b=rerbYvlRKutJP0T8x0WBfoLxwL0joDr+jxOh/9VQrrPlG1FjmCEAlRWBoEpu++pvFFinbn
        sg8maeIsS1Geyr3QdGP8uyzRE2gsnwRKXfYKt3S6B/38rvug1CxwOp9MhyECvBjLW9HDzM
        nHqOQy57vtfY4qEPEJMA1l9vIggjumOy5xLE/0iktwYHAbPKaOv0EdpVItUtakJd65nL6T
        Sc+ufa+ZSMACNq4fd+GaXNq2qMww9GIqZCsWUzQEWgHfKJalWd/ymzOI8HpQWzXVU45AIT
        aICGEDc8rE4lUtI4YAai98o68GvXFCAFa1pyOoo1fPa+WgG1jUibncZIzgubpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691137711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nG9NMi09qPiIVhfxyVq6fbFzAi3GlRiV5e3SNDBnopg=;
        b=XUmCnEdMsEoHLAVk5r5mhdmoZhZ/CI9eJwfSr3BIoUHKSOUZOS53NecZj/TBdTGysJFTds
        GORyTHH18R74BnBA==
To:     K Prateek Nayak <kprateek.nayak@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
Subject: Re: [patch V3 23/40] x86/cpu: Provide cpu_init/parse_topology()
In-Reply-To: <03ded839-a746-b741-02dd-c10fe37460bf@amd.com>
References: <20230802101635.459108805@linutronix.de>
 <20230802101934.026097251@linutronix.de>
 <03ded839-a746-b741-02dd-c10fe37460bf@amd.com>
Date:   Fri, 04 Aug 2023 10:28:30 +0200
Message-ID: <87leer1aa9.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04 2023 at 13:44, K Prateek Nayak wrote:
> On 8/2/2023 3:51 PM, Thomas Gleixner wrote:
>>
>> [..snip..]
>>
>> +static void topo_set_max_cores(struct topo_scan *tscan)
>> +{
>> +	/*
>> +	 * Bug compatible for now. This is broken on hybrid systems:
>> +	 * 8 cores SMT + 8 cores w/o SMT
>> +	 * tscan.dom_ncpus[TOPO_CORE_DOMAIN] = 24; 24 / 2 = 12 !!
>> +	 *
>> +	 * Cannot be fixed without further topology enumeration changes.
>> +	 */
>> +	tscan->c->x86_max_cores = tscan->dom_ncpus[TOPO_CORE_DOMAIN] >>
>> +		x86_topo_system.dom_shifts[TOPO_SMT_DOMAIN];
>> +}
>>
>
> In Documentation/arch/x86/topology.rst, "cpuinfo_x86.x86_max_cores" is
> described as "The number of cores in a package". In which case,
> shouldn't the above be:
>
> 	tscan->c->x86_max_cores = tscan->dom_ncpus[TOPO_PKG_DOMAIN] >>
> 		x86_topo_system.dom_shifts[TOPO_SMT_DOMAIN];
>
> since, with extended topology, there could be other higher domains and
> dom_ncpus[TOPO_CORE_DOMAIN] >> dom_shifts[TOPO_SMT_DOMAIN] should only
> give number of cores within the next domain (TOPO_MODULE_DOMAIN).

You're right in principle.

> Am I missing something here?

The fact, that this is bug compatible. It's broken in several
aspects. The real fix is in the next series, where this function goes
away and actually uses real topology data to compute this.

I could change this to be more "accurate" as you suggested, but that's
not making much of a difference.

Thanks,

        tglx
