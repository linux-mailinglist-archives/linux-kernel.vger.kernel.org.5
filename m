Return-Path: <linux-kernel+bounces-123144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8758902EA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52B1C29502B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA3D12F362;
	Thu, 28 Mar 2024 15:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ezE9sumk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9725512F37B
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 15:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711639306; cv=none; b=N19kpMTpQv1om3KC7H54ct8KxD396pjQP8M9dZHfEMeTCBAxcZCrWXYexSxz6+57kEurZ/0Lj3NM7MnniRmqFQMqbDZaxfNP+OY4pYtjvq9CQg7d5Vnit1CSt8T08AAvOfbss87SqdDyRP9sJ0oe7W7DJtXSTX0tvPFUOomIl5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711639306; c=relaxed/simple;
	bh=ondHyxfZ8OX6rwV1SB59go4V4JhpfH4Z1BXh1xU7Kls=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oMKqHHUUVzg3DOfbqRthjW2QMQDpuDcAzWQ8kqn64urDT8ysPjYXy+C9UjMvOdif3NTwUEvaqWQRAnWxELAdI8nFQf6CeEcaSTHWeCR3s106oKhkUHej5cRlY5LA5Nv7ZVsobhjAXTVC41xcdOBgUGaj1OuHR0/XaFJU/7kzdD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ezE9sumk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711639303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ondHyxfZ8OX6rwV1SB59go4V4JhpfH4Z1BXh1xU7Kls=;
	b=ezE9sumktW73q3kaCNMA37Ifb9J5LVgd0XLBttqry/2AaVTP9bOYXFRqTMB++rrW7NHXt9
	VhVMPYXF3p0vvHBXfSspfpcWsslycdAjy5btixJhi+bG+zAATQIcymKt5mwgRuo9gdho1D
	Go2mFx/buRVBwVLX5fL8t59aPnSBHes=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-B-8QFY0YMkOxqdIyfwGQOQ-1; Thu, 28 Mar 2024 11:21:41 -0400
X-MC-Unique: B-8QFY0YMkOxqdIyfwGQOQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33ec826d427so245922f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 08:21:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711639300; x=1712244100;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ondHyxfZ8OX6rwV1SB59go4V4JhpfH4Z1BXh1xU7Kls=;
        b=qeMIxANj6HoSH9kjNcUwxROcmOGOXlhwmWcyfShSYXLiJieSJMnFx6Sdw7OnyKsAHL
         9Qr12MtSHh0L0spe3MTqdeqhGh7xd5NUP58h/5iYYp2yOdlJ4B47hpRUZSYA+G0X4VIu
         a1Ut/hUCAnsZ+xkzAjRcuOl1LPlWtXCXqlQc0L7YOcGeXJCKRj+oeV8wBl9HjYSGaCO4
         9yMjW3P08AANIzluweWVIpgCzmJ96mnlV2SUqsa4eM8obt4T4ZSffJDY2y50/kOAq32o
         5qb13mUocwLC7lBf/bapwTaW60LoWmJyY58FWw1tHAgalnileTOE3X5B4x4Xarv0DUXm
         ueEg==
X-Forwarded-Encrypted: i=1; AJvYcCXUto9C2DnJyNFK9fyA5nZSbl0Evqk7w2r31uZ64lNEx1noU4yYpc3uqPOYefeJcj5CaxBsr9cOZJIPOLV+1Uv5M5xA5fuZEDKFfO1V
X-Gm-Message-State: AOJu0YxNZzfAI3qNCkNcEWmHhUHf8RWi0mz4AKnklX5PYMft41hNalSN
	qNTFlJjEVGfcGajfmkw5zRYMT8a/OOFIdwVjanKcKqvWEFZlJ6fJHgUJAw4yCpPvPzVLz8k/KrE
	fJNTv/pTEyXm8bDjYOa2UfrWW2AbQxyC25sTMd/hgJBy4map+vzZJqGT/L2ifMQnvE+6BHQ==
X-Received: by 2002:a5d:4d12:0:b0:341:8f18:db39 with SMTP id z18-20020a5d4d12000000b003418f18db39mr2162765wrt.1.1711639299849;
        Thu, 28 Mar 2024 08:21:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4wODag+R6YZegPQpjBBcHxwLoBqvrwbnJ8kbwMlZZahD5JYP2dGk26tLHT2tkN0npnp32mg==
X-Received: by 2002:a5d:4d12:0:b0:341:8f18:db39 with SMTP id z18-20020a5d4d12000000b003418f18db39mr2162753wrt.1.1711639299507;
        Thu, 28 Mar 2024 08:21:39 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2001:9e8:32de:9a00:227b:d2ff:fe26:2a7a])
        by smtp.gmail.com with ESMTPSA id m3-20020adffa03000000b003432dcdb5d3sm1987109wrr.35.2024.03.28.08.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 08:21:39 -0700 (PDT)
Message-ID: <25b5f2297c98500ed91971a61ccc4bfa5921035e.camel@redhat.com>
Subject: Re: [PATCH 6/9] nilfs2: fix out-of-range warning
From: Philipp Stanner <pstanner@redhat.com>
To: Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org, Ryusuke
	Konishi <konishi.ryusuke@gmail.com>, Nathan Chancellor <nathan@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Nick Desaulniers
 <ndesaulniers@google.com>,  Bill Wendling <morbo@google.com>, Justin Stitt
 <justinstitt@google.com>, Andrew Morton <akpm@linux-foundation.org>,
 Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 Thorsten Blum <thorsten.blum@toblux.com>,  linux-nilfs@vger.kernel.org,
 llvm@lists.linux.dev, pstanner@redhat.com
Date: Thu, 28 Mar 2024 16:21:38 +0100
In-Reply-To: <20240328143051.1069575-7-arnd@kernel.org>
References: <20240328143051.1069575-1-arnd@kernel.org>
	 <20240328143051.1069575-7-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-03-28 at 15:30 +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> clang-14 points out that v_size is always smaller than a 64KB
> page size if that is configured by the CPU architecture:
>=20
> fs/nilfs2/ioctl.c:63:19: error: result of comparison of constant
> 65536 with expression of type '__u16' (aka 'unsigned short') is
> always false [-Werror,-Wtautological-constant-out-of-range-compare]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (argv->v_size > PAGE_SIZE)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ~~~~~~=
~~~~~~ ^ ~~~~~~~~~
>=20
> This is ok, so just shut up that warning with a cast.

nit:
It's not a warning, but actually a compile error, right?

(no idea why they make that an error btw. Warning would be perfectly
fine)

>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Should / could that be backported to stable kernels in case people
start building those with clang-14?

Regards,
P.

> ---
> =C2=A0fs/nilfs2/ioctl.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/nilfs2/ioctl.c b/fs/nilfs2/ioctl.c
> index f1a01c191cf5..8be471ce4f19 100644
> --- a/fs/nilfs2/ioctl.c
> +++ b/fs/nilfs2/ioctl.c
> @@ -60,7 +60,7 @@ static int nilfs_ioctl_wrap_copy(struct the_nilfs
> *nilfs,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (argv->v_nmembs =3D=3D=
 0)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (argv->v_size > PAGE_SIZE)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if ((size_t)argv->v_size > PAG=
E_SIZE)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return -EINVAL;
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*


