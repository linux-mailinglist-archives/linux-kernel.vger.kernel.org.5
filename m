Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22EB7575A8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 09:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbjGRHrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 03:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbjGRHrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 03:47:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBB61700
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 00:47:39 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689666457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i0cnZNfXHqJ2QLQtFVDEv8W0I24maAtYhkEPWKK8Tnw=;
        b=nIdkZEhQaQSH9v+5zIfpXUGuQtvQlqB8uCZ8GClCgmhNqJ97stYwS+wN/VhVIfVNUw/yCa
        Kd9cW6NJWL/CcoAjNUWqOyfmAX1qaerGlhowz2P0nrXVZwKUuiYIOTrUJnuKa9WMJV0k4G
        Itf4bFIqBLRuQg9GhpKvCY+Ox7K7XECz0vq8jVWlbppJaHoKptqK1oaZBOT26/O+iUL1bL
        FAECJv5GPq3h2LdvK4u5qZnKfUgozc6VtVBvbfkY9XOhG2abUeG9pviylidST8QSW735nj
        e4K4kcTggY5iU1ufJ1HY7MltG4UkEjOJmED4OaIIXFiKigdmDmz7af/472muGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689666457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i0cnZNfXHqJ2QLQtFVDEv8W0I24maAtYhkEPWKK8Tnw=;
        b=psLYHn2/idg0KU7W0fPLY4uXxEn+i/Bk1QFKrJUcNHtuE5FOa9IKiwu+WB2kJwyflInp28
        GZIH7rQAlZVuSCBQ==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>
Subject: Re: [patch 41/58] x86/apic: Add max_apic_id member
In-Reply-To: <CAHk-=wh9sDpbCPCekRr-fgWYz=9xa0_BOkEa+5vOr9Co-fNhrQ@mail.gmail.com>
References: <20230717223049.327865981@linutronix.de>
 <20230717223225.515238528@linutronix.de>
 <CAHk-=wh9sDpbCPCekRr-fgWYz=9xa0_BOkEa+5vOr9Co-fNhrQ@mail.gmail.com>
Date:   Tue, 18 Jul 2023 09:47:36 +0200
Message-ID: <87h6q1y82v.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus!

On Mon, Jul 17 2023 at 17:19, Linus Torvalds wrote:
> So all of your patches make sense to me, but the whole apic_flat case
> confuses me.
>
> On Mon, 17 Jul 2023 at 16:15, Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> --- a/arch/x86/kernel/apic/apic_flat_64.c
>> +++ b/arch/x86/kernel/apic/apic_flat_64.c
>> @@ -94,6 +94,7 @@ static struct apic apic_flat __ro_after_
>>         .cpu_present_to_apicid          = default_cpu_present_to_apicid,
>>         .phys_pkg_id                    = flat_phys_pkg_id,
>>
>> +       .max_apic_id                    = 0xFE,
>>         .get_apic_id                    = flat_get_apic_id,
>>         .set_apic_id                    = set_apic_id,
>
> flat_send_IPI_mask() can only deal with a single word mask. How the
> heck can the max apic ID be more than 64?
>
> I'm probably very confused.

APIC is doing that to people.

The confusing part here is the physical APIC ID vs. the destination
mode.

Physical APIC ID is always a unique number per CPU (APIC) and on XAPIC
ranging from 0x0 to 0xFE. That's what is actually checked with that
max_apic_id entry.

Destination mode is a different story. APIC has two destination modes
for actually sending IPIs or messages from IO/APIC or PCI/MSI: Physical
and logical.

Logical is a bitmap of 8 bits, where each bit represents one CPU. So the
maximum number of CPUs addressable in logical mode is 8.

You can have a system with 8 CPUs where the physical APIC IDs are
0x20-0x27 and use logical destination mode by setting the LDR register
to the bit which represents the CPU, i.e. 1 << CPU#.

So in that 8 CPU case LDR is 0x1, 0x2, ... 0x80 on CPU0 - 7. When
sending an IPI then the destination mode in the ICR is set to logical
and the destination field is written with the bit representing the
target, i.e. 1 << CPU#. The destination field can have multiple bits set
to send the IPI to several CPUs (up to 8) with a single ICR write
operation.

Once the machine has more than 8 CPUs we are forced to use physical
destination mode. Physical destination mode is using the physical APIC
ID of the target: 0-254 are the valid addresses, which fit into one
byte. 255 (0xff) is a broadcast address. Sending IPIs to multiple
targets needs one ICR write per target, which is obviously more
expensive as between each write the ICR register has to be read back and
the ICR busy bit needs to go back to zero before the next ICR write can
happen.

X2APIC is similar. It just has a wider physical APIC ID space (full
32bit). X2APIC has a logical destination mode too which is more
useful. The logical destination is 32bit wide and split into two areas:

  [cluster ID] [logical ID]

Each being 16 bit wide. The logical ID is again one bit per CPU, the
cluster ID is a number. So we can send IPIs to multiple targets (up to
16) within a cluster with one ICR write. If the IPI targets are in
different clusters then obviously we need one write per cluster.

Physical destination mode on X2APIC is the same as with XAPIC but
cheaper as it does not need the ICR readback.

I'm sure you are now even more confused.

Thanks,

        tglx




