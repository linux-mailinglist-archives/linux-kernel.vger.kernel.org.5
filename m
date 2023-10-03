Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4887B6B61
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 16:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239926AbjJCOYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 10:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239944AbjJCOYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 10:24:02 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D2CC4
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 07:23:58 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7118940E019B;
        Tue,  3 Oct 2023 14:23:56 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9shXMrv2E7ba; Tue,  3 Oct 2023 14:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1696343034; bh=/7dHtqiGx9BuaO6bL2PIdZTGhAuYsFEOmU9lf5AfsO8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZtsLD6wLOFhfOxfn2IIz2OjTLi8UaKzyKJA8kWLX0mS24sf7MJCOcIZ3pgXq9V3ii
         3upxjQ2dOEUVK1MRlxdOr+zpKY8sIe92l1BDrVPleAXoIt/dU3pZPN0GwZj3wWKTM6
         nEhzTSI7RlbQI5mnVY8F9MNlTr3sGPJXm3I32jOeHJjP4MzJqhnuh9X1E420YBwiZj
         DQ7Yl7JjHQEqfc9q1wtXthZgYvFbBjLGSAf+WgWWp6gzBQPNzRa3EdJwaVy3YGjjD6
         vXdlmoSU9V3Zl546/mWzanS4hM6/XgMHcV0XvlG2WMg4ngs2WpuKwtf4rf1YhvSwoy
         HnGJCovl0L03j7vVqO/xwvSnTkT2++X7Tmq2GzocH/HXxXIbg9voJpB5wK6p5J2cp3
         Yr/5cBxHpHwVLOk+L3NgFDlnZxtpTyErP8aWq3V7H1zVJgPF8+hjUnHdbSSYv/y8uH
         hRIe7a4q14GUBTkOuMQbxA/ZOOvx7nBBrkfdi2vforIuv/zGhL1/GZkfx0zQdD4TIH
         /LAu6xl3RsrejwfctFS38TUjOiGEelvudPYd5bI5kFQQTCiDbssdG37EcxQ7E8BF8e
         2U/FRyt3kpiHzA7DoIVzeXR0nMhDSvGiw802Fwd84RUCs7rkMlB3kHPAsoLEG1vPMY
         UytRhkAKdLw0QLu3eFrOFH4Y=
Received: from zn.tnic (pd953036a.dip0.t-ipconnect.de [217.83.3.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 785C740E0198;
        Tue,  3 Oct 2023 14:23:48 +0000 (UTC)
Date:   Tue, 3 Oct 2023 16:23:47 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: Re: [patch V3 12/30] x86/microcode/intel: Reuse
 intel_cpu_collect_info()
Message-ID: <20231003142347.GAZRwj83xsi80gW0OS@fat_crate.local>
References: <20230912065249.695681286@linutronix.de>
 <20230912065501.530637507@linutronix.de>
 <20230921104220.GHZQweDKyaJmkYdt4f@fat_crate.local>
 <87zg1afs23.ffs@tglx>
 <20231003141439.GAZRwhz63IqTB+uNOM@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231003141439.GAZRwhz63IqTB+uNOM@fat_crate.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 04:14:39PM +0200, Borislav Petkov wrote:
> On Mon, Sep 25, 2023 at 12:47:16PM +0200, Thomas Gleixner wrote:
> > Eew. That's a function exposed to code outside of microcode and just
> > grows that unused argument for no value and you obviously forgot to
> > fixup the extern callsite :)
> 
> It's used on AMD. Adding the below to the pile.

And now that I look at it again, exposing that "unused" arg is uglier
than having the local wrapper in the loader code. Yeah, lemme zap that.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
