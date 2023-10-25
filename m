Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE2427D66AA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 11:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234201AbjJYJX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 05:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232428AbjJYJXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 05:23:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052978F
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 02:23:23 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698225800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yUcUiwGpFSCQqLOUhrIjCIBXxCb6by9NHlZTjR/R2b4=;
        b=XlCtbBKoJksQnxcIzlyrMcFEENs4LW7yVd+zeNy86cUdwQy5Cw4ZI+/xWddtkVR2Wkzqcz
        h9C6fOu/VSCYhKQjY6UhpHkA0JgRAhLZLIQBfcQGqUE7/UpsBLj635RpYAy40HmtjbpQaL
        JTjXYfsJUgQH6cnTriCf0EMQMdJwpUz2C5i65F77WVoGo9NUBwOYpJLeNCVRgZnWCNu9Yc
        2lYPoETAW8wQKkYWAN3LugsXnzKpaghmGAPG84siNzHESzzxb4STgYrnUsHMWS4/yCfURd
        IBhc6f5/tr6TeY4yJ9gTpt7LaaIrg6yOc7I1X98HD870CIETLhMyU4xi1oEbKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698225800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yUcUiwGpFSCQqLOUhrIjCIBXxCb6by9NHlZTjR/R2b4=;
        b=jEJMCRwroHoFGR736hf+zdVWzNWgPN0QQkGMD54XnBhCB+FYLFlJKW9rtN5b3YMQRdrtnj
        1CGo1ERdTRJo3zBQ==
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Hans de Goede <hdegoede@redhat.com>, kys@microsoft.com,
        hpa@linux.intel.com
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: PIC probing code from e179f6914152 failing
In-Reply-To: <87ttqhcotn.ffs@tglx>
References: <c8d43894-7e66-4a01-88fc-10708dc53b6b@amd.com>
 <878r7z4kb4.ffs@tglx> <e79dea49-0c07-4ca2-b359-97dd1bc579c8@amd.com>
 <87ttqhcotn.ffs@tglx>
Date:   Wed, 25 Oct 2023 11:23:19 +0200
Message-ID: <87v8avawe0.ffs@tglx>
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

On Mon, Oct 23 2023 at 17:59, Thomas Gleixner wrote:
> On Thu, Oct 19 2023 at 16:20, Mario Limonciello wrote:
>>   struct legacy_pic null_legacy_pic = {
>> -       .nr_legacy_irqs = 0,
>> +       .nr_legacy_irqs = 1,
>>          .chip = &dummy_irq_chip,
>>          .mask = legacy_pic_uint_noop,
>>          .unmask = legacy_pic_uint_noop,
>>
>> I think it's cleaner than changing all the places that use 
>> nr_legacy_irqs().
>
> No. It's not cleaner. It's a hack and you still need to audit all places
> which depend on nr_legacy_irqs(). Also why '1'? You could as well use
> '16', no?

So I sat down and did a thorough analysis of legacy PIC dependencies.

Unfortunately this is an unholy mess and sprinkled all over the place,
so there is no trivial way to resolve this quickly. This needs a proper
overhaul to decouple the actual PIC driver selection from the fact that
the kernel runs on a i8259 equipped hardware and therefore needs to
honour the legacy PNP overrides etc.

The probing itself is to stay in order to avoid sprinkling weird
conditions and NULL PIC selections all over the place.

It could be argued that the probe function should try to initialize the
PIC, but that's overkill for scenarios where the PIC does not exist.

Though it turns out that ACPI/MADT is helpful here because the MADT
header has a flags field which denotes in bit 0, whether the system has
a 8259 setup or not.

This allows to override the probe for now until we actually resolved the
dependency problems in a clean way.

Untested patch below.

Thanks,

        tglx
---
--- a/arch/x86/include/asm/i8259.h
+++ b/arch/x86/include/asm/i8259.h
@@ -69,6 +69,8 @@ struct legacy_pic {
 	void (*make_irq)(unsigned int irq);
 };
 
+void legacy_pic_pcat_compat(void);
+
 extern struct legacy_pic *legacy_pic;
 extern struct legacy_pic null_legacy_pic;
 
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -148,6 +148,9 @@ static int __init acpi_parse_madt(struct
 		pr_debug("Local APIC address 0x%08x\n", madt->address);
 	}
 
+	if (madt->flags & ACPI_MADT_PCAT_COMPAT)
+		legacy_pic_pcat_compat();
+
 	/* ACPI 6.3 and newer support the online capable bit. */
 	if (acpi_gbl_FADT.header.revision > 6 ||
 	    (acpi_gbl_FADT.header.revision == 6 &&
--- a/arch/x86/kernel/i8259.c
+++ b/arch/x86/kernel/i8259.c
@@ -32,6 +32,7 @@
  */
 static void init_8259A(int auto_eoi);
 
+static bool pcat_compat __ro_after_init;
 static int i8259A_auto_eoi;
 DEFINE_RAW_SPINLOCK(i8259A_lock);
 
@@ -299,15 +300,32 @@ static void unmask_8259A(void)
 
 static int probe_8259A(void)
 {
+	unsigned char new_val, probe_val = ~(1 << PIC_CASCADE_IR);
 	unsigned long flags;
-	unsigned char probe_val = ~(1 << PIC_CASCADE_IR);
-	unsigned char new_val;
+
+	/*
+	 * If MADT has the PCAT_COMPAT flag set, then do not bother probing
+	 * for the PIC. Some BIOSes leave the PIC uninitialized and probing
+	 * fails.
+	 *
+	 * Right now this causes problems as quite some code depends on
+	 * nr_legacy_irqs() > 0 or has_legacy_pic() == true. This is silly
+	 * when the system has an IO/APIC because then PIC is not required
+	 * at all, except for really old machines where the timer interrupt
+	 * must be routed through the PIC. So just pretend that the PIC is
+	 * there and let legacy_pic->init() initialize it for nothing.
+	 *
+	 * Alternatively this could just try to initialize the PIC and
+	 * repeat the probe, but for cases where there is no PIC that's
+	 * just pointless.
+	 */
+	if (pcat_compat)
+		return nr_legacy_irqs();
+
 	/*
-	 * Check to see if we have a PIC.
-	 * Mask all except the cascade and read
-	 * back the value we just wrote. If we don't
-	 * have a PIC, we will read 0xff as opposed to the
-	 * value we wrote.
+	 * Check to see if we have a PIC.  Mask all except the cascade and
+	 * read back the value we just wrote. If we don't have a PIC, we
+	 * will read 0xff as opposed to the value we wrote.
 	 */
 	raw_spin_lock_irqsave(&i8259A_lock, flags);
 
@@ -429,5 +447,9 @@ static int __init i8259A_init_ops(void)
 
 	return 0;
 }
-
 device_initcall(i8259A_init_ops);
+
+void __init legacy_pic_pcat_compat(void)
+{
+	pcat_compat = true;
+}

