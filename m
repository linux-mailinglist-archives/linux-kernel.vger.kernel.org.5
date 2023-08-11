Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 797BA7795E3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 19:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234383AbjHKRLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 13:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234215AbjHKRLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 13:11:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04CC130DC
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 10:11:08 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691773865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JwyIkaKnmged+6iD5cEH4DiyqcAjZzg85lmaqTOjsCM=;
        b=xPk6eNzOBlGDBWMWdONIUP8oaVOw9O0gtZGBdxu+2qTUp2QEjL1jxazsgQ1EwSpkEm+8Tp
        erdcIwzoDhwVdPh0MDPymdm6RUXFYfSEmmlEcrF++o6vY72YpHxULrFzVa30DKMiZgD/1J
        5XqwVwlNJM8yoq36q7nk1hNf0YGIExb/1vCmxJCV2fFvVpSAp8V8UNB3HxVGchiVbf6eY2
        LlqDEDQIzCPaBjukGuivT7iF2Qwa7fg88SW+CgP7S0gwGIOnobBvken5MMsdlvjL3T+wjV
        1rFBUPzSha7D/clqmo32YtBqXurxYxkF1q09xuRZfFjl3u9mXFVcolRZSayaGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691773865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JwyIkaKnmged+6iD5cEH4DiyqcAjZzg85lmaqTOjsCM=;
        b=Lj3+5TtBev8QyRTlUSTewJWtY5QIpCm1lvYgcTPPpJ2TeeKTD4g1UahuunSQHJWgvlaKhI
        +EzPuDumVD+CuNBw==
To:     Pu Wen <pu_wen@foxmail.com>, LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
Subject: Re: [patch V3a 30/40] x86/cpu: Provide an AMD/HYGON specific
 topology parser
In-Reply-To: <tencent_3C08D6938E6BD58AACCF018E0A7F3B848807@qq.com>
References: <20230802101635.459108805@linutronix.de>
 <20230802101934.418143974@linutronix.de> <87il9xjk95.ffs@tglx>
 <tencent_3C08D6938E6BD58AACCF018E0A7F3B848807@qq.com>
Date:   Fri, 11 Aug 2023 19:11:05 +0200
Message-ID: <87jzu1h5cm.ffs@tglx>
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

On Fri, Aug 11 2023 at 20:58, Pu Wen wrote:
> On 2023/8/3 3:51, Thomas Gleixner wrote:
>> +	if (tscan->c->x86_vendor == X86_VENDOR_AMD) {
>> +		if (tscan->c->x86 == 0x15)
>> +			tscan->c->topo.cu_id = leaf.cuid;
>> +
>> +		cacheinfo_amd_init_llc_id(tscan->c, leaf.nodeid);
>> +	} else {
>> +		/*
>> +		 * Package ID is ApicId[6..] on Hygon CPUs. See commit
>> +		 * e0ceeae708ce for explanation. The topology info is
>> +		 * screwed up: The package shift is always 6 and the node
>> +		 * ID is bit [4:5]. Don't touch the latter without
>> +		 * confirmation from the Hygon developers.
>> +		 */
>> +		topology_set_dom(tscan, TOPO_CORE_DOMAIN, 6, tscan->dom_ncpus[TOPO_CORE_DOMAIN]);
>
> Hygon updated CPUs will not always shift 6, and shift 6 is not good for 
> running guests.
> So suggest to modify like this:
>      if (!boot_cpu_has(X86_FEATURE_HYPERVISOR) && tscan->c->x86_model <= 
> 0x3)
>          topology_set_dom(tscan, TOPO_CORE_DOMAIN, 6, 
> tscan->dom_ncpus[TOPO_CORE_DOMAIN]);

This is exactly what the existing code does today. Can you please send a
delta patch on top of this with a proper explanation?

Thanks,

        tglx
