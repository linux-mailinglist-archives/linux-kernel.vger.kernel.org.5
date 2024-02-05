Return-Path: <linux-kernel+bounces-52956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E71E6849ECC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24BF81C2198E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69CE2E636;
	Mon,  5 Feb 2024 15:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RMXgJW8J"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD5A32C90
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 15:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707148355; cv=none; b=L9Obok5YUjlH1qWiv4e+YTfPkWCeDqO4D0ls+h5+55b5zsnNiKqcR3jPkIavQ21EjV5a6KAp54xcjIWLF7iYrneHNACUiu/lFk6HuCa+s2Uxeclh2GUOoYyCSOrUrBaL3ka6vYabjhr/ZVgaiZy8TAsSOQP0NL2hjQ0kin5j4Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707148355; c=relaxed/simple;
	bh=UFjJ/nC+EO5zNXlJIp90OHpvPbE5H66wtSZYQXKGwQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OBSW8E2CQn3AFmEHfOw+vQJwISdnuO6PWgeQZHz2yTTprmMgXvqwwgzMjh/7MK0ydGv6dIbLQme1NffqY5k4z2debEiQTkXmZTStHdSkmTgH5kQOACiN5j8TocOOTOo5ZwZfMCcMvwlnjRGrWiuW20cOSjRbtZbDIxuyHGc8Tf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RMXgJW8J; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707148352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UFjJ/nC+EO5zNXlJIp90OHpvPbE5H66wtSZYQXKGwQI=;
	b=RMXgJW8JCxW6c1LY9w6nRuqinJH95DJ6SRdonE4EfiMtyC4UI5izQAvRD3hjJZcjWh1EyJ
	HXYioiDrCEKXC6DOpW79o9zohYHwXQi8ZqzXKUWr24FYRZXZ3jkhL3wqwLd89MaA9uUPy5
	npGxObwuRQnqT69+hyAeUD37rbp/Cus=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-iizG5XP-Mlq8VFZgJFeqRw-1; Mon, 05 Feb 2024 10:52:30 -0500
X-MC-Unique: iizG5XP-Mlq8VFZgJFeqRw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a30f9374db7so611754766b.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 07:52:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707148349; x=1707753149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UFjJ/nC+EO5zNXlJIp90OHpvPbE5H66wtSZYQXKGwQI=;
        b=Vhpt7a4oQjX/Zt4Zi1BkTU8MHpasJ9VfX0xBC+urEbsxbLvQFspYLlB0sj052Z3dTf
         HXaoK0Lo5oIr5elwH+UNJCVar8J3NIvFKR84PgF87TiAMUJQZhpjBt1W1OuMTK2AYjSp
         uelxTqpj1ki1Wamw3WKdHSKdQNn57khspuIT7PLoNYVnOo5URcJyJ3AbHYkpjxz6l5Nk
         DWfrB2/4K764CJjjq2gcSsma7LD5M/8CrHAoMCbt2L6SWHZzDv4Z5hKosxlzvrrlJL4J
         uTNkvMAOBowb9yA2RqByijvbzUotg68L8P+PSj/kfZoxuRC0t1AJChAoLGvqFx14OGfY
         EB5w==
X-Gm-Message-State: AOJu0YwY77BU1GT7vQ4d92+HHCfCBwban6TM3AgC7xLSbbakmARLt+M6
	qx2S3tsPkbd3wL/M3x7/XDV+fuLcNhf2h9nYzsplBKB4ydF4isr6YgpmaACQqBiXUlcZTPpgjlb
	WNry50r81KdxaEhGAQy6RWIvFhshgjVZZS1oF1TISXVjdqSuusEqAuaMN9C6DBo/p/gd3oNNu8Q
	lc0ichtbkGnsSfDNwseYo/aGMtv6uV/htRMc1E
X-Received: by 2002:a17:906:b859:b0:a37:8574:357a with SMTP id ga25-20020a170906b85900b00a378574357amr73249ejb.4.1707148349711;
        Mon, 05 Feb 2024 07:52:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGweQ2W5Ahsln3HmpeaqfCI7/wF+qkjZUrhH63FkQDxmiB0liJcyKlQZpaeFTaSrxfbHqcmJQ95SQVSD63K9PI=
X-Received: by 2002:a17:906:b859:b0:a37:8574:357a with SMTP id
 ga25-20020a170906b85900b00a378574357amr73235ejb.4.1707148349408; Mon, 05 Feb
 2024 07:52:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205085949.439628-1-chentao@kylinos.cn>
In-Reply-To: <20240205085949.439628-1-chentao@kylinos.cn>
From: Alexander Aring <aahringo@redhat.com>
Date: Mon, 5 Feb 2024 10:52:18 -0500
Message-ID: <CAK-6q+jE8AzQboN+ACwQ7qCWUpz=Ax4pvzsNfu4SDhD8h2TMDw@mail.gmail.com>
Subject: Re: [PATCH] fs: dlm: Simplify the allocation of slab caches in dlm_midcomms_cache_create
To: Kunwu Chan <chentao@kylinos.cn>
Cc: teigland@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Feb 5, 2024 at 4:00=E2=80=AFAM Kunwu Chan <chentao@kylinos.cn> wrot=
e:
>
> Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
> to simplify the creation of SLAB caches.
>
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>

Acked-by: Alexander Aring <aahringo@redhat.com>

- Alex


