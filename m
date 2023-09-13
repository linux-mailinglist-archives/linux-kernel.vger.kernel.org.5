Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D412779F3F8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 23:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbjIMVql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 17:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbjIMVqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 17:46:35 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB641996
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 14:46:30 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-34df008b0e7so989295ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 14:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694641590; x=1695246390; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QowXTRSSOC8IB4ueS9Xc0NCSyyqp5xMMkI7wePQSkak=;
        b=I7g0e7aQ8TUPL+cBdyf68fqBnNwBC67NO0vKP5MRG20/M5u3zTlp1zm6KznJcLq+NK
         wv9tB5PNakaKiLkwhtaqogQRBYuPn8VHAjDdaiHeToB8JGDaOLCP7nuU8d+XwXNo78sn
         ZH2bqYf4GYJnuq3LyP11++q1Aq3AoleewMjQO83xXsWpMjz5SftIn6OME9PXHzHyOs+B
         avL4sSPmTh2PqApzP2szzjA9Cq64TMFbrhdUFOt3ObvLnA5o4/M90gzmZ2/YwWoPwJVe
         5bF7UgfRpkM9vmy5rwSJgLD88aWe2UQXL82rBcrwL/UvBT1luwLVIXsSFKE9jkRu3y4l
         z6cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694641590; x=1695246390;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QowXTRSSOC8IB4ueS9Xc0NCSyyqp5xMMkI7wePQSkak=;
        b=PgMFhxnh1pFLmRXFwjaxmz/GlHgBB51x5Am9vyfHxZI2he/KR1aYb85TEyrNjW2zbZ
         +oZyNtBhoS7Telysr5ADR22X49j/96DJY/krMf8eC5e7URuGWwicpp2EVClPM5OGW50r
         yJHcStczsDX8bpOjol4FPgeHoxwyDWZg7M9Xt5uHZgnLn4/MGrwnVyLjTrxt1Y9dtnIE
         qdrX19CQYB2LgTZ+WyxoXs5idcjacVxIj7O6LvUK14wMWHforzehTiFydy+anSdxshrO
         TmYVE3aUdL79nN5OOUzb/bdQHbIvbs61mO6U1wdx1M+mrtAYsiOmZqLfwfx6Nz+O2isH
         c2jg==
X-Gm-Message-State: AOJu0YzWc9SLn7pU8YyEkio6KLOCBTLZalF4h8/fEzPEkUHJMJwdDdqV
        jy+s72sGrl+uDJgPn7TvXWpxaA==
X-Google-Smtp-Source: AGHT+IHU/gkz+MAiiC6NWDNP87Txd53/KstTmyp3J9ijsGKI32VL8YatV9xSuNpaaWqc2Xy5X4aa3w==
X-Received: by 2002:a05:6e02:1bee:b0:34f:1e9c:45d9 with SMTP id y14-20020a056e021bee00b0034f1e9c45d9mr4553258ilv.12.1694641590231;
        Wed, 13 Sep 2023 14:46:30 -0700 (PDT)
Received: from google.com (26.103.132.34.bc.googleusercontent.com. [34.132.103.26])
        by smtp.gmail.com with ESMTPSA id r5-20020a92c505000000b0034f37a27bb4sm44105ilg.72.2023.09.13.14.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 14:46:29 -0700 (PDT)
Date:   Wed, 13 Sep 2023 21:46:27 +0000
From:   Justin Stitt <justinstitt@google.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     kent.overstreet@linux.dev, bfoster@redhat.com,
        linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, patches@lists.linux.dev
Subject: Re: [PATCH 4/7] bcachefs: Fix -Wformat in bch2_bucket_gens_invalid()
Message-ID: <20230913214627.ankymdgklzwob4ij@google.com>
References: <20230912-bcachefs-warning-fixes-v1-0-a1cc83a38836@kernel.org>
 <20230912-bcachefs-warning-fixes-v1-4-a1cc83a38836@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912-bcachefs-warning-fixes-v1-4-a1cc83a38836@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 12:15:41PM -0700, Nathan Chancellor wrote:
> When building bcachefs for 32-bit ARM, there is a compiler warning in
> bch2_bucket_gens_invalid() due to use of an incorrect format specifier:
>
>   fs/bcachefs/alloc_background.c:530:10: error: format specifies type 'unsigned long' but the argument has type 'size_t' (aka 'unsigned int') [-Werror,-Wformat]
>     529 |                 prt_printf(err, "bad val size (%lu != %zu)",
>         |                                                ~~~
>         |                                                %zu
>     530 |                        bkey_val_bytes(k.k), sizeof(struct bch_bucket_gens));
>         |                        ^~~~~~~~~~~~~~~~~~~
>   fs/bcachefs/util.h:223:54: note: expanded from macro 'prt_printf'
>     223 | #define prt_printf(_out, ...)           bch2_prt_printf(_out, __VA_ARGS__)
>         |                                                               ^~~~~~~~~~~
>
> On 64-bit architectures, size_t is 'unsigned long', so there is no
> warning when using %lu but on 32-bit architectures, size_t is 'unsigned
> int'. Use '%zu', the format specifier for 'size_t', to eliminate the
> warning.
>
> Fixes: 4be0d766a7e9 ("bcachefs: bucket_gens btree")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Reviewed-by: Justin Stitt <justinstitt@google.com>

> ---
>  fs/bcachefs/alloc_background.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/bcachefs/alloc_background.c b/fs/bcachefs/alloc_background.c
> index 67e73864823c..2b0d155d1ed5 100644
> --- a/fs/bcachefs/alloc_background.c
> +++ b/fs/bcachefs/alloc_background.c
> @@ -526,7 +526,7 @@ int bch2_bucket_gens_invalid(const struct bch_fs *c, struct bkey_s_c k,
>  			     struct printbuf *err)
>  {
>  	if (bkey_val_bytes(k.k) != sizeof(struct bch_bucket_gens)) {
> -		prt_printf(err, "bad val size (%lu != %zu)",
> +		prt_printf(err, "bad val size (%zu != %zu)",
>  		       bkey_val_bytes(k.k), sizeof(struct bch_bucket_gens));
>  		return -BCH_ERR_invalid_bkey;
>  	}
>
> --
> 2.42.0
>
