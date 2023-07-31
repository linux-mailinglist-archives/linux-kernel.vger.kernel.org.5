Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B5976A3FD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 00:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbjGaWNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 18:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGaWM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 18:12:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8917A1736;
        Mon, 31 Jul 2023 15:12:40 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690841558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a57aOMuoSA19D/1RvYx/fw5xehQ8MOOaj2fZT0pRM38=;
        b=tIHZwtSe8XcItSxrCKH1rtoRXOwh0yJltki1mAAGk5sPAAngNaQrtnH15IChhzx95Y6X+R
        erTZcajrnzm9SYBONwTyQ7lg9CbgE7DEf49e3IOiI8HYOTdb6uaATjJm6+8kH6rCyzXWYR
        vtihuwjxMCxVWC+yOWM6PPKWnasG/Fp/C8XtbzFDR0sd07snVt6s+WZSjhrbi125K0FUtz
        SObnnoXe2BEnxK2Jsk6OPvaKTTukAKovj+C2krtUnq3T4xFW+ojQDM5fdJCAFCcSpO6Vj0
        6tSwdLg30F7qXDmtQCnJYsrdWbM52jLaq604iaZhbpUcIkDq/r7EMWBMJmTfXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690841558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a57aOMuoSA19D/1RvYx/fw5xehQ8MOOaj2fZT0pRM38=;
        b=PwhvK953X/fbo78hs5vJj2d2ph4pIv5b8KCDD6zDX2WmFCGBgaBDweVd1jE8Yje+chDEtL
        qIkhD97LkwjYq4BA==
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>
Subject: RE: [patch v2 21/38] x86/cpu: Provide cpu_init/parse_topology()
In-Reply-To: <BYAPR21MB1688CE738E6DB857031B829DD705A@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230728105650.565799744@linutronix.de>
 <20230728120930.839913695@linutronix.de>
 <BYAPR21MB16889FD224344B1B28BE22A1D705A@BYAPR21MB1688.namprd21.prod.outlook.com>
 <871qgop8dc.ffs@tglx>
 <20230731132714.GH29590@hirez.programming.kicks-ass.net>
 <87sf94nlaq.ffs@tglx>
 <BYAPR21MB16885EA9B2A7F382D2F9C5A2D705A@BYAPR21MB1688.namprd21.prod.outlook.com>
 <87fs53n6xd.ffs@tglx>
 <BYAPR21MB1688CE738E6DB857031B829DD705A@BYAPR21MB1688.namprd21.prod.outlook.com>
Date:   Tue, 01 Aug 2023 00:12:37 +0200
Message-ID: <873513n31m.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31 2023 at 21:27, Michael Kelley wrote:
> From: Thomas Gleixner <tglx@linutronix.de> Sent: Monday, July 31, 2023 1:49 PM
>> Is there any indication in some other CPUID leaf which lets us deduce this
>> wreckage?
>
> You can detect being a Hyper-V guest with leaf 0x40000000.  See Linux
> kernel function ms_hyperv_platform().  But I'm not aware of anything
> to indicate that a specific Hyper-V VM has the APIC numbering problem
> vs. doesn't have the problem.

That's what I said :) here:

>> I don't think the hypervisor space (0x40000xx) has anything helpful, but
>> staring at the architectural ones provided by hyper-V to the guest might
>> give us an hint. Can you provide a cpuid dump for the boot CPU please?
>> 
>
> I'm not sure if you want the raw or decoded output.  Here's both.

Either way is fine.

Clearly the hyper-v BIOS people put a lot of thoughts into this:

>    x2APIC features / processor topology (0xb):
>       extended APIC ID                      = 0
>       --- level 0 ---
>       level number                          = 0x0 (0)
>       level type                            = thread (1)
>       bit width of level                    = 0x1 (1)
>       number of logical processors at level = 0x2 (2)
>       --- level 1 ---
>       level number                          = 0x1 (1)
>       level type                            = core (2)
>       bit width of level                    = 0x6 (6)
>       number of logical processors at level = 0x40 (64)

FAIL:                                           ^^^^^

While that field is not meant for topology evaluation it is at least
expected to tell the actual number of logical processors at that level
which are actually available. 

The CPUID APIC ID aka initial_apicid clearly tells that the topology has
36 logical CPUs in package 0 and 36 in package 1 according to your
table.

On real hardware this looks like this:

      --- level 1 ---
      level number                          = 0x1 (1)
      level type                            = core (2)
      bit width of level                    = 0x6 (6)
      number of logical processors at level = 0x38 (56)

Which corresponds to reality and is consistent. But sure, consistency is
overrated.

Thanks,

        tglx




