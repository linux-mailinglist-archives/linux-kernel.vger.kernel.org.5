Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D3E77D726
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 02:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240856AbjHPAls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 20:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240851AbjHPAlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 20:41:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03AE41BFB
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 17:41:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9159160E98
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 00:41:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BE7DC433C8;
        Wed, 16 Aug 2023 00:41:11 +0000 (UTC)
Date:   Tue, 15 Aug 2023 20:41:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     jpoimboe@kernel.org, x86@kernel.org, baron@akamai.com,
        ardb@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, christian@bricart.de,
        song@kernel.org, mcgrof@kernel.org
Subject: Re: [PATCH] x86/static_call: Fix __static_call_fixup()
Message-ID: <20230815204112.1f7ab2bf@gandalf.local.home>
In-Reply-To: <20230815230809.GA973560@hirez.programming.kicks-ass.net>
References: <20230815230809.GA973560@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Aug 2023 01:08:09 +0200
Peter Zijlstra <peterz@infradead.org> wrote:


> diff --git a/arch/x86/kernel/static_call.c b/arch/x86/kernel/static_call.c
> index b70670a98597..2e67512d7104 100644
> --- a/arch/x86/kernel/static_call.c
> +++ b/arch/x86/kernel/static_call.c
> @@ -186,6 +186,16 @@ EXPORT_SYMBOL_GPL(arch_static_call_transform);
>   */
>  bool __static_call_fixup(void *tramp, u8 op, void *dest)
>  {
> +	/*
> +	 * Not all .return_sites are a static_call trampoline (most are not).
> +	 * Check if the next 3 bytes are still kernel text, if not, then this
> +	 * definitely is not a trampoline and we need not worry further.
> +	 *
> +	 * This avoids the memcmp() below tripping over pagefaults etc..
> +	 */
> +	if (!kernel_text_address(tramp+7))

The comment says "next 3 bytes" and the test is "tramp+7". Why the magic 7 number?

If the tramp is 5 bytes, shouldn't it be +8?

-- Steve


> +		return false;
> +
>  	if (memcmp(tramp+5, tramp_ud, 3)) {
>  		/* Not a trampoline site, not our problem. */
>  		return false;

