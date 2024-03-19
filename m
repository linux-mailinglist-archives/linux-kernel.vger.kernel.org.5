Return-Path: <linux-kernel+bounces-107268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3925587FA2B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84CE2B20BD5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4879065195;
	Tue, 19 Mar 2024 08:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M8hxEtec"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF011E536
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 08:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710838361; cv=none; b=niedRFpqY+xwsqW/MbLKeMQEM9w/2h/oE/haQQOmIVpYznLvu24t4Jrw8fkwgHSed3PEaSW2t7vaMKLJRDs0UD+ynlzQG98plOw7AjtplzOQTxbT92pIeUenFn2vUL+6QgC5ozqWswzS8RYXIMnXMDSWgegPX4DihMWoURYvD0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710838361; c=relaxed/simple;
	bh=BpATYCWHMlDg+lXKRP1ZOVld6HIBGCoWxOXIwEyHUKg=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X7E9MG79nsZGD6LwxjOldPek5fzOQXgolSliu3vHxdi+l6//3y/6Db3Muxeb+CCRCXJ/C/IYkoH7Gge8jgfv4cSPVqS8pHhio+tFJAqgwJAOOQ8bqaie7NaNXi5bplLU8yE8j/axNhdbEIr3aAyal3KkUbA+bmQBtCL5+6qJk+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M8hxEtec; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710838358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LAFBEpXu4T6nIL4CcBb6XaYWpcmzJRFyTet/O4fBErk=;
	b=M8hxEtecNLzq50fkh9k4o14T2dWQfafkCju481os9KtHEDnlR4HSt52Ju9riI21IKgS6OX
	gYpUHqnyEqAc/hcCCtVIsICRfFv5NGvjy8phZiLUcZKshcl6wzuweA3O3+w2Gr1LyrVomd
	gVZit5hUbjwmKqjAQDAnzqVnjJe+1vs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-3J22H1LoNReOjb9-iy2s9g-1; Tue, 19 Mar 2024 04:52:37 -0400
X-MC-Unique: 3J22H1LoNReOjb9-iy2s9g-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33ed71800f2so1886138f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 01:52:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710838356; x=1711443156;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:to:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LAFBEpXu4T6nIL4CcBb6XaYWpcmzJRFyTet/O4fBErk=;
        b=mavFOZEPPSWpXCq0I21lPGZd0g8AxHsrtP39BuvSLhQvD1ifKjR6A5EHGBvZuqpLFW
         47rVt+60tw33ok6JO87ab/NTIEtHI3ep09siGHbiDN/VfcLdeztb6iVcIGsQ284EGxke
         qkYklhb9aKprJ51pogRHTeb9mJ/U1fI89Sk/IxFYgCxZpbe6CgRkqembDX+MyPP//ZFp
         Mnt2HPi9zjcs+VtdArh+O1vhKelthQ5Pe34XoRH9BU5aQKD078XNa7mM56STHDrkwcac
         nc/1TUrGTxZszbTOWR96sAbLhf5GlfIfb3fNvSfQHRkY/tPzb+xMwprm6skPkexV34FI
         TrfA==
X-Forwarded-Encrypted: i=1; AJvYcCWqzvZpiZFjIp0RIhEMEn5StQYhcp3oJqX/t+wZlTlQ/bWutMr56VHtwVzIP05W3hqzArznQYVeWTORdduKxKSpCQwY8v6ITZ/ysmRv
X-Gm-Message-State: AOJu0YydxZiag9Q33ZJ4t9N9Fl0+ZZsaK0qiCQ40ifw235+tmun/3Goy
	MEsxdDTdzDtMVrKHAF+trQpxQb2KOoerJnXrRiDqLbWIbLGMNaGjs/yIZsrZYGM1pgPUypmP4wr
	OmZjopOacnyhC6rIuUVmY1WKxLqOn6nYYjmfoZujjBLquRtuaEJTmAR1ih8Ychw==
X-Received: by 2002:a5d:400e:0:b0:33e:7650:1297 with SMTP id n14-20020a5d400e000000b0033e76501297mr1180592wrp.6.1710838355896;
        Tue, 19 Mar 2024 01:52:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEviy2BfD6h1n7GQIr/ySZRIA5TMsVkUat79nA6OyGDi7lEfv/1uq9WRg7/G+zkox+G3WNbig==
X-Received: by 2002:a5d:400e:0:b0:33e:7650:1297 with SMTP id n14-20020a5d400e000000b0033e76501297mr1180574wrp.6.1710838355482;
        Tue, 19 Mar 2024 01:52:35 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bo6-20020a056000068600b003418016b04csm2954367wrb.76.2024.03.19.01.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 01:52:35 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, Mehdi Djait
 <mehdi.djait.k@gmail.com>, daniel@ffwll.ch,
 maarten.lankhorst@linux.intel.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: drm/tiny: QUESTION: What to use instead of
 drm_simple_display_pipe ?
In-Reply-To: <da7cfff1-e147-48ea-bcda-9ea913e5feee@suse.de>
References: <ZfiTbYAa7qxXlrPd@mehdi-archlinux>
 <da7cfff1-e147-48ea-bcda-9ea913e5feee@suse.de>
Date: Tue, 19 Mar 2024 09:52:34 +0100
Message-ID: <87o7ba1u3x.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thomas Zimmermann <tzimmermann@suse.de> writes:

Hello Mehdi,

> Hi
>
> Am 18.03.24 um 20:18 schrieb Mehdi Djait:
>> Hello everyone :)
>>
>> I am implementing a tiny drm driver and I am currently working on the
>> V2: https://lore.kernel.org/dri-devel/cover.1701267411.git.mehdi.djait@b=
ootlin.com/
>>
>> I got a review on the v1 telling me not to use the
>> drm_simple_display_pipe. Can someone please explain this further ? Or
>> give me an example drm driver that does it the right way ?
>
> You can copy the code from drm_simple_kms_helper.c into your driver file=
=20
> and start inlining everything. For example
>
>  =C2=A01) Your driver calls drm_simple_display_pipe_init(), so you copy t=
hat=20
> code into your source file
>  =C2=A02) drm_simple_display_pipe_init() uses drm_simple_kms_plane_funcs =
and=20
> drm_simple_kms_crtc_funcs, so you copy these into your source file;=20
> together with the drm_simple_kms_*() helpers that they use for their=20
> callback pointers.
>  =C2=A03) Mayb do this for other drm_simple_kms_*() code.
>  =C2=A04) Then start inlining: inline your copy of=20
> drm_simple_display_pipe_iit(). Instead of using=20
> sharp_ls027b7dh01_pipe_funcs, inline its functions into your copy of the=
=20
> callers. And so on.
>  =C2=A05) Rename the resulting code, so that it fits you driver.
>
> With careful changes, you 'll end up with the same functionality as=20
> before, but without the intermediate layer of the simple-KMS code.
>

On top of what Thomas said, you can check 622113b9f11f ("drm/ssd130x:
Replace simple display helpers with the atomic helpers") that did this
change for the drivers/gpu/drm/solomon/ssd130x.c driver.

The driver is also for a monochrome panel controller and it does support
SPI as transport, which means the controller is similar to yours in many
aspects. You could use that driver code as a reference for your driver.

> Best regards
> Thomas
>
>>
>> --
>> Kind Regards
>> Mehdi Djait
>
> --=20
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Frankenstrasse 146, 90461 Nuernberg, Germany
> GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
> HRB 36809 (AG Nuernberg)
>

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


