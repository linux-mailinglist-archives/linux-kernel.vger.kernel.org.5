Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362547AAAAA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 09:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbjIVHqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 03:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbjIVHqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 03:46:18 -0400
Received: from mx.tweek.dk (mx.tweek.dk [13.53.76.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7CB10C3;
        Fri, 22 Sep 2023 00:45:27 -0700 (PDT)
Received: from tweek.dk ([192.168.170.2] helo=odin.tweek.dk)
        by mx.tweek.dk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <tweek@tweek.dk>)
        id 1qjaqk-000Agi-0R;
        Fri, 22 Sep 2023 09:45:18 +0200
Received: from tweek (helo=localhost)
        by odin.tweek.dk with local-esmtp (Exim 4.97-RC0)
        (envelope-from <tweek@tweek.dk>)
        id 1qjaqj-00000002GCu-3jDz;
        Fri, 22 Sep 2023 09:45:17 +0200
Date:   Fri, 22 Sep 2023 09:45:17 +0200 (CEST)
From:   Martin Nybo Andersen <tweek@tweek.dk>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Nick Terrell <terrelln@fb.com>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use CRC32 and a 1MiB dictionary for XZ compressed
 modules
In-Reply-To: <3d34a965-ab9c-d549-0c63-c717ab5d2edc@tweek.dk>
Message-ID: <1bf10ec1-c154-52f3-79dd-7ec5380aa159@tweek.dk>
References: <3d34a965-ab9c-d549-0c63-c717ab5d2edc@tweek.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello?
Anyone?

Best regards,
- Martin

On Fri, 15 Sep 2023, Martin Nybo Andersen wrote:

> Kmod is now using the kernel decompressor which doesn't handle CRC64
> and dictionaries larger than 1MiB.
>
> Fixes: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1050582
> Signed-off-by: Martin Nybo Andersen <tweek@tweek.dk>
> ---
> scripts/Makefile.modinst | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/Makefile.modinst b/scripts/Makefile.modinst
> index c59cc57286ba..ffbafbd3aeea 100644
> --- a/scripts/Makefile.modinst
> +++ b/scripts/Makefile.modinst
> @@ -144,7 +144,7 @@ endif
> quiet_cmd_gzip = GZIP    $@
>       cmd_gzip = $(KGZIP) -n -f $<
> quiet_cmd_xz = XZ      $@
> -      cmd_xz = $(XZ) --lzma2=dict=2MiB -f $<
> +      cmd_xz = $(XZ) --check=crc32 --lzma2=dict=1MiB -f $<
> quiet_cmd_zstd = ZSTD    $@
>       cmd_zstd = $(ZSTD) -T0 --rm -f -q $<
>
> --
> 2.40.1
>
>
