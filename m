Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6866A767CB5
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 09:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236602AbjG2HHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 03:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjG2HHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 03:07:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2003844BB;
        Sat, 29 Jul 2023 00:07:43 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690614461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=THTeBB2mb7AJ2E32STwqhY2BCLrGn27gKrLJx6NrAos=;
        b=rh3Hs4ds1qZ4VMTiu5OIAGK9TvCNkK8+2+WGMRnENHeQ7NiOtUkPnfT+rc96MjTyOsWwwm
        ndwb5IgZ1XmRaZn8UCbzSyy5jf2IkMPRLQW3nwAh5TlKdbQ4Zp/LgNDTT5vdXRWfM5qQ7O
        EBvVu/WzOY8EGtXccJxEtpH6le7T3VZ2S3bNrj4dwf0SqYA7+jxviu5IQ55EAaILKerM/i
        yZvazEmpmdC32ZOTvRT9PUM49Z3loybI0mH7JphWcv4b6Cdst48ngoBW1qftHK9cNuEyGp
        z7El657Upv8iGD2okau5Vxu3AG89HnopqCo/VZe18CE2NUXN9H0kH2uUgosEtQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690614461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=THTeBB2mb7AJ2E32STwqhY2BCLrGn27gKrLJx6NrAos=;
        b=hwjGmGni0Knm56AGG5IkZVTF4BBicZciX9trAGZ7RMursU919d4h5Zx9lLG2sdhUNUaRG/
        7m7gEdLfnCWZJzBQ==
To:     "Zhang, Rui" <rui.zhang@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "bp@alien8.de" <bp@alien8.de>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Tang, Feng" <feng.tang@intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [RFC PATCH] x86/acpi: Ignore invalid x2APIC entries
In-Reply-To: <84216c743c6368691bc3fae924c6cbd33805ca9b.camel@intel.com>
References: <20230702162802.344176-1-rui.zhang@intel.com>
 <87jzukqjvf.ffs@tglx>
 <84216c743c6368691bc3fae924c6cbd33805ca9b.camel@intel.com>
Date:   Sat, 29 Jul 2023 09:07:40 +0200
Message-ID: <87pm4bp54z.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28 2023 at 16:47, Rui Zhang wrote:
> On Fri, 2023-07-28 at 14:51 +0200, Thomas Gleixner wrote:
>> As the call sites during MADT parsing ignore the return value anyway,
>> there is no harm and this is a proper defense against broken tables
>> which enumerate an APIC twice.
>
> Yeah, this can fix the duplicate APIC ID issue.

We want it independent of the below.

> But for x2APIC CPUs with unique APIC ID, but smaller than 255, should
> we still enumerate them when we already have valid LAPIC entries?
>
> For the Ivebridge-EP 2-socket system,
>
> LAPIC: APIC ID from 0x0 - 0xB, 0x10 - 0x1B, 0x20 - 0x2B, 0x30 - 0x3B
> x2APIC: APIC ID from 0x0 - 0x77
>
> # cpuid -1 -l 0xb -s 1
> CPU:
>       --- level 1 (core) ---
>       bits to shift APIC ID to get next =3D 0x5 (5)
>       logical processors at this level  =3D 0x18 (24)
>       level number                      =3D 0x1 (1)
>       level type                        =3D core (2)
>       extended APIC ID                  =3D 0
>
> If we still enumerates all the x2APIC entries,
> 1. we got 72 extra possible CPUs from x2APIC
> 2.=C2=A0with the patch at https://lore.kernel.org/all/87edm36qqb.ffs@tglx=
/ ,
> _max_logical_packages is set to 4 instead of 2.
>
> this is still a problem, right?

Yes, you are right.

But I still don't like the indirection of the returned CPU number. It's
an ACPI selfcontained issue, no?

So something like this should do the trick:

+		count =3D acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_APIC,
+					acpi_parse_lapic, MAX_LOCAL_APIC);
+		if (count)
+			has_lapic_cpus =3D true;
+		x2count =3D acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_X2APIC,
+					acpi_parse_x2apic, MAX_LOCAL_APIC);
 	}
 	if (!count && !x2count) {
 		pr_err("No LAPIC entries present\n");
