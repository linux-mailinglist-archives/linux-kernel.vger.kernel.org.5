Return-Path: <linux-kernel+bounces-85764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD5386BA6C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 23:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40923282179
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 22:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D019472907;
	Wed, 28 Feb 2024 22:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fpZByzHn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC1572903
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 22:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709157720; cv=none; b=ldX8fKLQmtVwraaKUjJjGT1nFLkjPA0SfKOld3mxpBtcJ9qlt7+IBWdYOc8pQ1LWTHeEsi1Ia7y2XMYpdx7EnnZ2zHVci7ucdCrYnizgPs+SUxEaCY1nuLsJjTS3x09Bym/FqxrYVnx5QvVzDwGvELdcpN0JZZpfH/R9HFYn6EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709157720; c=relaxed/simple;
	bh=o+3lKU6VlE6nxZ2uIrWmlrrddb6OP4BDWK4YrtdQs/8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D5zuJTg/XilFabkniAdusthfBbsY+Amo5TlCmuHCVBorMmQhMpqllTovwVTCZvyC3NakM9HUM+vige3qnvLp7CUteTKkcGSRnGlS22mxYkjn04BlJfdXUhnmPUPPCqLZQWOd3YeioKDxN9LVsdQGTXgpEP/NqYW5cUKWCHgdB/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fpZByzHn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709157717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gb42RHaHbvgH6buS2vhwM8dxZVCNDCNpgqpB45gim8I=;
	b=fpZByzHnCH3AtY+wJzULPCkdXof7qZVo+CfmrK96LE6va2qw5Ndcay+jU+twrXlWrw2KIF
	PXuQvsOayf5KLpducYdMuFalRrAlFGF/AuVFH4/2yB+uX9+jtb9MiQsX9o0kt1AdcCYqJj
	sinCRjzTLi8cbKhLaie4IbHRgPKhwtc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-nGXaYNxkPR2qvCHipcVnXQ-1; Wed, 28 Feb 2024 17:01:55 -0500
X-MC-Unique: nGXaYNxkPR2qvCHipcVnXQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40e53200380so1160465e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 14:01:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709157714; x=1709762514;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gb42RHaHbvgH6buS2vhwM8dxZVCNDCNpgqpB45gim8I=;
        b=rRRqH8Pv725Sw+4jKB6tJNicZdLAe3TMSBHWxK9/xU7VfgDa2t7AMPUjtpapYzRtIs
         2YuBb6SXVdeYEdsEvd5mCTepuiSIFplS+oA4FEcGDv70tBqhq10lNswRxH7inrrt8VQw
         Mu0PAXoBlQXvM0MvR5WqGti+kEe4jMUM1EkI7QEH3y5ixOc9rtSX7NsbvWE3VvSVNy5q
         nTE6jj2gI/07VXy/eiHJRvgpqTt/Amx12qAgUcZA2xw8+isndglBVWUgq5CanW8rm+hF
         Rhz+VMWK6pO+Jdn706EXwEsUNO0dPcSxKtte7IBv2t5G54C3zs4HIJTjmEGqjtCtuqDv
         laKg==
X-Forwarded-Encrypted: i=1; AJvYcCVHRu0Rz/QjeIuWV8SV7PJH5Azb5JPBKb1q0tGP8gqA2W9bN98+G0tPyZRDyYKCxMwk6XKi66/WbV8jn4uaAzM90iT8QH6PPIAQEwB8
X-Gm-Message-State: AOJu0YzfffLjXsUEZvnzA8ev2DJ17I47N4LN2odkk6PDrqjWzsA4aI7o
	HCXULv9uIDiw5nWXTH3X6EWfxqp5DHSxzhhIcuct7kS6VMJyjPp4kVHc5Xzc3FJ+SJoukkc0VF9
	WIOB2htru5X+/603BzNVHvefghp9aDjdXbzVO1Qh0ia6vsWlq7WLVs3PSTCHcdw==
X-Received: by 2002:a05:600c:1da2:b0:412:9868:97ed with SMTP id p34-20020a05600c1da200b00412986897edmr351059wms.9.1709157714636;
        Wed, 28 Feb 2024 14:01:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFnexliJkq2EDSDzvfJngEL/iGnA4sFkcjtCKKNbI9fBcw6ZnUjpTccYX1RM3sqQbDz3XTJog==
X-Received: by 2002:a05:600c:1da2:b0:412:9868:97ed with SMTP id p34-20020a05600c1da200b00412986897edmr351036wms.9.1709157714290;
        Wed, 28 Feb 2024 14:01:54 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id jz12-20020a05600c580c00b00411a6ce0f99sm112831wmb.24.2024.02.28.14.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 14:01:54 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Andrew Halaney <ahalaney@redhat.com>, Jyri Sarha <jyri.sarha@iki.fi>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Enric Balletbo <eballetb@redhat.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Andrew
 Halaney <ahalaney@redhat.com>
Subject: Re: [PATCH] drm/tidss: Use dev_err_probe() over dev_dbg() when
 failing to probe the port
In-Reply-To: <20240228-tidss-dev-err-probe-v1-1-5482252326d3@redhat.com>
References: <20240228-tidss-dev-err-probe-v1-1-5482252326d3@redhat.com>
Date: Wed, 28 Feb 2024 23:01:53 +0100
Message-ID: <8734tcnt7y.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andrew Halaney <ahalaney@redhat.com> writes:

Hello Andrew,

> This gets logged out to /sys/kernel/debug/devices_deferred in the
> -EPROBE_DEFER case and as an error otherwise. The message here provides
> useful information to the user when troubleshooting why their display is
> not working in either case, so let's make it output appropriately.
>
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> ---
> There's definitely more spots in this driver that could be upgraded from
> dev_dbg() to something more appropriate, but this one burned me today so
> I thought I'd send a patch for it specifically before I forget.
> ---

Makes sense to me and I agree that's useful to have that information there.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


