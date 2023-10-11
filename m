Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB5D7C5D3B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 20:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376296AbjJKS4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 14:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235213AbjJKS4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 14:56:38 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69240ED
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 11:56:26 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2D59440E01B0;
        Wed, 11 Oct 2023 18:56:24 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id xjWCghSyIgh8; Wed, 11 Oct 2023 18:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1697050582; bh=EO+Gr9wtDatHvQMUhN4pP2pEXACbN/Jbj5OUgdQSFfA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WcKJ+OpJ/81E4AjFTeIGSWkuGOMkpXiIadE6UBuqyzDRJAsJuKKZMFw+qFf952ykj
         UblKlAjll76EcKZoDUUX15POwmW3mZz3la7hcPYMyLWtllaQcgKAZuy/aAv4WKdMQR
         iCY/EUdcIFn0ZhhoIQLjb31T9t5PIsMszykKKIGzDyuGIQJmmG9w2x241wvNlB3JGP
         4wJMgNJpeAgjdWHFsp0mkxUFWh2tUk5SyXs2eIw+ajDTqwJtz5dLu81mcOlHJNnSH0
         iCemrA4cfTaNomX2D7MsY/dK/swRGOKlVBU+ZyD5xZo+ZlIHZ2ODZSQVLld6VgcBtA
         ylXQSwSsygigtBZwzzMyKbCmr33CoCRdyve/StLZUfk6ccoj9l1ieZxedrQlI878Bj
         DPeemH3ALQ3RtuGFvPT6/TUtsMwcw623gOehsgCKdLD8RMORMUrUpdl1JcLoBr+nHE
         WQ/QJ/RXwbgc5xwGgMHx7s+pXykf9MUQjMLO3Khj/mIC8raRe2V9dfNvEqMgdkZUi+
         81CBwl/tNFf7xnABMpO0UhY4swJANfVjKezRKQq17SvTPuN7i5s0n2OLDwSDgAJzxv
         91LmfyS5Y23wzKampMJ1PySbClEBJcOhpZzv2liJadtt2Ya6oCOMah1QrY1DGrODxw
         dDnzuvtJVF3NjbcHxz43wnVw=
Received: from zn.tnic (pd953036a.dip0.t-ipconnect.de [217.83.3.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 63B8640E01AF;
        Wed, 11 Oct 2023 18:56:14 +0000 (UTC)
Date:   Wed, 11 Oct 2023 20:56:07 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Nikunj A Dadhania <nikunj@amd.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        thomas.lendacky@amd.com, dionnaglaze@google.com, pgonda@google.com,
        seanjc@google.com, pbonzini@redhat.com
Subject: Re: [PATCH v4 01/14] virt: sev-guest: Use AES GCM crypto library
Message-ID: <20231011185607.GVZSbvx8rJ8DXPqYfg@fat_crate.local>
References: <20230814055222.1056404-1-nikunj@amd.com>
 <20230814055222.1056404-2-nikunj@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230814055222.1056404-2-nikunj@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 11:22:09AM +0530, Nikunj A Dadhania wrote:
> The sev-guest driver encryption code uses Crypto API for SNP guest
> messaging to interact with AMD Security processor. For enabling SecureTSC,
> SEV-SNP guests need to send a TSC_INFO request guest message before the
> smpboot phase starts. Details from the TSC_INFO response will be used to
> program the VMSA before the secondary CPUs are brought up. The Crypto API
> is not available this early in the boot phase.
> 
> In preparation of moving the encryption code out of sev-guest driver to
> support SecureTSC and make reviewing the diff easier, start using AES GCM
> library implementation instead of Crypto API.
> 
> Link: https://lore.kernel.org/all/20221103192259.2229-1-ardb@kernel.org

Why is that Link pointing to Ard's lib?

Link tags are used to point to relevant threads regarding *this* code
- not the lib you're using...

> +static inline unsigned int get_ctx_authsize(struct snp_guest_dev *snp_dev)
> +{
> +	if (snp_dev && snp_dev->ctx)
> +		return snp_dev->ctx->authsize;
> +
> +	WARN_ONCE(1, "Unable to get crypto authsize\n");

What's the point of this?

You either fail the whole process or you succeed. What's the point of
warning and still returning 0?

What do you do when no one is looking at dmesg?

> +	return 0;
> +}
> +
>  static bool is_vmpck_empty(struct snp_guest_dev *snp_dev)
>  {
>  	char zero_key[VMPCK_KEY_LEN] = {0};
> @@ -152,132 +152,59 @@ static inline struct snp_guest_dev *to_snp_dev(struct file *file)
>  	return container_of(dev, struct snp_guest_dev, misc);
>  }
>  
> -static struct snp_guest_crypto *init_crypto(struct snp_guest_dev *snp_dev, u8 *key, size_t keylen)
> +static struct aesgcm_ctx *snp_init_crypto(u8 *key, size_t keylen)
>  {
> -	struct snp_guest_crypto *crypto;
> +	struct aesgcm_ctx *ctx;
>  
> -	crypto = kzalloc(sizeof(*crypto), GFP_KERNEL_ACCOUNT);
> -	if (!crypto)
> +	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL_ACCOUNT);
> +	if (!ctx)
>  		return NULL;
>  
> -	crypto->tfm = crypto_alloc_aead("gcm(aes)", 0, 0);
> -	if (IS_ERR(crypto->tfm))
> -		goto e_free;
> -
> -	if (crypto_aead_setkey(crypto->tfm, key, keylen))
> -		goto e_free_crypto;
> -
> -	crypto->iv_len = crypto_aead_ivsize(crypto->tfm);
> -	crypto->iv = kmalloc(crypto->iv_len, GFP_KERNEL_ACCOUNT);
> -	if (!crypto->iv)
> -		goto e_free_crypto;
> -
> -	if (crypto_aead_authsize(crypto->tfm) > MAX_AUTHTAG_LEN) {
> -		if (crypto_aead_setauthsize(crypto->tfm, MAX_AUTHTAG_LEN)) {
> -			dev_err(snp_dev->dev, "failed to set authsize to %d\n", MAX_AUTHTAG_LEN);
> -			goto e_free_iv;
> -		}
> +	if (aesgcm_expandkey(ctx, key, keylen, AUTHTAG_LEN)) {
> +		pr_err("SNP: crypto init failed\n");

This driver should already be printing with "sev-guest:" prefix - no
need for "SNP:" too.

> +		kfree(ctx);
> +		return NULL;
>  	}

...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
