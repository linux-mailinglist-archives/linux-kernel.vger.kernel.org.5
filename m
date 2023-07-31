Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79A1769B8D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 17:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233235AbjGaP5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 11:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233232AbjGaP5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 11:57:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED37919B3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 08:57:15 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690819034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t1PNvCl81kIXuXrMtp//26hEV+6FIy2SJ0Lubahfegw=;
        b=NdUxul9fpQOrlAsNLGHzuvOdVNVwaZc55/AoyQxqzvFqz0ayEpSTDkzAfFRlusdQssGbeE
        HCjbEEJI/3z6zaZs50ohUyPqbn7c4ES8oKh2oSOzoBkuzFyu5qn1KfOUEgKpG0W1pC5i3a
        ZGAtDHbZ4IBKg3Ps3SmI15Ou4wkupNwXjBCq5Ke8czlm3WKbjZ9NFLNlFMtkWr0uPm2mwY
        8x2DUSGWINxkNCHK3h1gLYElALT9X0tyAz/UN09X9O9r3B0msVayRhFlGY5ooL3g9EHy+R
        LGY1ZM7MvN3d9dYyZrOsoDxUktpSEk6WTkRDxH2LhXHY4L2tCyK5vm5mxTOONw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690819034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t1PNvCl81kIXuXrMtp//26hEV+6FIy2SJ0Lubahfegw=;
        b=QXZhhRGApA6OTgyGOpk/UBO9hyLTtAEd2od/SQaYXM5PZbi8zuArfggPnt4ZwI8OTSlfkn
        R7lnNuPOzUCvr4AQ==
To:     Juergen Gross <jgross@suse.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Peter Keresztes Schmidt <peter@keresztesschmidt.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [patch V2 16/58] x86/apic: Sanitize num_processors handling
In-Reply-To: <87y1iwnt34.ffs@tglx>
References: <20230724131206.500814398@linutronix.de>
 <20230724132045.555787669@linutronix.de>
 <d232e50f-01fc-ef2e-db29-3f790d960c0e@suse.com> <87y1iwnt34.ffs@tglx>
Date:   Mon, 31 Jul 2023 17:57:13 +0200
Message-ID: <87mszcnkfa.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31 2023 at 14:50, Thomas Gleixner wrote:
> Why can't XENPV pretend that it has a smp configuration detected,
> i.e. setting smp_found_config as any other special get_smp_config()
> implementation does?

The below should do the trick, no?


--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -182,7 +182,8 @@ static void __init _get_smp_config(unsig
 	if (subtract)
 		set_nr_cpu_ids(nr_cpu_ids - subtract);
 #endif
-
+	/* Pretend to be a proper enumerated system */
+	smp_found_config = 1;
 }
 
 static void __init xen_pv_smp_prepare_boot_cpu(void)
