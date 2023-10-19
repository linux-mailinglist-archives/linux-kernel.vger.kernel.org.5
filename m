Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6C27CFD9A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 17:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345550AbjJSPMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 11:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbjJSPM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 11:12:29 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42EE11B
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 08:12:27 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id DDCF440E01AA;
        Thu, 19 Oct 2023 15:12:25 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id XMEjBrjQIxp8; Thu, 19 Oct 2023 15:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1697728344; bh=jxWvDYhu22xzXY4/jglAUcc8tHFvy0xIj8ki/7s994w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JAppBAXN6lwZkpxtfgd8rsdlFj5Lxzzj/RouJYHQMl6fngJnH782OjdcxZUDKJcyn
         /QO6WMpy8i77Qw71ARthIN6vNaXSwBCqyBfP428JPNLJNx73BhLj9T+WyInIv8lUK+
         Nbz0UjxyjLcCTgUkCPMSIN9xZZ8+61ADKCf5viYy8/e7/pyuW4NQr4uNVb7snak08H
         0gTKZJ/khlF8SIkM47KU+u7IEfyAuqm6iOU7fjMAVZd/DOU5u3++zVcjZCWjWONGeX
         mfWQ8wbq/bAB19yK35pOpffq61hOrdELMoulHndDvq/MMkCgwxj/lfV/TJ9zp4TMYy
         mTaA/c9VXa1IhA7Z5RSEX8tgoNmGxAukpCFxv9vd4Im7RpzX1dYyj+F8R8Ugpib1mY
         SloruW+8t3cI0KtPNpe62aclXnN7bfdeXeazgvsu8XGqzk5xqPVirHjg0j+kzPoeLJ
         7Lp/g4c4AndFlAes5dxkrbqCEjlvfPfX10W0Wzf4QYJ2WDXh7WmeSyL0CVBI2CyWwb
         PAOmRmsF4C34rNuqpE6Mjv6iQxFNISIZkZATohInJ/m5nkoHs6rXd8PD1wFWSCQpd7
         SwpW2Qr7QKAq9nTQehxgRzW18kfVbyXFEcr95mMqZzpFAEE9QwhM+13aR3O//dNU67
         ro6XtzLOAGHQcqROHb0f5TPM=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EFB4640E0196;
        Thu, 19 Oct 2023 15:12:15 +0000 (UTC)
Date:   Thu, 19 Oct 2023 17:12:11 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Smita.KoralahalliChannabasappa@amd.com,
        dave.hansen@linux.intel.com, x86@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH v9 2/3] x86/mce: Add per-bank CMCI storm mitigation
Message-ID: <20231019151211.GHZTFHS3osBIL1IJbF@fat_crate.local>
References: <20230929181626.210782-1-tony.luck@intel.com>
 <20231004183623.17067-1-tony.luck@intel.com>
 <20231004183623.17067-3-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231004183623.17067-3-tony.luck@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 11:36:22AM -0700, Tony Luck wrote:
> +/*
> + * history:	bitmask tracking whether errors were seen or not seen in
> + *		the most recent polls of a bank.

		each bit in that bitmask represents an error seen.

> + * timestamp:	last time (in jiffies) that the bank was polled
> + * storm:	Is this bank in storm mode?
> + */
> +struct storm_bank {
> +	u64 history;
> +	u64 timestamp;
> +	bool storm;

I guess "in_storm_mode" is even more descriptive:

	storm->banks[bank].in_storm_mode = false;

etc.

> +};
> +
> +/* How many errors within the history buffer mark the start of a storm. */
> +#define STORM_BEGIN_THRESHOLD	5
> +
> +/*
> + * How many polls of machine check bank without an error before declaring
> + * the storm is over. Since it is tracked by the bitmaks in the history
> + * field of struct storm_bank the mask is 30 bits [0 ... 29].
> + */
> +#define STORM_END_POLL_THRESHOLD	29
>  
>  #ifdef CONFIG_ACPI_APEI
>  int apei_write_mce(struct mce *m);
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index f6e87443b37a..7c931f0c9251 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -680,6 +680,8 @@ bool machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
>  		barrier();
>  		m.status = mce_rdmsrl(mca_msr_reg(i, MCA_STATUS));
>  
> +		mce_track_storm(&m);

