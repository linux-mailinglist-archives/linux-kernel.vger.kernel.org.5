Return-Path: <linux-kernel+bounces-91181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4FA870AB8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D18A1C21CD0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B797B79DDE;
	Mon,  4 Mar 2024 19:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WUM/5z2h"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F70D79DD6
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 19:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709580615; cv=none; b=URxsY2zAOeAr3KinHIUKv+nsf7ROw6LblsX7gXZIynbsvy1gY9S6qK2nUf9qljk7DpwJkmMwLsXEu5F7Qv/tGd1aWRXgMTI1YXzzXuCD+jVbrUkHeRCtXqhWetdRqv3+QbpREBl6L3oV+mydEGnIiX2NvS3fUU4tcDr3ekdPAEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709580615; c=relaxed/simple;
	bh=N0+dVA/LrZJxmJ2LqiDpPOLemlHNFaSbv/OgoIwc3rU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E2nQ9zTwB6cUBqbCxSDjA2tW9CXrrJqfp43coZIUGoC2gLR/6TF6reYKlbtm37CDvv0suJYJK67QwrCGXbudxYD7AiTK74O/C/exrCay+bZSyFmx68OiEThuQlVNVn7IZtbfUx2+pqO+hc7ED64jrP77iFjmd/aVLFdHRhD1Lmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WUM/5z2h; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709580612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eZiRoNZpJWWKK/cOdoxLY/19xwv2y7y2vYTfMraz1OY=;
	b=WUM/5z2hiMevmyvHtx/KJb4GWS+Yk6/OJE39Ung6QOt/w+tXHkM48ow3BbuoNWuTTgu80m
	8yAzsW/wMOS6wchp33/x08xNIJDHfAG6da9suJFiUpLw74Fpk7avbrMEdP3rqXSFiq5mRn
	o7dVughFMlW6R41Nu+zoAvxMWO0sSZg=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-T1uQzw1pPLycaiypK-qdqA-1; Mon, 04 Mar 2024 14:30:11 -0500
X-MC-Unique: T1uQzw1pPLycaiypK-qdqA-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6903611eef7so73681146d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 11:30:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709580610; x=1710185410;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eZiRoNZpJWWKK/cOdoxLY/19xwv2y7y2vYTfMraz1OY=;
        b=ZODjFZVuJXCxcTHZ6XKhKfzYHGS0UqOOdwMwVe38Nxb8xm5akOBSJWwebQDODvpeiB
         ehvDvVd8SzxFScAAcqxEPN/jZitdjG8/gjwR2N93ANwwcPYmcd/x8cnk4gOJv+sq8AhJ
         BJzevsZbzpuxPSGHFRBOBWqnvS9Jk4NbkmZVBkX455bLledUVoDAq14hJameK73mn1Za
         YAV4DW37cCLwN7GBbDPEylOgnwIrMb9C1Zs0I0A/v/pFUsxX2yeG4Wiz3++ME+hm+SkO
         9OXQYlsM7ao79WBklPd0SI9cpjOI5Der4j4bzHvtp73MHnMh6vEe8oby3Tr7I3mSsDnP
         XL9A==
X-Forwarded-Encrypted: i=1; AJvYcCW9x5fWP7p0StW4JaDbEASBf4iSmHeUQIanKwV4OOcHOWWwF1nMaxU6mX3O5bHTxdaVUcA7hba4mT+VyzSYTydunKqNFG4eQLXe/Udv
X-Gm-Message-State: AOJu0YyITXbN4ZFcCInVIFVC8dXYG9tFT9kOvBKbS8ImIkMcPunnaddJ
	QmDxEvlVnFAcQkBUfP2QiSCYAOwBzDpWSMG3MASWfkqRzyY0PPtnJ7MbZCqiA/BQFdQ8RaYRudl
	WX+wPycB7pdLMJOwK2xecVewmvPjkZKxWm4RLT424YRxxVk4PgtaUDwuKTGOAYw==
X-Received: by 2002:a0c:e6a4:0:b0:690:4724:777c with SMTP id j4-20020a0ce6a4000000b006904724777cmr10059759qvn.35.1709580610577;
        Mon, 04 Mar 2024 11:30:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQoAv9sj9nxd+niUS6DSSnJifmdH5VWrZcwBNdh3HO60CPXPf5TWq0bZW09NJkHf71aBle2Q==
X-Received: by 2002:a0c:e6a4:0:b0:690:4724:777c with SMTP id j4-20020a0ce6a4000000b006904724777cmr10059744qvn.35.1709580610325;
        Mon, 04 Mar 2024 11:30:10 -0800 (PST)
Received: from ?IPv6:2600:4040:5c6c:a300::feb? ([2600:4040:5c6c:a300::feb])
        by smtp.gmail.com with ESMTPSA id qj22-20020a056214321600b0068f73372424sm5418384qvb.90.2024.03.04.11.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 11:30:09 -0800 (PST)
Message-ID: <14f1d3efc0bef057a51748db6fe95fcd22f3b34c.camel@redhat.com>
Subject: Re: [PATCH 1/2] drm/nouveau: fix stale locked mutex in
 nouveau_gem_ioctl_pushbuf
From: Lyude Paul <lyude@redhat.com>
To: Karol Herbst <kherbst@redhat.com>, linux-kernel@vger.kernel.org
Cc: Danilo Krummrich <dakr@redhat.com>, dri-devel@lists.freedesktop.org, 
	nouveau@lists.freedesktop.org
Date: Mon, 04 Mar 2024 14:30:08 -0500
In-Reply-To: <20240304183157.1587152-1-kherbst@redhat.com>
References: <20240304183157.1587152-1-kherbst@redhat.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Reviewed-by: Lyude Paul <lyude@redhat.com>

On Mon, 2024-03-04 at 19:31 +0100, Karol Herbst wrote:
> If VM_BIND is enabled on the client the legacy submission ioctl can't be
> used, however if a client tries to do so regardless it will return an
> error. In this case the clients mutex remained unlocked leading to a
> deadlock inside nouveau_drm_postclose or any other nouveau ioctl call.
>=20
> Fixes: b88baab82871 ("drm/nouveau: implement new VM_BIND uAPI")
> Cc: Danilo Krummrich <dakr@redhat.com>
> Signed-off-by: Karol Herbst <kherbst@redhat.com>
> ---
>  drivers/gpu/drm/nouveau/nouveau_gem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nouveau_gem.c b/drivers/gpu/drm/nouv=
eau/nouveau_gem.c
> index 49c2bcbef1299..5a887d67dc0e8 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_gem.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_gem.c
> @@ -764,7 +764,7 @@ nouveau_gem_ioctl_pushbuf(struct drm_device *dev, voi=
d *data,
>  		return -ENOMEM;
> =20
>  	if (unlikely(nouveau_cli_uvmm(cli)))
> -		return -ENOSYS;
> +		return nouveau_abi16_put(abi16, -ENOSYS);
> =20
>  	list_for_each_entry(temp, &abi16->channels, head) {
>  		if (temp->chan->chid =3D=3D req->channel) {

--=20
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat


