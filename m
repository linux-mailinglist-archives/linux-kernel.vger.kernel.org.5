Return-Path: <linux-kernel+bounces-162721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B68A98B5F91
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDAC21C21587
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24937126F1D;
	Mon, 29 Apr 2024 17:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="drvU758E"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A8D86136
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 17:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714410310; cv=none; b=NJRTwVnxQFjvd4FymVJIGwAUV4Qc68djRT+aCpJ2JpKEYCEiEf2h1lc5d4Ckp7T9ey2p/Bj/aeGVIzg5B7o/aq97xMxxS4Lm9PdJgfhp6lVdYc1rbUkG6fH8o54w2FxhmQqZ2HM3W8SGU6LQWHe+9NBM09BNRBx9nSSRsdPejm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714410310; c=relaxed/simple;
	bh=MN4P/h1kq1Q02r/Lhf7jm0fR1hoE8r8RghANUoLDXuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJ7fS/aArZgyI5tUo39Bsi3y3n8ljdGiyoRd7VqiHTybMzxl+iQSY/k8lOzzU+yRa9oGD7X3HBBnx4Il/UAaVEHQiQ8jwd3+YCBlk4nO5dl5m+4avVOmP/Qupgwy/29bf/dVwrjoPcmS5o6HEd9jmTLf763nsjSt3fGdCySN3IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=drvU758E; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7daa6bfe4c8so198013939f.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 10:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714410306; x=1715015106; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NjIM1YsOHJSXus8VNmDaNi8MZ1j7PDi3kmS0uCHnMmg=;
        b=drvU758EbpECeq2zHD9OBmPsG9kodvQQ/Zo8huvVjKVTaiciYwoHFmriEPJlxU1aB0
         6UKB0Pof0r7fGmdG3fNTp9j7xcY2KonHy+QIQ8h8Nu9nMrnuKzbKkyeht/BQUqCuLAie
         ar0NvmSl73jVBq/CAdctJ7V0MZla8b9CDO+Hg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714410306; x=1715015106;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NjIM1YsOHJSXus8VNmDaNi8MZ1j7PDi3kmS0uCHnMmg=;
        b=smASY3U5zjgwVff/msSydGGvg2YwL7SkK0y81E0fXxm345serHmcaEe2PzZnBcO2Ef
         phQGAfV2XLXQSICNpA6HezAS6L4YZWvhpAl1SLMSvcNbNCHTO/FCoLCEDCBEYy7fdRY6
         QOuFYR8VVaQeqvV/p00Zl8ejxjk2LJLX06M2/iAzLhEXs4/hF4wkelZbiss5d8nwTztZ
         bos2ecvcmhtuJ/s4gu5R/6Id3vABn48lI5i8QXnR8EW1RFrKqeX//JUuuZKPOXVkeVs1
         RK0J2+kmz2bG3YLoY35J6AfleSUpUJeciOVe5DjoAoURqnbZWOBr9F2QjY+asAlxo/nD
         CXOw==
X-Forwarded-Encrypted: i=1; AJvYcCU33lnKUmTw8FidmVWSDCsvRDi6CcKsu65Ax86eQltDJeroTlFKTbQ44Rcm1jUQt6HFIEek6e93PAqccJjNf6fkroh8gA5w5i+Gc8wB
X-Gm-Message-State: AOJu0Yxe7aQ90TvaTy8Odju09OdxTBWFV2YgWRedoNU2ToIwrHeGPRy0
	1cwNHfMsLt2ZXAZ73CSw2VMogarS7SdHwSGRLdonxm2PqJdvqmSvsQ8Vfio1PvF0QaaDttVJglE
	=
X-Google-Smtp-Source: AGHT+IHFoa7yUHDaRgqu4l/JUQo/w0VQEfcK74Y0V+lFVzAsB35zJ7rZlOdiXClJHSoCrRrlV+IkTQ==
X-Received: by 2002:a5e:9246:0:b0:7de:a753:82b3 with SMTP id z6-20020a5e9246000000b007dea75382b3mr420256iop.15.1714410306525;
        Mon, 29 Apr 2024 10:05:06 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x71-20020a63864a000000b00606dd49d3b8sm9250880pgd.57.2024.04.29.10.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 10:05:04 -0700 (PDT)
Date: Mon, 29 Apr 2024 10:05:01 -0700
From: Kees Cook <keescook@chromium.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Haren Myneni <haren@us.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] crypto/nx: Avoid potential
 -Wflex-array-member-not-at-end warning
Message-ID: <202404290947.4A8BF6A6@keescook>
References: <ZgHmRNcR+a4EJX94@neat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgHmRNcR+a4EJX94@neat>

