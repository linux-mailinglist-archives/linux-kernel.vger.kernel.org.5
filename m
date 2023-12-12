Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ADCD80F4AF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 18:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376799AbjLLRet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 12:34:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235113AbjLLReq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 12:34:46 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE3D123;
        Tue, 12 Dec 2023 09:34:50 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1702402489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
        bh=Vh5gxobmwSqeONL44Vg/pUFT6mcMvW2fhVncm4gDIi8=;
        b=kiOLCvlACFYSKEgH59hIsxkmAN5yOqVOdbfEWvZJYIq8JsqT26+3HhG+yzIX+K55d9nXA4
        w1XDM7B7/PvaycakMIWXkJ8eJ2cDGy9bO8bMddNkesig2IKPb8gdhpd2ikkR3XPLAIyZ85
        /cZgBx+yDd8wMewgMg5aoWd5A7pcHwIDwJqoVOQakQuW4A4haNBONlaUgvpCSq82UHmpKz
        HOLy/Nedm7xiskcCEbiriL47qD4B4nUOS/sNlmU0BcA+z3oBe0IuTj021F99fQkKoLsoRV
        1Ge/LAePtPsoxgrrxrtOpsQlZtFac0+La2hMFCc6PYdhhOwPhaS7tvWRBN3M/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1702402489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
        bh=Vh5gxobmwSqeONL44Vg/pUFT6mcMvW2fhVncm4gDIi8=;
        b=qaSr8NfzQX7db88EzLqItcs4NM5/uhqHSjuaV5nPbD5gfhErZun+m+2bD7sbcqoW79SxkM
        XD34XlI0gs9wIPAQ==
To:     "Zhang, Rui" <rui.zhang@intel.com>,
        "jsperbeck@google.com" <jsperbeck@google.com>,
        "tip-bot2@linutronix.de" <tip-bot2@linutronix.de>
Cc:     "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tip-commits@vger.kernel.org" 
        <linux-tip-commits@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Andres Freund <andres@anarazel.de>
Subject: Re: [tip: x86/urgent] x86/acpi: Ignore invalid x2APIC entries
In-Reply-To: <1e565bb08ebdd03897580a5905d1d2de01e15add.camel@intel.com>
Date:   Tue, 12 Dec 2023 18:34:48 +0100
Message-ID: <87ttonpbnr.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23 2023 at 12:50, Rui Zhang wrote:
> On Wed, 2023-11-22 at 22:19 +0000, John Sperbeck wrote:
>> I have a platform with both LOCAL_APIC and LOCAL_X2APIC entries for
>> each CPU.=C2=A0 However, the ids for the LOCAL_APIC entries are all
>> invalid ids of 255, so they have always been skipped in
>> acpi_parse_lapic()
>> by this code from f3bf1dbe64b6 ("x86/acpi: Prevent LAPIC id 0xff from
>> being
>> accounted"):
>>=20
>> =C2=A0=C2=A0=C2=A0 /* Ignore invalid ID */
>> =C2=A0=C2=A0=C2=A0 if (processor->id =3D=3D 0xff)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retur=
n 0;
>>=20
>> With the change in this thread, the return value of 0 means that the
>> 'count' variable in acpi_parse_entries_array() is incremented.=C2=A0 The
>> positive return value means that 'has_lapic_cpus' is set, even though
>> no entries were actually matched.
>
> So in acpi_parse_madt_lapic_entries, without this patch,
> madt_proc[0].count is a positive value on this platform, right?
>
> This sounds like a potential issue because the following checks to fall
> back to MPS mode can also break. (If all LOCAL_APIC entries have
> apic_id 0xff and all LOCAL_X2APIC entries have apic_id 0xffffffff)
>
>> =C2=A0 Then, when the MADT is iterated
>> with acpi_parse_x2apic(), the x2apic entries with ids less than 255
>> are skipped and most of my CPUs aren't recognized.
>>=20
>> I think the original version of this change was okay for this case in
>> https://lore.kernel.org/lkml/87pm4bp54z.ffs@tglx/T/
>
> Yeah.
>
> But if we want to fix the potential issue above, we need to do
> something more.
>
> Say we can still use acpi_table_parse_entries_array() and convert
> acpi_parse_lapic()/acpi_parse_x2apic() to
> acpi_subtable_proc.handler_arg and save the real valid entries via the
> parameter.

Nah.

> or can we just use num_processors & disabled_cpus to check if there is
> any CPU probed when parsing LOCAL_APIC/LOCAL_X2APIC entires?

No, we are not going to do that because that's just a proliferation of
boundary violations.

Let ACPI deal with it's own problems and not depend on something which
is subject to change.

The simple change below should do the trick.

Thanks,

        tglx
---
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 1a0dd80d81ac..85a3ce2a3666 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -293,6 +293,7 @@ acpi_parse_lapic(union acpi_subtable_headers * header, =
const unsigned long end)
 			    processor->processor_id, /* ACPI ID */
 			    processor->lapic_flags & ACPI_MADT_ENABLED);
=20
+	has_lapic_cpus =3D true;
 	return 0;
 }
=20
@@ -1134,7 +1135,6 @@ static int __init acpi_parse_madt_lapic_entries(void)
 	if (!count) {
 		count =3D acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_APIC,
 					acpi_parse_lapic, MAX_LOCAL_APIC);
-		has_lapic_cpus =3D count > 0;
 		x2count =3D acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_X2APIC,
 					acpi_parse_x2apic, MAX_LOCAL_APIC);
 	}


