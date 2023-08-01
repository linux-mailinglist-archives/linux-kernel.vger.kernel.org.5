Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D8576B245
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 12:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbjHAKts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 06:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232871AbjHAKtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 06:49:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77DB3A9C
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 03:47:40 -0700 (PDT)
Message-ID: <20230801103816.801427736@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690886838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=1KrXZ6WN0UqKcYJn0Q3OLCj/xDPlvNt/2RBQorpLgnc=;
        b=JzZ4pvGAdAuoWfSspvr38QPDU5lVCe4tPQePPeYxM4DMwGJ4p0eJFfnRAViLUEwgJnLolL
        pW8fzgMUIFqBujJlSJyr2wBiuQ4R9O0oyG1ed0c7BiCKSxAtYesC4caXt47WmMox1CROFc
        +USO3RNyqJqALeNXO2MUu4bgXwKImP5lDx6ox6hBDiZrh2jzjvKZWIB4Vf6NUzrdXal+n6
        8kbIqpJj2EktxnxySV9XeLVFAyYWNzYQK3hawi9F4M0wHnxAiLsvZWQxb7sgEPqVYNAaAn
        vs9VClaXQ1Tvt5XFI1He8wK/5+cWbcvXmHXMI0EDbhDc6Q+Ag8hbhGms2daNnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690886838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=1KrXZ6WN0UqKcYJn0Q3OLCj/xDPlvNt/2RBQorpLgnc=;
        b=q5LF6LwSb9xUUPmwXv0iQa39Fr3DpgZ2pvHJWEWAJn4oVPIRfA1Pnebzzid18PkmT8rQbT
        2ZQSCzlPvF4UGZBw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Peter Keresztes Schmidt <peter@keresztesschmidt.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [patch V3 30/60] x86/ioapic/32: Decrapify phys_id_present_map
 operation
References: <20230801103042.936020332@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  1 Aug 2023 12:47:18 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The operation to set the IOAPIC ID in phys_id_present_map is as convoluted
as it can be.

  1) Allocate a bitmap of 32byte size on the stack
  2) Zero the bitmap and set the IOAPIC ID bit
  3) Or the temporary bitmap over phys_id_present_map

The same functionality can be achieved by setting the IOAPIC ID bit
directly in the phys_id_present_map.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/apic/io_apic.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -1511,12 +1511,9 @@ void __init setup_ioapic_ids_from_mpc_no
 			physid_set(i, phys_id_present_map);
 			ioapics[ioapic_idx].mp_config.apicid = i;
 		} else {
-			physid_mask_t tmp;
-
-			physid_set_mask_of_physid(mpc_ioapic_id(ioapic_idx), &tmp);
 			apic_printk(APIC_VERBOSE, "Setting %d in the phys_id_present_map\n",
 				    mpc_ioapic_id(ioapic_idx));
-			physids_or(phys_id_present_map, phys_id_present_map, tmp);
+			physid_set(mpc_ioapic_id(ioapic_idx), phys_id_present_map);
 		}
 
 		/*

