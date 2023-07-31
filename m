Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 083CE769AE6
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 17:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbjGaPi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 11:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjGaPiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 11:38:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139C6D8;
        Mon, 31 Jul 2023 08:38:24 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690817902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P/W5Li7dfE7r3qR09rk7c9rr3IsQpi7R9QAF8g++NHk=;
        b=yYiJqZTbXdrPsUWG9m/MOHB+7MN+qcpf1Z5ZJ3J4QdSqw4egwDi8R607O4CVgZPQN7LvBs
        RnvBWshVh2pUpWtZY2KPI8ENqct1TSYeb3hokZtCa2zJIYySf471xi8UoDd+6qnFyTwfNi
        QBIxYdXMgeF8rIPtwh9mDxvMg5LPgCHmgIkX4HdNyh5GfWlmcBN2L3dpnanqn46R0HH87X
        nAsYCbl8ws4nJPfhajlrgsFUtDXr4YEr2GU0GJg+hmg3F6eRNyr0JQ7LItK1L0zo8f6sY3
        sDCC67ws3bEe7Sc6Do2yk38WTrcROYGO1Ug9sA8Qp1Mt7PrtuN1A1JQM3GUcnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690817902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P/W5Li7dfE7r3qR09rk7c9rr3IsQpi7R9QAF8g++NHk=;
        b=gTg0tWfhltDprkXyKscpuMQXBP7cFCPJjtXqf5P4PPi1Zg+0kngwoQpw0b871Pq/GrEET5
        TbPQ9fXeHPwui8BQ==
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        LKML <linux-kernel@vger.kernel.org>,
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
Subject: Re: [patch v2 21/38] x86/cpu: Provide cpu_init/parse_topology()
In-Reply-To: <20230731132714.GH29590@hirez.programming.kicks-ass.net>
References: <20230728105650.565799744@linutronix.de>
 <20230728120930.839913695@linutronix.de>
 <BYAPR21MB16889FD224344B1B28BE22A1D705A@BYAPR21MB1688.namprd21.prod.outlook.com>
 <871qgop8dc.ffs@tglx>
 <20230731132714.GH29590@hirez.programming.kicks-ass.net>
Date:   Mon, 31 Jul 2023 17:38:21 +0200
Message-ID: <87sf94nlaq.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31 2023 at 15:27, Peter Zijlstra wrote:
> On Mon, Jul 31, 2023 at 02:34:39PM +0200, Thomas Gleixner wrote:
>> This collides massively with the other work I'm doing, which uses the
>> MADT provided information to actually evaluate various topology related
>> things upfront and later during bringup. Thats badly needed because lots
>> of todays infrastructure is based on heuristics and guesswork.
>> 
>> But it seems I wasted a month on reworking all of this just to be
>> stopped cold in the tracks by completely undocumented and unnecessary
>> hyper-v abuse.
>> 
>> So if Hyper-V insists on abusing the initial APIC ID as read from CPUID
>> for topology information related to L3, then hyper-v should override the
>> cache topology mechanism and not impose this insanity on the basic
>> topology evaluation infrastructure.
>
> So I'm very tempted to suggest you continue with the topology rewrite
> and let Hyper-V keep the pieces. They're very clearly violating the SDM.
>
> Thing as they stand are untenable, the whole topology thing as it exists
> today is an untenable shitshow.
>
> Michael, is there anything you can do early (as in MADT parse early) to
> fix up the APIC-IDs?

I don't think so.

Michael, can you please provide me a table of:

   APICID (real/MADT)		APICID (CPUID)

from one of the tinker VMs please?

Thanks,

        tglx
