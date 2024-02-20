Return-Path: <linux-kernel+bounces-72725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B56E85B7FC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27BB3286839
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9A460861;
	Tue, 20 Feb 2024 09:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gBtdL0sv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032385BAFA
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 09:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708422206; cv=none; b=H6EQoEKbRPsTHZiposdxjMK9If1Uq/CcDzGB1B4RvIZvHfIB6cqFE5ijZ+66w95a+Jk0rZY6xNKiMP7J54cO+h5STMa6IEUDzPGZNUnV/qkM+2zgWy5NUGGj43F7cVldlxwLindQAqQEp+2lPo10JAuLbKqV5uR7wjnf6XzMNns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708422206; c=relaxed/simple;
	bh=D0Yo5x/4MfZWsJXiUKOIvYZcHzyTT/XtYOAf0/Z82rA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s2ZsmBrgtZb0LNO3g9Vtyg04a9tWsyC0RWehp48HVFbkI3F0NuCvEBaXn8D7CNypi36FKd6lrGOlSxrdNullkU8n+2iqZdklcOW4OaqqBxMvH23ptRVABU9AWbBz/v1O0ka5jDwJlS9PUyznYkT1lxmc5kCuWh0JNwCA2JRTqk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gBtdL0sv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708422203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d0/eBVPARKg7uLoz7RJuNF4kAD5bZj3l8nX7PR1I690=;
	b=gBtdL0svQJQSAUKeJmjopNK1MDIWjWjxqHZoQC+rtdpqtGrdHw7qidYy//gwvK7oLmkIjj
	65Fuw2/VtAOWxvikcgi+uKbzWzEfwvPztbc9HHaU9hLg2Wur+ngIb6hieZM7BRdxKGIlj/
	n6oBXH9IXijbgJQQ/TkMVaEmNsqpctc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-kodXUa3hPbG79N18a9SLrg-1; Tue, 20 Feb 2024 04:43:22 -0500
X-MC-Unique: kodXUa3hPbG79N18a9SLrg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33d1d766f83so1255604f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 01:43:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708422201; x=1709027001;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d0/eBVPARKg7uLoz7RJuNF4kAD5bZj3l8nX7PR1I690=;
        b=p/QWFAot2YRvD8ZzhXJuavpTI+7hPQNz8CR5UOarKoP3KMdvbSsPWC2CjAUGCCOxlN
         4f5wxSsFBJnD5kfJi7cZXKJxQONJfWocyMaT235xmZXn3poyJeCG/j6ejmU1BYXuozVp
         29LJD6Wo9EVmXW6z4lu9x37a0lBsn8/WvbMD3fctmkFT9TlphSMmSQPxo380WmuBwrI7
         iPp+lL7XMKc65me5GiLYGLSf+/9L0Zlimu9OHWeXZlEBDezSuDMnTtlUON10byDHGcIq
         YgbxlyaKfS/BG05ISU/3w2U3tbtDCqcn+lBHTgmVlwiLPn3cespeBSk0JP/X+/i0RAn2
         wdGg==
X-Forwarded-Encrypted: i=1; AJvYcCX03gX1F6hKZ9TJfz1BVuNqFhHuGlZSM82sVxNaaF6mIQ0OlJ7rwSG/hsye7L1FClulnTGdGCvu4sXcjzN5AQ+MAPGcHwo7LKEY5lch
X-Gm-Message-State: AOJu0Yy/FEuAApbHEGypHaO40w/v8rzp6hHfyut3FlDcUssLVr2PTctF
	8pafx40dWKt1BNGrUXHMdLAIAb1AJMne8cZvutLPWIidpWenOiqPBTz36RAApjW7PxOejuedRv/
	oFO79jcNE2+vQTPcG2RfS7z+QTxsdYsXVhXDYwq895y79D/5SNQeOOcJFVG+94A==
X-Received: by 2002:a05:6000:a18:b0:33d:3a02:8362 with SMTP id co24-20020a0560000a1800b0033d3a028362mr7878948wrb.70.1708422201297;
        Tue, 20 Feb 2024 01:43:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZ/M2FosjgjQmTAsSXTDdWEs4CliCEKwrB2i44K78RB/mTHLapK6fGxT2mIST6MolghceDqQ==
X-Received: by 2002:a05:6000:a18:b0:33d:3a02:8362 with SMTP id co24-20020a0560000a1800b0033d3a028362mr7878931wrb.70.1708422201005;
        Tue, 20 Feb 2024 01:43:21 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m17-20020a5d4a11000000b0033cf4e47496sm12805118wrq.51.2024.02.20.01.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 01:43:20 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org
Cc: kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
 Andreas Larsson <andreas@gaisler.com>, Arnd Bergmann <arnd@arndb.de>,
 "David S. Miller" <davem@davemloft.net>, Helge Deller <deller@gmx.de>,
 sparclinux@vger.kernel.org
Subject: Re: [PATCH] sparc: Fix undefined reference to fb_is_primary_device
In-Reply-To: <929a159f-f6dd-49d3-b6b5-70ab7450ab19@suse.de>
References: <20240220003433.3316148-1-javierm@redhat.com>
 <929a159f-f6dd-49d3-b6b5-70ab7450ab19@suse.de>
Date: Tue, 20 Feb 2024 10:43:20 +0100
Message-ID: <87h6i3ii87.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

Hello Thomas,

> Hi
>
> Am 20.02.24 um 01:34 schrieb Javier Martinez Canillas:
>> Commit 55bffc8170bb ("fbdev: Split frame buffer support in FB and FB_CORE
>> symbols") added a new FB_CORE Kconfig symbol, that can be enabled to only
>> have fbcon/VT and DRM fbdev emulation, but without support for any legacy
>> fbdev driver.
>>
>> Unfortunately, it missed to change a CONFIG_FB in arch/sparc/Makefile and
>> that leads to the following linking error in some sparc64 configurations:
>>
>>     sparc64-linux-ld: drivers/video/fbdev/core/fbcon.o: in function `fbcon_fb_registered':
>>>> fbcon.c:(.text+0x4f60): undefined reference to `fb_is_primary_device'
>> Fixes: 55bffc8170bb ("fbdev: Split frame buffer support in FB and FB_CORE symbols")
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/r/202401290306.IV8rhJ02-lkp@intel.com/
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>> ---
>>
>> I don't have a sparc64 toolchain to test this patch, but I'm pretty sure
>> that this is the correct fix for the linking error reported by the robot.
>>
>>   arch/sparc/video/Makefile | 2 +-
>
> I think you also have to fix arch/sparc/Makefile.
>

Oh, you are right! Thanks for pointing that.

> Best regards
> Thomas
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


