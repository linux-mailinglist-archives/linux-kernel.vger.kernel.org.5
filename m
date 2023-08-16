Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A3F77E926
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 20:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345571AbjHPS7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 14:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345484AbjHPS6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 14:58:46 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E642700
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 11:58:45 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 602CA40E0197;
        Wed, 16 Aug 2023 18:58:43 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id MpC0PBQpMLzh; Wed, 16 Aug 2023 18:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1692212320; bh=aw5nHTT9oFOTZK0h8JJR3CM7XYo+0yPrx12S26iJdG8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GAsDnoqJ7unBEriLF9/QTMGVO/TATcYci1w4k/P8jZ3xtjOGFbhiJ8bj3Lb8bG3QQ
         r5pC/fu+9IFOqG4YqWPvf7EWV/6Y7q2DNLVAyTZTuriHIVqI/F+UNAaZ0LOqsyxlQo
         n8t/tD2JyZh0+EFiDtxKOZutmvhvqfjP9QGW/UFJWuZMggyMzeEaIK6xGsV3iouR0t
         eKpCxUtQVR4ksNWoIh3VKTGKdDxIjRS+P+kWBK1oZbcdxkDWCUXLnNQDuuSVFl4Upu
         mmToCjVz7TtghTtLTex0k17lpmnVQha/+65PmM7NQWcU8KbuWqYQx1uX3H3OfMkb8h
         xw6+DtcxXTiG8kEm2ekjF+bWpc++h+Nstu5l3TRZrrhl/yDqImLnYZqMRJs+LpGalc
         LU57hHS8nd0EGgKgoPrSRt8ZJyE6qhEQMEPwM2WZG7XDxt0isZk5pz19COMiGdSgUk
         vVylzJiO1SmoYpfgwoDMcWHnl6/xJo1kXpKoxqZ1+Rz149eax2gVGLzNP4b414zBlu
         F5iB9W2ZoeKCVzqfZOrE7a/uHiE7dZzHUWXWMQy6mvC9BgaTytzF0ZvGh40PDqS/PA
         rJJlSG2aGtJoDPV6+FKYZjcGm264mOFmr/JzSXaInUeqST95OV4gPkm3msRwk2dh+d
         MZeyb00ESHttw98RvGidul2M=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9427040E0140;
        Wed, 16 Aug 2023 18:58:35 +0000 (UTC)
Date:   Wed, 16 Aug 2023 20:58:30 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Nikolay Borisov <nik.borisov@suse.com>, X86 ML <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/srso: Correct the mitigation status when SMT is
 disabled
Message-ID: <20230816185830.GOZN0cVl/pJcZUiPGY@fat_crate.local>
References: <20230814205300.krikym7jeckehqik@treble>
 <20230814211727.GLZNqZ5+flxtyaDjMQ@fat_crate.local>
 <20230815095724.GBZNtMBPUJSEegviJN@fat_crate.local>
 <20230815195831.2opbgrznnpszaa32@treble>
 <20230815201753.GGZNvdcbPHXtEXn4As@fat_crate.local>
 <20230815212751.xhsyn7iwj2gwpuk5@treble>
 <20230816083057.GCZNyJQVARsxD3rNAm@fat_crate.local>
 <20230816160757.oegndrcnf2fvt7l3@treble>
 <20230816173531.GMZN0I40DEFE38Zxuz@fat_crate.local>
 <20230816182940.xw67h5xbilqpb5au@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230816182940.xw67h5xbilqpb5au@treble>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 11:29:40AM -0700, Josh Poimboeuf wrote:
> No, if the bug bit isn't set then that comes from cpu_show_common():
> 
> static ssize_t cpu_show_common(struct device *dev, struct device_attribute *attr,
> 			       char *buf, unsigned int bug)
> {
> 	if (!boot_cpu_has_bug(bug))
> 		return sysfs_emit(buf, "Not affected\n");

Bah, there was that thing too.

Ok, I'll zap the sched_smt_active() branch in srso_show_state() then.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
