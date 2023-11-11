Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51FEA7E8AC5
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 12:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbjKKLzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 06:55:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjKKLzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 06:55:48 -0500
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BF13AA0;
        Sat, 11 Nov 2023 03:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1699703746; x=1731239746;
  h=mime-version:content-transfer-encoding:date:message-id:
   cc:from:to:references:in-reply-to:subject;
  bh=8QfYUSwPRb1Vx5K77xkRZVNfj9+EchNyz1L4WfQsarE=;
  b=EvdDsWayNVOJYFiLOqVbdLfSYSNwt1GrDCGklL3scLkQ1XUDPcwGrYRx
   gjqV+uyPd13v691YaJmkNPnDNgXX6VCEuxH30bUF3Gf1R0jPcrqpDPI3a
   ZGN6e95i3u8DoSXwhcSshLDfa8kuMQG1y2T3hvDa3uTB/9zmsO6SF7ctt
   c=;
X-IronPort-AV: E=Sophos;i="6.03,294,1694736000"; 
   d="scan'208";a="375772209"
Subject: Re: [RFC 0/33] KVM: x86: hyperv: Introduce VSM support
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-0aba4706.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2023 11:55:39 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
        by email-inbound-relay-iad-1e-m6i4x-0aba4706.us-east-1.amazon.com (Postfix) with ESMTPS id 1972BA29A7;
        Sat, 11 Nov 2023 11:55:35 +0000 (UTC)
Received: from EX19MTAEUA002.ant.amazon.com [10.0.10.100:13808]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.4.34:2525] with esmtp (Farcaster)
 id a5333eee-42a3-434f-9f21-1880518faf06; Sat, 11 Nov 2023 11:55:33 +0000 (UTC)
X-Farcaster-Flow-ID: a5333eee-42a3-434f-9f21-1880518faf06
Received: from EX19D004EUC001.ant.amazon.com (10.252.51.190) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Sat, 11 Nov 2023 11:55:33 +0000
Received: from localhost (10.13.235.138) by EX19D004EUC001.ant.amazon.com
 (10.252.51.190) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Sat, 11 Nov
 2023 11:55:28 +0000
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date:   Sat, 11 Nov 2023 11:55:25 +0000
Message-ID: <CWVYONW1SIQP.2B08EUESTOQHL@amazon.com>
CC:     <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hyperv@vger.kernel.org>, <pbonzini@redhat.com>,
        <vkuznets@redhat.com>, <anelkz@amazon.com>, <graf@amazon.com>,
        <dwmw@amazon.co.uk>, <jgowans@amazon.com>, <corbert@lwn.net>,
        <kys@microsoft.com>, <haiyangz@microsoft.com>,
        <decui@microsoft.com>, <x86@kernel.org>,
        <linux-doc@vger.kernel.org>
From:   Nicolas Saenz Julienne <nsaenz@amazon.com>
To:     Sean Christopherson <seanjc@google.com>
X-Mailer: aerc 0.15.2-182-g389d89a9362e-dirty
References: <20231108111806.92604-1-nsaenz@amazon.com>
 <ZUu9lwJHasi2vKGg@google.com> <ZUvUZytj1AabvvrB@google.com>
 <CWVBQQ6GVQVG.2FKWLPBUF77UT@amazon.com> <ZU6FOF0qUAv8b1zm@google.com>
In-Reply-To: <ZU6FOF0qUAv8b1zm@google.com>
X-Originating-IP: [10.13.235.138]
X-ClientProxiedBy: EX19D041UWA003.ant.amazon.com (10.13.139.105) To
 EX19D004EUC001.ant.amazon.com (10.252.51.190)
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Nov 10, 2023 at 7:32 PM UTC, Sean Christopherson wrote:
> On Fri, Nov 10, 2023, Nicolas Saenz Julienne wrote:
> > On Wed Nov 8, 2023 at 6:33 PM UTC, Sean Christopherson wrote:
> > >  - What is the split between userspace and KVM?  How did you arrive a=
t that split?
> >
> > Our original design, which we discussed in the KVM forum 2023 [1] and i=
s
> > public [2], implemented most of VSM in-kernel. Notably we introduced VT=
L
> > awareness in struct kvm_vcpu.
>
> ...
>
> > So we decided to move all this complexity outside of struct kvm_vcpu
> > and, as much as possible, out of the kernel. We figures out the basic
> > kernel building blocks that are absolutely necessary, and let user-spac=
e
> > deal with the rest.
>
> Sorry, I should have been more clear.  What's the split in terms of respo=
nsibilities,
> i.e. what will KVM's ABI look like?  E.g. if the vCPU=3D>VTLs setup is no=
nsensical,
> does KVM care?
>
> My general preference is for KVM to be as permissive as possible, i.e. le=
t
> userspace do whatever it wants so long as it doesn't place undue burden o=
n KVM.
> But at the same time I don't to end up in a similar boat as many of the p=
aravirt
> features, where things just stop working if userspace or the guest makes =
a goof.

