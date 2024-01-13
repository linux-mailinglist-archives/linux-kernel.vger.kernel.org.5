Return-Path: <linux-kernel+bounces-25362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F2B82CE53
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 20:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 902DEB2231D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 19:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C94B6AA6;
	Sat, 13 Jan 2024 19:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TetzL6B8"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C3B6AAB
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 19:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3606ef221dbso34298565ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 11:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705175283; x=1705780083; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hl+nlMkUurqcw4/ZOA4GmmsYbpxPCJqe8VKEKUx1KC8=;
        b=TetzL6B8pwhAVdT6W4a2XUlaxOOIZSewrFk2EK+au2VDRDOc92L6578aSzSqtFrnkN
         ugn5e2STYu36w52esq3RH6UHBclrfZjqEPy3O+49qtmr+ai+xmpWmYwimr0fl7qMP3pu
         mP24ZKYGeQX+ZzOm8t/aIUvDkTv3YM93+jkUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705175283; x=1705780083;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hl+nlMkUurqcw4/ZOA4GmmsYbpxPCJqe8VKEKUx1KC8=;
        b=WX3WtyRZ0T/FBWu7fMO9dR21hh14+BZcW2dV8MuIL3WK3nPwQUTz+BmlnKii8fyS6O
         dUmcME1jTTxQDTXND9AB4u9+2EeHQMTWVg+WB+CfCoaxUTap6+PRVuSLaghpADlmzAFe
         pY20AXnVkIjV3m685nXjyu8c9xQXxWZSXlA0342a/o5a/Axe5uacnh19HUq0FSXjTSQH
         yO6s/IlP9pwzKfDYXpCsD1dF5TOVSrqaSJZwhEWKIFi8jWfA9CfheRoF9aWiBWJEuMzn
         AD/oseU2EWRB4OzJsd+0ezkwd4FfIEbHQklpuezaqpiTbswPKmCmx8XBGa+VOufmp/OQ
         yabw==
X-Gm-Message-State: AOJu0Yw6e+MbkYuLdckvLvrcwzGlazh9XqtQgpuRFmRNqtxHBYVQdx+V
	O03y52KolfhQL0H05d6TAAO+XsMJOJ1I
X-Google-Smtp-Source: AGHT+IFqqbZrhxKSXD4axLOL1VZ8kwo5umP84zusMZOOcni8S84eee6aHt2ZCv8rtlaqfKQqR8xCyw==
X-Received: by 2002:a05:6e02:c6d:b0:360:e2:bfed with SMTP id f13-20020a056e020c6d00b0036000e2bfedmr3817046ilj.61.1705175283304;
        Sat, 13 Jan 2024 11:48:03 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q5-20020a170902e30500b001cfb4d36eb1sm3263533plc.215.2024.01.13.11.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jan 2024 11:48:02 -0800 (PST)
Date: Sat, 13 Jan 2024 11:48:01 -0800
From: Kees Cook <keescook@chromium.org>
To: jeffxu@chromium.org, rdunlap@infradead.org
Cc: akpm@linux-foundation.org, jannh@google.com, sroettger@google.com,
	willy@infradead.org, gregkh@linuxfoundation.org,
	torvalds@linux-foundation.org, usama.anjum@collabora.com,
	jeffxu@google.com, jorgelo@chromium.org, groeck@chromium.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, pedro.falcato@gmail.com, dave.hansen@intel.com,
	linux-hardening@vger.kernel.org, deraadt@openbsd.org
Subject: Re: [PATCH v6 2/4] mseal: add mseal syscall
Message-ID: <202401131146.F017DB5870@keescook>
References: <20240111234142.2944934-1-jeffxu@chromium.org>
 <20240111234142.2944934-3-jeffxu@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111234142.2944934-3-jeffxu@chromium.org>

On Thu, Jan 11, 2024 at 11:41:39PM +0000, jeffxu@chromium.org wrote:
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index f5a97dec5169..345667583b03 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -30,6 +30,7 @@
>  #include <linux/kasan.h>
>  #include <linux/memremap.h>
>  #include <linux/slab.h>
> +#include <uapi/linux/mman.h>

I think the arm64 build failure is from this include -- it's happening
too early and some of the arm defines aren't available yet?

-Kees

-- 
Kees Cook

