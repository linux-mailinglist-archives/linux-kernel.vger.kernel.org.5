Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED8F47F64D1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 18:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345339AbjKWRFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 12:05:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345287AbjKWRFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 12:05:43 -0500
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81641CB;
        Thu, 23 Nov 2023 09:05:49 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id DC5AA40E0195;
        Thu, 23 Nov 2023 17:05:46 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id hkozHP8UPGsA; Thu, 23 Nov 2023 17:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1700759144; bh=N6866AyEk35D3wyeN4/vh+11Z3gBWRfsdLnGQ+oqXnQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dm404St8Ku72srXLveKuecYQnT42cRmgEOYx2yddvOQTFEIFKifpkChBzp044mTVV
         PVZKbEcpvF0Da9qaFK43oz7ZEEDW4QxnvMzI6ZmReZCONkYqayGLhmkBw+ZxnQCnJ5
         Dc/aVRqGOYBcYZM4yChX886EXhjilXczZL+9ezyzkJ+a0PK6hGjJ82/JF6EAHM3v/5
         aOQ+4W1vnepmsYrPmyWX2Mf9XhZ5QX+QWoI+p1YHxr7s0BJ+OypPn8Vkk2+vzJUD8C
         e3ZkMhqOUMTHJU14rDQkCQ4Z76UPvKdDsf/N8ipmtwHO0WkBr1w+8bX/fwitAren0c
         9SJYSKEygE7JYfENnWee7iAmwiLYJbw0iWps2thT1J3MzIzesjDzSwlR4XR+v0q887
         3CNPM/8vfb1jMM8IY4BPhmHj4TjRsVWdWVzl2xMrySb5mcontKhjruNtEWBNQpp/ZP
         3WTbKho0GDSTDoazvBHcs8A8yRLp52tEe+3DOnvUBBZG94wnaCNGaCqfMFzKt6zu0C
         HFqpN9rEJ9cOytxv6JkU4Xj6E79ynE/hDEqsEYwrBPycN8i4VRyEilgdmUvY7hm/a3
         92vpvWGhvuWIts1vIbA6dFnzo8B8cwSygQIHLnY+KzL6sqL60ywoBUoS1EnIPzOD2Z
         0l+Qlq59EgoByv4WihS9hsic=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1A4BB40E014B;
        Thu, 23 Nov 2023 17:05:32 +0000 (UTC)
Date:   Thu, 23 Nov 2023 18:05:27 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Robert Richter <rric@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Sergey Temerkhanov <s.temerkhanov@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Yeqi Fu <asuk4.q@gmail.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC, thunderx: fix possible out-of-bounds string access.
Message-ID: <20231123170527.GGZV+GV+OKjHfdZiQR@fat_crate.local>
References: <20231122222007.3199885-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231122222007.3199885-1-arnd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 11:19:53PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Commit 1b56c90018f0 ("Makefile: Enable -Wstringop-overflow globally") exposes a
> warning for a common bug in the usage of strncat():
> 
> drivers/edac/thunderx_edac.c: In function 'thunderx_ocx_com_threaded_isr':
> drivers/edac/thunderx_edac.c:1136:17: error: 'strncat' specified bound 1024 equals destination size [-Werror=stringop-overflow=]
>  1136 |                 strncat(msg, other, OCX_MESSAGE_SIZE);
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/edac/thunderx_edac.c:1145:33: error: 'strncat' specified bound 1024 equals destination size [-Werror=stringop-overflow=]
>  1145 |                                 strncat(msg, other, OCX_MESSAGE_SIZE);
>       |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/edac/thunderx_edac.c:1150:33: error: 'strncat' specified bound 1024 equals destination size [-Werror=stringop-overflow=]
>  1150 |                                 strncat(msg, other, OCX_MESSAGE_SIZE);
>       |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/edac/thunderx_edac.c: In function 'thunderx_l2c_threaded_isr':
> drivers/edac/thunderx_edac.c:1899:17: error: 'strncat' specified bound 1024 equals destination size [-Werror=stringop-overflow=]
>  1899 |                 strncat(msg, other, L2C_MESSAGE_SIZE);
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/edac/thunderx_edac.c: In function 'thunderx_ocx_lnk_threaded_isr':
> drivers/edac/thunderx_edac.c:1220:17: error: 'strncat' specified bound 1024 equals destination size [-Werror=stringop-overflow=]
>  1220 |                 strncat(msg, other, OCX_MESSAGE_SIZE);
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Apparently the author of this driver expected strncat() to behave the
> way that strlcat() does, which uses the size of the destination buffer
> as its third argument rather than the length of the source buffer.
> The result is that there is no check on the size of the allocated
> buffer.
> 
> Change it to use strncat().
> 
> Fixes: 41003396f932 ("EDAC, thunderx: Add Cavium ThunderX EDAC driver")
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/edac/thunderx_edac.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
