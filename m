Return-Path: <linux-kernel+bounces-20505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B06F827FDD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 08:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D40E1B254B0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 07:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5508411CAF;
	Tue,  9 Jan 2024 07:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ntJSrakW"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDAE2D60B
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 07:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d45f182fa2so23347115ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 23:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704787050; x=1705391850; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LJaAgkMysyU+rJly+ZLjAMA6XzBdKr1ifp5VcfkkRmI=;
        b=ntJSrakWiG48I6/vXlFku3TzkbRf+vg8wL8lj5CXWzJ0dx5TUjOTH2Lmz3pQ4Cb5Gy
         4tjHC9MhSmdQ7UTxm4WvTtZ91C/n7LaX+J6fpvn7KtyIf2Df+xy3ed/UHLn6P83HDxvh
         yduFZca1LHnicY7AaoYffaW5p5LGekw/13mNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704787050; x=1705391850;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LJaAgkMysyU+rJly+ZLjAMA6XzBdKr1ifp5VcfkkRmI=;
        b=FDzxKfv5QN1+3gA4i1xbKsAS5Un3qp9C30CEa2/FBjT7bSKy3xOhn4Px5DLT3nYCeD
         D5v6L2w7+mqivygLwbaVcwzchShCfLFh/o/W3xASyWxYghtDdcdXaWrQVqOG8/9LNSeb
         0xQxtANYODwCfio4rclqFiZXIkpZ5kCvU6eZMeth4oJUfobZW5+JoHgy9zsSjcSCJdaO
         FMM3lwrTJVMj4iz48qORqkJGKRf9IkMaCaYXCJ/f1bGgqCmpUjnChZ4FC0KQIYT/zvIx
         unAz2pRaysYW3JXuXzuvEsm8fJEnd4p98/CBlaPsr1VGlVCKO7SuC4U4H3Bi7tTsSehu
         ayRA==
X-Gm-Message-State: AOJu0YxV1pihAA987FIfgUN8MdX4mnGFkg4xkeOPGg/7LnL2tKaWW0Zs
	6UMNlDBWvvk9CWybl1qAh83vpYZjMOcc
X-Google-Smtp-Source: AGHT+IHkdc5SEqOU4j+ZTAsSmX5JM1gcIkgcDn5+o0E0JsF/jrPN5rTqY5Qu8XkZuoCUCMrUd0zVDA==
X-Received: by 2002:a17:90b:383:b0:28c:e64c:b97f with SMTP id ga3-20020a17090b038300b0028ce64cb97fmr2688891pjb.85.1704787049720;
        Mon, 08 Jan 2024 23:57:29 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:7b29:709a:867f:fec5])
        by smtp.gmail.com with ESMTPSA id 15-20020a17090a000f00b0028bbf4c0264sm8420053pja.10.2024.01.08.23.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 23:57:29 -0800 (PST)
Date: Tue, 9 Jan 2024 16:57:26 +0900
From: Hidenori Kobayashi <hidenorik@chromium.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bingbu Cao <bingbu.cao@intel.com>,
	Tianshu Qiu <tian.shu.qiu@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Yong Zhi <yong.zhi@intel.com>, stable@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
	linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] media: staging: ipu3-imgu: Set fields before
 media_entity_pads_init()
Message-ID: <20240109075726.4ht5nqrtevzk7yh7@google.com>
References: <20240109041500.2790754-1-hidenorik@chromium.org>
 <68ff6c83-b8c7-4bcb-9b94-a33ab83aaf58@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68ff6c83-b8c7-4bcb-9b94-a33ab83aaf58@moroto.mountain>

On Tue, Jan 09, 2024 at 10:51:15AM +0300, Dan Carpenter wrote:
> On Tue, Jan 09, 2024 at 01:14:59PM +0900, Hidenori Kobayashi wrote:
> > The imgu driver fails to probe because it does not set the pad's flags
> > before calling media_entity_pads_init(). Fix the initialization order so
> > that the driver probe succeeds. The ops initialization is also moved
> > together for readability.
> > 
> 
> Wait, I was really hoping you would include these lines in the commit
> message:
> 
> the imgu driver fails to probe with the following message:
> 
> [   14.596315] ipu3-imgu 0000:00:05.0: failed initialize subdev media entity (-22)
> [   14.596322] ipu3-imgu 0000:00:05.0: failed to register subdev0 ret (-22)
> [   14.596327] ipu3-imgu 0000:00:05.0: failed to register pipes (-22)
> [   14.596331] ipu3-imgu 0000:00:05.0: failed to create V4L2 devices (-22)
> 
> That's what people will search for when they run intio the problem.
> Could you please resend a v3?  Normally, editing a commit message is
> pretty easy, right?
> 
> regards,
> dan carpenter
> 
> 

Ah, I misunderstood then, sorry. I will add the error lines to the
commit messages and send a v3.

Hidenori

