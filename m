Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E22975706C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 01:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbjGQXSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 19:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbjGQXSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 19:18:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3774F172E
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 16:17:27 -0700 (PDT)
Message-ID: <20230717223224.801556578@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689635720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=1fi5EfwywiW+JxLoqkaaJxdnnrJM3lL64yD5t1OC3bQ=;
        b=BADiRAFTkC6r+a6gyybktPa+HfMXroxjn94l+bXbqaw3hq9umOUNeI+hfDtflvabJCgkd5
        QafHXvflNvNJy/0aP7T1om1tokKWKy0kWeS+wIa6a4G5IGSmufLN9xvcqtTEjwOi5+MXx3
        8GezOJsDcGML0gR+CwAMJGMfWTiy3rS/rOqo0rJkKJerU87KohFbetomtjwF9muWhZpVNZ
        RESKOnkG/WXU0hxG3iczaPFjdgcOdTFWoH2KDBpEX4wf1GuCXUvbJphNnlnb2y2YfXeuTK
        uvQ6KOXl/URhjav4FU825U9eo8rowRqpyoA8+YJI3k64zJF5s4YiDqPk1NdtLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689635720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=1fi5EfwywiW+JxLoqkaaJxdnnrJM3lL64yD5t1OC3bQ=;
        b=gEMTuYy1EBhlm7p9f9Q1LKgSaDPFxw28WPcOb9fBTWlqY6cWG1255arVxNdYPX4Kr9ZFwy
        ZCcvTKnNXjsBQoCw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>
Subject: [patch 29/58] x86/ioapic/32: Decrapify phys_id_present_map operation
References: <20230717223049.327865981@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 18 Jul 2023 01:15:19 +0200 (CEST)
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

