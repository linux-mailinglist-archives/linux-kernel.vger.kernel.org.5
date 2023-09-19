Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C067A66C1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 16:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbjISOc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 10:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232804AbjISOcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 10:32:55 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95B283
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 07:32:48 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C2C3B40E01A2;
        Tue, 19 Sep 2023 14:32:46 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id wTs37xPUpq0S; Tue, 19 Sep 2023 14:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1695133961; bh=2BzkiaBN5bZ1a884LQzJAvYbzoGhiXpowiFpBa3/2Yk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J27WBG70Xe/ZNwuTRVOHMVM1xccKZ3wMj+LzxecyDTpKXFtA9drLu46dkQXeDhMfu
         tIGjbTpJqu3NRcgVeNlXfUgx4sv8mrH7jOfxECrM9UMay65ntDDcgIqrXGy5o0Mlgm
         gjHAmW90tzfr1+vRNH2fjkRPip2i5jVPoN+2DRUgDjQqepna+C7lLJk6opByd/csIp
         bzhPa5e/VSmLzdpJwQh+qTEpbTgz6j6Q+nHPyUGo+Rv4WrrOIfteb0Jnd7kbxxYU3z
         7NGr9YrjEjFnaygyaW3QDpSxKiBDuoPPkyToJLSj+v6iQOXFt6i0G2vRE7wcZ8T1B1
         8KFh1rE2pxcetoW1SS3JMPEcCon4NQPilxtYHUedCWbwkVcT8WfRX+/S8n+cX8KGbk
         5wswlND06qodrU00ypqo+H5k1JmgR/tfgIlVvoGmgbMNYb/xIYQBZluilH1yqwjZlq
         DWewozP/pEhWNbNhFfI7wzU1IxVsxSXG25J7SJQ6c8/95JJ705zGiEbmxCuzdi4f4e
         MZPYxPPuWLyStLcmOOR+RMk4B6m7yXLPbRmHp94C9dD766QrgYyZvx8SuCw2NVjrtt
         LjitM4MhV0H80Kt6ttFTz8WRwELqsh7LWUkJWy68ryxtlH0q+jcvUbpMZfSiNJt7dA
         3fMK104VPfllBVO0uyOvT580=
Received: from zn.tnic (pd953036a.dip0.t-ipconnect.de [217.83.3.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A559340E01A8;
        Tue, 19 Sep 2023 14:32:35 +0000 (UTC)
Date:   Tue, 19 Sep 2023 16:32:30 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: Re: [patch V3 07/30] x86/microcode/intel: Simplify early loading
Message-ID: <20230919143230.GDZQmw/kLc5nyu9CZV@fat_crate.local>
References: <20230912065249.695681286@linutronix.de>
 <20230912065501.208060138@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230912065501.208060138@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 09:57:54AM +0200, Thomas Gleixner wrote:
> @@ -361,89 +356,75 @@ static bool load_builtin_intel_microcode
>  	return false;
>  }
>  
> -int __init save_microcode_in_initrd_intel(void)
> +static __init struct microcode_intel *get_ucode_from_cpio(struct ucode_cpu_info *uci)

This is not only cpio but the builtin crap too. Just call it
load_microcode_blobs() or so.

...

> -static struct microcode_intel *__load_ucode_intel(struct ucode_cpu_info *uci)
> +static int __init save_microcode_from_cpio(void)
>  {
> -	struct cpio_data cp;
> -
> -	/* try built-in microcode first */
> -	if (!load_builtin_intel_microcode(&cp))
> -		cp = find_microcode_in_initrd(ucode_path);
> -
> -	if (!(cp.data && cp.size))
> -		return NULL;
> +	struct microcode_intel *mc;
>  
> -	intel_cpu_collect_info(uci);
> +	if (!ucode_early_pa)
> +		return 0;
>  
> -	return scan_microcode(cp.data, cp.size, uci, false);
> +	mc = __va((void *)ucode_early_pa);
> +	save_microcode_patch(mc);
> +	return 0;
>  }
> +early_initcall(save_microcode_from_cpio);
>  
> +/* Load microcode on BSP from CPIO */

Yeah, no need to say "from CPIO" everywhere. We load it from somewhere,
it can be cpio but it can be builtin too.

But I can fix up too when applying.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
