Return-Path: <linux-kernel+bounces-163006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3468B6350
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 22:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32D331C21833
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 20:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504931411EB;
	Mon, 29 Apr 2024 20:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OhPo1yH+"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5F614039D
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 20:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714421604; cv=none; b=qtwkl312pK4rX+kPB76tSO/+zlE04wB5U4i1+Ofd08nsfbjafBwISxve381ePs07A9sSQ9pAfVKmXDNhVYTiGzrdP8meBK/iXtkwEkSABUlg3Xrw94jsH3XdxtoRJ7pGXGEvu1R6/EDdfuyhubUWQsOpRGVf+NCBLmAbROy3XOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714421604; c=relaxed/simple;
	bh=Wpz9boe/w8KT9hr5B4n4S8JECxM9pa+bGQT6Fr8iw4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aguFmXNuY/tumTRSD3kt9TJgGJAW8nQO3ofi0xiAZnU++usbiAtTfu1ARlYnk1y+zG2kDfKLsi1AY9ZuzE1Q0E8myEdSnhBSsj/5KbaCtDVso0+Btidv8Cyl001dtDeLsk+BqSWVLMyikDFm0Q9NioOXrUQi8yL/mWWm5qh+8OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OhPo1yH+; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6ecf05fd12fso4410003b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 13:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714421603; x=1715026403; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BXjzsh/nfrNV74+/Eg/rT8Fya+BcYBRXBPB+VYkGIr8=;
        b=OhPo1yH+CQsaHtevEsQPziFBtmiv7UnZc8xCKssikeC82GIEG5U0OnktR/nMyi9mP1
         QeGKdnSrzfuRLR2homs1QDJQDu6Suuopgl6LgeCU6Wjfe/M8xVshT0p5mI2ItIDqPZRS
         bTDvZnGG1pylYyK2NhR8QH4qqmGY3ZQAhk8Pg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714421603; x=1715026403;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BXjzsh/nfrNV74+/Eg/rT8Fya+BcYBRXBPB+VYkGIr8=;
        b=WxTQEsDtEiYjtoEggh53j8WAdqbkxAJARCSXfiIDiNcoFkXMNrPnfMaIHotnamLiN5
         hMRvNZ41tgyhWyp2NyvGZSldwTFHgZY6+ZYISYf0q0GiyK/KVj32F2EIMjs7b7DCkYCu
         ffGmLzc+mAoirftvrzyg4xx2fWoQERHddQxMtSzQ7gDk3BBD0pfBkkwBadZiV0/50uVI
         /yaywOpwDJiRU6+0MyfhY2PLlg8WS4DVH+BfzESF1SYbnPvDClRzMhZEkF96LDNY8NYl
         85f0Vur0ew2Q3BQCS7JJguzk0zpLnJC6p90Xdg+SnYCIcNofxe640KGODgOsrwLUPUaQ
         8yug==
X-Forwarded-Encrypted: i=1; AJvYcCUMDRWf2wzd4gB6ckURSoDG7iCbIrG1flg6LuaTKLNvghAvrOyyg56lmM3dngvuYpfgaIGRHCKdNE1OgTEVL0Elc0QPkOaYuvmXtYIr
X-Gm-Message-State: AOJu0YwHHynksw8osLSguvT+rgipLMUEY0G8sT9tMeI/N9MXuDJgiNhC
	EEuHxrKePbT6PgNmZZhQLPTaSId9stJj+L4oSWyqBL+H2raTz1ygnk2/QvxbZg==
X-Google-Smtp-Source: AGHT+IHx20vgzODxO0CmjBxc3eLPOcVrUqtUBQgDReCQFkXCxJwNnQAZ4SSCabovup0+fIe8uoMO0A==
X-Received: by 2002:a05:6a20:43ab:b0:1af:597f:ffa4 with SMTP id i43-20020a056a2043ab00b001af597fffa4mr620907pzl.14.1714421602751;
        Mon, 29 Apr 2024 13:13:22 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b8-20020a170902d50800b001eab473021fsm6336073plg.168.2024.04.29.13.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 13:13:22 -0700 (PDT)
Date: Mon, 29 Apr 2024 13:13:21 -0700
From: Kees Cook <keescook@chromium.org>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Erick Archer <erick.archer@outlook.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Justin Stitt <justinstitt@google.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] scsi: csiostor: Use kcalloc() instead of kzalloc()
Message-ID: <202404291259.3A8EE11@keescook>
References: <AS8PR02MB7237BA2BBAA646DFDB21C63B8B392@AS8PR02MB7237.eurprd02.prod.outlook.com>
 <202404291019.5AC903A@keescook>
 <yq17cgg58sp.fsf@ca-mkp.ca.oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq17cgg58sp.fsf@ca-mkp.ca.oracle.com>

On Mon, Apr 29, 2024 at 02:31:19PM -0400, Martin K. Petersen wrote:
> 
> Kees,
> 
> >> This patch seems to be lost. Gustavo reviewed it on January 15, 2024
> >> but the patch has not been applied since.
> >
> > This looks correct to me. I can pick this up if no one else snags it?
> 
> I guess my original reply didn't make it out, I don't see it in the
> archives.
> 
> My objections were:
> 
>  1. The original code is more readable to me than the proposed
>     replacement.

I guess this is a style preference. I find the proposed easier to read.
It also removes lines while doing it. :)

>  2. The original code has worked since introduced in 2012. Nobody has
>     touched it since, presumably it's fine.

The code itself is fine unless you have a 32-bit system with a malicious
card, so yeah, near zero risk.

>  3. I don't have the hardware and thus no way of validating the proposed
>     changes.

This is kind of an ongoing tension we have between driver code and
refactoring efforts. And this isn't a case where we can show identical
binary output, since this actively adds overflow checking via kcalloc()
internals.

> So what is the benefit of me accepting this patch? We have had several
> regressions in these conversions. Had one just last week, almost
> identical in nature to the one at hand.

People are working through large piles of known "weak code patterns"
with the goal of reaching 0 instances in the kernel. Usually this is for
ongoing greater compiler flag coverage, but this particular one is
harder for the compiler to warn on, so it's from Coccinelle patterns.

> I am all for fixing code which is undergoing active use and development.
> But I really don't see the benefit of updating a legacy driver which
> hasn't seen updates in ages. Why risk introducing a regression?

I see a common pattern where "why risk introducing a regression?" gets
paired with "we can't test this code". I'm really not sure what to do
about this given how much the kernel is changing all the time.

In this particular case, I guess all I can say is that it is a trivially
correct change that uses a more robust API and more idiomatic allocation
sizeof()s (i.e. use the sizeof() of what is being allocated, not a
potentially disconnected struct name).

-Kees

-- 
Kees Cook

