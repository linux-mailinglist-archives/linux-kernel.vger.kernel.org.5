Return-Path: <linux-kernel+bounces-63016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1BF852910
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 07:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B37CB21562
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 06:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C498614F75;
	Tue, 13 Feb 2024 06:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2+ovmIoj"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C841427A
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 06:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707806075; cv=none; b=UgnqoHYFymTWWvbfjAXXfTIT655/95UXzm0tPnGJKzDoWiDOA8ERfGiI86LVzCXbH+PAspPg1DinIBzdAoKyikBAdjNByVhGw4MINH3aVV9Cs74RdVzgKIh9d9I9vq8cT4bg8WnM9GHdc+qH+K1ixmgw/OHfvg3xZpJW1MVjlH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707806075; c=relaxed/simple;
	bh=mKruLP81k11KOUoI6CLV7eaQ8XK+33pFP3PO6J0iJaI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a1mI04a5raEGaqzoeFAs80zWhwWwTYAATufPTQ2lBt3IHO4JU2UD9x60mYf9XoXz77tfAU7RnYTihAKyHHMIxS+HoR4y8OocJKMf/UY/zTgEUrIIMsO6jMUlj3RGOo+qXa9i0vC/dfpgR859Y6YO2uH1eGO6XatUEEB7rLWCPTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2+ovmIoj; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56101dee221so4612a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 22:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707806071; x=1708410871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WIm9WdyKzo3v62kbxut9xYgCk+tYqEBgc0eUHAV5Zlg=;
        b=2+ovmIoju8lmDNJlrpfYfP087VESODXAiSkGrZteWzarRhwU4BwIFyCIQ7ikikNqrY
         Ndy/coF8B0HoiG6QWXZrAWghrZ699IobY09TzGEO9dVqYbgd7+WWt0fLQgESL5tt04DG
         EP3+ywXjwtoXdJ4J+mAVmG1CpAEvSDF45hofnGrdUlYB9vj2o4wQKsyAX7EcYNrv/zcG
         fGJmsGkl+yBCcaieOzkton3VVKB1sp56irtmNuJDBH1Om+qnNJ9yc517ml7CP8xp2gFK
         5+swdJD97vbtpzSyGtlclxQj07YHkFkjhkjgId3qXJMSDVZtGjazMp2iEgIrucxTo50Q
         +MlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707806071; x=1708410871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WIm9WdyKzo3v62kbxut9xYgCk+tYqEBgc0eUHAV5Zlg=;
        b=dbnO4Iie9W5sbNCr/Kz1BzCnbz2GIS2N9uIaOv15X30V/JmSt5Ft2Tv48Nvv1xky+s
         hLUmwjInDHKLnAYQDjnQEEXtSJXJpcSSKtQZN/hn7qxNBPlyW9/ULmllyQAhUzUaBIN1
         inEyK8Byh/QyVUwpei33PaOwbovEx5H1aB8RUHhr4K+l4T/+7av0fA29J+GyO97atFYe
         zwS2Ib5g+v5VovQ+tA1nFF8Hs+IgymHyhuRSPDBBWdgRmRYIm4s6xszrfBKQXu5VBmNW
         bV7//osDHS/FGGMRc7c63ISYLQFkgakL9KRNDxIDAwMoqDYd4QagjzJVCOhy4lFVpeI8
         k5/Q==
X-Gm-Message-State: AOJu0YxpJpU4LPIDG4uNngeWhE/dz2r7WH/Dr4m+iaiIxc3XtYJKFdUN
	Judb1QNsBChlT7HOnjAHWh387n4Z7L+V/QfSz2+sOGPjY2tlN190E5u/nfNj22A2+guZdNBSQ+c
	JZ3aoVb6DqLCKv7SMl8P5OdA++aEMtN+IC6TxTgT5pXLd60crkg==
X-Google-Smtp-Source: AGHT+IF/wXpV/blHGlNxQbtZJNK0epc6JpPwR38cJIbefYqx2cTJy1wPy/M8ipB1ttLExylgcqf+vmoP6JozNIHit60=
X-Received: by 2002:a50:bae9:0:b0:560:2a1:44fc with SMTP id
 x96-20020a50bae9000000b0056002a144fcmr42153ede.1.1707806071396; Mon, 12 Feb
 2024 22:34:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213061652.6342-1-jdamato@fastly.com> <20240213061652.6342-5-jdamato@fastly.com>
In-Reply-To: <20240213061652.6342-5-jdamato@fastly.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 13 Feb 2024 07:34:18 +0100
Message-ID: <CANn89i+JQdR9-X_mEfifSAGGxqJaWz+hzWcUjScNCz5zOA1yLA@mail.gmail.com>
Subject: Re: [PATCH net-next v8 4/4] eventpoll: Add epoll ioctl for epoll_params
To: Joe Damato <jdamato@fastly.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	chuck.lever@oracle.com, jlayton@kernel.org, linux-api@vger.kernel.org, 
	brauner@kernel.org, davem@davemloft.net, alexander.duyck@gmail.com, 
	sridhar.samudrala@intel.com, kuba@kernel.org, willemdebruijn.kernel@gmail.com, 
	weiwan@google.com, David.Laight@aculab.com, arnd@arndb.de, sdf@google.com, 
	amritha.nambiar@intel.com, Jiri Slaby <jirislaby@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Michael Ellerman <mpe@ellerman.id.au>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Nathan Lynch <nathanl@linux.ibm.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Julien Panis <jpanis@baylibre.com>, Steve French <stfrench@microsoft.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, 
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 7:17=E2=80=AFAM Joe Damato <jdamato@fastly.com> wro=
te:
>
> Add an ioctl for getting and setting epoll_params. User programs can use
> this ioctl to get and set the busy poll usec time, packet budget, and
> prefer busy poll params for a specific epoll context.
>
> Parameters are limited:
>   - busy_poll_usecs is limited to <=3D s32_max
>   - busy_poll_budget is limited to <=3D NAPI_POLL_WEIGHT by unprivileged
>     users (!capable(CAP_NET_ADMIN))
>   - prefer_busy_poll must be 0 or 1
>   - __pad must be 0
>
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> Acked-by: Stanislav Fomichev <sdf@google.com>
> Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks !

