Return-Path: <linux-kernel+bounces-92018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8538E8719D9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B1031F214EE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26195339E;
	Tue,  5 Mar 2024 09:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GLYhEu1+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D52F10A1B
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 09:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709631992; cv=none; b=SoBh/ovNTVUkC332CPCeLV6ZltQYm7ahloG+hQp40PzPX4umiDHftgdhA16f4kOJdm0eu0fc/jB/ErUPJb+dVVe0g4VxPvAtcXP1FDVwy7MM08pEh3Wb7YNUG+DHOCW2X7BA8Lt9WwkcJ54rruMfyRFB5p7e40BAphB4aFGd7ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709631992; c=relaxed/simple;
	bh=j5Pt77CTd32TV8V7ZreeJ0uz8eAWYRbZtaIoc5KmXBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QNEVmcO+yWdY7cE4Ij7H0Mof9T5fD/Ic1TVnQwk2mD7ow1Nys1gZxNc5Rnxsd8GeywtUI+oJmvNfu4JsJLR5PiMlNnE+tG2fq/ZXB24BT45nOMQz8eUig6aLKGt71CA4pUyU4mSv/5NArRLLkK1FJ2hzFWWtD/vSEsvwhpR/hB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GLYhEu1+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709631989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qlPaL+1qbcMigBEz3qx7ZtCPheah+YYYXpFOCWieYr8=;
	b=GLYhEu1+hME+iqok95p+rtcKGdoOo1Irig4gUSqYV02/yb8r0EBnoHBVbS/knD3nndbDdH
	txk6p6XL8JVxXhTXOco3ZgxULty7z9FkMEyXPLOF3Ol8HplwFo6ZtB8cRaEU0IJN77Ad+c
	a85YvFfsH/4ED56hezk2fcwTcHoCyE4=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-g4k60Z-VPdyANI5Uv64S9A-1; Tue, 05 Mar 2024 04:46:28 -0500
X-MC-Unique: g4k60Z-VPdyANI5Uv64S9A-1
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-4d378b792ebso2342891e0c.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 01:46:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709631987; x=1710236787;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qlPaL+1qbcMigBEz3qx7ZtCPheah+YYYXpFOCWieYr8=;
        b=SVJELeyy+eRq30T2Z1w7Ewng6V+DKaxywZNAeG01Jjwh5kpscUwPCcbK9e7wnmJRpT
         2u6WnNyA0orKSbjtWpF5jO1tnM4a9qNQi0K3wfULZCZb3wUrtJWGddNK39pQ1vRK4wwy
         rpYPAp5xmalphRk/aYxfIdoX1z39Wp2W/JmRD4wmwMw+MvCIv+rlPpDG6wiKsNW3pEBa
         B4kTy7qs33p01xLnSMvj9xeQtvknQfy7cygP1BoTI+kvPcQvq01zppFbiH44iGyXVJnn
         F/mts6DlkbQPHl8eRaAD7zk5RwJcdWzACeSwkDAlSn3WbEeyi1Sgb/4vz8ZXXV+v7Ref
         jPUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrWVOfc6zkEarW0dnH6ZJkWoMIygQPIDRsRpqRUZh2/B46/GKQ7UJSNg+l5w2TU9TP+IJUID2BSFkaojF/1lF9tVca7ycEVTzlQPsL
X-Gm-Message-State: AOJu0YyHTRQWnx5YHHdX04jA3uzpBWl+017Y/kgugq89172nCmrrC/5x
	qAcrlSP7rtMPkmP5eK9zkxM8nMk9TsGLtsJUFfB3zoBl4A73RZV6q0qv+qSxlWxHkl/LVWEoCP1
	NkiXklyxPUWatPGd+wx01l/eaxif10zcGeOVJAAIlz86IdlbaXUEmhbmco+22rQ+f52ztkA==
X-Received: by 2002:a05:620a:5e13:b0:788:33ec:d8a8 with SMTP id xz19-20020a05620a5e1300b0078833ecd8a8mr2119013qkn.19.1709630320804;
        Tue, 05 Mar 2024 01:18:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFL7ZlquCoZ60Snk3iqt0FcWv+4rmgyNgIzTovW4+l2TWmVx4HZr2FQyZGXyzR6Vzz7p4retg==
X-Received: by 2002:a05:620a:5e13:b0:788:33ec:d8a8 with SMTP id xz19-20020a05620a5e1300b0078833ecd8a8mr2119001qkn.19.1709630320559;
        Tue, 05 Mar 2024 01:18:40 -0800 (PST)
Received: from [10.32.64.131] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id bp9-20020a05620a458900b0078812f8a042sm3635157qkb.90.2024.03.05.01.18.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 01:18:40 -0800 (PST)
Message-ID: <deaeaceb-bfb0-4dbf-b800-b0debfd3bac9@redhat.com>
Date: Tue, 5 Mar 2024 10:18:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/nouveau: fix stale locked mutex in
 nouveau_gem_ioctl_pushbuf
Content-Language: en-US
To: Karol Herbst <kherbst@redhat.com>, linux-kernel@vger.kernel.org
Cc: Lyude Paul <lyude@redhat.com>, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org
References: <20240304183157.1587152-1-kherbst@redhat.com>
From: Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <20240304183157.1587152-1-kherbst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/4/24 19:31, Karol Herbst wrote:
> If VM_BIND is enabled on the client the legacy submission ioctl can't be
> used, however if a client tries to do so regardless it will return an
> error. In this case the clients mutex remained unlocked leading to a
> deadlock inside nouveau_drm_postclose or any other nouveau ioctl call.
> 
> Fixes: b88baab82871 ("drm/nouveau: implement new VM_BIND uAPI")
> Cc: Danilo Krummrich <dakr@redhat.com>
> Signed-off-by: Karol Herbst <kherbst@redhat.com>

Should add a stable tag for that one, otherwise:

Reviewed-by: Danilo Krummrich <dakr@redhat.com>

> ---
>   drivers/gpu/drm/nouveau/nouveau_gem.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_gem.c b/drivers/gpu/drm/nouveau/nouveau_gem.c
> index 49c2bcbef1299..5a887d67dc0e8 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_gem.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_gem.c
> @@ -764,7 +764,7 @@ nouveau_gem_ioctl_pushbuf(struct drm_device *dev, void *data,
>   		return -ENOMEM;
>   
>   	if (unlikely(nouveau_cli_uvmm(cli)))
> -		return -ENOSYS;
> +		return nouveau_abi16_put(abi16, -ENOSYS);
>   
>   	list_for_each_entry(temp, &abi16->channels, head) {
>   		if (temp->chan->chid == req->channel) {


