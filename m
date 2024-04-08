Return-Path: <linux-kernel+bounces-136012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3090A89CEE4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 01:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF8F6284CA3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 23:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9917146000;
	Mon,  8 Apr 2024 23:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V1fUp2g+"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D56E3D0BD
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 23:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712618436; cv=none; b=RULiv2kJ5KKihAxIDGNjNsMI9BFzCpwPFKXJrNQ8Q97nGtIdTFTAJp988/kbqOr2VJPPjBn/wlDdydWXHQerCJTektdT3QMgsg3JjEc/F24LcDI4+tq6JTBj/vnLKJvt47we2jyGisKATmgWybaDHhU7lLllnAda+/GFrRW37jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712618436; c=relaxed/simple;
	bh=R0vbJw/BDBrD1C3Wb0cjCIKzALfO3U+u/MPT5lmUcrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jYqUzY5zQ3MsgYcARY9eS6/8I6ktwEqK7eeOQU4otkoNdCHiWgiXalY0OiZKh10meSgtdhbYWe4ZeLw+JBcqXCUQ9+/zHNgRCTNKBruD4C2GO9jkw1PNQyjKKZvQFYFl1dBzKNtxVkxmhQ6/hJQPtGdzGRxaVCxz8gb+ABxGPVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=V1fUp2g+; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2a54fb929c8so639882a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 16:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712618434; x=1713223234; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iGfzW3KSWciZlgCPg70ValvXebgWwF9Br7yRSrVmJ8Y=;
        b=V1fUp2g+b7qKJEiXATTj3FznZF+WdNt+AtO6VyvLMvHxOmtkuDnmjOo2U4LR9nLjiv
         RjSSNGCQsNt1CbjKNwSoXpfQwjwLgdVvHBc60lnilbtasvP02TIckI6oCjoegQQoMS54
         FjBu2yDrfJftb0uz/aoOZw2vfkzy4SAoi3ybo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712618434; x=1713223234;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iGfzW3KSWciZlgCPg70ValvXebgWwF9Br7yRSrVmJ8Y=;
        b=WfkUQAXy+y6GhIvoqtTT6Hy5bRlkgMBvGr8bJ4v8jxv8WuoFiNonlKC/icj5u2jJJB
         sOnxl3Y193vq7/rTOF+Zs/fpq6x7NPUc9IAFZB9CsrG1j2/+0T1fFDTYIqkQD/u1K5S5
         WFG3CIdVdpeCFxJETeCQIWo5UL5zTw4s9pyoJSsfjefJT3o0vjajolPFC4uqqTUIojGC
         iAmzu1etit9VhcfsOA5+vSBE3qo9z6twgdxjF8bw1lqVPuMOHTgMHTueN00WvZ72vucV
         HpCqdAcu/YHQhQFTyqkVn+rjGpbrNcSc2wrHUorScJ1tX+SeIlYc9osO5mB8gTOZ/JhK
         5RvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvh69dshTu+LAXeq7AZJK4IPqs02RJ/llth9pS3PFyTJLV05E0uXopC8cdv+L1Z3pPyUWZ8XovOaJLnQbSQ2aDivnc1gegJzUDd9+/
X-Gm-Message-State: AOJu0YxJlvPaj/xAwT1lcIwWsEwP38HSD8JsUgDq2IRNXDST+9fjHbT9
	SXiHAF22EnL9F81wDL9Lzx+EWLbbrflgR0YtjZf8RN/EnnpjW+tZ3afny7l79A==
X-Google-Smtp-Source: AGHT+IHagw1kJFyHr7aumQ6VVYFpyQcraFdxbmvsNxzzJN/4xkU5PmluPOJ0qvhBBB6jr79Q6fO2fg==
X-Received: by 2002:a17:90a:7286:b0:2a2:d41d:2258 with SMTP id e6-20020a17090a728600b002a2d41d2258mr8360479pjg.28.1712618433895;
        Mon, 08 Apr 2024 16:20:33 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id fz7-20020a17090b024700b0029facfb3f25sm7026022pjb.45.2024.04.08.16.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 16:20:33 -0700 (PDT)
Date: Mon, 8 Apr 2024 16:20:32 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>,
	linux-hardening@vger.kernel.org, Finn Thain <fthain@linux-m68k.org>
Subject: Re: [PATCH v4] checkpatch: add check for snprintf to scnprintf
Message-ID: <202404081620.551120F8EC@keescook>
References: <20240408-snprintf-checkpatch-v4-1-8697c96ac94b@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408-snprintf-checkpatch-v4-1-8697c96ac94b@google.com>

On Mon, Apr 08, 2024 at 08:53:33PM +0000, Justin Stitt wrote:
> I am going to quote Lee Jones who has been doing some snprintf ->
> scnprintf refactorings:
> 
> "There is a general misunderstanding amongst engineers that
> {v}snprintf() returns the length of the data *actually* encoded into the
> destination array.  However, as per the C99 standard {v}snprintf()
> really returns the length of the data that *would have been* written if
> there were enough space for it.  This misunderstanding has led to
> buffer-overruns in the past.  It's generally considered safer to use the
> {v}scnprintf() variants in their place (or even sprintf() in simple
> cases).  So let's do that."
> 
> To help prevent new instances of snprintf() from popping up, let's add a
> check to checkpatch.pl.
> 
> Suggested-by: Finn Thain <fthain@linux-m68k.org>
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

