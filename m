Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98CC87DEA46
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 02:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348012AbjKBBmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 21:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbjKBBmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 21:42:15 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377DF10E
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 18:42:12 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-2800c221af2so455446a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 18:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1698889331; x=1699494131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3fm1ZyyOcsA8wjDRuIpsTTo8wiDi5ib4FYzkiHs1w04=;
        b=GHzI/X/WuonoSMf9/6HfZQMyfuW3RN4Jn82Pn6rudUtQXYfufncCQ7R+nHJfhvHfXG
         JhJxOW/lUcBfkXgt1n/mfoAbf7maRwe0e7suxR4cJQ7d3C3JcsJ9OjYKmeSo3mOFSQBx
         JkvLiEMYDuhHSol9wy23yYvlqUrlMR9KU7KCAhK0vzf1ahhudVd9uw+VKRKQucDISnpG
         MvexNEklzhAqxy+RGJG7LnjFrdsgw759L1NIsunZMNy8htZZl78L/9c7MIkd7mkFuVh2
         aLqa4+rILA4nV/nYIWSgmekuoFA31zs2yshv+D11rRPr9+0SGaQyfLxva3SdbIfM9qIO
         td3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698889331; x=1699494131;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3fm1ZyyOcsA8wjDRuIpsTTo8wiDi5ib4FYzkiHs1w04=;
        b=GvO11JTOW8dbHD/gu0Uj6yNqWqp9e8z5nMZjbfDvCDYVm1qsoCdVEvKdJYWYkrvUMX
         MGZxzkQt8iodItkFpuhSEdj7UfEwy5ZaLumcuTM5AvljPeEvEeayftTU6WmRcnFYOY2y
         5mwCAk6BWo66XQINRg4I3rG9c+olHRkFla6hyjAjU+SlVdXBuCP9j426YfY0cS5sAowC
         AgJJDOPk6G5XlD3hdfa8/WaSe5R5UbYERQOLtAHweNUBYyN4kyOEkZOFy7J/cxrZJe4R
         OC3xNjiI0bGWIJTGAQxDzNQovreoUImkq6moniYJhs+MS6OyH8VeSSiCY9ioPtK70YgM
         mfHw==
X-Gm-Message-State: AOJu0YyNeZI+vPYGgAlCThBx3NAV/V9cOfFKRXA5vKGJMuXsARogE8GO
        ZKDCvm4z2VJD3Uc/zx82ZWkN8g==
X-Google-Smtp-Source: AGHT+IH51zTtsKFSOlKMwd/y9VfDttx+UnqJ+HS5r6aeeTGJRnYLq7FIrav7895W+8HTqdLQf2H4ow==
X-Received: by 2002:a17:90b:2485:b0:27f:fec6:b9c9 with SMTP id nt5-20020a17090b248500b0027ffec6b9c9mr14402082pjb.9.1698889331490;
        Wed, 01 Nov 2023 18:42:11 -0700 (PDT)
Received: from localhost ([12.44.203.122])
        by smtp.gmail.com with ESMTPSA id 3-20020a17090a1a4300b00268b439a0cbsm1495151pjl.23.2023.11.01.18.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 18:42:10 -0700 (PDT)
