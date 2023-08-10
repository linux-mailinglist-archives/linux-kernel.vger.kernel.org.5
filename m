Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65FF8777E1D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 18:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbjHJQXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 12:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbjHJQXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 12:23:37 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CA52133
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 09:23:36 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-51b4ef5378bso850472a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 09:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1691684616; x=1692289416;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K/oujXsuCZNyJ7beuH4thfI7Yg3Owqk0Evwp+NQ9/Ag=;
        b=tOhr8QlGuuLYwtzgrCExPgKzkc+mdwQSaUCSeIw8tDRrXsI0qvHEmsAOIqUBALO6NT
         n/o8YUH0REX+nURR6TwsIRoG0tKVVy9ezrW21avpnUMb+v2qqMwp9zZw5mqCNK5sPVEy
         G6vvmERyd7ksq0WDlHCrKj4788yFpjMDoF29Ge+lZ8K38Pqkt3XKD9rZqh64flWa77yC
         +vNKaeBLBZmPLZfoduB+4EvO05g5rGUkvn5xzkE9US94Xx7gAttISKzJYYheCIclMyiH
         CWqfF+3plJBQY5VJi/9sTlfDfg+VeSXC+RgtA952o/qsrsheDGc+4ZNFFXn7/4IIdR5O
         qX3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691684616; x=1692289416;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K/oujXsuCZNyJ7beuH4thfI7Yg3Owqk0Evwp+NQ9/Ag=;
        b=ay6Uwhy6IYbcoNRvjMYLfdBn6oWQwdBPJw+Y46fsQsnXPJEMCvDEYIQxoO+oHbu7Ky
         1OE/Zl5NaOP3q/qTfhf6+9SKOKvupq1womEZIrIA6msFtbD+c5dUwwhhcDRk0XmDFV4j
         ejG6NtpoqSpRuJojb3p1xnlKXoMRlw5ng6uIJyIDgzBhJacOvoU/q6X83DlmDDAeGdRT
         kB3ncEDVk2GmNh0kmu8wDREWTNfNgx1p/XlIbM/jvf576Ne4zHzSm19n5KiKKVChcGxR
         UBS+eB85dfGUqvmyKOGvtgfYcqrpcVpPPKzUFWbs3hDKt+yjVa0ioA0Yi8q7eNcZ9dJ8
         QWrg==
X-Gm-Message-State: AOJu0YylZUgG7g685xbHIUdO52jom3Q2yjIlRV+mmcaSF+3ETu3+nqox
        YcrzDZcViZ4eqJFWNnOOWJmr4w==
X-Google-Smtp-Source: AGHT+IH5NjFG9ebyRPc7nGWmHQsTm1rfLT1IflWmJ6tGtItusVgprAJhLWBFgU4p6rhMI5D3oXgNZA==
X-Received: by 2002:a17:90a:fa02:b0:268:13c4:b800 with SMTP id cm2-20020a17090afa0200b0026813c4b800mr2650610pjb.21.1691684615778;
        Thu, 10 Aug 2023 09:23:35 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id c9-20020a17090aa60900b00260a5ecd273sm1672318pjq.1.2023.08.10.09.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 09:23:35 -0700 (PDT)
Date:   Thu, 10 Aug 2023 09:23:35 -0700 (PDT)
X-Google-Original-Date: Thu, 10 Aug 2023 09:23:33 PDT (-0700)
Subject:     Re: [RFC PATCH v5 5/5] riscv/cmpxchg: Implement xchg for variables of size 1 and 2
In-Reply-To: <98f523e515b2adc2aa7bb8d133353bad74e30897.camel@redhat.com>
CC:     Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
        peterz@infradead.org, boqun.feng@gmail.com,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, parri.andrea@gmail.com,
        andrzej.hajda@intel.com, guoren@kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     leobras@redhat.com
Message-ID: <mhng-92f37526-d36c-48c0-8fbd-7676df1b6086@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2023 09:04:04 PDT (-0700), leobras@redhat.com wrote:
> On Thu, 2023-08-10 at 08:51 +0200, Arnd Bergmann wrote:
>> On Thu, Aug 10, 2023, at 06:03, Leonardo Bras wrote:
>> > xchg for variables of size 1-byte and 2-bytes is not yet available for
>> > riscv, even though its present in other architectures such as arm64 and
>> > x86. This could lead to not being able to implement some locking mechanisms
>> > or requiring some rework to make it work properly.
>> > 
>> > Implement 1-byte and 2-bytes xchg in order to achieve parity with other
>> > architectures.
>> > 
>> > Signed-off-by: Leonardo Bras <leobras@redhat.com>
>> 
>
> Hello Arnd Bergmann, thanks for reviewing!
>
>> Parity with other architectures by itself is not a reason to do this,
>> in particular the other architectures you listed have the instructions
>> in hardware while riscv does not.
>
> Sure, I understand RISC-V don't have native support for xchg on variables of
> size < 4B. My argument is that it's nice to have even an emulated version for
> this in case any future mechanism wants to use it.
>
> Not having it may mean we won't be able to enable given mechanism in RISC-V. 

IIUC the ask is to have a user within the kernel for these functions.  
That's the general thing to do, and last time this came up there was no 
in-kernel use of it -- the qspinlock stuff would, but we haven't enabled 
it yet because we're worried about the performance/fairness stuff that 
other ports have seen and nobody's got concrete benchmarks yet (though 
there's another patch set out that I haven't had time to look through, 
so that may have changed).

So if something uses these I'm happy to go look closer.

>> Emulating the small xchg() through cmpxchg() is particularly tricky
>> since it's easy to run into a case where this does not guarantee
>> forward progress.
>> 
>
> Didn't get this part:
> By "emulating small xchg() through cmpxchg()", did you mean like emulating an
> xchg (usually 1 instruction) with lr & sc (same used in cmpxchg) ?
>
> If so, yeah, it's a fair point: in some extreme case we could have multiple
> threads accessing given cacheline and have sc always failing. On the other hand,
> there are 2 arguments on that:
>
> 1 - Other architectures, (such as powerpc, arm and arm64 without LSE atomics)
> also seem to rely in this mechanism for every xchg size. Another archs like csky
> and loongarch use asm that look like mine to handle size < 4B xchg. 
>     
>
>>  This is also something that almost no architecture
>> specific code relies on (generic qspinlock being a notable exception).
>> 
>
> 2 - As you mentioned, there should be very little code that will actually make
> use of xchg for vars < 4B, so it should be safe to assume its fine to not
> guarantee forward progress for those rare usages (like some of above mentioned
> archs).
>
>> I would recommend just dropping this patch from the series, at least
>> until there is a need for it.
>
> While I agree this is a valid point, I believe its more interesting to have it
> implemented if any future mechanism wants to make use of this. 
>
>
> Thanks!
> Leo
