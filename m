Return-Path: <linux-kernel+bounces-156918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3800A8B0A58
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B972A1F24374
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C41C15B133;
	Wed, 24 Apr 2024 13:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OriySXip"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6077546435
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 13:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713963815; cv=none; b=Hm7TDLgevT5e4rpytxdaTwmHOrtj4rGkurBoBYZs9De9ej9G/FSnq2tEQjpIT+RdFbRNf5t3eQKWrycqCZDZG/9OWwPhsT9R+2R5XMcIcILY166YQyHafs3REn7h0oAL7UwwUX89cJNNkwoCTO6hMoNEnZw/YENDa7OyR6PFp4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713963815; c=relaxed/simple;
	bh=9Vw3QsSN9MtG+Q8HObd3p3koDa2c+pw2/PkCfEYrGi4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fHvWaSclhTAk25X0e++H8v2Dy5QSQZpbWqIaETmDodLnftgoYgPU9M/xV8YIWDugG/hHEtUcFJxZB0LlNnCaNVaTJu7B3JJUkSZrweBi3MD8034ejHpHcxcca9NDCDEW3bzYfCSCsS7hP+cIfwgRXgH1PSnyqTCwWrhdBbP9b9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OriySXip; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713963812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RaV3IArlUv54xMzfpCp75Zf5kU8oPtgFZOhgzTbc6L4=;
	b=OriySXip3+NB28jI4LUFV4w2bvEbsOJ590K8mHKOFxpoj7DY0hijIbec+xnGnVMqZowQ+M
	WDfdE5WS9+1bgdsYuFMzbxFmvEqA8r2JrIB1eP3Q/jdTJutdrjeLyLoaKpNW507cWt1ktC
	Eyy6zzG7hhuEqkZIUK9zPePepe4dnF8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-1KweKocYM32Gh14YGP1mBQ-1; Wed, 24 Apr 2024 09:03:30 -0400
X-MC-Unique: 1KweKocYM32Gh14YGP1mBQ-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4347271f444so72182631cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 06:03:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713963810; x=1714568610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RaV3IArlUv54xMzfpCp75Zf5kU8oPtgFZOhgzTbc6L4=;
        b=queHXhwZ05erVq4+PA2WFuk+w8sY5QM85tPEwbO4psYNtU4FlgriOlu7GdVw/oLdP2
         ms+dR/OfjRJMOw+O87XfBIw3Kc+bw9ebvuuF6B7EURKVcu6A0SqRCNqfxFnBgpxDpTun
         5wELFWbge0CmeiCj+CWh3Nqwyr8NqeMS2di89e3tU3MNKKObVhYHq4mx30qugerIAc7L
         3ns6c0f9DzrjwewGVQ4HrlcEfnz/aZaYel4rK8O1lcMkKylFcoK7PaJ+rZm+bFXTXOKQ
         23FD2KuvIKl+4FTpY9tcnq7dE2WPue/iEwaDUJYIj0SNAJLKXFaCQQQvcGc5MtPpFStC
         s6/g==
X-Forwarded-Encrypted: i=1; AJvYcCUopbqI5J4xCfqt30yTqPCccgjiUJzUyDKUqrFQoD03lFRRQvDJgdGbq8xufnpct69G5wTW0I7Fo7KhysbWzowwrRWCqcLOhup1gkKw
X-Gm-Message-State: AOJu0Yz9iqRA2WbEsHZOcSeSJFte3pUL38asIpQxIX7YHaPGWTjhn7bo
	FhK/h0VEgMe7luyc11njHq+b6yv6qOutqlVtdHGENXaKc95FPMfLnvnNgN1nXMbnFtaMF3CQ3XK
	9+LxRl9iTzRknNV2zEzyIijEsI1A9IfBzlNcTKI2CNOvGutFNKWkZbMwlzpGOcboRiakZdXhSbu
	IGJxZPpVAa04rqx/SNIR6q7nFWjBD+ydlMloo9JugVkm1z
X-Received: by 2002:a05:622a:2998:b0:439:e722:1923 with SMTP id hd24-20020a05622a299800b00439e7221923mr2473836qtb.35.1713963809842;
        Wed, 24 Apr 2024 06:03:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6udTZN9HoEjIdODs1JhGOU4VWnBeQOkmX6+2ZVLMzs0E9kEXmTBXlyxDebJcR95prOQoRgnbVHMjUCuFNumw=
X-Received: by 2002:a05:622a:2998:b0:439:e722:1923 with SMTP id
 hd24-20020a05622a299800b00439e7221923mr2473812qtb.35.1713963809572; Wed, 24
 Apr 2024 06:03:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424090613.2630952-1-korantli@tencent.com>
In-Reply-To: <20240424090613.2630952-1-korantli@tencent.com>
From: Wander Lairson Costa <wander@redhat.com>
Date: Wed, 24 Apr 2024 10:03:18 -0300
Message-ID: <CAAq0SUmJsuns4_wJ155+Gnj-a8WmXhzptsrCiz7+=HjKiFKQ0w@mail.gmail.com>
Subject: Re: [PATCH] drm/qxl: fix comment typo
To: Xinghui Li <korantwork@gmail.com>
Cc: airlied@redhat.com, kraxel@redhat.com, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Xinghui Li <korantli@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 6:06=E2=80=AFAM Xinghui Li <korantwork@gmail.com> w=
rote:
>
> There is one typo in drivers/gpu/drm/qxl/qxl_gem.c's comment, which
> 'acess' should be 'access'. So fix it.
>
> Signed-off-by: Xinghui Li <korantli@tencent.com>
> ---
>  drivers/gpu/drm/qxl/qxl_gem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/qxl/qxl_gem.c b/drivers/gpu/drm/qxl/qxl_gem.=
c
> index fc5e3763c359..2cfe29d72d81 100644
> --- a/drivers/gpu/drm/qxl/qxl_gem.c
> +++ b/drivers/gpu/drm/qxl/qxl_gem.c
> @@ -74,7 +74,7 @@ int qxl_gem_object_create(struct qxl_device *qdev, int =
size,
>
>  /*
>   * If the caller passed a valid gobj pointer, it is responsible to call
> - * drm_gem_object_put() when it no longer needs to acess the object.
> + * drm_gem_object_put() when it no longer needs to access the object.
>   *
>   * If gobj is NULL, it is handled internally.
>   */
> --
> 2.39.3
>

Reviewed-by: Wander Lairson Costa <wander@redhat.com>


