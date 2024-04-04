Return-Path: <linux-kernel+bounces-132129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D521899001
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 23:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02926288C4C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD7013B587;
	Thu,  4 Apr 2024 21:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mO57yTp9"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE74313AD38
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 21:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712265634; cv=none; b=riydbu8vM5Nk5N0hQh0qJmpe3ZVYDQ+bBFWpnRZxBwM7saVi8Ur0Jy5uQXsoZmuHRmW6XrxH2raUft7Yj3oP+LsQnECpDf0hhMZUuYILubT+9H9a4KgMt5lILAZQQ/jHaypELNFlwgg+hXatWZUOQBO59X19NpcaWZRJCsfr2is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712265634; c=relaxed/simple;
	bh=+g8FGEnBfIcvGrLKu/TZA6HVZV3dI9QDg/YewVouvCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NZn0UrO73NsmE8X54NfPURKboKrNvikMAtanZhiFYTZTAgmK9RkYNdkFcfD/udKV+F38E9ZQeijxacM8Ko8urJkfN8bMjwYBlmyeV59q7IxtnCo6NeIfs58q79FcOS3uB+c/QuqGdvs7AlVjZkYD7TABgaTdCLVVOpyh7hcKqv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mO57yTp9; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6ecee5c08e6so1100498b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 14:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712265632; x=1712870432; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h5Or6NstpRZDX+9Mk41p2/RZwAVxHZ+F1Exhs3xjDok=;
        b=mO57yTp9GjmD4EsEaEuv4lVtNm7PmUYsRtQoJzj74+TmoYx76aTWWLlJ0FUf4+SlrO
         eSKTi3gHtZNbgQd/96AG05AV8ir2jGtOPJPwCQS+GdTMcXD8TSdCo2vZAPnAnp/Nt4fi
         /uE246FcBYqwWyGriQ0qEncwvfFl4nqok9U2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712265632; x=1712870432;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h5Or6NstpRZDX+9Mk41p2/RZwAVxHZ+F1Exhs3xjDok=;
        b=My3pKfaBoKSmsVci3S9wgx8xr0dPss5tu5ryknATuoL7cnu1Vd5And38XgG57qaZ7t
         FgeSQOa96jif+aAz/ntgzrcirgMx3xXUDPnGwGXZK04Lzh8aLIkBMaariVCfk2JoJrMM
         fTYwqEg932kyxe7hnjcH1+y9z5On/urj4VfAuqxuqwSQxCV98BxLz5WYnZs2eYTeiGvM
         KVm+z5IaLEYSTnVq58i9l9zD4DB3SlZMgGpV9kaFSmNe3ZU8XzlLiyCawNIzx14BGEG3
         aIeJGUx6tlSsFeY8rSJ4xgRJGY/kgyloY+gRON4mfDo9N4KGuTh50cOhFkhPeV1eCwUm
         MCEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLNvmyV0gw0gCKrd4h4iX6Q41cLfFd7RHH6NQ+50hVzde6D1EteP5ZHOrf2lv+jwlfWZTgWhMyreMGwuLbGkUUvGUvewAGgsxTXTue
X-Gm-Message-State: AOJu0Yy54DFAH6vP7mzKqJ9tndeB7dQFQitnwhzIkAdb7pCQb8TmSeUT
	czodadpbGTfJaD11CxZIXc8dLTVdQuZ9krobkzKmvxqj3jdasAcQV4G2F5U+mA==
X-Google-Smtp-Source: AGHT+IHM9ahEcWXLsBaMCLEHnLx24RdcbgqVAPA2u0PCEKRr8KtBpytL1lmSDOlyFf59XcyE6D7u2g==
X-Received: by 2002:a05:6a21:819b:b0:1a7:35b1:18af with SMTP id pd27-20020a056a21819b00b001a735b118afmr964578pzb.20.1712265632210;
        Thu, 04 Apr 2024 14:20:32 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s1-20020a170902ea0100b001e042dc5202sm79451plg.80.2024.04.04.14.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 14:20:31 -0700 (PDT)
Date: Thu, 4 Apr 2024 14:20:31 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] vmcore: replace strncpy with strscpy_pad
Message-ID: <202404041420.E3C0933@keescook>
References: <20240401-strncpy-fs-proc-vmcore-c-v2-1-dd0a73f42635@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401-strncpy-fs-proc-vmcore-c-v2-1-dd0a73f42635@google.com>

On Mon, Apr 01, 2024 at 06:39:55PM +0000, Justin Stitt wrote:
> strncpy() is in the process of being replaced as it is deprecated [1].
> We should move towards safer and less ambiguous string interfaces.
> 
> Looking at vmcoredd_header's definition:
> |	struct vmcoredd_header {
> |		__u32 n_namesz; /* Name size */
> |		__u32 n_descsz; /* Content size */
> |		__u32 n_type;   /* NT_VMCOREDD */
> |		__u8 name[8];   /* LINUX\0\0\0 */
> |		__u8 dump_name[VMCOREDD_MAX_NAME_BYTES]; /* Device dump's name */
> |	};
> ... we see that @name wants to be NUL-padded.
> 
> We're copying data->dump_name which is defined as:
> |	char dump_name[VMCOREDD_MAX_NAME_BYTES]; /* Unique name of the dump */
> ... which shares the same size as vdd_hdr->dump_name. Let's make sure we
> NUL-pad this as well.
> 
> Use strscpy_pad() which NUL-terminates and NUL-pads its destination
> buffers. Specifically, use the new 2-argument version of strscpy_pad
> introduced in Commit e6584c3964f2f ("string: Allow 2-argument
> strscpy()").
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Looks good; thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

