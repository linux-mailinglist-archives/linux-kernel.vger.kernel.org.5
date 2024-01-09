Return-Path: <linux-kernel+bounces-20853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD99828643
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 13:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6E5C285E33
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 12:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA38381D5;
	Tue,  9 Jan 2024 12:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="SqAIqgRv"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AFD364AE
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 12:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a28af5d7531so84593666b.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 04:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1704804615; x=1705409415; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z4HBT3vRdZsJHEbNKDeJKOCZfga8hHDywItcZI2H538=;
        b=SqAIqgRvHQ2z0ZJjkUNyM0UIv0RoqnEyX3Bd27KuA3yb38invCaH9TU1sdKDh8sW93
         EVWVug2cFA5oJ1wgKs9GJVNx9k1c4G3tFCMjFBG+zgzBh0BsG7d4N751nIyiVyXA8d54
         OXo33m+5rDgHd/T4d7Hz+dBwzvuUk1pmk3tng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704804615; x=1705409415;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z4HBT3vRdZsJHEbNKDeJKOCZfga8hHDywItcZI2H538=;
        b=mT2862shHUixEBtWLEmr3Cdw6am4m9zlZxNwRaiV3X8wE9qvXUiFagU4IC6bzRmxbV
         ITJoyuqxZUN2cD8zWedPauTxwN1siCx80DcgCx+q9ARHT97ik2nXt7MRXE7yRCiNJHJ9
         yGJlz66QGpOit61DW3qwxYrUwRDoIuRD+A7G361fyu+j1fZqx9PXjD87prVoSZbUTAmJ
         JBtxcZ/ArXznbd9beqHzoFKIRZjff+uc6It/91dminnowY7rfKhhx3D0wL+xUjMSMafK
         lwrw5bsB7D6zB/jGUbrVX+FAXSibavo//ttFSP37i3dtcx4vAQ5ec/+ff7ogbbYrg2t9
         BkOQ==
X-Gm-Message-State: AOJu0YzDonX6pOEIAS6Gpw2cAWKGUx66smQ83QxE80nQyCdWZQzFE/ca
	F6Hz8CPKCKOMJNjTuQ+VLT2xq4U0KM18dQ==
X-Google-Smtp-Source: AGHT+IEQLrFaUVEDnyO4kIJDI57CEii1UOqvOGAkct9whu6SzjHDG/l2Sd70k1spg79Oo5wAqtVJfA==
X-Received: by 2002:a17:907:2d09:b0:a27:4531:719f with SMTP id gs9-20020a1709072d0900b00a274531719fmr6140566ejc.2.1704804614942;
        Tue, 09 Jan 2024 04:50:14 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id se12-20020a170906ce4c00b00a1d5c52d628sm1010517ejb.3.2024.01.09.04.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 04:50:14 -0800 (PST)
Date: Tue, 9 Jan 2024 13:50:12 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Michael Walle <mwalle@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Robert Foss <rfoss@kernel.org>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Jagan Teki <jagan@amarulasolutions.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Tim Harvey <tharvey@gateworks.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-kernel@vger.kernel.org,
	DRI mailing list <dri-devel@lists.freedesktop.org>,
	Inki Dae <daeinki@gmail.com>
Subject: Re: [PATCH] drm: bridge: samsung-dsim: Don't use FORCE_STOP_STATE
Message-ID: <ZZ1BBO2nNSp3g-gT@phenom.ffwll.local>
Mail-Followup-To: Michael Walle <mwalle@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	David Airlie <airlied@gmail.com>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Robert Foss <rfoss@kernel.org>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Jagan Teki <jagan@amarulasolutions.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Tim Harvey <tharvey@gateworks.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-kernel@vger.kernel.org,
	DRI mailing list <dri-devel@lists.freedesktop.org>,
	Inki Dae <daeinki@gmail.com>
References: <20231113164344.1612602-1-mwalle@kernel.org>
 <631fe35a2a3b00781231e4f3f5094fae@kernel.org>
 <1ef3dad2-5f55-40e5-bba7-3c71d71c12e4@kontron.de>
 <CAAQKjZMccDwa63_PNJCP0rNOaHjTwcOz8AbKa=JXLQi-b0QVVw@mail.gmail.com>
 <2400535875c353ff7208be2d86d4556f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2400535875c353ff7208be2d86d4556f@kernel.org>
X-Operating-System: Linux phenom 6.5.0-4-amd64 

On Tue, Jan 09, 2024 at 09:47:20AM +0100, Michael Walle wrote:
> Hi,
> 
> > > Inki, are you picking this up? Or if not, who will?
> > 
> > I can pick it up but it would be better to go to the drm-misc tree. If
> > nobody cares about it then I will pick it up. :)
> > 
> > acked-by : Inki Dae <inki.dae@samsung.com>
> 
> Who is going to pick this up? Who has access to the drm-misc tree?

Inki has, so I'm assuming since he acked he'll also merge.
-Sima
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

