Return-Path: <linux-kernel+bounces-105598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B2E87E134
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 01:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08F791F22080
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 00:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D967512B76;
	Mon, 18 Mar 2024 00:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cgPGB1Jg"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7631095B
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 00:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710720969; cv=none; b=j6cNcbFlXsEhxJueewUadkxDc76GJL4jJayg+Z9iA7m+RLpnkG52vZKXGKhZ3PUE717vNyZ/fkAH2mTJJY2zLjyC3GUeeoFW7zEIVBnz7EpIKMYh3LAjlGCNbiizudVOjZpRlK7Y6FoEq6aDOH0tsJOFG9yAqK3J9G3WTER2ZMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710720969; c=relaxed/simple;
	bh=Dt+bUP5TGLgAHNIvAhUBdii4y5s/O6Vz7Ao4CfXft3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=efQePDfBvt72qbTvOBMop8pWqj4DindSMKiij4ZZFVk3ja1+szMSkc2OOGUJnJeGQUsIbB89Ufd81yRqGchyuHcAzQwbL4P5bZ871ZAqOSIDhjH0hiA/Bhu3D+yBkloDpPI+QvsNU94wWa5PccMA96OA8KBMT4lrg+i8tnSLGr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cgPGB1Jg; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e6b6e000a4so2688929b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 17:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710720967; x=1711325767; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tgQQ/cSs7DpzBUKVRBioInrlIDv2gBjmdK74sDkvV7A=;
        b=cgPGB1JgeP5ervup5R7/O12LxThCHg5gO+jzmybnwoU2aEM1czcsv+1KOcYy7Pwame
         jTRUxKC2g8FhWh0diSLoj4uDhWev2SmxOvHFT8Uo91PF0YaErmtIivARTKuf+KqifUfU
         FbMrjysKt9QySneS/fhx46ZQrqAdyVFwQcwLRzeJHCrpR0tblwpbl2qalqLtcTRnoAJT
         UR6aBIUQwr1jjiHPErWY/VYI/RsSKWvAul/axrXRSdtauBA/2uqmPbyWQrmN3TxTBmni
         77mTEbSPb7F46NlJjkiHUxVwuf3pfGhTPGSD+ieqXsVP1L3fmpXq+tZ2CgfNtxIcbPFg
         2DvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710720967; x=1711325767;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tgQQ/cSs7DpzBUKVRBioInrlIDv2gBjmdK74sDkvV7A=;
        b=OvBK42xtAnFntPVkM37wN6I4V4OCI8iaBw6roLZtlQqQd8S01xQ8IzlIfLaPDKkM3X
         5dBz3HFydinbvVrj+Iz/0i0rAM0SVFli6wMrf/KUfJHaA8IBWi5T2HLhnhGyeIRUsfap
         IIMdSbtSlPjDpHzA4kj+HT61FDwxtdgpa+yBAJu8PF86HtND8WH9eLmzzPKIA8YlrDLr
         hdSRYrXeuWy7B/Va8qeSo7lbwHrr4IMsPGR9VbHYtMy7UALlU+P7x4PepPEDviut4Klq
         w1OVm/yN+XIoKtOdf0VPAmEZHkPj7F+4sMn0Bw2W4vrUvGUzjtR6VO+/SrwiFpG0ZMbV
         msWA==
X-Forwarded-Encrypted: i=1; AJvYcCWjzESIn25S1gtElhGdkF0g2j54LGQZ6M89+fPSSEm5B19zuo/NRqmCBHW2EWyoLYrIJkmcl9lMDevzyhA5tR7M98hy/G4pgox8I9Ql
X-Gm-Message-State: AOJu0YweGRGJk7vqOaKm/PDFd73A1ZbPLMHt8e9hjMqse3qiBqS8LjR/
	FWDsHGAheQjtjvprtaZqbaNUaXyaKF9JZYXCnwpcYE5d1EMrS7m+
X-Google-Smtp-Source: AGHT+IEhbjfduUnbrectLudyYjqIMifOgw6+lL49jVOaeF/cxkaz51NHXC6YztCDpLJ9BuDQcncyVA==
X-Received: by 2002:aa7:9883:0:b0:6e7:e64:2ad8 with SMTP id r3-20020aa79883000000b006e70e642ad8mr5428019pfl.8.1710720967006;
        Sun, 17 Mar 2024 17:16:07 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b3-20020a631b03000000b005c6617b52e6sm5871576pgb.5.2024.03.17.17.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 17:16:06 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 17 Mar 2024 17:16:05 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	chris@zankel.net, jcmvbkbc@gmail.com, willy@infradead.org,
	alexghiti@rivosinc.com, rppt@kernel.org, dennis@kernel.org,
	Barry Song <v-songbaohua@oppo.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] xtensa: remove redundant flush_dcache_page and
 ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE macros
Message-ID: <369716bf-0216-4114-b502-a2d2c819ee8c@roeck-us.net>
References: <20240313045036.51065-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313045036.51065-1-21cnbao@gmail.com>

On Wed, Mar 13, 2024 at 05:50:36PM +1300, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> xtensa's flush_dcache_page() can be a no-op sometimes. There is a
> generic implementation for this case in include/asm-generic/
> cacheflush.h.
>  #ifndef ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE
>  static inline void flush_dcache_page(struct page *page)
>  {
>  }
> 
>  #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 0
>  #endif
> 
> So remove the superfluous flush_dcache_page() definition, which also
> helps silence potential build warnings complaining the page variable
> passed to flush_dcache_page() is not used.
> 
>    In file included from crypto/scompress.c:12:
>    include/crypto/scatterwalk.h: In function 'scatterwalk_pagedone':
>    include/crypto/scatterwalk.h:76:30: warning: variable 'page' set but not used [-Wunused-but-set-variable]
>       76 |                 struct page *page;
>          |                              ^~~~
>    crypto/scompress.c: In function 'scomp_acomp_comp_decomp':
> >> crypto/scompress.c:174:38: warning: unused variable 'dst_page' [-Wunused-variable]
>      174 |                         struct page *dst_page = sg_page(req->dst);
>          |
> 
> The issue was originally reported on LoongArch by kernel test
> robot. And Huacai fixed it on LoongArch, but I found xtensa
> obviously has the same issue.
> 

Maybe I am doing something wrong, but this patch doesn't build
for me.

 CC      arch/xtensa/kernel/asm-offsets.s
In file included from ./include/linux/highmem.h:8,
                 from ./include/linux/bvec.h:10,
                 from ./include/linux/blk_types.h:10,
                 from ./include/linux/writeback.h:13,
                 from ./include/linux/memcontrol.h:23,
                 from ./include/linux/swap.h:9,
                 from ./include/linux/suspend.h:5,
                 from arch/xtensa/kernel/asm-offsets.c:24:
/include/linux/cacheflush.h:9:5: error: "ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE" is not defined, evaluates to 0 [-Werror=undef]
    9 | #if ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE

Guenter

