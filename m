Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095727B51F9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 14:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236961AbjJBMAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 08:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236921AbjJBMAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 08:00:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 403D71B6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 04:59:53 -0700 (PDT)
Message-ID: <20231002115902.854919221@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696247991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=wSIKumgnxSQh4jImaEIP58qXBdiBffu/K6t5/ntvIzQ=;
        b=tSDpcr5rWCDpa5okkQctpU3oe2fk8ZQztVdUP8lJ+eg0iqaXsaT8RZcr9YMh3l+dJdnfOL
        vha25su6LdaNwPHe6Z4hc+g7DBiKcXHokZ9ID3LtOWYJjJ/dBXnE2gwySfxhERfwD7+bsu
        GE4adkXnzmhS15Jl5Rx/96uLkoCSKsOxCnBdVokVccSUBJEDnC92kJt0A13vd7RaCodcAj
        CLMr0pxWkNBjn8KU5geQc4CUrozwM+sDlX5fa7qFdal8eHIrmjOYSk4GO61KsC5ifRzQNB
        3wwCiS+nSwyFDlVYsQnv3anxR+p+dlJpNNySE4M+/1eh9M5sJmDDqZbmrz1Mmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696247991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=wSIKumgnxSQh4jImaEIP58qXBdiBffu/K6t5/ntvIzQ=;
        b=TBKKTtA1j5HNxDEtmf3rFeMukhPCQNSKVB+EtkrfabEqMwQCo24qURJXZz2bMSmEpjxagS
        u2s0llm9RrQTIwBw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [patch V4 14/30] x86/microcode/amd: Read revision from hardware in
 collect_cpu_info_amd()
References: <20231002115506.217091296@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  2 Oct 2023 13:59:51 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare to decrapify the core initialization logic which invokes
microcode_ops::apply_microcode() several times just to set
cpu_data::microcode.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: New patch
---
 arch/x86/kernel/cpu/microcode/amd.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -634,12 +634,12 @@ void reload_ucode_amd(unsigned int cpu)
 
 static int collect_cpu_info_amd(int cpu, struct cpu_signature *csig)
 {
-	struct cpuinfo_x86 *c = &cpu_data(cpu);
 	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
+	u32 dummy __always_unused;
 	struct ucode_patch *p;
 
 	csig->sig = cpuid_eax(0x00000001);
-	csig->rev = c->microcode;
+	rdmsr(MSR_AMD64_PATCH_LEVEL, csig->rev, dummy);
 
 	/*
 	 * a patch could have been loaded early, set uci->mc so that

