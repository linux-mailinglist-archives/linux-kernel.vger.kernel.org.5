Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B357DFB77
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 21:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbjKBUYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 16:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjKBUX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 16:23:59 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B607186
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 13:23:56 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-5875e2b27c5so465198eaf.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 13:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1698956635; x=1699561435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZYxqorYTLyNgH4Ys5lNUekyUrwpkE+NAoR9Xx/kQ8MQ=;
        b=1qAmgj4zLduDhMvPJzRi0HkTyUVdhhRV4+LAgpxiP2wloWJaqbEz040uaaSBCnLYXT
         Q6urspTLANP3FvNUuoDOxFoaz5xs6RC6rDGQegCqJDMrCh9e1MOooGYnhOHps2TWjD6D
         vjY3M/ClCf4g3eLnGHgnLGwbb4kmND7Mzsu26SMby5b7s2i/8nHy8ZwjJWXTM3tbNoir
         3h0o6IURTx6DN67BeqMxipopgwEnUt34+zWpnTBb3QqvyOwtkWfQ2Rsd5tTkCUbYdy86
         4jPo6ruIOUhB89BtBnO36nlD3Uw5bjlSDa783eNRv5J6/Kh/acohwJ0RYh7Bcr+tdWGt
         PX2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698956635; x=1699561435;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZYxqorYTLyNgH4Ys5lNUekyUrwpkE+NAoR9Xx/kQ8MQ=;
        b=HeUfwdVcb0zpVERzEk48dB6bDnm8soIALEgOUNM/DsHLzoKRS15bReh9xyOIgqPe2W
         RuhcoXYhcC7jRd5cDwYbEX7C3z8e/159f+durrybfBXp4SyP5lGPhtmyE7x232HT4M9G
         eQNuL61k1TPU1V49C5f8OQCenRud4IBISuDHpk4+3UN82o3/p6K8hHpbH9LEKLO50i+M
         EIe2JvJEIWJqlCkeCg5re6OL4OjsThhhcCpj7QyDdegYbUNGV9QuMKDrHLrbjvX7o51J
         FiXmys/0iT8zEsAyJOOB0PPHcJmZL7zsqjNm+OZcUKG9upC8N5GPhK0us8tccpD/MahT
         lTFw==
X-Gm-Message-State: AOJu0Yyh5BWDUXO8/JkxatrOl2tN6zol2hjF/SBeLw0qdJE57yTOfzP1
        cvMcpqx93AjM/0Bo8DJLEYT7Zw==
X-Google-Smtp-Source: AGHT+IHvjzSJSgbbFHJHFSPQEfHZb0G1dwFxE6QUSYdRHcKUimuPg3oA0e89k53MrVMNkydfp+r/RA==
X-Received: by 2002:a4a:b487:0:b0:581:ff09:62e4 with SMTP id b7-20020a4ab487000000b00581ff0962e4mr19252180ooo.2.1698956635428;
        Thu, 02 Nov 2023 13:23:55 -0700 (PDT)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id 64-20020a4a0943000000b0057b43a25deasm52070ooa.3.2023.11.02.13.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 13:23:54 -0700 (PDT)
