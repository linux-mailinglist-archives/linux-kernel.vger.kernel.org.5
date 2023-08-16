Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C1777D6ED
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 02:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240761AbjHPAKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 20:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240746AbjHPAKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 20:10:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F53B1FF9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 17:10:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F24B061F1D
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 00:10:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D01F3C433C7;
        Wed, 16 Aug 2023 00:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692144635;
        bh=iuMFAheImAxMAx+YMsypZpjJZiLt71RLL+wQgYlnNps=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kuZ8Gg3jta3rBcVxwh9J6nLDxmb+0Du47cOZy+6tzfgvXvYgdq6/oqC5tbEOK54F1
         Yyf5Y4X7N2yYAqRD2mt4+LYAXHBuBgWb0hzdkiV9B5eM0pnSZQraxc1pWTyObhsN6p
         VH4pPbogkpH9drlow8siTsFSR215mli0BTvwFdUl3pL1g65SOX54yNHJ+mKHesGZ1J
         KdVdtmVqBIw4qwdD3hHG1XG1FrIqLJZzKhJ1USXZIYP5vQhNiwuE79uMPS7/ip9r7e
         ot8kPwpS9zVUVws8S4JA7+PwPUGKpkdzhcX3kYb8sp47++ZyUahfPVUrlvONfb/Lx0
         hbo3Icad/KpZA==
Date:   Tue, 15 Aug 2023 17:10:32 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, baron@akamai.com, rostedt@goodmis.org,
        ardb@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, christian@bricart.de,
        song@kernel.org, mcgrof@kernel.org
Subject: Re: [PATCH] x86/static_call: Fix __static_call_fixup()
Message-ID: <20230816001032.n4jp2uek3gi654bq@treble>
References: <20230815230809.GA973560@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230815230809.GA973560@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 01:08:09AM +0200, Peter Zijlstra wrote:
>  bool __static_call_fixup(void *tramp, u8 op, void *dest)
>  {
> +	/*
> +	 * Not all .return_sites are a static_call trampoline (most are not).
> +	 * Check if the next 3 bytes are still kernel text, if not, then this

s/3/7 ?

> +	 * definitely is not a trampoline and we need not worry further.
> +	 *
> +	 * This avoids the memcmp() below tripping over pagefaults etc..
> +	 */
> +	if (!kernel_text_address(tramp+7))
> +		return false;
> +
>  	if (memcmp(tramp+5, tramp_ud, 3)) {
>  		/* Not a trampoline site, not our problem. */
>  		return false;

kernel_text_address() can be quite heavyweight to call in a loop during
module loading.  Maybe that doesn't matter much.  But it would be a lot
faster to only call kernel_text_address() if tramp+7 is on the next
page.

-- 
Josh
