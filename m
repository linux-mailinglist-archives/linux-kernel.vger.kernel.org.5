Return-Path: <linux-kernel+bounces-20855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5C782864A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 13:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92D08284EE2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 12:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A3838F8F;
	Tue,  9 Jan 2024 12:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IUhJG5n7"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AB738F82
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 12:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso2194679a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 04:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704804703; x=1705409503; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8Sxl8/kBvhDFF/AoSIu6WVPGy6THdY3oshj1Hx9R7Rs=;
        b=IUhJG5n7gpGW0fZeq0W3YaRJW4GZ4pJWFolpckHWzKZbVi+wvvwq3bfhMB8mbXuFgm
         D+kRXYs/uz+Ddk4yOy0CTDQyG49DkF7usTNBL9WuuH+fqFEmB7BNAoC1hhVSFfI+7Hx0
         aE4QERrIESpUsmA8Vz6X/1y+qV390CawsXrTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704804703; x=1705409503;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Sxl8/kBvhDFF/AoSIu6WVPGy6THdY3oshj1Hx9R7Rs=;
        b=P9XMQk/A5vG4I09uavoLhwSgSzYFNHiAVrPJFh+z+qqZosUvscnxCD+txb1eUM0HTR
         1YOHSoEQLNVojxeI2gRSpdaLlB32VA9c5Bd6bl6guV9oTs2dX0Ptv3d/XBDUJRcpRJbY
         rXvaI1dT2Eb85As6U7x9+rpsjH0Z355lzNAOkhERbroQIPPhYqqxYhtjZPrAOqlHQrIB
         XQSGBj2691jFyL8IkGzkT06np9cbn7be46+J04LVho8aLli5CB0p656jF9Lep541l5S8
         /EAJ68PfXIFfuM0njKBk3Rbxnxm6xdowubD827FULxtHN6AIC2tvSj4BLUuSDCWQajLI
         dbcw==
X-Gm-Message-State: AOJu0Ywe4+OkW2WDUgDqwiJAZJmmJxZtTti2/3emwey1doxDfH4HCE1k
	0LG0/yZHabvS1ocZTqM+Slf7dl+gFMrv
X-Google-Smtp-Source: AGHT+IFc6rYxuOUQkU6wTWmxuuKmjNJOShljLpSpdpRfMplgFRtbGeJ3Rniw08DbwOcrhrsvP/mckw==
X-Received: by 2002:a05:6a20:a124:b0:199:fa27:9eb9 with SMTP id q36-20020a056a20a12400b00199fa279eb9mr649774pzk.95.1704804702996;
        Tue, 09 Jan 2024 04:51:42 -0800 (PST)
Received: from google.com (KD124209171220.ppp-bb.dion.ne.jp. [124.209.171.220])
        by smtp.gmail.com with ESMTPSA id i1-20020aa78b41000000b006d9af8c25easm1573919pfd.84.2024.01.09.04.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 04:51:42 -0800 (PST)
Date: Tue, 9 Jan 2024 21:51:38 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yunke Cao <yunkec@google.com>
Subject: Re: [PATCH v2] media: uvcvideo: Fix power line control for
 Shine-Optics Camera
Message-ID: <20240109125138.GC1012017@google.com>
References: <20240108-shine-v2-1-ddff959dab89@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108-shine-v2-1-ddff959dab89@chromium.org>

On (24/01/08 14:04), Ricardo Ribalda wrote:
> The device does not implement the power line frequency control
> correctly. It is a UVC 1.5 device, but implements the control as a UVC
> 1.1 device.
> 
> Add the corresponding control mapping override.
> 
> Bus 003 Device 002: ID 3277:009e Shine-Optics Integrated Camera
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               2.01
>   bDeviceClass          239 Miscellaneous Device
>   bDeviceSubClass         2
>   bDeviceProtocol         1 Interface Association
>   bMaxPacketSize0        64
>   idVendor           0x3277
>   idProduct          0x009e
>   bcdDevice            0.01
>   iManufacturer           3 Shine-Optics
>   iProduct                1 Integrated Camera
>   iSerial                 2 0001
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>




[..]
> ---
> base-commit: 0dd3ee31125508cd67f7e7172247f05b7fd1753a
> change-id: 20240108-shine-06c600d17a2a
> 
> Best regards,
> -- 
> Ricardo Ribalda <ribalda@chromium.org>

A side note: not sure what these lines are for.

