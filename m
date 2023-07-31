Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA6A76966D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 14:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232730AbjGaMep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 08:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjGaMen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 08:34:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1123139;
        Mon, 31 Jul 2023 05:34:41 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690806879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=26bNPteWLKWX+IXb6CXn0F6iXGIdt9GmgAnDVbyNoUc=;
        b=uDXkw2Ay5rxDMiOgBXNnZOMctMLa1CZfO0YQ8FiSGypGhqCA3YfCB8QO2bcWKTBHwXPon1
        4SG2jZnu7h2E7IgvCIIkNvArtILo3wCcp3CKPy5vKXHlEu9kl9xoiEgt2/OZrSk5zQt9qK
        hhyYL1L7z2rvJwtBDzahacKFKUkKRQhzoI1+IG3DQTmICoVIKPsVfm8lRHhcYiLm/X/Yck
        xPrqyPUakMrE+ZKueCEgPUEM1omfO9aN/m3xm7S88c+ATcmuN5rTFRnaSriVrj6PapaEe7
        2T704/PZ4VFKJNeIGkqSvC/L8Han350umiQssr78hOhSnZRAm3MGYcH6f02J6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690806879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=26bNPteWLKWX+IXb6CXn0F6iXGIdt9GmgAnDVbyNoUc=;
        b=1w9HP+LRa/uXwBirEj5ZNjtThhek9E5qaTN8T6DYClnfLEm8+4TGDNsMvPGktEuJjF8s8B
        56/kKbxH3Nbb1oCQ==
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     "x86@kernel.org" <x86@kernel.org>,
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
In-Reply-To: <BYAPR21MB16889FD224344B1B28BE22A1D705A@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230728105650.565799744@linutronix.de>
 <20230728120930.839913695@linutronix.de>
 <BYAPR21MB16889FD224344B1B28BE22A1D705A@BYAPR21MB1688.namprd21.prod.outlook.com>
Date:   Mon, 31 Jul 2023 14:34:39 +0200
Message-ID: <871qgop8dc.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31 2023 at 04:05, Michael Kelley wrote:
>> +	/*
>> +	 * The initial invocation from early_identify_cpu() happens before
>> +	 * the APIC is mapped or X2APIC enabled. For establishing the
>> +	 * topology, that's not required. Use the initial APIC ID.
>> +	 */
>> +	if (early)
>> +		c->topo.apicid =3D c->topo.initial_apicid;
>> +	else
>> +		c->topo.apicid =3D read_apic_id();
>
> Using the value from the local APIC ID reg turns out to cause a problem in
> some Hyper-V VM configurations.  If a VM has multiple L3 caches (probably
> due to multiple NUMA nodes) and the # of CPUs in the span of the L3 cache
> is not a power of 2, the APIC IDs for the CPUs in the span of the 1st L3 =
cache
> are sequential starting with 0.  But then there is a gap before starting =
the
> APIC IDs for the CPUs in the span of the 2nd L3 cache.  The gap is
> repeated if there are additional L3 caches.
>
> The CPUID instruction executed on a guest vCPU correctly reports the APIC
> IDs.  However, the ACPI MADT assigns the APIC IDs sequentially with no
> gaps, and the guest firmware sets the APIC_ID register for each local APIC
> to match the MADT.  When parse_topology() sets the apicid field based on
> reading the local APIC ID register, the value it sets is different from t=
he
> initial_apicid value for CPUs in the span of the 2nd and subsequent L3
> caches, because there's no gap in the APIC IDs read from the local APIC.
> Linux boots and runs, but the topology is set up with the wrong span for
> the L3 cache and for the associated scheduling domains.

TBH. That's an insanity. MADT and the actual APIC ID determine the
topology. So the gaps should be reflected in MADT and the actual APIC
IDs should be set correctly if the intent is to provide topology
information.

Just for the record. This hack works only on Intel today, because AMD
init sets topo.apicid =3D read_apic_id() unconditionally. So this is
inconsistent already, no?

> The old code derives the apicid from the initial_apicid via the
> phys_pkg_id() callback, so these bad Hyper-V VM configs skate by.  The
> wrong value in the local APIC ID register and MADT does not affect
> anything, except that the check in validate_apic_and_package_id() fails
> during boot, and a set of "Firmware bug:" messages is correctly
> output.

So instead of fixing the firmware bugs, hyper-v just moves on and
pretends that everything works fine, right?

> Three thoughts:
>
> 1)  Are Hyper-V VMs the only place where the local APIC ID register might
> have a bogus value?  Probably so, but you never know what might crawl
> out.

Define bogus. MADT is the primary source of information because that's
how we know how many CPUs (APICs) are there and what their APIC ID is
which we can use to wake them up. So there is a reasonable expectation
that this information is consistent with the rest of the system.

The Intel SDM clearly says in Vol 3A section 9.4.5 Identifying Logical
Processors in an MP System:

  "After the BIOS has completed the MP initialization protocol, each
   logical processor can be uniquely identified by its local APIC
   ID. Software can access these APIC IDs in either of the following
   ways:"

These ways include read from APIC, read MADT, read CPUID and implies
that this must be consistent. For X2APIC it's actually written out:

  "If the local APIC unit supports x2APIC and is operating in x2APIC
   mode, 32-bit APIC ID can be read by executing a RDMSR instruction to
   read the processor=E2=80=99s x2APIC ID register. This method is equivale=
nt to
   executing CPUID leaf 0BH described below."

AMD has not been following that in the early 64bit systems as they moved
the APIC ID space to start at 32 for the first CPU in the first socket
for whatever reasons. But since then the kernel reads back the APIC ID
on AMD systems into topo.apicid. But that was long ago and can easily be
dealt with because at least the real APIC ID and the MADT/MPTABLE
entries are consistent.

Hypervisors have their own CPUID space to override functionality with
their own magic stuff, but imposing their nutbolt ideas on the
architectural part of the system is not only wrong, it's disrespectful
against the OS developers who try to keep their system sane.

> 2) The natural response is "Well, fix Hyper-V!"  I first had this convers=
ation
> with the Hyper-V team about 5 years ago.  Some cases of the problem were
> fixed, but some cases remain unfixed.  It's a long story.
>
> 3)  Since Hyper-V code in Linux already has an override for the apic->rea=
d()
> function, it's possible to do a hack in that override so that apicid gets=
 set to
> the same value as initial_apicid, which matches the old code.  Here's the=
 diff:

This collides massively with the other work I'm doing, which uses the
MADT provided information to actually evaluate various topology related
things upfront and later during bringup. Thats badly needed because lots
of todays infrastructure is based on heuristics and guesswork.

But it seems I wasted a month on reworking all of this just to be
stopped cold in the tracks by completely undocumented and unnecessary
hyper-v abuse.

So if Hyper-V insists on abusing the initial APIC ID as read from CPUID
for topology information related to L3, then hyper-v should override the
cache topology mechanism and not impose this insanity on the basic
topology evaluation infrastructure.

Yours seriously grumpy

      tglx
