Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D6C773119
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 23:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjHGVRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 17:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjHGVRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 17:17:20 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C651715
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 14:17:19 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 03A5D40E0197;
        Mon,  7 Aug 2023 21:17:17 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id o5u-WEMUzBeW; Mon,  7 Aug 2023 21:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1691443034; bh=J0eA2UqHFMwv+jFBzrbdJSwAYutp1v1yRYopctxZwOM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FBhZeKJl+V4yKj5+eZYFfG4EAcJ97wAqWZwDQGCnu5Qxbznfm5VFZnQrlUFYInrBx
         IeuSSvljsoRMOVHBp0VboRTUwRKKRqaoat/XUXoa5XFlJg5SuSPi3DXF7HTE7Qp9Aj
         ap2j7MKcRvDtf0R70SxBfa0HreiPFcIFNivomqNGJsYLMxPhV9+11+mNJi5Oeofda7
         xfqwcYAcFACFUHBScfbtaGhristD6T887rrvlVO1HmiSAnMJvsPP+P6avmCikDDILY
         7GJUjUkiVo4UlUU/2YnHCDqtlhloxiKLHldHqKWeuQkPSM63eJWzvpjjNHPTGG4uw0
         ZHtamx+D/Hfgp+1R2M8D1Ffd1WZmKfsMgYrL8j+6vcdPw9g/MEYsLx4IxWfE6nZzs1
         Uvzq+fZyCCB+yu17JrqMlvadnkJKct2fZfZiAV4ItQvGdSaWQqno1srOl/N7bP4RYm
         tEqe8nxO4sYIFTQHIywyUq00XmOwQ7afZsbAe8Y7XsiByqh/5/63j9tS8JnO9TjLzd
         naxxzCc96YoZskb2N7gju0mgA/21Zg5miUNLJBU+MsjuZSaR4vT7ng2iEYzSl1ZPhY
         1arTG1nqPGowmtKiDE5yNmTiuhk84QQ7EiZqtXffKhgNaftf6lvLqZvYm5gMeGtxGl
         xW+griy2NiTAMxjGiSoBHbRI=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 30B2440E018F;
        Mon,  7 Aug 2023 21:17:05 +0000 (UTC)
Date:   Mon, 7 Aug 2023 23:16:59 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 2/5] [RESEND] x86: avoid unneeded __div64_32 function
 definition
Message-ID: <20230807211659.GKZNFfS+7PK71yYt0p@fat_crate.local>
References: <20230725134837.1534228-1-arnd@kernel.org>
 <20230725134837.1534228-3-arnd@kernel.org>
 <20230801170315.GGZMk60zojZOeuUwX7@fat_crate.local>
 <baf750f4-a42c-453a-91dc-7fd457bc1e80@app.fastmail.com>
 <20230802172030.GEZMqQXmeb98Tm+Qhg@fat_crate.local>
 <alpine.DEB.2.21.2308072124320.38537@angie.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2308072124320.38537@angie.orcam.me.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 09:37:00PM +0100, Maciej W. Rozycki wrote:
>  Otherwise you risk `__div64_32(n, base)' getting expanded to `(n, base)', 

You mean in the very obscure case of a 32-bit kernel where they don't call
do_div() but call this low level function?

I'd say if they can't be bothered to even grep the tree for the right usage,
they deserve both pieces... :)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
