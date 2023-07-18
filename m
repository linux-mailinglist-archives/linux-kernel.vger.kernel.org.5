Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6AB4758899
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 00:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbjGRWiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 18:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjGRWiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 18:38:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6BC198E;
        Tue, 18 Jul 2023 15:38:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6FE26126C;
        Tue, 18 Jul 2023 22:38:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73162C433C7;
        Tue, 18 Jul 2023 22:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689719896;
        bh=RXO+gAcZm+MhRenqy65hhkLUzlwKRVhTNDHhFXVPjjc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WC8frNZQi3mlQRwzd/1B/o58REsGjVM4bTqKYDGfIE0sdXtSivhP2CyO9GHwyZmUh
         /fSMjJcqo48S1vnfEmmBEuLJHAJPEWExHLr/fGVg72zBItMXT5mcrGyyeTxbsSA84F
         6LENyGcMmgizG0XyhLIpTWGmW5LNVmvAW2H++ihnyl/GFL1ab+KbX6AQgQGzKV14bB
         C7ttE95UTAd7KsoYwEkaDtSAZr6mZGfIVkXp1QrwAzNbs+XmOJRAl2Qpf1itgUpGdz
         7Xh0infj6g0F2qtc/JkRPt1YQH30JhSn8B77F32PIysiR197GoqrB8XClTi6/Qu1MM
         4FL5RdcE/3Bqg==
Date:   Tue, 18 Jul 2023 15:38:13 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Kees Cook <keescook@chromium.org>,
        Haren Myneni <haren@us.ibm.com>,
        Nick Terrell <terrelln@fb.com>,
        Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Richard Weinberger <richard@nod.at>,
        David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        qat-linux@intel.com, linuxppc-dev@lists.ozlabs.org,
        linux-mtd@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [RFC PATCH 05/21] ubifs: Pass worst-case buffer size to
 compression routines
Message-ID: <20230718223813.GC1005@sol.localdomain>
References: <20230718125847.3869700-1-ardb@kernel.org>
 <20230718125847.3869700-6-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718125847.3869700-6-ardb@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 02:58:31PM +0200, Ard Biesheuvel wrote:
> Currently, the ubifs code allocates a worst case buffer size to
> recompress a data node, but does not pass the size of that buffer to the
> compression code. This means that the compression code will never use
> the additional space, and might fail spuriously due to lack of space.
> 
> So let's multiply out_len by WORST_COMPR_FACTOR after allocating the
> buffer. Doing so is guaranteed not to overflow, given that the preceding
> kmalloc_array() call would have failed otherwise.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  fs/ubifs/journal.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
> index dc52ac0f4a345f30..4e5961878f336033 100644
> --- a/fs/ubifs/journal.c
> +++ b/fs/ubifs/journal.c
> @@ -1493,6 +1493,8 @@ static int truncate_data_node(const struct ubifs_info *c, const struct inode *in
>  	if (!buf)
>  		return -ENOMEM;
>  
> +	out_len *= WORST_COMPR_FACTOR;
> +
>  	dlen = le32_to_cpu(dn->ch.len) - UBIFS_DATA_NODE_SZ;
>  	data_size = dn_size - UBIFS_DATA_NODE_SZ;
>  	compr_type = le16_to_cpu(dn->compr_type);

This looks like another case where data that would be expanded by compression
should just be stored uncompressed instead.

In fact, it seems that UBIFS does that already.  ubifs_compress() has this:

        /*
         * If the data compressed only slightly, it is better to leave it
         * uncompressed to improve read speed.
         */
        if (in_len - *out_len < UBIFS_MIN_COMPRESS_DIFF)
                goto no_compr;

So it's unclear why the WORST_COMPR_FACTOR thing is needed at all.

- Eric
