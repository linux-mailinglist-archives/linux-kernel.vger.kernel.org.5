Return-Path: <linux-kernel+bounces-15840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5309C823428
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 19:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17C5A286C88
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 18:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05AC21C697;
	Wed,  3 Jan 2024 18:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hgiGavpj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517AE1C68A;
	Wed,  3 Jan 2024 18:15:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AE03C433C7;
	Wed,  3 Jan 2024 18:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704305744;
	bh=AUXrWa4gez8USeQ48h8WOwSAUbB123G3JwiEuIp/YrM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hgiGavpjnyWCBS+MOW1xqN+TMQo7IoZrUXbaSExkf51Dv66D5lZxSzuU2DvD0JyoS
	 KGY7vBvcsByvQkjkaYqD4P4Xd/QSsl8qeEjNDFm4Ru87DYlzs0VJj1g5i7lVaWMvjy
	 2wCLrDZvwV6CNqDyih5ZpZgyo2gnzUtMuhSrHLi+eSRawL+KIV5Oiyang1guGb6Awj
	 hsEOp66LkLFXgK9VAvRDQ9rNq9N/lUDMdFXG1G0sLczCk0mNF0xzPw4qx4Egb/DsTo
	 bSqqXS9+WWEdDgRU4BDWGOuhX27W4dna2kmVIIyOHnau9VX2WvOkSjYnDGmht2Y/mp
	 39wEn5K3GbyPw==
Date: Wed, 3 Jan 2024 11:15:42 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	patches@lists.linux.dev
Subject: Re: [PATCH] x86/tools: objdump_reformat.awk: Skip bad instructions
 from llvm-objdump
Message-ID: <20240103181542.GA629234@dev-arch.thelio-3990X>
References: <20231205-objdump_reformat-awk-handle-llvm-objdump-bad_expr-v1-1-b4a74f39396f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205-objdump_reformat-awk-handle-llvm-objdump-bad_expr-v1-1-b4a74f39396f@kernel.org>

Ping? I am still seeing this issue.

On Tue, Dec 05, 2023 at 12:53:08PM -0700, Nathan Chancellor wrote:
> When running the instruction decoder selftest with LLVM=1 +
> CONFIG_PVH=y, there is a series of warnings:
> 
>   arch/x86/tools/insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
>   arch/x86/tools/insn_decoder_test: warning: ffffffff81000050     ea                      <unknown>
>   arch/x86/tools/insn_decoder_test: warning: objdump says 1 bytes, but insn_get_length() says 7
>   arch/x86/tools/insn_decoder_test: warning: Decoded and checked 7214721 instructions with 1 failures
> 
> GNU objdump outputs "(bad)" instead of "<unknown>", which is already
> handled in the bad_expr regex, so there is no warning.
> 
>   $ objdump -d arch/x86/platform/pvh/head.o | grep -E '50:\s+ea'
>   50:   ea                      (bad)
> 
>   $ llvm-objdump -d arch/x86/platform/pvh/head.o | grep -E '50:\s+ea'
>         50: ea                            <unknown>
> 
> Add "<unknown>" to the bad_expr regex to clear up the warning, allowing
> the instruction decoder selftest to fully pass with llvm-objdump.
> 
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  arch/x86/tools/objdump_reformat.awk | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/tools/objdump_reformat.awk b/arch/x86/tools/objdump_reformat.awk
> index a4120d907277..20b08a6c4d33 100644
> --- a/arch/x86/tools/objdump_reformat.awk
> +++ b/arch/x86/tools/objdump_reformat.awk
> @@ -11,7 +11,7 @@ BEGIN {
>  	prev_addr = ""
>  	prev_hex = ""
>  	prev_mnemonic = ""
> -	bad_expr = "(\\(bad\\)|^rex|^.byte|^rep(z|nz)$|^lock$|^es$|^cs$|^ss$|^ds$|^fs$|^gs$|^data(16|32)$|^addr(16|32|64))"
> +	bad_expr = "(\\(bad\\)|<unknown>|^rex|^.byte|^rep(z|nz)$|^lock$|^es$|^cs$|^ss$|^ds$|^fs$|^gs$|^data(16|32)$|^addr(16|32|64))"
>  	fwait_expr = "^9b[ \t]*fwait"
>  	fwait_str="9b\tfwait"
>  }
> 
> ---
> base-commit: 5225952d74d43e4c054731c74b8afd700b23a94a
> change-id: 20231205-objdump_reformat-awk-handle-llvm-objdump-bad_expr-9e74cd2a08b5
> 
> Best regards,
> -- 
> Nathan Chancellor <nathan@kernel.org>
> 
> 

