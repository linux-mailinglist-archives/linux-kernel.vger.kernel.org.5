Return-Path: <linux-kernel+bounces-53924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B7D84A812
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CD0628F98B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BFF135A72;
	Mon,  5 Feb 2024 20:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VRGTl9qW"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCFF135A6A
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 20:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707165487; cv=none; b=JZW14nwqRrFbjN0Xh8ZPOWaSIXpUS+VBU8PmFQ4cmjN1Q6ahZfO9qqhKtfZvVsRIwQIxhAkk8FqdQKeRF/S4BBh9hO5LMZi9Hko2EVT3eYWaztF1dE1gVc1DtCB3Ez34drqQc5+Id8G5Rudjy1xsqYQT8KLCvQJInTOECv2r+Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707165487; c=relaxed/simple;
	bh=FkaCPPY+yFxG1dBqRLvK4B5HaNh0fUzHJekCjedzjhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iPHfKHTs+OJOe+LMcv2KJp0xEmudP7Uj5ydUF1NXs8WDKwhJcerdgkOWh810nrk+dsi6+c/RqVwghRq4eQfbLXrANdSY6q7xu4jKsUUTgH25V7O3USF3fMk8T4fJt6xGgsjVoZkBLb3LX3rTNpYAVeXPIveR4JaPrRhmjXotL0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VRGTl9qW; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40fdf17fa89so3465875e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 12:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707165484; x=1707770284; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LCIET90ETC7SgPWApGZWClXqn8NAi7LR1Ka+mUuA/6g=;
        b=VRGTl9qWyqqXaOHXMnWLvCnv5ZeJrMH0yJJ4MPcr9LoZoxqq81v0zvpv1J1LxcdmPz
         yjJeQFL2tsBbUfpx5XWj/XYaAsK64Jp3wGN8DUy1edWju9ZVrmkEmI3LiVwhVoU4DS5T
         RTw7BGI5APbxcOwP4eL322gAgjJM1KNKW5Nh5WmNHJGoM5TrIgw3sXd9hujG+/bqTtfg
         kIZY36P7bxk+P3PNSYb8EDOIorWwaYeuZHUqUQcLJJ51X1qcRtMwkbN/ljVCoWfy2Q28
         a+NRYW7uW9pJ4wk27r3w+fCSrf1NTZ4QBjW462NiMlyWJNxTIT0eAZYLmfp4WGp4ZLrU
         lO4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707165484; x=1707770284;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LCIET90ETC7SgPWApGZWClXqn8NAi7LR1Ka+mUuA/6g=;
        b=GMH9TdeCxII+RwTSW6v1WGVBwAiiVBS40mKLQ9ZYzY/LPvhJlBL0m/tnJJg8GZQoPg
         MsL2Z/dx4jSy0jnedY5L5KCH+t9D0NrbvHUTr9TtsG8aTOhp3TC3AKXZpEvviw9iigx8
         GuFJyOR+mHmQdrqDw3/d5lFA1Egzv9q4jLvxIjOa4AuteqEBitJV3a1xXAhcMbnvadTe
         IrU8eO4WMFlSgQB/8lUWZtxxaeBLF+5dknaEW0CqfBBbxF38JfHcNU/OhJ1bNNFdPkFy
         K5u6HPFhmAd9Eq06ZySRIFlVIvTK24YCvgMG4ztvouGay5hM8qadj7UnYUohdaQMVuei
         syVw==
X-Gm-Message-State: AOJu0YyFy4i47y9UROHYI45hwUC8yTjvdWB/6Sjg9Jlx0HKar8is9orb
	qTY2crQV435hYJM0gDxO2kEYZTjoG7P0+P9QHqRQI0paF/PdUp/hg7xk8PkmMw==
