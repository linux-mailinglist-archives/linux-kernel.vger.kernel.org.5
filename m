Return-Path: <linux-kernel+bounces-118593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1891D88BCFA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7A8B2E4784
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F55C1C2A1;
	Tue, 26 Mar 2024 08:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TIouS957"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6643C17722
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 08:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711443572; cv=none; b=SgvDlxgiVsMif7DtmNPjz8bOjwBSuWo2FIL1+VaxygjDx+aJ995g/LX/TTeJvcIkMrPd3M8a85ein7IFHTGFwnYknskYAr6dCEghmE+qblJCfbMK2ffqVriqunQF0lNgacknGkzkImovu+Xno9+XbrALT+pPOYG7Tdt9uTBIv5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711443572; c=relaxed/simple;
	bh=wV/EQGWM37o9gV7TNgoer7nZ6ODRKLvAZpARz5FCfPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iDiqdifFAkWOiyoKQ6CtKl3IEZl/oSU/YsLrzOI6Wvk1a+tbenDMLnt5xbyUJYDSENlwAM9uTDWfmW4VI3Oht+usp8k+VTZrqMBIi5/oBTnSU9ySGWEejD/PFDh3HQd7pzG+sjK4DS5MaHKesBD8l0Ku1FmsJlt0XXJ0zMtLLVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TIouS957; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-29de4c33441so3797285a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 01:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711443570; x=1712048370; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wXXZ7I2S+pmCNq9J5Ztqf++BnYQI/03nvNeZpPx+xyU=;
        b=TIouS957g664/9o/NlYLMlWnLE8xzLeKPi6GYxx5afU/fGnq612ir0NSN/64b/Rj2m
         waRZtLOs+UZpKNb5iUDAIrEuy29CBtt/DXljynfTo69vHB0cKPEgQ25A0+ewpVKS27Tl
         XwuAHnO56pMd3CgWkonPY6CavyrAa8C3kZu/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711443570; x=1712048370;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wXXZ7I2S+pmCNq9J5Ztqf++BnYQI/03nvNeZpPx+xyU=;
        b=dpGHD3GW8fQsjhr/lM3GzkKp8hwgUb/dyubHg6vVFag+nccdERzBerxeqpdfcHuqbu
         Dcj2Fw79XuQpX87N4Fq0wHYofTD6n0d7Rvt/siU1yudRtz3mc33rgsQKY9CvFCkSKVYh
         PhUtXy8vn4kS7R8mHhEVOCcllhy6588/tBhjXvfoaW9+KXztx74xzS2N9Ks5kOn8G9TV
         irJKqXg3jtHe8XEe1Gu+wJtVpF3398ioWwxrRuTSWhch6XIEbKN2rqX/UJyOyNINbPS3
         /cavYYGkggH3rFJpou6zzGgaBeFXBri2RLszxokQuYks1t0H0XDjXsWYxr7WXxv9LzmW
         F1XA==
X-Forwarded-Encrypted: i=1; AJvYcCVPy3Z8EOLTEHp78vbdHhONSIH5AdtFixo+riL8lvWh8AhfrL/7sjpxbs3n9CWdKQN68TtBqeAaMd/Pcu7ufBsZjhEpL8zOvub8JdS2
X-Gm-Message-State: AOJu0YwKMy6yaNarDTs7yagnVcYyqbvMXKiwlYaSU0xWt2+JcpXRFIhH
	emjMUaknA4IyiD6PEJImbj/thbHY7EUsPgfzbL6kZbds/wzwOVxhXDogRYhzpA==
X-Google-Smtp-Source: AGHT+IG0I3qcKcasVVSl6gTL9bPuD+8TYH73Fvc0nKcDLKacOqN+6H1VA4Nj6RAlv+k6gDuO4078Qw==
X-Received: by 2002:a17:90a:fa95:b0:2a0:4c10:da52 with SMTP id cu21-20020a17090afa9500b002a04c10da52mr7776876pjb.36.1711443570013;
        Tue, 26 Mar 2024 01:59:30 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:10b5:aeae:7583:f4c3])
        by smtp.gmail.com with ESMTPSA id l18-20020a17090a599200b0029beb0fc60fsm11226563pji.28.2024.03.26.01.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 01:59:29 -0700 (PDT)
Date: Tue, 26 Mar 2024 17:59:25 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Max Staudt <mstaudt@chromium.org>, Tomasz Figa <tfiga@chromium.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sean Paul <seanpaul@chromium.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v3 2/3] media: uvcvideo: Refactor the status irq API
Message-ID: <20240326085925.GC1041856@google.com>
References: <20240325-guenter-mini-v3-0-c4bc61d84e03@chromium.org>
 <20240325-guenter-mini-v3-2-c4bc61d84e03@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325-guenter-mini-v3-2-c4bc61d84e03@chromium.org>

On (24/03/25 16:31), Ricardo Ribalda wrote:
>  
>  void uvc_status_unregister(struct uvc_device *dev)
>  {
> -	usb_kill_urb(dev->int_urb);
> +	uvc_status_suspend(dev);
>  	uvc_input_unregister(dev);
>  }


Was the removal of usb_kill_urb() intended? If so, does it deserve
to be a patch on its own?

