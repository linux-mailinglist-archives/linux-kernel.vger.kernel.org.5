Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04CB67F710F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 11:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345563AbjKXKP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 05:15:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345737AbjKXKPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 05:15:41 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE811719;
        Fri, 24 Nov 2023 02:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=X/ymfIJYGS3rgfsyyKZPvatWK1hMRdU56iYMTo6mr84=; b=rCFKbF3mDACBFhTXzRNdFrFO4O
        eoXOKmJ9nZiGJbfFMIBv6nwz3CsjBdIoMhWkUoG1xIESyQX9y7utknNb2crx4yYaVl0TokaNQnX59
        UQEefO9tha/lsxyx4F65ZPyZ5QCqVo0rlZL/kdkYuCLGIjIenfBE0G4ANfmh4TiCyiHjQw5pCSoOw
        9nE6YLG7xrJLF6VvKnJbRf5H0lcpRBYkeFjXyVCwHcJ8GALVBfL/W2eebEDWHFXmQx9wxeHAVLh5J
        AP7Md+iD5Lbnbp5HhKqJfhCerVvC52VYb0wyb/cpFm3UZZNXbX+76free6tqI6J6N/OKWjkdwAGLS
        Lh31sbQw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r6TDU-00DqKC-0M;
        Fri, 24 Nov 2023 10:15:20 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 83119300338; Fri, 24 Nov 2023 11:15:19 +0100 (CET)
Date:   Fri, 24 Nov 2023 11:15:19 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christoph Muellner <christoph.muellner@vrull.eu>
Cc:     linux-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Anup Patel <apatel@ventanamicro.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Andrew Jones <ajones@ventanamicro.com>,
        Guo Ren <guoren@kernel.org>,
        Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Daniel Lustig <dlustig@nvidia.com>
Subject: Re: [RFC PATCH 0/5] RISC-V: Add dynamic TSO support
Message-ID: <20231124101519.GP3818@noisy.programming.kicks-ass.net>
References: <20231124072142.2786653-1-christoph.muellner@vrull.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231124072142.2786653-1-christoph.muellner@vrull.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 08:21:37AM +0100, Christoph Muellner wrote:
> From: Christoph Müllner <christoph.muellner@vrull.eu>
> 
> The upcoming RISC-V Ssdtso specification introduces a bit in the senvcfg
> CSR to switch the memory consistency model at run-time from RVWMO to TSO
> (and back). The active consistency model can therefore be switched on a
> per-hart base and managed by the kernel on a per-process/thread base.

You guys, computers are hartless, nobody told ya?

> This patch implements basic Ssdtso support and adds a prctl API on top
> so that user-space processes can switch to a stronger memory consistency
> model (than the kernel was written for) at run-time.
> 
> I am not sure if other architectures support switching the memory
> consistency model at run-time, but designing the prctl API in an
> arch-independent way allows reusing it in the future.

IIRC some Sparc chips could do this, but I don't think anybody ever
exposed this to userspace (or used it much).

IA64 had planned to do this, except they messed it up and did it the
wrong way around (strong first and then relax it later), which lead to
the discovery that all existing software broke (d'uh).

I think ARM64 approached this problem by adding the
load-acquire/store-release instructions and for TSO based code,
translate into those (eg. x86 -> arm64 transpilers).

IIRC Risc-V actually has such instructions as well, so *why* are you
doing this?!?!
