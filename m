Return-Path: <linux-kernel+bounces-35392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C00183904C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6C0B1F2A66F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F7E5EE9A;
	Tue, 23 Jan 2024 13:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="evktzCJE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1925EE76
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 13:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706017104; cv=none; b=usnaPWz7DCDgHBsxGy6IrInJ7eQKKjzGFVY1AK4ZPOk/VLMaWgQtM8xuWK+xMep0BUvyU1Oub547MotkPLQnb2K8xfJDGUaN0JOpCsYn141dmUGf/Wcr8qDQgYyBlFChPG77Xb6Fv+Wut9r9e+FNFkzCcecI6v+vS12h6AYSTT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706017104; c=relaxed/simple;
	bh=XjIK/7Xpg144Fxy0/nUAPJZJk41v/xciwVkQI1CZ5G0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QS3TMWIus7efuF7crMSCxoKdKLscTxdH9kIAn5zqlM0O0owqUmYGZ+jxDK75l1MuG2JrOu/rk3PvO9l+1CFS2vM60yGS+gZnIr+CEM1es6RyaPgJzF85cVRaY5TheFkVnvoXK+9WIimjLs2Yd3Uzi4yuYCrdKyyqP9LPKKfebOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=evktzCJE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706017101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eIEgnQ9c50Sj+zsvA8MdnvK0Mjj4Z9htr/i8+xUw1GA=;
	b=evktzCJENuDTsxU29PZEue6YxG8/oku9YApco69+rPw0xObj9LSenxnDcPstWbLmm5n6pO
	v2yb1Y+9ejXyr3n/ynSmq2ZtgVcBk0cEslOJO1f+1zd8zNgwDMgrjQYkbAt3FCYgQm64e4
	lfRtQhdWZolr51rFzGL5X5S0nvmqugI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-52qU3dqsPWqUM9nh68MrsQ-1; Tue, 23 Jan 2024 08:38:20 -0500
X-MC-Unique: 52qU3dqsPWqUM9nh68MrsQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40e4caa37f5so36266455e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 05:38:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706017099; x=1706621899;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eIEgnQ9c50Sj+zsvA8MdnvK0Mjj4Z9htr/i8+xUw1GA=;
        b=PkNRrJqSDExDESSHzf4F9t6N9lXrzL8IZIQEu12whTMW34fu0bcDVNk0gBWEF4pmZ9
         92C5WupTGKY2R/81medQfixBo/Um/gR78TM0n1ZinhpTd832YjAKw4TDIwX+YV8AnPrA
         O9MmjM3bamA1y+0sb2n+ziDh0Dz4RkIh7r6JPqHTKNaiGIH8gpvw47qPz0kSeoFhYxGd
         7tqEyimX5zfCWAQBjbZhBar4XE22ImLHEjRubsOgH+oCzDaVYAh288aJEmUgDmZ1jcrC
         Ll2Z2TT9oJLEgUBd9rPeuJ+TdEeNTbucX74SvIgWdybKCgM5y3kQ3+PhUlwKN4h4VAuZ
         +vBg==
X-Gm-Message-State: AOJu0YzPEcD5QscrBGNfsuc1ErldxDBKdAJ3GbgPsMLl0DmHiBjbRZSL
	vn6B3nYCLe652zkgHP7Rwm0GtX4irn3ck7/s8BAC54DqL4J9kkjOTXMRHkVsc25jnck6J2Cc98v
	M666wCvXe/RJwqOXEZh2/n9aWwp0Q2V2ztslokk/lWKEcDWwXD/hj3Drc/XDJ3A==
X-Received: by 2002:a05:600c:4e88:b0:40e:b313:9da2 with SMTP id f8-20020a05600c4e8800b0040eb3139da2mr155374wmq.90.1706017098957;
        Tue, 23 Jan 2024 05:38:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXaxkDqdTjqQUUG1IEKUig0tKAlfzSQioI62GUGYo2aeuE2fALmv9NQ4rZZcK0tCK4jCvWnQ==
X-Received: by 2002:a05:600c:4e88:b0:40e:b313:9da2 with SMTP id f8-20020a05600c4e8800b0040eb3139da2mr155365wmq.90.1706017098635;
        Tue, 23 Jan 2024 05:38:18 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f6-20020a05600c154600b0040e880ac6ecsm22681842wmg.35.2024.01.23.05.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 05:38:18 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, chenhuacai@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Thomas
 Zimmermann <tzimmermann@suse.de>, Jaak Ristioja <jaak@ristioja.ee>, Huacai
 Chen <chenhuacai@loongson.cn>, Thorsten Leemhuis
 <regressions@leemhuis.info>, Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH] Revert "drivers/firmware: Move sysfb_init() from
 device_initcall to subsys_initcall_sync"
In-Reply-To: <20240123120937.27736-1-tzimmermann@suse.de>
References: <20240123120937.27736-1-tzimmermann@suse.de>
Date: Tue, 23 Jan 2024 14:38:17 +0100
Message-ID: <871qa8w4om.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> This reverts commit 60aebc9559492cea6a9625f514a8041717e3a2e4.
>
> Commit 60aebc9559492cea ("drivers/firmware: Move sysfb_init() from
> device_initcall to subsys_initcall_sync") messes up initialization order
> of the graphics drivers and leads to blank displays on some systems. So
> revert the commit.
>
> To make the display drivers fully independent from initialization
> order requires to track framebuffer memory by device and independently
> from the loaded drivers. The kernel currently lacks the infrastructure
> to do so.
>
> Reported-by: Jaak Ristioja <jaak@ristioja.ee>
> Closes: https://lore.kernel.org/dri-devel/ZUnNi3q3yB3zZfTl@P70.localdomain/T/#t
> Reported-by: Huacai Chen <chenhuacai@loongson.cn>
> Closes: https://lore.kernel.org/dri-devel/20231108024613.2898921-1-chenhuacai@loongson.cn/
> Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/10133
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Cc: Thorsten Leemhuis <regressions@leemhuis.info>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


