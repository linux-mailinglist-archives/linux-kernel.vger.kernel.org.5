Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71AA27AAD99
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 11:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjIVJQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 05:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjIVJQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 05:16:49 -0400
Received: from mail.avm.de (mail.avm.de [212.42.244.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2509B114
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 02:16:41 -0700 (PDT)
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
        by mail.avm.de (Postfix) with ESMTPS;
        Fri, 22 Sep 2023 11:16:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
        t=1695374193; bh=LtM687oI9TFrYjIfRJXzHSYw7X0NRDTTPtB/S1Bg2W0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hoCOuDrzKh4zqLMGadFkno5hxDh0k+e57tQ8xBuyXabTB30GvYpf834/8jAkI8u+Z
         7jQvWkWY46vyzwF+KwMR2eiMhiP3Y0/ulQ6hjg9YvXN4hhK56HH/UCM6xDq9xiawf+
         nA1urMKKbcLTlxTy7XtH33lU+Ymcd1+9lVdRC1iE=
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
        by mail-auth.avm.de (Postfix) with ESMTPA id BAD0080A71;
        Fri, 22 Sep 2023 11:16:32 +0200 (CEST)
Received: by buildd.core.avm.de (Postfix, from userid 1000)
        id ADFE71813CA; Fri, 22 Sep 2023 11:16:32 +0200 (CEST)
Date:   Fri, 22 Sep 2023 11:16:32 +0200
From:   Nicolas Schier <n.schier@avm.de>
To:     Martin Nybo Andersen <tweek@tweek.dk>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nick Terrell <terrelln@fb.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org
Subject: Re: [PATCH] Use CRC32 and a 1MiB dictionary for XZ compressed modules
Message-ID: <ZQ1bcIEECHEvK09c@buildd.core.avm.de>
Mail-Followup-To: Martin Nybo Andersen <tweek@tweek.dk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nick Terrell <terrelln@fb.com>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org
References: <3d34a965-ab9c-d549-0c63-c717ab5d2edc@tweek.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3d34a965-ab9c-d549-0c63-c717ab5d2edc@tweek.dk>
X-purgate-ID: 149429::1695374193-9A4019BA-C47752C9/0/0
X-purgate-type: clean
X-purgate-size: 1000
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In linux-modules@v.k.o probably some more experts can comment on this:

On Fri, Sep 15, 2023 at 12:15:39PM +0200, Martin Nybo Andersen wrote:
> Kmod is now using the kernel decompressor which doesn't handle CRC64
> and dictionaries larger than 1MiB.
> 
> Fixes: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1050582
> Signed-off-by: Martin Nybo Andersen <tweek@tweek.dk>
> ---
>  scripts/Makefile.modinst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/Makefile.modinst b/scripts/Makefile.modinst
> index c59cc57286ba..ffbafbd3aeea 100644
> --- a/scripts/Makefile.modinst
> +++ b/scripts/Makefile.modinst
> @@ -144,7 +144,7 @@ endif
>  quiet_cmd_gzip = GZIP    $@
>        cmd_gzip = $(KGZIP) -n -f $<
>  quiet_cmd_xz = XZ      $@
> -      cmd_xz = $(XZ) --lzma2=dict=2MiB -f $<
> +      cmd_xz = $(XZ) --check=crc32 --lzma2=dict=1MiB -f $<
>  quiet_cmd_zstd = ZSTD    $@
>        cmd_zstd = $(ZSTD) -T0 --rm -f -q $<
> 
> --
> 2.40.1
