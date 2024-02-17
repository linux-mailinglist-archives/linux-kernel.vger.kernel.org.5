Return-Path: <linux-kernel+bounces-70110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 719F785932F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 23:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F05411F22371
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 22:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41317CF32;
	Sat, 17 Feb 2024 22:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kzRoPuDU"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E277E6D1A8
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 22:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708209908; cv=none; b=kzp6wm3L7M+dqnzSktsGVisRMiem0aOmalqfgqUwR3SwXtOXVgIOWzaBmzQWMG7DL3GZIxWL2DmmOO5dm4rzPKZm5xQu+Haro7UczkdNsoKCfw3rkPE/WIRiUp32m8TmjJ5J2gq/FBKmntVd6dzBP+sxVz6QdW3CgSBUIUuv51Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708209908; c=relaxed/simple;
	bh=urM+nLCqAhqOanY4utAYiFvmTeBTP9vM1GuLdCAu7dU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nom6Xy89Ht5owEMHrBIoEb30MuxC6F7FRnfrYPLz3g+zubI8ip9kxqplfLJKJjcqaE0DMAoPiTgfz765gHU9jqCqTaItudRR7dmwMfMga3RLlDF2qORqUlTPJCgy7TvT+bbUQUXkQ5utFjAbQ3wPYxU6Ft3kJnVL5esCjqi8KMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kzRoPuDU; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso1721936a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 14:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708209905; x=1708814705; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6zYveub7yYw/4yOK4qfAyNaSqjm09WW1iA3q80zNNrI=;
        b=kzRoPuDU1k7WdDDWHWFIgd4yz75FvLnn0aJYYAL3SndOZpcv77XLMTIQHNuPvOVqat
         7BW2yeWSAjm6YhG6dGfoN+Nvg3BpRWI50TU4gzN1WhHL9xk2ALAZZ+XWx2CEJGyT/XPS
         Aiu1M30MDTXYfHh2xiIWjTJnyBDOVUQLOqN1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708209905; x=1708814705;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6zYveub7yYw/4yOK4qfAyNaSqjm09WW1iA3q80zNNrI=;
        b=L2V1I7ZO+Fi5xOQwLNXykVoikX7gaWtgASYeIT3Hykk1ciuUMK4oc+tN+A/WUssz2A
         mfxvSKLmD4p6YRYsGAcBDHgivKkwSQxPJWwtwGbAI3GN1/CAlNcb+4hDkhPCnCy4SNVK
         vHXlYUtsU9+wl64lGM4+yMzjmvV00hN3t9vZnEQJwgVqAkhvMtbNjqjcQ6BZlxxFIPLR
         r4bQ88dT6/bGLMDgH3bFpkBUZiFE0A0eqmnt7JCFEdnKk6ei+Bx/aFizZllchh6n/QpK
         ZeYH4T8s7CC5HGcjgHedc7Dqzhew6S/w1kkdHGqcXZrpxJLUtqe93UvAeOU6ElVHWC82
         UhuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWc7KwO3QGQAZlB8BYS4Gx99DXmDHNYAE3rn0Zqx1IK0SMYhgTXauO0pczBMA+46ZTTMEXDnfLdA76CBFLNlsIk/gwLbP/badETbjKN
X-Gm-Message-State: AOJu0YyMGrGJ+1s7I3iHk3ie74BAx92DuvBVf4qk0rrd6HZ5zF+oAFJx
	UATePAXBqnWF9EvZY3ZZ1JqUM4Poh2oS0iSAt5O10V/qt5SPi4Q956wCwjredQ==
X-Google-Smtp-Source: AGHT+IGfBwCI/zJRAfkI3/3guXIHn5ScNJfsMg7yf6ZXenaRb2Xqpg5ydDYfgeE6X+Dq0UeBGs5IJw==
X-Received: by 2002:a05:6a20:9c97:b0:19e:bca3:213f with SMTP id mj23-20020a056a209c9700b0019ebca3213fmr11331029pzb.52.1708209905129;
        Sat, 17 Feb 2024 14:45:05 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id w3-20020a17090a528300b002990d91d31dsm2270321pjh.15.2024.02.17.14.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 14:45:04 -0800 (PST)
Date: Sat, 17 Feb 2024 14:45:03 -0800
From: Kees Cook <keescook@chromium.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"linux-hardening @ vger . kernel . org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH bpf-next] bpf: Check return from set_memory_rox() and
 friends
Message-ID: <202402171444.C121486@keescook>
References: <63322c8e8454de9b240583de58cd730bc97bb789.1708165016.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63322c8e8454de9b240583de58cd730bc97bb789.1708165016.git.christophe.leroy@csgroup.eu>

On Sat, Feb 17, 2024 at 11:24:07AM +0100, Christophe Leroy wrote:
> arch_protect_bpf_trampoline() and alloc_new_pack() call
> set_memory_rox() which can fail, leading to unprotected memory.
> 
> Take into account return from set_memory_XX() functions and add
> __must_check flag to arch_protect_bpf_trampoline().
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Thanks for doing this! This seems to hit all the right error paths that
I can see.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

