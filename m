Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D73E278E36E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 01:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344047AbjH3Xnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 19:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244582AbjH3Xno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 19:43:44 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58DE11B
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 16:43:39 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bf55a81eeaso1522205ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 16:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693439019; x=1694043819; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rfuzHnmA/2/YVK6PLoXiL1kOIJ/ZFhVyk3JopXec8Pw=;
        b=BcmD+j0IwIV3ZK0bsXEy2GqmD4vA+Pq4Uz/+9ykZI5J+ps6aRBoVfQczIxEkDCAtfD
         UjQJdVrkCSKowXr3Lem8VrqwxmQqGX0+fwLJW2cNnyj7ddW+JC6GCLCGcVKxOXaBGF2u
         mbPEhzMXVO/4WDzPEkx2NDxsOV4XRUjDt0pOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693439019; x=1694043819;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rfuzHnmA/2/YVK6PLoXiL1kOIJ/ZFhVyk3JopXec8Pw=;
        b=DVl66G9RDvyaRyXZwQrEJj1xc4qZ7dSY8bH/YQxMfxRppBFmNquUKekVgmG1jTYRzy
         j7FPyHsXxzzHqY03pott5GZUgxyRrplWVtlzf8yt8bbvONzDN3RWrs5F9isiglGZ78KQ
         ZwKHJxNWDPC6dNBqdplPtR5kNYjdwfyUPNmO8AyMs/JzG1RHKw54sOnqzsnWHvd00+R7
         yFNyQ5uNIe3xnv9sXJeViEKhdxFT+OCS2L5VCVaU6970EQ+rhknJk7nYErSiY5Z4q1YO
         YwAlDZtx3U5Ow4M4qE9zOQLnLz7nEuqRNWeHiwAbw5bFZLTdoevtP3SPm0TiImLKBqgq
         /RFQ==
X-Gm-Message-State: AOJu0Yx8wfzEZFNP2azoMkADen0MNuBGmoKHUQEzfDwj8oHJcbsz4Qy3
        xmhbccLljLify9nJsCXL1tZixQ==
X-Google-Smtp-Source: AGHT+IGDYue2wbW4Pk0nkv3oXMC6lK30iPB1b1i/if1H5uYTRJQ34qxRwb1klw1ovgh6PRdRcPxjnA==
X-Received: by 2002:a17:903:25d4:b0:1c0:9bef:4bbd with SMTP id jc20-20020a17090325d400b001c09bef4bbdmr3525017plb.14.1693439019174;
        Wed, 30 Aug 2023 16:43:39 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n16-20020a170902e55000b001c0af36dd64sm53153plf.162.2023.08.30.16.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 16:43:38 -0700 (PDT)
Date:   Wed, 30 Aug 2023 16:43:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] pstore: Base compression input buffer size on estimated
 compressed size
Message-ID: <202308301608.739BFA8@keescook>
References: <20230830212238.135900-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830212238.135900-1-ardb@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 11:22:38PM +0200, Ard Biesheuvel wrote:
> Commit 1756ddea6916 ("pstore: Remove worst-case compression size logic")
> removed some clunky per-algorithm worst case size estimation routines on
> the basis that we can always store pstore records uncompressed, and
> these worst case estimations are about how much the size might
> inadvertently *increase* due to encapsulation overhead when the input
> cannot be compressed at all. So if compression results in a size
> increase, we just store the original data instead.

Does the Z_FINISH vs Z_SYNC_FLUSH thing need to be fixed as well, or
does that become a non-issue with this change?

