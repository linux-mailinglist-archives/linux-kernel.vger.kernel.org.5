Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 264267D95C3
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 12:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345707AbjJ0K50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 06:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345539AbjJ0K5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 06:57:24 -0400
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7026F9C;
        Fri, 27 Oct 2023 03:57:22 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qwKWj-00BegP-RR; Fri, 27 Oct 2023 18:57:18 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 27 Oct 2023 18:57:24 +0800
Date:   Fri, 27 Oct 2023 18:57:24 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] crypto: pkcs7 x509 add FIPS 202 SHA-3 support
Message-ID: <ZTuXlGsYsmvO6v+M@gondor.apana.org.au>
References: <20231022182208.188714-1-dimitri.ledkov@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231022182208.188714-1-dimitri.ledkov@canonical.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 22, 2023 at 07:22:02PM +0100, Dimitri John Ledkov wrote:
> Recent patches to cryptodev removed support for insecure, broken or
> weak x509/pkcs7 signing hashes MD4, MD5, SHA1, SHA-224. This opens
> room to add SHA-3 family of hashes, which are not yet broken.
> 
> Add support for FIPS 202 SHA-3 in x509 RSA & ECC certs, pkcs7
> signatures, hash info structs. And adjust documentation.
> 
> This enables using SHA-3 family of hashes for kernel module signing.
> 
> For SHA3+ECC signing openssl with this patch [0] is needed, currently
> in openssl development tip. SHA3+RSA signing is supported by stable
> openssl.
> 
> kmod needs a patch to recognise SHA3 hash names [1], submitted
> separately.
> 
> This patch series is on top of tip of cryptodev git repository commit
> a2786e8bdd ("crypto: qcom-rng - Add missing dependency on hw_random")
> 
> [0] https://github.com/openssl/openssl/pull/22147/files
> [1] https://lore.kernel.org/all/20231022180928.180437-1-dimitri.ledkov@canonical.com/
> 
> Dimitri John Ledkov (6):
>   x509: Add OIDs for FIPS 202 SHA-3 hash and signatures
>   crypto: FIPS 202 SHA-3 register in hash info for IMA
>   crypto: rsa-pkcs1pad - Add FIPS 202 SHA-3 support
>   crypto: x509 pkcs7 - allow FIPS 202 SHA-3 signatures
>   crypto: enable automatic module signing with FIPS 202 SHA-3
>   Documentation/module-signing.txt: bring up to date
> 
>  Documentation/admin-guide/module-signing.rst | 17 ++++++++-----
>  certs/Kconfig                                |  2 +-
>  crypto/asymmetric_keys/mscode_parser.c       |  9 +++++++
>  crypto/asymmetric_keys/pkcs7_parser.c        | 12 ++++++++++
>  crypto/asymmetric_keys/public_key.c          |  5 +++-
>  crypto/asymmetric_keys/x509_cert_parser.c    | 24 +++++++++++++++++++
>  crypto/hash_info.c                           |  6 +++++
>  crypto/rsa-pkcs1pad.c                        | 25 +++++++++++++++++++-
>  crypto/testmgr.c                             | 12 ++++++++++
>  include/crypto/hash_info.h                   |  1 +
>  include/linux/oid_registry.h                 | 11 +++++++++
>  include/uapi/linux/hash_info.h               |  3 +++
>  kernel/module/Kconfig                        | 15 ++++++++++++
>  13 files changed, 133 insertions(+), 9 deletions(-)
> 
> -- 
> 2.34.1

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
