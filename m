Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C297F17D9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 16:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234076AbjKTPxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 10:53:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234020AbjKTPw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 10:52:56 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F3FB4;
        Mon, 20 Nov 2023 07:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Subject:Cc:To:From:Date:Message-Id:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=MZyP9bbN2OhFmaCO48JjdH05j95W9qWzKHyC/r9shIA=; b=AJ8R0APoE3kvguae/t7BRpSBMx
        CbYGmu5Fck97KBn9bNsfBC/0axTNbqoXuhPbuH3owW4KH2Tj3hpjWvP0ZJuXGmgo2hoV8mw2Z2GKK
        9UcjURzUH8ViNZr/kAh4OJQSdtGinFLoIhZy+RLK/0LpEYf2czxFxlWSsJWzjcTOF627S2Vk/is7C
        H0Y+uXehusnOrffASCN/8v/dNbj0roeAthhOWeakUv27dUwPB7Fi8nVK6K6rDzheSgqoRuNPxeMoa
        oY1eUM456tHJ58poVvkLUmZNl8QRxoPypM8BNJBMCLc7QhGAhnKHTHe16kR/UNsXimxuaZw0KDyWZ
        z8+52VYg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r56Z8-00B1Hd-1z;
        Mon, 20 Nov 2023 15:52:03 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
        id 444DF300419; Mon, 20 Nov 2023 16:52:01 +0100 (CET)
Message-Id: <20231120144642.591358648@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 20 Nov 2023 15:46:42 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     peterz@infradead.org
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, davem@davemloft.net, dsahern@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        samitolvanen@google.com, keescook@chromium.org, nathan@kernel.org,
        ndesaulniers@google.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-arch@vger.kernel.org,
        llvm@lists.linux.dev, jpoimboe@kernel.org, joao@overdrivepizza.com,
        mark.rutland@arm.com
Subject: [PATCH 0/2] x86/bpf: Fix FineIBT vs eBPF
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

There's a problem with FineIBT and eBPF using __nocfi when
CONFIG_BPF_JIT_ALWAYS_ON=n, in which case the __nocfi indirect call can target
a normal function like __bpf_prog_run32().

Specifically the various preambles look like:

   FineIBT				JIT

   __cfi_foo:
      endbr64
      subl	$hash, %r10d
      jz	1f
      ud2
   1: nop
   foo:					foo:
      osp nop3				   endbr64
      ...				   ...

So while bpf_dispatcher_*_func() does a __nocfi call to foo()+0 and this
matches what the JIT generates, it does not work for regular FineIBT functions,
since their +0 endbr got poisoned and things go *boom*.

Cure this by teaching the BPF JIT about all the various CFI forms. Notably this
removes the last __nocfi call on x86.

If the BPF folks agree (and the robots don't find fail) I'd like to take this
through the x86 tree, because I have a few more patches that turn the non-fatal
'osp nop3' poison into a 4 byte ud1 instruction which is rather fatal. As a
result this problem will also surface on !IBT hardware.

