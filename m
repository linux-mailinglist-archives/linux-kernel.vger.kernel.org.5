Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B637AB5D0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 18:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbjIVQYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 12:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjIVQYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 12:24:45 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ABF2AC
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 09:24:40 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4959F40E014B;
        Fri, 22 Sep 2023 16:24:38 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id TIzGViwPsv4e; Fri, 22 Sep 2023 16:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1695399876; bh=oMM3XZ8Bu5bBw3attGNnnJFGCWMMT33xDE5tdnNkSII=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NudtE7DMqADXX9VZzWp6d5YZ5AqGQzQnJJ3efHDSsa1UY8NgeGRHslw1H7e2ZfcL7
         Sgx3UiOg243ywyTl9rdIp7TnEu9ufrM8R5hGKLQGzBaceuHdXeXEF15DbBmjJx1LPE
         eQhsHvbM3RRyHvnHgQomsHp6RcNnWenu2RsSsn/HUoV/v1sF6EDibej0RYE0534kuS
         izTou8vq6/oDjpgfTylB0fqJYLWWVhj3Q1C8+iabNK+dbiq3ut1kXoSkOVKc8vfFRs
         h9UuHk8wpcEl9ym1KS2MdECGv4AJetT5J+lak8YPOhm2w8/KpGd5b8slzPZcnBAeVA
         opIPNeVDf2SQs7H8dudFptHKbk1KVxBNrZ6MW6P2pGd/OKhlxiKaBxY24Q7DoC8aHG
         h2g+4FU0IY+6joHCCSMEpKNvYChlJdxhRZacd+N7di0XACQ0S6obhI+JjTuB3WK2zR
         Z++0+0rpzctBhJrHtKVOvWw213OWmWX/MYdXKO9Wl9Yuj5zkv3J0lN/gf47OKUiEbO
         r1Hrc0tTAtYPdcPXDEPMDsNPemXgmKAroZvClsOURYQKD4o5Uqb8c9LLCSk7rwIG7b
         AT0A+IqTsYl9GxNhCRhX824FiF35Uu5RwWFt9mr9Mf/MpowwkL5obDlF1t5uvyxkEZ
         U/urAtFxpRqcG2EoZlhIK7S0=
Received: from zn.tnic (pd953036a.dip0.t-ipconnect.de [217.83.3.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3A23E40E0081;
        Fri, 22 Sep 2023 16:24:30 +0000 (UTC)
Date:   Fri, 22 Sep 2023 18:24:29 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: Re: [patch V3 20/30] x86/microcode: Sanitize __wait_for_cpus()
Message-ID: <20230922162429.GKZQ2/vfYY21ty5bqR@fat_crate.local>
References: <20230912065249.695681286@linutronix.de>
 <20230912065502.022650614@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230912065502.022650614@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 09:58:15AM +0200, Thomas Gleixner wrote:
> +	for (timeout = 0; timeout < USEC_PER_SEC; timeout++) {
> +		if (!atomic_read(cnt))
> +			return true;

<---- newline here.

> +		udelay(1);

And here.

Otherwise it looks too crammed.

> +		if (!(timeout % 1000))

MSEC_PER_SEC - no naked numbers pls.

> +			touch_nmi_watchdog();
>  	}
> -	return 0;
> +	/* Prevent the late comers to make progress and let them time out */

s/to make progress/from making progress/

Nice, otherwise.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
