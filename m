Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9147600A7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 22:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjGXUum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 16:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjGXUuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 16:50:39 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45AE10C3;
        Mon, 24 Jul 2023 13:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OYTJvIAB8armLdjFxMwh4eSieKXJT6xjO05VM/ChcnE=; b=RMBu/I6CBq72t9E1PN6/U2q1BC
        eEsWz4I0tSZ8p+V45mL1CpupwdqzYM3GAAm8hap3+9Eo+JXttG8Uq6TYvXlk3A2yOq4UvR1IjLbN2
        szIw/YgCYt+x1bnuKVZveBQ+gtNCoRo/+9ZVHaR1rkQmYcHehjuPhwgc0WHDGjDIPZjPAB3sIm1sB
        YB492rfmmvzsg3EIUmBo2qWFaS6Qaf5C/0mL/VXiIHCfd9IFEVz+55KgELrmVkaoiYCwS2gCwWmjX
        XaWMTHOiysJJiMUp0Lc1wAEawuzk/wQ7BTUNB2eYSEf7ndLI13dnzU2thU2gfZNO2L0iXsKwd+dEL
        +I7jynKw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qO2Uy-002i3Y-1O;
        Mon, 24 Jul 2023 20:49:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F1030300155;
        Mon, 24 Jul 2023 22:49:42 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D1AD32CC644CB; Mon, 24 Jul 2023 22:49:42 +0200 (CEST)
Date:   Mon, 24 Jul 2023 22:49:42 +0200
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
Message-ID: <20230724204942.GD3745454@hirez.programming.kicks-ass.net>
References: <20230724155329.474037902@linutronix.de>
 <20230724172844.690165660@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724172844.690165660@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 07:44:17PM +0200, Thomas Gleixner wrote:

> +static inline bool topo_subleaf(struct topo_scan *tscan, u32 leaf, u32 subleaf)
> +{
> +	unsigned int dom, maxtype = leaf == 0xb ? CORE_TYPE + 1 : MAX_TYPE;
> +	struct {
> +		// eax
> +		u32	x2apic_shift	:  5, // Number of bits to shift APIC ID right
> +					      // for the topology ID at the next level
> +			__rsvd0		: 27; // Reserved
> +					      // ebx
> +		u32	num_processors	: 16, // Number of processors at current level
> +			__rsvd1		: 16; // Reserved
> +					      // ecx
> +		u32	level		:  8, // Current topology level. Same as sub leaf number
> +			type		:  8, // Level type. If 0, invalid
> +			__rsvd2		: 16; // Reserved
> +					      // edx
> +		u32	x2apic_id	: 32; // X2APIC ID of the current logical processor

That comment seems inconsistent, either have then all aligned or move
all register names left.

But yeah, I think this is more or less what we ended up with last time I
went through this.

> +	} sl;
> +
> +	cpuid_subleaf(leaf, subleaf, &sl);
> +
> +	if (!sl.num_processors || sl.type == INVALID_TYPE)
> +		return false;
> +
> +	if (sl.type >= maxtype) {
> +		/*
> +		 * As the subleafs are ordered in domain level order, this
> +		 * could be recovered in theory by propagating the
> +		 * information at the last parsed level.
> +		 *
> +		 * But if the infinite wisdom of hardware folks decides to
> +		 * create a new domain type between CORE and MODULE or DIE
> +		 * and DIEGRP, then that would overwrite the CORE or DIE
> +		 * information.
> +		 *
> +		 * It really would have been too obvious to make the domain
> +		 * type space sparse and leave a few reserved types between
> +		 * the points which might change instead of forcing
> +		 * software to either create a monstrosity of workarounds
> +		 * or just being up the creek without a paddle.
> +		 *
> +		 * Refuse to implement monstrosity, emit an error and try
> +		 * to survive.
> +		 */
> +		pr_err_once("Topology: leaf 0x%x:%d Unknown domain type %u\n",
> +			    leaf, subleaf, sl.type);
> +		return true;
> +	}
> +
> +	dom = topo_domain_map[sl.type];
> +	if (!dom) {
> +		tscan->c->topo.initial_apicid = sl.x2apic_id;
> +	} else if (tscan->c->topo.initial_apicid != sl.x2apic_id) {
> +		pr_warn_once(FW_BUG "CPUID leaf 0x%x subleaf %d APIC ID mismatch %x != %x\n",
> +			     leaf, subleaf, tscan->c->topo.initial_apicid, sl.x2apic_id);
> +	}
> +
> +	topology_set_dom(tscan, dom, sl.x2apic_shift, sl.num_processors);
> +	return true;
> +}
> +
> +static bool parse_topology_leaf(struct topo_scan *tscan, u32 leaf)
> +{
> +	u32 subleaf;
> +
> +	if (tscan->c->cpuid_level < leaf)
> +		return false;
> +
> +	/* Read all available subleafs and populate the levels */
> +	for (subleaf = 0; topo_subleaf(tscan, leaf, subleaf); subleaf++);

Personally I prefer:

	for (;;)
		;

that is, have the semicolon on it's own line, but meh.

> +
> +	/* If subleaf 0 failed to parse, give up */
> +	if (!subleaf)
> +		return false;
> +
> +	/*
> +	 * There are machines in the wild which have shift 0 in the subleaf
> +	 * 0, but advertise 2 logical processors at that level. They are
> +	 * truly SMT.
> +	 */
> +	if (!tscan->dom_shifts[TOPO_SMT_DOMAIN] && tscan->dom_ncpus[TOPO_SMT_DOMAIN] > 1) {
> +		u16 sft = get_count_order(tscan->dom_ncpus[TOPO_SMT_DOMAIN]);
> +
> +		pr_warn_once(FW_BUG "CPUID leaf 0x%x subleaf 0 has shift level 0 but %u CPUs\n",
> +			     leaf, tscan->dom_ncpus[TOPO_SMT_DOMAIN]);
> +		topology_update_dom(tscan, TOPO_SMT_DOMAIN, sft, tscan->dom_ncpus[TOPO_SMT_DOMAIN]);
> +	}
> +
> +	set_cpu_cap(tscan->c, X86_FEATURE_XTOPOLOGY);
> +	return true;
> +}
> +
> +bool cpu_parse_topology_ext(struct topo_scan *tscan)
> +{
> +	/* Try lead 0x1F first. If not available try leaf 0x0b */
> +	if (parse_topology_leaf(tscan, 0x1f))
> +		return true;
> +	return parse_topology_leaf(tscan, 0x0b);
> +}
> 
