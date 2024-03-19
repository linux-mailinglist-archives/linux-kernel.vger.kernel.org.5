Return-Path: <linux-kernel+bounces-107260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7110587FA12
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D1A92829F6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89E87C6E9;
	Tue, 19 Mar 2024 08:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S/q2qrf/"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D817C0B8
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 08:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710837654; cv=none; b=AlyGBxfMDMiHte/hQiE5z6b4RxUZoEl9P14FNNh2jTa+qlYOCiZCxaRRwd9U5LgPNesbTyqFXTDZWOJW7GggIFPq4/jyKAWEswOYraGaFQ4hk1gKJ1xnOS+YupCrJ3K/sPUlC3rpijy9n4WxFVWZNV4ZVmBzr5e0qwFOivbLawU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710837654; c=relaxed/simple;
	bh=+lllqe1oGamg54GIj07KoJdepo5YUkK20ROlGfy+QX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iPQ4QFcYatmcCv4mMB4eOU8HmzpendA24/KHy0vYDfBmBc6YlH6a9yDJ905/n7DUHhtTSEab/0D5cm5T556lfnzmVpkV4YFY49k/h1rBr/MV1E33Aa3ENDTEwNXA1AyLfRg36osJwv1YqvmaD94U3EkdBSKXJUZKqpRkprL1cLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=S/q2qrf/; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1dee27acf7aso34114925ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 01:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710837652; x=1711442452; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1VAbjMoPwP6lJtWhwCQoX288twS1Y5Av3wBQ4HPYz4c=;
        b=S/q2qrf/jsYWIfnadnLl3p1Iv2MksHfpMDSwQaXbkt0nJ7+fQm/HWSzatnq7hIe0hz
         rR31OPInc9kXDcQcJkqoFhCSq1MpnChA33AlSnWLFbAuUSP/K676ZEzwC9ZdfYtSyE61
         k0Itz3IEVqvkP58E/BIKry+/fNdvuH9D5Bp8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710837652; x=1711442452;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1VAbjMoPwP6lJtWhwCQoX288twS1Y5Av3wBQ4HPYz4c=;
        b=qw5AF3w+ExVi0/URnpZXTqVHVussCVZElJPZjslOjNtxat3KnnV9PaKxbXf21MEi5n
         ABgt128u0RC9BGdPXRBUYA45G7sWp6i8S280m6aMom3fel3WF+6zEbTNVs1Y+NdWFIdo
         va8syEeLMJSHJtjh9Iptv+BeDFVOzsPN8Nxo5QrBhYGdHMwdgRaVZiMdPxpBwBbBOwaZ
         043QT6lyDKGfIEOyCbg4Cnoi+GgIIPDvGnPuDVAygjXPjGndxbXVaMdU3DrFu7p8aD2q
         +qGhQY+lUT1fVSz9LvBPqnAH58iOvYsO9dVcrNzNNiP2unus7J0/fZBYkSBToUkxVU6U
         jk2Q==
X-Forwarded-Encrypted: i=1; AJvYcCW60mxXJ4bzxN6tJ0bi14MucR4FJ6vg1t4mZcZi/g5M6J/JlxG6KlYzj/+7r3wUvx4nYHXUmJhnc2+C487p5Jc7uv2Ssdrflsv7Pzm6
X-Gm-Message-State: AOJu0YwNN8niL9Lh565XPUkNE8aH2M7+aAtXieBQZlLor4AzhzYrCwzq
	g5PBHbqQO98v5NULzC1bv3f99WVm1svCThepStLkNMRGjxPOjmiuhM9tX1BMKg==
X-Google-Smtp-Source: AGHT+IFkekqhASItln4Exvoi3VtGSD6RbwGcTZF1ddA3Qcwn+Oy9wecz8g1YC5sxwbpWJ00N0RtJMA==
X-Received: by 2002:a17:903:1c4:b0:1dd:7e30:4b15 with SMTP id e4-20020a17090301c400b001dd7e304b15mr16645851plh.29.1710837652007;
        Tue, 19 Mar 2024 01:40:52 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:c250:918d:64f:6463])
        by smtp.gmail.com with ESMTPSA id p10-20020a170902c70a00b001dcb18cd22esm10845105plp.141.2024.03.19.01.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 01:40:51 -0700 (PDT)
Date: Tue, 19 Mar 2024 17:40:47 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] media: uvc: Probe PLF limits at start-up
Message-ID: <20240319084047.GA1041856@google.com>
References: <20240318-billion-v1-0-2f7bc0ee2030@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318-billion-v1-0-2f7bc0ee2030@chromium.org>

On (24/03/18 23:55), Ricardo Ribalda wrote:
> 
> The UVC standard descries the values for the PLF control for its
> versions 1.1 and and 1.5, but it does not describe which values MUST be
> implemented.
> 
> So far, we have been adding "device quirks" to provide proper limits for
> the control, but this is failing to scale.
> 
> Add a function that during probe-time checks the capability of the
> control.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Looks good to me

FWIW
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

