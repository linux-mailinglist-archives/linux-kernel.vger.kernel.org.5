Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A758275A893
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 10:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjGTID1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 04:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjGTIDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 04:03:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8B22111
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 01:03:23 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689840201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7PdFSlTwZ92Iu5k4zEnx3qqOg4qIJ3r9ex8fDWUMyQs=;
        b=0cQT47GzdUVme/i2+7thYh3x4MMiijFZotMrqpPhvAycv90bqdewOt2F0N7+Zn5jzZdSua
        IXB2wUJfwxCO0bcdbiZeaRQ7ZaTCEwqDDJENOE5h8hSKRnJEOa0mDa1Npw3o6ZepNgdxjW
        Cff1F2iQjjknPeFFrhumcjhyZ9Ej02dmjjJ2XZ7J7n4Bcd/5VoWhWIWeN9evr5xHjkW8tU
        vfwBO4jBzpgqQbLfHe4VW3QHOo0lBwu6Nagc2wNsgoEwjKS5NO+mWA4ZyoACCyCtzcNWkC
        /dBfZM80B9ZIE7nfWQbvaERAY1Kwgoj9nlmDkSV51TT7RZoT5OAw5xGBI8tPMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689840201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7PdFSlTwZ92Iu5k4zEnx3qqOg4qIJ3r9ex8fDWUMyQs=;
        b=7DV908KZMFJFpWqwq8Jh2x8+pq0b/LPLwpqWiUMCa2fiuanFPgaDFmduqMhnONMnSRf7tC
        TdFzQOEcaLKB8pCg==
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>
Subject: RE: [patch 19/58] x86/apic: Get rid of apic_phys
In-Reply-To: <BYAPR21MB1688E1BDE9B6D1225E590FF1D73EA@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230717223049.327865981@linutronix.de>
 <20230717223224.207131427@linutronix.de> <87edl5xt2n.ffs@tglx>
 <BYAPR21MB1688E1BDE9B6D1225E590FF1D73EA@BYAPR21MB1688.namprd21.prod.outlook.com>
Date:   Thu, 20 Jul 2023 10:03:20 +0200
Message-ID: <874jlz3t87.ffs@tglx>
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

On Thu, Jul 20 2023 at 04:18, Michael Kelley wrote:

> From: Thomas Gleixner <tglx@linutronix.de> Sent: Tuesday, July 18, 2023 6:12 AM
>> 
>> On Tue, Jul 18 2023 at 01:15, Thomas Gleixner wrote:
>> > @@ -1921,7 +1922,6 @@ static __init void try_to_enable_x2apic(
>> >  		 * be addressed must not be brought online.
>> >  		 */
>> >  		x2apic_set_max_apicid(apic_limit);
>> > -		x2apic_phys = 1;

^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ This hunk _IS_ wrong and needs to be
reverted obvioulsy.

>> >  	}
>> >  	x2apic_enable();
>> >  }
>> 
>> This hunk is obviously bogus. I just noticed on a VM which takes this
>> code path...
>
> I'm testing guests on Hyper-V.  The case where the x2apic is enabled
> in the BIOS works, but when the x2apic must be enabled by Linux,
> the VMbus drivers never get initialized and things go downhill from
> there. Your comment above is somewhat cryptic (as I haven't studied
> the patches in detail), but I'm guessing it explains the failure I'm seeing.
>
> Let me know if I should debug the failure I'm seeing.  Otherwise
> I'll wait for a new version and try again.

Can you add that line back and retest?

Thanks,

        tglx
