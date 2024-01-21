Return-Path: <linux-kernel+bounces-32125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A00B78356C9
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 17:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2B0D281C53
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 16:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E014937716;
	Sun, 21 Jan 2024 16:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VkAzxHO0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8pTsA3Ru"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE83B376F2
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 16:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705856300; cv=none; b=Ph5HwKBDg1gwubPabuWev6pvwCoe4JsiIB+B/O3k1SqhshwiNvt+namrG8IXCMFwbCqvXQfdqE+6bQdC6b8D0djFYHRApJlx71nucAaQ7wH5lzIHN+j2bBpeFtH2qLsycpX2kJ/s9rQ/RkHVRFaBekCH/565XPJ1jSRibLptmKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705856300; c=relaxed/simple;
	bh=YWvFpNEi5WR+SXNlviuBw5sUUItlqOe2NuwW+0eMfKY=;
	h=From:To:Cc:Subject:Message-ID:Content-Type:MIME-Version:Date; b=RVxPUeJg/5I+2qUIB2eVYuqTrYiYMaAjp2FN6DmV2m7KscYwr8V70KZHqV5eeVmelpMbbNQs53Sl7UrHXlb7feXpVwlK8G3/FQySzq/IBsfRQGxB9DJ9vsqYmAtHaWtdaU7kX+Ccl4eASII/tOI9JvSx3mTz2Wi6nbo+4tOQK+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VkAzxHO0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8pTsA3Ru; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705856291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=f+7cdUkenFaUBE5S8J6wjP4HQaY0iZlm6kwrMqAJhjk=;
	b=VkAzxHO0XF9OZeDwyZ2o5kn9m+N+7GsHtqbAnsPOcYOkKBBOyK8eqGER9OqQw3eR7kvMqv
	Ktabb4zszPk36HhOZFUtbxkwbgMTihKjFbac+Qm6UJSw81PKn3hNlfjhRzmTgSrRixbsoU
	Ramf2ESBkXf759/IOoa5U2OP6Nk4bz3f9oJ7ipLulanqHs+SIHEt+iDGSeTF+obAHn4UFl
	7CHwfiXWzxSl4Os8QJlkCltPFwSKX8nhrQVwQTxNe/sgUIy5Bma3s8b1K97G7Blrvs3BtW
	YIZBgXL2/OD4BZ6K5R00Hv2ww9kTuWlMfF3Krb+eMhwccsysMYiVtjoe3wL9Hg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705856291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=f+7cdUkenFaUBE5S8J6wjP4HQaY0iZlm6kwrMqAJhjk=;
	b=8pTsA3RuEtcH6orixPwCbHjArrnLdI8d23zfi3LYT/CiNZkpB33qIP+00dWcIuBnC2h+oH
	NZ8rBG53rV14eABw==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] timers/core for v6.8-rc1
Message-ID: <170585625183.1573913.4183642933597906500.tglx@xen13.fritz.box>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 21 Jan 2024 17:58:10 +0100 (CET)

Linus,

please pull the latest timers/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2024=
-01-21

up to:  71fee48fb772: tick-sched: Fix idle and iowait sleeptime accounting vs=
 CPU hotplug


Updates for time and clocksources:

  - A fix for the idle and iowait time accounting vs. CPU hotplug.
    The time is reset on CPU hotplug which makes the accumulated
    systemwide time jump backwards.

 - Assorted fixes and improvements for clocksource/event drivers

Thanks,

	tglx

------------------>
Arnd Bergmann (1):
      clocksource/drivers/ep93xx: Fix error handling during probe

Heiko Carstens (1):
      tick-sched: Fix idle and iowait sleeptime accounting vs CPU hotplug

Inochi Amaoto (1):
      dt-bindings: timer: thead,c900-aclint-mtimer: separate mtime and mtimec=
mp regs

Joshua Yeong (1):
      clocksource/timer-riscv: Add riscv_clock_shutdown callback

Randy Dunlap (1):
      clocksource/drivers/cadence-ttc: Fix some kernel-doc warnings

Sia Jee Heng (1):
      dt-bindings: timer: Add StarFive JH8100 clint

Tony Lindgren (1):
      clocksource/drivers/timer-ti-dm: Fix make W=3Dn kerneldoc warnings


 .../devicetree/bindings/timer/sifive,clint.yaml    |  1 +
 .../bindings/timer/thead,c900-aclint-mtimer.yaml   |  9 ++++++++-
 drivers/clocksource/timer-cadence-ttc.c            | 22 ++++++++++++++++----=
