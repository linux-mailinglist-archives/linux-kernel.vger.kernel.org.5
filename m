Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A82EB7E5B2D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 17:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjKHQ2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 11:28:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjKHQ2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 11:28:36 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F94C131
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 08:28:34 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 167AB1BF209;
        Wed,  8 Nov 2023 16:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699460912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zs9+S0R8PYjyShEny+cHKDT3xvgakq4XWC3C6mTZOWY=;
        b=JCvPwIz6Y1AJVBP82jxN6G/mhBUMS26WR3fwHzXT5+jWxTEjAk30mOkQad6uLOj2eqjaP7
        tIVjT53iN/EWskgDMRk9pgDL7FzuZpv4eVg1+j2JMjZ7i7aw6BViUPdhayXLcGFBcPOby0
        ohSpPzTAw0oONxiCTbJj2sOMCKJc6JVi/fQ7oex7XkTMwaH14EmzwBLzZOFZNdvuVCnGba
        C9+fJpydn567cpxV9lPQ1cA+A9fFTupG/6SYZTQVK8fZ8L5wt5sO9cAnhlPRfbxwVTSi3O
        iM6X/qbqhSOR2M3sD3zv53uTvDkleUlWHBRc7PqMoHZOweKxiY/6Bu8+HSb+4w==
Date:   Wed, 8 Nov 2023 17:28:27 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Ankur Arora <ankur.a.arora@oracle.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, jon.grimm@amd.com,
        bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com, mingo@kernel.org,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@ACULAB.COM, richard@nod.at, mjguzik@gmail.com,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>
Subject: Re: [RFC PATCH 82/86] treewide: mtd: remove cond_resched()
Message-ID: <20231108172827.1fc0bd89@xps-13>
In-Reply-To: <20231107230822.371443-26-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
        <20231107230822.371443-1-ankur.a.arora@oracle.com>
        <20231107230822.371443-26-ankur.a.arora@oracle.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ankur,

ankur.a.arora@oracle.com wrote on Tue,  7 Nov 2023 15:08:18 -0800:

> There are broadly three sets of uses of cond_resched():
>=20
> 1.  Calls to cond_resched() out of the goodness of our heart,
>     otherwise known as avoiding lockup splats.
>=20
> 2.  Open coded variants of cond_resched_lock() which call
>     cond_resched().
>=20
> 3.  Retry or error handling loops, where cond_resched() is used as a
>     quick alternative to spinning in a tight-loop.
>=20
> When running under a full preemption model, the cond_resched() reduces
> to a NOP (not even a barrier) so removing it obviously cannot matter.
>=20
> But considering only voluntary preemption models (for say code that
> has been mostly tested under those), for set-1 and set-2 the
> scheduler can now preempt kernel tasks running beyond their time
> quanta anywhere they are preemptible() [1]. Which removes any need
> for these explicitly placed scheduling points.
>=20
> The cond_resched() calls in set-3 are a little more difficult.
> To start with, given it's NOP character under full preemption, it
> never actually saved us from a tight loop.
> With voluntary preemption, it's not a NOP, but it might as well be --
> for most workloads the scheduler does not have an interminable supply
> of runnable tasks on the runqueue.
>=20
> So, cond_resched() is useful to not get softlockup splats, but not
> terribly good for error handling. Ideally, these should be replaced
> with some kind of timed or event wait.
> For now we use cond_resched_stall(), which tries to schedule if
> possible, and executes a cpu_relax() if not.
>=20
> Most of the uses here are in set-1 (some right after we give up a lock
> or enable bottom-halves, causing an explicit preemption check.)
>=20
> There are a few cases from set-3. Replace them with
> cond_resched_stall(). Some of those places, however, have wait-times
> milliseconds, so maybe we should just have an msleep() there?

Yeah, I believe this should work.

>=20
> [1] https://lore.kernel.org/lkml/20231107215742.363031-1-ankur.a.arora@or=
acle.com/
>=20
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Tudor Ambarus <tudor.ambarus@linaro.org>
> Cc: Pratyush Yadav <pratyush@kernel.org>
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---

[...]

> --- a/drivers/mtd/nand/raw/nand_legacy.c
> +++ b/drivers/mtd/nand/raw/nand_legacy.c
> @@ -203,7 +203,13 @@ void nand_wait_ready(struct nand_chip *chip)
>  	do {
>  		if (chip->legacy.dev_ready(chip))
>  			return;
> -		cond_resched();
> +		/*
> +		 * Use a cond_resched_stall() to avoid spinning in
> +		 * a tight loop.
> +		 * Though, given that the timeout is in milliseconds,
> +		 * maybe this should timeout or event wait?

Event waiting is precisely what we do here, with the hardware access
which are available in this case. So I believe this part of the comment
(in general) is not relevant. Now regarding the timeout I believe it is
closer to the second than the millisecond, so timeout-ing is not
relevant either in most cases (talking about mtd/ in general).

> +		 */
> +		cond_resched_stall();
>  	} while (time_before(jiffies, timeo));

Thanks,
Miqu=C3=A8l
