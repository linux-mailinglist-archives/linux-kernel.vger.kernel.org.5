Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B341A776580
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 18:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbjHIQtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 12:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbjHIQtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 12:49:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31841BFE;
        Wed,  9 Aug 2023 09:49:34 -0700 (PDT)
Date:   Wed, 09 Aug 2023 16:49:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691599773;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=zH38xtHL9HqIzLBGvvTBhROYV0QZSJpOfbkOR0Lj/7w=;
        b=Tz9QrgDEHDorugHj8mio5yFNF9GQdvZliXTTnRo1SEMgoKYzgwdu2tD0sGXa7WidPdLUwg
        eRkM/3S8dzj/er8JEDZIsDU9JZX/69RoJayc01OHJsRBtSFpFzXdmwJQkEWVuvBguWCZaf
        a1d8ioCQvXjBrxKEhCvkqdT7Qiqs2eaivmS7zln3ULnVtj2Q1QV9fYOaxsmC4eIwpj1Jya
        jToh75r9JZtHbZI/+WoovIZSqmg9JoUYhFy/1vXwnxLP4XiLYWHCaECOMvSqNJ04VxCwHc
        gN7E0rfXp+eMfSaBxUgkBv4bI0lJQgbrtudwfVmnc+XsHruFzF40gWY5K/6f3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691599773;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=zH38xtHL9HqIzLBGvvTBhROYV0QZSJpOfbkOR0Lj/7w=;
        b=L2+qmcdwXZ6165XeHZ52prG4+lvCnk05vLLBHWuBp1VhSPz1HH2ZRX4BtceDZaFGdB4i1k
        T414Fi9n+ZiprICQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/ioapic/32: Decrapify phys_id_present_map operation
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169159977304.27769.12345903887373451399.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     6026bdba949934b45b7e3ae2babbb7c58d4daeca
Gitweb:        https://git.kernel.org/tip/6026bdba949934b45b7e3ae2babbb7c58d4daeca
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 08 Aug 2023 15:03:59 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 09 Aug 2023 08:10:12 -07:00

x86/ioapic/32: Decrapify phys_id_present_map operation

The operation to set the IOAPIC ID in phys_id_present_map is as convoluted
as it can be.

  1) Allocate a bitmap of 32byte size on the stack
  2) Zero the bitmap and set the IOAPIC ID bit
  3) Or the temporary bitmap over phys_id_present_map

The same functionality can be achieved by setting the IOAPIC ID bit
directly in the phys_id_present_map.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/apic/io_apic.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 8c47099..ff2d27e 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -1511,12 +1511,9 @@ void __init setup_ioapic_ids_from_mpc_nocheck(void)
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
