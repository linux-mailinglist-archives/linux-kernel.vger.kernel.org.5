Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2DCF809AC5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 05:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235582AbjLHEEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 23:04:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjLHEEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 23:04:23 -0500
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394EB1712;
        Thu,  7 Dec 2023 20:04:29 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1rBS66-008Ias-LB; Fri, 08 Dec 2023 12:04:19 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 08 Dec 2023 12:04:28 +0800
Date:   Fri, 8 Dec 2023 12:04:28 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] crypto: ccp - fix memleak in ccp_init_dm_workarea
Message-ID: <ZXKVzGnviCY5Hb6+@gondor.apana.org.au>
References: <20231127034710.23413-1-dinghao.liu@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127034710.23413-1-dinghao.liu@zju.edu.cn>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 11:47:10AM +0800, Dinghao Liu wrote:
> When dma_map_single() fails, wa->address is supposed to be freed
> by the callers of ccp_init_dm_workarea() through ccp_dm_free().
> However, many of the call spots don't expect to have to call
> ccp_dm_free() on failure of ccp_init_dm_workarea(), which may
> lead to a memleak. Let's free wa->address in ccp_init_dm_workarea()
> when dma_map_single() fails.
> 
> Fixes: 63b945091a07 ("crypto: ccp - CCP device driver and interface support")
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
> 
> Changelog:
> 
> v2: -Improve the commit message.
>     -Set wa->address to NULL after kfree() to prevent double-free.
> ---
>  drivers/crypto/ccp/ccp-ops.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
