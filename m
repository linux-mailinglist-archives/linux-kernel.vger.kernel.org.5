Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1397AAC91
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 10:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbjIVI0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 04:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232680AbjIVI0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 04:26:13 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050:0:465::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2F7CE7;
        Fri, 22 Sep 2023 01:26:03 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4RsQMW1c9Mz9srm;
        Fri, 22 Sep 2023 10:25:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1695371159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XHByl+js/YUPP3gf9zZaEGtUeq+uQ1pus0JHx74CtHs=;
        b=jWAk5WWjD17Th+abAe4pc7Reqbq9ifWaBWjByP4GrzMM3AwOuKiDhMQTZ7p5cf7jAZN8Et
        RcBme8YUPK7KyeZx89XUkNn6N4HtO0xPMNnwzgYe6qLtQD43SYxKQ5ImN4/VMUpMqBTWcj
        8aO3uGe1ifaMf2Pth//ADqQoTyXoilJRkEKszDqDYFCt2pJX22rMPdKzdi0lRYIrrDZFKB
        Eh+Ppqi3jT27kPZs60p1Y9DJk5VctFY2qAid3Lr7ikyH0X21H2vlf+jzyJUuS2sTSXi5Dw
        EDXWe6qscVekxeIh6yeku1F91mX+yAlxX+v0o3LX+MRer+BNgGqf2VKLwmFWTA==
Message-ID: <c2b92ff2-d077-4588-9d5c-93dfec0037ee@mailbox.org>
Date:   Fri, 22 Sep 2023 10:25:55 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] Use CRC32 and a 1MiB dictionary for XZ compressed modules
Content-Language: en-US
To:     Martin Nybo Andersen <tweek@tweek.dk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Nick Terrell <terrelln@fb.com>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <3d34a965-ab9c-d549-0c63-c717ab5d2edc@tweek.dk>
From:   Tor Vic <torvic9@mailbox.org>
In-Reply-To: <3d34a965-ab9c-d549-0c63-c717ab5d2edc@tweek.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: yehc7bqndknetusqe9r11sg8xckoeupk
X-MBO-RS-ID: 0cfd58da9bd54bab989
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Hello?

Hello,

> Anyone?
> 
> Best regards,
> - Martin
> 
> On Fri, 15 Sep 2023, Martin Nybo Andersen wrote:
> 
>> Kmod is now using the kernel decompressor which doesn't handle CRC64
>> and dictionaries larger than 1MiB.
>>
>> Fixes: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1050582
>> Signed-off-by: Martin Nybo Andersen <tweek@tweek.dk>
>> ---
>> scripts/Makefile.modinst | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/scripts/Makefile.modinst b/scripts/Makefile.modinst
>> index c59cc57286ba..ffbafbd3aeea 100644
>> --- a/scripts/Makefile.modinst
>> +++ b/scripts/Makefile.modinst
>> @@ -144,7 +144,7 @@ endif
>> quiet_cmd_gzip = GZIP    $@
>>       cmd_gzip = $(KGZIP) -n -f $<
>> quiet_cmd_xz = XZ      $@
>> -      cmd_xz = $(XZ) --lzma2=dict=2MiB -f $<
>> +      cmd_xz = $(XZ) --check=crc32 --lzma2=dict=1MiB -f $<

I wonder whether it should be guarded with
     ifdef CONFIG_MODULE_DECOMPRESS

But on the other hand, the difference between 1M and 2M is likely very 
small in terms of compression ratio.

Cheers,
Tor Vic

>> quiet_cmd_zstd = ZSTD    $@
>>       cmd_zstd = $(ZSTD) -T0 --rm -f -q $<
>>
>> -- 
>> 2.40.1
>>
>>
> 
