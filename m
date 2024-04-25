Return-Path: <linux-kernel+bounces-158735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EECD48B244A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4CD5281F72
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C52D14A600;
	Thu, 25 Apr 2024 14:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UrUamniA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A716514A605
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 14:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714056314; cv=none; b=Eun4NoVFYMvPYNtSGtyvhHF8v8PFO1yN+d4FeOiUJbTLInP/D0gnycMF8UQMb4hi1TaIKV+oMKDHbMlfeGSpQAgSC8gwf2yVUcqUGi1hQ2vzLX5+eMURyrQzqsZ9E94MA/uD6iqf9xVLIqVUny3allYEj/ioyMCElNdgfQdCZTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714056314; c=relaxed/simple;
	bh=t3L626GQK5+C8xYKwo/jgNN4prZo8bdv5XDJYAotQcM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aA+V2jfzyO130dBGq7WIhf12fe1LdvBfQb04l+427UnVXnxKcSAps+9csoAB2EzFVtaoUEfnOvA/WNX/tWjGnvW47K8AMLnt+Zkboc5ApRY5J+/tlcSga26Fg/ua8ynfWvg8mvyqk4bfZsDIjmvsMaOaKey/0q/9UBJLkC4dNww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UrUamniA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714056311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZubHCtXDSlDiNjtbhlVfa47NJZTf/QQgEF9HNNRnrpc=;
	b=UrUamniAjxHgDo19E4Ic7F7/8kQgwjqgLNLY+m8OQoua4XW6EQHAhEF0x8FW3un7ddC+BX
	doZuB3LR1169ixHIs6IWrBh1EJ9QeMG6HTUj+vFnhB5IQqkrJt6R1uu4gVl39wiuSVOR+u
	OpEuCDhp6GW26CrgKmK4wcV+PFXiUs0=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-vFVO9z9ZMAGLjKHC3uKScQ-1; Thu, 25 Apr 2024 10:45:09 -0400
X-MC-Unique: vFVO9z9ZMAGLjKHC3uKScQ-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2dccd9dee76so9512261fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 07:45:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714056308; x=1714661108;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZubHCtXDSlDiNjtbhlVfa47NJZTf/QQgEF9HNNRnrpc=;
        b=jwUM/SbWRCkqSjJQEU0OQg5ahacejTVKId6zRSL15NCrsb0qDmWvjbxzj07sP6ol5M
         QHeU0bWoJGnIxzFElxYRYmmzkGc6Te7w1dW5kcmwU6I/03IMoG5N37mye7Yy0RgievEZ
         iJZqedtx34z84oFdeXiyCgAPuOMCY/AkjN5A/X4JJZMBDSwpd8Yp3J2DBBlRfJK8LKhq
         hIMaiKBRI9lkODmwQi3Rz/eWvJ3eK4h/ifFS1uEkYL+K0qnREaXiG8O8U75FtnO/ya8L
         EbkvOuq95ZUknq1/+4Jz8HZfOkWk+BU6LiCwnV9jHfgyHtmchc5obNm7hE5uYU0ZgzGa
         aEIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXybpqdB0NL6+CyK+cjBpZttQTlOMKEK41rgfp69CK65AoT9I26BNBk3r7uQyvY/IwZZR+Df75ZQlzYyWwizURlb9pD/Mif15olq6Q+
X-Gm-Message-State: AOJu0YxhxgdUHje4U+3Kc6X3U78/BdeTDYlS1vYk66+YcZAc2H6vf9U6
	/M17gtmGUvikGJEOcSbuq/rTBdwx+2RVvb7p5rN/vRWAvCDg2zM+F6PD5izo9BTX2pvfW66+5rH
	lCV4/BhhyZieKlFhICeU8eVUmozJfgrXZKN6Tc2KgbffUs7WNQIxbqd7AZt6s7w==
