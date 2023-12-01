Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D87BD80070A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 10:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378072AbjLAJb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 04:31:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378042AbjLAJbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 04:31:07 -0500
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2080173B;
        Fri,  1 Dec 2023 01:28:00 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1r8znq-005gYB-SE; Fri, 01 Dec 2023 17:27:19 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 01 Dec 2023 17:27:28 +0800
Date:   Fri, 1 Dec 2023 17:27:28 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
Cc:     davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, seanjc@google.com, kim.phillips@amd.com,
        pbonzini@redhat.com, babu.moger@amd.com,
        jiaxi.chen@linux.intel.com, jmattson@google.com,
        pawan.kumar.gupta@linux.intel.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, CobeChen@zhaoxin.com,
        TonyWWang@zhaoxin.com, YunShen@zhaoxin.com, Leoliu@zhaoxin.com
Subject: Re: [PATCH v3] crypto: x86/sm2 -add Zhaoxin SM2 algorithm
 implementation
Message-ID: <ZWmnAPlJrkaNE4QF@gondor.apana.org.au>
References: <20231109094744.545887-1-LeoLiu-oc@zhaoxin.com>
 <20231122064355.638946-1-LeoLiu-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122064355.638946-1-LeoLiu-oc@zhaoxin.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 02:43:55PM +0800, LeoLiu-oc wrote:
> From: LeoLiuoc <LeoLiu-oc@zhaoxin.com>
> 
> Add support for SM2 (ShangMi 2) public key algorithm by Zhaoxin GMI
> Instruction. The purpose of this driver is to ensure that the application
> has both high performance and high security.
> 
> ---
> 
> v1 -> v2:
> 1. The assembly code is modified to be embedded in the .c file.
> 2. Optimize code style and details.
> 
> v2 -> v3:
> 1. Increase compatibility with i386 architecture.
> 2. Optimize variable and return value types in some functions..
> 
> Signed-off-by: LeoLiuoc <LeoLiu-oc@zhaoxin.com>
> ---
>  arch/x86/crypto/Kconfig                |  11 ++
>  arch/x86/crypto/Makefile               |   2 +
>  arch/x86/crypto/sm2-zhaoxin-gmi_glue.c | 158 +++++++++++++++++++++++++
>  arch/x86/include/asm/cpufeatures.h     |   2 +
>  4 files changed, 173 insertions(+)
>  create mode 100644 arch/x86/crypto/sm2-zhaoxin-gmi_glue.c
> 
> diff --git a/arch/x86/crypto/Kconfig b/arch/x86/crypto/Kconfig
> index 9bbfd01cfa2f..974d4c3806ff 100644
> --- a/arch/x86/crypto/Kconfig
> +++ b/arch/x86/crypto/Kconfig
> @@ -519,4 +519,15 @@ config CRYPTO_CRCT10DIF_PCLMUL
>  	  Architecture: x86_64 using:
>  	  - PCLMULQDQ (carry-less multiplication)
>  
> +config CRYPTO_SM2_ZHAOXIN_GMI
> +	tristate "SM2 Cipher algorithm (Zhaoxin GMI Instruction)"
> +	depends on X86 && (CPU_SUP_CENTAUR || CPU_SUP_ZHAOXIN)
> +	select CRYPTO_AKCIPHER
> +	select CRYPTO_MANAGER

Why does this depend on CRYPTO_MANAGER?

> +static int zhaoxin_sm2_verify(struct akcipher_request *req)
> +{
> +	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
> +	struct sm2_cipher_data *ec = akcipher_tfm_ctx(tfm);
> +	unsigned char *buffer;
> +	int ret, buf_len;
> +
> +	buf_len = req->src_len + req->dst_len;

What if this overflows? I know you copied this from the generic sm2
code, but that's still broken and both should be fixed up.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
