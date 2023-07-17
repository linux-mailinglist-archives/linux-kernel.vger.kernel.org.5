Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8255A756ED5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 23:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbjGQVP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 17:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjGQVPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 17:15:55 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ABA4F3;
        Mon, 17 Jul 2023 14:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1689628551; bh=aykiJeEyynq6EQjWV0Y3bk+J73cLE6yf17a01KGynCc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qKBTZH8ETNgNA2LVTp75YYVZAURhCrFzye9lWlWKwlEnzi+TEHP0PMbt5+0EwM0tS
         UqC82dVVd109sAwHtWrfWdMDjI0AYlP0A+ANs79c4lky8ryDsRv9c516If5BhJePV9
         7Gy3piku64llOz5uRySr+PJRfEOtQSDJkedXOylI=
Date:   Mon, 17 Jul 2023 23:15:50 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Leesoo Ahn <lsahn@ooseel.net>
Cc:     lsahn@wewakecorp.com, Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selinux: optimize major part with a kernel config in
 selinux_mmap_addr()
Message-ID: <505b3356-4bb3-42b9-a4fd-92b097a93e1e@t-8ch.de>
References: <20230710082500.1838896-1-lsahn@wewakecorp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710082500.1838896-1-lsahn@wewakecorp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-07-10 17:25:00+0900, Leesoo Ahn wrote:
> The major part, the conditional branch in selinux_mmap_addr() is always to be
> false so long as CONFIG_LSM_MMAP_MIN_ADDR is set to zero at compile time.
> 
> This usually happens in some linux distros, for instance Ubuntu, which
> the config is set to zero in release version. Therefore it could be a bit
> optimized with '#if <expr>' at compile time.
> 
> Signed-off-by: Leesoo Ahn <lsahn@wewakecorp.com>
> ---
>  security/selinux/hooks.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index d06e350fedee..a049aab6524b 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3723,11 +3723,13 @@ static int selinux_mmap_addr(unsigned long addr)
>  {
>  	int rc = 0;
>  
> +#if CONFIG_LSM_MMAP_MIN_ADDR > 0
>  	if (addr < CONFIG_LSM_MMAP_MIN_ADDR) {
>  		u32 sid = current_sid();
>  		rc = avc_has_perm(sid, sid, SECCLASS_MEMPROTECT,
>  				  MEMPROTECT__MMAP_ZERO, NULL);
>  	}
> +#endif

Shouldn't the compiler figure out on its own that "0 < 0" is always
false and optimize it all away? My gcc 13.1.1 does so.

Without your change:

$ ./scripts/bloat-o-meter  security/selinux/hooks.o-min-addr-64k security/selinux/hooks.o-min-addr-0
add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-65 (-65)
Function                                     old     new   delta
selinux_mmap_addr                             81      16     -65
Total: Before=57673, After=57608, chg -0.11%

The same with your patch and also with the proposal by Paul that
redefines the whole function to "return 0".
