Return-Path: <linux-kernel+bounces-29512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3966830F7A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 23:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31D1A1C20E42
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 22:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E5D1E891;
	Wed, 17 Jan 2024 22:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lgcUy59G"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13151E872
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 22:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705531596; cv=none; b=g/gfXhnEJ08EDdd3cemklSbPXjB8ZLG8MFm/z+QZJ5okVVC4iEqvWGWNTHrNiSFexYGyGsCiRB5CKYiSg4MkUt03z8aS0H2/hYnmCAE00kau/SU4CLhWXFMibrkL/BfeyteRtVbSe8OQukPDndER/LjD8w+Tvse1FLwdCM5EJkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705531596; c=relaxed/simple;
	bh=iUlscJeTm4pbcg+uiIT41dxgdS0KpwW/iR3/zKnUo08=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=IHFvzJpgNHoCKyQn0Wq1WaIXdwOcaP7lpJ+KOB3aHkAWcI+pAwJ/0pKKX8EmyzInFwkxHJopjNkn1BFBR1zTbM1hCfVtnHS6scTP8cE7cXxn/wgrRyDN3J1GiriPIL9kDsU0g9zPATsqUgJzDwsTU1nrIu263UByp4L70p/JNnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lgcUy59G; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5ff847429d4so1453757b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 14:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705531593; x=1706136393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZEtfKHM4jQzQLGyBhBaXBaAlBL+U+MX7o4RckoJKRd4=;
        b=lgcUy59GfI7bWRPKu3lW8abUo3M6xXsWdT/t+UVqA0OsOM+ooeizGyQf6KVBM/wJxH
         x9tObR0CybXihTbypLnrMphrQVgUo/d/BPMTRIAeLfl4RUYmSuQnBzvcwBurSgH2qRVx
         rq5h2oao5h4FkWrCecVQYbMWilz0vb8pV5FxjBHzH2cZkaCtf+L2qrE6fERccn33tHlz
         5yq9CyrZuruj6xzNbI5I2IJYZjLMdTCIHO4DdZEC4oOyM9iV7eSVQ1oSlztyc3zKBEfI
         ERPnZP4DYK7fPeKxKAxW5Ex+HYGQVojbP0VH0nafFqEXqqY48dPdt8WrhTDUzNlrzC41
         Nq4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705531593; x=1706136393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZEtfKHM4jQzQLGyBhBaXBaAlBL+U+MX7o4RckoJKRd4=;
        b=lf7TsVFxy4XY5y9Ghqy6tSH+PFcLbsFLxBANjvsuGdH9flor/xpKcRW930Zquh3QyA
         HaBeE9pg0X6Ln5EJ27/Go45JIY8zuYO8vbrLLMtlXDFQKzsltNTlOmmv5C+0EmTrRmdt
         xKzev3UerAj/tc4ZTAcdhHGiyDA04JSmHGloM7Fy0szZw1gokHqrmJcZPQwKA/CrWsN/
         HbCZ0Qoz+gpvB/NTBu/0FDS1q646kXuboaV+mDQLg6/8NotswvEOEieqjylEKHmWzhwR
         ltcuWt4/bcKknwfC0gEPQk4uFU97BjtDAsEniTIdpE2PKxwh+pZRD84JVBnimPvVzpd7
         sZDQ==
X-Gm-Message-State: AOJu0YxxuAwGqiyIsG/d1MpyFfra31LF3VlzR8VlEoZh1MWB7/98A1RW
	7umEnbURZMqoxjj6NhFuLh6D8q8Om7cX/4aTLuU7m4udnB0Y
X-Google-Smtp-Source: AGHT+IFcNPtuzXeyNaWzcBsBS0yPnJacNDAP6RyfSMO6gLFv7R5OR5rMNmfvyQmUVgCL03Ny0eXHwuHfVLL4PqulmvY=
X-Received: by 2002:a81:ed02:0:b0:5f3:dd8d:4646 with SMTP id
 k2-20020a81ed02000000b005f3dd8d4646mr7819257ywm.81.1705531593500; Wed, 17 Jan
 2024 14:46:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117223922.1445327-1-lokeshgidra@google.com>
In-Reply-To: <20240117223922.1445327-1-lokeshgidra@google.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 17 Jan 2024 14:46:22 -0800
Message-ID: <CAJuCfpHFNBSteck_bWxHwXDzeqC7QLn6hks5PoMC4ytWbJO4tQ@mail.gmail.com>
Subject: Re: [PATCH] userfaultfd: fix return error if mmap_changing is
 non-zero in MOVE ioctl
To: Lokesh Gidra <lokeshgidra@google.com>
Cc: akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, selinux@vger.kernel.org, 
	kernel-team@android.com, aarcange@redhat.com, peterx@redhat.com, 
	david@redhat.com, axelrasmussen@google.com, bgeffon@google.com, 
	willy@infradead.org, jannh@google.com, kaleshsingh@google.com, 
	ngeoffray@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 2:39=E2=80=AFPM Lokesh Gidra <lokeshgidra@google.co=
m> wrote:
>
> To be consistent with other uffd ioctl's returning EAGAIN when
> mmap_changing is detected, we should change UFFDIO_MOVE to do the same.
>
> Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>

Looks correct. Thanks for catching it!

Acked-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  fs/userfaultfd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index 959551ff9a95..05c8e8a05427 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -2047,7 +2047,7 @@ static int userfaultfd_move(struct userfaultfd_ctx =
*ctx,
>                         ret =3D move_pages(ctx, mm, uffdio_move.dst, uffd=
io_move.src,
>                                          uffdio_move.len, uffdio_move.mod=
e);
>                 else
> -                       ret =3D -EINVAL;
> +                       ret =3D -EAGAIN;
>
>                 mmap_read_unlock(mm);
>                 mmput(mm);
> --
> 2.43.0.429.g432eaa2c6b-goog
>

