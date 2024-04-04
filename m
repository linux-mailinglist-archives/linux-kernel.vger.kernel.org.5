Return-Path: <linux-kernel+bounces-132114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 643CB898FCD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FAFE1C2297F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD5813AA4D;
	Thu,  4 Apr 2024 20:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oGHezI49"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3CC763FD
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 20:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712263916; cv=none; b=Y3XBBdRQtUH4Stzr4D7zMyknvmCrT7/FYS3/0rQG3FpTdM315vz5Kc8JuR01LrWqa8VkJu8CqF8xaWqwJu4Twy3KlPxmWiaNIZU5bdh/+1sqnb2/zedmNaX3up0cMbaD8cXqaaM52spwCEmb2wSr24DEV2aZolbFsCXpubKkD18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712263916; c=relaxed/simple;
	bh=YtI2ruwAXEeLsDZf6Ahi6HUoQo1ypf/gr7HozATqWiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZoo9oWPT6Sg7VrBkpEwotqJnvg60Gyfs+CkbmwToSne56l89hj17r7DYkJkUkfJcgAHQLf+CNcMdgh09c20mlz6HFPWRaNWeBVU0lsdiNixZGKJNDRiFEjPY/eWaAXYevN4+O0gjF7Bzs9UbxpGOnAJE91tMfsNeW93y8CjT40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oGHezI49; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e0bfc42783so12857145ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 13:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712263914; x=1712868714; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IievYpX8CFKdhYar1uMDyClwmKohq+pMo1GKIaqn2LQ=;
        b=oGHezI49WRUhBDtRHKaAsDPCnt3H9YXIMbnvZXYqAsfK+Yiu6Ipr8fp2dddbroiGGK
         TfDcD+b8Q7W53neW7Jn2IrRDjxoDehL45KKhPP8SAOc4VbJjCOONWI/zK+bl+kh6woWs
         yGI5xoL/LBSDsIQ3rmQvT0YGWprepMd1qCKyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712263914; x=1712868714;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IievYpX8CFKdhYar1uMDyClwmKohq+pMo1GKIaqn2LQ=;
        b=bUe93tS2Lh7lbZT2tr3XLHX8C8RbuDy8uAoI0gstdlmtLzjINMpS/CFYQJ6DCmlCmG
         Zw7RXF1vkAGVCGDOyNd2KAD07qZHjw5rG26zwfo+xpqej4EZ+TPHs3+d2Me8N6ESsUCY
         GWIODc2a6u/9fpJX2QtawT3iIii1Mxumd8EAQZf2rb2valpv+Vqu5NOeU9xivCN2/+oC
         09Oxl/kP7hdUKqYhtwQDWomMwbAnVCDHKTGlRvKzrECxxfPHd5BvtO4Rji/jfEh4eBqx
         MgiVW5Oesi6twyBs+iZrFFMJAzfu2v/B+QzYWbTtcfXWRK/DQWCgiObdS7G83hk9vSV7
         eTSg==
X-Gm-Message-State: AOJu0YytkivJYF0u3aJKmmFYH8XeJepKEfj5QfdA8XwEu0H8puZmX/kE
	HV/goVJlEj78zsUjhXSKm0keaylnn/kOv27buD0J4NrrWYew7kmTEqhKCv7WHQ==
X-Google-Smtp-Source: AGHT+IEFTkHCy3DwvnHohRthWuZHzZAjk3sv9WbtmQ4rqctgK/TihGSptNJc+b+Ef40jwR/ei0rmXQ==
X-Received: by 2002:a17:902:ea12:b0:1e0:b62c:3ae2 with SMTP id s18-20020a170902ea1200b001e0b62c3ae2mr4219776plg.10.1712263914303;
        Thu, 04 Apr 2024 13:51:54 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t5-20020a170902e84500b001e0a2cf62bfsm46256plg.201.2024.04.04.13.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 13:51:53 -0700 (PDT)
Date: Thu, 4 Apr 2024 13:51:53 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] init: replace deprecated strncpy with strscpy_pad
Message-ID: <202404041351.3631CD6E19@keescook>
References: <20240402-strncpy-init-do_mounts-c-v1-1-e16d7bc20974@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402-strncpy-init-do_mounts-c-v1-1-e16d7bc20974@google.com>

On Tue, Apr 02, 2024 at 08:39:49PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> data_page wants to be NUL-terminated and NUL-padded, use strscpy_pad to
> provide both of these. data_page no longer awkwardly relies on
> init_mount to perform its NUL-termination, although that sanity check is
> left unchanged.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

This looks good. Thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

