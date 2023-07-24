Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F33CD76034D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 01:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjGXXrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 19:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjGXXrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 19:47:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDB1171B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 16:47:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F1FD61173
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 23:47:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47469C433C7;
        Mon, 24 Jul 2023 23:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690242457;
        bh=AsgzhlOowdQCqAqSl23pe+ClF/XmTNnLUie2u/6buoY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M7BXlfolrLmBmqw4OYgyCWnBe56SZ0XF4LzJAlNfpXaBeIjN2B7cZqj0hUuaIpJKb
         4ReA8InZBj2JUOVbTiAax/i64ZHB0trvwYU8JQupdi6SNpMaaoFU0lTSxa6AetLck+
         6b+PI3k2ZYe4j/V1NMqI94hsjvVq7p/X0/V1FJcQdWAvIXSTyQpNojFQ6DeWG/fshk
         SHVG4QngGmDE4VxfN1F+w0MFt4orZU6QrbpQuktsGjljKxpZ1plvOY8FUjy5Wa+QBX
         tN1fuzpnnAt8kZ91Md68nagrL/dVBhxH4w6jTQWy/RaYZBaVB5ueF5t3cF8AIY5LGI
         iPr2lWkGubgqg==
Date:   Mon, 24 Jul 2023 16:47:34 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        John Stultz <jstultz@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/2] scripts/faddr2line: Ignore non-function symbols in
 readelf output
Message-ID: <20230724234734.zy67gm674vl3p3wv@treble>
References: <20230724174517.15736-1-will@kernel.org>
 <20230724174517.15736-2-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230724174517.15736-2-will@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 06:45:16PM +0100, Will Deacon wrote:
> Non-function symbols emitted in the readelf output can confuse the
> 'faddr2line' symbol size calculation, resulting in the erroneous
> rejection of valid offsets. This is especially prevalent when building
> an arm64 kernel with CONFIG_CFI_CLANG=y, where most functions are
> prefixed with a 32-bit data value in a '$d.n' section. For example:
> 
> 447538: ffff800080014b80   548 FUNC    GLOBAL DEFAULT    2 do_one_initcall
>    104: ffff800080014c74     0 NOTYPE  LOCAL  DEFAULT    2 $x.73
>    106: ffff800080014d30     0 NOTYPE  LOCAL  DEFAULT    2 $x.75
>    111: ffff800080014da4     0 NOTYPE  LOCAL  DEFAULT    2 $d.78
>    112: ffff800080014da8     0 NOTYPE  LOCAL  DEFAULT    2 $x.79
>     36: ffff800080014de0   200 FUNC    LOCAL  DEFAULT    2 run_init_process
> 
> Adding a warning to do_one_initcall() results in:
> 
>   | WARNING: CPU: 0 PID: 1 at init/main.c:1236 do_one_initcall+0xf4/0x260
> 
> Which 'faddr2line' refuses to accept:
> 
> $ ./scripts/faddr2line vmlinux do_one_initcall+0xf4/0x260
> skipping do_one_initcall address at 0xffff800080014c74 due to size mismatch (0x260 != 0x224)
> no match for do_one_initcall+0xf4/0x260
> 
> Filter out entries from readelf that are not "FUNC" type, so that the
> size of a symbol is calculated as a delta to the next function address.

Problem is, I think the kernel's symbol printing code prints the nearest
kallsyms symbol, and there are some valid non-FUNC code symbols.  For
example, syscall_return_via_sysret.  This patch would cause those valid
symbols to get missed.

I presume these '$x.*' symbols don't end up in System.map?  How do they
get filtered out?  By the linker maybe?

We may want to use whatever criteria used there, e.g. have faddr2line
ignore symbols starting with '$' or so?

-- 
Josh
