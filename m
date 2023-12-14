Return-Path: <linux-kernel+bounces-164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB30813CF3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 22:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87F062834DC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 21:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236BB2C68F;
	Thu, 14 Dec 2023 21:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O7Rt2W2/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D36671EF
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 21:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-28b29d1fe6fso123201a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 13:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702590606; x=1703195406; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q3uvOl5I1K5LVZjTbvdk6O6AI3UzMwrE4ysaxYUe9kI=;
        b=O7Rt2W2/umRxANgZyktz+eyA5O6bnAtP2wUk4AJZpw6CiELu3Tz7E0LFpU+JzbyI29
         YCUwFaF/hC9TOlrRXj8sxTpriwMOi+S8ORMLX3U6ERBiyTSAPLW1HqabHIAoUcO53ugO
         WgE/tpPMp7D5cKHD9BKc7h6o/ZMSWI2r8YtWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702590606; x=1703195406;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q3uvOl5I1K5LVZjTbvdk6O6AI3UzMwrE4ysaxYUe9kI=;
        b=c//ucOlO+pKlrZHdmnJT6fVhXZsKUD8VfHVUQU4ZEa+eCGupcqNd6M1kfuthBYY+ZM
         +YFzewa3yKYue7SCDWxnxMWKr4EJiZS79uiFu6rr/QMNMSvaaAIW3Zs9bDjcuz+Co1CR
         HyWaKCl6tJmgg22XU7lY025ahzZ367QXre/7Af5e9O9wWLERzPHG5iLiwCy/HJ433EgK
         SkmckkswM29MXBFE3+BQGRr8rEJ810Z+8B7cW2icPIajipexuXHKzBUa5h0BCvBdapK0
         /DwtIHbSFgGXF8eNmXL3bJLqDriPYCaLNhLgAI4MgF5EUu8qv7Y7uoIfjZsqd7+98jgi
         dYXg==
X-Gm-Message-State: AOJu0Yz0Rxf3kvD0NRJeeW2bh5XKywdSXRCOYE125sfqPLqMC+p5dhNu
	pquRSvKan2VQH8cKo6KmrWKNRw==
X-Google-Smtp-Source: AGHT+IH8XIX3Um1NiC6K2GNJEyKljGfB96y9SWgXPf2JeECrD6rGe9/j6ZSa0NVjliiYfaX/MzK2Aw==
X-Received: by 2002:a17:90a:aa8b:b0:288:76d7:4227 with SMTP id l11-20020a17090aaa8b00b0028876d74227mr4749010pjq.52.1702590606645;
        Thu, 14 Dec 2023 13:50:06 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j8-20020a17090a734800b0028ae9cb6ce0sm3740633pjs.6.2023.12.14.13.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 13:50:06 -0800 (PST)
Date: Thu, 14 Dec 2023 13:50:05 -0800
From: Kees Cook <keescook@chromium.org>
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: kernel/gcov/fs.c:103: warning: Excess struct member 'buffer'
 description in 'gcov_iterator'
Message-ID: <202312141344.9E41E46584@keescook>
References: <202312150432.oBngC94A-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202312150432.oBngC94A-lkp@intel.com>

On Fri, Dec 15, 2023 at 04:53:19AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   5bd7ef53ffe5ca580e93e74eb8c81ed191ddc4bd
> commit: fbd126f5a658b92c7f6af986a6d89cf5e5693268 gcov: annotate struct gcov_iterator with __counted_by
> date:   8 weeks ago
> config: i386-buildonly-randconfig-001-20231214 (https://download.01.org/0day-ci/archive/20231215/202312150432.oBngC94A-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231215/202312150432.oBngC94A-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202312150432.oBngC94A-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
> >> kernel/gcov/fs.c:103: warning: Excess struct member 'buffer' description in 'gcov_iterator'
> 
> 
> vim +103 kernel/gcov/fs.c
> 
> 7a1d55b987dfcb Johannes Berg 2021-05-06   90  
> 7a1d55b987dfcb Johannes Berg 2021-05-06   91  /**
> 7a1d55b987dfcb Johannes Berg 2021-05-06   92   * struct gcov_iterator - specifies current file position in logical records
> 7a1d55b987dfcb Johannes Berg 2021-05-06   93   * @info: associated profiling data
> 7a1d55b987dfcb Johannes Berg 2021-05-06   94   * @buffer: buffer containing file data
> 7a1d55b987dfcb Johannes Berg 2021-05-06   95   * @size: size of buffer
> 7a1d55b987dfcb Johannes Berg 2021-05-06   96   * @pos: current position in file
> 7a1d55b987dfcb Johannes Berg 2021-05-06   97   */
> 7a1d55b987dfcb Johannes Berg 2021-05-06   98  struct gcov_iterator {
> 7a1d55b987dfcb Johannes Berg 2021-05-06   99  	struct gcov_info *info;
> 7a1d55b987dfcb Johannes Berg 2021-05-06  100  	size_t size;
> 7a1d55b987dfcb Johannes Berg 2021-05-06  101  	loff_t pos;
> fbd126f5a658b9 Kees Cook     2023-09-22  102  	char buffer[] __counted_by(size);
> 7a1d55b987dfcb Johannes Berg 2021-05-06 @103  };
> 7a1d55b987dfcb Johannes Berg 2021-05-06  104  

It looks like whatever produces that error is not parsing attributes
correctly. I suspect this is the "htmldocs" target and "__counted_by" is
missing from Documentation/conf.py. I'll investigate...

-- 
Kees Cook

