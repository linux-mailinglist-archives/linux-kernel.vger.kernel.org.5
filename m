Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332B07D3EBF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 20:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbjJWSO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 14:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjJWSO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 14:14:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73DBF9D;
        Mon, 23 Oct 2023 11:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698084865; x=1729620865;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P30FNT417k1cYRKrbeS6AdI66H28Gw47BUwkjsEDXmw=;
  b=NvQsb73esoJaU+zbPW+IbLwQvQgHMwrj3m2RSFy7eKLOVzYsI1R1zwpJ
   D2XdU2m24G7iXylJVnTM8yXLt5Cq3F2x9h1w4BQZkeqXdYZWwuH7GStMr
   Cj2pfK4Wxkc/9aXrMcrVgMvo8p6HLbdq4QLi1pU105YCmwEzNoFw5fkMA
   TORLB+54F8Dktv6v8vNQgr31e631xPLDixlb24a61rJVjn5pPzQZWBqo1
   xmzkjCEs0AwsgjUtpIx3EcmGvKhVxGijkHnA5nbgXOKE8fId6juRnF+/l
   9NikTQz0MAJGRF8taU7TaDNaotZ2tGNvJdx2jtJbJz10W1KXpDel1m4ER
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="384099283"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="384099283"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 11:14:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="787529774"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="787529774"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 11:14:06 -0700
Date:   Mon, 23 Oct 2023 11:14:04 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Smita.KoralahalliChannabasappa@amd.com,
        dave.hansen@linux.intel.com, x86@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH v9 2/3] x86/mce: Add per-bank CMCI storm mitigation
Message-ID: <ZTa37L2nlnbok8dz@agluck-desk3>
References: <20230929181626.210782-1-tony.luck@intel.com>
 <20231004183623.17067-1-tony.luck@intel.com>
 <20231004183623.17067-3-tony.luck@intel.com>
 <20231019151211.GHZTFHS3osBIL1IJbF@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019151211.GHZTFHS3osBIL1IJbF@fat_crate.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 05:12:11PM +0200, Borislav Petkov wrote:
> On Wed, Oct 04, 2023 at 11:36:22AM -0700, Tony Luck wrote:
> > +/*
> > + * history:	bitmask tracking whether errors were seen or not seen in
> > + *		the most recent polls of a bank.
> 
> 		each bit in that bitmask represents an error seen.

Yes. That reads better.

> 
> > + * timestamp:	last time (in jiffies) that the bank was polled
> > + * storm:	Is this bank in storm mode?
> > + */
> > +struct storm_bank {
> > +	u64 history;
> > +	u64 timestamp;
> > +	bool storm;
> 
> I guess "in_storm_mode" is even more descriptive:
> 
> 	storm->banks[bank].in_storm_mode = false;
> 
> etc.

Will fix.

> 
> > +};
> > +
> > +/* How many errors within the history buffer mark the start of a storm. */
> > +#define STORM_BEGIN_THRESHOLD	5
> > +
> > +/*
> > + * How many polls of machine check bank without an error before declaring
> > + * the storm is over. Since it is tracked by the bitmaks in the history
> > + * field of struct storm_bank the mask is 30 bits [0 ... 29].
> > + */
> > +#define STORM_END_POLL_THRESHOLD	29
> >  
> >  #ifdef CONFIG_ACPI_APEI
> >  int apei_write_mce(struct mce *m);
> > diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> > index f6e87443b37a..7c931f0c9251 100644
> > --- a/arch/x86/kernel/cpu/mce/core.c
> > +++ b/arch/x86/kernel/cpu/mce/core.c
> > @@ -680,6 +680,8 @@ bool machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
> >  		barrier();
> >  		m.status = mce_rdmsrl(mca_msr_reg(i, MCA_STATUS));
> >  
> > +		mce_track_storm(&m);
> 
> Lemme see if I understand the idea here:
> 
> the default polling interval is 5 mins. So the storm tracking is called
> every 5 mins once to see how are banks "doing", so to speak and to get
> them in or out of storm mode. So far so good...
> 
> > +
> >  		/* If this entry is not valid, ignore it */
> >  		if (!(m.status & MCI_STATUS_VAL))
> >  			continue;
> 
> Btw, you're tracking storm even if the error is not valid - conditional
> above here. Why?

I want to track whether each bank is in storm mode, or not. But there's
no indication when a CMCI is delivered which bank was the source. Code
just has to scan all the banks, and might find more than one with an
error. While no bank is in polling mode, there isn't a set time interval
between scanning banks. A scan is just triggered when a CMCI happens.
So it's non-trivial to compute a rate. Would require saving a timestamp
for every logged error.

In a simple case there's just one bank responsible for a ton of CMCI.
No need for complexity here, the count of interrupts from that bank will
hit a threshold and a storm is declared.

But more complex scenarois are possible. Other banks may trigger small
numbers of CMCI. Not enough to call it a storm.  Or multiple banks may
be screaming together.

By tracking both the hits and misses in each bank, I end up with a
bitmap history for the past 64 polls. If there are enough "1" bits in
that bitmap to meet the threshold, then declare a storm for that bank.

