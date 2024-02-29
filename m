Return-Path: <linux-kernel+bounces-87368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3A886D37D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AD881C2287C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C3913F446;
	Thu, 29 Feb 2024 19:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aucVFdWL"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D55B13F43A
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 19:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709235764; cv=none; b=g5b0+2y7UJbUsRehYlQx0X/f58G3EV17X9ammKtsmdsByxEGWdjeYYAtGhKmxR4qVh13Q0kFZFES5r2yaMZeQIjN4l8fF0VKKkJemkIPWhFapIq9A5FMlSas8TDkP/LiQQakpr69kNCCiTYZjGXZiwA/bL03cqbcNjcque7nOlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709235764; c=relaxed/simple;
	bh=mOBVHJ8yyzsN+2QTeI7ofL3PhOFi+3K77Ftt0ex0OhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V5dYxiUm3xs25jUg4Db3ybRXxP2y/96c3s/+xcZVq5dJueo5glNrTYziEDJpKMMqh8UDOOjpVP+rpUa8KUh7j3dcXaeCpOjjQjztks/COZsxSHVb+AdxRmNrA77Al69udA+ciBcUlmfsxfAr/+/4q8f2KGKQeUocLZp8iVuLLPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aucVFdWL; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-365c9d37995so3371705ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 11:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709235762; x=1709840562; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KdmQnb2fNMhFh9QHwFl1noeV2VqNw483nMl2dymZb8k=;
        b=aucVFdWLaFK6gD5wE8vCjGiNtgFfQ/wdBUVltXOeGZZP5RB2hxN2lzcjTb0SGx3imb
         n5MFbynQ4w4xt21K223PHDd/OsNJNhxSR3kOji85d3g9pQaR0sDEMH0TmKM6UyEhlogI
         CahxTVxU++Ze+FMUWO6xKBAGMfuV8Jz7rpyHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709235762; x=1709840562;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KdmQnb2fNMhFh9QHwFl1noeV2VqNw483nMl2dymZb8k=;
        b=bPUhvA51wKl0uHCLZOwQYi6nLDxnrZMX6IIkZoMiyRd+tRctOpbADRtE8m9Er32pwg
         UYjEPb0Ol5p9w9YIgWe4eQ95GGJYvTliYjAmdbCXlWiQme4VRVSu76ZzpvfeUWd61bwy
         PHlU84XyFSISqyJ6XkIMouw+HnKqHkxvE/Owd81w6pK4r6Xu1fC2rUtrMZ/uBCosO5fW
         +Kk94T64S/MZaKnRRFCkc9GuOihpqUq5GAjbNHM/bWT1g7o1KYFqzap3aOTOX+6S5G38
         MJlp2xfVwS+PKZj7vEH3ZGiQuUJXQ6SwYD9oucrrVqMRTMo9m/nn5rDh4wvYrDwds99+
         DkZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdtY/N73MiX2olNf7AOvivp1b4q3++9sJdh3bOZNxvAtuIbAT3HfyMTNsXfae/ji8yB35YGu+RJfzxLaPVXNf86sg6yY5sTPdxswOh
X-Gm-Message-State: AOJu0Yzh9XUAqnV46MARrOkou0TdmQrBVGmHbq9KLqJQLDsfXnjMTaW2
	iXKF1kwfVGTUqb+evDr3HwOR/XEpw9DSqvV1GJYqzJCNqfL1TmjNSJkg3FZ/qg==
X-Google-Smtp-Source: AGHT+IFq8HTZpzDtKrD3CmV20Ym2lHtGVcr43P2WwUpMFpTWmAh7BLzqB4hWiofzybpN3yXuPwjHbQ==
X-Received: by 2002:a05:6e02:1a8c:b0:363:e7c8:2180 with SMTP id k12-20020a056e021a8c00b00363e7c82180mr35407ilv.12.1709235762414;
        Thu, 29 Feb 2024 11:42:42 -0800 (PST)
Received: from localhost (144.57.222.35.bc.googleusercontent.com. [35.222.57.144])
        by smtp.gmail.com with UTF8SMTPSA id k16-20020a023350000000b00474c8277395sm99591jak.47.2024.02.29.11.42.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 11:42:42 -0800 (PST)
Date: Thu, 29 Feb 2024 19:42:41 +0000
From: Matthias Kaehlcke <mka@chromium.org>
To: Javier Carrasco <javier.carrasco@wolfvision.net>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Helen Koike <helen.koike@collabora.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Russell King <linux@armlinux.org.uk>,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 4/9] drm: ci: arm64.config: update ONBOARD_USB_HUB to
 ONBOARD_USB_DEV
Message-ID: <ZeDeMc_hQzVo-CxQ@google.com>
References: <20240229-onboard_xvf3500-v6-0-a0aff2947040@wolfvision.net>
 <20240229-onboard_xvf3500-v6-4-a0aff2947040@wolfvision.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240229-onboard_xvf3500-v6-4-a0aff2947040@wolfvision.net>

On Thu, Feb 29, 2024 at 09:34:47AM +0100, Javier Carrasco wrote:
> The onboard_usb_hub driver has been updated to support non-hub devices,
> which has led to some renaming.
> 
> Update to the new name (ONBOARD_USB_DEV) accordingly.
> 
> Acked-by: Helen Koike <helen.koike@collabora.com>
> Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>

