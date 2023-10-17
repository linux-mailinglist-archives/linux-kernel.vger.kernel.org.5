Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEC37CC8BF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 18:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343507AbjJQQ14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 12:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjJQQ1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 12:27:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8517AF1;
        Tue, 17 Oct 2023 09:27:50 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697560068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=lfHOTyBZhmqEi9ACy3JbB6tdjyLchlUMu4qxcvGrHmg=;
        b=17P0K36nCt0H71Gm6ZP4tBHbSJlWXbB8Sdv0V542K/o3/FZ4wTLoIOuu095D52/kHkaMth
        UlOiw2uyv4EQV5oJ8r/+hOq0aj1yF0rjj9/ne/bjxUMg/tH8HMUt1TfO3ENqzOyr3+bvXD
        8KspHKHCkGZIdARR+yYzv+1isZEHaQ8pVKtQBw1HHmIFMjVJWKbn/4lvjbtHbp6w856zCA
        a5+IfwN10orKGHpzJLwXKs1ncboqNetbqkXfI/P4R1/Ph9RCEg86+oK1zAtWLibsJyWENK
        Cx0SDeOOGVr8zoPAbN5bJJgKYVSeghWfh+nm/pgYZ6bXNdGMfu/qb0sh9FSpLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697560068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=lfHOTyBZhmqEi9ACy3JbB6tdjyLchlUMu4qxcvGrHmg=;
        b=seYJ6PHalH4yQMCOGJIjmS6y1ghNYXx2GBdfMCrDZefCcFSmX8RV6FmkJOTR6LmGRkOvJK
        zXxAFBiUU5xjQgCQ==
To:     lakshmi.sowjanya.d@intel.com, jstultz@google.com,
        giometti@enneenne.com, corbet@lwn.net, linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, linux-doc@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, eddie.dong@intel.com,
        christopher.s.hall@intel.com, pandith.n@intel.com,
        mallikarjunappa.sangannavar@intel.com, thejesh.reddy.t.r@intel.com,
        lakshmi.sowjanya.d@intel.com,
        Peter Hilber <peter.hilber@opensynergy.com>
