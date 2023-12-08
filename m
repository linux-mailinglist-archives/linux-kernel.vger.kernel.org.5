Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1016480A105
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 11:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573700AbjLHKcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 05:32:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235903AbjLHKbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 05:31:47 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75722325B
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 02:31:19 -0800 (PST)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1702031474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qKILzRTd25bfCjTNlwp7pDmuYeLxqzS8V4H69hHqUNQ=;
        b=axBkgfgzmdIk6Uu/T+DeFOn4DAZvck9+YHB+Ch7CwtGxFhYlzn+vXmPjxdxb9aZkFPGDFt
        n8rCVkaTpPSCCz/0DOKpYE6G1kK0+FYCEYX6fgOgD7SgyGzW2au8oNyw5otbzpelor+3B/
        jUs0qejV+tDPmxGbYRcGF3Cr9cvfYsXa1G/TXJZ/dBxDD7hJ3+xtwO1RWi5MsuCLKtrRZF
        YTRLcYZBpPImAmFTeIAof2QCkwTl+Iihe/i8TYtMo1H24OkytjMbQTmrfARD8rCh4uIAaB
        mWQL6TQRqKKCgRjCHI/TA6zni8TnuwM8HbO86D3clt1byngdeUupX4CqWuLgqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1702031474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qKILzRTd25bfCjTNlwp7pDmuYeLxqzS8V4H69hHqUNQ=;
        b=9qQo5uqCEin3poQQUOs72IDiDx4T/0Q/FIGvx0qU1wtTukf/McQnnMGG5xPBrJNgAL99k0
        9UJ9jyFToQ8MwyCA==
To:     Sebastian Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH v9 30/32] timers: Implement the hierarchical pull model
In-Reply-To: <20231207180928.FZB319OJ@linutronix.de>
References: <20231201092654.34614-1-anna-maria@linutronix.de>
 <20231201092654.34614-31-anna-maria@linutronix.de>
 <20231207180928.FZB319OJ@linutronix.de>
Date:   Fri, 08 Dec 2023 11:31:13 +0100
Message-ID: <875y19ouj2.fsf@somnus>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sebastian Siewior <bigeasy@linutronix.de> writes:

