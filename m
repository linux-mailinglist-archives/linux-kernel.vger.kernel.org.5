Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6377E5B4A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 17:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbjKHQdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 11:33:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232585AbjKHQdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 11:33:08 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A11D2117
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 08:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=xl9zIZaPQWoZmouQEGUv8vjcnw5Dobym2k6XqXL+ejU=; b=bizyTGVSMBTPDyPGoga+q/pwuJ
        xRcGFCzgYTY8JFfjUdkCr57FSUxMQ/bCsPimFuBIIJuN7WnzH0lW+nPjut8Wmt0gCCOnmjtJa5ARm
        nMNfAOpa6ILF/8nZhw50gnAQ+AkJkcBNEJL74VIdEXLtnAwW8W3OAe7XI5nwXJRj9VvcvhXFNw7hU
        zm2iFw/GqY6IEBOhx9erZ9YOhRGXR3adOIfsCrAKUPZ+wDt3gb0BObn2CuFej587xwuGfD8RFojsL
        sjiHk0t3RroZeGiwoHY2lP9a/wlSN7tErkqpGFczUuVBzcS9w/34hOQp2LZ3Lhm6oUt3Fnmug7W+Q
        ETzNojTA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r0lTo-00217a-9G; Wed, 08 Nov 2023 16:32:36 +0000
Date:   Wed, 8 Nov 2023 16:32:36 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
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
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>
Subject: Re: [RFC PATCH 82/86] treewide: mtd: remove cond_resched()
Message-ID: <ZUu4JHLMwC4s7QvS@casper.infradead.org>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107230822.371443-1-ankur.a.arora@oracle.com>
 <20231107230822.371443-26-ankur.a.arora@oracle.com>
 <20231108172827.1fc0bd89@xps-13>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231108172827.1fc0bd89@xps-13>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2023 at 05:28:27PM +0100, Miquel Raynal wrote:
> > --- a/drivers/mtd/nand/raw/nand_legacy.c
> > +++ b/drivers/mtd/nand/raw/nand_legacy.c
> > @@ -203,7 +203,13 @@ void nand_wait_ready(struct nand_chip *chip)
> >  	do {
> >  		if (chip->legacy.dev_ready(chip))
> >  			return;
> > -		cond_resched();
> > +		/*
> > +		 * Use a cond_resched_stall() to avoid spinning in
> > +		 * a tight loop.
> > +		 * Though, given that the timeout is in milliseconds,
> > +		 * maybe this should timeout or event wait?
> 
> Event waiting is precisely what we do here, with the hardware access
> which are available in this case. So I believe this part of the comment
> (in general) is not relevant. Now regarding the timeout I believe it is
> closer to the second than the millisecond, so timeout-ing is not
> relevant either in most cases (talking about mtd/ in general).

I think you've misunderstood what Ankur wrote here.  What you're
currently doing is spinning in a very tight loop.  The comment is
suggesting you might want to msleep(1) or something to avoid burning CPU
cycles.  It'd be even better if the hardware could signal you somehow,
but I bet it can't.

> > +		 */
> > +		cond_resched_stall();
> >  	} while (time_before(jiffies, timeo));
> 
> Thanks,
> Miquèl
> 
