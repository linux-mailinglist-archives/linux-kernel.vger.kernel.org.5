Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039927AAD28
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 10:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbjIVIw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 04:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbjIVIwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 04:52:24 -0400
Received: from mx.tweek.dk (mx.tweek.dk [13.53.76.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D50EBB;
        Fri, 22 Sep 2023 01:52:15 -0700 (PDT)
Received: from tweek.dk ([192.168.170.2] helo=odin.tweek.dk)
        by mx.tweek.dk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <tweek@tweek.dk>)
        id 1qjbtK-000Axq-2f;
        Fri, 22 Sep 2023 10:52:02 +0200
Received: from tweek (helo=localhost)
        by odin.tweek.dk with local-esmtp (Exim 4.97-RC0)
        (envelope-from <tweek@tweek.dk>)
        id 1qjbtK-00000002HH2-24HI;
        Fri, 22 Sep 2023 10:52:02 +0200
Date:   Fri, 22 Sep 2023 10:52:02 +0200 (CEST)
From:   Martin Nybo Andersen <tweek@tweek.dk>
To:     Tor Vic <torvic9@mailbox.org>
cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Nick Terrell <terrelln@fb.com>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use CRC32 and a 1MiB dictionary for XZ compressed
 modules
In-Reply-To: <c2b92ff2-d077-4588-9d5c-93dfec0037ee@mailbox.org>
Message-ID: <b85bf040-f6be-ef12-5b33-6d41991e4d97@tweek.dk>
References: <3d34a965-ab9c-d549-0c63-c717ab5d2edc@tweek.dk> <c2b92ff2-d077-4588-9d5c-93dfec0037ee@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463811414-1003633596-1695372722=:541272"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811414-1003633596-1695372722=:541272
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Fri, 22 Sep 2023, Tor Vic wrote:

>> 
>> Hello?
>
> Hello,

:)

>> Anyone?
>> 
>> Best regards,
>> - Martin
>> 
>> On Fri, 15 Sep 2023, Martin Nybo Andersen wrote:
>> 
>>> Kmod is now using the kernel decompressor which doesn't handle CRC64
>>> and dictionaries larger than 1MiB.
>>> 
>>> Fixes: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1050582
>>> Signed-off-by: Martin Nybo Andersen <tweek@tweek.dk>
>>> ---
>>> scripts/Makefile.modinst | 2 +-
>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>> 
>>> diff --git a/scripts/Makefile.modinst b/scripts/Makefile.modinst
>>> index c59cc57286ba..ffbafbd3aeea 100644
>>> --- a/scripts/Makefile.modinst
>>> +++ b/scripts/Makefile.modinst
>>> @@ -144,7 +144,7 @@ endif
>>> quiet_cmd_gzip = GZIP    $@
>>>       cmd_gzip = $(KGZIP) -n -f $<
>>> quiet_cmd_xz = XZ      $@
>>> -      cmd_xz = $(XZ) --lzma2=dict=2MiB -f $<
>>> +      cmd_xz = $(XZ) --check=crc32 --lzma2=dict=1MiB -f $<
>
> I wonder whether it should be guarded with
>    ifdef CONFIG_MODULE_DECOMPRESS
>
> But on the other hand, the difference between 1M and 2M is likely very small 
> in terms of compression ratio.

That would work, since kmod decompress the modules in userspace if 
CONFIG_MODULE_DECOMPRESS if off.

What I'm aiming for is just that the kernel should be able to decompress 
its own modules, when it advertises it.

Cheers,
Martin

> Cheers,
> Tor Vic
>
>>> quiet_cmd_zstd = ZSTD    $@
>>>       cmd_zstd = $(ZSTD) -T0 --rm -f -q $<
>>> 
>>> -- 
>>> 2.40.1
>>> 
>>> 
>> 
>
>
---1463811414-1003633596-1695372722=:541272--
