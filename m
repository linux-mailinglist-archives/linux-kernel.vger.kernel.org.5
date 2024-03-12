Return-Path: <linux-kernel+bounces-100470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3608797EF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDDCE2844EC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C56A7CF13;
	Tue, 12 Mar 2024 15:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XuV2fcF1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD26254FA1
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 15:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710258469; cv=none; b=JxBvcBr4Od1e4oxLU82//vN9vThbaBTTpnuBAOEsHDxAOhY6cmykLA1NKjJzE+cJS3D65XCZKRyVW1ONjRIvdaZNeN4X82U55YiC3wJpmUaCA7m8rnHjKXOxcMsgIhri1YsLP5bQvDbDFCxZjyIpQirish87VMjbjLDECozkk38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710258469; c=relaxed/simple;
	bh=rSV8M403liOsOWpkP+QfGYfJEErc5Df98s4BS9GLlP8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dTiUuPwTx5mRXU5MpTau9S+XjQ+nLzqgU3FOiCzYb6KpXLiXTHyqfizm1lUv27Jo9H11SmAAlvwzsNYAzbgmVdBAWb5WowR/rkkrYZ8h/CoUNfq6wtFsJX6Yh/X6xPR9AQe2cfLd/IlQ9YjYzODeCHhSvqrKavC844yclCu2KPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XuV2fcF1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710258466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C03ZzqydLhwftyx/8OV079lEb5JdweH7XCPi8d8sS0U=;
	b=XuV2fcF119Kad+YeTvuVmJGIgT6GxZQW05egqI4dRsvYGKxBpoT/oq4LjtjOAIdnhRbrcI
	+LQQmrxIMEO9avUkRyJ/QD2OwUFvbMST5go5S56Q0LwdYMgxFqNoeOMcLZ2Tfpsgwnas/q
	T5QCVpRLi0npZ43aMPVooFe53XOxM3w=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-ze7-P2qaMembtJyMk8xPgg-1; Tue, 12 Mar 2024 11:47:44 -0400
X-MC-Unique: ze7-P2qaMembtJyMk8xPgg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33e7ffdf5c1so2372668f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 08:47:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710258463; x=1710863263;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C03ZzqydLhwftyx/8OV079lEb5JdweH7XCPi8d8sS0U=;
        b=XuEzulHAsvCS3GfXEyIMYUChqCDUw4Zu88aLugZe1jFjYn5vSFbJOAAWxvX5l4G1Zl
         skw8+L/9bIV31EfdacuuMhOAWb6KCmCWaX9aH4NpDvrSQwXeW1M/W64/hkEQhGf0/8EY
         1UWt5dvaO6l1rXcpGE7s2nF12j3hFObDWbd0mDQ1mrnm2Wm3OtDNTZa5aj2K0zbq38EL
         HopBMPjkRg/lv3iLbQ9ZL4oPlfO3y02RMpvKKjslJ8a2CgoFKT9ECJrqQEwh+1e0sYsD
         kc0ANSetTG391+DG4w8B3Kf/VavfTi0lvZgOvGNFfPwh99MAy6BGACLQvrZdMWTErcZu
         kpeQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+A/xwNRsRVqo+v017FjvjXGWKJx7NfcFGMvLKVwDA6MFINnHVDIQHDRfemZsCBPGp5jcjd9mtMkRnJ7nUI9ducJutuX8I9vOzSs0O
X-Gm-Message-State: AOJu0YwaYnSBemfGY+7UY3RKZxyII9Eawpmgi6FQg9TojszA/HjhD6uh
	UjlC4bnN7V6Xc9oVikRBOFVtfKvfcj944i5081fi1v03GQsRkStmo/dX6jYdECBuPnuKtG1GwbD
	UBTNW4KsjXC5QXkNYMXfYnhloRQnJOvN9Jcr1N7XkSSfIFOrRgtz4qdmfLzHzuQ==
X-Received: by 2002:a5d:5288:0:b0:33e:7ae7:accc with SMTP id c8-20020a5d5288000000b0033e7ae7acccmr5781982wrv.45.1710258463660;
        Tue, 12 Mar 2024 08:47:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDsApizg7abXDxnCPbaYlKdHgY8nGSh+z+TqlHOoR5D3BylQMjUqTJGZ6234DJDk41455U3g==
X-Received: by 2002:a5d:5288:0:b0:33e:7ae7:accc with SMTP id c8-20020a5d5288000000b0033e7ae7acccmr5781967wrv.45.1710258463239;
        Tue, 12 Mar 2024 08:47:43 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id p18-20020adf9d92000000b0033e17341ebesm9404825wre.117.2024.03.12.08.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 08:47:42 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
 maarten.lankhorst@linux.intel.com
Cc: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, tzimmermann@suse.de,
 Abaci Robot <abaci@linux.alibaba.com>, linux-kernel@vger.kernel.org,
 sumit.semwal@linaro.org, linaro-mm-sig@lists.linaro.org,
 dri-devel@lists.freedesktop.org, christian.koenig@amd.com,
 linux-media@vger.kernel.org
Subject: Re: [PATCH] drm/shmem-helper: Remove duplicate include
In-Reply-To: <871qh3k4bg.fsf@minerva.mail-host-address-is-not-set>
References: <20230320015829.52988-1-jiapeng.chong@linux.alibaba.com>
 <871qh3k4bg.fsf@minerva.mail-host-address-is-not-set>
Date: Tue, 12 Mar 2024 16:47:41 +0100
Message-ID: <87wmq7310i.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Javier Martinez Canillas <javierm@redhat.com> writes:

> Jiapeng Chong <jiapeng.chong@linux.alibaba.com> writes:
>
>> ./drivers/gpu/drm/drm_gem_shmem_helper.c: linux/module.h is included more than once.
>>
>> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
>> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4567
>> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
>> ---
>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
>

Pushed to drm-misc (drm-misc-next). Thanks!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


