Return-Path: <linux-kernel+bounces-158292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7BA38B1DF1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69D6F284DDD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1CB84FD0;
	Thu, 25 Apr 2024 09:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OtLCn4zr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E641F84FC8
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 09:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714036980; cv=none; b=mf/QLvIKSdZzwWqNRF6ByiiKJNaCY/1XGg2Kh1GLCgFBFL7QbiF7wHcrargm3R4Cl1h/KrDsDZuBbJb0sTD2mx/b/FvjMDJE02GadFcXhXPq4bWslapfj4rP+Xr8Xmj82be1BgRjf/5iyagAj+glDn3GAixyjEbNhUXSkzHv1wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714036980; c=relaxed/simple;
	bh=Lcgg3hvKGEDl4Y9urblPbKPzWGNtZjBouwoTCr4upUM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AZgZyT+QQfL9/koaVvxVpXRmlAx3qjCMTV1/oNstUlejugCoimcSANTTl23cY5yZDrvMNMMl1Lt3tikjour8WKgf4z9y8jkNBwO7+xnCxViPtPHfTCJ++NCR9U5vWLaocXku+R5j6UIvtl0cRCgaVWMh/4Lepwp8/Bd02hSKCF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OtLCn4zr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714036977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AxVOqCleBMDIW/ByJ67k7KAL9izw4KY+nAlh60+o9Hs=;
	b=OtLCn4zr0BTQwF7PvFeugRZtbg+3RA3rW/yeFDoCXwOMgF1vXMXVVPht3uKcHfx4huiPOc
	T9qnBbZ/YsjJKJphVc1ltVZCnWqGyS+Y8Qnay0HylcttxItH31EpgLdE7BpU+AI2VYvId1
	xlxr7ByKN2D4JGEXCcH+pwLPQ9AtWrI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-a88wwS7iPzqU-fdWEQ82pQ-1; Thu, 25 Apr 2024 05:22:56 -0400
X-MC-Unique: a88wwS7iPzqU-fdWEQ82pQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-41ab7cdccd2so3837995e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 02:22:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714036975; x=1714641775;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AxVOqCleBMDIW/ByJ67k7KAL9izw4KY+nAlh60+o9Hs=;
        b=kwRB++TQ68ExXXN7wUFCXH/t9q2JiZHurYdCS53JJ14ljliZZIQ9I8obkzUH6IF11T
         Ia0Qloy3cx2I5AMFE+J7Yz9/ySyORGMrV99fY6RRj8YDOzRdowap2hKAuTRmsPkv18lS
         xfsNQZEzwzpgReL0XVKqYgYD7lByV2GZ9j9+ZHfGoTzkHSF60lC/m65P1TeMnTu7SfiY
         yiuprJj5wO/DfEt5E5EW/Nj6RFhNvBRzS/beA/7czVQOuOptvzHl5lD0GSWkeuHfDEfQ
         etafPnQNFLCLJW8OjQHWwPhogjVFaXbwaB5iuVqDrdXpnaFVndGjM8QcrPsKCuYwt3Ya
         bnng==
X-Forwarded-Encrypted: i=1; AJvYcCVhn8uzzSTCoMAl+k/XE2EihGsyMktHJlZ+H1Hbag6ruCSQovN7rZPXMH0ec5qhMsWEbNGuXF/DXX3odZN798nWbg4pxmUSpifTZka4
X-Gm-Message-State: AOJu0YxKbBSf7TYeYeu+aMSIDiFqo+qXy9/PJEdnbnxUwjzqL76h4SlE
	m1boxso1UuW+Rgix+F+MbgVWYjhcyHSM5vS/AKUO/tzFEJG5mQyRc+lC28EvvaWlbl4ouCd+jbd
	epMgjL2PHckgNnD6OWrt+V422Ij8CKExFR7UrYvB0/QlwMcz2em745QR0y2HuhA==
