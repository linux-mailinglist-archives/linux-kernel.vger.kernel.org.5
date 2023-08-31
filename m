Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA1A78F4B1
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 23:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241784AbjHaVei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 17:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjHaVeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 17:34:37 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2971107;
        Thu, 31 Aug 2023 14:34:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DD6B4CE223C;
        Thu, 31 Aug 2023 21:34:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AFB9C433CB;
        Thu, 31 Aug 2023 21:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693517671;
        bh=Pgd2Yocptj9793lIYLqngAmH9TmBoivbfYxnZc7PBrQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hiPGhd/3c0qNhHdmi69L4PA7g+37wO5CLgwhhcFP5vKqw1scF+yKPrkw1O8ZCIgxB
         5mCv6ZQSCorvCihaDTfGlfkzApaMZjD0CgCbgyJkLlxL36XFFYfMi/vhpNFLUrqzKD
         ZUjks1TgN+bvuuZ1ecy7bfJfx7iI8OCKlO0sMOUN+YljqGPJjpBWaSwL/68EVf54DN
         5z2H/udtRhNY5WJXAUv47YFHb4wu04iA68+4teyLcWal9V1ob9wLN220ljo5F3nApG
         Z1vw324n6PoFB5fRINXbVN/SoG9APZPdQ5BNQjmvf1Scm53HJznhNaC7mkPGKkNaSw
         4v8/4TgrclThA==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-500760b296aso1539461e87.0;
        Thu, 31 Aug 2023 14:34:30 -0700 (PDT)
X-Gm-Message-State: AOJu0YyCBL3S99U+N31adkR0LOT79bJpz/eTKUsnYIA7+r5wTU0SUdXB
        BAU5WtWCnXBPsIa6bHY6WCsmipy/FNXZvCy2jRQ=
X-Google-Smtp-Source: AGHT+IFSoy9FnYK0eqaRYZrG5VzapGIF4728UjrRo2b8KBxTWSMKta2bRo8O2D4f85IEjpm8toZ0g6qpXrHLuUAWdwU=
X-Received: by 2002:a05:6512:2347:b0:4f9:6adf:3981 with SMTP id
 p7-20020a056512234700b004f96adf3981mr1297313lfu.33.1693517669059; Thu, 31 Aug
 2023 14:34:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230831210125.gonna.173-kees@kernel.org>
In-Reply-To: <20230831210125.gonna.173-kees@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 31 Aug 2023 23:34:17 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE2kz1raOSy+ethim7YyFvKs+_uP2xhvndXDAbLdJDLdA@mail.gmail.com>
Message-ID: <CAMj1kXE2kz1raOSy+ethim7YyFvKs+_uP2xhvndXDAbLdJDLdA@mail.gmail.com>
Subject: Re: [PATCH v2] pstore: Base compression input buffer size on
 estimated compressed size
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Aug 2023 at 23:01, Kees Cook <keescook@chromium.org> wrote:
>
> From: Ard Biesheuvel <ardb@kernel.org>
>
> Commit 1756ddea6916 ("pstore: Remove worst-case compression size logic")
> removed some clunky per-algorithm worst case size estimation routines on
> the basis that we can always store pstore records uncompressed, and
> these worst case estimations are about how much the size might
> inadvertently *increase* due to encapsulation overhead when the input
> cannot be compressed at all. So if compression results in a size
> increase, we just store the original data instead.
>
> However, it seems that the original code was misinterpreting these
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
> used the computation given below for zlib:
>
>   switch (size) {
>   /* buffer range for efivars */
>   case 1000 ... 2000:
>         cmpr = 56;
>         break;
>   case 2001 ... 3000:
>         cmpr = 54;
>         break;
>   case 3001 ... 3999:
>         cmpr = 52;
>         break;
>   /* buffer range for nvram, erst */
>   case 4000 ... 10000:
>         cmpr = 45;
>         break;
>   default:
>         cmpr = 60;
>         break;
>   }
>
>   return (size * 100) / cmpr;
>
> We will use the previous worst-case of 60% for compression. For
> decompression go extra large (3x) so we make sure there's enough space
> for anything.
>
> While at it, rate limit the error message so we don't flood the log
> unnecessarily on systems that have accumulated a lot of pstore history.
>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Eric Biggers <ebiggers@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> Link: https://lore.kernel.org/r/20230830212238.135900-1-ardb@kernel.org
> Co-developed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> v2:
>  - reduce compression buffer size to 1.67x from 2x
>  - raise decompression buffer size to 3x

LGTM

Thanks for picking this up.