Lemme see if I understand the idea here:

the default polling interval is 5 mins. So the storm tracking is called
every 5 mins once to see how are banks "doing", so to speak and to get
them in or out of storm mode. So far so good...

> +
>  		/* If this entry is not valid, ignore it */
>  		if (!(m.status & MCI_STATUS_VAL))
>  			continue;

Btw, you're tracking storm even if the error is not valid - conditional
above here. Why?

> @@ -1652,22 +1654,29 @@ static void mce_timer_fn(struct timer_list *t)
>  	else
>  		iv = min(iv * 2, round_jiffies_relative(check_interval * HZ));
>  
> -	__this_cpu_write(mce_next_interval, iv);
> -	__start_timer(t, iv);
> +	if (mce_is_storm()) {
> +		__start_timer(t, HZ);
> +	} else {
> +		__this_cpu_write(mce_next_interval, iv);
> +		__start_timer(t, iv);
> +	}

... this is where it becomes, hm, interesting: the check interval will
be halved if an error has been seen during this round but then if we're
in storm mode, that check interval doesn't matter - you'll run the timer
each second.

Then you need to restructure this to check the storm condition and not
do anything to iv if storm.

Or, am I missing something?

> diff --git a/arch/x86/kernel/cpu/mce/threshold.c b/arch/x86/kernel/cpu/mce/threshold.c
> index ef4e7bb5fd88..ecdf13f1bb7d 100644
> --- a/arch/x86/kernel/cpu/mce/threshold.c
> +++ b/arch/x86/kernel/cpu/mce/threshold.c
> @@ -29,3 +29,115 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_threshold)
>  	trace_threshold_apic_exit(THRESHOLD_APIC_VECTOR);
>  	apic_eoi();
>  }
> +
> +/*
> + * banks:		per-cpu, per-bank details
> + * stormy_bank_count:	count of MC banks in storm state
> + * poll_mode:		CPU is in poll mode
> + */
> +struct mca_storm_desc {
> +	struct storm_bank	banks[MAX_NR_BANKS];
> +	u8			stormy_bank_count;
> +	bool			poll_mode;
> +};

Yeah, put the struct definition into internal.h pls.

> +static DEFINE_PER_CPU(struct mca_storm_desc, storm_desc);
> +
> +void mce_inherit_storm(unsigned int bank)
> +{
> +	struct mca_storm_desc *storm = this_cpu_ptr(&storm_desc);
> +
> +	storm->banks[bank].history = ~0ull;

So upon inheriting a bank, you set its history that it has seen errors
each time?

That's weird.

> +	storm->banks[bank].timestamp = jiffies;
> +}
> +
> +bool mce_is_storm(void)

That's a weird name. mce_get_storm_mode() perhaps?

> +{
> +	return __this_cpu_read(storm_desc.poll_mode);
> +}
> +
> +void mce_set_storm(bool storm)

mce_set_storm_mode()

> +{
> +	__this_cpu_write(storm_desc.poll_mode, storm);
> +}
> +
> +static void mce_handle_storm(unsigned int bank, bool on)
> +{
> +	switch (boot_cpu_data.x86_vendor) {
> +	}
> +}

...

> +void mce_track_storm(struct mce *mce)
> +{
> +	struct mca_storm_desc *storm = this_cpu_ptr(&storm_desc);
> +	unsigned long now = jiffies, delta;
> +	unsigned int shift = 1;
> +	u64 history = 0;
> +
> +	/*
> +	 * When a bank is in storm mode it is polled once per second and
> +	 * the history mask will record about the last minute of poll results.
> +	 * If it is not in storm mode, then the bank is only checked when
> +	 * there is a CMCI interrupt. Check how long it has been since
> +	 * this bank was last checked, and adjust the amount of "shift"
> +	 * to apply to history.
> +	 */
> +	if (!storm->banks[mce->bank].storm) {

Yeah, if this were

	if (!storm->banks[mce->bank].in_storm_mode)

it would've been perfectly clear what the condition tests.

> +		delta = now - storm->banks[mce->bank].timestamp;
> +		shift = (delta + HZ) / HZ;
> +	}
> +
> +	/* If it has been a long time since the last poll, clear history. */
> +	if (shift < 64)

Use a properly named define instead of a naked number.

...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