I'll make sure to formalize this for whenever I post a full series, I
need to go over every hcall and think from that perspective.

There are some rules it might make sense to enforce. But it really
depends on the abstractions we settle on. KVM might not have the
necessary introspection to enforce them. IMO ideally it wouldn't, VTLs
should remain a user-space concept. My approach so far has been trusting
QEMU is doing the right thing.

Some high level examples come to mind:
 - Only one VTL vCPU might run at all times.
 - Privileged VTL interrupts have precedence over lower VTL execution.
 - lAPICs can only access their VTL. (Cross VTL IPIs happen through the
   PV interface).
 - Lower VTL state should be up to date when accessed from privileged
   VTLs (through the GET/SET_VP_REGSITER hcall).

> > >  - Why not make VTLs a first-party concept in KVM?  E.g. rather than =
bury info
> > >    in a VTL device and APIC ID groups, why not modify "struct kvm" to=
 support
> > >    replicating state that needs to be tracked per-VTL?  Because of ho=
w memory
> > >    attributes affect hugepages, duplicating *memslots* might actually=
 be easier
> > >    than teaching memslots to be VTL-aware.
> >
> > I do agree that we need to introduce some level VTL awareness into
> > memslots. There's the hugepages issues you pointed out. But it'll be
> > also necessary once we look at how to implement overlay pages that are
> > per-VTL. (A topic I didn't mention in the series as I though I had
> > managed to solve memory protections while avoiding the need for multipl=
e
> > slots). What I have in mind is introducing a memory slot address space
> > per-VTL, similar to how we do things with SMM.
>
> Noooooooo (I hate memslot address spaces :-) )
>
> Why not represent each VTL with a separate "struct kvm" instance?  That w=
ould
> naturally provide per-VTL behavior for:
>
>   - APIC groups
>   - memslot overlays
>   - memory attributes (and their impact on hugepages)
>   - MMU pages

Very interesting idea! I'll spend some time researching it, it sure
solves a lot of issues.

> The only (obvious) issue with that approach would be cross-VTL operations=
.  IIUC,
> sending IPIs across VTLs isn't allowed, but even if it were, that should =
be easy
> enough to solve, e.g. KVM already supports posting interrupts from non-KV=
M sources.

Correct. Only through kvm_hv_send_ipi(), but from experience it happens
very rarely, so performance shouldn't be critical.

> GVA=3D>GPA translation would be trickier, but that patch suggests you wan=
t to handle
> that in userspace anyways.  And if translation is a rare/slow path, maybe=
 it could
> simply be punted to userspace?
>
>   NOTE: The hypercall implementation is incomplete and only shared for
>   completion. Additionally we'd like to move the VTL aware parts to
>   user-space.
>
> Ewww, and looking at what it would take to support cross-VM translations =
shows
> another problem with using vCPUs to model VTLs.  Nothing prevents userspa=
ce from
> running a virtual CPU at multiple VTLs concurrently, which means that any=
thing
> that uses kvm_hv_get_vtl_vcpu() is unsafe, e.g. walk_mmu->gva_to_gpa() co=
uld be
> modified while kvm_hv_xlate_va_walk() is running.
>
> I suppose that's not too hard to solve, e.g. mutex_trylock() and bail if =
something
> holds the other kvm_vcpu/VTL's mutex.  Though ideally, KVM would punt all=
 cross-VTL
> operations to userspace.  :-)
>
> If punting to userspace isn't feasible, using a struct kvm per VTL probab=
ly wouldn't
> make the locking and concurrency problems meaningfully easier or harder t=
o solve.
> E.g. KVM could require VTLs, i.e. "struct kvm" instances that are part of=
 a single
> virtual machine, to belong to the same process.  That'd avoid headaches w=
ith
> mm_struct, at which point I don't _think_ getting and using a kvm_vcpu fr=
om a
> different kvm would need special handling?

I'll look into it.

> Heh, another fun one, the VTL handling in kvm_hv_send_ipi() is wildly bro=
ken, the
> in_vtl field is consumed before send_ipi is read from userspace.

ugh, that's a tired last minute "cleanup" that went south... It's been
working as intended for a while otherwise. I'll implement a
kvm-unit-test to redeem myself. :)

Nicolas
