Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 834FE79F3F4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 23:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbjIMVqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 17:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjIMVqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 17:46:08 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A821739
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 14:46:04 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-7927f24140eso9661039f.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 14:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694641564; x=1695246364; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hS6LHZP97enWTuQrtj4p55fJQ0mnk4aMtCPKI4xtC9M=;
        b=18tlNagWct2lJErMpBBze8hACFvX5AZfJLqUoJDTdn8+tzMzPrIui3pb2PRkgj3YRu
         f3PuBDz4ls1YMRvPhgpSyYyA6cuJ4I5XNaR6KVrZiBdpZf4zJxTuT43MBLxiREBUSS0h
         n0rMasvjPs+aSvU1ZoLuE4EJrbCDGYGXaOjaTabw0jAPqvNi8OB2Zs35x0jwYYoeZL1t
         GCazIk56jwrycpvcVMZDZuY4cmhHxFrFJYFGDTEOghy3vcv022pDC3ofYa/CDup4TApO
         zsqta+wTSCB6mC7WWxEw7SwfhbeBOm48l4Kvz/qeKWRo2I6tLda2b1MaCpapl6aCnH08
         4F2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694641564; x=1695246364;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hS6LHZP97enWTuQrtj4p55fJQ0mnk4aMtCPKI4xtC9M=;
        b=V7pPtgwR96A99sRG7MGfP41+ZBXL4WnVrFwzQEgGdFKoAE80AWpZRq12YpRPqkh7gY
         l2Yd++BR3VyrandtaID5+fSl+9x+jIqnwkCWpRFeQ8iXAO9NfI4N9mYSfNqxY/BaP2bD
         X2bkCt0i/zBvELGhTCPMeikbQfCDzLReH37VSqmFOTpLG3Adr44gIsaFYes7goI18Vr0
         24TKiSOEnEsi1Md+FyNzPjzsfAQslzBhQ0+cWpf78GCuwkWhuBiBkOkPHmexl6nLC5NL
         juo0Ubls/lcQEmqmbn2adKb/oLAnkNbMJpnTw8ZK3+8H3TgAEhxMmehILe7TjsOtXGa/
         fiiA==
X-Gm-Message-State: AOJu0Yz6FQeCSew2buelE5kkayBji0zbqCKyDqjGLVrVB/zYSIKJ8lzN
        AVrjouDTAcK7m33uiV3RsYCNPg==
X-Google-Smtp-Source: AGHT+IEB+MklxqwnlrjkpN5LSD98xUtIFfRsg2kZyYkJD4SxmRxnVtsxRjGe7HwbeANhxquKJjnX0g==
X-Received: by 2002:a05:6e02:214d:b0:349:9af9:d412 with SMTP id d13-20020a056e02214d00b003499af9d412mr4794802ilv.0.1694641564057;
        Wed, 13 Sep 2023 14:46:04 -0700 (PDT)
Received: from google.com (26.103.132.34.bc.googleusercontent.com. [34.132.103.26])
        by smtp.gmail.com with ESMTPSA id f15-20020a056638118f00b004316bbe1d4csm24843jas.78.2023.09.13.14.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 14:46:03 -0700 (PDT)
Date:   Wed, 13 Sep 2023 21:46:00 +0000
From:   Justin Stitt <justinstitt@google.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     kent.overstreet@linux.dev, bfoster@redhat.com,
        linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, patches@lists.linux.dev
Subject: Re: [PATCH 3/7] bcachefs: Fix -Wformat in bch2_alloc_v4_invalid()
Message-ID: <20230913214600.y3eo3emayljnxfuy@google.com>
References: <20230912-bcachefs-warning-fixes-v1-0-a1cc83a38836@kernel.org>
 <20230912-bcachefs-warning-fixes-v1-3-a1cc83a38836@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912-bcachefs-warning-fixes-v1-3-a1cc83a38836@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 12:15:40PM -0700, Nathan Chancellor wrote:
> When building bcachefs for 32-bit ARM, there is a compiler warning in
> bch2_alloc_v4_invalid() due to use of an incorrect format specifier:
>
>   fs/bcachefs/alloc_background.c:246:30: error: format specifies type 'unsigned long' but the argument has type 'unsigned int' [-Werror,-Wformat]
>     245 |                 prt_printf(err, "bad val size (%u > %lu)",
>         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>         |                                                     %u
>     246 |                        alloc_v4_u64s(a.v), bkey_val_u64s(k.k));
>         |                        ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~
>   fs/bcachefs/bkey.h:58:27: note: expanded from macro 'bkey_val_u64s'
>      58 | #define bkey_val_u64s(_k)       ((_k)->u64s - BKEY_U64s)
>         |                                 ^
>   fs/bcachefs/util.h:223:54: note: expanded from macro 'prt_printf'
>     223 | #define prt_printf(_out, ...)           bch2_prt_printf(_out, __VA_ARGS__)
>         |                                                               ^~~~~~~~~~~
>
> This expression is of type 'size_t'. On 64-bit architectures, size_t is
> 'unsigned long', so there is no warning when using %lu but on 32-bit
> architectures, size_t is 'unsigned int'. Use '%zu', the format specifier
> for 'size_t' to eliminate the warning.
>
> Fixes: 11be8e8db283 ("bcachefs: New on disk format: Backpointers")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Reviewed-by: Justin Stitt <justinstitt@google.com>

> ---
>  fs/bcachefs/alloc_background.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/bcachefs/alloc_background.c b/fs/bcachefs/alloc_background.c
> index 540d94c0cceb..67e73864823c 100644
> --- a/fs/bcachefs/alloc_background.c
> +++ b/fs/bcachefs/alloc_background.c
> @@ -242,7 +242,7 @@ int bch2_alloc_v4_invalid(const struct bch_fs *c, struct bkey_s_c k,
>  	struct bkey_s_c_alloc_v4 a = bkey_s_c_to_alloc_v4(k);
>
>  	if (alloc_v4_u64s(a.v) > bkey_val_u64s(k.k)) {
> -		prt_printf(err, "bad val size (%u > %lu)",
> +		prt_printf(err, "bad val size (%u > %zu)",
>  		       alloc_v4_u64s(a.v), bkey_val_u64s(k.k));
>  		return -BCH_ERR_invalid_bkey;
>  	}
>
> --
> 2.42.0
>
