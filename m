Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C1E808FA2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 19:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443645AbjLGSJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 13:09:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233088AbjLGSJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 13:09:27 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33CEF10F0
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 10:09:33 -0800 (PST)
Date:   Thu, 7 Dec 2023 19:09:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701972570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f07I5vkYcNbiJNcAFNGcoVH+whxOwsU4ggr1Z+Ad5Oo=;
        b=wx9J+x173SrfVWMNdaqT+ljIRdiLnnFsFD6yQR2Ekhy1Yt6UQT/Vbpl5LB4pA3bsdOlnk8
        +U4Pfl8xo32E3TlxTAQ3Pe5zH7oHLmsOcGyrRzS2hJ2dnkLlGCHX7Iv++jhdJp7lFYpHvb
        MkgSfZtr4QCj51IyWO33EkW7pLbP8b2wKguZ1uvKkL+ki1pPFMW1Ub5jRTiFjR0HzxvPil
        lVsiK2KvtkNALd0M04O+vUQgOabTTGPiutriGWM7RGuLSRTQwy05yw40BO9QbFeQALm+7L
        9lJkW0pRVJHg7XoMkls6Ms/0jtrP3IgZeJRFJaW4UZ6KAcHeFEIroKQCr0lG6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701972570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f07I5vkYcNbiJNcAFNGcoVH+whxOwsU4ggr1Z+Ad5Oo=;
        b=xs/glPgKWdiq161zlbK3FZZ3ABArMgyrleehjhmhOn6S4QFdtkAsnXRd0VL+t2l8oTPWd+
        FEABJ1I0ZlAyIgAA==
From:   Sebastian Siewior <bigeasy@linutronix.de>
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
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
Message-ID: <20231207180928.FZB319OJ@linutronix.de>
References: <20231201092654.34614-1-anna-maria@linutronix.de>
 <20231201092654.34614-31-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231201092654.34614-31-anna-maria@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-12-01 10:26:52 [+0100], Anna-Maria Behnsen wrote:
> diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
> new file mode 100644
> index 000000000000..05cd8f1bc45d
> --- /dev/null
> +++ b/kernel/time/timer_migration.c
> @@ -0,0 +1,1636 @@
=E2=80=A6
> + * Protection of the tmigr group state information:
> + * ------------------------------------------------
> + *
> + * The state information with the list of active children and migrator n=
eeds to
> + * be protected by a sequence counter. It prevents a race when updates i=
n a

s/a$//

> + * child groups are propagated in changed order. The following scenario
> + * describes what happens without updating the sequence counter:
> + *
> + * Therefore, let's take three groups and four CPUs (CPU2 and CPU3 as we=
ll
> + * as GRP0:1 will not change during the scenario):
> + *
> + *    LVL 1            [GRP1:0]
> + *                     migrator =3D GRP0:1
> + *                     active   =3D GRP0:0, GRP0:1
> + *                   /                \
> + *    LVL 0  [GRP0:0]                  [GRP0:1]
> + *           migrator =3D CPU0           migrator =3D CPU2
> + *           active   =3D CPU0           active   =3D CPU2
> + *              /         \                /         \
> + *    CPUs     0           1              2           3
> + *             active      idle           active      idle
> + *
> + *
> + * 1. CPU0 goes idle (changes are updated in GRP0:0; afterwards the curr=
ent
> + *    states of GRP0:0 and GRP1:0 are stored in the data for walking the
> + *    hierarchy):

   CPU0 goes idle. The state update is performed lock less and group
   wise. In the first step only GRP0:0 has been updated. The update of
   GRP1:0 is pending, the CPU walks through the hierarchy.

