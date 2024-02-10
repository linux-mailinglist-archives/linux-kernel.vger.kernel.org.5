Return-Path: <linux-kernel+bounces-60350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDB5850380
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 09:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF6AC28660F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 08:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D932533CFC;
	Sat, 10 Feb 2024 08:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R8hcqKPA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA8324214
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 08:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707553528; cv=none; b=n29YksuZpBSc3V6iCf9Yv/khs+2T2X5ITBN7cUO+dOkg/ebq21JGSfY+V5ODanj81A+tATnF53FBr1cgcNvkVfN2WFXvXJNwMnYLulo89mHVIo/2Vh1gTLkvk7MF8p6IphcncFiN52YsN9D3KMUKAJ1T5ZJPAUtIoohOJX0OQss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707553528; c=relaxed/simple;
	bh=HVb0K0f5msiTiN71d3DRsc68LqQj3DPeSg+k30JHhUA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=joHtpuopDFzGayvg1+U5TDQrtoR1yoQHZ5jAarTebB+LWSdK9LUK5T+NVr7qK8uDY9sJK8GjJk5DSVo49ZWzSVAImQkUCyjERmjihHQazfHaftErpBvr18p+Doi+Irt46z/RHC/ivB0NhhM8X2mqHPLeHIHeY2NQcOR2B0yho/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R8hcqKPA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707553525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XtNoNPhPYS5y1EwYz+Bl0Y1o61/cIUgu8DRvNvKo0a0=;
	b=R8hcqKPAhHhkXtJfbBk5ursD/cI8Kztijr8EcN3g2MyBZapHUDNrEiPJv8Kzhr3snDk13G
	558saxretFUYaVUjeCbo7ndPEOnjAzwtz8nhOXhw41AfaSYtGBzmXgQQgWXkAcCMdt9C25
	pUfUIzQXY1iJBng6FIxb81b6wgFgW9o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-HA0I5VR3MlmvGmlo5qaOUg-1; Sat, 10 Feb 2024 03:25:23 -0500
X-MC-Unique: HA0I5VR3MlmvGmlo5qaOUg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33b6fe7f46cso85383f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 00:25:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707553522; x=1708158322;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XtNoNPhPYS5y1EwYz+Bl0Y1o61/cIUgu8DRvNvKo0a0=;
        b=bUMiHWicfy/KOGPpP+BdS5VjsMUIsSRWWXJDQ2Hvb8n7TMabgE+JrIKd3/rO1cTwRc
         ZlB8TbsuLOZq2aSk4zxNGcTZQe1CSXzfGs/OY6dkNHBwqzJpbR3Krkh4QmcSsWuI5ZuH
         X4sc5EEClCwj1aAlP4y1HVdZVjfIC3SvWLwP++eB+zM8uucugWei7PGWzCijCWamMk7Q
         DkFck9XCvcISDH23jzfb8CQ8YxTl/06n9eifKDf0SFihEqS+4mEBSswxBZ5zpFsV2Hdd
         gU/YFf0NiaHIEa+k9XzbokiR3JjwJyrY2WGRE+2GAJrmJ3giT/vIlrnWkbFXxj1FCKrE
         GQng==
X-Gm-Message-State: AOJu0YyxfNzQnfu2+gw7U0hm3TmZAhTGMHWsQb0I8556/YPXoEOkQhLL
	ICt5D2PqRlGmERFPKvbGLGrWi9Z7X0fUt00IJD1I5Vl128RF9NIE6q2XexyNVC0pjOVvQ+6NkNU
	p9AmUcA1emdSth3KxIeObkRaWZkPkjVBnNU0tuyCkwUs4rxXHiF3KLT1s7L1o9A==
X-Received: by 2002:adf:e950:0:b0:33b:586a:4c3e with SMTP id m16-20020adfe950000000b0033b586a4c3emr3455659wrn.1.1707553522720;
        Sat, 10 Feb 2024 00:25:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJ/IAYSjqmfgt/oW+M+ddPhNyZ7MQ4Pa8g7/5X9ZmBQ0TfhYi7HTRZXo571jhFWeQyinZEXA==
X-Received: by 2002:adf:e950:0:b0:33b:586a:4c3e with SMTP id m16-20020adfe950000000b0033b586a4c3emr3455649wrn.1.1707553522439;
        Sat, 10 Feb 2024 00:25:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVAf6lA5eNBQS0f4Fh4tq/bLVNx44ZDbEdh9Sofz1JYJ0wd9Rt85BZ3cGJirupBieMTpoTfWx0e5bfInujgybluyAMs1uwvO8Yg7jmS+NrPSzzKnextK3Jmd52h0UAqt1HDiVIZ6y83hrMqrOTm7DWUd2k7jSOJ53Q1snF6r1vA4QuExHSoFTzuciXiMQ1/hwA3qbRK4WiBgRsZk5S6wie0KbmAGJyv74BkjUE2Efm9uRt6iXWPGMOh7ZmOO00GL0g3oFdpCTBQ9RAUFT7MXzC28tGnbi5KGkwDBTvU2q+/rBTkjD8Ezdz7fb63GvhCXTpLi27r
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id y12-20020a056000108c00b0033b40a3f92asm1247781wrw.25.2024.02.10.00.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 00:25:22 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Geert Uytterhoeven
 <geert@linux-m68k.org>, Thomas Zimmermann <tzimmermann@suse.de>, John Paul
 Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Sam Ravnborg
 <sam@ravnborg.org>, Helge Deller <deller@gmx.de>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] fbdev/sh7760fb: allow modular build
In-Reply-To: <20240210053938.30558-1-rdunlap@infradead.org>
References: <20240210053938.30558-1-rdunlap@infradead.org>
Date: Sat, 10 Feb 2024 09:25:21 +0100
Message-ID: <87cyt4u3ny.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Randy Dunlap <rdunlap@infradead.org> writes:

> There is no reason to prohibit sh7760fb from being built as a
> loadable module as suggested by Geert, so change the config symbol
> from bool to tristate to allow that and change the FB dependency as
> needed.
>
> Fixes: f75f71b2c418 ("fbdev/sh7760fb: Depend on FB=y")
> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Helge Deller <deller@gmx.de>
> Cc: linux-fbdev@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> ---
>  drivers/video/fbdev/Kconfig |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


