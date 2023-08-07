Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C367726C8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234510AbjHGNz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234676AbjHGNyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:54:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D3B1FF9
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:53:37 -0700 (PDT)
Message-ID: <20230807135028.486658473@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691416415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ayByDUJuswmwRg+JdkqaUgq40LVH8XzK6wjgNRkT7J0=;
        b=V7FUOYfCvGD/WjL1hz+d+jUBSXqy1DJhVjHBHvlzWOx49ih7b+z8Pe3Z5+uLkAELFVl/aR
        VLKGsCcHj34BJlnqR5RDMZ1G2mHnq1aXUy77opzwjEHaEZmtgJSHnmPhVV91PDEk5Osb7X
        jVvDcPmKMcXpoByMER5MJm/invKurM1RilwsHT4VeAZwf0ivX23u+nmuOLqTgqx8hfe44a
        ZbmxmVPuA8S4dsg1AwZz4njC5k+jn2ZXXhJbkaYgoQxh4PiWVL6eZKOlGJBn3uZubIOITV
        eoasm/VSvYTd2og0tWmh7RsW0pN495wgIiogjUx/RoS5OAwfUBXiHIMdCNfsFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691416415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ayByDUJuswmwRg+JdkqaUgq40LVH8XzK6wjgNRkT7J0=;
        b=Xs3/S9inXz+zznJfqErs4MVyDfMdQjvATNjIst7qOCoxxN5ZOTE9gFe1rO+DqQWh+O9/zy
        gWZ28HkVx5sWbfDA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Feng Tang <feng.tang@intel.com>,
        Andy Shevchenko <andy@infradead.org>
Subject: [patch 39/53] x86/cpu/topology: Reject unknown APIC IDs on ACPI
 hotplug
References: <20230807130108.853357011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  7 Aug 2023 15:53:34 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The topology bitmaps track all possible APIC IDs which have been registered
during enumeration. As sizing and further topology information is going to
be derived from these bitmaps, reject attempts to hotplug an APIC ID which
was not registered during enumeration.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/cpu/topology.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -237,6 +237,10 @@ int topology_hotplug_apic(u32 apic_id, u
 	if (apic_id >= MAX_LOCAL_APIC)
 		return -EINVAL;
 
+	/* Reject if the APIC ID was not registered during enumeration. */
+	if (!test_bit(apic_id, apic_maps[TOPO_SMT_DOMAIN].map))
+		return -ENODEV;
+
 	cpu = topo_lookup_cpuid(apic_id);
 	if (cpu < 0) {
 		if (topo_info.nr_assigned_cpus >= nr_cpu_ids)

