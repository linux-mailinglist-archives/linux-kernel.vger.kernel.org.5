Return-Path: <linux-kernel+bounces-168375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E40908BB7B8
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 00:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D9E21C20DAF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 22:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13E883A10;
	Fri,  3 May 2024 22:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XPZYpFfq"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93A85BAF0
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 22:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714776389; cv=none; b=hdk3+2IGFwybHe4FSYXj0rc729ILeH7lTXEsVPHcYXlIV2TwlCGQEoYAKj6SlFpY4xdM+Uk322uHnscdh4KZet9g8ZXdhYVwo2ApPIdlhiIC5Jfs10ERRkKLXhEDlwVkqtBnSpfKgJ3ZRuxJpJKC8tpcmbzOtawuSu7tjnHNSHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714776389; c=relaxed/simple;
	bh=iOYe7kRINa7Nbtm22olG2bI2SMpe/8xXq1fjYHcE2To=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aF4NjVP8Zf0lZkRrH2i6SAdHQVqnVc/5Z9pFhyGk9fF//4scrgWs4F4pnWQgDJk46BfxRQjEhKOTM34avRw1Icm24u8fKhC23+yDYLjIDol0kPt/ztTrYD0nteChS40Ypo0/G3LrD/ZsN2SWB5E18EZ8YvfT9a+NMJMaIVV9LAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XPZYpFfq; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6f0aeee172dso104192b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 15:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714776387; x=1715381187; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mDJm+G1eQTkRtzeGacfCcUIfkVf82OdjbXxPvJWkGL8=;
        b=XPZYpFfqASbH92roVadM1Ux0CXeXl7kWbmWkFMukvW2trXx/AlLIeB55xooBdErhgo
         I6ScubhAM8iZg6HtGsLWR10szv1RWDGqto0Zmqf3txgW0w5xM3x1TwGmxaGNMFuP0MUR
         K54GXBCG1Uejp/NdlJJw9l6t+XUksMQzK9VBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714776387; x=1715381187;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mDJm+G1eQTkRtzeGacfCcUIfkVf82OdjbXxPvJWkGL8=;
        b=iHjS2bphBTcjTPBbt++zAIuAZp5QchHVcf39FmQCTOqkqFCreZ0ewMCrDP+hD9Pp5+
         Qtsq6NcbLJENsnz97Xdln0GqYgD+XCsQeAL1ZUVfp7HpvpD/mHrHYGFyszLtRhaT5hhj
         o6/VBXRXbrcz/6zlTuMMHiyDGt6LKeBoxUkZFWccp8Cbn9RyHQUQ+3OevD0QeqIshLfr
         QcROReV7h0t8guVpD4gg3Kys86XGbDN+JXR1EC/n5YzFyIwnOu3poppj+Zi/DCjiIF8E
         mHOpK2VyLQUNYf/22wmcwtagKmAR2YjdQ08M1RNBNe/QTaFZkoSLkG6IvEVUEk8DKbsO
         qWVw==
X-Forwarded-Encrypted: i=1; AJvYcCVoMYxaKsK/0FjumqttRmyjkXAhBT3CEtC4csw7rb0Nl86jgdcd3B1R1GNarbxCZ+hOCD0MaimSl24FXTD1EkQ1EeXDJrUD1cuNKgAQ
X-Gm-Message-State: AOJu0Yx/+he+nmw0EGyJShFDeMLfeP8QqLjIGPTBkU2/lFHr3Z7qZYa7
	x1p3XR/UC+y27/dqRb/p726sCT/aYAH6my4Y27rkTEvjd/fi+ufCRbr0SGBT8A==
X-Google-Smtp-Source: AGHT+IGHwRAHiUilkIaBMSgKxfWAn6dj229eadrK2bv8wlplvr3MD06FsL2cYfgcUjeFAYrze9wdSQ==
X-Received: by 2002:aa7:88d2:0:b0:6e7:48e3:7895 with SMTP id k18-20020aa788d2000000b006e748e37895mr9433402pff.2.1714776387222;
        Fri, 03 May 2024 15:46:27 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id w17-20020aa79a11000000b006f4476e078dsm2406826pfj.192.2024.05.03.15.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 15:46:26 -0700 (PDT)
Date: Fri, 3 May 2024 15:46:25 -0700
From: Kees Cook <keescook@chromium.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, axboe@kernel.dk, brauner@kernel.org,
	christian.koenig@amd.com, dri-devel@lists.freedesktop.org,
	io-uring@vger.kernel.org, jack@suse.cz, laura@labbott.name,
	linaro-mm-sig@lists.linaro.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	minhquangbui99@gmail.com, sumit.semwal@linaro.org,
	syzbot+045b454ab35fd82a35fb@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] epoll: try to be a _bit_ better about file lifetimes
Message-ID: <202405031529.2CD1BFED37@keescook>
References: <202405031110.6F47982593@keescook>
 <20240503211129.679762-2-torvalds@linux-foundation.org>
 <20240503212428.GY2118490@ZenIV>
 <CAHk-=wjpsTEkHgo1uev3xGJ2bQXYShaRf3GPEqDWNgUuKx0JFw@mail.gmail.com>
 <20240503214531.GB2118490@ZenIV>
 <CAHk-=wgC+QpveKCJpeqsaORu7htoNNKA8mp+d9mvJEXmSKjhbw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgC+QpveKCJpeqsaORu7htoNNKA8mp+d9mvJEXmSKjhbw@mail.gmail.com>

On Fri, May 03, 2024 at 02:52:38PM -0700, Linus Torvalds wrote:
> That means that the file will be released - and it means that you have
> violated all the refcounting rules for poll().

I feel like I've been looking at this too long. I think I see another
problem here, but with dmabuf even when epoll is fixed:

dma_buf_poll()
	get_file(dmabuf->file)		/* f_count + 1 */
	dma_buf_poll_add_cb()
		dma_resv_for_each_fence ...
			dma_fence_add_callback(fence, ..., dma_buf_poll_cb)

dma_buf_poll_cb()
	...
        fput(dmabuf->file);		/* f_count - 1 ... for each fence */

Isn't it possible to call dma_buf_poll_cb() (and therefore fput())
multiple times if there is more than 1 fence? Perhaps I've missed a
place where a single struct dma_resv will only ever signal 1 fence? But
looking through dma_fence_signal_timestamp_locked(), I don't see
anything about resv nor somehow looking into other fence cb_list
contents...

-- 
Kees Cook

