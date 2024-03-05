Return-Path: <linux-kernel+bounces-93120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 406A1872B4A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 00:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F028728C0F7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 23:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C8512DDBF;
	Tue,  5 Mar 2024 23:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hWQNwmko"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4506212D747
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 23:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709682735; cv=none; b=YPpSKyhmtZkaVnu0LYeqJD48rg2RssICzG9B+7PvAEtMoHgtQnxEv3uQE3jOLNoYCIodXbFhpMnkPrSx8Q3eTigSX0SIPqAMKbQ/AKteA1lH3fsz2q8ysyiSlL3rlR32QzNDmXejrxt+IY3Z/s+G01IUd+UXFjc+2NIfpAbW82E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709682735; c=relaxed/simple;
	bh=jad1ZTuPBnQnVhyAUaIXJ0sj2KmNN+XpvGPh1Z8NAiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nIE9RL6FEKg9xmEUInQgd0XBzrZnIzuwS5c9QVRVwoGB+wmA/7Wls8+TSMP9dxDI82w57eOYDv6gqZYwhyzBkYvNiLzPkkchisXLLmRD0o/nV7ppbLbSvnI+uGmb5vaIYsyjj9cI8IqEBXuWSxCG8G9/+KykfWJ9DJcitTTNUZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hWQNwmko; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1dc0e5b223eso53923665ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 15:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709682733; x=1710287533; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jyoc6sqBdOY+7wLmmpdaiPXTvskeQaEAskb3Q12WvtU=;
        b=hWQNwmkoP6X9trL+mOxnNbMVV5ZgU4F4xTCcdQhzKJqixqNrhe/FaY7XPOdBZH3Wfl
         sZ6wD2ubgEZpJnJNcab0ofM/vJ4mW3tPl+Eojwwm/m7YFpU6nE63s6Yi2AQqYGPU7tk0
         KIfQUPpcg0mZ8Bd8PXd+LPnMZvYWnhgE6gu7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709682733; x=1710287533;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jyoc6sqBdOY+7wLmmpdaiPXTvskeQaEAskb3Q12WvtU=;
        b=DLVg7hyshbH7VMkirInxPtcZCSXF8zZjf49BnaafKAnlMeyYXFIQm0xMJOM6Rypg2y
         W65fAPJ9VtNJUFxqC4ehhJeTPutVkUp3jxReAv5n9GftlHOcbHB8Gkyz5DW18okJCcwR
         06hQ7xwx+qmD3kPC1xQc67mDXfXFo4oH2BhkBHWCoA4iDYkPI7bNlXe1W9RfK/pNS/rg
         WVQ0jb8sTRdPkFXsptGFlzAb9XX0kUny/q3ADvCJdRE28qEU5Q3XnvhwNuOUm/aC4Uip
         JzAEJeaMtLQCW/iKIMBk7HV6bwDofzL8FeDT7s515Nr8MAHd96ZbJrum9sZWQH/6CF6B
         2egQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcKf7vN0VNSCzludhcETT70ljpIlmphK/SlKbo85RAZrcBw2BevyjaeCU0Y4Adzh8gnoDUZtgsYAcxYO6DdD4QhWYo+sh0jbGqS9hM
X-Gm-Message-State: AOJu0Yz+br8ViaDxCDQSoiHcMK0TWwohUR5gwDNiyIGyPe+Owitkt6a0
	LX8PYnehPxNOUuuc+KNlpUk+F/j5LUCb5zMN14fG8uwEc9B8g/Uq6z0XGvYnrA==
X-Google-Smtp-Source: AGHT+IHSAi/R0Z+FnSnYEll+Jdzr9evRXwkkfto2W7u2LIJBRhmtHvsvuWPYgTohLmHE92SmGPwJxg==
X-Received: by 2002:a17:902:a514:b0:1d9:7095:7e3c with SMTP id s20-20020a170902a51400b001d970957e3cmr3152769plq.57.1709682733364;
        Tue, 05 Mar 2024 15:52:13 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id k23-20020a170902ba9700b001da105d6a83sm11089065pls.224.2024.03.05.15.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 15:52:12 -0800 (PST)
Date: Tue, 5 Mar 2024 15:52:12 -0800
From: Kees Cook <keescook@chromium.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] fsnotify: Avoid -Wflex-array-member-not-at-end
 warning
Message-ID: <202403051548.045B16BF@keescook>
References: <ZeeaRuTpuxInH6ZB@neat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeeaRuTpuxInH6ZB@neat>

On Tue, Mar 05, 2024 at 04:18:46PM -0600, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
> ready to enable it globally.
> 
> There is currently a local structure `f` that is using a flexible
> `struct file_handle` as header for an on-stack place-holder for the
> flexible-array member `unsigned char f_handle[];`.
> 
> struct {
> 	struct file_handle handle;
> 	u8 pad[MAX_HANDLE_SZ];
> } f;

This code pattern is "put a flex array struct on the stack", but we have
a macro for this now:

DEFINE_FLEX(struct file_handle, handle, f_handle, MAX_HANDLE_SZ);

And you can even include the initializer:

_DEFINE_FLEX(struct file_handle, handle, f_handle, MAX_HANDLE_SZ,
	     = { .handle_bytes = MAX_HANDLE_SZ });

I think this would be a simpler conversion.

Also, this could use a __counted_by tag...

I need to improve the DEFINE_FLEX macro a bit, though, to take advantage
of __counted_by.

-- 
Kees Cook

