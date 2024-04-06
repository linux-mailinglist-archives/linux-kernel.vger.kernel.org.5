Return-Path: <linux-kernel+bounces-133793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD0B89A8C2
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 05:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78C33B21ECF
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 03:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628111B80F;
	Sat,  6 Apr 2024 03:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YM/yzcn8"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C58E17BB5
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 03:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712375809; cv=none; b=du/oiLTg6F7Laqf17oGHT+ybuoCC1+OpU47ZZQ5KJ2y1n08LELeTo7mv0ARiaYdQNhXjCoCZqx0Boy2Y+XiislPjLUnlFMpp1jVBQi8TUUytS8VQTHwSuYUKhGM+fMWRkveAKCd4Gq9eI9HjI1gE0O0vUfasG8GTu/5af18CrD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712375809; c=relaxed/simple;
	bh=Nknx+id0eWyF+dIrz26ypWeTQwcjuf/c/RRecCxTfyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MiQITTPjOENGbIPpOl/fZU83f38ZbBjmxvOKenMBmr3sAur7skQiJDUoitmFBlVHe573BWxni1UEuJlfVmGzWV1T9qHy7PlLeZNNS2yX0LVXfIDTwWTSMhEC4PjemCdUwIK8AzKw1X+ZFa3nk/8CiVPx9Biij+KRsLmi1x6uqKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YM/yzcn8; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6ed054f282aso884259b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 20:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712375807; x=1712980607; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2waHho42F7C08+DfylsDnjRzoFfxGmadSquP0/DTSzQ=;
        b=YM/yzcn8VvIgMQQrrwfLqbb1wcNlEPg0MIb6MVjCnFSxzIfo9iwDVYGsuUUOcABy17
         Jzq4JhFPxls26H8ffMnzIHxbypzrHM6wVOJvA7UFlY2tkb8boNkdvAu0duEcX/PjXqIt
         YAYziewi7ZpbF1Yo7VomINrxH4GVrWjxT0RwpdZDNQIoKNIY8bycZiL/vW87NOZqZW1z
         dQfEsPZCHM2VBM76ifBXzXh5xUVCXv4+bWPR9reXrWFLEME/EVfLLQdkG1nRqRqmATdF
         yLwXwzHUMazAHv5f4dGwcBDZ8wwCkIq8nguwso1yVHFUfOSoETk9jzXygwUCh1iyZzxc
         UGvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712375807; x=1712980607;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2waHho42F7C08+DfylsDnjRzoFfxGmadSquP0/DTSzQ=;
        b=Ozjv/lew9FaJjSp/OkBaEbdEryyp5vslrrY84tEQ3g0lBEO4yvx65lJNsFum6PWiW/
         SSMt+t4znId6O599qfhzvZ0VFVNQ7WQ1mai5IIDccM1mRjEEzAcbl2qL6tE6wDVfAWqF
         FyuZaWX9WZO9ugYW95UrH3k7wFvr5yKG4gR0+iDf1zfR/USjKAFkzBFDndv6JaBcbGFc
         UMF8HcisIiOcM4Tk7W9JixQScfXng8O1MpK3vEWGlJFX/i8be/QsRRbesMMAK+vRUJKs
         P0mme0SB4TNHPSE+aFocJksi6zlO7EXVU7vQSdyOOB0uD6swIZgwGPX8DIoRRmCxf8Dw
         U/jw==
X-Forwarded-Encrypted: i=1; AJvYcCVafK+klbHPaamw6PYzT7Gx5Pv7p+PI44wbjaxQ1IB9Jo360Jqm48HBomGMVx5CLOOdeHB1llRl6S+FIcQ8DlB1rkBMqnkDNguHRdxk
X-Gm-Message-State: AOJu0YzZBfApwmwQQywz6HDNOmX7/9EXd1W19mKOHKkGU3fVf5g4yFDZ
	Dad+0KTgJuA4MREA3DRFrbKpqEfUvhZ+6zEVkgdt2Truihco2b+3NVurqbLosA==
X-Google-Smtp-Source: AGHT+IHZ9PC/wF2PeMmOAyVpbGPTZX/rB3bFShp9yCUZv3Gg3YkGHiD3lCdlkJCMaYpPKaSbCSrurQ==
X-Received: by 2002:a05:6a00:1a86:b0:6e6:c38e:e8a6 with SMTP id e6-20020a056a001a8600b006e6c38ee8a6mr3628754pfv.4.1712375807375;
        Fri, 05 Apr 2024 20:56:47 -0700 (PDT)
Received: from thinkpad ([103.28.246.231])
        by smtp.gmail.com with ESMTPSA id g24-20020a63dd58000000b005d66caee3d0sm2263567pgj.22.2024.04.05.20.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 20:56:47 -0700 (PDT)
Date: Sat, 6 Apr 2024 09:26:42 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Amit Pundir <amit.pundir@linaro.org>
Subject: Re: [PATCH v2 0/2] scsi: ufs: qcom: Add missing interconnect
 bandwidth values for Gear 5
Message-ID: <20240406035642.GB2678@thinkpad>
References: <20240403-ufs-icc-fix-v2-0-958412a5eb45@linaro.org>
 <yq1o7anqo62.fsf@ca-mkp.ca.oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yq1o7anqo62.fsf@ca-mkp.ca.oracle.com>

On Fri, Apr 05, 2024 at 09:24:00PM -0400, Martin K. Petersen wrote:
> 
> Manivannan,
> 
> > This series adds the interconnect bandwidth values for Gear 5 to the
> > Qcom driver and also adds the check for the unsupported gear/lane
> > values.
> 
> Applied to 6.10/scsi-staging, thanks!
> 

Thanks Martin! But patch 1/2 is actually a fix that needs to be merged for 6.9,
since starting from 6.9 we are seeing the crash on some Qcom boards.

But patch 2/2 is just an improvement, so it can be part of 6.10.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

