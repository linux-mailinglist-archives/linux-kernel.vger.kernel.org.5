Return-Path: <linux-kernel+bounces-95988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 199738755AD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACD041F22A19
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5866A13173E;
	Thu,  7 Mar 2024 17:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lvsqJQXD"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E4D1BDDB
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 17:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709834358; cv=none; b=lwnxqHRbwdBWUGGJfCAbEjertfOoMgImWm7TeSIH2KjMI8WAy9B6iOCMwzteJTpSXY344JdS2w0OUR9hTRUkYjF6pN6mIV4UgJoMJTd0wMGpx16y7DeCRu6xWFoDaljQdxW52zc+rgwbVohcJwdNBQjAZul3jJqs07ptGV0sWG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709834358; c=relaxed/simple;
	bh=O2hdfjlzZlZ0CPCqJt23wbPJbF7Ae0mInAc+itOKRtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H7wYnShx2XVUaBfD8Cu0G852I82xdFN325F30Kg7Fz9qty7qZ9Da3ZQ8aektr8Q6KQWVlbPrD1epiH95txrWqKPPaKbqRk85BUCzzto5C1jF53kTjmi/RNKFftPHUPNCuSqpPuimaR9hfP0sVdjG4eLen5f7DAOGgKV3TErZatQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lvsqJQXD; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6d9f94b9186so1187270b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 09:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709834356; x=1710439156; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VEqlp2HgRH1JvED8C1eQ8Jd7JtBfD5vT+Rfxt4u7aG4=;
        b=lvsqJQXDodKjSvzCkHGyvGIv590mgf5/x5L8bNeJIkKlUuhyrGYEXKSyBKohU4K58c
         8FK2Z//BCr7b8m1Egf1qWTEoL146hwp8ibyRWEvnAgg13VrTXobJJa13emiBnrAi1sgP
         Hj8OxNmc8Be94QSabBeN6nbcM8WDbqE2K10Uk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709834356; x=1710439156;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VEqlp2HgRH1JvED8C1eQ8Jd7JtBfD5vT+Rfxt4u7aG4=;
        b=Hb6LMCIbyD+oRNVwKZ4OUu1WsJjDHE1ZR37RiLW227e24Hh9jmxPcqK22bnpNBLg9C
         NrqpOGK0hYnVtBCHXbmoJjAMi6jMQrj0OSjAWMqaf88VQj1dZyFq/LupFNfjwUpdi3HE
         GLhxFx5cQR1Z3ODxALtPiwHApslxBtLCJDDUlVF7tOba58p56ajLLvHmCjX+Xfo+cDvk
         U2wV+ChVQYzYfptMvm1MbsEe8bwPzHCRK3ocqF3Plc9oiWZk2m9bgQmRgWFXI+qVVUwf
         JdtyB+Pw8FI6LMzbAF3c4fVTnnwxfkpguOyKTnRBX0B4pdlN43CqQLgeWFXZH27ldpkV
         B8jg==
X-Forwarded-Encrypted: i=1; AJvYcCXI6KM9YKQGEFB7GSxmRMJTsjgM9IkJLErkOdp+ga+kw7E5g1nTW8gmR5Sw5OdRnACK0nuMiHhZZp2s7godDADUWwRg7xQMf3kVRy40
X-Gm-Message-State: AOJu0Yyd5ArtLax5vxBNngjZXdByRTuTZbGzVuR76tL8Vge2Av3cxR1o
	sMVUTljACNVVEu/bvqy+ajxnLrnDhbIViIThqX8WWEUfvXiv4zjs7w0q5ZQ/pQ==
X-Google-Smtp-Source: AGHT+IEOvEuUqre/6sdNhgEG9LkJsdT6YuHjsXW6DtfCKNmHlmt7CPFD+bSq/JO0jH9mi0j5BLd1wQ==
X-Received: by 2002:a05:6a20:da87:b0:1a1:4cd2:441f with SMTP id iy7-20020a056a20da8700b001a14cd2441fmr9864304pzb.6.1709834355997;
        Thu, 07 Mar 2024 09:59:15 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q4-20020a63e944000000b005dc1edf7371sm13198387pgj.9.2024.03.07.09.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 09:59:15 -0800 (PST)
Date: Thu, 7 Mar 2024 09:59:14 -0800
From: Kees Cook <keescook@chromium.org>
To: Breno Leitao <leitao@debian.org>
Cc: linux-wireless@vger.kernel.org, johannes.berg@intel.com,
	gregory.greenman@intel.com,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Kalle Valo <kvalo@kernel.org>, kuba@kernel.org,
	Alon Giladi <alon.giladi@intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
	Avraham Stern <avraham.stern@intel.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] wifi: iwlwifi: pcie: allocate dummy net_device
 dynamically
Message-ID: <202403070958.BE50CCDC@keescook>
References: <20240307174843.1719130-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307174843.1719130-1-leitao@debian.org>

On Thu, Mar 07, 2024 at 09:48:31AM -0800, Breno Leitao wrote:
> struct net_device shouldn't be embedded into any structure, instead,
> the owner should use the priv space to embed their state into net_device.
> 
> Embedding net_device into structures prohibits the usage of flexible
> arrays in the net_device structure. For more details, see the discussion
> at [1].
> 
> Un-embed the net_device from struct iwl_trans_pcie by converting it
> into a pointer. Then use the leverage alloc_netdev() to allocate the
> net_device object at iwl_trans_pcie_alloc.
> 
> The private data of net_device becomes a pointer for the struct
> iwl_trans_pcie, so, it is easy to get back to the iwl_trans_pcie parent
> given the net_device object.
> 
> [1] https://lore.kernel.org/all/20240229225910.79e224cf@kernel.org/
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Ah, nice! Thanks for doing this.

I had to double-check the pointer-to-pointer stuff, but it makes sense
to me now. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

