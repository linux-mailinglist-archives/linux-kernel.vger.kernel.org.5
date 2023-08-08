Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90AD774E12
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 00:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbjHHWLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 18:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbjHHWLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 18:11:17 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80215E51
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 15:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cUYjKPgyIxtNZfg3shuVrcaEGlvnmip2/wg3J3HZJJk=; b=ABL2/9aW/7CqWOx0YRH6TpOwOq
        anglSnecGk+JWitxOLauL+gKICBVQuEZz2a5CW6gHRnvZjdeCrC8k/4trwL8ca3LUljGXSdHoiWzf
        MGb67Jv7BwEcoCqZaCEHAsyULdjXkeRvxJh5U6Llq7cLjLGtlehVDR3nuZ1nfS97/s9cZowHWdNE+
        nrKPgFSyxx79X59iao7NB3YlJ0mHhipG6WxRxTJuH4LDWScE81AMux74TVkhszwiKQNwSBQ2ybocU
        EVmnOPunXHhpvibh4qPE8M4gUDLljbujTckX3AeJfhS6s0CS5avR79MpkT1kYfEManCaLekLcidV9
        9svPRdyQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qTUuW-0055qT-1W;
        Tue, 08 Aug 2023 22:10:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AE4D630010B;
        Wed,  9 Aug 2023 00:10:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8D4CA201CFE5F; Wed,  9 Aug 2023 00:10:39 +0200 (CEST)
Date:   Wed, 9 Aug 2023 00:10:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Sohil Mehta <sohil.mehta@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Feng Tang <feng.tang@intel.com>,
        Andy Shevchenko <andy@infradead.org>
Subject: Re: [patch 00/53] x86/topology: The final installment
Message-ID: <20230808221039.GH212435@hirez.programming.kicks-ass.net>
References: <20230807130108.853357011@linutronix.de>
 <c8ca9e16-ce03-1fe0-cf9f-f6cc2302dbac@intel.com>
 <87h6p9l58u.ffs@tglx>
 <7ef60626-28ab-a4cc-2f24-4f35e3d946aa@intel.com>
 <87edkdl10w.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87edkdl10w.ffs@tglx>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 10:41:51PM +0200, Thomas Gleixner wrote:

> --- a/arch/x86/kernel/acpi/boot.c
> +++ b/arch/x86/kernel/acpi/boot.c
> @@ -171,6 +171,8 @@ static bool __init acpi_is_processor_usa
>  	return false;
>  }
>  
> +static bool has_lapic_cpus;
> +
>  static int __init
>  acpi_parse_x2apic(union acpi_subtable_headers *header, const unsigned long end)
>  {
> @@ -241,6 +243,14 @@ acpi_parse_lapic(union acpi_subtable_hea
>  		return 0;
>  
>  	/*
> +	 * According to https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model.html#processor-local-x2apic-structure
> +	 * when MADT provides both valid LAPIC and x2APIC entries, the APIC ID
> +	 * in x2APIC must be equal or greater than 0xff.
> +	 */
> +	if (has_lapic_cpus && processor->id < 0xff)
> +		return 0;
> +
> +	/*
>  	 * We need to register disabled CPU as well to permit
>  	 * counting disabled CPUs. This allows us to size
>  	 * cpus_possible_map more accurately, to permit

It works better if you move this hunk into acpi_parse_x2apic() instead.
Then I can indeed confirm it works as advertised -- also having one of
them afflicted ivb-ep machines.

Tested-by: Peter Zijlstra (Intel) <peterz@infradead.org>

---
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 088323ed6179..f6cff99d6087 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -171,6 +171,8 @@ static bool __init acpi_is_processor_usable(u32 lapic_flags)
 	return false;
 }
 
+static bool has_lapic_cpus;
+
 static int __init
 acpi_parse_x2apic(union acpi_subtable_headers *header, const unsigned long end)
 {
@@ -199,6 +201,14 @@ acpi_parse_x2apic(union acpi_subtable_headers *header, const unsigned long end)
 	if (!acpi_is_processor_usable(processor->lapic_flags))
 		return 0;
 
+	/*
+	 * According to https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model.html#processor-local-x2apic-structure
+	 * when MADT provides both valid LAPIC and x2APIC entries, the APIC ID
+	 * in x2APIC must be equal or greater than 0xff.
+	 */
+	if (has_lapic_cpus && apic_id < 0xff)
+		return 0;
+
 	/*
 	 * We need to register disabled CPU as well to permit
 	 * counting disabled CPUs. This allows us to size
@@ -1072,10 +1083,8 @@ static int __init early_acpi_parse_madt_lapic_addr_ovr(void)
 
 static int __init acpi_parse_madt_lapic_entries(void)
 {
-	int count;
 	int x2count = 0;
-	int ret;
-	struct acpi_subtable_proc madt_proc[2];
+	int count;
 
 	if (!boot_cpu_has(X86_FEATURE_APIC))
 		return -ENODEV;
@@ -1084,21 +1093,12 @@ static int __init acpi_parse_madt_lapic_entries(void)
 				      acpi_parse_sapic, MAX_LOCAL_APIC);
 
 	if (!count) {
-		memset(madt_proc, 0, sizeof(madt_proc));
-		madt_proc[0].id = ACPI_MADT_TYPE_LOCAL_APIC;
-		madt_proc[0].handler = acpi_parse_lapic;
-		madt_proc[1].id = ACPI_MADT_TYPE_LOCAL_X2APIC;
-		madt_proc[1].handler = acpi_parse_x2apic;
-		ret = acpi_table_parse_entries_array(ACPI_SIG_MADT,
-				sizeof(struct acpi_table_madt),
-				madt_proc, ARRAY_SIZE(madt_proc), MAX_LOCAL_APIC);
-		if (ret < 0) {
-			pr_err("Error parsing LAPIC/X2APIC entries\n");
-			return ret;
-		}
-
-		count = madt_proc[0].count;
-		x2count = madt_proc[1].count;
+		count = acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_APIC,
+					      acpi_parse_lapic, MAX_LOCAL_APIC);
+		if (count > 0)
+			has_lapic_cpus = true;
+		x2count = acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_X2APIC,
+						acpi_parse_x2apic, MAX_LOCAL_APIC);
 	}
 	if (!count && !x2count) {
 		pr_err("No LAPIC entries present\n");
