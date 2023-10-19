Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E01037CF76D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 13:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbjJSLu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 07:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232977AbjJSLu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 07:50:56 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34C8BE
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 04:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1697716249;
        bh=QVNmT0LMj8mt5yv4FZ1LFFQtgL5o7wdHisErTaVs4hE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Rmar2YgEngG8pbe1XRhd/jpc3FiE/6WmFa6NDuRcLlK6yAxHuJMH6qD9lDSfW+6az
         3wWovzJWSHUNxe5sHAgGmOT7F7cZuePWOnfokLxsY1ulLzAzVBPjEFMECw4Gr0ETwZ
         1YZ+aboGXQFo+H+gnshFjMoIqfZvlNiezc8WFyFrDnHNlkNlhBb2OoPS7AfRacnTkC
         EDBqTflVoGwLTRmbNUZvlk7eA3PX/PAuTHG5Ke4fwRxANfX/nr2KMKjmbQZSbvLstA
         w7axDAUvC56hYILjiXhau9N65HeHs/V7qlBFnwopA+nPzAWUB9wgnYbKg9wfy07EcJ
         Ao+1wEY0JMulw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SB5dM5p59z4xZm;
        Thu, 19 Oct 2023 22:50:47 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>,
        Rohan McLure <rmclure@linux.ibm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] powerpc/smp: Enable Asym packing for cores on
 shared processor
In-Reply-To: <20231019074828.GM33217@noisy.programming.kicks-ass.net>
References: <20231018163751.2423181-1-srikar@linux.vnet.ibm.com>
 <20231018163751.2423181-3-srikar@linux.vnet.ibm.com>
 <87v8b35ir3.fsf@mail.lhotse>
 <20231019074828.GM33217@noisy.programming.kicks-ass.net>
Date:   Thu, 19 Oct 2023 22:50:43 +1100
Message-ID: <87h6mm6dbg.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:
> On Thu, Oct 19, 2023 at 03:38:40PM +1100, Michael Ellerman wrote:
>> Srikar Dronamraju <srikar@linux.vnet.ibm.com> writes:
>> > If there are shared processor LPARs, underlying Hypervisor can have more
>> > virtual cores to handle than actual physical cores.
>> >
>> > Starting with Power 9, a core has 2 nearly independent thread groups.
>> 
>> You need to be clearer here that you're talking about "big cores", not
>> SMT4 cores as seen on bare metal systems.
>
> What is a 'big core' ? I'm thinking big.LITTLE, but I didn't think Power
> went that route (yet?).. help?

No it's not big.LITTLE :)

It means we have two SMT4 cores glued together that behave as a single
SMT8 core, a system is either in "big core" mode or it's not, it's never
heterogeneous.

If you grep for "big_core" there's some code in the kernel for dealing
with it, though it's probably not very illuminating.

Possibly we should switch to using the "thread group" terminology, so
that it doesn't confuse folks about big.LITTLE. Also the device tree
property that we use to discover if we're using big cores is called
ibm,thread-groups.

cheers
