Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0FC777311D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 23:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjHGVSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 17:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjHGVSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 17:18:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D441BC
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 14:18:47 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691443126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dQFlAcVpbdRgUn44CMhJm8OFh8ADhlX2XloNqJAsh1E=;
        b=yiS5YGTBx8V16wAIv1qDqZLEy31mVPmEfrZCkLzhoHp9IEf3+TV7daCI2r15BDWO6PcuLU
        RcKklWHM+rJ3swoFtNcofqb2yVFitRoGW0AHQ4QVXGjl67SWW1kJI0IYwqrfqY1rANcpSM
        YmNqzfuJPfFe4DlCffY9hID1ymqMasfIK6Qb2vPJTHa80J4MVEli83cKeUyZ7+wcbIdtAS
        oiQoEqwgvlT4P+EFUXYbrh/ZXgji5MdHpjipp66qeu7mjmFNEJM6g/LDIp2ZUTsd3/YPrY
        GKOA2cBdA0+fsTVcz25BD+0mQbjvNZUI0F/m29wTdbjAQkYke5sPmffWTLjsmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691443126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dQFlAcVpbdRgUn44CMhJm8OFh8ADhlX2XloNqJAsh1E=;
        b=XROi1DDDZCu6XoQmlVeDZJ7Ekuz3gwqbfjZU35s2anlqOkOJKQ5NHBOWFq2VWl3sY34fn2
        Qp1RQpVdRf/BRZCw==
To:     Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Peter Keresztes Schmidt <peter@keresztesschmidt.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [patch V3 26/60] x86/apic/32: Decrapify the def_bigsmp mechanism
In-Reply-To: <09100858-3be2-a9f2-e0af-b6cad67d760b@intel.com>
References: <20230801103042.936020332@linutronix.de>
 <20230801103816.584394452@linutronix.de>
 <09100858-3be2-a9f2-e0af-b6cad67d760b@intel.com>
Date:   Mon, 07 Aug 2023 23:18:45 +0200
Message-ID: <877cq6tutm.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07 2023 at 13:11, Dave Hansen wrote:

> On 8/1/23 03:47, Thomas Gleixner wrote:
> ...
>> -void __init default_setup_apic_routing(void)
>> +void __init x86_32_probe_bigsmp_early(void)
>>  {
>> -	int version = boot_cpu_apic_version;
>> +	if (nr_cpu_ids <= 8 || xen_pv_domain())
>> +		return;
> ...
>> +void __init default_setup_apic_routing(void)
>> +{
>> +	if (nr_cpu_ids >= 8 && !xen_pv_domain())
>> +		apic_bigsmp_force();
>
> I thought bigsmp didn't come into play until 9 or more CPUs.  Won't this
> do apic_bigsmp_force() at nr_cpu_ids==8?
>
> Should this be:
>
> 	if (nr_cpu_ids > 8 && !xen_pv_domain())
> 		apic_bigsmp_force();
>
> ?

Yes, obviously. Thanks for catching that
