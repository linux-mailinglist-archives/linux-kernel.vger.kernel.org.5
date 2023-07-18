Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6202E75853B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 20:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjGRS7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 14:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGRS7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 14:59:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC68F0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 11:59:49 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689706787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VUSxXGcmIRjp/7eWv7Dj7xeIv9NgHXqog6LPPMoYxtU=;
        b=clpyVgzmkV7giIEgPu8+ARXPYuSvSWy8D3SLs0n7co/mCr/PEA9mH8GdvvmyPzMuVpzYUA
        diia7e8G8PcZpQN1pB+vA2yBd6SLqIsBRkA6E7ZpbsFyN4P97Ih6SCkQ7erkHKxbjDCGoi
        63A7Kmet0wzgToeSCtJ6MYQAY87PWYxCXCBOH5dcRttnm8+LP1EfN27zJH4X6jcb4Ymajj
        VcX+P8lU7HCk3UqU2l5u/TQL3l5hgTdOw0aMFnHODlmQUTHxhkvuqvGIi+1K3qj9VuMZgz
        IFWMnXbDClTASI3AYibYChLgQ1Nzpeiz7xrFxlDA8t925Dr/hGEDYd30FgYCNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689706787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VUSxXGcmIRjp/7eWv7Dj7xeIv9NgHXqog6LPPMoYxtU=;
        b=E9cps3qvyuYpKiTnDVYN2Wz3RdvXfrYxO1Q/DDpASIohXHmzMP7UhyL/cAaoBxkpmtCfjd
        ycjIQTGg2So9uoAw==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>
Subject: Re: [patch 41/58] x86/apic: Add max_apic_id member
In-Reply-To: <CAHk-=wjkmwJB4puU7dn0eTABXGa7WdX=JZFZjqxOEkiA3f+aGQ@mail.gmail.com>
References: <20230717223049.327865981@linutronix.de>
 <20230717223225.515238528@linutronix.de>
 <CAHk-=wh9sDpbCPCekRr-fgWYz=9xa0_BOkEa+5vOr9Co-fNhrQ@mail.gmail.com>
 <87h6q1y82v.ffs@tglx>
 <CAHk-=wjkmwJB4puU7dn0eTABXGa7WdX=JZFZjqxOEkiA3f+aGQ@mail.gmail.com>
Date:   Tue, 18 Jul 2023 20:59:46 +0200
Message-ID: <87351lxcyl.ffs@tglx>
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

On Tue, Jul 18 2023 at 09:06, Linus Torvalds wrote:
> On Tue, 18 Jul 2023 at 00:47, Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> The confusing part here is the physical APIC ID vs. the destination
>> mode.
>
> Actually, no, what confused me here ended up being that I didn't see
> any other limit checking at all for the flat mode, and then I was
> "this cannot possibly work up to that limit".
>
> But it turns out that the limit checking appears to be in the
> "physflat" case, not in the simple flat case.
>
> IOW, the physflat probe function says "I'll take it" whenever
> num_possible_cpus() > 8", and that seems to be what then limits the
> flat mode to a max of 8 cpus. So the limit was just in another place
> than I expected.

Right. And obviously you managed to confuse me too :)
