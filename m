Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86377774BBA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233054AbjHHUyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234880AbjHHUyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:54:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DC56CD3
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 13:41:54 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691527312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FNbB5fJwUpaIOU+kZzlbrzvUYgLN0PtPCPG9nyBr0KU=;
        b=D0ZHGydstoIY2SDSiIONRQpvozJ+h0k0NfL9FZYB7baA0YsoJaYD1YuwKh2euNQ5U/9YZM
        +A6ozwpJvoFNP9a/KHLyrK0PrDR3OC/DFBAD0sT+++M6ax5KnTZf5JTe5bH8BCc26M6vas
        FKaGSNgyajesCYiaNaZ5AhUJ1EJez+YUu3pzqyNM5fnED+66l/A4r9FyGFE0XgJSHKbEBG
        Viep3lqmK842RNgADODJcDyzghZKklseW/yOwads2V4tOTAPHfvAn/4Fb1/HhTApnYf8xW
        Aq3q7+kEG/Ztoo3S/vfS2gfUFXyUR23eSxnpl684OzjKciFW29Ed2TF/+7UdEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691527312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FNbB5fJwUpaIOU+kZzlbrzvUYgLN0PtPCPG9nyBr0KU=;
        b=w7EVC/HPSKj96eomE38fgBY2w/jm4S++S1GC36w3rGKbd7QFK/XBHTYz0W3aaUBcXTZYJA
        Q4fESJCZgcQO80Cw==
To:     Sohil Mehta <sohil.mehta@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
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
In-Reply-To: <7ef60626-28ab-a4cc-2f24-4f35e3d946aa@intel.com>
References: <20230807130108.853357011@linutronix.de>
 <c8ca9e16-ce03-1fe0-cf9f-f6cc2302dbac@intel.com> <87h6p9l58u.ffs@tglx>
 <7ef60626-28ab-a4cc-2f24-4f35e3d946aa@intel.com>
Date:   Tue, 08 Aug 2023 22:41:51 +0200
Message-ID: <87edkdl10w.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08 2023 at 13:30, Sohil Mehta wrote:
> There are compile issues with the ACPI hunk.
>
>> arch/x86/kernel/acpi/boot.c: In function =E2=80=98acpi_parse_lapic=E2=80=
=99:
>> arch/x86/kernel/acpi/boot.c:250:31: error: =E2=80=98apic_id=E2=80=99 und=
eclared (first use in this function)
>>   250 |         if (has_lapic_cpus && apic_id < 0xff)
>>       |                               ^~~~~~~
>> arch/x86/kernel/acpi/boot.c:250:31: note: each undeclared identifier is =
reported only once for each function it appears in
>> arch/x86/kernel/acpi/boot.c: In function =E2=80=98acpi_parse_madt_lapic_=
entries=E2=80=99:
>> arch/x86/kernel/acpi/boot.c:1097:47: error: =E2=80=98ACPI_MADT_TYPE_LOCA=
L_LAPIC=E2=80=99 undeclared (first use in this function); did you mean =E2=
=80=98ACPI_MADT_TYPE_LOCAL_SAPIC=E2=80=99?
>>  1097 |                 count =3D acpi_table_parse_madt(ACPI_MADT_TYPE_L=
OCAL_LAPIC,
>>       |                                               ^~~~~~~~~~~~~~~~~~=
~~~~~~~~
>>       |                                               ACPI_MADT_TYPE_LOC=
AL_SAPIC
>

Duh. Yes. I just picked the thing from the list and hacked it
up. Compilable variant below.

Thanks,

        tglx
---
 arch/x86/kernel/acpi/boot.c    |   35 +++++++++++++++++------------------
 arch/x86/kernel/cpu/topology.c |    2 ++
 2 files changed, 19 insertions(+), 18 deletions(-)

--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -171,6 +171,8 @@ static bool __init acpi_is_processor_usa
 	return false;
 }
=20
+static bool has_lapic_cpus;
+
 static int __init
 acpi_parse_x2apic(union acpi_subtable_headers *header, const unsigned long=
 end)
 {
@@ -241,6 +243,14 @@ acpi_parse_lapic(union acpi_subtable_hea
 		return 0;
=20
 	/*
+	 * According to https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programm=
ing_Model.html#processor-local-x2apic-structure
+	 * when MADT provides both valid LAPIC and x2APIC entries, the APIC ID
+	 * in x2APIC must be equal or greater than 0xff.
+	 */
+	if (has_lapic_cpus && processor->id < 0xff)
+		return 0;
+
+	/*
 	 * We need to register disabled CPU as well to permit
 	 * counting disabled CPUs. This allows us to size
 	 * cpus_possible_map more accurately, to permit
@@ -1072,10 +1082,8 @@ static int __init early_acpi_parse_madt_
=20
 static int __init acpi_parse_madt_lapic_entries(void)
 {
-	int count;
 	int x2count =3D 0;
-	int ret;
-	struct acpi_subtable_proc madt_proc[2];
+	int count;
=20
 	if (!boot_cpu_has(X86_FEATURE_APIC))
 		return -ENODEV;
@@ -1084,21 +1092,12 @@ static int __init acpi_parse_madt_lapic_
 				      acpi_parse_sapic, MAX_LOCAL_APIC);
=20
 	if (!count) {
-		memset(madt_proc, 0, sizeof(madt_proc));
-		madt_proc[0].id =3D ACPI_MADT_TYPE_LOCAL_APIC;
-		madt_proc[0].handler =3D acpi_parse_lapic;
-		madt_proc[1].id =3D ACPI_MADT_TYPE_LOCAL_X2APIC;
-		madt_proc[1].handler =3D acpi_parse_x2apic;
-		ret =3D acpi_table_parse_entries_array(ACPI_SIG_MADT,
-				sizeof(struct acpi_table_madt),
-				madt_proc, ARRAY_SIZE(madt_proc), MAX_LOCAL_APIC);
-		if (ret < 0) {
-			pr_err("Error parsing LAPIC/X2APIC entries\n");
-			return ret;
-		}
-
-		count =3D madt_proc[0].count;
-		x2count =3D madt_proc[1].count;
+		count =3D acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_APIC,
+					      acpi_parse_lapic, MAX_LOCAL_APIC);
+		if (count > 0)
+			has_lapic_cpus =3D true;
+		x2count =3D acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_X2APIC,
+						acpi_parse_x2apic, MAX_LOCAL_APIC);
 	}
 	if (!count && !x2count) {
 		pr_err("No LAPIC entries present\n");
