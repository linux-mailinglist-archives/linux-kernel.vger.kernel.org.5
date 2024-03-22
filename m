Return-Path: <linux-kernel+bounces-111318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3FF886A9B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE7B62850E6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068D63D0B3;
	Fri, 22 Mar 2024 10:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cOf7Awtl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89917E6
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 10:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711104221; cv=none; b=BwmmFxQVmOUsyjFj7IuUdr09V9pgFgcRLRcui9T6ocAojrUXVfzeRgJ1pS/crO4RNrqkc5Da6M2KsgBm74uPP7q3Dgm8RmbKVFhgAhruGvWLD3RDQsAUvOcjBhqzTRJljrbr0Ojuwx6taiLk7nB7O7Jvz63YYfCZFFfOc3nClUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711104221; c=relaxed/simple;
	bh=S8Z7aChjuflwNhwZ9CR9vs1643uDXcQF3L3Qw+I+IUk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lHcNSQbFGks055bEOtdEqVcmHojMYNh5A+Y89Sskip7nf42+SJiwKYyRQVBtkaXuODNgC96112QWfeUqeWHzQrtn/xV55s8HexvJD4Dv8cCTg6rDkBoaRI3G8TZJJZ8U5VPAYleBeqg539+CCCOZoysWw2B3wxkUqQkPaq5+XfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cOf7Awtl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711104218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e4hqr5sqga/uu4OSt9i/tA6ZdLVrKguR4cLu3EI2g3Y=;
	b=cOf7Awtlm66/grHI/GtbzfU3c1FKuTshw8yAvxFfro6uWZREYmkxt1oRD8q51PyqLfwfBB
	RYFNEeHcdkFTPqyn/tARoplktR+5lxjr2No1pZzu0sEMnbF/vwu+AAolUqH2fbO602EEpV
	fG5nxqQuG0CpiTSXZm9DVZJzvDHPAGE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-vHgEMmDMP-u0JC6VqNPMZw-1; Fri, 22 Mar 2024 06:43:37 -0400
X-MC-Unique: vHgEMmDMP-u0JC6VqNPMZw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-41464672d85so10743685e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 03:43:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711104216; x=1711709016;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e4hqr5sqga/uu4OSt9i/tA6ZdLVrKguR4cLu3EI2g3Y=;
        b=otyrFH0DsC2ZTDggiLnUBtJ0fpoo2HQUn3cYC3ZGHJifMNbeoGZsnTTMfcKZun3/6B
         dsuOgbPKJrV8a4h8DdXVtKu2OmfV4MbC4NXqRzzr82hq8cBg/pByUlc4JUibaM7h2OW1
         j7MfQRTJ+LnA3R28t/zsV+nOqiypPGu4d/FwJS+MSdazS483ga4iGtsc5g96XB8hUSj8
         KUnIgMtFGwYW7S5bLY3EeM001iYXVWOxzJD0L4llQcUWh+MMvCzuzIQcNHl0ix/Nz/n7
         UGD0O1URWMt0LlEuLTzrzXO1SP6aT4UvnBmbSe8LIEaU2wTSkr6X49NuM8nO1fuwVj80
         PeVw==
X-Forwarded-Encrypted: i=1; AJvYcCUGKiRRkI+JGHs+rrw8sC4FB3AfZ5FBNE2rintagUNBOJJxfkw7G6sLq3d/jDGXH6FdoxOENby5GNQDtnNSUZUC1tBsdnd5gc/PeII8
X-Gm-Message-State: AOJu0YwF6NoOcu4oKooaBfl5sNINlRBO8xWV9TcvhafFPa05+/AGhzoJ
	+/HFW78Srhfo6IdRBRhLn7qP3LKc7eQeBiIyZAa3FsDzLha1YbhcVSMF8cG+kkegfkGUGOIf/LS
	Uly5I9/IOE93vNc8cCGwjHE8QKrBw5V4UP4jl82swAmROE3/dwT9ikC3wfFrFOQ==
X-Received: by 2002:a5d:4145:0:b0:33e:9451:c299 with SMTP id c5-20020a5d4145000000b0033e9451c299mr1237990wrq.26.1711104216101;
        Fri, 22 Mar 2024 03:43:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsAkU+2jK4kRfvDnw8i0oVWh6n19VVa3BIi69kxPxPYLEkn3rIbnPUV1SFTkGh0njd+owt8g==
X-Received: by 2002:a5d:4145:0:b0:33e:9451:c299 with SMTP id c5-20020a5d4145000000b0033e9451c299mr1237971wrq.26.1711104215672;
        Fri, 22 Mar 2024 03:43:35 -0700 (PDT)
Received: from localhost ([90.167.87.57])
        by smtp.gmail.com with ESMTPSA id n10-20020adfe34a000000b0033de10c9efcsm1771312wrj.114.2024.03.22.03.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 03:43:35 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, nbowler@draconx.ca, deller@gmx.de
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>,
 Daniel Vetter <daniel@ffwll.ch>, Sam Ravnborg <sam@ravnborg.org>, Arnd
 Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert+renesas@glider.be>,
 stable@vger.kernel.org
Subject: Re: [PATCH] fbdev: Select I/O-memory framebuffer ops for SBus
In-Reply-To: <20240322083005.24269-1-tzimmermann@suse.de>
References: <20240322083005.24269-1-tzimmermann@suse.de>
Date: Fri, 22 Mar 2024 11:43:31 +0100
Message-ID: <877chu1r8s.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Framebuffer I/O on the Sparc Sbus requires read/write helpers for
> I/O memory. Select FB_IOMEM_FOPS accordingly.
>
> Reported-by: Nick Bowler <nbowler@draconx.ca>
> Closes: https://lore.kernel.org/lkml/5bc21364-41da-a339-676e-5bb0f4faebfb@draconx.ca/
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: 8813e86f6d82 ("fbdev: Remove default file-I/O implementations")
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: linux-fbdev@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v6.8+
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


