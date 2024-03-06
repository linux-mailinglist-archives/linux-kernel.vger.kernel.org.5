Return-Path: <linux-kernel+bounces-94075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3BA87397E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64F0728AEC0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F33133425;
	Wed,  6 Mar 2024 14:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FEw6lnrY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DA228EC
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 14:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709736179; cv=none; b=Jv2cOjg81KxNmNZgDRIyIWrkbrJw1y7ObfnpjdgaCqioQ7mbTzN4ks+VroSQo51SYVJggId29bSIorCThKIZ3AHuXW4g29yWYZB8Ib3k558FGyYYZUUUBDKrnKnUO4gdrPxe1gC3+E2epKixsUff+tXeNCpkk29VpCGLvRU3Fr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709736179; c=relaxed/simple;
	bh=RAcMJrC6ub5Q+DuIUs7BpLIVW2WQU7yyOZclgJ3QgwQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fdizl1dH5kV7CoJGa/JoIrIkry/O79SU0aVmqQRatnurcr/pg6mi4ol3qJWBcMupijGrwPVUBNFLU/qerdDSYLzbau+faYoPAQql0WgRi6sz6v3br2UBn3ArTGil+ieo/XkMfZSN62grvNf2ncoxGaln7W+u8oDadlEBRpLmmcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FEw6lnrY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709736176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nI16e0Px5mCnCB0ak7IH5fMzEGmp9xyhpg8P096W8A0=;
	b=FEw6lnrY6Yipx3lrfUaIM4JjA4rJ33RaXj6V8GEJjwoMATbSYprsW/5JFzRNvnYXt2jpbK
	ACJRIseaD0Qaf0z7Tcj7XF8IQzNy+xLbrjab3pdFfgJVB/u5pIjjC4Ew/xWc+NWlbn1rB/
	fCkFSi+pFi/+pPL5vH330sX67++w4eE=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-NsKgz2aTMj-yOwJEzAC1Ow-1; Wed, 06 Mar 2024 09:42:55 -0500
X-MC-Unique: NsKgz2aTMj-yOwJEzAC1Ow-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5135a84b942so1278689e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 06:42:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709736173; x=1710340973;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nI16e0Px5mCnCB0ak7IH5fMzEGmp9xyhpg8P096W8A0=;
        b=cVyOV9EFhLUZyddEzQzKALt7adv6bVEF2lOeYbFCcjXybHRoark0L18CPAV5G3V3Sp
         2eot93t8siD448A3Cm8OdKN6wj4gQJK8+8JWL1psSEE6IXnLKVmv6vDuB+9NmmsMC3L2
         n3gS0juCYO46irrpoKlQqVP6Tkoo8PMpoTlTd8URQneMVylvW3y1PEm7T/HqQh4MWyYx
         TADzogX1M4ftiHvglQV1j13h63+i1VJx8bH9lgJrku8NyWob55dhM7KUHJpvWoqsch8C
         AhqPl2wTvsCQBFUWP1JevVLZmS+q/xwXAR5e8hGEx4Ibiqx0/GWmvnkDKnCPTjMLfDo8
         lo+A==
X-Forwarded-Encrypted: i=1; AJvYcCUxh8DnMBFpydXIwfq9TBOGVU5g1iZ5NaRRNuR133JZ+0IcIvSb4lrswOh4GYGR+VVK4gKk/Xbi+76WY0tYLidUo5iMMvOLgxlwQtpX
X-Gm-Message-State: AOJu0YyilVZpN4ruFMl9vxSPPSUW5qzq9zH62/f6c2UBcNt5vyVwJhIh
	/Wesj7Lvp2JFkRC5wlEPd3HiCFHvWj/7cxirR3hjyxPBzEcyvjmSfw3VFhbty95OwlFObiHdxJR
	zVACRrng+ybw9MvKSQoXTQsgfIB6ZyzMsToeZQjMJSVaE0zNt9hHLXrtbbQwGGA==
X-Received: by 2002:a05:6512:282b:b0:513:2de3:6274 with SMTP id cf43-20020a056512282b00b005132de36274mr4056466lfb.55.1709736173415;
        Wed, 06 Mar 2024 06:42:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHHKZnxXOZaF1o6ZUr1X0aoj/T1WzfkQ2C4TYfYmHMXOz5xD8NuMemYB9AfCfZUppfYcNQSoA==
X-Received: by 2002:a05:6512:282b:b0:513:2de3:6274 with SMTP id cf43-20020a056512282b00b005132de36274mr4056444lfb.55.1709736172855;
        Wed, 06 Mar 2024 06:42:52 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o17-20020a05600c4fd100b00412d68dbf75sm14206235wmq.35.2024.03.06.06.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 06:42:52 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Douglas Anderson <dianders@chromium.org>, dri-devel@lists.freedesktop.org
Cc: Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann
 <tzimmermann@suse.de>, Douglas Anderson <dianders@chromium.org>, Daniel
 Vetter <daniel@ffwll.ch>, Dave Airlie <airlied@redhat.com>, David Airlie
 <airlied@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Sean Paul <sean@poorly.run>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "drm/udl: Add ARGB8888 as a format"
In-Reply-To: <20240306063721.1.I4a32475190334e1fa4eef4700ecd2787a43c94b5@changeid>
References: <20240306063721.1.I4a32475190334e1fa4eef4700ecd2787a43c94b5@changeid>
Date: Wed, 06 Mar 2024 15:42:51 +0100
Message-ID: <878r2vs9p0.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Douglas Anderson <dianders@chromium.org> writes:

Hello Doug,

> This reverts commit 95bf25bb9ed5dedb7fb39f76489f7d6843ab0475.
>
> Apparently there was a previous discussion about emulation of formats
> and it was decided XRGB8888 was the only format to support for legacy
> userspace [1]. Remove ARGB8888. Userspace needs to be fixed to accept
> XRGB8888.
>
> [1] https://lore.kernel.org/r/60dc7697-d7a0-4bf4-a22e-32f1bbb792c2@suse.de
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