X-Google-Smtp-Source: AGHT+IFXgAFv0t6Z5BJcW0zDTPKXQm9HGkpvxeQ9RnxL+RNpdvDhKG13rqujDxVjoItwx8eBE6TQfA==
X-Received: by 2002:a05:600c:3b19:b0:40e:45c0:ad64 with SMTP id m25-20020a05600c3b1900b0040e45c0ad64mr617796wms.14.1707165483954;
        Mon, 05 Feb 2024 12:38:03 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXuK7G1136CvcXV0SqbJwlIu89EagR7Yxa7m5sGBZRqm3853j8fWkDafNa9dduwIyQ/2TQjcpb2SOAzeC3nUSWSrSR+Ljq1yPXn0rAEPrIW14hG3SDv6aVjLidt81gBpfuNnu9pzrQyoKejUk1itDCj57iKlj3KEkdPUILZp1cqg5xRJ52/EUKQdill52JxFOS25AUydi2vQLv9FrqmvA==
Received: from google.com (185.83.140.34.bc.googleusercontent.com. [34.140.83.185])
        by smtp.gmail.com with ESMTPSA id h16-20020a05600c315000b0040fde4451e2sm2192988wmo.0.2024.02.05.12.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 12:38:03 -0800 (PST)
Date: Mon, 5 Feb 2024 20:37:59 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v14 4/6] tracing: Allow user-space mapping of the
 ring-buffer
Message-ID: <ZcFHJ75PzEUvIyaf@google.com>
References: <20240205163410.2296552-1-vdonnefort@google.com>
 <20240205163410.2296552-5-vdonnefort@google.com>
 <3c16bee0-70b7-420f-a085-c9e09e293fe2@efficios.com>
 <ZcEqLmyi3fEMOSIl@google.com>
 <d1aa52b9-d2a5-4315-b39d-d2784cece3f4@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1aa52b9-d2a5-4315-b39d-d2784cece3f4@efficios.com>

On Mon, Feb 05, 2024 at 01:44:47PM -0500, Mathieu Desnoyers wrote:
> On 2024-02-05 13:34, Vincent Donnefort wrote:
> > On Mon, Feb 05, 2024 at 11:55:08AM -0500, Mathieu Desnoyers wrote:
> [...]
> 
> > > 
> > > How are the kernel linear mapping and the userspace mapping made coherent
> > > on architectures with virtually aliasing data caches ?
> > > 
> > > Ref. https://lore.kernel.org/lkml/20240202210019.88022-1-mathieu.desnoyers@efficios.com/T/#t
> > 
> > Hi Mathieu,
> > 
> > Thanks for the pointer.
> > 
> > We are in the exact same problem as DAX. We do modify the data through the
> > kernel linear mapping while user-space can read it through its own. I should
> > probably return an error when used with any of the arch ARM || SPARC || MIPS,
> > until cpu_dcache_is_aliasing() introduces a fine-grain differentiation.
> 
> You might want to use LTTng's ring buffer approach instead. See
> 
> https://github.com/lttng/lttng-modules/blob/master/src/lib/ringbuffer/ring_buffer_frontend.c#L1202
> 
> lib_ring_buffer_flush_read_subbuf_dcache()

Thanks!

> 
> Basically, whenever user-space grabs a sub-buffer for reading (through
> lttng-modules's LTTNG_KERNEL_ABI_RING_BUFFER_GET_SUBBUF ioctl), lttng
> calls flush_dcache_page() on all pages of this subbuffer (I should
> really change this for a call to flush_dcache_folio() which would be
> more efficient).
> 
> Note that doing this is not very efficient on architectures which have
> coherent data caches and incoherent dcache vs icache: in that case,
> we issue the flush_dcache_page uselessly. I plan on using the new
> cpu_dcache_is_aliasing() check once/if it makes it way upstream to
> remove those useless flushes on architectures which define
> ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE, but do not virtually alias the
> data cache.

I believe the aim is to use the mapping by default in libtracefs and fallback to
splice whenever not available...  But for those arch, I guess that might be a
mistake. Wonder if then it isn't just better to return ENOTSUPP?

> 
> The equivalent of LTTng's "get subbuf" operation would be
> the new TRACE_MMAP_IOCTL_GET_READER ioctl in ftrace AFAIU.

That is correct!

> 
> Thanks,
> 
> Mathieu
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
> 

