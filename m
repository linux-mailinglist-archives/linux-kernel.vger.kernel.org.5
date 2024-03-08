Return-Path: <linux-kernel+bounces-97538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2EA876BA5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 21:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 032951F21D3A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 20:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C175D47B;
	Fri,  8 Mar 2024 20:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bwXjVQtG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4262D60B;
	Fri,  8 Mar 2024 20:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709929223; cv=none; b=W1R5/fexdQ0cJTju+1IArxCy2eNXtp+LD1cUeWOkaisBwojvk8ki1YwDch+Xsp0w7pkdSnEimQQ9iBuk+dr2W8HlUNyO02dST/+5s7NtXdLhAW65Ux9cwg6lrgDRxvdta+OST8h8c75dFEMoTykxKZFiVK56S9jD+S2u77l2W1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709929223; c=relaxed/simple;
	bh=gYgxy4F5CnKyHPKbcHJaavUq/XxDolwE8qGCqjDXh+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WeCE+apYQ4hPwFER36veNPFS7q2fCbAKtOvdRnBRzpbd5QMbHMpXvJoN2c9uAxpYYvW+rdsdVuC0b0Sq92Hl3irjMeMfsq/w13DR8kshqUOxopDjXdgq4beUerNRVCxtlr/NbGeP6MJbd2XqXl9F+DZl2xC3txywWNz9T1qZF7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bwXjVQtG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33931C433C7;
	Fri,  8 Mar 2024 20:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709929223;
	bh=gYgxy4F5CnKyHPKbcHJaavUq/XxDolwE8qGCqjDXh+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bwXjVQtGGIi4z05dXM7t+mW349nAbNwduE6oKVrFaZqaqvjJAZm1gY9cyKAaaGzVz
	 jeIwty/w36mFs0a1IIzAQA0eel7mIwNKMwXnn3QRuKZkesAf96SFGm2HRHvyWsDzkR
	 Ic29K329b7pgj1Ddkv8YZlovz2x7xk9WTC7TuDGbyRR8eYWnkB7FsGpkAIgQQnlntd
	 KR14Yc8aUhx3c87tFBIAuvlqn7x+QBYUvhD9n6gwg2+m1QsW0zm6rybHTFwnjK6Rt1
	 YJtX06wEpTmXnvJUMUeHrD1N9CvJAHtpr9tlqrVU8cJkkGHb34BD4L2HIBH+pmpn0R
	 UYec58b4sG9Wg==
Date: Fri, 8 Mar 2024 20:20:18 +0000
From: Simon Horman <horms@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] overflow: Change DEFINE_FLEX to take __counted_by
 member
Message-ID: <20240308202018.GC603911@kernel.org>
References: <20240306235128.it.933-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306235128.it.933-kees@kernel.org>

On Wed, Mar 06, 2024 at 03:51:36PM -0800, Kees Cook wrote:
> The norm should be flexible array structures with __counted_by
> annotations, so DEFINE_FLEX() is updated to expect that. Rename
> the non-annotated version to DEFINE_RAW_FLEX(), and update the
> few existing users.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Hi Kees,

I'm unclear what this is based on, as it doesn't appear to apply
cleanly to net-next or the dev-queue branch of the iwl-next tree.
But I manually applied it to the latter and ran some checks.

..

> diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
> index f84bab80ca42..d4baae8c3b72 100644
> --- a/drivers/net/ethernet/intel/ice/ice_switch.c
> +++ b/drivers/net/ethernet/intel/ice/ice_switch.c

Given what is currently in the dev-queue branch of the iwl-next tree,
the following hunk also seems to be required for ice_switch.c.

@@ -5378,7 +5378,7 @@ ice_get_compat_fv_bitmap(struct ice_hw *hw, struct ice_adv_rule_info *rinfo,
  */
 static int ice_subscribe_recipe(struct ice_hw *hw, u16 rid)
 {
-	DEFINE_FLEX(struct ice_aqc_alloc_free_res_elem, sw_buf, elem, 1);
+	DEFINE_RAW_FLEX(struct ice_aqc_alloc_free_res_elem, sw_buf, elem, 1);
 	u16 buf_len = __struct_size(sw_buf);
 	u16 res_type;
 	int status;

..

> diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> index aa691f2119b0..677b03c4c84f 100644
> --- a/include/linux/overflow.h
> +++ b/include/linux/overflow.h
> @@ -396,9 +396,9 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
>   * @name: Name for a variable to define.
>   * @member: Name of the array member.
>   * @count: Number of elements in the array; must be compile-time const.
> - * @initializer: initializer expression (could be empty for no init).
> + * @initializer...: initializer expression (could be empty for no init).

Curiously kernel-doc --none seems happier without the line above changed.

>   */
> -#define _DEFINE_FLEX(type, name, member, count, initializer)			\
> +#define _DEFINE_FLEX(type, name, member, count, initializer...)			\
>  	_Static_assert(__builtin_constant_p(count),				\
>  		       "onstack flex array members require compile-time const count"); \
>  	union {									\

..