--
 drivers/clocksource/timer-ep93xx.c                 |  5 ++---
 drivers/clocksource/timer-riscv.c                  |  7 +++++++
 drivers/clocksource/timer-ti-dm.c                  |  4 ++--
 kernel/time/tick-sched.c                           |  5 +++++
 7 files changed, 41 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/Docu=
mentation/devicetree/bindings/timer/sifive,clint.yaml
index e8be6c470364..01254261e156 100644
--- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
+++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
@@ -33,6 +33,7 @@ properties:
               - sifive,fu540-c000-clint # SiFive FU540
               - starfive,jh7100-clint   # StarFive JH7100
               - starfive,jh7110-clint   # StarFive JH7110
+              - starfive,jh8100-clint   # StarFive JH8100
           - const: sifive,clint0        # SiFive CLINT v0 IP block
       - items:
           - enum:
diff --git a/Documentation/devicetree/bindings/timer/thead,c900-aclint-mtimer=
yaml b/Documentation/devicetree/bindings/timer/thead,c900-aclint-mtimer.yaml
index fbd235650e52..2e92bcdeb423 100644
--- a/Documentation/devicetree/bindings/timer/thead,c900-aclint-mtimer.yaml
+++ b/Documentation/devicetree/bindings/timer/thead,c900-aclint-mtimer.yaml
@@ -17,7 +17,12 @@ properties:
       - const: thead,c900-aclint-mtimer
=20
   reg:
-    maxItems: 1
+    items:
+      - description: MTIMECMP Registers
+
+  reg-names:
+    items:
+      - const: mtimecmp
=20
   interrupts-extended:
     minItems: 1
@@ -28,6 +33,7 @@ additionalProperties: false
 required:
   - compatible
   - reg
+  - reg-names
   - interrupts-extended
=20
 examples:
@@ -39,5 +45,6 @@ examples:
                             <&cpu3intc 7>,
                             <&cpu4intc 7>;
       reg =3D <0xac000000 0x00010000>;
+      reg-names =3D "mtimecmp";
     };
 ...
diff --git a/drivers/clocksource/timer-cadence-ttc.c b/drivers/clocksource/ti=
mer-cadence-ttc.c
index 32daaac9b132..ca7a06489c40 100644
--- a/drivers/clocksource/timer-cadence-ttc.c
+++ b/drivers/clocksource/timer-cadence-ttc.c
@@ -69,7 +69,7 @@
  * @base_addr:	Base address of timer
  * @freq:	Timer input clock frequency
  * @clk:	Associated clock source