> + *
> + *    LVL 1            [GRP1:0]
> + *                     migrator =3D GRP0:1
> + *                     active   =3D GRP0:0, GRP0:1
> + *                   /                \
> + *    LVL 0  [GRP0:0]                  [GRP0:1]
> + *       --> migrator =3D TMIGR_NONE     migrator =3D CPU2
> + *       --> active   =3D                active   =3D CPU2
> + *              /         \                /         \
> + *    CPUs     0           1              2           3
> + *         --> idle        idle           active      idle

> + * 2. CPU1 comes out of idle (changes are update in GRP0:0; afterwards t=
he
> + *    current states of GRP0:0 and GRP1:0 are stored in the data for wal=
king the
> + *    hierarchy):

   While CPU0 goes idle and continues to update the state, CPU1 comes
   out of idle. CPU1 updates GRP0:0. The update for GRP1:0 is pending,
   tge CPU walks through the hierarchy. Both CPUs now walk the hierarchy
   to perform the needed update from their point of view.
   The currently visible state:

> + *
> + *    LVL 1            [GRP1:0]
> + *                     migrator =3D GRP0:1
> + *                     active   =3D GRP0:0, GRP0:1
> + *                   /                \
> + *    LVL 0  [GRP0:0]                  [GRP0:1]
> + *       --> migrator =3D CPU1           migrator =3D CPU2
> + *       --> active   =3D CPU1           active   =3D CPU2
> + *              /         \                /         \
> + *    CPUs     0           1              2           3
> + *             idle    --> active         active      idle
> + *
> + * 3. Here comes the change of the order: Propagating the changes of ste=
p 2
> + *    through the hierarchy to GRP1:0 - nothing to be done, because GRP0=
:0
> + *    is already up to date.

    Here is the race condition: CPU1 managed to propagate its changes
    through the hierarchy to GRP1:0 before CPU0 did. The active members
    of GRP1:0 remain unchanged after the update since it is still valid
    from CPU1 current point of view:

         LVL 1            [GRP1:0]
                      --> migrator =3D GRP0:1
                      --> active   =3D GRP0:0, GRP0:1
                        /                \
         LVL 0  [GRP0:0]                  [GRP0:1]
                migrator =3D CPU1           migrator =3D CPU2
                active   =3D CPU1           active   =3D CPU2
                   /         \                /         \
         CPUs     0           1              2           3
                  idle        active         active      idle

[ I take it as the migrator remains set to GRP0:1 by CPU1 but it could
  be changed to GRP0:0. I assume that both fields (migrator+active) are
  changed there via the propagation and the arrow in both fields denotes
  this. ]

> + * 4. Propagating the changes of step 1 through the hierarchy to GRP1:0

     Now CPU0 finally propagates its changes to GRP1:0.

> + *
> + *    LVL 1            [GRP1:0]
> + *                 --> migrator =3D GRP0:1
> + *                 --> active   =3D GRP0:1
> + *                   /                \
> + *    LVL 0  [GRP0:0]                  [GRP0:1]
> + *           migrator =3D CPU1           migrator =3D CPU2
> + *           active   =3D CPU1           active   =3D CPU2
> + *              /         \                /         \
> + *    CPUs     0           1              2           3
> + *             idle        active         active      idle
> + *
> + * Now there is a inconsistent overall state because GRP0:0 is active, b=
ut
> + * it is marked as idle in the GRP1:0. This is prevented by incrementing
> + * sequence counter whenever changing the state.

   The race of CPU0 vs CPU1 led to an inconsistent state in GRP1:0.
   CPU1 is active and is correctly listed as active in GRP0:0. However
   GRP1:0 does not have GRP0:0 listed as active which is wrong.
   The sequence counter has been added to avoid inconsistent states
   during updates. The state is updated atomically only if all members,
   including the sequence counter, match the expected value
   (compare-and-exchange).
   Looking back at the previous example with the addition of the
   sequence number: The update as performed by CPU0 in step 4 will fail.
   CPU1 changed the sequence number during the update in step 3 so the
   expected old value (as seen by CPU0 before starting the walk) does
   not match.


Sebastian
