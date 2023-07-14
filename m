Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 018DD75358B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 10:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235462AbjGNIuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 04:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235439AbjGNIuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 04:50:23 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78C12710;
        Fri, 14 Jul 2023 01:50:18 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qKEV3-001RdB-GM; Fri, 14 Jul 2023 18:50:06 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 14 Jul 2023 18:49:58 +1000
Date:   Fri, 14 Jul 2023 18:49:58 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Danny Tsen <dtsen@linux.ibm.com>
Cc:     linux-crypto@vger.kernel.org, leitao@debian.org,
        nayna@linux.ibm.com, appro@cryptogams.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        mpe@ellerman.id.au, ltcgcw@linux.vnet.ibm.com, dtsen@us.ibm.com
Subject: Re: [PATCH v2 0/5] crypto: Accelerated Chacha20/Poly1305
 implementation
Message-ID: <ZLEMNpZ4M4U/4t6j@gondor.apana.org.au>
References: <20230426191147.60610-1-dtsen@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230426191147.60610-1-dtsen@linux.ibm.com>
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

On Wed, Apr 26, 2023 at 03:11:42PM -0400, Danny Tsen wrote:
> This patch series provide an accelerated/optimized Chacha20 and Poly1305
> implementation for Power10 or later CPU (ppc64le).  This module
> implements algorithm specified in RFC7539.  The implementation
> provides 3.5X better performance than the baseline for Chacha20 and
> Poly1305 individually and 1.5X improvement for Chacha20/Poly1305
> operation.
> 
> This patch has been tested with the kernel crypto module tcrypt.ko and
> has passed the selftest.  The patch is also tested with
> CONFIG_CRYPTO_MANAGER_EXTRA_TESTS enabled.
> 
> 
> Danny Tsen (5):
>   An optimized Chacha20 implementation with 8-way unrolling for ppc64le.
>   Glue code for optmized Chacha20 implementation for ppc64le.
>   An optimized Poly1305 implementation with 4-way unrolling for ppc64le.
>   Glue code for optmized Poly1305 implementation for ppc64le.
>   Update Kconfig and Makefile.
> 
>  arch/powerpc/crypto/Kconfig             |   26 +
>  arch/powerpc/crypto/Makefile            |    4 +
>  arch/powerpc/crypto/chacha-p10-glue.c   |  221 +++++
>  arch/powerpc/crypto/chacha-p10le-8x.S   |  842 ++++++++++++++++++
>  arch/powerpc/crypto/poly1305-p10-glue.c |  186 ++++
>  arch/powerpc/crypto/poly1305-p10le_64.S | 1075 +++++++++++++++++++++++
>  6 files changed, 2354 insertions(+)
>  create mode 100644 arch/powerpc/crypto/chacha-p10-glue.c
>  create mode 100644 arch/powerpc/crypto/chacha-p10le-8x.S
>  create mode 100644 arch/powerpc/crypto/poly1305-p10-glue.c
>  create mode 100644 arch/powerpc/crypto/poly1305-p10le_64.S
> 
> -- 
> 2.31.1

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
