Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00220764237
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 00:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbjGZWi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 18:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjGZWi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 18:38:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F02213E;
        Wed, 26 Jul 2023 15:38:26 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690411103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NmfT6/fQLhcDtQ7kZHIOof5oxpIbpLR7hSdf3CpmgP4=;
        b=e8BEyuBar6zz7yQ5GrDWPWH9QQL36kt5SgJnXHoFjm05ocwe4uLPoLorCM52MObUwJuQQh
        f59ylRkBqn/iLMiRS3Y5/gQ6pSnytW2ZmWvzyWEGNgvAlHvqwh1A8pPv/JoCobxfUuyP+0
        kOAGzL3GZFiN+tdmQEcTPPmYHnMXBcT24xv/QT2ApyZTOYIu6yd51pdesI6J3nMGrUh2gA
        578JNEJHv/flqafXv58ZL0dqxmD6Wp6B7s7vPrVDKf5DPq8RnTkNlIVJ5gmxaLAULpYD66
        fR2PEgF5oWqZovK80jLzCzlF3PsBN3wcAIpEjcyEJCYkgaaSUlkf3djV+ZUaDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690411103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NmfT6/fQLhcDtQ7kZHIOof5oxpIbpLR7hSdf3CpmgP4=;
        b=9Ax00ioiaN2yNs3Of+psAiJatpo4UgoTQlTgjjq5x/6l3Ik0W/XC4vcbhRb6lltRX1cVtp
        yWhjC9O/pNhUugAg==
To:     Sohil Mehta <sohil.mehta@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
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
Subject: Re: [patch 00/29] x86/cpu: Rework the topology evaluation
In-Reply-To: <545cff6e-09ad-afc3-5d5f-bf5a435885b9@intel.com>
References: <20230724155329.474037902@linutronix.de>
 <545cff6e-09ad-afc3-5d5f-bf5a435885b9@intel.com>
Date:   Thu, 27 Jul 2023 00:38:22 +0200
Message-ID: <87mszis3hd.ffs@tglx>
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

On Wed, Jul 26 2023 at 15:15, Sohil Mehta wrote:
> On 7/24/2023 10:43 AM, Thomas Gleixner wrote:
>> The series is based on the APIC cleanup series:
>> 
>>   https://lore.kernel.org/lkml/20230724131206.500814398@linutronix.de
>> 
>> and also available on top of that from git:
>> 
>>  git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git topo-cpuid-v1
>> 
>
> The series boots fine on an old Sandy Bridge 2S system. There is a print
> from topology_update_die_map() which is missing from dmesg but it seems
> mostly harmless.
>
>> [    0.085686] smpboot: x86: Booting SMP configuration:> [    0.085690] .... node  #0, CPUs:          #1   #2   #3   #4   #5
> #6   #7   #8   #9
>> [    0.089253] .... node  #1, CPUs:    #10  #11  #12  #13  #14  #15  #16  #17  #18  #19
>> [    0.000000] smpboot: CPU 10 Converting physical 0 to logical die 1
>
>  ^^ The "Converting physical..." line doesn't show up with the patches
> applied.

That message comes from the complete nonsense in the current upstream
code that cpuinfo::die_id is made relative to the package. That's just
wrong. My rework uses the physical die id which is unique by definition
and therefore does not need this conversion. The logical ID is the same
as the physical id in that case.

>> [    0.134035] .... node  #0, CPUs:    #20  #21  #22  #23  #24  #25  #26  #27  #28  #29
>> [    0.140239] .... node  #1, CPUs:    #30  #31  #32  #33  #34  #35  #36  #37  #38  #39
>
> Please let me know if you need more information.
>
> Tested-by: Sohil Mehta <sohil.mehta@intel.com>

There is a real and unrelated snafu vs. that logical package and logical
die management which I discovered today. I missed the fact that this
cruft abuses cpuinfo as permanent storage, which breaks CPU
offline/online as the online operation reinitializes the topology
information.

I pushed out a fixed version to

  git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git x86/topology

earlier. It doesn't have a tag yet.

Thanks,

        tglx

