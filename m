Return-Path: <linux-kernel+bounces-21358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 316C3828E25
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 20:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D76A11F2277C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4922B3DB84;
	Tue,  9 Jan 2024 19:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WmFMijfi"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECB13D556
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 19:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7bee3761bb4so35432939f.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 11:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704829634; x=1705434434; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jp3sPNgDn5/w+4+SQ1Qzo5FCSJIVAu5zu+xhNcaS+RE=;
        b=WmFMijfiyoN4iXHXnNTgp9SZ3FGgajoebCBzBn2+XT8eXw9KYXXP8u8n8RWp5u3U8S
         diK0rc0TIrU/3540+ag3pm3B4Vzkz0c6ZWHcpVKmtvKbWKCAdU+2fvc8beCJ+M5g07Aa
         ZutY43ahCZPDU7Wt/qgCxAGFrx9ACN6CryvJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704829634; x=1705434434;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jp3sPNgDn5/w+4+SQ1Qzo5FCSJIVAu5zu+xhNcaS+RE=;
        b=Ow0TcCHO+2JSeqkuQYZ7NySOLwl6KuD/gcrOlG1jO0m3X600bIs2c+OSifmAxYuTRt
         55TNVNeUmrYcI3iysSwNc8eAin2mZJxvUfjgbQBu8rWwdI0+UPU98BiMW50q0tLkzfzq
         kqzb7RNpEtdEA80tFClkHJMZZcvICXhsutoloVrvk5/FO93isecSb3ddqmoUzFKwrWEo
         NhT5a1tRPDfMBHTzOIK7x+IVNrd00uPiub1DwkEG2s2cAjjZJ261yZcv2S8tJza3PP42
         E+Rlgk6bCq6sbOygovvT76Z1aWnqMiZdYQ83T1d9vDBQk56nrh/VXO/ueFJ5njDk35QC
         Rd5w==
X-Gm-Message-State: AOJu0YwpZhKyktGwNRRbl3IEsuY5mVP14deBrZivDHg2gi3u2CIBYpzV
	MmMrTDXaMr0AHlvaV22wW1hHGAjFUdx6
X-Google-Smtp-Source: AGHT+IF2+p52+a/uGcKh/I7JeXkJJoDrdwxg8dNkuNsj9eVicHWq61t6V8lQJDA2Rjq6uoJanlNaeg==
X-Received: by 2002:a05:6e02:1989:b0:360:637:f64d with SMTP id g9-20020a056e02198900b003600637f64dmr9062346ilf.6.1704829634495;
        Tue, 09 Jan 2024 11:47:14 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n68-20020a632747000000b005cd8044c6fesm2019222pgn.23.2024.01.09.11.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 11:47:14 -0800 (PST)
Date: Tue, 9 Jan 2024 11:47:13 -0800
From: Kees Cook <keescook@chromium.org>
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, jannh@google.com, sroettger@google.com,
	willy@infradead.org, gregkh@linuxfoundation.org,
	torvalds@linux-foundation.org, usama.anjum@collabora.com,
	jeffxu@google.com, jorgelo@chromium.org, groeck@chromium.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, pedro.falcato@gmail.com, dave.hansen@intel.com,
	linux-hardening@vger.kernel.org, deraadt@openbsd.org
Subject: Re: [RFC PATCH v5 0/4] Introduce mseal()
Message-ID: <202401091144.2C203AA7@keescook>
References: <20240109154547.1839886-1-jeffxu@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109154547.1839886-1-jeffxu@chromium.org>

On Tue, Jan 09, 2024 at 03:45:38PM +0000, jeffxu@chromium.org wrote:
> This patchset proposes a new mseal() syscall for the Linux kernel.

Thanks for continuing to work on this! Given Linus's general approval
on the v4, I think this series can also drop the "RFC" part -- this code
is looking to land. :)

Since we're in the merge window right now, it'll likely be a couple
weeks before akpm will consider putting this in -next. But given timing,
this means it'll have a long time to bake in -next, which is good.

-Kees

-- 
Kees Cook

