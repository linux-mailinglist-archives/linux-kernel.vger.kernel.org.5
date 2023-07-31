Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4166976A228
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 22:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjGaUsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 16:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjGaUsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 16:48:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D6A198B;
        Mon, 31 Jul 2023 13:48:48 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690836527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RI0CJ7D+9SiL2iee0tYtf2iNXcHIA4WEuqt5DO0U+u4=;
        b=ytxM1q6a1kWAOp+kt/SDNX+gtbbFSuFYpq7Qu+/vJOEa4+CD0EjCywhuXhfSQpJNBBNTpS
        wYOpBBbMrpG6A5Izq4a1mw8wSK3HFUZe+IzDw8668ewe6oNTB8C09n6+jGsDNftW5XJWV7
        zNBpBw2MRoOuwbuIhUugsweMMhbkKJFBfYjVpcR4s0tlYzAJveiQptLr/j2SguB/3XWoPE
        mTd6+4YD94TTRoVTigXnEQVGP/EC6y25bz9BRs+l7Cck584Ezmx/crlE2pyFeXzDcERWGe
        HRFGpAGlz1uEVaFg4TJYmSG3lFgpVCq76f3sUn9AoYObsrTcP9ZurIB53blBRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690836527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RI0CJ7D+9SiL2iee0tYtf2iNXcHIA4WEuqt5DO0U+u4=;
        b=t3lJZ98F788Ee1TSBQzrtJlVNyh8UlwaGfZ1OY5jmlFSS9svCnvR9B8Vw0qzcS15OB3kqR
        gP47h2kx/N+UftAw==
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
In-Reply-To: <BYAPR21MB16885EA9B2A7F382D2F9C5A2D705A@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230728105650.565799744@linutronix.de>
 <20230728120930.839913695@linutronix.de>
 <BYAPR21MB16889FD224344B1B28BE22A1D705A@BYAPR21MB1688.namprd21.prod.outlook.com>
 <871qgop8dc.ffs@tglx>
 <20230731132714.GH29590@hirez.programming.kicks-ass.net>
 <87sf94nlaq.ffs@tglx>
 <BYAPR21MB16885EA9B2A7F382D2F9C5A2D705A@BYAPR21MB1688.namprd21.prod.outlook.com>
Date:   Mon, 31 Jul 2023 22:48:46 +0200
Message-ID: <87fs53n6xd.ffs@tglx>
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

On Mon, Jul 31 2023 at 16:10, Michael Kelley wrote:
> From: Thomas Gleixner <tglx@linutronix.de> Sent: Monday, July 31, 2023 8:38 AM
> The VM is an F72s_v2 in Azure running your patch set.  The VM has
> 72 vCPUs in two NUMA nodes across two physical Intel processors, with
> 36 vCPUs in each NUMA node.
>
> The output is from /sys/kernel/debug/x86/topo/cpus, so the initial_apicid
> is from CPUID, while the apicid is from read_apic_id() and matches the
> MADT.  As expected, the two values match for the first 36 vCPUs, but differ
> by 28 (decimal) for the remaining 36.
>
> initial_apicid:      0 apicid:              0
...
> initial_apicid:      23 apicid:              23

> initial_apicid:      40 apicid:              24
...
> initial_apicid:      63 apicid:              47

Is there any indication in some other CPUID leaf which lets us deduce this
wreckage?

I don't think the hypervisor space (0x40000xx) has anything helpful, but
staring at the architectural ones provided by hyper-V to the guest might
give us an hint. Can you provide a cpuid dump for the boot CPU please?

Thanks,

        tglx