Subject: Re: [PATCH v1 4/6] pps: generators: Add PPS Generator TIO Driver
In-Reply-To: <20231017052457.25287-5-lakshmi.sowjanya.d@intel.com>
Date:   Tue, 17 Oct 2023 18:27:48 +0200
Message-ID: <87lec15i4b.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17 2023 at 10:54, lakshmi.sowjanya.d@intel.com wrote:
> +
> +static inline ktime_t first_event(struct pps_tio *tio)
> +{
> +	struct timespec64 ts;
> +
> +	ktime_get_real_ts64(&ts);
> +
> +	return ktime_set(ts.tv_sec + 1, NSEC_PER_SEC - PREP_INTERVAL_NS);

        return ktime_set(ktime_get_real_seconds() + 1, MAGIC_CONSTANT);

Perhaps?

PREP_INTERVAL_NS is a misnomer as it has nothing to do with an
interval. It's the time substracted from the actual pulse target time to
allow the hrtimer callback to setup the hardware for the pulse.

Naming matters really.

> +static int translate_system_time_to_art_cycles(struct timespec64 ts, u64 *art_timestamp,
> +					       bool *real_to_tsc_result)
> +{
> +	struct system_counterval_t sys_counter;
> +	ktime_t sys_realtime;
> +	int err;
> +
> +	sys_realtime = timespec64_to_ktime(ts);

Why are you handing timespecs around? Because timespec math is so
awesome, right?

> +	err = ktime_convert_real_to_system_counter(sys_realtime, &sys_counter);
> +	if (err) {
> +		*real_to_tsc_result = true;

This makes my bad taste sensors reach saturation.

> +		return err;
> +	}
> +
> +	return convert_tsc_to_art(&sys_counter, art_timestamp);
> +}

> +static int pps_tio_generate_output(struct pps_tio *tio, struct timespec64 time)
> +{
> +	bool real_to_tsc_result;
> +	u64 art_timestamp;
> +	int err;
> +
> +	real_to_tsc_result = false;
> +	err = translate_system_time_to_art_cycles(time, &art_timestamp, &real_to_tsc_result);
> +	if (err) {
> +		pps_tio_disable(tio);
> +		dev_err(tio->dev, "Disabling PPS due to failure in conversion of %s",
> +			real_to_tsc_result ? "realtime to system_counter" : "tsc to art");
> +		return err;

Clearly nothing in the call chain cares about the actual error code,
right? So instead of having all these undocumented -E* all over the
place, just make the inner functions bool and then only for
translate_system_time_to_art_cycles() use

enum {
	SUCCESS,
        FAIL_SC,
        FAIL_ART,
};

or something like that to make this error printout happy.

pps_tio_generate_output() itself can return bool too.

> +	}
> +	/* The timed IO hardware adds a two cycle delay on output */
> +	art_timestamp -= 2;
> +	pps_compv_write(tio, art_timestamp);
> +
> +	return 0;
> +}
> +
> +static int schedule_event(struct hrtimer *timer, struct timespec64 *next_event)
> +{
> +	struct pps_tio *tio = container_of(timer, struct pps_tio, timer);
> +	struct timespec64 expire_time, cur_time, roundoff;
> +	long half_sec_ns = NSEC_PER_SEC / 2;
> +
> +	/* get the current time */
> +	ktime_get_real_ts64(&cur_time);
> +	expire_time = ktime_to_timespec64(hrtimer_get_softexpires(timer));
> +
> +	/*
> +	 * Figure out if it is in "top half" or "bottom half" of the second
> +	 * and round-off to the nearest 500ms
> +	 */
> +	if (cur_time.tv_nsec > half_sec_ns) {
> +		roundoff.tv_sec = cur_time.tv_sec + 1;
> +		roundoff.tv_nsec = 0;
> +		next_event->tv_sec = roundoff.tv_sec;
> +		next_event->tv_nsec = half_sec_ns;
> +	} else {
> +		roundoff.tv_sec = cur_time.tv_sec;
> +		roundoff.tv_nsec = half_sec_ns;
> +		next_event->tv_sec = roundoff.tv_sec;
> +		next_event->tv_nsec = roundoff.tv_nsec + half_sec_ns;
> +	}
> +	next_event->tv_nsec -= PREP_INTERVAL_NS;
> +	/* Check for elapsed time */
> +	if (expire_time.tv_sec != cur_time.tv_sec ||
> +	    (cur_time.tv_nsec - PREP_INTERVAL_NS) > expire_time.tv_nsec) {

The timer is considered on time when cur_time <= T_pulse?

How do you ensure that there is enough time to actually convert and arm
the timer? Not at all. If cur_time is close to T_pulse then you end up
arming it late.

> +		dev_warn(tio->dev, "Time expired, edge not scheduled at time: %lld.%09ld\n",
> +			 cur_time.tv_sec, cur_time.tv_nsec);
> +		return 0;
> +	}
> +
> +	return pps_tio_generate_output(tio, roundoff);
> +}
> +
> +static enum hrtimer_restart hrtimer_callback(struct hrtimer *timer)
> +{
> +	struct pps_tio *tio = container_of(timer, struct pps_tio, timer);
> +	struct timespec64 next_event;
> +	int err = 0;
> +
> +	scoped_guard(spinlock_irqsave, &tio->lock) {
> +		if (tio->enabled)
> +			err = schedule_event(timer, &next_event);
> +	}
> +	if (err)
> +		return HRTIMER_NORESTART;
> +
> +	hrtimer_set_expires(timer, ktime_set(next_event.tv_sec, next_event.tv_nsec));
> +	return HRTIMER_RESTART;

All of this is overengineered complexity. Initially you start the
hrtimer with

	hrtimer_start(&tio->timer, first_event(tio), HRTIMER_MODE_ABS);

and that sets the first event to expire TPREP_NS before the full
second. After that you want to schedule the timer periodically every
0.5s, right?

hrtimers provide periodic schedule already. So all of the gunk above
can be replaced with:

static enum hrtimer_restart hrtimer_callback(struct hrtimer *timer)
{
	struct pps_tio *tio = container_of(timer, struct pps_tio, timer);
        ktime_t expires, now;

        guard(spinlock)(&tio->lock);

	expires = hrtimer_get_expires(timer);
	now = ktime_get_real();

	if (now - expires < TOO_LATE) {
        	if (!pps_arm_next_pulse(tio, expires + TPREP_NS))
                	return HRTIMER_NORESTART;
	}

	hrtimer_forward(timer, now, NSEC_PER_SEC / 2);
       	return HRTIMER_RESTART;
}
      
and

static bool pps_arm_next_pulse(struct pps_tio *tio, ktime_t expires)
{
	u64 art;

	if (!ktime_real_to_base_clock(expires, CSID_X86_ART, &art))
        	return false;

	pps_compv_write(tio, art - ART_HW_DELAY_CYCLES);
        return true;
}

ktime_real_to_base_clock() does not exist, but that's the function you
really want to have.

Not this convoluted construct of indirections and therefore we need to
rethink the whole related clock mechanism from ground up.

As I said vs. patch 3/6 already this smells badly of the wrong
abstractions and data representations. So this needs to be fixed first
instead of adding several layers of duct tape.

> +static ssize_t enable_store(struct device *dev, struct device_attribute *attr, const char *buf,
> +			    size_t count)
> +{
> +	struct pps_tio *tio = dev_get_drvdata(dev);
> +	bool enable;
> +	int err;
> +
> +	err = kstrtobool(buf, &enable);
> +	if (err)
> +		return err;
> +
> +	guard(spinlock_irqsave)(&tio->lock);
> +	if (enable && !tio->enabled) {
> +		if (!is_current_clocksource_art_related()) {
> +			dev_err(tio->dev, "PPS cannot be started as clock is not related to ART");
> +			return -EPERM;
> +		}

Ah. Here is the usecase for this magic patch 3/6 hackery. Again, it's
the wrong abstraction. You want something like:

    timekeeping_clocksource_has_base(CSID_X86_ART);

or something like this, which can be handled completely in the core
code.

All of this needs some serious rework. See the below disfunctional
mockup patch for illustration.

There is also a patch series, which tried to replace the clocksource
pointer in system_counterval_t with a clocksource ID:

  https://lore.kernel.org/all/20230818011256.211078-1-peter.hilber@opensynergy.com

That went nowhere, but has some valid points. I took some of Peter's (cc'ed)
ideas into the mockup, but did it slightly different to make all of this
indirection mess go away.

There are certainly bugs and thinkos in that mockup. If you find them,
you can keep and fix them :)

Thanks,

        tglx
---
 arch/x86/include/asm/tsc.h                        |    3 
 arch/x86/kernel/kvmclock.c                        |    1 
 arch/x86/kernel/tsc.c                             |   78 ++--------------
 drivers/clocksource/arm_arch_timer.c              |    7 -
 drivers/net/ethernet/intel/e1000e/ptp.c           |    3 
 drivers/net/ethernet/intel/ice/ice_ptp.c          |    4 
 drivers/net/ethernet/intel/igc/igc_ptp.c          |    8 +
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c |    3 
 drivers/ptp/ptp_kvm_common.c                      |    9 -
 drivers/ptp/ptp_kvm_x86.c                         |    5 -
 include/linux/clocksource.h                       |   24 +++++
 include/linux/clocksource_ids.h                   |    3 
 include/linux/ptp_kvm.h                           |    3 
 include/linux/timekeeping.h                       |    8 +
 kernel/time/timekeeping.c                         |  103 ++++++++++++++++++++--
 sound/pci/hda/hda_controller.c                    |    3 
 16 files changed, 169 insertions(+), 96 deletions(-)

--- a/arch/x86/include/asm/tsc.h
+++ b/arch/x86/include/asm/tsc.h
@@ -27,9 +27,6 @@ static inline cycles_t get_cycles(void)
 }
 #define get_cycles get_cycles
 
-extern struct system_counterval_t convert_art_to_tsc(u64 art);
-extern struct system_counterval_t convert_art_ns_to_tsc(u64 art_ns);
-
 extern void tsc_early_init(void);
 extern void tsc_init(void);
 extern void mark_tsc_unstable(char *reason);
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -157,6 +157,7 @@ static int kvm_cs_enable(struct clocksou
 struct clocksource kvm_clock = {
 	.name	= "kvm-clock",
 	.read	= kvm_clock_get_cycles,
+	.cs_id	= CSID_X86_KVM_CLK,
 	.rating	= 400,
 	.mask	= CLOCKSOURCE_MASK(64),
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -50,9 +50,13 @@ int tsc_clocksource_reliable;
 
 static int __read_mostly tsc_force_recalibrate;
 
+static struct clocksource_base art_base_clk = {
+	.id	= CSID_X86_ART,
+};
+
 static u32 art_to_tsc_numerator;
 static u32 art_to_tsc_denominator;
-static u64 art_to_tsc_offset;
+static u64 art_base_clk.offset;
 static struct clocksource *art_related_clocksource;
 
 struct cyc2ns {
@@ -1089,13 +1093,13 @@ static void __init detect_art(void)
 	    tsc_async_resets)
 		return;
 
-	cpuid(ART_CPUID_LEAF, &art_to_tsc_denominator,
-	      &art_to_tsc_numerator, unused, unused+1);
+	cpuid(ART_CPUID_LEAF, &art_base_clk.denominator,
+	      &art_base_clk.numerator, &art_base_clk.freq_khz, unused+1);
 
-	if (art_to_tsc_denominator < ART_MIN_DENOMINATOR)
+	if (art_base_clk.denominator < ART_MIN_DENOMINATOR)
 		return;
 
-	rdmsrl(MSR_IA32_TSC_ADJUST, art_to_tsc_offset);
+	rdmsrl(MSR_IA32_TSC_ADJUST, art_base_clk.offset);
 
 	/* Make this sticky over multiple CPU init calls */
 	setup_force_cpu_cap(X86_FEATURE_ART);
@@ -1190,6 +1194,7 @@ static struct clocksource clocksource_ts
 				  CLOCK_SOURCE_VALID_FOR_HRES |
 				  CLOCK_SOURCE_MUST_VERIFY |
 				  CLOCK_SOURCE_VERIFY_PERCPU,
+	.id			= CSID_X86_TSC,
 	.vdso_clock_mode	= VDSO_CLOCKMODE_TSC,
 	.enable			= tsc_cs_enable,
 	.resume			= tsc_resume,
@@ -1294,65 +1299,6 @@ int unsynchronized_tsc(void)
 	return 0;
 }
 
-/*
- * Convert ART to TSC given numerator/denominator found in detect_art()
- */
-struct system_counterval_t convert_art_to_tsc(u64 art)
-{
-	u64 tmp, res, rem;
-
-	rem = do_div(art, art_to_tsc_denominator);
-
-	res = art * art_to_tsc_numerator;
-	tmp = rem * art_to_tsc_numerator;
-
-	do_div(tmp, art_to_tsc_denominator);
-	res += tmp + art_to_tsc_offset;
-
-	return (struct system_counterval_t) {.cs = art_related_clocksource,
-			.cycles = res};
-}
-EXPORT_SYMBOL(convert_art_to_tsc);
-
-/**
- * convert_art_ns_to_tsc() - Convert ART in nanoseconds to TSC.
- * @art_ns: ART (Always Running Timer) in unit of nanoseconds
- *
- * PTM requires all timestamps to be in units of nanoseconds. When user
- * software requests a cross-timestamp, this function converts system timestamp
- * to TSC.
- *
- * This is valid when CPU feature flag X86_FEATURE_TSC_KNOWN_FREQ is set
- * indicating the tsc_khz is derived from CPUID[15H]. Drivers should check
- * that this flag is set before conversion to TSC is attempted.
- *
- * Return:
- * struct system_counterval_t - system counter value with the pointer to the
- *	corresponding clocksource
- *	@cycles:	System counter value
- *	@cs:		Clocksource corresponding to system counter value. Used
- *			by timekeeping code to verify comparability of two cycle
- *			values.
- */
-
-struct system_counterval_t convert_art_ns_to_tsc(u64 art_ns)
-{
-	u64 tmp, res, rem;
-
-	rem = do_div(art_ns, USEC_PER_SEC);
-
-	res = art_ns * tsc_khz;
-	tmp = rem * tsc_khz;
-
-	do_div(tmp, USEC_PER_SEC);
-	res += tmp;
-
-	return (struct system_counterval_t) { .cs = art_related_clocksource,
-					      .cycles = res};
-}
-EXPORT_SYMBOL(convert_art_ns_to_tsc);
-
-
 static void tsc_refine_calibration_work(struct work_struct *work);
 static DECLARE_DELAYED_WORK(tsc_irqwork, tsc_refine_calibration_work);
 /**
@@ -1454,8 +1400,10 @@ static void tsc_refine_calibration_work(
 	if (tsc_unstable)
 		goto unreg;
 
-	if (boot_cpu_has(X86_FEATURE_ART))
+	if (boot_cpu_has(X86_FEATURE_ART)) {
 		art_related_clocksource = &clocksource_tsc;
+		clocksource_tsc.base_clk = &art_base_clk;
+	}
 	clocksource_register_khz(&clocksource_tsc, tsc_khz);
 unreg:
 	clocksource_unregister(&clocksource_tsc_early);
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -1784,8 +1784,7 @@ static int __init arch_timer_acpi_init(s
 TIMER_ACPI_DECLARE(arch_timer, ACPI_SIG_GTDT, arch_timer_acpi_init);
 #endif
 
-int kvm_arch_ptp_get_crosststamp(u64 *cycle, struct timespec64 *ts,
-				 struct clocksource **cs)
+int kvm_arch_ptp_get_crosststamp(u64 *cycle, struct timespec64 *ts, int cs_id)
 {
 	struct arm_smccc_res hvc_res;
 	u32 ptp_counter;
@@ -1809,8 +1808,8 @@ int kvm_arch_ptp_get_crosststamp(u64 *cy
 	*ts = ktime_to_timespec64(ktime);
 	if (cycle)
 		*cycle = (u64)hvc_res.a2 << 32 | hvc_res.a3;
-	if (cs)
-		*cs = &clocksource_counter;
+	if (cs_id)
+		*cs_id = clocksource_counter.id;
 
 	return 0;
 }
--- a/drivers/net/ethernet/intel/e1000e/ptp.c
+++ b/drivers/net/ethernet/intel/e1000e/ptp.c
@@ -124,7 +124,8 @@ static int e1000e_phc_get_syncdevicetime
 	sys_cycles = er32(PLTSTMPH);
 	sys_cycles <<= 32;
 	sys_cycles |= er32(PLTSTMPL);
-	*system = convert_art_to_tsc(sys_cycles);
+	system->cycles = sys_cycles;
+	system->cs_id = CSID_X86_ART;
 
 	return 0;
 }
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1989,6 +1989,8 @@ ice_ptp_get_syncdevicetime(ktime_t *devi
 	wr32(hw, GLHH_ART_CTL, hh_art_ctl);
 
 #define MAX_HH_LOCK_TRIES 100
+	system->cs_id = CSID_X86_ART;
+	system->nsecs = true;
 
 	for (i = 0; i < MAX_HH_LOCK_TRIES; i++) {
 		/* Wait for sync to complete */
@@ -2005,7 +2007,7 @@ ice_ptp_get_syncdevicetime(ktime_t *devi
 			hh_ts_lo = rd32(hw, GLHH_ART_TIME_L);
 			hh_ts_hi = rd32(hw, GLHH_ART_TIME_H);
 			hh_ts = ((u64)hh_ts_hi << 32) | hh_ts_lo;
-			*system = convert_art_ns_to_tsc(hh_ts);
+			system->cycles = hh_ts;
 			/* Read Device source clock time */
 			hh_ts_lo = rd32(hw, GLTSYN_HHTIME_L(tmr_idx));
 			hh_ts_hi = rd32(hw, GLTSYN_HHTIME_H(tmr_idx));
--- a/drivers/net/ethernet/intel/igc/igc_ptp.c
+++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
@@ -911,7 +911,13 @@ static bool igc_is_crosststamp_supported
 static struct system_counterval_t igc_device_tstamp_to_system(u64 tstamp)
 {
 #if IS_ENABLED(CONFIG_X86_TSC) && !defined(CONFIG_UML)
-	return convert_art_ns_to_tsc(tstamp);
+	// FIXME: How has this ensured that ART exists?
+	return (struct system_counterval_t) {
+		.cs_id	= CSID_X86_ART,
+		.cycles	= tstamp,
+		.nsecs	= true,
+	};
+
 #else
 	return (struct system_counterval_t) { };
 #endif
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
@@ -390,10 +390,11 @@ static int intel_crosststamp(ktime_t *de
 		*device = ns_to_ktime(ptp_time);
 		read_unlock_irqrestore(&priv->ptp_lock, flags);
 		get_arttime(priv->mii, intel_priv->mdio_adhoc_addr, &art_time);
-		*system = convert_art_to_tsc(art_time);
+		system->cycles = art_time;
 	}
 
 	system->cycles *= intel_priv->crossts_adj;
+	system->cs_id = CSID_X86_ART;
 	priv->plat->flags &= ~STMMAC_FLAG_INT_SNAPSHOT_EN;
 
 	return 0;
--- a/drivers/ptp/ptp_kvm_common.c
+++ b/drivers/ptp/ptp_kvm_common.c
@@ -28,15 +28,14 @@ static int ptp_kvm_get_time_fn(ktime_t *
 			       struct system_counterval_t *system_counter,
 			       void *ctx)
 {
-	long ret;
-	u64 cycle;
 	struct timespec64 tspec;
-	struct clocksource *cs;
+	int ret, cs_id;
+	u64 cycle;
 
 	spin_lock(&kvm_ptp_lock);
 
 	preempt_disable_notrace();
-	ret = kvm_arch_ptp_get_crosststamp(&cycle, &tspec, &cs);
+	ret = kvm_arch_ptp_get_crosststamp(&cycle, &tspec, &cs_id);
 	if (ret) {
 		spin_unlock(&kvm_ptp_lock);
 		preempt_enable_notrace();
@@ -46,7 +45,7 @@ static int ptp_kvm_get_time_fn(ktime_t *
 	preempt_enable_notrace();
 
 	system_counter->cycles = cycle;
-	system_counter->cs = cs;
+	system_counter->cs_id = cs_id;
 
 	*device_time = timespec64_to_ktime(tspec);
 
--- a/drivers/ptp/ptp_kvm_x86.c
+++ b/drivers/ptp/ptp_kvm_x86.c
@@ -92,8 +92,7 @@ int kvm_arch_ptp_get_clock(struct timesp
 	return 0;
 }
 
-int kvm_arch_ptp_get_crosststamp(u64 *cycle, struct timespec64 *tspec,
-			      struct clocksource **cs)
+int kvm_arch_ptp_get_crosststamp(u64 *cycle, struct timespec64 *tspec, int *cs_id)
 {
 	struct pvclock_vcpu_time_info *src;
 	unsigned int version;
@@ -123,7 +122,7 @@ int kvm_arch_ptp_get_crosststamp(u64 *cy
 		*cycle = __pvclock_read_cycles(src, clock_pair->tsc);
 	} while (pvclock_read_retry(src, version));
 
-	*cs = &kvm_clock;
+	*cs_id = kvm_clock.id;
 
 	return 0;
 }
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -21,6 +21,7 @@
 #include <asm/div64.h>
 #include <asm/io.h>
 
+struct clocksource_base;
 struct clocksource;
 struct module;
 
@@ -70,6 +71,7 @@ struct module;
  *			validate the clocksource from which the snapshot was
  *			taken.
  * @flags:		Flags describing special properties
+ * @base_clk:		Optional pointer to an underlying base clock
  * @enable:		Optional function to enable the clocksource
  * @disable:		Optional function to disable the clocksource
  * @suspend:		Optional suspend function for the clocksource
@@ -111,6 +113,7 @@ struct clocksource {
 	enum clocksource_ids	id;
 	enum vdso_clock_mode	vdso_clock_mode;
 	unsigned long		flags;
+	struct clocksource_base	*base_clk;
 
 	int			(*enable)(struct clocksource *cs);
 	void			(*disable)(struct clocksource *cs);
@@ -294,4 +297,25 @@ static inline void timer_probe(void) {}
 extern ulong max_cswd_read_retries;
 void clocksource_verify_percpu(struct clocksource *cs);
 
+/**
+ * struct clocksource_base - hardware abstraction for clock on which a clocksource is based
+ * @id:			Defaults to CSID_GENERIC. The id value is used for conversion
+ *			functions which require that the current clocksource is based
+ *			on a clocksource_base with a particular ID
+ *			in certain snapshot functions to allow callers to
+ *			validate the clocksource from which the snapshot was
+ *			taken.
+ * @freq_khz:		Nominal frequency of the base clock in kHz
+ * @offset:		Offset between the base clock and the clocksource
+ * @numerator:		Numerator of the clock ratio between base clock and the clocksource
+ * @denominator:	Denominator of the clock ratio between base clock and the clocksource
+ */
+struct clocksource_base {
+	enum clocksource_ids	id;
+	u32			freq_khz;
+	u64			offset;
+	u32			numerator;
+	u32			denominator;
+};
+
 #endif /* _LINUX_CLOCKSOURCE_H */
--- a/include/linux/clocksource_ids.h
+++ b/include/linux/clocksource_ids.h
@@ -6,6 +6,9 @@
 enum clocksource_ids {
 	CSID_GENERIC		= 0,
 	CSID_ARM_ARCH_COUNTER,
+	CSID_X86_TSC,
+	CSID_X86_TSC_ART,
+	CSID_X86_KVM_CLK,
 	CSID_MAX,
 };
 
--- a/include/linux/ptp_kvm.h
+++ b/include/linux/ptp_kvm.h
@@ -16,7 +16,6 @@ struct clocksource;
 int kvm_arch_ptp_init(void);
 void kvm_arch_ptp_exit(void);
 int kvm_arch_ptp_get_clock(struct timespec64 *ts);
-int kvm_arch_ptp_get_crosststamp(u64 *cycle,
-		struct timespec64 *tspec, struct clocksource **cs);
+int kvm_arch_ptp_get_crosststamp(u64 *cycle, struct timespec64 *tspec, int csid);
 
 #endif /* _PTP_KVM_H_ */
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -270,12 +270,14 @@ struct system_device_crosststamp {
  * struct system_counterval_t - system counter value with the pointer to the
  *				corresponding clocksource
  * @cycles:	System counter value
- * @cs:		Clocksource corresponding to system counter value. Used by
- *		timekeeping code to verify comparibility of two cycle values
+ * @cs_id:	Clocksource ID. Either the ID of the current clocksource
+ *		or the ID of a clocksource base.
+ * @nsecs:	@cycles is in nanoseconds
  */
 struct system_counterval_t {
 	u64			cycles;
-	struct clocksource	*cs;
+	enum clocksource_ids	cs_id;
+	bool			nsecs;
 };
 
 /*
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1191,6 +1191,78 @@ static bool cycle_between(u64 before, u6
 	return false;
 }
 
+static u64 convert_clock(u64 val, u32 numerator, u32 denominator)
+{
+	u64 rem, res;
+
+	res = div_u64_rem(val, denominator, &rem) * numerator;
+	return res + div_u64(rem * numerator, denominator);
+}
+
+static bool convert_base_to_cs(struct system_counterval_t *scv)
+{
+	struct clocksource *cs = tk_core.timekeeper.tkr_mono.clock;
+	struct clocksource_base *csb = clock->base;
+
+	/* The timestamp was taken from the time keeper clock source */
+	if (cs->id == scv->cs_id)
+		return true;
+
+	/* Check whether cs_id matches the base clock */
+	if (!base || base->id != scv->cs_id)
+		return false;
+
+	if (scv->nsecs)
+		scv->cycles = convert_clock(scv->cycles, base->freq_khz, USEC_PER_SEC);
+
+	scv->cycles = convert_clock(scv->cycles, base->numerator, base->denominator);
+	scv->cycles += base->offset;
+	return true;
+}
+
+static bool convert_cs_to_base(u64 *cycles, enum clocksource_ids base_id)
+{
+	struct clocksource *cs = tk_core.timekeeper.tkr_mono.clock;
+	struct clocksource_base *csb = clock->base;
+
+	/* Check whether base_id matches the base clock */
+	if (!base || base->id != base_id)
+		return false;
+
+	*cycles = convert_clock(cycles - base->offset, base->denominator, base->numerator);
+	return true;
+}
+
+static u64 convert_ns_to_cs(u64 delta)
+{
+	struct tk_read *tkr = &tk_core.timekeeper.tkr_mono;
+
+	return div_u64(delta << tkr->shift, tkr->mult);
+}
+
+bool ktime_real_to_base_clock(ktime_t treal, enum clocksource_ids base_id, u64 *cycles)
+{
+	struct timekeeper *tk = &tk_core.timekeeper;
+	struct clocksource_base *csb;
+	unsigned int seq;
+	u64 delta;
+
+	do {
+		seq = read_seqcount_begin(&tk_core.seq);
+
+		delta = (u64)treal - tk->tkr_mono.base_real;
+		if (delta > tk->tkr_mono.clock->max_idle_ns)
+			return false;
+
+		*cycles = tk->tkr_mono.cycle_last + convert_ns_to_cs(delta);
+		if (!convert_cs_to_base(cycles, base_id))
+			return false;
+
+	} while (read_seqcount_retry(&tk_core.seq, seq));
+
+	return true;
+}
+
 /**
  * get_device_system_crosststamp - Synchronously capture system/device timestamp
  * @get_time_fn:	Callback to get simultaneous device time and
@@ -1231,13 +1303,9 @@ int get_device_system_crosststamp(int (*
 		if (ret)
 			return ret;
 
-		/*
-		 * Verify that the clocksource associated with the captured
-		 * system counter value is the same as the currently installed
-		 * timekeeper clocksource
-		 */
-		if (tk->tkr_mono.clock != system_counterval.cs)
+		if (!convert_base_to_cs(&system_counterval))
 			return -ENODEV;
+
 		cycles = system_counterval.cycles;
 
 		/*
@@ -1304,6 +1372,29 @@ int get_device_system_crosststamp(int (*
 EXPORT_SYMBOL_GPL(get_device_system_crosststamp);
 
 /**
+ * timekeeping_clocksource_has_base - Check whether the current clocksource has a base clock
+ * @id:	The clocksource ID to check for
+ *
+ * Note: The return value is a snapshot which can become invalid right
+ *	 after the function returns.
+ *
+ * Returns: True if the timekeeper clocksource has a base clock with @id, false otherwise
+ */
+bool timekeeping_clocksource_has_base(enum clocksource_ids id)
+{
+	unsigned int seq;
+	bool ret;
+
+	do {
+		seq = read_seqcount_begin(&tk_core.seq);
+		ret = tk_core.timekeeper.tkr_mono.clock->base ?
+			tk_core.timekeeper.tkr_mono.clock->base.id == id : false;
+	} (read_seqcount_retry(&tk_core.seq, seq));
+
+	return ret;
+}
+
+/**
  * do_settimeofday64 - Sets the time of day.
  * @ts:     pointer to the timespec64 variable containing the new time
  *
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -457,7 +457,8 @@ static int azx_get_sync_time(ktime_t *de
 	*device = ktime_add_ns(*device, (wallclk_cycles * NSEC_PER_SEC) /
 			       ((HDA_MAX_CYCLE_VALUE + 1) * runtime->rate));
 
-	*system = convert_art_to_tsc(tsc_counter);
+	system->cycles = tsc_counter;
+	system->cs_id = CSID_X86_ART;
 
 	return 0;
 }