> 
> > @@ -1652,22 +1654,29 @@ static void mce_timer_fn(struct timer_list *t)
> >  	else
> >  		iv = min(iv * 2, round_jiffies_relative(check_interval * HZ));
> >  
> > -	__this_cpu_write(mce_next_interval, iv);
> > -	__start_timer(t, iv);
> > +	if (mce_is_storm()) {
> > +		__start_timer(t, HZ);
> > +	} else {
> > +		__this_cpu_write(mce_next_interval, iv);
> > +		__start_timer(t, iv);
> > +	}
> 
> ... this is where it becomes, hm, interesting: the check interval will
> be halved if an error has been seen during this round but then if we're
> in storm mode, that check interval doesn't matter - you'll run the timer
> each second.
> 
> Then you need to restructure this to check the storm condition and not
> do anything to iv if storm.
> 
> Or, am I missing something?

I need to stare at this again to refresh my memory of what's going on
here. This code may need pulling apart into a routine that is used for
systems with no CMCI (or have CMCI disabled). Then the whole "divide the
poll interval by two" when you see an error and double the interval
when you don't see an error makes sense.

For systems with CMCI ... I think just polling a one second interval
until the storm is over makes sense.

> 
> > diff --git a/arch/x86/kernel/cpu/mce/threshold.c b/arch/x86/kernel/cpu/mce/threshold.c
> > index ef4e7bb5fd88..ecdf13f1bb7d 100644
> > --- a/arch/x86/kernel/cpu/mce/threshold.c
> > +++ b/arch/x86/kernel/cpu/mce/threshold.c
> > @@ -29,3 +29,115 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_threshold)
> >  	trace_threshold_apic_exit(THRESHOLD_APIC_VECTOR);
> >  	apic_eoi();
> >  }
> > +
> > +/*
> > + * banks:		per-cpu, per-bank details
> > + * stormy_bank_count:	count of MC banks in storm state
> > + * poll_mode:		CPU is in poll mode
> > + */
> > +struct mca_storm_desc {
> > +	struct storm_bank	banks[MAX_NR_BANKS];
> > +	u8			stormy_bank_count;
> > +	bool			poll_mode;
> > +};
> 
> Yeah, put the struct definition into internal.h pls.

These are only used in threshold.c now. What's the point of them
being in internal.h. That's for defintiones shared by multiple
mcs/*.c files. Isn't it? But will move there if you still want this.

> 
> > +static DEFINE_PER_CPU(struct mca_storm_desc, storm_desc);
> > +
> > +void mce_inherit_storm(unsigned int bank)
> > +{
> > +	struct mca_storm_desc *storm = this_cpu_ptr(&storm_desc);
> > +
> > +	storm->banks[bank].history = ~0ull;
> 
> So upon inheriting a bank, you set its history that it has seen errors
> each time?
> 
> That's weird.

Ideally the new CPU would inherit the precise state of the previous
owner of this bank. But there's no easy way to track that as the bank
is abanoned by the CPU going offline, and there is a free-for-all with
remaining CPUs racing to claim ownership. It is known that this bank
was in storm mode (because the threshold in the CTL2 bank register is
set to CMCI_STORM_THRESHOLD).

I went with "worst case" to make sure the new CPU didn't prematurely
declare an end to the storm.

I'll add a comment in mce_inherit_storm() to explain this.

> 
> > +	storm->banks[bank].timestamp = jiffies;
> > +}
> > +
> > +bool mce_is_storm(void)
> 
> That's a weird name. mce_get_storm_mode() perhaps?

Sure.

> 
> > +{
> > +	return __this_cpu_read(storm_desc.poll_mode);
> > +}
> > +
> > +void mce_set_storm(bool storm)
> 
> mce_set_storm_mode()

Also sure.

> 
> > +{
> > +	__this_cpu_write(storm_desc.poll_mode, storm);
> > +}
> > +
> > +static void mce_handle_storm(unsigned int bank, bool on)
> > +{
> > +	switch (boot_cpu_data.x86_vendor) {
> > +	}
> > +}
> 
> ...
> 
> > +void mce_track_storm(struct mce *mce)
> > +{
> > +	struct mca_storm_desc *storm = this_cpu_ptr(&storm_desc);
> > +	unsigned long now = jiffies, delta;
> > +	unsigned int shift = 1;
> > +	u64 history = 0;
> > +
> > +	/*
> > +	 * When a bank is in storm mode it is polled once per second and
> > +	 * the history mask will record about the last minute of poll results.
> > +	 * If it is not in storm mode, then the bank is only checked when
> > +	 * there is a CMCI interrupt. Check how long it has been since
> > +	 * this bank was last checked, and adjust the amount of "shift"
> > +	 * to apply to history.
> > +	 */
> > +	if (!storm->banks[mce->bank].storm) {
> 
> Yeah, if this were
> 
> 	if (!storm->banks[mce->bank].in_storm_mode)
> 
> it would've been perfectly clear what the condition tests.

Yup.

> 
> > +		delta = now - storm->banks[mce->bank].timestamp;
> > +		shift = (delta + HZ) / HZ;
> > +	}
> > +
> > +	/* If it has been a long time since the last poll, clear history. */
> > +	if (shift < 64)
> 
> Use a properly named define instead of a naked number.

Like this?

#define NUM_HISTORY_BITS (sizeof(u64) * BITS_PER_BYTE)

	if (shift < NUM_HISTORY_BITS)
> 
> ...
> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.

-Tony
