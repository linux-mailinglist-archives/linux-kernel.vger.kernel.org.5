Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E070B7600D7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 23:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjGXVDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 17:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjGXVDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 17:03:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118DF187;
        Mon, 24 Jul 2023 14:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ikv5RWJ2ZX7Htggzkm0GhNiijEx+JWmm8AH3RJo3Msw=; b=lMUXDEMMWct/2mxwlw6njxwJMG
        mrTykE5uacXXfi2B7KyFMenBk5MNW9KWcqydaBvDuz3J1bP/XWS0DJZGzG7feVOdINkmjIGmgFqCg
        +x3HjxDWYl529w4JV97dPzIeUjtuUTHVG+qxoip6k2YtnpOZLffNhopIn1Y2WagLpWpT3Pr+aFm/F
        YLEzzsSb878lyI+y3aYSavsi4adduZ8ITINi4eZD5S3iqPVSwSx/cciFWfo4g9P3qZBezQU4oZpN7
        5UeXSNgFGM5diU9xT6Q64KwkiAPq76jbbjb5QMdTx/hvl6XKBBE5RPj3hNkSr2qvnEtM4QA1Ted4l
        dPgBLhzg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qO2hJ-004o2T-BB; Mon, 24 Jul 2023 21:02:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 68B55300155;
        Mon, 24 Jul 2023 23:02:28 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4AC702CC644CF; Mon, 24 Jul 2023 23:02:28 +0200 (CEST)
Date:   Mon, 24 Jul 2023 23:02:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Huang Rui <ray.huang@amd.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Steve Wahl <steve.wahl@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>
Subject: Re: [patch 17/29] x86/cpu: Provide a sane leaf 0xb/0x1f parser
Message-ID: <20230724210228.GA3749554@hirez.programming.kicks-ass.net>
References: <20230724155329.474037902@linutronix.de>
 <20230724172844.690165660@linutronix.de>
 <20230724204942.GD3745454@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724204942.GD3745454@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 10:49:42PM +0200, Peter Zijlstra wrote:
> On Mon, Jul 24, 2023 at 07:44:17PM +0200, Thomas Gleixner wrote:
> 
> > +static inline bool topo_subleaf(struct topo_scan *tscan, u32 leaf, u32 subleaf)
> > +{
> > +	unsigned int dom, maxtype = leaf == 0xb ? CORE_TYPE + 1 : MAX_TYPE;
> > +	struct {
> > +		// eax
> > +		u32	x2apic_shift	:  5, // Number of bits to shift APIC ID right
> > +					      // for the topology ID at the next level
> > +			__rsvd0		: 27; // Reserved
> > +					      // ebx
> > +		u32	num_processors	: 16, // Number of processors at current level
> > +			__rsvd1		: 16; // Reserved
> > +					      // ecx
> > +		u32	level		:  8, // Current topology level. Same as sub leaf number
> > +			type		:  8, // Level type. If 0, invalid
> > +			__rsvd2		: 16; // Reserved
> > +					      // edx
> > +		u32	x2apic_id	: 32; // X2APIC ID of the current logical processor
> 
> That comment seems inconsistent, either have then all aligned or move
> all register names left.

AMD code seems to have the reg names left aligned -- perhaps do the same
here.
