Return-Path: <linux-kernel+bounces-70101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45705859313
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 22:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A39822846A8
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 21:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A8C80037;
	Sat, 17 Feb 2024 21:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gbUFQu1W"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055B97F7E1
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 21:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708207122; cv=none; b=GZL2E3br+cJmDQQ0OhwL4qEm92N23YZE49mIGLvoByb5oQqtE9KWJEF38Xof2IUkP8Wq4Y110fnYayjf3sNdeEG4za1A7C47vtSRaxG2qNeJrzA1N2keqU9ZHO1iWNI8Rgivh369NOrJP2ru5d5k8HJ69OqU6iSYAlwT7nEj53E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708207122; c=relaxed/simple;
	bh=ywZlTuum4wD7jSFZh6uqgulvkk0AYR4CsjB1nx0/r5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HPrPxy/5u0n8ibBAw5jdM1UE3b9FXP7htwbrRbejTGWcIRoQNAC3m4cVtKkYplE4vMhcl5FFauHVRBokQAoErLrtmJBFdJkqD538Cbfr+9ELC/W0G8wWWdhTjFl7JJGerbE4yBMV4Wj7cREoCL0FvveoT2AvL7eWsmLG3TNqWRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gbUFQu1W; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d94b222a3aso30960565ad.2
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 13:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708207120; x=1708811920; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2udDkf3nnvuGOZcbthLGLXbiEAUsVkkHJpuyz93NVo4=;
        b=gbUFQu1WDY8HtZtoZXaVt6DQ0oKmGOplHQWSi1B6jPEvRNAvdMYofZV/iaZH69AfBM
         nID3LAlSGLnUX2F/VvggUP/N+XAKJgHOGBHPKtqe06ETn+rvNEA8hznIZADJqe9uHr0X
         RApo3QES/0QzoxTbElfbYpe1cbDtVqNoviAf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708207120; x=1708811920;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2udDkf3nnvuGOZcbthLGLXbiEAUsVkkHJpuyz93NVo4=;
        b=ufT/4xlqDfBtOj1+PPWp7knvbwIjPdJUyBOUVmlvgcGuE9T3eAt6GW6jHl1b+xeEF8
         zOJeqSwn0m5wHSW5SP2Pwypt5qsl86nSxcA8TqsoFOmLT/sxft6ugQa6i2LGqss8zqmV
         3CXWAN9Avvwm1jYd9wqkuIcTG9C/s5nj595rI5Cj+i9Tw/bJJobzj505IIIgCfVIX8Wj
         +mTlhfRbPbJWNh3TFFh91wmpdoGc3xErgeSUrL0FgHoajtG3bT87bYFHu8ctTdu/pPQm
         Fo8x1GRbvjGk+xzIwhBaQa9cN/0J9MbJCzKcglFmWKRQqtIHRSjaDoj060CZc4x19v/V
         X0Xg==
X-Forwarded-Encrypted: i=1; AJvYcCUL1Q1cUajJFsBpQj+d5ozeyxEbckRhIlva8+c6vBS139AR6OYo7IXP8yMZbfABmOaZbQKtSJnT8941SOxPbssB+O2fPaUTPmiOFGOi
X-Gm-Message-State: AOJu0YwqQWuvCjghfk0dWHeVb/KGVrmvLFiUB9fI5TeaXBn3OSr+EWWe
	bdVXIaejDDTGzy0BAe37g3Lvu37pgwb6x8bQU3WFeg1jGxtJIl1LpUYZ0xnvwA==
X-Google-Smtp-Source: AGHT+IHOMhJGSekMFv4rEX09CV/DMe6NhlrWe0tPcvwNf9MdbYiiO6SbhgkLkSoAEiSdMjj1pRgGYg==
X-Received: by 2002:a17:903:98f:b0:1db:b495:1391 with SMTP id mb15-20020a170903098f00b001dbb4951391mr5503536plb.36.1708207120363;
        Sat, 17 Feb 2024 13:58:40 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id mi11-20020a170902fccb00b001db608107ecsm1865857plb.167.2024.02.17.13.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 13:58:39 -0800 (PST)
Date: Sat, 17 Feb 2024 13:58:39 -0800
From: Kees Cook <keescook@chromium.org>
To: Alex Elder <elder@ieee.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Gustavo A . R . Silva" <gustavo@embeddedor.com>,
	greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] greybus: Avoid fake flexible array for response data
Message-ID: <202402171357.E671B5589@keescook>
References: <20240216232824.work.862-kees@kernel.org>
 <672fafca-547e-443e-8dd8-80ccd2320767@ieee.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <672fafca-547e-443e-8dd8-80ccd2320767@ieee.org>

On Sat, Feb 17, 2024 at 02:17:33PM -0600, Alex Elder wrote:
> On 2/16/24 5:28 PM, Kees Cook wrote:
> > FORTIFY_SOURCE has been ignoring 0-sized destinations while the kernel
> > code base has been converted to flexible arrays. In order to enforce
> > the 0-sized destinations (e.g. with __counted_by), the remaining 0-sized
> > destinations need to be handled. Instead of converting an empty struct
> > into using a flexible array, just directly use a pointer without any
> > additional indirection. Remove struct gb_bootrom_get_firmware_response
> > and struct gb_fw_download_fetch_firmware_response.
> 
> The only down side I see is that it sort of disrupts a pattern
> used on Greybus request handlers (and the response structure definitions).
> 
> I think a one-line comment in place of each of these two
> definitions would be helpful, something like:
> /* gb_fw_download_fetch_firmware_response contains no data */

Er, maybe this should be "no other data" ? Do you want a v2 of this
patch?

> And then add a similar comment above the calls to
> gb_operation_response_alloc().
> 
> Otherwise this looks good.
> 
> Reviewed-by: Alex Elder <elder@linaro.org>

Thanks!

-- 
Kees Cook