- * @clk_rate_change_nb	Notifier block for clock rate changes
+ * @clk_rate_change_nb:	Notifier block for clock rate changes
  */
 struct ttc_timer {
 	void __iomem *base_addr;
@@ -134,7 +134,7 @@ static void ttc_set_interval(struct ttc_timer *timer,
  * @irq:	IRQ number of the Timer
  * @dev_id:	void pointer to the ttc_timer instance
  *
- * returns: Always IRQ_HANDLED - success
+ * Returns: Always IRQ_HANDLED - success
  **/
 static irqreturn_t ttc_clock_event_interrupt(int irq, void *dev_id)
 {
@@ -151,8 +151,9 @@ static irqreturn_t ttc_clock_event_interrupt(int irq, voi=
d *dev_id)
=20
 /**
  * __ttc_clocksource_read - Reads the timer counter register
+ * @cs: &clocksource to read from
  *
- * returns: Current timer counter register value
+ * Returns: Current timer counter register value
  **/
 static u64 __ttc_clocksource_read(struct clocksource *cs)
 {
@@ -173,7 +174,7 @@ static u64 notrace ttc_sched_clock_read(void)
  * @cycles:	Timer interval ticks
  * @evt:	Address of clock event instance
  *
- * returns: Always 0 - success
+ * Returns: Always %0 - success
  **/
 static int ttc_set_next_event(unsigned long cycles,
 					struct clock_event_device *evt)
@@ -186,9 +187,12 @@ static int ttc_set_next_event(unsigned long cycles,
 }
=20
 /**
- * ttc_set_{shutdown|oneshot|periodic} - Sets the state of timer
- *
+ * ttc_shutdown - Sets the state of timer
  * @evt:	Address of clock event instance
+ *
+ * Used for shutdown or oneshot.
+ *
+ * Returns: Always %0 - success
  **/
 static int ttc_shutdown(struct clock_event_device *evt)
 {
@@ -202,6 +206,12 @@ static int ttc_shutdown(struct clock_event_device *evt)
 	return 0;
 }
=20
+/**
+ * ttc_set_periodic - Sets the state of timer
+ * @evt:	Address of clock event instance
+ *
+ * Returns: Always %0 - success
+ */
 static int ttc_set_periodic(struct clock_event_device *evt)
 {
 	struct ttc_timer_clockevent *ttce =3D to_ttc_timer_clkevent(evt);
diff --git a/drivers/clocksource/timer-ep93xx.c b/drivers/clocksource/timer-e=
p93xx.c
index bc0ca6e12334..6981ff3ac8a9 100644
--- a/drivers/clocksource/timer-ep93xx.c
+++ b/drivers/clocksource/timer-ep93xx.c
@@ -155,9 +155,8 @@ static int __init ep93xx_timer_of_init(struct device_node=
 *np)
 	ep93xx_tcu =3D tcu;
=20
 	irq =3D irq_of_parse_and_map(np, 0);
-	if (irq =3D=3D 0)
-		irq =3D -EINVAL;
-	if (irq < 0) {
+	if (!irq) {
+		ret =3D -EINVAL;
 		pr_err("EP93XX Timer Can't parse IRQ %d", irq);
 		goto out_free;
 	}
diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-ri=
scv.c
index 57857c0dfba9..e66dcbd66566 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -61,12 +61,19 @@ static int riscv_clock_next_event(unsigned long delta,
 	return 0;
 }
=20
+static int riscv_clock_shutdown(struct clock_event_device *evt)
+{
+	riscv_clock_event_stop();
+	return 0;
+}
+
 static unsigned int riscv_clock_event_irq;
 static DEFINE_PER_CPU(struct clock_event_device, riscv_clock_event) =3D {
 	.name			=3D "riscv_timer_clockevent",
 	.features		=3D CLOCK_EVT_FEAT_ONESHOT,
 	.rating			=3D 100,
 	.set_next_event		=3D riscv_clock_next_event,
+	.set_state_shutdown	=3D riscv_clock_shutdown,
 };
=20
 /*
diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti=
-dm.c
index 5f60f6bd3386..56acf2617262 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -183,7 +183,7 @@ static inline u32 dmtimer_read(struct dmtimer *timer, u32=
 reg)
  * dmtimer_write - write timer registers in posted and non-posted mode
  * @timer:      timer pointer over which write operation is to perform
  * @reg:        lowest byte holds the register offset
- * @value:      data to write into the register
+ * @val:        data to write into the register
  *
  * The posted mode bit is encoded in reg. Note that in posted mode, the write
  * pending bit must be checked. Otherwise a write on a register which has a
@@ -949,7 +949,7 @@ static int omap_dm_timer_set_int_enable(struct omap_dm_ti=
mer *cookie,
=20
 /**
  * omap_dm_timer_set_int_disable - disable timer interrupts
- * @timer:	pointer to timer handle
+ * @cookie:	pointer to timer cookie
  * @mask:	bit mask of interrupts to be disabled
  *
  * Disables the specified timer interrupts for a timer.
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index a17d26002831..d2501673028d 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1576,13 +1576,18 @@ void tick_setup_sched_timer(void)
 void tick_cancel_sched_timer(int cpu)
 {
 	struct tick_sched *ts =3D &per_cpu(tick_cpu_sched, cpu);
+	ktime_t idle_sleeptime, iowait_sleeptime;
=20
 # ifdef CONFIG_HIGH_RES_TIMERS
 	if (ts->sched_timer.base)
 		hrtimer_cancel(&ts->sched_timer);
 # endif
=20
+	idle_sleeptime =3D ts->idle_sleeptime;
+	iowait_sleeptime =3D ts->iowait_sleeptime;
 	memset(ts, 0, sizeof(*ts));
+	ts->idle_sleeptime =3D idle_sleeptime;
+	ts->iowait_sleeptime =3D iowait_sleeptime;
 }
 #endif
=20


