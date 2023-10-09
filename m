Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5BDA7BDBE9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 14:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376546AbjJIMaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 08:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376362AbjJIM3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 08:29:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4296AF;
        Mon,  9 Oct 2023 05:29:48 -0700 (PDT)
Date:   Mon, 09 Oct 2023 12:29:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696854587;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wv0sEbLfTBqdFn88MWHtvD6hO1P7q7jCdD7P4fgMJ6U=;
        b=4FVfGXxiU4Liq8Acn1GXL6Ux5nQRasebYLtYfuqU/TpMAprwMb8NTO1E4PHzBsph5uirXs
        /L9MpzxxepgRDj/xiJLRyW4HgqaiiwXNeGb7pWVm0K0sID+zmwuBZLeq+3QDi7pHC5HDaQ
        2TJrSNvkMBjKSD2Ov9O5nhrMeQF6ut9NQR0XMvpobiDsChBgHT6fZQpUXU1wltRi92Lnhr
        UHaL55e9thk/bW+FSJ7RNGH0znhjw6tCvJlFWmzI9SYJWe1VlSLgfxXCKkWMo1RXsPqE4g
        mGmscv/eystU2CIlw3pJ9DlZ+zKH64xs6/LR4p4Z6elWn9MscanBVIM/CMvD0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696854587;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wv0sEbLfTBqdFn88MWHtvD6hO1P7q7jCdD7P4fgMJ6U=;
        b=3VD/4rtRP44AYBXjzeCiHp4HY98auBhkW+DCR3rM/teqJE8T+xUhU7dAIA4WJl+CjTVJw8
        MrTZ/8hgBwpt78Cw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode: Provide new control functions
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231002115903.377922731@linutronix.de>
References: <20231002115903.377922731@linutronix.de>
MIME-Version: 1.0
Message-ID: <169685458644.3135.12705331350380186214.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     54f1ae8f731a733f45711b71117452c098e73dc4
Gitweb:        https://git.kernel.org/tip/54f1ae8f731a733f45711b71117452c098e73dc4
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 02 Oct 2023 14:00:02 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 06 Oct 2023 15:12:24 +02:00

x86/microcode: Provide new control functions

The current all in one code is unreadable and really not suited for
adding future features like uniform loading with package or system
scope.

Provide a set of new control functions which split the handling of the
primary and secondary CPUs. These will replace the current rendezvous
all in one function in the next step. This is intentionally a separate
change because diff makes an complete unreadable mess otherwise.

So the flow separates the primary and the secondary CPUs into their own
functions which use the control field in the per CPU ucode_ctrl struct.

   primary()			secondary()
    wait_for_all()		 wait_for_all()
    apply_ucode()		 wait_for_release()
    release()			 apply_ucode()

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20231002115903.377922731@linutronix.de
---
 arch/x86/kernel/cpu/microcode/core.c | 84 +++++++++++++++++++++++++++-
 1 file changed, 84 insertions(+)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 35d37de..f755b3c 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -319,6 +319,90 @@ static bool wait_for_cpus(atomic_t *cnt)
 	return false;
 }
 
+static bool wait_for_ctrl(void)
+{
+	unsigned int timeout;
+
+	for (timeout = 0; timeout < USEC_PER_SEC; timeout++) {
+		if (this_cpu_read(ucode_ctrl.ctrl) != SCTRL_WAIT)
+			return true;
+		udelay(1);
+		if (!(timeout % 1000))
+			touch_nmi_watchdog();
+	}
+	return false;
+}
+
+static __maybe_unused void load_secondary(unsigned int cpu)
+{
+	unsigned int ctrl_cpu = this_cpu_read(ucode_ctrl.ctrl_cpu);
+	enum ucode_state ret;
+
+	/* Initial rendezvous to ensure that all CPUs have arrived */
+	if (!wait_for_cpus(&late_cpus_in)) {
+		pr_err_once("load: %d CPUs timed out\n", atomic_read(&late_cpus_in) - 1);
+		this_cpu_write(ucode_ctrl.result, UCODE_TIMEOUT);
+		return;
+	}
+
+	/*
+	 * Wait for primary threads to complete. If one of them hangs due
+	 * to the update, there is no way out. This is non-recoverable
+	 * because the CPU might hold locks or resources and confuse the
+	 * scheduler, watchdogs etc. There is no way to safely evacuate the
+	 * machine.
+	 */
+	if (!wait_for_ctrl())
+		panic("Microcode load: Primary CPU %d timed out\n", ctrl_cpu);
+
+	/*
+	 * If the primary succeeded then invoke the apply() callback,
+	 * otherwise copy the state from the primary thread.
+	 */
+	if (this_cpu_read(ucode_ctrl.ctrl) == SCTRL_APPLY)
+		ret = microcode_ops->apply_microcode(cpu);
+	else
+		ret = per_cpu(ucode_ctrl.result, ctrl_cpu);
+
+	this_cpu_write(ucode_ctrl.result, ret);
+	this_cpu_write(ucode_ctrl.ctrl, SCTRL_DONE);
+}
+
+static __maybe_unused void load_primary(unsigned int cpu)
+{
+	struct cpumask *secondaries = topology_sibling_cpumask(cpu);
+	enum sibling_ctrl ctrl;
+	enum ucode_state ret;
+	unsigned int sibling;
+
+	/* Initial rendezvous to ensure that all CPUs have arrived */
+	if (!wait_for_cpus(&late_cpus_in)) {
+		this_cpu_write(ucode_ctrl.result, UCODE_TIMEOUT);
+		pr_err_once("load: %d CPUs timed out\n", atomic_read(&late_cpus_in) - 1);
+		return;
+	}
+
+	ret = microcode_ops->apply_microcode(cpu);
+	this_cpu_write(ucode_ctrl.result, ret);
+	this_cpu_write(ucode_ctrl.ctrl, SCTRL_DONE);
+
+	/*
+	 * If the update was successful, let the siblings run the apply()
+	 * callback. If not, tell them it's done. This also covers the
+	 * case where the CPU has uniform loading at package or system
+	 * scope implemented but does not advertise it.
+	 */
+	if (ret == UCODE_UPDATED || ret == UCODE_OK)
+		ctrl = SCTRL_APPLY;
+	else
+		ctrl = SCTRL_DONE;
+
+	for_each_cpu(sibling, secondaries) {
+		if (sibling != cpu)
+			per_cpu(ucode_ctrl.ctrl, sibling) = ctrl;
+	}
+}
+
 static int load_cpus_stopped(void *unused)
 {
 	int cpu = smp_processor_id();