Date:   Thu, 02 Nov 2023 13:23:54 -0700 (PDT)
X-Google-Original-Date: Thu, 02 Nov 2023 13:23:51 PDT (-0700)
Subject:     Re: [PATCH net] tcp: Fix -Wc23-extensions in tcp_options_write()
In-Reply-To: <mhng-41e9fb36-f703-461e-b585-9e8dd5984714@palmer-ri-x1c9a>
CC:     edumazet@google.com, davem@davemloft.net, dsahern@kernel.org,
        kuba@kernel.org, pabeni@redhat.com, ndesaulniers@google.com,
        trix@redhat.com, 0x7f454c46@gmail.com, fruggeri@arista.com,
        noureddine@arista.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        patches@lists.linux.dev
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     nathan@kernel.org
Message-ID: <mhng-7500e386-1e83-4303-a1ee-cd2d5688e73e@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Nov 2023 18:42:10 PDT (-0700), Palmer Dabbelt wrote:
> On Wed, 01 Nov 2023 18:07:23 PDT (-0700), nathan@kernel.org wrote:
>> On Wed, Nov 01, 2023 at 05:41:10PM -0700, Palmer Dabbelt wrote:
>>> On Tue, 31 Oct 2023 13:23:35 PDT (-0700), nathan@kernel.org wrote:
>>> > Clang warns (or errors with CONFIG_WERROR=y) when CONFIG_TCP_AO is set:
>>> >
>>> >   net/ipv4/tcp_output.c:663:2: error: label at end of compound statement is a C23 extension [-Werror,-Wc23-extensions]
>>> >     663 |         }
>>> >         |         ^
>>> >   1 error generated.
>>> >
>>> > On earlier releases (such as clang-11, the current minimum supported
>>> > version for building the kernel) that do not support C23, this was a
>>> > hard error unconditionally:
>>> >
>>> >   net/ipv4/tcp_output.c:663:2: error: expected statement
>>> >           }
>>> >           ^
>>> >   1 error generated.
>>> >
>>> > Add a semicolon after the label to create an empty statement, which
>>> > resolves the warning or error for all compilers.
>>> >
>>> > Closes: https://github.com/ClangBuiltLinux/linux/issues/1953
>>> > Fixes: 1e03d32bea8e ("net/tcp: Add TCP-AO sign to outgoing packets")
>>> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
>>> > ---
>>> >  net/ipv4/tcp_output.c | 2 +-
>>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>>> >
>>> > diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
>>> > index f558c054cf6e..6064895daece 100644
>>> > --- a/net/ipv4/tcp_output.c
>>> > +++ b/net/ipv4/tcp_output.c
>>> > @@ -658,7 +658,7 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
>>> >  			memset(ptr, TCPOPT_NOP, sizeof(*ptr));
>>> >  			ptr++;
>>> >  		}
>>> > -out_ao:
>>> > +out_ao:;
>>> >  #endif
>>> >  	}
>>> >  	if (unlikely(opts->mss)) {
>>> >
>>> > ---
>>> > base-commit: 55c900477f5b3897d9038446f72a281cae0efd86
>>> > change-id: 20231031-tcp-ao-fix-label-in-compound-statement-warning-ebd6c9978498
>>> >
>>> > Best regards,
>>>
>>> This gives me a
>>>
>>> linux/net/ipv4/tcp_output.c:663:2: error: expected statement
>>>        }
>>>
>>> on GCC for me.
>>
>> What GCC version?
>
> 12.1, though I can't get a smaller reproducer so I'm going to roll back
> to your change and double-check.  Might take a bit...

Looks like there was just some bug in my test scripts and the original 
patch wasn't actually picked up for all the configs.  It's working now, 
so

Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>

Sorry for the confusion!

>> I cannot reproduce that error with my patch applied. I tested mainline
>> at commit deefd5024f07 ("Merge tag 'vfio-v6.7-rc1' of
>> https://github.com/awilliam/linux-vfio") using GCC 6 from kernel.org and
>> I can reproduce a similar failure with ARCH=x86_64 allyesconfig:
>>
>>   net/ipv4/tcp_output.c: In function 'tcp_options_write':
>>   net/ipv4/tcp_output.c:661:1: error: label at end of compound statement
>>    out_ao:
>>    ^~~~~~
>>
>> With this change applied, the error disappears for GCC 6 and GCC 13
>> continues to build without error. I can try the other supported versions
>> later, I just did an older and newer one for a quick test.
>>
>>> So I think something like
>>>
>>> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
>>> index f558c054cf6e..ca09763acaa8 100644
>>> --- a/net/ipv4/tcp_output.c
>>> +++ b/net/ipv4/tcp_output.c
>>> @@ -659,6 +659,11 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
>>> 			ptr++;
>>> 		}
>>> out_ao:
>>> +	/*
>>> +	 * Labels at the end of compound statements are a C23 feature, so
>>> +	 * introduce a block to avoid a warning/error on strict toolchains.
>>> +	 */
>>> +	{}
>>> #endif
>>> 	}
>>> 	if (unlikely(opts->mss)) {
>>>
>>> should do it (though it's still build testing...)
>>
>> I am not opposed to this once we understand what versions are affected
>> by this so that we have some timeline of removing this workaround.
>>
>> Cheers,
>> Nathan
