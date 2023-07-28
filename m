Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67EC6766D9E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 14:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235629AbjG1Mvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 08:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235304AbjG1Mvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 08:51:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B7F30DC;
        Fri, 28 Jul 2023 05:51:50 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690548708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uee1JwbJtrSsNiVqiqBVYlccVv4FcLT02FiwlBJ68ak=;
        b=E+sMdFe6N69DarDfk/W4e28bmj5X4v/zEANopsroRe1eFkIrjQbnCaYqhKytU5iC9JS2lU
        jek+r/OgdpuORHKyOnuymYxStjYwwQvq5JDEmEyWt8XkESh+WEKkVvEuVDSx+dJFHMM7tH
        +BOGx+qnP+GcwxPW5dr/sLrS5b0c59z0SnctOFmU4z+wcglpddgBtkt5o+1p0/FKJm5GZZ
        bwDmWLsA/j3dZzil0q9uC9lt2/IUVChThj/i8bXWDHvLtUXPTef4USJpE7gzKsSRtTjndT
        iVvCSQ1M9b+rf9XCNa7xdc1/AEjuyfrVYwCuLvs0Qu9d8+r2gAudsnFNuvqfQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690548708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uee1JwbJtrSsNiVqiqBVYlccVv4FcLT02FiwlBJ68ak=;
        b=81x79X5abcEjItjdT0ZlVOWuNw57yLZp72WJa+F0o5NWf/PnXufii0XDX1IiiebkxZY/ak
        RBkzqvSBDZ5Wi2Dg==
To:     Zhang Rui <rui.zhang@intel.com>, peterz@infradead.org,
        bp@alien8.de, rafael.j.wysocki@intel.com
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        x86@kernel.org, feng.tang@intel.com
Subject: Re: [RFC PATCH] x86/acpi: Ignore invalid x2APIC entries
In-Reply-To: <20230702162802.344176-1-rui.zhang@intel.com>
References: <20230702162802.344176-1-rui.zhang@intel.com>
Date:   Fri, 28 Jul 2023 14:51:48 +0200
Message-ID: <87jzukqjvf.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03 2023 at 00:28, Zhang Rui wrote:
>  
> +static bool has_lapic_cpus;

Yet another random flag. Sigh.

I really hate this. Why not doing the obvious?

--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2452,6 +2452,9 @@ int generic_processor_info(int apicid, i
 	bool boot_cpu_detected = physid_isset(boot_cpu_physical_apicid,
 				phys_cpu_present_map);
 
+	if (physid_isset(apicid, phys_cpu_present_map))
+		return -EBUSY;
+
 	/*
 	 * boot_cpu_physical_apicid is designed to have the apicid
 	 * returned by read_apic_id(), i.e, the apicid of the

As the call sites during MADT parsing ignore the return value anyway,
there is no harm and this is a proper defense against broken tables
which enumerate an APIC twice.

Thanks,

        tglx
