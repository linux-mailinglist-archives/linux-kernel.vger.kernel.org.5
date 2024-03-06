Return-Path: <linux-kernel+bounces-94492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A210A87409E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3693C282EC9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300B4140E47;
	Wed,  6 Mar 2024 19:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JKLC432o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77190140E25
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 19:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709754024; cv=none; b=BQDcV9DT9GxOJaSZjA5w3HnfyMcpqQJTP/mSoJ5PUDr+zlD9/nWRnFAOho4GUtNKkFjeKKN7ptQVQo36LBIYC+8e2zXk++MZd6pzVw73qeHb3FpHW0/yUO+oECbTgh99HmDyAKBF0Ye08Ed+uz1SIXlqiKzVjxuUpPqrk7Bfmb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709754024; c=relaxed/simple;
	bh=5/Zn7NHW1uTwkwELhBiHm6Z/dCQjigrm4gBqAaJY9Ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hTsmbn2mQah4Vi/fEtq0oshQkKccP5khswCqvnx8S4dgvfYC9TE5m1B2IHuCwqOa22Aaax4yNw2B4w2tf+CMAlD54lvD0frFxgEQpSgkOqRR0kAC8cuddyQAhUH1uLZqLq5DvesCiDfsyfbCPeXuM1rmyXs180SxmSvmRfST1Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JKLC432o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A15D6C433C7;
	Wed,  6 Mar 2024 19:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709754023;
	bh=5/Zn7NHW1uTwkwELhBiHm6Z/dCQjigrm4gBqAaJY9Ho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JKLC432oMy/qlvpf9vVwvVrMXSu9agkHKeeO3zV41CO6dZ20Sm+V1eNXj22cNLo5Z
	 G+5sWuR3L6AmhazuPitHyEI9Q62kI8Foz0g935QQYo5vAzrjZ8nDxoXm0R/Wr/9CFG
	 vPXG+0e+XKAtpxEOR49vSMOYzsg0x7aSvwcfzAYphXrOpC1eDjwtgQjdyTDVvoqQSC
	 SuqdIW6aNwut2F9YETPd7sXXRv9mmM45omYm/5wkTilQZD9GK9SEX1YNN/R2vmh6sP
	 W8ymyxZAaL1dbgbc4v+T12pja5MoSTS/EQylltQZ+i5r84F3qO2rQpqaPUmf0jdR02
	 kkHwk+XGSsg9Q==
Date: Wed, 6 Mar 2024 12:40:20 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Chunhui Li <chunhui.li@mediatek.com>
Cc: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com
Subject: Re: [PATCH] printk: fix _entry_ptr build warning
Message-ID: <20240306194020.GA3711543@dev-arch.thelio-3990X>
References: <20240306092647.16010-1-chunhui.li@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306092647.16010-1-chunhui.li@mediatek.com>

On Wed, Mar 06, 2024 at 05:26:47PM +0800, Chunhui Li wrote:
> We build with Werror and suffer build error when
> enable CONFIG_PRINTK_INDEX, such as
> gfp.h:223:2: error: unused variable '_entry_ptr'
> ratelimit.h:31:3: error: unused variable '_entry_ptr'
> kallsyms.h:172:2: error: unused variable '_entry_ptr'
> [-Werror,-Wunused-variable]
> 
> Fix the warning by appending __attribute__((unused)).
> 
> Signed-off-by: Chunhui Li <chunhui.li@mediatek.com>

Are these warnings being emitted from an Android version of clang,
specifically 18.0.0 with the build ID of 11209041 (you should be able to
tell this from the "bid" field in the BUILD_INFO file in the clang
toolchain folder)? This seems remarkably similar to
https://github.com/ClangBuiltLinux/linux/issues/1977, which was a report
using that version of Android clang.

Ultimately, this warning is a bug in a clang change that was quickly
found and reverted upstream

  https://github.com/llvm/llvm-project/commit/f0f395e00e2ec3f1f20ca9021d1554fde73d56c9
  https://github.com/llvm/llvm-project/commit/cfa578cde0314935c6eb5d7fa19ec26390d431dd

but unfortunately, Android picked a revision for the 11209041 build that
was between the landing of the broken commit and its revert. It was
quickly fixed with the 11368308 build

  https://android.googlesource.com/platform/prebuilts/clang/host/linux-x86/+/42d100b025eb5f4a41781348016c148e9e912cf9

so you should just be able to update to that version to resolve this.

Cheers,
Nathan

> ---
>  include/linux/printk.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/printk.h b/include/linux/printk.h
> index 8ef499ab3c1e..749c1c4257f1 100644
> --- a/include/linux/printk.h
> +++ b/include/linux/printk.h
> @@ -392,7 +392,7 @@ struct pi_entry {
>  				.level = __builtin_constant_p(_level) ? (_level) : NULL, \
>  				.subsys_fmt_prefix = _subsys_fmt_prefix,\
>  			};						\
> -			static const struct pi_entry *_entry_ptr	\
> +			static const struct pi_entry *_entry_ptr __attribute__((unused)) \
>  			__used __section(".printk_index") = &_entry;	\
>  		}							\
>  	} while (0)
> -- 
> 2.18.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

