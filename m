Return-Path: <linux-kernel+bounces-106723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DB187F29B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18C481F21BB8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6103D59B60;
	Mon, 18 Mar 2024 21:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jAd8nIVH"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E985A780
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 21:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710798743; cv=none; b=maxo77MZOWRIiI1PfonpybEO/da7eKe0+CU4jRkF7/emmGjpQE5lRAg4hFpUKe4s9Zf2wZO3UjgROgOAEkQNnx5ErxbVjYpi/vhLDPLyPA/64B3DGsMfnKF9/QDe2E0kuYpnKy8RYNImSdUxcP+Kuoc9+NVOmV26GDmDBR9lCz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710798743; c=relaxed/simple;
	bh=Zoh/plVRzNX+mESj2AyesuzyFZDwEPVf/5TgNhPjGPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m9Sf9DZ9mH6tIBNKedSjfxRjhJhD4FvMLiQwKCZsYL7eKjIcCT/PjKnaRTX2byvgRP52ichzFhXoGW3EVF5xBZOvj4uKZIWjOOtamz+IphJcDs6FcalwTsgBEaSJR6U57Ot4eQDFycu27a02m8zMXnklkkBxoix4tkopmddNsT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jAd8nIVH; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1dee5daa236so32283105ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 14:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710798741; x=1711403541; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=phAwglOrC+GzhgRWH4s2HaB4VQhNtprYIKXp99X9Uc4=;
        b=jAd8nIVHTsJd3mAUtB1mIVX+O/1XR0yVyu1V/Jqq/7zHe6ywtFaJ5uEEenYFsUycUF
         +/coFaLIZiEXAEdqUwG/yDAw+gzybaNDy5dh+Qg6jWe8SK9U3gexOao+bUyeidhr81tg
         /d6aGHp5nem58SlUCyfvjRxwbHY6aKXQyztKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710798741; x=1711403541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=phAwglOrC+GzhgRWH4s2HaB4VQhNtprYIKXp99X9Uc4=;
        b=AeifhlXR7LqX+6SKV2P3dzd41NLL1g1DbU2WQ+uBFKuLDqgEeGwTQPtnoEx0lTE95j
         w3K73vF18SrIc35moLCismcKmHrwC2X4WkA6+WiVEWpWMrCCLBMz6803xeKKuLmzF0yq
         9IjL1wKyUum2j2p0VcftL4kyCpqyv0nCs6z2kodkT8LiPkFtHPcMl8cGiLsQknlP8/36
         EIfkpKojmcVOuywQhk7tUxqA5aVfXpYQqdiP/OX0w4prK2AirmpRmZN7GPY0WPFzjyMD
         ZYmRf/bo+3BIZX94LTQEMgt8cC6IQK07yx31blRQPFj652m4dg0L1K7n18dpz87KkoDb
         uC1g==
X-Forwarded-Encrypted: i=1; AJvYcCVU3897TCH5JfYRlQtoPuhCIWV58hVxFBrWBlVeA/etEnLMJLYWykh1LRH+rnY54QOLCb/WukjF1l1Fvvw5DzKe0PpQOo+Lsv3XxDDI
X-Gm-Message-State: AOJu0YxtvwXjYr986o6plWjvyPdSsHD5NVzyVQR9U1HHbjJtN8alclfO
	GLTuAa5V0/lAgUie2qQMtjVSeMnjmqeBKPEsdxR/Gaxw1NgcchEU6uA9OZ3v3g==
X-Google-Smtp-Source: AGHT+IGFvpUkb4zb8ZV5cxUcrGzuH2I+SCgZ2wa3Oc3Y3SsPXQEkBAX3UGe71imR/kKil5/jxQnWJw==
X-Received: by 2002:a17:902:c952:b0:1de:e278:cb95 with SMTP id i18-20020a170902c95200b001dee278cb95mr15968411pla.50.1710798741455;
        Mon, 18 Mar 2024 14:52:21 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id mm14-20020a1709030a0e00b001dd2b965a8esm9823069plb.163.2024.03.18.14.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 14:52:20 -0700 (PDT)
Date: Mon, 18 Mar 2024 14:52:20 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: cmd-db: replace deprecated strncpy with memcpy
Message-ID: <202403181443.F4021C9F63@keescook>
References: <20240314-strncpy-drivers-soc-qcom-cmd-db-c-v1-1-70f5d5e70732@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314-strncpy-drivers-soc-qcom-cmd-db-c-v1-1-70f5d5e70732@google.com>

On Thu, Mar 14, 2024 at 10:29:37PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> @query is already marked as __nonstring and doesn't need to be
> NUL-terminated. Due to this, we don't need to use a string API here
> (especially a deprecated one). Let's have our stack allocation also
> zero-initialize so that we can just perform a standard memcpy. Since the
> code now speaks for itself we can drop the comment. A memcpy on a
> __nonstring buffer explains everything that this comment talks about.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
> 
> Found with: $ rg "strncpy\("
> ---
>  drivers/soc/qcom/cmd-db.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
> index a5fd68411bed..512556366a3e 100644
> --- a/drivers/soc/qcom/cmd-db.c
> +++ b/drivers/soc/qcom/cmd-db.c
> @@ -141,18 +141,13 @@ static int cmd_db_get_header(const char *id, const struct entry_header **eh,
>  	const struct rsc_hdr *rsc_hdr;
>  	const struct entry_header *ent;
>  	int ret, i, j;
> -	u8 query[sizeof(ent->id)] __nonstring;
> +	u8 query[sizeof(ent->id)] __nonstring = { 0 };
>  
>  	ret = cmd_db_ready();
>  	if (ret)
>  		return ret;
>  
> -	/*
> -	 * Pad out query string to same length as in DB. NOTE: the output
> -	 * query string is not necessarily '\0' terminated if it bumps up
> -	 * against the max size. That's OK and expected.
> -	 */
> -	strncpy(query, id, sizeof(query));
> +	memcpy(query, id, sizeof(query));

Hm, no, this isn't right. We do want to stop copying at the first NUL
character, but we don't care about truncation. e.g. imagine if "id" was
a 3 character string followed by other bytes in memory. We'd copy beyond
the end of "id" into query, and the later memcmp()s would start failing.
I think what you want here is:

	strtomem(query, id);

-Kees

>  
>  	for (i = 0; i < MAX_SLV_ID; i++) {
>  		rsc_hdr = &cmd_db_header->header[i];
> 
> ---
> base-commit: fe46a7dd189e25604716c03576d05ac8a5209743
> change-id: 20240314-strncpy-drivers-soc-qcom-cmd-db-c-284f3abaabb8
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 
> 

-- 
Kees Cook

