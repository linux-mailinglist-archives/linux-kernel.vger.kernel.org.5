Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A9F760AEC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 08:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbjGYGvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 02:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbjGYGvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 02:51:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB10BD;
        Mon, 24 Jul 2023 23:51:15 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690267873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qTSiGFdzDyf1mwg76cDRV4nFA1LBdaWOeq/VwaKIiXQ=;
        b=gugcPXUsURN8CiK4gBblLM8WprgclBunxGBjioeu0mP2lJgVKud+4wII4ChSIKvsaNcTpm
        iqvMelH1IG0ENaS7X0FC+yHmn74aljtxc1JiKvoDb+z6ToAd0KClYAuxUXP0Jfx+TPm6ZX
        6J0UehC7IeTAWKl62CyNzj5UTbl3Mh8LDD22lx6lN3lrfrMP/3gY6m06uQHzfkTy+lru3A
        al1YUmzbuVaT6eeYUxexb5OLkAIuL5E35d1mI3iagp82RY9eAia7/q/JsteVd7C+3sQdm8
        qumt/8+WVlbFDWz3Ec2djWWWj/4aMnHcMj9rnspNnsWZCANCzzmwncUf4xzVag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690267873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qTSiGFdzDyf1mwg76cDRV4nFA1LBdaWOeq/VwaKIiXQ=;
        b=ZIJyz3EHuhOHXV5TbBCQJvJ6IxAQUYjVqwLnNxOTSl/LKu+0yOvmitEHAINhkGkvG7WmKe
        nDOEuof05OYfuNDA==
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Huang Rui <ray.huang@amd.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Steve Wahl <steve.wahl@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>
Subject: Re: [patch 17/29] x86/cpu: Provide a sane leaf 0xb/0x1f parser
In-Reply-To: <20230724204942.GD3745454@hirez.programming.kicks-ass.net>
References: <20230724155329.474037902@linutronix.de>
 <20230724172844.690165660@linutronix.de>
 <20230724204942.GD3745454@hirez.programming.kicks-ass.net>
Date:   Tue, 25 Jul 2023 08:51:12 +0200
Message-ID: <87a5vktrfj.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24 2023 at 22:49, Peter Zijlstra wrote:
> On Mon, Jul 24, 2023 at 07:44:17PM +0200, Thomas Gleixner wrote:
>
>> +static inline bool topo_subleaf(struct topo_scan *tscan, u32 leaf, u32 subleaf)
>> +{
>> +	unsigned int dom, maxtype = leaf == 0xb ? CORE_TYPE + 1 : MAX_TYPE;
>> +	struct {
>> +		// eax
>> +		u32	x2apic_shift	:  5, // Number of bits to shift APIC ID right
>> +					      // for the topology ID at the next level
>> +			__rsvd0		: 27; // Reserved
>> +					      // ebx
>> +		u32	num_processors	: 16, // Number of processors at current level
>> +			__rsvd1		: 16; // Reserved
>> +					      // ecx
>> +		u32	level		:  8, // Current topology level. Same as sub leaf number
>> +			type		:  8, // Level type. If 0, invalid
>> +			__rsvd2		: 16; // Reserved
>> +					      // edx
>> +		u32	x2apic_id	: 32; // X2APIC ID of the current logical processor
>
> That comment seems inconsistent, either have then all aligned or move
> all register names left.

Bah. I had all the register names left at some point. No idea how I lost
that again. Probably when I rolled back to some earlier version after
screwing up :)

>> +
>> +	/* Read all available subleafs and populate the levels */
>> +	for (subleaf = 0; topo_subleaf(tscan, leaf, subleaf); subleaf++);
>
> Personally I prefer:
>
> 	for (;;)
> 		;
>
> that is, have the semicolon on it's own line, but meh.

:)

