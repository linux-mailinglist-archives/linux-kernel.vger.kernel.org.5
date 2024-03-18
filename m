Return-Path: <linux-kernel+bounces-106832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1D987F43F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 00:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B45071C21B63
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 23:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367A75F872;
	Mon, 18 Mar 2024 23:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CElG8ibh"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B355F862
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 23:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710806016; cv=none; b=SGosw9BFTJcf66/gSNdzHUzhTaPi8DzJ+nQ9+diMvB4sXoa8rXQYXez5fKIvXQ4zXP+awjtsRym6fsUSii+GqOseoYMyCN1oBmo4BlE739sgJWpTNr71FF7Vzs+MVI/ZM86VbZXdfZX80sYQbmh2Y+PL2m7yLGPDaRipLtos/PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710806016; c=relaxed/simple;
	bh=HhOALnLvJr6e/hOsBTLFMnisPn49hkhh42F7lwsBv1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZCTi1NrKPk0HxonyU/nSXCUI2EUigZZR63+iwxSH6hNiME5hP5qFiHEik6zYclLip2wyv+FNZJGrVxM1wYpZs9YGStPLIErZFGt1FpsPr2x2jFZkAEmGI64a8grL6X6Abi6Ukt7uXfPcWLKQdb05jIvVitNBuDRkKJJJH6EQE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CElG8ibh; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1dddb160a37so35788175ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 16:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710806014; x=1711410814; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e4aQCNHMu7YycaVLkSKKBtvitVWMbxsN8tyLTuzbn1o=;
        b=CElG8ibhYZyqBptPXqoZ5Zk/t8bHqEqSySQGKUydXqnVI7IF2ebGNwPzpt+C1pcooB
         36kMafXxnuBi9XoLxwt37YX046fhFF78BpB1WU6EIsUipHwqlqPGqUj44wk9vKc22qfL
         wrNUpk9TD2mUXt+a1Naq57CCgragyslhjMEEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710806014; x=1711410814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e4aQCNHMu7YycaVLkSKKBtvitVWMbxsN8tyLTuzbn1o=;
        b=uaAnupfNgRRJ7X4/9C8v2MKDAA/xqdhlNAEEUbvFMBT/xV5R07AjAZu/7HCRNEmpZg
         u40oUSPQfw9y1qGZ23vtpBLuPxL2Cskjv9T1OsJECIzYtingrPAdE6/rSNCTBokJX8m+
         k167IJlZYPXHtNvqYJcixvJOa9hj/KbNC1wtIueEFIzaVyPhziDvTjJybn8RmNhAIutM
         ECdhKCE6YzrDlldAsttvyP0jXXS3qgyb1eorY/cuUve8par3vzqqC3EomeIf3hyP0HzU
         v4ShWiLz0nms2+vlVNyTFpZH82uMtHHfCBwP2GQUdbdZJdLpHVl1vzjRbaPzQIfHWEzi
         768w==
X-Gm-Message-State: AOJu0YyZFPk6i2aWx52Vaxa3AuRqklgbVAhQhAS4jguIzcvvNUroNJfS
	ywby2oVbO23HooPeu1pRJ+IxnW6HB2gwwJQivClIkmEuwUreuUgWzA7TRCBZLw==
X-Google-Smtp-Source: AGHT+IEedCJ+r//9PWKUMbOis0hvEVZccgS5nb2CixGCwmiwaNoNpJBcdouR4P7b3UEL6vEYdFvt9A==
X-Received: by 2002:a17:902:f681:b0:1dd:a3d7:dca3 with SMTP id l1-20020a170902f68100b001dda3d7dca3mr1468891plg.11.1710806014295;
        Mon, 18 Mar 2024 16:53:34 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h14-20020a170902680e00b001dda608484asm10111806plk.57.2024.03.18.16.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 16:53:33 -0700 (PDT)
Date: Mon, 18 Mar 2024 16:53:32 -0700
From: Kees Cook <keescook@chromium.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] stddef: Introduce struct_group_tagged_attr()
 helper macro
Message-ID: <202403181652.B8787FB288@keescook>
References: <ZfjHkXJWg12rARKU@neat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfjHkXJWg12rARKU@neat>

On Mon, Mar 18, 2024 at 05:00:33PM -0600, Gustavo A. R. Silva wrote:
> We need a new `struct_group()` helper that allows for both having the
> struct be tagged, and specifying struct attributes like `__packed`
> or `__align(x)`.
> 
> This new helper will initially be used to address
> -Wflex-array-member-not-at-end warnings, where a tagged struct is used
> to separate the flexible-array member from the rest of the members in
> the flexible structure [1]. There are some scenarios in which those
> members need to be packed, as well.
> 
> So, `struct_group_tagged_attr()` is introduced for this.
> 
> Link: https://lore.kernel.org/linux-hardening/ZeIgeZ5Sb0IZTOyt@neat/ [1]
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  include/linux/stddef.h | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/include/linux/stddef.h b/include/linux/stddef.h
> index 929d67710cc5..919df9453257 100644
> --- a/include/linux/stddef.h
> +++ b/include/linux/stddef.h
> @@ -80,6 +80,26 @@ enum {
>  #define struct_group_tagged(TAG, NAME, MEMBERS...) \
>  	__struct_group(TAG, NAME, /* no attrs */, MEMBERS)
>  
> +/**
> + * struct_group_tagged_attr() - Create a struct_group with a reusable
> + * tag and trailing attributes.
> + *
> + * @TAG: The tag name for the named sub-struct
> + * @NAME: The identifier name of the mirrored sub-struct
> + * @ATTRS: Any struct attributes to apply
> + * @MEMBERS: The member declarations for the mirrored structs
> + *
> + * Used to create an anonymous union of two structs with identical
> + * layout and size: one anonymous and one named. The former can be
> + * used normally without sub-struct naming, and the latter can be
> + * used to reason about the start, end, and size of the group of
> + * struct members. Includes struct tag argument for the named copy,
> + * so the specified layout can be reused later. Also includes
> + * structure attributes argument.
> + */
> +#define struct_group_tagged_attr(TAG, NAME, ATTRS, MEMBERS...) \
> +	__struct_group(TAG, NAME, ATTRS, MEMBERS)

This is the same as __struct_group() only with a longer name? Why not
just use __struct_group() directly?

-- 
Kees Cook

