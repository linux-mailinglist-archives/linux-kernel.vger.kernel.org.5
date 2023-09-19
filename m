Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A267A663F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 16:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbjISOON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 10:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbjISOOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 10:14:11 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5A110C1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 07:14:05 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1910340E01A3;
        Tue, 19 Sep 2023 14:14:04 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id o68-Xfl0irPS; Tue, 19 Sep 2023 14:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1695132841; bh=xslIfg9U+Ps06lByqzoJtS4Q//KQIsbuCKNo4YAAC7o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cFAwY1fThYx8Qe28aeGNErDKD1fX0MIHjwtBwnpSw/AoGtkEuHSFhkH1igeNejptI
         r7C2gGsnkL3MDU4lkFUNkEpMHLMUQDSF1zEWEkAtzIIYprhEubBoDBDawhA2FtWXo3
         T4YhBr87wigQQopABV49YE8p5MEwDwReKc7KiBNIUQOgxbqYXHO0CalCoD3yRfWypj
         UYt4IbYnTNYwcnNsThrz3OCcjxMcCb4PX7CQoIl9/XBxlzgwCrRDHlVq+q81/XGNAR
         5V+5wsx1liTjHkxFgFkibNPNatxnGYIFEN21WdSPl10lTIPXQu/9gLXiFFJft7bPbm
         rBaGJw6f6V8LYq8cQn2UN3R2f6y8Z+CR7t3/RdCjyxdPlIt0NbvifcSnXfCO/WRoon
         8R+FkPJ2cABvryH1HbY1tpqP13LK3vHcCyf44B++qOihyiFvVIoFe8zEQWppkrk6JC
         5T/keJ3Vr7X2JZq68b+IF8HJzMyVQOg728+RO2FHOOY+p8kYXBdJJLUwaEf/pbRr53
         s+2opdpJC4O+xTLkPwjghJV8FVgrfGoCcunQOHDKygCqTGtpjux9uVtr64LOQPZrhC
         5y4WIgO/pMmqxnq5tk4xYv3X0DyUwogrJN3u0LN9XwO06hZSR/ME9zzTq8Ql+oj3HQ
         wg8prvt43phvCz1SFVkHseGQ=
Received: from zn.tnic (pd953036a.dip0.t-ipconnect.de [217.83.3.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9878C40E0140;
        Tue, 19 Sep 2023 14:13:55 +0000 (UTC)
Date:   Tue, 19 Sep 2023 16:13:54 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: Re: [patch V3 06/30] x86/microcode/intel: Cleanup code further
Message-ID: <20230919141354.GCZQmsolxkMSUp1OEe@fat_crate.local>
References: <20230912065249.695681286@linutronix.de>
 <20230912065501.146684094@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230912065501.146684094@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 09:57:52AM +0200, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Sanitize the microcode scan loop, fixup printks and move the initrd loading

The "builtin". Yeah, we support builtin microcode loading too. ;-\

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
