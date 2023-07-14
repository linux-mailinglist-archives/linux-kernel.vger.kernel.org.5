Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED8B7535B1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 10:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235667AbjGNIwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 04:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235618AbjGNIwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 04:52:10 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F2430E0;
        Fri, 14 Jul 2023 01:52:08 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qKEWv-001Rdg-L3; Fri, 14 Jul 2023 18:52:02 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 14 Jul 2023 18:51:54 +1000
Date:   Fri, 14 Jul 2023 18:51:54 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        davem@davemloft.net, ebiggers@kernel.org, x86@kernel.org,
        tglx@linutronix.de, mingo@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com
Subject: Re: [PATCH] crypto: x86/aesni: Align the address before
 aes_set_key_common()
Message-ID: <ZLEMqvdeKXOV0AbG@gondor.apana.org.au>
References: <f1093780-cdda-35ec-3ef1-e5fab4139bef@intel.com>
 <20230621120653.121759-1-chang.seok.bae@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621120653.121759-1-chang.seok.bae@intel.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 05:06:53AM -0700, Chang S. Bae wrote:
> aes_set_key_common() performs runtime alignment to the void *raw_ctx
> pointer. This facilitates consistent access to the 16byte-aligned
> address during key extension.
> 
> However, the alignment is already handlded in the GCM-related setkey
> functions before invoking the common function. Consequently, the
> alignment in the common function is unnecessary for those functions.
> 
> To establish a consistent approach throughout the glue code, remove
> the aes_ctx() call from its current location. Instead, place it at
> each call site where the runtime alignment is currently absent.
> 
> Link: https://lore.kernel.org/lkml/20230605024623.GA4653@quark.localdomain/
> Suggested-by: Eric Biggers <ebiggers@kernel.org>
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> Cc: linux-crypto@vger.kernel.org
> Cc: x86@kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
> The need for this fix was discovered during Eric's review of the Key
> Locker series [1]. Considering the upstream code also requires this
> improvement, this is applicable regardless of the Key Locker enabling
> [2].
> 
> [1] https://lore.kernel.org/lkml/20230605024623.GA4653@quark.localdomain/
> [2] https://lore.kernel.org/lkml/f1093780-cdda-35ec-3ef1-e5fab4139bef@intel.com/
> ---
>  arch/x86/crypto/aesni-intel_glue.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