Date:   Wed, 01 Nov 2023 18:42:10 -0700 (PDT)
X-Google-Original-Date: Wed, 01 Nov 2023 18:42:09 PDT (-0700)
Subject:     Re: [PATCH net] tcp: Fix -Wc23-extensions in tcp_options_write()
In-Reply-To: <20231102010723.GA406542@dev-arch.thelio-3990X>
CC:     edumazet@google.com, davem@davemloft.net, dsahern@kernel.org,
        kuba@kernel.org, pabeni@redhat.com, ndesaulniers@google.com,
        trix@redhat.com, 0x7f454c46@gmail.com, fruggeri@arista.com,
        noureddine@arista.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        patches@lists.linux.dev
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     nathan@kernel.org
Message-ID: <mhng-41e9fb36-f703-461e-b585-9e8dd5984714@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Nov 2023 18:07:23 PDT (-0700), nathan@kernel.org wrote:
> On Wed, Nov 01, 2023 at 05:41:10PM -0700, Palmer Dabbelt wrote:
>> On Tue, 31 Oct 2023 13:23:35 PDT (-0700), nathan@kernel.org wrote:
>> > Clang warns (or errors with CONFIG_WERROR=y) when CONFIG_TCP_AO is set:
>> >
>> >   net/ipv4/tcp_output.c:663:2: error: label at end of compound statement is a C23 extension [-Werror,-Wc23-extensions]
>> >     663 |         }
>> >         |         ^
>> >   1 error generated.
>> >
>> > On earlier releases (such as clang-11, the current minimum supported
>> > version for building the kernel) that do not support C23, this was a
>> > hard error unconditionally:
>> >
>> >   net/ipv4/tcp_output.c:663:2: error: expected statement
>> >           }
>> >           ^
>> >   1 error generated.
>> >
>> > Add a semicolon after the label to create an empty statement, which
>> > resolves the warning or error for all compilers.
>> >
>> > Closes: https://github.com/ClangBuiltLinux/linux/issues/1953
>> > Fixes: 1e03d32bea8e ("net/tcp: Add TCP-AO sign to outgoing packets")
>> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
>> > ---
>> >  net/ipv4/tcp_output.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
>> > index f558c054cf6e..6064895daece 100644
>> > --- a/net/ipv4/tcp_output.c
>> > +++ b/net/ipv4/tcp_output.c
>> > @@ -658,7 +658,7 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
>> >  			memset(ptr, TCPOPT_NOP, sizeof(*ptr));
>> >  			ptr++;
>> >  		}
>> > -out_ao:
>> > +out_ao:;
>> >  #endif
>> >  	}
>> >  	if (unlikely(opts->mss)) {
>> >
>> > ---
>> > base-commit: 55c900477f5b3897d9038446f72a281cae0efd86
>> > change-id: 20231031-tcp-ao-fix-label-in-compound-statement-warning-ebd6c9978498
>> >
>> > Best regards,
>>
>> This gives me a
>>
>> linux/net/ipv4/tcp_output.c:663:2: error: expected statement
>>        }
>>
>> on GCC for me.
>
> What GCC version?

12.1, though I can't get a smaller reproducer so I'm going to roll back 
to your change and double-check.  Might take a bit...

> I cannot reproduce that error with my patch applied. I tested mainline
> at commit deefd5024f07 ("Merge tag 'vfio-v6.7-rc1' of
> https://github.com/awilliam/linux-vfio") using GCC 6 from kernel.org and
> I can reproduce a similar failure with ARCH=x86_64 allyesconfig:
>
>   net/ipv4/tcp_output.c: In function 'tcp_options_write':
>   net/ipv4/tcp_output.c:661:1: error: label at end of compound statement
>    out_ao:
>    ^~~~~~
>
> With this change applied, the error disappears for GCC 6 and GCC 13
> continues to build without error. I can try the other supported versions
> later, I just did an older and newer one for a quick test.
>
>> So I think something like
>>
>> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
>> index f558c054cf6e..ca09763acaa8 100644
>> --- a/net/ipv4/tcp_output.c
>> +++ b/net/ipv4/tcp_output.c
>> @@ -659,6 +659,11 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
>> 			ptr++;
>> 		}
>> out_ao:
>> +	/*
>> +	 * Labels at the end of compound statements are a C23 feature, so
>> +	 * introduce a block to avoid a warning/error on strict toolchains.
>> +	 */
>> +	{}
>> #endif
>> 	}
>> 	if (unlikely(opts->mss)) {
>>
>> should do it (though it's still build testing...)
>
> I am not opposed to this once we understand what versions are affected
> by this so that we have some timeline of removing this workaround.
>
> Cheers,
> Nathan
