Return-Path: <linux-kernel+bounces-22656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EB582A0FF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7378281E92
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 19:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570424EB28;
	Wed, 10 Jan 2024 19:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Oi6m1TVl"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B99B4EB23
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 19:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d427518d52so33413095ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 11:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704914665; x=1705519465; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ksBpub1lP/jvDFiUMw2x/JKCWlBs10qSrtIRra9tdmQ=;
        b=Oi6m1TVleG89Cst6zzK5CxOVuXZloQGT7lq+5DTWTuv8O8e+xPmh501QVIjxzq/dKt
         NipVtkG3VftPAz2J3U0l8l8vr5cNEWvHBz8j3gTfvT/z8Q+mu6Ov62ZuS46BzCdhKJou
         UOBNaiQP3Zx62wS5dOfbREF0O/xtj31lJgJ14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704914665; x=1705519465;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ksBpub1lP/jvDFiUMw2x/JKCWlBs10qSrtIRra9tdmQ=;
        b=ReZADqTD/kWPUp0tYmf9H6wv5AuKVcpM7iroIdur/DLEIUeHXDXbRpWnGymfY8qjQs
         Gm7urs+p6w8CAz7dXt6BpWg7B7ieYs8UilIuxcMZcTM383uP4VrnxVk1B4osMmspY4/F
         p0xvctx5i4iNBEQLecipheds/GSeRYB1F29VkFlE8ff2ZgxTa9FMWkhWxiPY4h7H3Jr/
         FF38uJcs4vHyAFKU7HjX57viF+vIFcUejiOvY3PyKF3E9uXLA7c6ksVnYQSn81XDtOEz
         REcidase39MtVT65vaQdHbJ525UY5Iif04Lvxk1MOPqUotkjv2NoSK5a7zfO0A1ERCQn
         bZZQ==
X-Gm-Message-State: AOJu0YxTfb/96n2uDKu3JEDIs5taPFMxgZM4iPJM0twLkjCJmJRvtSUg
	3XzxFvabcF4Y1F83LHx42nLtZYzs3/qU
X-Google-Smtp-Source: AGHT+IHkxk3D86zP7jp1IZ3UnXi4YDrtM6ROJGYoPzRj1eGT7V8VBxHLXFoXIEzqGBvxP5Ox2BE2mA==
X-Received: by 2002:a17:902:b413:b0:1d5:731a:ac7e with SMTP id x19-20020a170902b41300b001d5731aac7emr751304plr.35.1704914665736;
        Wed, 10 Jan 2024 11:24:25 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b4-20020a170902d50400b001d46274b533sm3990904plg.138.2024.01.10.11.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 11:24:25 -0800 (PST)
Date: Wed, 10 Jan 2024 11:24:24 -0800
From: Kees Cook <keescook@chromium.org>
To: Josh Triplett <josh@joshtriplett.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org,
	Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [GIT PULL] execve updates for v6.8-rc1
Message-ID: <202401101120.68DCE0F@keescook>
References: <202401081028.0E908F9E0A@keescook>
 <CAHk-=wgznerM-xs+x+krDfE7eVBiy_HOam35rbsFMMOwvYuEKQ@mail.gmail.com>
 <D01C78AC-830C-4D73-9E9F-7FD38CEF2E82@kernel.org>
 <ZZ2W_xzCSyOgltad@localhost>
 <CAHk-=wi75tFVtZdzFRr4hsDeUKmeACbgD46rLe+2bcd=4mHBBw@mail.gmail.com>
 <ZZ3_Jmb1sb2wQWO_@localhost>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZ3_Jmb1sb2wQWO_@localhost>

On Tue, Jan 09, 2024 at 06:21:26PM -0800, Josh Triplett wrote:
> With Linus's fastpath patch ("no patch" with Linus's applied, and the
> followup -ENOMEM fix applied):
> 
> === With only PATH ===
> 0.28user 2.44system 0:02.80elapsed 97%CPU (0avgtext+0avgdata 1152maxresident)k
> 0inputs+0outputs (0major+694706minor)pagefaults 0swaps
> 
> === With 64 extra environment variables ===
> 0.29user 2.68system 0:03.06elapsed 97%CPU (0avgtext+0avgdata 1152maxresident)k
> 0inputs+0outputs (0major+712431minor)pagefaults 0swaps

Thanks for digging into this!

I've been trying to figure out how to measure only the execve portion of
a workload (with perf)[1] to get a more real-world measurement, but the
above does show improvements for the "open once early". I'll get the
behavior landed in -next after the merge window closes, and we can
continue examining if we can make do_filp_open() better...

-Kees

[1] https://lore.kernel.org/linux-perf-users/ZZ32p0LRSt5-vFPX@kernel.org/

-- 
Kees Cook

