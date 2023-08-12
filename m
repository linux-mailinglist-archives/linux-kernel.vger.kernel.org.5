Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECA477A1BA
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 20:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjHLSa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 14:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjHLSa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 14:30:26 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309B3E75
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 11:30:29 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4918340E019C;
        Sat, 12 Aug 2023 18:30:27 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ANkyiBwZaiml; Sat, 12 Aug 2023 18:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1691865024; bh=dB5YfOKstnq1KyiqCwAAA5zYYjt6+P0d++vEAhm+U4I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gMr9CLHOKR+U8kRZc5W+w8tTL51wRNl3wtiMLFZ4trXy07rI1Lbwo3TQQnriKkSCm
         /lSDMPXDP4fE2q1GDgSDly3LrxJWE6mEYTXMHJVgKx4dOOOw/X29XVjy3VPn5XYzLW
         iBi6sMo91ShJoeXtg8StnZSHZeKFKENhBEK0gwHDt16uHoWdONk2JOB2T8gSWr0DmR
         4eZyoPm4zGNEdTZfM+cn3oPLZQqCKiI4zQwe1mWxTj/bsM/+UywM5pj7e9MxI7nUlE
         H4yhAvn/yPAogJbbKPdLvchcc7GsJ/Nkt81UbuLrVIjy02rYYibtuiUWmJydpyIDUj
         lzL6/ChyDds/+g/Gvukw6Azv3dr38Ow9Q52GGL++4Yvma+U5SV5l96uDR5R0AoeWF5
         xyPqso1wj/5f6TAj5ppGqE8SJ4RNpFpynu8qdeUN7f2lHRHYGwuJmpHBodSyzP3ksn
         xXGSP31LQCHfRGRVg6TqmhVGiCmKos8TR7onkG+stx0jDvhwM/TwLopTeMcZitvx4k
         ffJjuz2r8o/u7WQ4cHxd9TwhTlF+XptYPe6bFyPVZCpFiEf8MNSrbX84jy9vtovEqm
         Nrl1EL5RcE/4zV+8dbzyi/KODD4RnqlKmtNiftUbkrI206SJ4/HY8jokoYwKuvTcrb
         gXq0u5pP0lq+Fx7H9hVlc82A=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 51EBE40E0185;
        Sat, 12 Aug 2023 18:30:17 +0000 (UTC)
Date:   Sat, 12 Aug 2023 20:30:09 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, gregkh@linuxfoundation.org
Subject: Re: [RFC][PATCH 05/17] x86/cpu: Cleanup the untrain mess
Message-ID: <20230812183009.GJZNfPsXvQDDxhKp0s@fat_crate.local>
References: <20230809071218.000335006@infradead.org>
 <20230809072200.782716727@infradead.org>
 <20230809125101.xxwhuipfvj7kbasn@treble>
 <20230809131243.GK212435@hirez.programming.kicks-ass.net>
 <20230809132635.GB220434@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230809132635.GB220434@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 03:26:35PM +0200, Peter Zijlstra wrote:
> I think simply setting UNRET for SRSO at this point will be sufficient.
> That ensures the entry_untrain_ret thing gets called, and the
> alternative there DTRT.
> 
> The feature isn't used anywhere else afaict.
> 
> Then later, after the fancy alternatives happen, this can be cleaned up
> again.

Yes, this fixes it for >= Zen3:

---
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 4b0a770fbacb..611d048f6415 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2448,6 +2448,7 @@ static void __init srso_select_mitigation(void)
 			 * like ftrace, static_call, etc.
 			 */
 			setup_force_cpu_cap(X86_FEATURE_RETHUNK);
+			setup_force_cpu_cap(X86_FEATURE_UNRET);
 
 			if (boot_cpu_data.x86 == 0x19) {
 				setup_force_cpu_cap(X86_FEATURE_SRSO_ALIAS);

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
