Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E4379F3D7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 23:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbjIMVb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 17:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjIMVb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 17:31:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AAFB91724
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 14:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694640664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=91TDHfKWyNcniwPo6icRVlVFGUzya3X9UEIIOH1o+MM=;
        b=G/n/xsPvtqg5nW7jR5vK22g2DsfFH6hebLG+LA+uvZr7MacUH+haarvPT9e9qVye3AEp/Q
        PmBWtNPAziuYo2sD+Kjyoqfqj9zqNNDXb/ByL7ca4l3ndwQ7Aqyz2t7YOj43M1mxLgNfXp
        LxIwneYtXZZjdhZtLNr3kdpQ5vsuv9M=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-STF98fJrMPGavBMG8h4xOA-1; Wed, 13 Sep 2023 17:31:03 -0400
X-MC-Unique: STF98fJrMPGavBMG8h4xOA-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-76dd2550295so37909285a.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 14:31:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694640662; x=1695245462;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=91TDHfKWyNcniwPo6icRVlVFGUzya3X9UEIIOH1o+MM=;
        b=UH6eDc/NjoexD/2rnnbv6qh9s9wLsyrn9TS4pjfeh1mxrS1FEHNcbA5/SZ1aK46Is7
         IRiO1SJXm5d/g3+p88u7H/K1thNQ/lSkZ1zIOpaMlrCrTK96H499sNlb5+LkHtNhoku7
         Qv4wG3BLf0yBmcbGW9sjreohHQsZDl2TouYq5zHZq8s0lRk/zql3SgxV60Dv+3BJcIVT
         SQek6ulUrJxAo0pgx9SmNrpbOYL3iNptUqyjxtCk970/JqdwuE7gsYz50PEJMqc7cuIN
         raRaIPkStBOO/7/NHQJ+GZbFff+9+Xm+pgCIGHn93fC18XOY7kvxjr3pZWj0zhT7FfZO
         f2Jg==
X-Gm-Message-State: AOJu0Yxh+bNttKgphZu9Rvi2yLOBSFJOQg3grRThPqRQZgngLNJdSMdF
        5StATsHZasoFvOUlihxHjIisk2ZAIH8TXp/qfqnd1C6yv/5xM95sfsf7EAtmgYd+Hqbukv2mIKd
        Oob0AWFp0m5EwPqLHW6dcY8c9BsGeFuLT
X-Received: by 2002:a05:620a:25c6:b0:770:df33:58ac with SMTP id y6-20020a05620a25c600b00770df3358acmr3903891qko.36.1694640662692;
        Wed, 13 Sep 2023 14:31:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHbIiso4/gYXvz8peyMt5Uc8yB9q3KxC/NKWnz7vLM5TDxmaYZjvImv7B3PZ+lGHusfLaaaA==
X-Received: by 2002:a05:620a:25c6:b0:770:df33:58ac with SMTP id y6-20020a05620a25c600b00770df3358acmr3903877qko.36.1694640662407;
        Wed, 13 Sep 2023 14:31:02 -0700 (PDT)
Received: from rh (p200300c93f1ec600a890fb4d684902d4.dip0.t-ipconnect.de. [2003:c9:3f1e:c600:a890:fb4d:6849:2d4])
        by smtp.gmail.com with ESMTPSA id oo18-20020a05620a531200b00765ab6d3e81sm29574qkn.122.2023.09.13.14.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 14:31:01 -0700 (PDT)
Date:   Wed, 13 Sep 2023 23:30:57 +0200 (CEST)
From:   Sebastian Ott <sebott@redhat.com>
To:     Willy Tarreau <w@1wt.eu>
cc:     =?ISO-8859-15?Q?Thomas_Wei=DFschuh?= <linux@weissschuh.net>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: aarch64 binaries using nolibc segfault before reaching the entry
 point
In-Reply-To: <20230913205838.GA21038@1wt.eu>
Message-ID: <57707201-b8a6-1389-d451-033e9e13fe1c@redhat.com>
References: <5d49767a-fbdc-fbe7-5fb2-d99ece3168cb@redhat.com> <2da5ce29-e0de-4715-aa77-453ff3cc48aa@t-8ch.de> <20230913205838.GA21038@1wt.eu>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463795790-1700873777-1694640661=:19348"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463795790-1700873777-1694640661=:19348
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 13 Sep 2023, Willy Tarreau wrote:
> On Wed, Sep 13, 2023 at 10:19:00PM +0200, Thomas Weißschuh wrote:
>>> All on aarch64 running fedora37 + upstream kernel. Any hints on what could
>>> be borken here or how to actually fix it?
>>
>> I reduced it to the following reproducer:
>>
>>     $ cat test.c
>>     int foo;  /* It works when deleting this variable */
>>
>>     void __attribute__((weak, noreturn, optimize("Os", "omit-frame-pointer"))) _start(void)
>>     {
>>     	__asm__ volatile (
>>     		"mov x8, 93\n"       /* NR_exit == 93 */
>>     		"svc #0\n"
>>     	);
>>     	__builtin_unreachable();
>>     }
>>
>>     $ aarch64-linux-gnu-gcc -Os -static -fno-stack-protector -Wall -nostdlib test.c
>>     $ ./a.out
>>     Segmentation fault
>>
>> Also when running under gdb the error message is:
>>
>>     During startup program terminated with signal SIGSEGV, Segmentation fault.
>>
>> So it seems the error already happens during loading.
>>
>> Could be a compiler or kernel bug?
>
> I tried here with gcc-11.4.0 native on an ubuntu-22.04 and using a
> cross gcc-9.5 executed on another box and couldn't reproduce the issue
> at all. It could be that the compiler inserts whatever, did someone
> try to disassemble de resulting program to see what it looks like ?
> Maybe we're even dealing with issues related to random stack alignment
> that causes issues past a function call due to some garbage being placed
> at the wrong place in the stack. Also, dmesg should generally report
> what (and where) the segv happened. Similarly, gdb with "info reg"
> and "disassemble $pc" should report some info.

Sadly there is no kernel output for this I guess this happens just too
early. gdb just reports "The program has no registers now."

Sebastian
---1463795790-1700873777-1694640661=:19348--

