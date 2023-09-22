Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C77297AB02C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 13:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233506AbjIVLEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 07:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233512AbjIVLEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 07:04:47 -0400
Received: from mx.tweek.dk (mx.tweek.dk [13.53.76.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F01BAC;
        Fri, 22 Sep 2023 04:04:41 -0700 (PDT)
Received: from tweek.dk ([192.168.170.2] helo=odin.tweek.dk)
        by mx.tweek.dk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <tweek@tweek.dk>)
        id 1qjdxT-000BSd-05;
        Fri, 22 Sep 2023 13:04:27 +0200
Received: from tweek (helo=localhost)
        by odin.tweek.dk with local-esmtp (Exim 4.97-RC0)
        (envelope-from <tweek@tweek.dk>)
        id 1qjdxS-00000002Iqp-3IsX;
        Fri, 22 Sep 2023 13:04:26 +0200
Date:   Fri, 22 Sep 2023 13:04:26 +0200 (CEST)
From:   Martin Nybo Andersen <tweek@tweek.dk>
To:     Masahiro Yamada <masahiroy@kernel.org>
cc:     Tor Vic <torvic9@mailbox.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Nick Terrell <terrelln@fb.com>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: Re: [PATCH] Use CRC32 and a 1MiB dictionary for XZ compressed
 modules
In-Reply-To: <CAK7LNAQVuKQ34xK8AA9M0dytb1zNpE+rUYDhi6kGDO60SYBpyw@mail.gmail.com>
Message-ID: <d0016504-af19-eab5-8898-f51a8c8abdcd@tweek.dk>
References: <3d34a965-ab9c-d549-0c63-c717ab5d2edc@tweek.dk> <c2b92ff2-d077-4588-9d5c-93dfec0037ee@mailbox.org> <b85bf040-f6be-ef12-5b33-6d41991e4d97@tweek.dk> <CAK7LNAQVuKQ34xK8AA9M0dytb1zNpE+rUYDhi6kGDO60SYBpyw@mail.gmail.com>
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


On Fri, 22 Sep 2023, Masahiro Yamada wrote:

[...]

> Hello, sorry for the delay.
>
> I am OK with picking the patch to my tree.

Hi,

That sound great :)

> I think we can use --check=crc32 --lzma2=dict=1MiB
> unconditionally.
>
> (But, if the in-kernel decompressor is improved
> to understand CRC64 in the future, we can loosen
> this restriction again.)

Of course.

> Just small change requests.
>
> Please do not use the Fixes tag to point at the Debian bug tracker.
>
>
> Instead, you can do
>
> Link: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1050582
>
>   or
>
> Closes: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1050582
>
>
>
> Also, mention that this change happened in
>
> kmod commit 09c9f8c5df04 ("libkmod: Use kernel decompression when available")
>
> in the commit description might be helpful.
>
>
>
>
> I added Lukas to CC.
> He is the author of the change on kmod side.

Is this ok?

Kmod is now (since kmod commit 09c9f8c5df04 ("libkmod: Use kernel
decompression when available")) using the kernel decompressor, when
loading compressed modules.

However, the kernel XZ decompressor is XZ Embedded, which doesn't
handle CRC64 and dictionaries larger than 1MiB.

Use CRC32 and 1MiB dictionary when XZ compressing and installing
kernel modules.

Link: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1050582
Signed-off-by: Martin Nybo Andersen <tweek@tweek.dk>
---
  scripts/Makefile.modinst | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.modinst b/scripts/Makefile.modinst
index c59cc57286ba..ffbafbd3aeea 100644
--- a/scripts/Makefile.modinst
+++ b/scripts/Makefile.modinst
@@ -144,7 +144,7 @@ endif
  quiet_cmd_gzip = GZIP    $@
        cmd_gzip = $(KGZIP) -n -f $<
  quiet_cmd_xz = XZ      $@
-      cmd_xz = $(XZ) --lzma2=dict=2MiB -f $<
+      cmd_xz = $(XZ) --check=crc32 --lzma2=dict=1MiB -f $<
  quiet_cmd_zstd = ZSTD    $@
        cmd_zstd = $(ZSTD) -T0 --rm -f -q $<
-- 
2.40.1