X-Received: by 2002:a05:600c:a47:b0:41b:4d5d:9687 with SMTP id c7-20020a05600c0a4700b0041b4d5d9687mr783434wmq.24.1714036975230;
        Thu, 25 Apr 2024 02:22:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZx2CGKayPSYRJJU36QaH68kn0admzBOk1wBPDIGabrTkFGgP7cte5hNSk7Msg+eAtqgaAGg==
X-Received: by 2002:a05:600c:a47:b0:41b:4d5d:9687 with SMTP id c7-20020a05600c0a4700b0041b4d5d9687mr783420wmq.24.1714036974803;
        Thu, 25 Apr 2024 02:22:54 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id e6-20020a05600c4e4600b0041b43e301e8sm1716682wmq.42.2024.04.25.02.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 02:22:54 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Steven Price <steven.price@arm.com>, Andy Yan <andyshrk@163.com>,
 boris.brezillon@collabora.com
Cc: daniel@ffwll.ch, airlied@gmail.com, liviu.dudau@arm.com,
 maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Andy Yan
 <andy.yan@rock-chips.com>
Subject: Re: [PATCH] drm/panthor: Add defer probe for firmware load
In-Reply-To: <54e4a174-dea7-4588-b8a6-0310c210ffce@arm.com>
References: <20240413114938.740631-1-andyshrk@163.com>
 <54e4a174-dea7-4588-b8a6-0310c210ffce@arm.com>
Date: Thu, 25 Apr 2024 11:22:53 +0200
Message-ID: <87frv9zthu.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Steven Price <steven.price@arm.com> writes:

Hello Steven,

> On 13/04/2024 12:49, Andy Yan wrote:
>> From: Andy Yan <andy.yan@rock-chips.com>
>> 
>> The firmware in the rootfs will not be accessible until we
>> are in the SYSTEM_RUNNING state, so return EPROBE_DEFER until
>> that point.
>> This let the driver can load firmware when it is builtin.
>
> The usual solution is that the firmware should be placed in the
> initrd/initramfs if the module is included there (or built-in). The same
> issue was brought up regarding the powervr driver:
>
> https://lore.kernel.org/dri-devel/20240109120604.603700-1-javierm@redhat.com/T/
>
> I'm not sure if that ever actually reached a conclusion though. The
> question was deferred to Greg KH but I didn't see Greg actually getting
> involved in the thread.
>

Correct, there was not conclusion reached in that thread.

>> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
>> ---
>> 
>>  drivers/gpu/drm/panthor/panthor_fw.c | 11 ++++++++++-
>>  1 file changed, 10 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
>> index 33c87a59834e..25e375f8333c 100644
>> --- a/drivers/gpu/drm/panthor/panthor_fw.c
>> +++ b/drivers/gpu/drm/panthor/panthor_fw.c
>> @@ -1336,8 +1336,17 @@ int panthor_fw_init(struct panthor_device *ptdev)
>>  	}
>>  
>>  	ret = panthor_fw_load(ptdev);
>> -	if (ret)
>> +	if (ret) {
>> +		/*
>> +		 * The firmware in the rootfs will not be accessible until we
>> +		 * are in the SYSTEM_RUNNING state, so return EPROBE_DEFER until
>> +		 * that point.
>> +		 */
>> +		if (system_state < SYSTEM_RUNNING)
>
> This should really only be in the case where ret == -ENOENT - any other
> error and the firmware is apparently present but broken in some way, so
> there's no point deferring.
>
> I also suspect we'd need some change in panthor_fw_load() to quieten
> error messages if we're going to defer on this, in which case it might
> make more sense to move this logic into that function.
>

In the thread you referenced I suggested to add that logic in request_firmware()
(or add a new request_firmware_defer() helper function) that changes the request
firmare behaviour to return -EPROBE_DEFER instead of -ENOENT.

Since as you mentioned, this isn't specific to panthor and an issue that I also
faced with the powervr driver.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


