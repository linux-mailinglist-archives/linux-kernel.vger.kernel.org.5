Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A207783141
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 21:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjHUTtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 15:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjHUTtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 15:49:09 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F96113
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 12:49:07 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d72403b9e03so4974685276.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 12:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692647347; x=1693252147;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cJZGEQtf1VL3HQEXak5eCjnl1mSbYK2LpINf2Y7mWuc=;
        b=RZl6OjBiLyxrlN7m8yUzSzxx4s8l6y5XQtCqoL2DKa9CznCEyAG8OEzPqxiGWWfNJU
         DP58nwM09rHRg7Se9vncvUgBs+EoatdB0oIHiYis/CY/mK8bpz5tBW/wF/N/V/N/8FcH
         u/rMp5FZpxMI+ASR8w8FwZSKb5yUKy8z1UKPp14XAoTBk3vwb+9KvbuE4eIugJspN8RX
         snR6LHbvF/g0TCDHMTgr7kn44jTj6A+c9BdOOfnITVAKCoxj2XXqVMiBuH5zs1EhWFJ1
         LASBEZFLbEqzA+6VnHUNymrGUBh6X+GLDf47Xj3E2vNSql4sDsL+0xZSb2rnh4OE9Sf8
         LLXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692647347; x=1693252147;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cJZGEQtf1VL3HQEXak5eCjnl1mSbYK2LpINf2Y7mWuc=;
        b=Xnj6Kr2V01sO6kQqt6DiSGmIIp81iDSsdsp7plHDyaFuJ4j80/mwHN8zFKWtRWTs6Z
         zwSIzOA8r4nRVi7WgUw/TnR/g8aV92HUVAX+GFdvXacQUfWwJFzBpVST0oqVOS3cJiZl
         ck1pFD6xJs+ZCFar/5+JnRi3CiRZdIoO/ed995PElnBLqVXiYnehAJrgzx4/t9hUqXTn
         MUfWpfQ6BurPMVRcbJN56wXLr6XCbYDyJxOQ9pqQ/7TRbmH0ALnqb6SaPhAtLjgM89Xf
         2DBAjsmco/uY872yTVWI83RM7TwLgycOdmmDXfKmNiKSOr4dFWaDJJVq2vJpioUJrY8z
         6iqw==
X-Gm-Message-State: AOJu0YxcUTbYZWMHHPgm8EGgV+WDFWd1091YXXEdwUZf6mk5VKcUv1Kb
        IhiC/7lfX1qq/tnoRb317rBBAuphkqX4Q1p3YQ==
X-Google-Smtp-Source: AGHT+IHM9bfoMlIQRP0Zhx06e/5qWh61CmNcgWIzhDyB//MY5jBFnNMVKsg1bGSAIpor6rGkYRANDK9cShM4uv9gKA==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a25:fc0d:0:b0:d07:e80c:412e with SMTP
 id v13-20020a25fc0d000000b00d07e80c412emr56346ybd.12.1692647346791; Mon, 21
 Aug 2023 12:49:06 -0700 (PDT)
Date:   Mon, 21 Aug 2023 19:49:05 +0000
In-Reply-To: <ZN/4RjDsBLf0FB98@google.com> (message from Sean Christopherson
 on Fri, 18 Aug 2023 16:01:26 -0700)
Mime-Version: 1.0
Message-ID: <diqzwmxotbv2.fsf@ackerleytng-ctop.c.googlers.com>
Subject: Re: [RFC PATCH v11 28/29] KVM: selftests: Add basic selftest for guest_memfd()
From:   Ackerley Tng <ackerleytng@google.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     pbonzini@redhat.com, maz@kernel.org, oliver.upton@linux.dev,
        chenhuacai@kernel.org, mpe@ellerman.id.au, anup@brainfault.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, willy@infradead.org,
        akpm@linux-foundation.org, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, chao.p.peng@linux.intel.com,
        tabba@google.com, jarkko@kernel.org, yu.c.zhang@linux.intel.com,
        vannapurve@google.com, mail@maciej.szmigiero.name, vbabka@suse.cz,
        david@redhat.com, qperret@google.com, michael.roth@amd.com,
        wei.w.wang@intel.com, liam.merwick@oracle.com,
        isaku.yamahata@gmail.com, kirill.shutemov@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> On Mon, Aug 07, 2023, Ackerley Tng wrote:
>> Sean Christopherson <seanjc@google.com> writes:
>> 
>> > Add a selftest to verify the basic functionality of guest_memfd():
>> >
>> > <snip>
>> 
>> Here's one more test:
>
> First off, thank you!  I greatly appreciate all the selftests work you (and
> others!) have been doing.
>
> For v2, can you please post a standalone patch?  My workflow barfs on unrelated,
> inlined patches.  I'm guessing I can get b4 to play nice, but it's easier to just
> yell at people :-)
>

Here's a standalone patch :)
https://lore.kernel.org/lkml/20230821194411.2165757-1-ackerleytng@google.com/

> <snip>
