Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4071575F873
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 15:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbjGXNfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 09:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbjGXNf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 09:35:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7E91BC5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 06:34:55 -0700 (PDT)
Message-ID: <20230724132046.329111530@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690205675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=1KrXZ6WN0UqKcYJn0Q3OLCj/xDPlvNt/2RBQorpLgnc=;
        b=zPdsB3Qf0w8rV5u7JJnEIrIICeCzWTESZsbT+83xaO4G7lSL6vRPsUxFUTxGRaSn99v1B3
        hdl4ic6m1fHScfmE1QZy+GtIL+FU5Afy7wGZpS832vieQtAbLjn6JcxiNvfFFDGjecia3G
        ZMkQ+qbslirBrb5NlWts1dfA3jURrpmMaFIfs2AySraOPjrJ2e6K/higTJDfYj0IMyOYEY
        xtn/6s7nb7/QEG6GxJC0kC7bdD0f/IGFHZc+4rSm/UXTCYdt9BF84cLblVCaMIc8x+2Sop
        ZkYBK1VPcRBq8M9lGd8RrCqVvcsewXmLPPZbJGHxy2EEu6LTW4x8Tuy+be5d5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690205675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=1KrXZ6WN0UqKcYJn0Q3OLCj/xDPlvNt/2RBQorpLgnc=;
        b=bXbMHxnrFfo/lqPPNrPTXtirsfmHyRdr4Kx5gjWQ8CrH9UqX1+MNBomFj4GHEJEKRk+eWe
        NvxyiUz6wdHclhBA==
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
Subject: [patch V2 29/58] x86/ioapic/32: Decrapify phys_id_present_map operation
References: <20230724131206.500814398@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 24 Jul 2023 15:34:34 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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

