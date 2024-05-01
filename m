Return-Path: <linux-kernel+bounces-165085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B8B8B878F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 11:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 808011F22AB3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 09:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C08537F6;
	Wed,  1 May 2024 09:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gmcAosuQ"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153D3502BB
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 09:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714555217; cv=none; b=NbaY748UeQpTOr/Al9ufJmSp3/D7x12FyyFe4SsysGu6ykvWMjqkfMAQnEnmouEX7lJg+bL/lNylBHghnTk8+Z+NXb1o8yZ4GpuYDzv3PGOTI1N4lFwOtGECwpGWRFAFl2oZx3uqVbvbXl8RBE/mJr/o2K3k7WtnZOaeul8s8iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714555217; c=relaxed/simple;
	bh=JES2V+o9lOG9nehMlWomz2LhbnbqipCEb9t4IBCDUcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UzYCryWyLilp1s0/A8xeCT2Hr1MFEXP8k/JuvypxeTLRPj87JClomxM1thHTrJsvqLtNGvtY1vLYcHtNFnyDRM1yfHDekmzW2LaJ2eZDFlWQV5ncBknsi050Mc0ul1dc9mEUnJMPh4L81OpOI/++MoANh/LPH0RHL6YfB8OaWU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gmcAosuQ; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-6082fd3e96eso4752527a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 02:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714555215; x=1715160015; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hBRFnyQ/MHghSNLsgG37WUgrQtBEqXPI6JDu9bkHFOE=;
        b=gmcAosuQdfBsx7VSOPrRf23otBiO6z0PPJ1D7lM6rBoMVnmIouZ65UPWQ3KKTX8ycS
         k0OerwSR35Sp+fBlZzcW8bC/yl67y/JiUhu3mf2EMjI52Mx3Epal9vsxQr78H8O8yFlo
         Anp07QCbk9L3S7wxAiO4gMj3imNcxYx5u4b1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714555215; x=1715160015;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hBRFnyQ/MHghSNLsgG37WUgrQtBEqXPI6JDu9bkHFOE=;
        b=E+coRGb3NVILJB6YSz4qtYuPXwioWmML76GjewtsczBs7GbZymXbUrNf6ciNDRhjdW
         n7PILlC0kalJZdJsrmYN09CySA7MAU6EF8yefrrCkqkKz74v/nBhZM5Ri5lvLaoflPxe
         WFj58GVNxAHnXbUcgQEUW6uQp7vcvAaOpR7xdA9J9/ddu0B0LJvcwwyTxHXBB+W28Zhh
         fXgreAkpYdFEV4hVx8i37dN7EKa3TX9oPQa0RTj76YW8dqx8bb7IowfdaHqREP95z7WC
         05gr4PHzIc0WSuUW2+uzDq1YMXJ6axqSLe2FIfKr1GJPn48AtMGbRMUALOJrcwZBUspj
         odcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXj7WZC33KuXvjPTW66HOAdnhvvdufWd1SExHDYesG8Qc4/CAjJttElwP5WsFTbNFRC9u0Bjh6OgMXT9b38p6lZgeIkHFzZJYSQXnwT
X-Gm-Message-State: AOJu0YzoUsgUKODPifhMCQypEQ/z/DfkUm6zQnBxpO0DdiwZej+q8Rx0
	EF99zezQwILjjxLgmymMr/SuStmhwCnW+/H8/VGi/ttRM8EwlrmYQajAy7/WRQ==
X-Google-Smtp-Source: AGHT+IF/08H7VJa9WOtcUnw4KEBJFekRcM3QhNFcB/+I0ZfORL4KH1vD28h3MBmb7I7BgCMTg96dIw==
X-Received: by 2002:a05:6a21:3994:b0:1af:6697:2512 with SMTP id ad20-20020a056a21399400b001af66972512mr2666075pzc.22.1714555215252;
        Wed, 01 May 2024 02:20:15 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:eea3:591:a74c:b230])
        by smtp.gmail.com with ESMTPSA id se6-20020a17090b518600b002b08e6d885asm958562pjb.3.2024.05.01.02.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 02:20:14 -0700 (PDT)
Date: Wed, 1 May 2024 18:20:12 +0900
From: Hidenori Kobayashi <hidenorik@chromium.org>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Bingbu Cao <bingbu.cao@intel.com>, Tianshu Qiu <tian.shu.qiu@intel.com>, 
	linux-media@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: [PATCH 2/4] media: intel/ipu6: Switch to RUNTIME_PM_OPS() and
 SYSTEM_SLEEP_PM_OPS
Message-ID: <42svo2ykapj3atpds3dedqzybp4vh7vcvje622n4cxz6geaw2w@mfazrgyw6653>
References: <20240430-fix-ipu6-v1-0-9b31fbbce6e4@chromium.org>
 <20240430-fix-ipu6-v1-2-9b31fbbce6e4@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240430-fix-ipu6-v1-2-9b31fbbce6e4@chromium.org>

On Tue, Apr 30, 2024 at 12:55:34PM +0000, Ricardo Ribalda wrote:
> Replace the old helpers with its modern alternative.
> Now we do not need to set '__maybe_unused' annotations when we are not
> enabling the PM configurations.
> 
> Fixes:
> drivers/media/pci/intel/ipu6/ipu6.c:841:12: warning: ‘ipu6_runtime_resume’ defined but not used [-Wunused-function]
> drivers/media/pci/intel/ipu6/ipu6.c:806:12: warning: ‘ipu6_resume’ defined but not used [-Wunused-function]
> drivers/media/pci/intel/ipu6/ipu6.c:801:12: warning: ‘ipu6_suspend’ defined but not used [-Wunused-function]
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/pci/intel/ipu6/ipu6.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/media/pci/intel/ipu6/ipu6.c b/drivers/media/pci/intel/ipu6/ipu6.c
> index 4b1f69d14d71..ff5ca0c52781 100644
> --- a/drivers/media/pci/intel/ipu6/ipu6.c
> +++ b/drivers/media/pci/intel/ipu6/ipu6.c
> @@ -803,7 +803,7 @@ static int ipu6_suspend(struct device *dev)
>  	return 0;
>  }
>  
> -static int ipu6_resume(struct device *dev)
> +static int __maybe_unused ipu6_resume(struct device *dev)

Doesn't this contradict your commit message?

>  {
>  	struct pci_dev *pdev = to_pci_dev(dev);
>  	struct ipu6_device *isp = pci_get_drvdata(pdev);
> @@ -860,8 +860,8 @@ static int ipu6_runtime_resume(struct device *dev)
>  }
>  
>  static const struct dev_pm_ops ipu6_pm_ops = {
> -	SET_SYSTEM_SLEEP_PM_OPS(&ipu6_suspend, &ipu6_resume)
> -	SET_RUNTIME_PM_OPS(&ipu6_suspend, &ipu6_runtime_resume, NULL)
> +	SYSTEM_SLEEP_PM_OPS(&ipu6_suspend, &ipu6_resume)
> +	RUNTIME_PM_OPS(&ipu6_suspend, &ipu6_runtime_resume, NULL)
>  };
>  
>  MODULE_DEVICE_TABLE(pci, ipu6_pci_tbl);
> 
> -- 
> 2.44.0.769.g3c40516874-goog
> 
> 

