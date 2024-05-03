Return-Path: <linux-kernel+bounces-168180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A1C8BB4D9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 22:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14653B20C47
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 20:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366E8158DC8;
	Fri,  3 May 2024 20:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MFl3aMru"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A49112EBFB
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 20:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714768121; cv=none; b=M+goQF5YTOtV+b33qmkJpah3t9nGF7qWrSX5yfABsFkuxTE9v5LOo/QuBYtFxWW7ZmNErUBqjTbi7+5RszuvO4vndP68cCWGHbQQ227Ua8exFVRNlEOyNCFgjgzWWexG8uXmdz65vlbnnfZ2ZsdrjPj2b3f0sUR7xrGk5CPflck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714768121; c=relaxed/simple;
	bh=uqcs2WtkKRadbRkgGXZX4d/MnzZr9F+VgkdeEm57dwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=llDTYeS8GYa1gXDQshEvI2oOBOTtEcx6vVwxeVAumEDuh+JUV/u9vSSWCc3244iw2OqC+HKGlY78h2xfB+vIrBSDaZvX41CScF+iG1xee3MBZP95IOcPT6bdWoAnSM09tsGebcOp1PJ4u6BRQC2/Bn7ej368zoEo16Ghrl0O9gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MFl3aMru; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5aa1bf6cb40so72069eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 13:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714768118; x=1715372918; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1iqzX4jEVf88YLxrEdDnezO793F37cz7yvxwfuzhVk4=;
        b=MFl3aMrudLTG6woBI3MzX3NVA8/nIldg9wzSH/6cqQEEiT9oKmFz724DjHNByklU4T
         lZh3e1uomz0KRqWVMZV2SXDxoi+R3vknpoJzTpuJxdhtZHckBuXtTKAIFNIfi+ZLA7/P
         yTo7rdM96D2runS5qOEeA82Nx/S70E4J3gUJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714768118; x=1715372918;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1iqzX4jEVf88YLxrEdDnezO793F37cz7yvxwfuzhVk4=;
        b=YMMLyC3GTecxtpF8nGin9cSFeXP4DE3RILcaooVvFG2UNAM3gROXFPk4B4F5BfkMtM
         NZ3rnksUN2TuAlQ0/CpSWc/mohmP+pH4azFT0czd9GV6gBBiU9gX1Dibx2k1N1RUaFJl
         1ebTwmEgKcwwt468F/P61EI0JS4vPxMmAAyHWxRQSdsn8UbqHRbXXoBen3kebDKogro2
         jcNjRFWi8Pxy1GRtMmlNAIBd9VBEfvU2bClFOoZEdxKdZfdDMUnqhj35SCtuA8kQ4Wbb
         ZXhRNFhlr5rELPgW3l36EwMMbCl+PUtDGoSIXw5RZOmvPh8sk2QH4Y2iYk7OBTCpWNdk
         LEeg==
X-Forwarded-Encrypted: i=1; AJvYcCV7C6He8HItPvNfEoNMGIFChXCqIuvnzYr52UqgslIrmPhux22EZZoCuh1d6Hq4MHdwvZudFtTl+cFyjiRuOXNxdVs9rFfGQEplTITq
X-Gm-Message-State: AOJu0YyTTiQ7kEFHa2VZMIBgK9sGNPa3BUeqePUDfLmY4Xc4tDRN/VP7
	atkjs4HXZ2icia9kt2gLy0TzY8lANK26TTl0tMAR7ipqXUKBMUpdY0WKS1T/AQ==
X-Google-Smtp-Source: AGHT+IF94HWVpg+ieTREfKNo4EYCAREwn5FJES4sWZrWNDrTepMs4qAK9EBYEOGD6R0pN+rBpz049w==
X-Received: by 2002:a05:6358:9481:b0:183:645b:cfa4 with SMTP id i1-20020a056358948100b00183645bcfa4mr3887974rwb.16.1714768118230;
        Fri, 03 May 2024 13:28:38 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n16-20020a63ee50000000b005f3d54c0a57sm3551694pgk.49.2024.05.03.13.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 13:28:37 -0700 (PDT)
Date: Fri, 3 May 2024 13:28:37 -0700
From: Kees Cook <keescook@chromium.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Bui Quang Minh <minhquangbui99@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	syzbot <syzbot+045b454ab35fd82a35fb@syzkaller.appspotmail.com>,
	io-uring@vger.kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, Laura Abbott <laura@labbott.name>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: get_file() unsafe under epoll (was Re: [syzbot] [fs?]
 [io-uring?] general protection fault in __ep_remove)
Message-ID: <202405031325.B8979870B@keescook>
References: <0000000000002d631f0615918f1e@google.com>
 <7c41cf3c-2a71-4dbb-8f34-0337890906fc@gmail.com>
 <202405031110.6F47982593@keescook>
 <64b51cc5-9f5b-4160-83f2-6d62175418a2@kernel.dk>
 <202405031207.9D62DA4973@keescook>
 <d6285f19-01aa-49c8-8fef-4b5842136215@kernel.dk>
 <202405031237.B6B8379@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202405031237.B6B8379@keescook>

On Fri, May 03, 2024 at 12:59:52PM -0700, Kees Cook wrote:
> So, yeah, I can't figure out how eventpoll_release() and epoll_wait()
> are expected to behave safely for .poll handlers.
> 
> Regardless, for the simple case: it seems like it's just totally illegal
> to use get_file() in a poll handler. Is this known/expected? And if so,
> how can dmabuf possibly deal with that?

Is this the right approach? It still feels to me like get_file() needs
to happen much earlier...

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 882b89edc52a..c6c29facf228 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -991,9 +991,13 @@ static __poll_t ep_item_poll(const struct epitem *epi, poll_table *pt,
 	__poll_t res;
 
 	pt->_key = epi->event.events;
-	if (!is_file_epoll(file))
-		res = vfs_poll(file, pt);
-	else
+	if (!is_file_epoll(file)) {
+		if (atomic_long_inc_not_zero(&file->f_count)) {
+			res = vfs_poll(file, pt);
+			fput(file);
+		} else
+			res = EPOLLERR;
+	} else
 		res = __ep_eventpoll_poll(file, pt, depth);
 	return res & epi->event.events;
 }

-- 
Kees Cook

