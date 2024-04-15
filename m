Return-Path: <linux-kernel+bounces-145546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 584758A57B6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F17F282A8F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B75A80BF0;
	Mon, 15 Apr 2024 16:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nZ+gxhY1"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3389F80BFE
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 16:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713198403; cv=none; b=Jq2ySg9fLNbf4/ejrh2iUwOlOQCfvrFZNO+PGHZPN/dEGuAxDZZRlO5wo/Hh2ZF9eM6oXuyctWR6qEbsZSoSEW5zh59niZ6wbPUatKvhkH3jxYpUPSNzbD1w7aKPsfr14iffnU3yxkbI22srxA2DF5X+625fsprQ3F7GHLjlSwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713198403; c=relaxed/simple;
	bh=TPnCz2wIas6s6nm4zl4kHicnrqDlbc3QFZUPUtZbe4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q8V4NNsOCQhfKUMQrNZU6grsHlGkJoW5F8Ru0MtgeKHZU2oCbfnZsadk8m0KjNtuQFBhgtriiR+Jgdh5uSwp1Twjw95Y1C04l5jYf7e2KlDg00YigfLb4Cw6kNsXz2uOZMfCdbtiwgY9tL+jhxebrpg0YBo7f1rJ4sT+/cOBTjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nZ+gxhY1; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5a49261093cso1890505eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 09:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713198401; x=1713803201; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QKHTfr0tvl13h4ZA+OR/lP9gzZF3Fnqy/imumDFRLcI=;
        b=nZ+gxhY1m3mhD3UrfIhn5CDg7S5qCFXvhWlgNO9Ckv8PPTkFmJCwMhQUx40+PyqJ56
         /uszDEHZoTFaJtOn2StgYoTtBaU84GPDXS1PwbKzM4weKqUPA66n2nGR+KzKmOtIEiCM
         v2O/sNCsCre+cgSsAvEnZBHZtcskEPOjTbzFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713198401; x=1713803201;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QKHTfr0tvl13h4ZA+OR/lP9gzZF3Fnqy/imumDFRLcI=;
        b=JGZki6G2y73OzvxqH2LxaDKR2Z9SY/nIvBCHyAfqClzyI3DZxIYRpTXFu5OtXEyckF
         tePu+SyJQ/2PROnYZocTtlAOLVYezQMKM1+JIuZuLl0WMS98S6pmt5y4QOz/e/c4meXE
         XwK8QOujZCjZVIUihTfyIcDY+EDCQlCoOfvi8ME1GQHgE9L3RWYzYXasQz5zwz8hDlOZ
         AEQ+t71zwqkRkzVUSASWFZ42gNjLa6irW7JBdHTe0kx6URC1PaEMwbzN94idQCHWLj/R
         RCTionui6vHNEjyIlCSUdOcl2qQhB/xrPVMeE/WoGPzLIHvf1DShQKnfraSL03QBQNs8
         ljlg==
X-Forwarded-Encrypted: i=1; AJvYcCWrTUhQENG27QwY+FyD5/G2oAk6VwC/cN45T/tftqSOR75ssoBFV6NKKPL0SAzdfpXXKEwCBEOHu+F1nMECNcb2ZZwR2YLoM/jNS49s
X-Gm-Message-State: AOJu0YwFVvWLh8hQXR0oEwmkA8N82vDADhAha6zynZ4NBQ07rHda+PCA
	2KzxgAncDlZaaUM2gSpk4NooK2XE731fG9xh/jW9mxtEJAv+p+qApabt5jubzA==
X-Google-Smtp-Source: AGHT+IG5foknaEEd3MkXk9+LN5r3/huMB4/LsTYhpQfavkLppvPRN0r2oC8b83xw/nAjf+NuBYciog==
X-Received: by 2002:a05:6358:c695:b0:183:e8d7:6f58 with SMTP id fe21-20020a056358c69500b00183e8d76f58mr7637642rwb.32.1713198401272;
        Mon, 15 Apr 2024 09:26:41 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x124-20020a636382000000b005bdbe9a597fsm7238801pgb.57.2024.04.15.09.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 09:26:40 -0700 (PDT)
Date: Mon, 15 Apr 2024 09:26:40 -0700
From: Kees Cook <keescook@chromium.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Christoph Hellwig <hch@infradead.org>, Alex Elder <elder@linaro.org>,
	corbet@lwn.net, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: coding-style: don't encourage WARN*()
Message-ID: <202404150919.042E6FF@keescook>
References: <20240414170850.148122-1-elder@linaro.org>
 <ZhzgTeEHFF19N3UZ@infradead.org>
 <2024041544-fester-undead-7949@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024041544-fester-undead-7949@gregkh>

On Mon, Apr 15, 2024 at 10:35:21AM +0200, Greg KH wrote:
> On Mon, Apr 15, 2024 at 01:07:41AM -0700, Christoph Hellwig wrote:
> > No, this advice is wronger than wrong.  If you set panic_on_warn you
> > get to keep the pieces.  
> > 
> 
> But don't add new WARN() calls please, just properly clean up and handle
> the error.  And any WARN() that userspace can trigger ends up triggering
> syzbot reports which also is a major pain, even if you don't have
> panic_on_warn enabled.

Here's what was more recently written on WARN:

https://docs.kernel.org/process/deprecated.html#bug-and-bug-on

Specifically:

- never use BUG*()
- WARN*() should only be used for "expected to be unreachable" situations

This, then, maps correctly to panic_on_warn: System owners may have set
the panic_on_warn sysctl, to make sure their systems do not continue
running in the face of "unreachable" conditions.

As in, userspace should _never_ be able to reach a WARN(). If it can,
either the logic leading to it needs to be fixed, or the WARN() needs to
be changed to a pr_warn().

-- 
Kees Cook