On Mon, Mar 25, 2024 at 03:01:56PM -0600, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
> ready to enable it globally.
> 
> Use the `__struct_group()` helper to separate the flexible array
> from the rest of the members in flexible `struct nx842_crypto_header`,
> through tagged `struct nx842_crypto_header_hdr`, and avoid embedding
> the flexible-array member in the middle of `struct nx842_crypto_ctx`.
> 
> Also, use `container_of()` whenever we need to retrieve a pointer to
> the flexible structure.
> 
> This code was detected with the help of Coccinelle, and audited and
> modified manually.
> 
> Link: https://github.com/KSPP/linux/issues/202
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/crypto/nx/nx-842.c |  6 ++++--
>  drivers/crypto/nx/nx-842.h | 11 +++++++----
>  2 files changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/crypto/nx/nx-842.c b/drivers/crypto/nx/nx-842.c
> index 2ab90ec10e61..82214cde2bcd 100644
> --- a/drivers/crypto/nx/nx-842.c
> +++ b/drivers/crypto/nx/nx-842.c
> @@ -251,7 +251,9 @@ int nx842_crypto_compress(struct crypto_tfm *tfm,
>  			  u8 *dst, unsigned int *dlen)
>  {
>  	struct nx842_crypto_ctx *ctx = crypto_tfm_ctx(tfm);
> -	struct nx842_crypto_header *hdr = &ctx->header;
> +	struct nx842_crypto_header *hdr =
> +				container_of(&ctx->header,
> +					     struct nx842_crypto_header, hdr);
>  	struct nx842_crypto_param p;
>  	struct nx842_constraints c = *ctx->driver->constraints;
>  	unsigned int groups, hdrsize, h;
> @@ -490,7 +492,7 @@ int nx842_crypto_decompress(struct crypto_tfm *tfm,
>  	}
>  
>  	memcpy(&ctx->header, src, hdr_len);
> -	hdr = &ctx->header;
> +	hdr = container_of(&ctx->header, struct nx842_crypto_header, hdr);
>  
>  	for (n = 0; n < hdr->groups; n++) {
>  		/* ignore applies to last group */
> diff --git a/drivers/crypto/nx/nx-842.h b/drivers/crypto/nx/nx-842.h
> index 7590bfb24d79..1f42c83d2683 100644
> --- a/drivers/crypto/nx/nx-842.h
> +++ b/drivers/crypto/nx/nx-842.h
> @@ -157,9 +157,12 @@ struct nx842_crypto_header_group {
>  } __packed;
>  
>  struct nx842_crypto_header {
> -	__be16 magic;		/* NX842_CRYPTO_MAGIC */
> -	__be16 ignore;		/* decompressed end bytes to ignore */
> -	u8 groups;		/* total groups in this header */
> +	/* New members must be added within the __struct_group() macro below. */
> +	__struct_group(nx842_crypto_header_hdr, hdr, __packed,
> +		__be16 magic;		/* NX842_CRYPTO_MAGIC */
> +		__be16 ignore;		/* decompressed end bytes to ignore */
> +		u8 groups;		/* total groups in this header */
> +	);
>  	struct nx842_crypto_header_group group[];
>  } __packed;
>  
> @@ -171,7 +174,7 @@ struct nx842_crypto_ctx {
>  	u8 *wmem;
>  	u8 *sbounce, *dbounce;
>  
> -	struct nx842_crypto_header header;
> +	struct nx842_crypto_header_hdr header;
>  	struct nx842_crypto_header_group group[NX842_CRYPTO_GROUP_MAX];
>  
>  	struct nx842_driver *driver;

Hmm. I think commit 03952d980153 ("crypto: nx - make platform drivers
directly register with crypto") incorrectly added "struct nx842_driver
*driver" to the end of struct nx842_crypto_ctx. I think it should be
before "header".

Then I see:

#define NX842_CRYPTO_HEADER_SIZE(g)                             \
        (sizeof(struct nx842_crypto_header) +                   \
         sizeof(struct nx842_crypto_header_group) * (g))

This is just struct_size(), really. And nothing uses:

#define NX842_CRYPTO_HEADER_MAX_SIZE                            \
        NX842_CRYPTO_HEADER_SIZE(NX842_CRYPTO_GROUP_MAX)

And then looking for what uses struct nx842_crypto_ctx's "group" member,
I don't see anything except some sizeof()s:

drivers/crypto/nx/nx-common-powernv.c:1044:     .cra_ctxsize = sizeof(struct nx842_crypto_ctx),
drivers/crypto/nx/nx-common-pseries.c:1021:     .cra_ctxsize = sizeof(struct nx842_crypto_ctx),

This is just a maximally sized ctx (as if the group count were
NX842_CRYPTO_GROUP_MAX), which we could use struct_size for again:

     .cra_ctxsize = struct_size_t(struct nx842_crypto_ctx, header.group,
				  NX842_CRYPTO_GROUP_MAX),

So then "group" can be entirely removed from struct nx842_crypto_ctx.

The result means we can also add __counted_by:


diff --git a/drivers/crypto/nx/nx-842.c b/drivers/crypto/nx/nx-842.c
index 2ab90ec10e61..144972fe2e6f 100644
--- a/drivers/crypto/nx/nx-842.c
+++ b/drivers/crypto/nx/nx-842.c
@@ -62,10 +62,7 @@
  */
 #define NX842_CRYPTO_MAGIC	(0xf842)
 #define NX842_CRYPTO_HEADER_SIZE(g)				\
-	(sizeof(struct nx842_crypto_header) +			\
-	 sizeof(struct nx842_crypto_header_group) * (g))
-#define NX842_CRYPTO_HEADER_MAX_SIZE				\
-	NX842_CRYPTO_HEADER_SIZE(NX842_CRYPTO_GROUP_MAX)
+	struct_size_t(nx842_crypto_header, group, g)
 
 /* bounce buffer size */
 #define BOUNCE_BUFFER_ORDER	(2)
diff --git a/drivers/crypto/nx/nx-842.h b/drivers/crypto/nx/nx-842.h
index 7590bfb24d79..70d9f99a4595 100644
--- a/drivers/crypto/nx/nx-842.h
+++ b/drivers/crypto/nx/nx-842.h
@@ -160,7 +160,7 @@ struct nx842_crypto_header {
 	__be16 magic;		/* NX842_CRYPTO_MAGIC */
 	__be16 ignore;		/* decompressed end bytes to ignore */
 	u8 groups;		/* total groups in this header */
-	struct nx842_crypto_header_group group[];
+	struct nx842_crypto_header_group group[] __counted_by(groups);
 } __packed;
 
 #define NX842_CRYPTO_GROUP_MAX	(0x20)
@@ -171,10 +171,9 @@ struct nx842_crypto_ctx {
 	u8 *wmem;
 	u8 *sbounce, *dbounce;
 
-	struct nx842_crypto_header header;
-	struct nx842_crypto_header_group group[NX842_CRYPTO_GROUP_MAX];
-
 	struct nx842_driver *driver;
+
+	struct nx842_crypto_header header;
 };
 
 int nx842_crypto_init(struct crypto_tfm *tfm, struct nx842_driver *driver);
diff --git a/drivers/crypto/nx/nx-common-powernv.c b/drivers/crypto/nx/nx-common-powernv.c
index 8c859872c183..22ab4a5885f2 100644
--- a/drivers/crypto/nx/nx-common-powernv.c
+++ b/drivers/crypto/nx/nx-common-powernv.c
@@ -1041,7 +1041,8 @@ static struct crypto_alg nx842_powernv_alg = {
 	.cra_driver_name	= "842-nx",
 	.cra_priority		= 300,
 	.cra_flags		= CRYPTO_ALG_TYPE_COMPRESS,
-	.cra_ctxsize		= sizeof(struct nx842_crypto_ctx),
+	.cra_ctxsize		= struct_size_t(struct nx842_crypto_ctx, header.group,
+						NX842_CRYPTO_GROUP_MAX),
 	.cra_module		= THIS_MODULE,
 	.cra_init		= nx842_powernv_crypto_init,
 	.cra_exit		= nx842_crypto_exit,
diff --git a/drivers/crypto/nx/nx-common-pseries.c b/drivers/crypto/nx/nx-common-pseries.c
index 35f2d0d8507e..fdf328eab6fc 100644
--- a/drivers/crypto/nx/nx-common-pseries.c
+++ b/drivers/crypto/nx/nx-common-pseries.c
@@ -1018,7 +1018,8 @@ static struct crypto_alg nx842_pseries_alg = {
 	.cra_driver_name	= "842-nx",
 	.cra_priority		= 300,
 	.cra_flags		= CRYPTO_ALG_TYPE_COMPRESS,
-	.cra_ctxsize		= sizeof(struct nx842_crypto_ctx),
+	.cra_ctxsize		= struct_size_t(struct nx842_crypto_ctx, header.group,
+						NX842_CRYPTO_GROUP_MAX),
 	.cra_module		= THIS_MODULE,
 	.cra_init		= nx842_pseries_crypto_init,
 	.cra_exit		= nx842_crypto_exit,


-- 
Kees Cook

