Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662437E5C4B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 18:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbjKHRVU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 8 Nov 2023 12:21:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjKHRVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 12:21:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E95182
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 09:21:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0DBFC433C8;
        Wed,  8 Nov 2023 17:21:12 +0000 (UTC)
Date:   Wed, 8 Nov 2023 12:21:16 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org, mgorman@suse.de,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com, mingo@kernel.org,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, David.Laight@aculab.com,
        richard@nod.at, mjguzik@gmail.com,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>
Subject: Re: [RFC PATCH 82/86] treewide: mtd: remove cond_resched()
Message-ID: <20231108122116.5e2c11be@gandalf.local.home>
In-Reply-To: <ZUu4JHLMwC4s7QvS@casper.infradead.org>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
        <20231107230822.371443-1-ankur.a.arora@oracle.com>
        <20231107230822.371443-26-ankur.a.arora@oracle.com>
        <20231108172827.1fc0bd89@xps-13>
        <ZUu4JHLMwC4s7QvS@casper.infradead.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Nov 2023 16:32:36 +0000
Matthew Wilcox <willy@infradead.org> wrote:

> On Wed, Nov 08, 2023 at 05:28:27PM +0100, Miquel Raynal wrote:
> > > --- a/drivers/mtd/nand/raw/nand_legacy.c
> > > +++ b/drivers/mtd/nand/raw/nand_legacy.c
> > > @@ -203,7 +203,13 @@ void nand_wait_ready(struct nand_chip *chip)
> > >  	do {
> > >  		if (chip->legacy.dev_ready(chip))
> > >  			return;
> > > -		cond_resched();
> > > +		/*
> > > +		 * Use a cond_resched_stall() to avoid spinning in
> > > +		 * a tight loop.
> > > +		 * Though, given that the timeout is in milliseconds,
> > > +		 * maybe this should timeout or event wait?  
> > 
> > Event waiting is precisely what we do here, with the hardware access
> > which are available in this case. So I believe this part of the comment
> > (in general) is not relevant. Now regarding the timeout I believe it is
> > closer to the second than the millisecond, so timeout-ing is not
> > relevant either in most cases (talking about mtd/ in general).  
> 
> I think you've misunderstood what Ankur wrote here.  What you're
> currently doing is spinning in a very tight loop.  The comment is
> suggesting you might want to msleep(1) or something to avoid burning CPU
> cycles.  It'd be even better if the hardware could signal you somehow,
> but I bet it can't.
> 

Oh how I wish we could bring back the old PREEMPT_RT cpu_chill()...

#define cpu_chill()	msleep(1)

;-)

-- Steve


> > > +		 */
> > > +		cond_resched_stall();
> > >  	} while (time_before(jiffies, timeo));  
> > 
> > Thanks,
> > Miquèl
> >   

