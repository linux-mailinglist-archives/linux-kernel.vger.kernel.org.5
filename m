Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B3A77304F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 22:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjHGUZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 16:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjHGUZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 16:25:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8064010D8;
        Mon,  7 Aug 2023 13:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=Cme/GFrer/cjxKzEvlIyzG4iYJKaLUpEkQryrM6h73A=; b=ewsICs8kkBG84aBu/hw8tCEMZR
        BaT/Ta9Bv0JfAlb+EA2tlNx+WcCbCBWi6BpruMGOnGrcVUWs635Q/bJ758/tAShjJZvWDriMg9pGX
        9mKs/s5d8PHjVb8YwUK505R+BFFJI64cME6N8v5vDfHPN/e89sjd6OfP61RgP5ZrBcNU+/yd0UnvI
        hh8jpTMutiXq8YtNPF0kRA/I9Tn1I/k0gv9xA+7G+XuLSiAw4zsKd3GgynwAUTCW2sqrGVPHgaerR
        yQGptH/Vd+ups0aaf9KUfyWFNXBEK86slW4uWCrZXkrL5ZQCM5LjuOTXAK4BEs5cAH9WTn6cC1Rpo
        4cFxlPqg==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qT6mp-000eBX-1o;
        Mon, 07 Aug 2023 20:25:07 +0000
Message-ID: <a3990928-b239-9939-5b40-8937d9301674@infradead.org>
Date:   Mon, 7 Aug 2023 13:25:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2] kconfig: avoid an infinite loop in
 oldconfig/syncconfig
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Yoann Congal <yoann.congal@smile.fr>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230805095709.6717-1-yoann.congal@smile.fr>
 <CAK7LNAS8a=8n9r7kQrLTPpKwqXG1d1sd0WjJ8PQhOXHXxnSyNQ@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAK7LNAS8a=8n9r7kQrLTPpKwqXG1d1sd0WjJ8PQhOXHXxnSyNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/7/23 12:25, Masahiro Yamada wrote:
> On Sat, Aug 5, 2023 at 6:57 PM Yoann Congal <yoann.congal@smile.fr> wrote:
>>
>> Exit on error when asking for value that has an invalid default value
>> and stdin has reached EOF. This happens in particular for hex/int
>> configs without an explicit default value.
>>
>> Previously, this case would loop:
>> * oldconfig prompts for the value but stdin has reached EOF
>> * It gets the global default value : an empty string
>> * This is not a valid hex/int value so it prompts again, hence the infinite loop.
>>
>> This case happens with a configuration like this (a hex config without a
>> valid default value):
>>   config TEST_KCONFIG
>>        hex "Test KConfig"
>>        # default 0x0
>>
>> And using:
>>   make oldconfig < /dev/null
>>
>> This was discovered when working on Yocto bug[0] on a downstream
>> kconfig user (U-boot)
>>
>> [0]: https://bugzilla.yoctoproject.org/show_bug.cgi?id=14136
>>
>> Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
>> ---
>> v1->v2:
>>  * Improve coding style
>>  * Put more info in the commit message
>>
>>  scripts/kconfig/conf.c | 10 +++++++++-
>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/scripts/kconfig/conf.c b/scripts/kconfig/conf.c
>> index 7cf63261d951c..8f32cbbce4805 100644
>> --- a/scripts/kconfig/conf.c
>> +++ b/scripts/kconfig/conf.c
>> @@ -377,8 +377,16 @@ static int conf_string(struct menu *menu)
>>                         line[strlen(line)-1] = 0;
>>                         def = line;
>>                 }
>> -               if (def && sym_set_string_value(sym, def))
>> +               if (def && sym_set_string_value(sym, def)) {
>>                         return 0;
>> +               } else {
>> +                       if (feof(stdin) && !sym_string_valid(sym, sym_get_string_value(sym))) {
>> +                               fprintf(stderr,
>> +                                       "Symbol %s has invalid default value and stdin reached EOF\n",
>> +                                       sym->name);
>> +                               exit(1);
>> +                       }
>> +               }
>>         }
>>  }
>>
>> --
>> 2.30.2
>>
> 
> 
> It is strange (and consistent) to bail out
> only for particular types.
> 

It's still very helpful to know the symbol name that is causing
the issue.

> 
> I would change the code simply as follows:
> 
> 
> 
> --- a/scripts/kconfig/conf.c
> +++ b/scripts/kconfig/conf.c
> @@ -76,8 +76,10 @@ static void strip(char *str)
>  /* Helper function to facilitate fgets() by Jean Sacren. */
>  static void xfgets(char *str, int size, FILE *in)
>  {
> -       if (!fgets(str, size, in))
> +       if (!fgets(str, size, in)) {
>                 fprintf(stderr, "\nError in reading or end of file.\n");
> +               exit(1);
> +       }
> 
>         if (!tty_stdio)
>                 printf("%s", str);
> 
> 
> 
> 
> 
> 
> yes "" | make config
> 
> will succeed.
> 
> 
> 
> make config < /dev/null
> 
> will fail.
> 
> 
> 
> 
> 
> People expecting the closed stdin to succeed
> may start complaining, but I believe
> they must fix their wrong scripts.
> 
> 

-- 
~Randy