> 
> However, it seems that the the original code was misinterpreting these
> calculations as an estimation of how much uncompressed data might fit
> into a compressed buffer of a given size, and it was using the results
> to consume the input data in larger chunks than the pstore record size,
> relying on the compression to ensure that what ultimately gets stored
> fits into the available space.
> 
> One result of this, as observed and reported by Linus, is that upgrading
> to a newer kernel that includes the given commit may result in pstore
> decompression errors reported in the kernel log. This is due to the fact
> that the existing records may unexpectedly decompress to a size that is
> larger than the pstore record size.
> 
> Another potential problem caused by this change is that we may
> underutilize the fixed sized records on pstore backends such as ramoops.
> And on pstore backends with variable sized records such as EFI, we will
> end up creating many more entries than before to store the same amount
> of compressed data.
> 
> So let's fix both issues, by bringing back the typical case estimation of
> how much ASCII text captured from the dmesg log might fit into a pstore
> record of a given size after compression. The original implementation
> used the computation given below for zlib, and so simply taking 2x as a
> ballpark number seems appropriate here.
> 
>   switch (size) {
>   /* buffer range for efivars */
>   case 1000 ... 2000:
>   	cmpr = 56;
>   	break;
>   case 2001 ... 3000:
>   	cmpr = 54;
>   	break;
>   case 3001 ... 3999:
>   	cmpr = 52;
>   	break;
>   /* buffer range for nvram, erst */
>   case 4000 ... 10000:
>   	cmpr = 45;
>   	break;
>   default:
>   	cmpr = 60;
>   	break;
>   }
> 
>   return (size * 100) / cmpr;
> 
> While at it, rate limit the error message so we don't flood the log
> unnecessarily on systems that have accumulated a lot of pstore history.
> 
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Eric Biggers <ebiggers@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  fs/pstore/platform.c | 30 +++++++++++++++++++++++-------
>  1 file changed, 23 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
> index 62356d542ef67f60..a866b70ea5933a1d 100644
> --- a/fs/pstore/platform.c
> +++ b/fs/pstore/platform.c
> @@ -98,7 +98,14 @@ MODULE_PARM_DESC(kmsg_bytes, "amount of kernel log to snapshot (in bytes)");
>  
>  static void *compress_workspace;
>  
> +/*
> + * Compression is only used for dmesg output, which consists of low-entropy
> + * ASCII text, and so we can assume a 2x compression factor is achievable.
> + */
> +#define DMESG_COMP_FACTOR	2
> +
>  static char *big_oops_buf;
> +static size_t max_uncompressed_size;
>  
>  void pstore_set_kmsg_bytes(int bytes)
>  {
> @@ -216,7 +223,7 @@ static void allocate_buf_for_compression(void)
>  	 * uncompressed record size, since any record that would be expanded by
>  	 * compression is just stored uncompressed.
>  	 */
> -	buf = kvzalloc(psinfo->bufsize, GFP_KERNEL);
> +	buf = kvzalloc(DMESG_COMP_FACTOR * psinfo->bufsize, GFP_KERNEL);
>  	if (!buf) {
>  		pr_err("Failed %zu byte compression buffer allocation for: %s\n",
>  		       psinfo->bufsize, compress);
> @@ -233,6 +240,7 @@ static void allocate_buf_for_compression(void)
>  
>  	/* A non-NULL big_oops_buf indicates compression is available. */
>  	big_oops_buf = buf;
> +	max_uncompressed_size = DMESG_COMP_FACTOR * psinfo->bufsize;
>  
>  	pr_info("Using crash dump compression: %s\n", compress);
>  }
> @@ -246,6 +254,7 @@ static void free_buf_for_compression(void)
>  
>  	kvfree(big_oops_buf);
>  	big_oops_buf = NULL;
> +	max_uncompressed_size = 0;
>  }
>  
>  void pstore_record_init(struct pstore_record *record,
> @@ -305,7 +314,7 @@ static void pstore_dump(struct kmsg_dumper *dumper,
>  		record.buf = psinfo->buf;
>  
>  		dst = big_oops_buf ?: psinfo->buf;
> -		dst_size = psinfo->bufsize;
> +		dst_size = max_uncompressed_size ?: psinfo->bufsize;
>  
>  		/* Write dump header. */
>  		header_size = snprintf(dst, dst_size, "%s#%d Part%u\n", why,
> @@ -326,8 +335,15 @@ static void pstore_dump(struct kmsg_dumper *dumper,
>  				record.compressed = true;
>  				record.size = zipped_len;
>  			} else {
> -				record.size = header_size + dump_size;
> -				memcpy(psinfo->buf, dst, record.size);
> +				/*
> +				 * Compression failed, so the buffer is most
> +				 * likely filled with binary data that does not
> +				 * compress as well as ASCII text. Copy as much
> +				 * of the uncompressed data as possible into
> +				 * the pstore record, and discard the rest.
> +				 */
> +				record.size = psinfo->bufsize;
> +				memcpy(psinfo->buf, dst, psinfo->bufsize);

I don't think this is "friendly" enough. :P

In the compression failure case, we've got a larger dst_size (and
dump_size, but technically it might not be true if something else went
wrong) than psinfo->bufsize, so we want to take the trailing bytes
(i.e. panic details are more likely at the end). And we should keep
the header, which is already present in "dst". I think we need to do
something like this:

	size_t buf_size_available = psinfo->bufsize - header_size;
	size_t dump_size_wanted = min(dump_size, buf_size_available);

	record.size = header_size + dump_size_wanted;
	memcpy(psinfo->buf, dst, header_size);
	memcpy(psinfo->buf + header_size,
	       dst + header_size + (dump_size - dump_size_wanted),
	       dump_size_wanted);

My eyes, my eyes.

>  			}
>  		} else {
>  			record.size = header_size + dump_size;
> @@ -583,7 +599,7 @@ static void decompress_record(struct pstore_record *record,
>  	}
>  
>  	/* Allocate enough space to hold max decompression and ECC. */
> -	workspace = kvzalloc(psinfo->bufsize + record->ecc_notice_size,
> +	workspace = kvzalloc(max_uncompressed_size + record->ecc_notice_size,
>  			     GFP_KERNEL);
>  	if (!workspace)
>  		return;
> @@ -591,11 +607,11 @@ static void decompress_record(struct pstore_record *record,
>  	zstream->next_in	= record->buf;
>  	zstream->avail_in	= record->size;
>  	zstream->next_out	= workspace;
> -	zstream->avail_out	= psinfo->bufsize;
> +	zstream->avail_out	= max_uncompressed_size;
>  
>  	ret = zlib_inflate(zstream, Z_FINISH);
>  	if (ret != Z_STREAM_END) {
> -		pr_err("zlib_inflate() failed, ret = %d!\n", ret);
> +		pr_err_ratelimited("zlib_inflate() failed, ret = %d!\n", ret);
>  		kvfree(workspace);
>  		return;
>  	}
> -- 
> 2.39.2
> 

Otherwise, yes, this should do nicely. :)

-- 
Kees Cook
