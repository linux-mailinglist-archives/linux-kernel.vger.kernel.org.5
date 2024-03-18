Return-Path: <linux-kernel+bounces-106717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF8287F265
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39F8A28280A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2095859166;
	Mon, 18 Mar 2024 21:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P07bGrcU"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C9C5916F
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 21:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710798176; cv=none; b=AkNOYiddhlVU5Jxjpg+RaGM7c3eUxNOIi8ytpFNT2Mpd7FATcRVTyVVPUgyCvrS1nXKWjODyfuy3RCVraHT3MzVevPmrnAgarurEMKufTqMK5Fu8mTtmAZsZfDgGtOMY0KWme3X0q4Zddh53YLtdUz9xZKxX71VuCEQfIHtDlS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710798176; c=relaxed/simple;
	bh=iVcACEXJ7ByPQf/VBR4On2mYZO1me0Bq9PH9vIqjwdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HOpcHbtxjkF51QmGP54MxVkXyx/hPusfG08XF5754WFHmaj4uWiUjAASgcEOSXuuOfUvYNSP0r9kSHat9FPjCz/uz9WEQxQiip46vFKClvInKHo/7L/d1K1PyC3hdPUAjiL3w/qt/t7pyZk5rJN9srJ1OpRyssW1EUyeUGLst6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=P07bGrcU; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-29bfc3ca816so4338237a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 14:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710798174; x=1711402974; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7ZT3rXspzzYF/8VZb3BdJDfiIw9byhNvhoKVVNwzolw=;
        b=P07bGrcUbCkl6Na9Jht1T9n59gwomnTOspdHFH4AvL0VyCoWGjuVN+oomoYbTJ9bb7
         fu7UXDwbSHJSVNwg459j90QJNN+DhZZWPys+hiNv9JCxeXHTow89eMr95249LnQ6t1m0
         QmTny9xaFOK5tYK8tagQBQpBytPOIXgZ/HNZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710798174; x=1711402974;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ZT3rXspzzYF/8VZb3BdJDfiIw9byhNvhoKVVNwzolw=;
        b=b9AXnLLpL9hasuNt37F0zxcrBAOvQwoGskK2K3U9bBj9uYVPzkSbGa+UPWILhfEkMn
         vl+OgKH1ODoxnstTPrwLummHDgN/6W9gTOJ2Rgdiyobs8bjuG23+H00Lr2QB7iZozQzp
         V5H3KtYwkKJ6V4hcY/vnFioVrZNXnrRhzSiQyQ3sRVs2hdARVVqglkigJq43ajttaoSC
         mxo1l2zdA0wFEjRMZXC/WMNiBNkZs/IZEPVG/s5gLHFRtrDtmC/n9JhzYwq6Nh+kF9Yy
         fpjy8OAJUXR5Ck5aP3xvMTP4NSkrbjyz4Jihne29qsZtw/PL5lScjX2/PpLeOttDuUEo
         nU1w==
X-Forwarded-Encrypted: i=1; AJvYcCX0cTyp/vdWP4UaXdTP6blc+8Pu4H6ORlmK1YyrcLqKejQE9K5rr47XUMlASAAXKro7JEsROOvhNJce7noJOOO1csDrI970mQppdVHS
X-Gm-Message-State: AOJu0YxtIm8GPQTA27oy3jckt0w4jTPa721YgOA9NRpOrjneJh7TYdqd
	Ehskbto78dGnX5kSbnOtVeXMzDpHZIfmRoFzyi9DdrZTvnoGOs7RUJjXR+TIWQ==
X-Google-Smtp-Source: AGHT+IGg9l6bZmeO7Ny5acljZFDqRjc8/N34eF9u08DQc0aZry14iz4qSdvaqNwuhzR5e/Zliea6fQ==
X-Received: by 2002:a17:90a:8044:b0:29c:7931:87f8 with SMTP id e4-20020a17090a804400b0029c793187f8mr10092454pjw.43.1710798174286;
        Mon, 18 Mar 2024 14:42:54 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l23-20020a17090a3f1700b0029bce05b7dfsm9004860pjc.32.2024.03.18.14.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 14:42:53 -0700 (PDT)
Date: Mon, 18 Mar 2024 14:42:53 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] scsi: target: replace deprecated strncpy with strscpy
Message-ID: <202403181442.1E78DAA4@keescook>
References: <20240318-strncpy-drivers-target-target_core_configfs-c-v1-1-dc319e85fe45@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318-strncpy-drivers-target-target_core_configfs-c-v1-1-dc319e85fe45@google.com>

On Mon, Mar 18, 2024 at 09:32:01PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect db_root and db_root_stage to be NUL-terminated based on its
> immediate use with pr_debug which expects a C-string argument (%s).
> Moreover, it seems NUL-padding is not required.
> 
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.
> 
> Additionally, we should also change snprintf() to scnprintf().
> `read_bytes` may be improperly assigned as snprintf() does NOT return
> the number of bytes written into the destination buffer, rather it
> returns the number of bytes that COULD have been written to that buffer
> if it had ample space. Conversely, scnprintf() returns the actual number
> of bytes written into the destination buffer (except the NUL-byte). This
> essentially means the ``if (!read_bytes)`` was probably never a possible
> branch.
> 
> After these changes, this code is more self-describing since it uses
> string APIs that more accurately match the desired behavior.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Good catch on "read_bytes"!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

