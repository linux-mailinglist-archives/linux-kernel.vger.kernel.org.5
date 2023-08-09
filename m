Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38B9C776821
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 21:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233285AbjHITMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 15:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233405AbjHITMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 15:12:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A98210B;
        Wed,  9 Aug 2023 12:12:19 -0700 (PDT)
Date:   Wed, 09 Aug 2023 19:12:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691608338;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=YGt04ExDD90fkwtK9eQG4guWZCoYCrl9GUzAoXCPlKs=;
        b=bXpUWSfhkL00gEE2YindtaTf+1y9FCu2c2LcUwvOxO0H2A52BbaUbOivX3dSB1/1PHzETH
        vKgJMa1d2qelFKQXJOPZVaqqIfqAEUabpGGCtTjDkCzAfszXRSAvg+g25sq39OgaOemRGb
        f8lJIvv50lgNrKPTceM9x9FYPiVPxn3sinM9OUaKvopHhHE08DHs4mNoOrCNolevX1i316
        NWjc59wqzARwzJeXdpWMwuiUowVC0HnsWRsOtIwPYG0xWIimikjpeZPK4GEp0ceV/lqdwF
        rTi6NrvLnqmtN963pfNs8/jsO+Yy7ehlaPkFmN8d5kOmzuE8joXX6KbyjP+u4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691608338;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=YGt04ExDD90fkwtK9eQG4guWZCoYCrl9GUzAoXCPlKs=;
        b=ZWM/ZF8FDRTsrqgWn/v0LmAPDRZ6Ees9SR0gCa53ufd+tfTE+IsSqk2XdsUd7+PKKX+pFQ
        4kn6yb61q2QFjqCA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/ioapic/32: Decrapify phys_id_present_map operation
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169160833776.27769.15048619665774499729.tip-bot2@tip-bot2>
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

Commit-ID:     9faee3ecbfedebc6cdd0d96bfb2788ad8d62ef7e
Gitweb:        https://git.kernel.org/tip/9faee3ecbfedebc6cdd0d96bfb2788ad8d62ef7e
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 08 Aug 2023 15:03:59 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 09 Aug 2023 11:58:26 -07:00

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
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Juergen Gross <jgross@suse.com> # Xen PV (dom0 and unpriv. guest)
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
