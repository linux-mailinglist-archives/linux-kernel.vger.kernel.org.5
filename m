Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC0D7B778D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 07:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232728AbjJDF4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 01:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjJDFz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 01:55:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A8BAD
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 22:55:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2F41C433C7;
        Wed,  4 Oct 2023 05:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696398953;
        bh=ssPARn68NgZDptbx2mvFf6HZm3RGCbrKiLLObwEzL6k=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=cfb7ppcDmUlLaFFSKE4IQKv/be6tMpKFfECXmye5RC4kDTwlvkn4oIqiX6iAVNIxn
         yEfyicZRlqC3jadXNqUBaTa4HiaqekF2w/VI6dWbCCmaB3/Z/ymmAY7PwDb+8FGr3P
         V0xNYXYja95n/PyMqGZrkwiGJ0EJ1aGes4ewYNYR3SESSpnsPmR74609h2uwIwYq6h
         9GmlBsUOtLVAwVGBnGMskAvIUuPw1ixj6mDkFmHDlpfcarITey7MZXJale6rKGYvjt
         EZs8Uz2gjGlI+UjcK1Pz4Z9o7xTzSSG7EyAHnKwk1Z0USVLpmQGDwLTbDyvqzSoN+C
         3NVQ1KnszEb+w==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: Re: [PATCH -fixes] riscv: Fix ftrace syscall handling which are now
 prefixed with __riscv_
In-Reply-To: <20231003182407.32198-1-alexghiti@rivosinc.com>
References: <20231003182407.32198-1-alexghiti@rivosinc.com>
Date:   Wed, 04 Oct 2023 07:55:50 +0200
Message-ID: <87r0mb3p95.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexandre Ghiti <alexghiti@rivosinc.com> writes:

> ftrace creates entries for each syscall in the tracefs but has failed
> since commit 08d0ce30e0e4 ("riscv: Implement syscall wrappers") which
> prefixes all riscv syscalls with __riscv_.
>
> So fix this by implementing arch_syscall_match_sym_name() which allows us
> to ignore this prefix.
>
> And also ignore compat syscalls like x86/arm64 by implementing
> arch_trace_is_compat_syscall().
>
> Fixes: 08d0ce30e0e4 ("riscv: Implement syscall wrappers")
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>

This fix does the BPF test suite happier!

Tested-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
