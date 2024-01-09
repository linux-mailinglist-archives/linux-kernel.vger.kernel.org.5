Return-Path: <linux-kernel+bounces-21052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C1C828911
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 16:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06DC11C23D4C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5093A1D1;
	Tue,  9 Jan 2024 15:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="urIOvyOe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B783A1A4;
	Tue,  9 Jan 2024 15:32:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7EFDC433F1;
	Tue,  9 Jan 2024 15:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704814371;
	bh=hDja7E4tLI84/B+LvKvpuGzDwB00YZ742js1mLiw8AE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=urIOvyOeYXKfa+n5L5JpW8d918D2fKc4i1SpRLtvR7WRQDMQ05W6MSBDoqt1ixtO/
	 hVHMzKuzqzELPV8JUWHykNDc0Dcjte+zJrOyoKKr79ML/O3vPUvX/YU9bzWgZfgvVe
	 VCT8xwJ6q519RUMfWR0Pf6cUJ5EV9kpk7DZMuWbTQS7Irjra/lyUsknqE1BYsaPC/z
	 OC8qRED1dePHyyfuL1fJPo2rsu4MmmXDr11qXXun0G5iqbF0CIHbEoNNMfuwA5vY1Z
	 SQc34JFXkU9rtl/4qrTMTWu0fpaw1eBDItt2B6XgsBEo+u+tHP+PNsLpPLkn6LkojA
	 sHJ/BCMefuYIg==
Date: Tue, 9 Jan 2024 08:32:49 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Kees Cook <keescook@chromium.org>,
	"Gustavo A . R . Silva" <gustavo@embeddedor.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] Compiler Attributes: counted_by: bump compiler versions
Message-ID: <20240109153249.GA205400@dev-arch.thelio-3990X>
References: <20240109133633.1103876-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109133633.1103876-1-senozhatsky@chromium.org>

On Tue, Jan 09, 2024 at 10:36:24PM +0900, Sergey Senozhatsky wrote:
> Bump compiler versions, as GCC is expected to implement it
> in version 15 and current clang-18 still has no support for
> counted_by(). Also fix clang URL - the project has moved
> to github.
> 
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
>  include/linux/compiler_attributes.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
> index 28566624f008..1829c24c3357 100644
> --- a/include/linux/compiler_attributes.h
> +++ b/include/linux/compiler_attributes.h
> @@ -95,11 +95,11 @@
>  #endif
>  
>  /*
> - * Optional: only supported since gcc >= 14
> - * Optional: only supported since clang >= 18
> + * Optional: only supported since gcc >= 15
> + * Optional: only supported since clang >= 19

It is still possible in theory for this feature to make clang-18, as the
release/18.x branch is not scheduled to be cut until the fourth Tuesday
in January, which is two weeks from now. I don't have a good feeling for
how close that pull request is to being mergeable though, so this is
fine for now. I assume this won't go to Linus immediately so we would
have time to change it if necessary.

The link change is obviously good.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

I should probably go through and try to update all the other
review.llvm.org links to GitHub as well...

>   *
>   *   gcc: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=108896
> - * clang: https://reviews.llvm.org/D148381
> + * clang: https://github.com/llvm/llvm-project/pull/76348
>   */
>  #if __has_attribute(__counted_by__)
>  # define __counted_by(member)		__attribute__((__counted_by__(member)))
> -- 
> 2.43.0.472.g3155946c3a-goog
> 

