Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36D677EB47
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 23:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346334AbjHPVDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 17:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346384AbjHPVCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 17:02:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F042270A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 14:02:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C89266EDF
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 21:02:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA0BCC433C8;
        Wed, 16 Aug 2023 21:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692219771;
        bh=wE8YRwdB9MfE4hhH0w6yLhSm+34TieTMC2SFyVcLFQY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W/y2T+fSgzDTkPSbODwXG3ejmV0kctnK/J0GLFDwT5V1t/YRY5wzbOJaiTiQ2l2ae
         Wl8EUl04GCKrEyvE+QamQ4qf53QtIMWBi90XsMhP7rcYFDmFczwAwtxhQ1I97R7ZWh
         64Hs0+JCRiPfBR17N2sJjJLlwjQN5r7fOJaZm9DGJ0Pc8n8tFtC4A3EbSAUTqwtUEw
         NJwbOc/QwwUfA7D6SN7M9iTZx5XrBPkfRtgKALlBsd1LMbiE2mJB6Q1Bemjbv6+rDA
         6Mb3ik2Qk9Ti6rF4v5VTJK87STF5I6/p3kYd/rOgt8/AS19CEkehFjJy/tLQYkUSf1
         sPVM4fD/Lxk8Q==
Date:   Wed, 16 Aug 2023 14:02:49 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, baron@akamai.com, rostedt@goodmis.org,
        ardb@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, christian@bricart.de,
        song@kernel.org, mcgrof@kernel.org
Subject: Re: [PATCH v2] x86/static_call: Fix __static_call_fixup()
Message-ID: <20230816210249.7jk6wmxatfz7riwr@treble>
References: <20230815230809.GA973560@hirez.programming.kicks-ass.net>
 <20230816104419.GA982867@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230816104419.GA982867@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 12:44:19PM +0200, Peter Zijlstra wrote:
> 
> Christian reported spurious module load crashes after some of Song's
> module memory layout patches.
> 
> Turns out that if the very last instruction on the very last page of the
> module is a 'JMP __x86_return_thunk' then __static_call_fixup() will
> trip a fault and die.
> 
> And while the module rework made this slightly more likely to happen,
> it's always been possible.
> 
> Fixes: ee88d363d156 ("x86,static_call: Use alternative RET encoding")
> Reported-by: Christian Bricart <christian@bricart.de>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>

-- 
Josh