> v1: https://lore.kernel.org/all/20230830212238.135900-1-ardb@kernel.org
> ---
>  fs/pstore/platform.c | 34 +++++++++++++++++++++++++++-------
>  1 file changed, 27 insertions(+), 7 deletions(-)
>
> diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
> index 62356d542ef6..e5bca9a004cc 100644
> --- a/fs/pstore/platform.c
> +++ b/fs/pstore/platform.c
> @@ -98,7 +98,14 @@ MODULE_PARM_DESC(kmsg_bytes, "amount of kernel log to snapshot (in bytes)");
>
>  static void *compress_workspace;
>
> +/*
> + * Compression is only used for dmesg output, which consists of low-entropy
> + * ASCII text, and so we can assume worst-case 60%.
> + */
> +#define DMESG_COMP_PERCENT     60
> +
>  static char *big_oops_buf;
> +static size_t max_compressed_size;
>
>  void pstore_set_kmsg_bytes(int bytes)
>  {
> @@ -196,6 +203,7 @@ static int pstore_compress(const void *in, void *out,
>
>  static void allocate_buf_for_compression(void)
>  {
> +       size_t compressed_size;
>         char *buf;
>
>         /* Skip if not built-in or compression disabled. */
> @@ -216,7 +224,8 @@ static void allocate_buf_for_compression(void)
>          * uncompressed record size, since any record that would be expanded by
>          * compression is just stored uncompressed.
>          */
> -       buf = kvzalloc(psinfo->bufsize, GFP_KERNEL);
> +       compressed_size = (psinfo->bufsize * 100) / DMESG_COMP_PERCENT;
> +       buf = kvzalloc(compressed_size, GFP_KERNEL);
>         if (!buf) {
>                 pr_err("Failed %zu byte compression buffer allocation for: %s\n",
>                        psinfo->bufsize, compress);
> @@ -233,6 +242,7 @@ static void allocate_buf_for_compression(void)
>
>         /* A non-NULL big_oops_buf indicates compression is available. */
>         big_oops_buf = buf;
> +       max_compressed_size = compressed_size;
>
>         pr_info("Using crash dump compression: %s\n", compress);
>  }
> @@ -246,6 +256,7 @@ static void free_buf_for_compression(void)
>
>         kvfree(big_oops_buf);
>         big_oops_buf = NULL;
> +       max_compressed_size = 0;
>  }
>
>  void pstore_record_init(struct pstore_record *record,
> @@ -305,7 +316,7 @@ static void pstore_dump(struct kmsg_dumper *dumper,
>                 record.buf = psinfo->buf;
>
>                 dst = big_oops_buf ?: psinfo->buf;
> -               dst_size = psinfo->bufsize;
> +               dst_size = max_compressed_size ?: psinfo->bufsize;
>
>                 /* Write dump header. */
>                 header_size = snprintf(dst, dst_size, "%s#%d Part%u\n", why,
> @@ -326,8 +337,15 @@ static void pstore_dump(struct kmsg_dumper *dumper,
>                                 record.compressed = true;
>                                 record.size = zipped_len;
>                         } else {
> -                               record.size = header_size + dump_size;
> -                               memcpy(psinfo->buf, dst, record.size);
> +                               /*
> +                                * Compression failed, so the buffer is most
> +                                * likely filled with binary data that does not
> +                                * compress as well as ASCII text. Copy as much
> +                                * of the uncompressed data as possible into
> +                                * the pstore record, and discard the rest.
> +                                */
> +                               record.size = psinfo->bufsize;
> +                               memcpy(psinfo->buf, dst, psinfo->bufsize);
>                         }
>                 } else {
>                         record.size = header_size + dump_size;
> @@ -560,6 +578,7 @@ static void decompress_record(struct pstore_record *record,
>         int ret;
>         int unzipped_len;
>         char *unzipped, *workspace;
> +       size_t max_uncompressed_size;
>
>         if (!IS_ENABLED(CONFIG_PSTORE_COMPRESS) || !record->compressed)
>                 return;
> @@ -583,7 +602,8 @@ static void decompress_record(struct pstore_record *record,
>         }
>
>         /* Allocate enough space to hold max decompression and ECC. */
> -       workspace = kvzalloc(psinfo->bufsize + record->ecc_notice_size,
> +       max_uncompressed_size = 3 * psinfo->bufsize;
> +       workspace = kvzalloc(max_uncompressed_size + record->ecc_notice_size,
>                              GFP_KERNEL);
>         if (!workspace)
>                 return;
> @@ -591,11 +611,11 @@ static void decompress_record(struct pstore_record *record,
>         zstream->next_in        = record->buf;
>         zstream->avail_in       = record->size;
>         zstream->next_out       = workspace;
> -       zstream->avail_out      = psinfo->bufsize;
> +       zstream->avail_out      = max_uncompressed_size;
>
>         ret = zlib_inflate(zstream, Z_FINISH);
>         if (ret != Z_STREAM_END) {
> -               pr_err("zlib_inflate() failed, ret = %d!\n", ret);
> +               pr_err_ratelimited("zlib_inflate() failed, ret = %d!\n", ret);
>                 kvfree(workspace);
>                 return;
>         }
> --
> 2.34.1
>
