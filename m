Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5FE576A186
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 21:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjGaTsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 15:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjGaTsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 15:48:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A250A0;
        Mon, 31 Jul 2023 12:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=G10afZyCNiaw2vu2jAC3R9gIyzTLIVHGE2tClR0IBw8=; b=kBp+2VJp5ZkwgOk6UXkI6Hycfa
        6kT98WUmhx2HQkhtNUZTNNoe07jkAj4Lz4PjP+7r5FBs15S+dQQb2piYzaUHD0peDdc8WIdLQxMQK
        DNFi0PDdxcs5CJoEXFHGSc7/TGeaYG1Ke5nrUTGoljolHji24RtvsxqdvE5A7itlLqUScknltKB3Z
        zWy96M9RwO8SFgNHBjDdAjDnzHwsoV3IjCqVd1ylRCKJHShmoUN00v/rzC7LsqX7U0zpk2QAtFJhj
        LWnDr4Thcm4PrDlyS5MM6o9h4m4nkIP9/R16jO8Ry8c5m88Uki668qErHNvG+0fkJkOImHmzuHHTb
        jeL6dO4A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qQYry-003T3N-E9; Mon, 31 Jul 2023 19:47:54 +0000
Date:   Mon, 31 Jul 2023 20:47:54 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Brendan Sweeney <brs@rivosinc.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        =?iso-8859-1?Q?R=E9mi?= Denis-Courmont <remi@remlab.net>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Atish Patra <atishp@rivosinc.com>
Subject: Re: [PATCH v4 09/10] tools: lib: perf: Implement riscv mmap support
Message-ID: <ZMgP6hhD/k7QNQ3t@casper.infradead.org>
References: <20230727141428.962286-1-alexghiti@rivosinc.com>
 <20230727141428.962286-10-alexghiti@rivosinc.com>
 <CAP-5=fU5XYXrVnRUidpwjV2LiTsdebfidL43_Qo4Z7TBxMsVGA@mail.gmail.com>
 <CAHVXubgVAe1WsiZx5Ay+3KPK4u24k_vsnTwFFmBeVsHrGXwhfw@mail.gmail.com>
 <CAHVXubj80rQRShuDS09BeTrfR6nux0A68EMWLbeat8fd_Y3YdA@mail.gmail.com>
 <CAP-5=fWwzuGZ6a6Z38ndsb7gw7_uwS0a2VGXx08hMeiK8eZ91w@mail.gmail.com>
 <CAHVXubjhM9C1fw_Us=8+RuSJbW0pacFAk9gp7j2=BtMUPy_Byw@mail.gmail.com>
 <CAP-5=fUbiaVwSAhTbymyhdUPcVAXHiQZZexAOnrqid0LsPmfpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUbiaVwSAhTbymyhdUPcVAXHiQZZexAOnrqid0LsPmfpw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 09:46:07AM -0700, Ian Rogers wrote:
> On Mon, Jul 31, 2023 at 9:06 AM Alexandre Ghiti <alexghiti@rivosinc.com> wrote:
> > I have just had the answer internally (thanks to @Brendan Sweeney):
> > csr modifications can alter how the memory is accessed (satp which
> > changes the address space, sum which allows/disallows userspace
> > access...), so we need the memory barrier to make sure the compiler
> > does not reorder the memory accesses.
> 
> The conditions you mention shouldn't apply here though? Even if you
> add a memory barrier for the compiler what is stopping the hardware
> reordering loads and stores? If it absolutely has to be there then a
> comment something like "There is a bug is riscv where the csrr
> instruction can clobber memory breaking future reads and some how this
> constraint fixes it by ... ".

If the hardware doesn't know that writing to a csr can change how memory
accesses are done and reorders memory accesses around that csr write,
you've got a really broken piece of hardware on your hands ...

I know nothing about risc-v, and maybe the definition says that you need
to put a memory barrier before and/or after it in the instruction stream,
but on all hardware I'm familiar with, writing to a CSR is an implicitly
serialising operation.