X-Received: by 2002:a2e:8346:0:b0:2da:bbf4:81b8 with SMTP id l6-20020a2e8346000000b002dabbf481b8mr3523045ljh.14.1714056307861;
        Thu, 25 Apr 2024 07:45:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2uHszwgcgWYNWC1sA6fA2CDpWKf9lvVT0t3YBkpRT8qSW7BlgzlOt4c00AAdz79TQEB56HA==
X-Received: by 2002:a2e:8346:0:b0:2da:bbf4:81b8 with SMTP id l6-20020a2e8346000000b002dabbf481b8mr3523014ljh.14.1714056307207;
        Thu, 25 Apr 2024 07:45:07 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id v11-20020a05600c470b00b0041a963bf2cdsm11668719wmo.36.2024.04.25.07.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 07:45:06 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Steven Price <steven.price@arm.com>, Andy Yan <andyshrk@163.com>,
 boris.brezillon@collabora.com
Cc: daniel@ffwll.ch, airlied@gmail.com, liviu.dudau@arm.com,
 maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Andy Yan
 <andy.yan@rock-chips.com>
Subject: Re: [PATCH] drm/panthor: Add defer probe for firmware load
In-Reply-To: <501d18c9-3116-4cd1-8091-b9f552e9fb5a@arm.com>
References: <20240413114938.740631-1-andyshrk@163.com>
 <54e4a174-dea7-4588-b8a6-0310c210ffce@arm.com>
 <87frv9zthu.fsf@minerva.mail-host-address-is-not-set>
 <501d18c9-3116-4cd1-8091-b9f552e9fb5a@arm.com>
Date: Thu, 25 Apr 2024 16:45:06 +0200
Message-ID: <87y1918psd.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Steven Price <steven.price@arm.com> writes:

> Hi Javier,
>
> On 25/04/2024 10:22, Javier Martinez Canillas wrote:
>> Steven Price <steven.price@arm.com> writes:
>> 
>> Hello Steven,
>> 
>>> On 13/04/2024 12:49, Andy Yan wrote:
>>>> From: Andy Yan <andy.yan@rock-chips.com>
>>>>
>>>> The firmware in the rootfs will not be accessible until we
>>>> are in the SYSTEM_RUNNING state, so return EPROBE_DEFER until
>>>> that point.
>>>> This let the driver can load firmware when it is builtin.
>>>
>>> The usual solution is that the firmware should be placed in the
>>> initrd/initramfs if the module is included there (or built-in). The same
>>> issue was brought up regarding the powervr driver:
>>>
>>> https://lore.kernel.org/dri-devel/20240109120604.603700-1-javierm@redhat.com/T/
>>>
>>> I'm not sure if that ever actually reached a conclusion though. The
>>> question was deferred to Greg KH but I didn't see Greg actually getting
>>> involved in the thread.
>>>
>> 
>> Correct, there was not conclusion reached in that thread.
>
> So I think we need a conclusion before we start applying point fixes to
> individual drivers.
>

Agreed.

[...]

>> 
>> In the thread you referenced I suggested to add that logic in request_firmware()
>> (or add a new request_firmware_defer() helper function) that changes the request
>> firmare behaviour to return -EPROBE_DEFER instead of -ENOENT.
>
> That would seem like a good feature if it's agreed that deferring on
> request_firmware is a good idea.
>

Yeah. I didn't attempt to type that patch because didn't get an answer
from Greg and didn't want to spent the time writing and testing a patch
to just be nacked.

>> Since as you mentioned, this isn't specific to panthor and an issue that I also
>> faced with the powervr driver.
>
> I'm not in any way against the idea of deferring the probe until the
> firmware is around - indeed it seems like a very sensible idea in many
> respects. But I don't want panthor to be 'special' in this way.
>
> If the consensus is that the firmware should live with the module (i.e.
> either both in the initramfs or both in the rootfs) then the code is
> fine as it is. That seemed to be the view of Sima in that thread and
> seems reasonable to me - why put the .ko in the initrd if you can't
> actually use it until the rootfs comes along?
>

That's indeed a sensible position for me as well and is what I answered to
the user who reported the powervr issue.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


