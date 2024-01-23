Return-Path: <linux-kernel+bounces-36162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 840A5839C93
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 23:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6D531C22F51
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 22:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F6B54663;
	Tue, 23 Jan 2024 22:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C0NzgG/D"
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D5D2C1B3
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 22:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706050355; cv=none; b=f1COlWA8X8L7BkUPbuINQ8Q6XINeATRXpqvGyOPnSizWohknGV77SVB+UAdjnTKekNHkxI0fJ7qy3fwaL08wWNSjoFE1Z7WU8mYU2yIteSNUpiSSji3gxX9fpDGnUr/ZwYl0Du28DWVUgakN4iRDIsMzN0p+SyRUL5TTtIdtLDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706050355; c=relaxed/simple;
	bh=cM1u6TyGETJjhtJrO6J7JSwAWml7G37TEKeViMrmnfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=quOnSYLsFnGFPrVJC6Ej9/moOC8uqHpRB2at/VG4kObRlS7Y/nz0ZHRUJ6pUZrm6zjVymSml/BpLQ0ebWm9Ji3gAf4+vpdhUczTUoNMJkQX+FfWsEqJuDpW6MoAu10bi4QA33RrrgNl2PK5nJ19ErhB3UW9/8hGWQwz8RaFcXIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=C0NzgG/D; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-59612e4a21eso1888528eaf.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 14:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706050353; x=1706655153; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+8OzyRNimHg6MWBPPPferJ7a6OpiMFAs+H+g4XMLgls=;
        b=C0NzgG/Dtgm+JZP1sZbWdF2MiEiKlGVX+chQ+apBliQQPqDWONqY4GsZUHsOZ/l4Tn
         VefDp4FH0thNeBBWbqtlKuOcCaOLGBwYxYIk+IpCz8DDHVTD3a2GUMX7ciLC3Uo+Wj7K
         h3otUX+cogjgJNcr3/aviv5gOGCdMxmi2JtKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706050353; x=1706655153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+8OzyRNimHg6MWBPPPferJ7a6OpiMFAs+H+g4XMLgls=;
        b=CnMBPUdVtwy/BaauXAXiGqMAif4/7kaBQdjiRAJv/lOOJPdbTbrP+2QzSi3YoBeWRz
         4u2EJ8NbbFgwgYXguHS+9PU1J0LQf1LaGVK+7VTMUlu1HZpAmXSgKX/jbUOXF9LsCMFD
         aBfo1LxnF3yGCjuU14/JlE32nRcyTXZOaIRM7sQhalkdx/LogKblwZAxR1Qj/hUlo+du
         1Z2sgorlamkoiN6EYOHA5V1/Sut/hZnSePrd3waD7xocrAg6RcfoyghMGGmboWn+fjtH
         zGadcAzsyADoqNRHTU0MTxRoiLB/e4OEmPI3AaWm28eqkbqLItkpfG2ulgTL1FYf71TX
         TZuQ==
X-Gm-Message-State: AOJu0YzmyqLSieu8m1nsEybhnqNh+A2aytN+n5B1X0ZIN/nb2tA3j/Et
	EATMy+kiZiigpd8XknxFyFE0+DhWcVrfhKMr+8l/N1Ko8TgXKkr8DgYWr5tYftIhF3dqJ8otX7L
	r2Q==
X-Google-Smtp-Source: AGHT+IHDl/6I1rG7FFOH5TLpxkcvik0AXWrRwPOVODwTcq5RC8mUYxoyhnLKMEDwXanwWecFPslILA==
X-Received: by 2002:a05:6358:7e49:b0:176:3715:3c32 with SMTP id p9-20020a0563587e4900b0017637153c32mr3147609rwm.3.1706050353056;
        Tue, 23 Jan 2024 14:52:33 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e33-20020a631e21000000b005d0796e779bsm2079685pge.12.2024.01.23.14.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 14:52:32 -0800 (PST)
Date: Tue, 23 Jan 2024 14:52:31 -0800
From: Kees Cook <keescook@chromium.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-hardening@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Max Chen <mxchen@codeaurora.org>, Yang Shen <shenyang39@huawei.com>,
	linux-wireless@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 41/82] wil6210: Refactor intentional wrap-around test
Message-ID: <202401231452.2A37D157C@keescook>
References: <20240123002814.1396804-41-keescook@chromium.org>
 <170601063238.3962299.12030024839048269322.kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170601063238.3962299.12030024839048269322.kvalo@kernel.org>

On Tue, Jan 23, 2024 at 11:50:34AM +0000, Kalle Valo wrote:
> Kees Cook <keescook@chromium.org> wrote:
> 
> > In an effort to separate intentional arithmetic wrap-around from
> > unexpected wrap-around, we need to refactor places that depend on this
> > kind of math. One of the most common code patterns of this is:
> > 
> > 	VAR + value < VAR
> > 
> > Notably, this is considered "undefined behavior" for signed and pointer
> > types, which the kernel works around by using the -fno-strict-overflow
> > option in the build[1] (which used to just be -fwrapv). Regardless, we
> > want to get the kernel source to the position where we can meaningfully
> > instrument arithmetic wrap-around conditions and catch them when they
> > are unexpected, regardless of whether they are signed[2], unsigned[3],
> > or pointer[4] types.
> > 
> > Refactor open-coded wrap-around addition test to use add_would_overflow().
> > This paves the way to enabling the wrap-around sanitizers in the future.
> > 
> > Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
> > Link: https://github.com/KSPP/linux/issues/26 [2]
> > Link: https://github.com/KSPP/linux/issues/27 [3]
> > Link: https://github.com/KSPP/linux/issues/344 [4]
> > Cc: Kalle Valo <kvalo@kernel.org>
> > Cc: Johannes Berg <johannes.berg@intel.com>
> > Cc: Max Chen <mxchen@codeaurora.org>
> > Cc: Yang Shen <shenyang39@huawei.com>
> > Cc: linux-wireless@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > Acked-by: Kalle Valo <kvalo@kernel.org>
> 
> If you can edit before commit please add "wifi:" prefix to the wireless patches:
> 
> ERROR: 'wifi:' prefix missing: '[PATCH 41/82] wil6210: Refactor intentional wrap-around test'
> ERROR: 'wifi:' prefix missing: '[PATCH 62/82] mwifiex: pcie: Refactor intentional wrap-around test'

Ah yes, thank you! I will adjust them.

-Kees

> 
> 2 patches set to Not Applicable.
> 
> 13526631 [41/82] wil6210: Refactor intentional wrap-around test
> 13526632 [62/82] mwifiex: pcie: Refactor intentional wrap-around test
> 
> -- 
> https://patchwork.kernel.org/project/linux-wireless/patch/20240123002814.1396804-41-keescook@chromium.org/
> 
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
> 

-- 
Kees Cook

