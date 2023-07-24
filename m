Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 370C975F8A0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 15:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbjGXNhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 09:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbjGXNhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 09:37:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686BBE49
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 06:35:52 -0700 (PDT)
Message-ID: <20230724132046.798166836@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690205688;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=uHpiyIwnqkWBnjjWfT4MmD20MOeZo84Wu6JyGvenGyY=;
        b=sII8AMGEUk71qups17UPGan/1X6Oz4dN3y3R4Usl83xjwtiKkwbJl83UWMmED765XG2H0l
        sJOLAkks0XXEUbq+MIjkyiR6SkIDXVKizl5cBACwjAWAkVZZ9orG3b+q66WwxuNMjRi1gS
        DWF9JLp0VKl0QUngWFC9FwLC8XYhj38r+/DaDoUwpqN97BpABWWIDz4J6nxmV1n7V8Ve8V
        A0bZ2/KQbKGLs51FGAfQ21/JygXsjCnXt8bIZfuSQ/lMBU+Tqhn3P4h6zdQjLiKaMPkQ4m
        JB3Z6P7kpJL+8AEExpNsknWkqyzh+5ug7TujXpYTX5zD/hERpOM/V4PSgTTl7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690205688;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=uHpiyIwnqkWBnjjWfT4MmD20MOeZo84Wu6JyGvenGyY=;
        b=CnP2WFY6GpG1cLaCZywtXKsFh51V/sa9JR/IZ+vgMRk3CIRLy24ronVGvU3m1DJM1X1n/m
        2R0S+jFWyDHhfhCg==
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
Subject: [patch V2 37/58] x86/apic/uv: Get rid of wrapper callbacks
References: <20230724131206.500814398@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 24 Jul 2023 15:34:48 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Why on earth makes a wrapper around some common function sense? Just to be
able to slap some vendor name on it...

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/apic/x2apic_uv_x.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -783,11 +783,6 @@ static int uv_apic_id_valid(u32 apicid)
 	return 1;
 }
 
-static u32 apic_uv_calc_apicid(unsigned int cpu)
-{
-	return apic_default_calc_apicid(cpu);
-}
-
 static unsigned int x2apic_get_apic_id(unsigned long id)
 {
 	return id;
@@ -838,7 +833,7 @@ static struct apic apic_x2apic_uv_x __ro
 	.get_apic_id			= x2apic_get_apic_id,
 	.set_apic_id			= set_apic_id,
 
-	.calc_dest_apicid		= apic_uv_calc_apicid,
+	.calc_dest_apicid		= apic_default_calc_apicid,
 
 	.send_IPI			= uv_send_IPI_one,
 	.send_IPI_mask			= uv_send_IPI_mask,

