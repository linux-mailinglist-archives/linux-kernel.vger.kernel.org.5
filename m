Return-Path: <linux-kernel+bounces-118563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C20FC88BCAA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28AE0B22332
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E6512E71;
	Tue, 26 Mar 2024 08:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bBu0x7Qq"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F433EEDB
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 08:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711442544; cv=none; b=dARxThsfrK3mJjRKtEkDCHHUsAEAOrocl2VcH18tRi39UFEHbXm3xZrRS9em+XYpwlmAFeqAhhA9YUzVwoCMavrdBjjvdADIEqqkYQAb25k4u4pYC0aV4fn07Unu9zowNPHC4sh+ayfl8HLdOeJMy9Lzv3a1W/eENdoIofX6hIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711442544; c=relaxed/simple;
	bh=kuPEe1BoQTJFc2AUuBmgpz4yVcIxcJz3CaXsR1n7fk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BCvpCWIYML/ItKnWGNmgdBlRXf1jrx634Ecnh/DOw/XAJAXIS1J7U3dDCqKWRNKGHVGe4qhAMYXqqGicFNHIO6V3QbzYsOSAayeMB6BWQFnwdoGwjJNpNghZiFi1yRAkKDMiWP4bwPO4yaYAx6dWjPMRyj8znIccsoTKF43060U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bBu0x7Qq; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e6b5432439so4002114b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 01:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711442542; x=1712047342; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/3h3bAU2IX0EB0gn3S1QQMZf5Ge3/aPCneW3boA4Y8M=;
        b=bBu0x7QqrswvAbYqo5uNV0u09VCgr807PK/YaSSduS80LNMZlzyTp7Dkz/C3XH1nJb
         M0/vS2ON0DuEOOh/D5I5L+vhbQn/+jLoZWwKg6NYZO9WcrQGADB88UYJsQzycUmNSzga
         LYcGEGcnnne9ICwkNJUaAwl5FSaa/AYePtWLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711442542; x=1712047342;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/3h3bAU2IX0EB0gn3S1QQMZf5Ge3/aPCneW3boA4Y8M=;
        b=Nv3tE12DG2wPfU9IWurCMU66mzV9dHq24i5aSzPLmAOwF2o9mrf3SY+s2pfG9LVXHa
         281/vXSVZEl689xyZv820vBc3AdJlcT2Ss4ZsGY3S8DIMPDe9zTWl3IObD42ww0XFjnE
         2DkjFLsg/fldQX0pA9F51OZFQrhZg8mohW4hQX87C8xmDy87ImJOrkCtWeQVxJ7KPci7
         CkVLG2p2xEHFysFlaIh1W7+x/TuaUTIzUhl2OhFZUSS0BmepQTA/lWLM15EAlH/2aqCE
         RPmzql43UKxlrAICrjt1Psnx4Q9ZjS3anL6NAG5wFXQTnjDjLCDYRSSh/AHdg8oBZYFy
         t7vA==
X-Forwarded-Encrypted: i=1; AJvYcCXmuBqDikCSPxCZziJ0cYW8Fq8izzmELIb3dn46WlZuG6REk6sYY+JSSNK7aCAXuyvEPvAOM/UUZgte6i9Fx9C49x84lM2U3x/c6UD9
X-Gm-Message-State: AOJu0YxmoRvHNXDCFDd5T/dLf3ZQVMkT5T0sZuCJicUwMYq1JpjN/5Oz
	KnhozwXKFHYJRltu/rpx24DPsm5rbCpTb0Dsu+1eziwX7Zk0Pkyc8F0WJg+TJA==
X-Google-Smtp-Source: AGHT+IGve+mTHopZRTJXGmpkPMe6J2fEMTfF2BadNQ0JCYre3KPYhIGs7Z/mFu1RkFC5QTJ7USBTTQ==
X-Received: by 2002:a05:6a20:d398:b0:1a3:d60f:738f with SMTP id iq24-20020a056a20d39800b001a3d60f738fmr695431pzb.18.1711442541913;
        Tue, 26 Mar 2024 01:42:21 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:10b5:aeae:7583:f4c3])
        by smtp.gmail.com with ESMTPSA id ko12-20020a17090307cc00b001e0f2dc4165sm771704plb.60.2024.03.26.01.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 01:42:21 -0700 (PDT)
Date: Tue, 26 Mar 2024 17:42:17 +0900
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
Message-ID: <20240326084217.GB1041856@google.com>
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
>  drivers/media/usb/uvc/uvc_driver.c | 13 ++-------
>  drivers/media/usb/uvc/uvc_status.c | 57 ++++++++++++++++++++++++++++++++++++--
>  drivers/media/usb/uvc/uvc_v4l2.c   | 22 ++++-----------
>  drivers/media/usb/uvc/uvcvideo.h   | 10 ++++---
>  4 files changed, 68 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> index 17fc945c8deb6..b579644ac0745 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -2116,7 +2116,6 @@ static int uvc_probe(struct usb_interface *intf,
>  	INIT_LIST_HEAD(&dev->streams);
>  	kref_init(&dev->ref);
>  	atomic_set(&dev->nmappings, 0);
> -	mutex_init(&dev->lock);

Where is this getting initialized?

