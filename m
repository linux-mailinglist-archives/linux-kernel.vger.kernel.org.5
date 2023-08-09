Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9DB776294
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 16:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbjHIOeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 10:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233569AbjHIOeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 10:34:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D29B2123
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 07:34:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22D9863C1F
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 14:34:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3477C433C8;
        Wed,  9 Aug 2023 14:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691591652;
        bh=Pxrp/nTjB2g7POw4gq6Z7s8LJfCLybCdtnbsoSynndQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sX6sNxvDYAEX8FZa2q34GC1g8GgzvihtbMCRcApCk63xBsO91IHB0nEUqunuriv6/
         TFt+yP2NnVGUL4iYm41cAo4Wmlf+7DLJiTN73J5Jr40s+8RWJueKv7SYjijgp2j6OJ
         t3GMrjOGu+XJFCXpGnROtWgySb1OAkxoE396HYIsX9r5IJJyQBWqJ0qf5iuer5x+Z2
         9wZlmr//Q9TlYYVWOwAUu4wiggF2dJosaFBt6kFqbUSmhLE9po9KvyX7In45dVYYlB
         8lA+v6/6f4k6zwbD6xVXKDsVgqWD0qNFVUeCJCCQShcB2MDqQEsUj/YO6OXv+KWbHM
         q2sTDLo346ngQ==
Date:   Wed, 9 Aug 2023 10:34:09 -0400
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, gregkh@linuxfoundation.org
Subject: Re: [RFC][PATCH 13/17] objtool/x86: Add arch_is_offset_insn()
Message-ID: <20230809143409.5rs4jjvgsk64np6h@treble>
References: <20230809071218.000335006@infradead.org>
 <20230809072201.326960605@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230809072201.326960605@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 09:12:31AM +0200, Peter Zijlstra wrote:
> Add a little wrappery to identify the magic symbols that are actually
> inside another instruction -- yay for variable length instruction
> encoding.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  tools/objtool/arch/x86/decode.c      |    6 ++++++
>  tools/objtool/check.c                |   13 ++++++++++---
>  tools/objtool/include/objtool/arch.h |    1 +
>  tools/objtool/include/objtool/elf.h  |    1 +
>  4 files changed, 18 insertions(+), 3 deletions(-)
> 
> --- a/tools/objtool/arch/x86/decode.c
> +++ b/tools/objtool/arch/x86/decode.c
> @@ -826,3 +826,9 @@ bool arch_is_rethunk(struct symbol *sym)
>  {
>  	return !strcmp(sym->name, "__x86_return_thunk");
>  }
> +
> +bool arch_is_offset_insn(struct symbol *sym)
> +{
> +	return !strcmp(sym->name, "zen_return_thunk") ||
> +	       !strcmp(sym->name, "srso_safe_ret");
> +}

arch_is_embedded_in_insn()?

-- 
Josh
