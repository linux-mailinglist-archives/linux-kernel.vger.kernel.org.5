Return-Path: <linux-kernel+bounces-11581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BA181E87B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 17:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33C1AB21ECB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 16:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7084F61D;
	Tue, 26 Dec 2023 16:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bhXkKEjr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF7F4E62B;
	Tue, 26 Dec 2023 16:38:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22AA9C433C7;
	Tue, 26 Dec 2023 16:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703608684;
	bh=RxHy8+ihBu9w7EFvm3iGuBimY1BWS+E6JAT10AejE9U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bhXkKEjrhRBt0b+ZqhcMUP2ear3PjkkvDOZuNqXcWZpkTMHclVEfF7oDaYeN7skrz
	 ZS+gPzFYDwBvztIMN1NezADGXvwEIHPG03lgLB0HFNyl7h3cfwJs5xZtD5nq7KsDYR
	 xpPgWojDqcE82LR2Xi4L/+iM+Fm6opPbzI3DwJRVz2M/hJx4NBRQjMGtP8HuI1pwiY
	 DVkh0yGIjF8x99COupGQPe1QXShSw4RAAapkIGtfYdn059f5OVOvo5CLtlHCL3IEbJ
	 oNCi+ekVZAD4AqVPCcIn1PjobWHwstrEzfDh4EBYrFHg5fMF/u6uGHIAtDCg8KhKaQ
	 eKuTLiziqjvZw==
Date: Tue, 26 Dec 2023 09:38:02 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] scripts/decode_stacktrace.sh: Support LLVM addr2line
Message-ID: <20231226163802.GA952423@dev-arch.thelio-3990X>
References: <20231225-decode-stacktrace-llvm-v1-1-abb9aa220cbf@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231225-decode-stacktrace-llvm-v1-1-abb9aa220cbf@quicinc.com>

On Mon, Dec 25, 2023 at 10:52:57AM -0800, Bjorn Andersson wrote:
> The kernel build system adhere to the LLVM environment variable, to
> select building the kernel using clang/llvm. In combination with the
> ARCH environment variable the kernel can be cross-compiled without the
> user specifying the CROSS_COMPILE variable.
> 
> The LLVM environment variable is used to specify the suffix of the llvm
> executables (such as LLVM=-12 for llvm-addr2line-12), or to omit the
> suffix when set to "1" (e.g. llvm-addr2line).
> 
> decode_stacktrace.sh allows invoking a specific addr2line executable by
> prefixing the command with CROSS_COMPILE. At best allows the user to
> trick decode_stacktrace.sh into invoking llvm-addr2line, and it does not
> support specifying an alternative version based on the suffix.
> 
> Teach decode_stacktrace.sh about the two cases of the LLVM environment
> variable, and use this to determine which addr2line to use. The current
> behavior is maintained when the LLVM variable is not set.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>

Hmmm, this is the second patch to decode_stacktrace.sh in the same
number of weeks...

https://lore.kernel.org/20231215-llvm-decode-stacktrace-v1-1-201cb86f4879@quicinc.com/

Nick pointed out on that one that Carlos's patch from some time ago was
even better at using all LLVM tools and requested testing/review on that
one.

https://lore.kernel.org/20230929034836.403735-1-cmllamas@google.com/

Furthermore, this patch does not handle the LLVM=<prefix>/bin/ syntax
that we support, which I personally use all the time.

Cheers,
Nathan

> ---
>  scripts/decode_stacktrace.sh | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/decode_stacktrace.sh b/scripts/decode_stacktrace.sh
> index 564c5632e1a2..adf1d64477a1 100755
> --- a/scripts/decode_stacktrace.sh
> +++ b/scripts/decode_stacktrace.sh
> @@ -16,6 +16,13 @@ elif type c++filt >/dev/null 2>&1 ; then
>  	cppfilt_opts=-i
>  fi
>  
> +# Determine which addr2line to use
> +case "$LLVM" in
> +	""	) addr2line="${CROSS_COMPILE}addr2line";;
> +	"1"	) addr2line="llvm-addr2line";;
> +	*	) addr2line="llvm-addr2line${LLVM}";;
> +esac
> +
>  if [[ $1 == "-r" ]] ; then
>  	vmlinux=""
>  	basepath="auto"
> @@ -169,7 +176,7 @@ parse_symbol() {
>  	if [[ $aarray_support == true && "${cache[$module,$address]+isset}" == "isset" ]]; then
>  		local code=${cache[$module,$address]}
>  	else
> -		local code=$(${CROSS_COMPILE}addr2line -i -e "$objfile" "$address" 2>/dev/null)
> +		local code=$(${addr2line} -i -e "$objfile" "$address" 2>/dev/null)
>  		if [[ $aarray_support == true ]]; then
>  			cache[$module,$address]=$code
>  		fi
> 
> ---
> base-commit: 39676dfe52331dba909c617f213fdb21015c8d10
> change-id: 20231225-decode-stacktrace-llvm-f260a1614361
> 
> Best regards,
> -- 
> Bjorn Andersson <quic_bjorande@quicinc.com>
> 
> 