> On 2023-12-01 10:26:52 [+0100], Anna-Maria Behnsen wrote:
>> diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration=
.c
>> new file mode 100644
>> index 000000000000..05cd8f1bc45d
>> --- /dev/null
>> +++ b/kernel/time/timer_migration.c
>> @@ -0,0 +1,1636 @@
> =E2=80=A6
>> + * Protection of the tmigr group state information:
>> + * ------------------------------------------------
>> + *
>> + * The state information with the list of active children and migrator =
needs to
>> + * be protected by a sequence counter. It prevents a race when updates =
in a
>
> s/a$//
>
>> + * child groups are propagated in changed order. The following scenario
>> + * describes what happens without updating the sequence counter:
>> + *
>> + * Therefore, let's take three groups and four CPUs (CPU2 and CPU3 as w=
ell
>> + * as GRP0:1 will not change during the scenario):
>> + *
>> + *    LVL 1            [GRP1:0]
>> + *                     migrator =3D GRP0:1
>> + *                     active   =3D GRP0:0, GRP0:1
>> + *                   /                \
>> + *    LVL 0  [GRP0:0]                  [GRP0:1]
>> + *           migrator =3D CPU0           migrator =3D CPU2
>> + *           active   =3D CPU0           active   =3D CPU2
>> + *              /         \                /         \
>> + *    CPUs     0           1              2           3
>> + *             active      idle           active      idle
>> + *
>> + *
>> + * 1. CPU0 goes idle (changes are updated in GRP0:0; afterwards the cur=
rent
>> + *    states of GRP0:0 and GRP1:0 are stored in the data for walking the
>> + *    hierarchy):
>
>    CPU0 goes idle. The state update is performed lock less and group
>    wise. In the first step only GRP0:0 has been updated. The update of
>    GRP1:0 is pending, the CPU walks through the hierarchy.
>
>> + *
>> + *    LVL 1            [GRP1:0]
>> + *                     migrator =3D GRP0:1
>> + *                     active   =3D GRP0:0, GRP0:1
>> + *                   /                \
>> + *    LVL 0  [GRP0:0]                  [GRP0:1]
>> + *       --> migrator =3D TMIGR_NONE     migrator =3D CPU2
>> + *       --> active   =3D                active   =3D CPU2
>> + *              /         \                /         \
>> + *    CPUs     0           1              2           3
>> + *         --> idle        idle           active      idle
>
>> + * 2. CPU1 comes out of idle (changes are update in GRP0:0; afterwards =
the
>> + *    current states of GRP0:0 and GRP1:0 are stored in the data for wa=
lking the
>> + *    hierarchy):
>
>    While CPU0 goes idle and continues to update the state, CPU1 comes
>    out of idle. CPU1 updates GRP0:0. The update for GRP1:0 is pending,
>    tge CPU walks through the hierarchy. Both CPUs now walk the hierarchy
>    to perform the needed update from their point of view.
>    The currently visible state:
>
>> + *
>> + *    LVL 1            [GRP1:0]
>> + *                     migrator =3D GRP0:1
>> + *                     active   =3D GRP0:0, GRP0:1
>> + *                   /                \
>> + *    LVL 0  [GRP0:0]                  [GRP0:1]
>> + *       --> migrator =3D CPU1           migrator =3D CPU2
>> + *       --> active   =3D CPU1           active   =3D CPU2
>> + *              /         \                /         \
>> + *    CPUs     0           1              2           3
>> + *             idle    --> active         active      idle
>> + *
>> + * 3. Here comes the change of the order: Propagating the changes of st=
ep 2
>> + *    through the hierarchy to GRP1:0 - nothing to be done, because GRP=
0:0
>> + *    is already up to date.
>
>     Here is the race condition: CPU1 managed to propagate its changes
>     through the hierarchy to GRP1:0 before CPU0 did. The active members
>     of GRP1:0 remain unchanged after the update since it is still valid
>     from CPU1 current point of view:
>
>          LVL 1            [GRP1:0]
>                       --> migrator =3D GRP0:1
>                       --> active   =3D GRP0:0, GRP0:1
>                         /                \
>          LVL 0  [GRP0:0]                  [GRP0:1]
>                 migrator =3D CPU1           migrator =3D CPU2
>                 active   =3D CPU1           active   =3D CPU2
>                    /         \                /         \
>          CPUs     0           1              2           3
>                   idle        active         active      idle
>
> [ I take it as the migrator remains set to GRP0:1 by CPU1 but it could
>   be changed to GRP0:0. I assume that both fields (migrator+active) are
>   changed there via the propagation and the arrow in both fields denotes
>   this. ]
>
>> + * 4. Propagating the changes of step 1 through the hierarchy to GRP1:0
>
>      Now CPU0 finally propagates its changes to GRP1:0.
>
>> + *
>> + *    LVL 1            [GRP1:0]
>> + *                 --> migrator =3D GRP0:1
>> + *                 --> active   =3D GRP0:1
>> + *                   /                \
>> + *    LVL 0  [GRP0:0]                  [GRP0:1]
>> + *           migrator =3D CPU1           migrator =3D CPU2
>> + *           active   =3D CPU1           active   =3D CPU2
>> + *              /         \                /         \
>> + *    CPUs     0           1              2           3
>> + *             idle        active         active      idle
>> + *
>> + * Now there is a inconsistent overall state because GRP0:0 is active, =
but
>> + * it is marked as idle in the GRP1:0. This is prevented by incrementing
>> + * sequence counter whenever changing the state.
>
>    The race of CPU0 vs CPU1 led to an inconsistent state in GRP1:0.
>    CPU1 is active and is correctly listed as active in GRP0:0. However
>    GRP1:0 does not have GRP0:0 listed as active which is wrong.
>    The sequence counter has been added to avoid inconsistent states
>    during updates. The state is updated atomically only if all members,
>    including the sequence counter, match the expected value
>    (compare-and-exchange).
>    Looking back at the previous example with the addition of the
>    sequence number: The update as performed by CPU0 in step 4 will fail.
>    CPU1 changed the sequence number during the update in step 3 so the
>    expected old value (as seen by CPU0 before starting the walk) does
>    not match.
>

Thanks a lot for rephrasing the documentation to make it clearer for the
reader! I use your proposal with some minor changes.

Thanks,

	Anna-Maria

