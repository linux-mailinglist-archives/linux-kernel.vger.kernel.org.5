Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC4A7BFB13
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 14:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbjJJMTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 08:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbjJJMSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 08:18:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF53E6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 05:18:49 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696940327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n34Yjr73UApla1HKKWZ0In4KYUOcdx7o7ymM14zpnvc=;
        b=bVoHiOmHJDgIhpQI/d4gwM/rUlZ4hSDm+JxKCz3NI+s6TaxxyAeczIz68YpSjEig01B1l5
        TAniTBhyk8w3w2ALwLy+kb5auG9npYtVrHhoDvfa3le7C2s/sIfmFYycmbFJv9Vj5RA2lp
        S6j/Wjc2BBZvRt2qUNrYOWCFlLcrxCi9nDWMYu07xV7u4AXaIFJM/4XAqXJns82mrreHfv
        ZCuH6TIoATERFsir/MbVnCHMBwLo0AT8c9/90n5kV3eSgxHOYli6at+wOwemD6ZgCMY5+6
        FIbTzmi8SSCr91MU40QFipJSJcBAqanPPV2XQAjOk4O1SIwlQOTfsocuXLdg8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696940327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n34Yjr73UApla1HKKWZ0In4KYUOcdx7o7ymM14zpnvc=;
        b=HYgFWSMOjhTDGW9zE7WA/ZI3YV+PC3+iv9wWqxCHLQAsoHPxosKmRGgLIiQkcC+ak1YJgE
        gchdhlKrtOc4TRDQ==
To:     Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Pu Wen <puwen@hygon.cn>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>
Subject: Re: [patch V4 02/41] cpu/SMT: Make SMT control more robust against
 enumeration failures
In-Reply-To: <3b9518f5-8b92-1c24-286c-47bf9e8b8a2e@intel.com>
References: <20230814085006.593997112@linutronix.de>
 <20230814085112.149440843@linutronix.de>
 <3b9518f5-8b92-1c24-286c-47bf9e8b8a2e@intel.com>
Date:   Tue, 10 Oct 2023 14:18:47 +0200
Message-ID: <87r0m2oel4.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15 2023 at 14:15, Dave Hansen wrote:
> On 8/14/23 01:53, Thomas Gleixner wrote:
>> -static inline bool cpu_smt_allowed(unsigned int cpu)
>> +static inline bool cpu_bootable(unsigned int cpu)
>>  {
>>  	if (cpu_smt_control == CPU_SMT_ENABLED)
>>  		return true;
>>  
>> +	if (cpu_smt_control == CPU_SMT_NOT_SUPPORTED)
>> +		return true;
>
> I found this new pair of if()'s rather counterintuitive to read.
>
> The first one reads like:
>
> 	"If SMT is not supported, the CPU is always bootable"
>
> but "supported" could easily mean CONFIG_SMP==n (which is actually
> covered in the next case).  Would this be better named:
>
> 	CPU_SMT_NOT_ENUMERATED
> or
> 	CPU_SMT_NOT_DETECTED
>
> ?

Yes, no, maybe. I rather keep them as is because the strings which are
exposed via sysfs cannot be changed and are matching.

> 	/* Every CPU is bootable on non-SMT systems: */
> 	if (cpu_smt_control == CPU_SMT_NOT_DETECTED)
> 		return true;
>
> For the next one:
>
>> +	if (cpu_smt_control == CPU_SMT_NOT_IMPLEMENTED)
>> +		return true;
>
> This reads a bit like "SMT is not implemented" rather than "SMT controls
> are not implemented".  Maybe a comment would help:
>
> 	/* All CPUs are bootable if controls are not implemented: */

Sure.
