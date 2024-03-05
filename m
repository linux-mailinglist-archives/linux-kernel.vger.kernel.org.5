Return-Path: <linux-kernel+bounces-92529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 451198721B2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4FE8B247F4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F5986ACB;
	Tue,  5 Mar 2024 14:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="mu8gjg6d"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDBA37145
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 14:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709649538; cv=none; b=DJ21afew5nYX+2yOKooPzI8lWIC6F9wV3P3iB05ocAfTpWnrl/Kw0l96u9lkHMV5xSY7yUvcDzLauiX9wZcHHALArayBL8Phwh6Nj9Sz0+qpGpG+ljgbA4qFRqnftqUa8TLzUBcp1LxNi4ppqfkBispcUQE3O2AuWIKmf7lREVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709649538; c=relaxed/simple;
	bh=oMoaD15Q4RZurtXz9m0mjYyGcE+cC4GEA1JD8WLd12w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kTWwbgM34/eLnVisvoToOpj9AeOHjDyQMC0brqef+ShCyuDRdhYsH00MAD80VsfxheIHbocIxDBbj/3fuQw3JI7Xsej687OBTmbuN416B9Cb0ZKDz5oJ4EnfaItxOgJT2zf+G0U4spL0LGUcJb+CqFJOynL0Kmlea0P9CPDQmLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=mu8gjg6d; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-512b3b04995so4307469e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 06:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1709649535; x=1710254335; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oMoaD15Q4RZurtXz9m0mjYyGcE+cC4GEA1JD8WLd12w=;
        b=mu8gjg6dD1CMKjtcrsSeXbJJa7zwEvW23eLM4jvo8l10xBWcPfceeKhHX44lN77+g7
         95+MI5qWAqJ8dBTqTYS2SB2A/OSbkyWadinyQcSMaIXZM4wgSU1FcjW1OiqcU+yH8J0o
         K/UhDa0w8cII223Jd4iqDgvpDmUov8LOuJ4TM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709649535; x=1710254335;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oMoaD15Q4RZurtXz9m0mjYyGcE+cC4GEA1JD8WLd12w=;
        b=mwLCy2qNnHExlZG2uE3b20ZEEV9dufeWumT5+vuGS5jqKWO91zBaDn1gX6kzCt6LmK
         3AfBK1DevXrdi3JnpZvSDWiZSKdKMfIOgIphV0WNbsPFYqveob3Wsr1+Nl8V6u9vFcF8
         tGTKqEalTFh8qf6aAwKAqdmK0J/EjUlBS+kh/C3BzKa+kXwN7SdZ89sURGMk0N+WfKbx
         Eh/LhvZbRq1MNUumcGpgXg6rxt0m6WG1caqKm4flmCO3ckwnO8WkpWYx+ufHyCwHWfP7
         p1AuNde9hS/q8BTtYJMZgDV4Phk/WAAeha2zTZcv5yh3k8WWjHKyVGzJDmdGW0sk63AL
         TJ8A==
X-Forwarded-Encrypted: i=1; AJvYcCXMa32Q2KsCxJa6dYV0cWLumFyjSMhYv+/YKEUjoJoU+KK+fG9ZlW12q1Tx7lc4+u+CXbLxPRPnMHiGncZfGWSlBe38Z3HzgaUnDwHV
X-Gm-Message-State: AOJu0YxTw3pAcHbnFfBs30QMF1WACybWYgP9y1pa051fm35tXS4x/zir
	1feOYjd9ASr/Y7BXItMETKGzvG/tVzBd5iALLodxx5FMLv78iO4gls0jIOiWo4BE1t6K/JAf8sU
	EtCWbm46dgTL+DKxjlSQrVq6CiQxjtZX/MHNc6M38y8OA8ZNA
X-Google-Smtp-Source: AGHT+IHtd287Cim+U4qSt3a8db88CbzOFal6Gmy5OoASE9Fw7x+WgX5YbLauuKoFawGzS6YyLx5H0xL5YW8GyxOwFlc=
X-Received: by 2002:ac2:54a3:0:b0:511:674d:88c5 with SMTP id
 w3-20020ac254a3000000b00511674d88c5mr1505026lfk.13.1709649535128; Tue, 05 Mar
 2024 06:38:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108120824.122178-1-aleksandr.mikhalitsyn@canonical.com> <20240108120824.122178-3-aleksandr.mikhalitsyn@canonical.com>
In-Reply-To: <20240108120824.122178-3-aleksandr.mikhalitsyn@canonical.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 5 Mar 2024 15:38:43 +0100
Message-ID: <CAJfpegtixg+NRv=hUhvkjxFaLqb_Vhb6DSxmRNxXD-GHAGiHGg@mail.gmail.com>
Subject: Re: [PATCH v1 2/9] fs/fuse: add FUSE_OWNER_UID_GID_EXT extension
To: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: mszeredi@redhat.com, brauner@kernel.org, stgraber@stgraber.org, 
	linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Bernd Schubert <bschubert@ddn.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Jan 2024 at 13:10, Alexander Mikhalitsyn
<aleksandr.mikhalitsyn@canonical.com> wrote:
>
> To properly support vfs idmappings we need to provide
> a fuse daemon with the correct owner uid/gid for
> inode creation requests like mkdir, mknod, atomic_open,
> symlink.
>
> Right now, fuse daemons use req->in.h.uid/req->in.h.gid
> to set inode owner. These fields contain fsuid/fsgid of the
> syscall's caller. And that's perfectly fine, because inode
> owner have to be set to these values. But, for idmapped mounts
> it's not the case and caller fsuid/fsgid != inode owner, because
> idmapped mounts do nothing with the caller fsuid/fsgid, but
> affect inode owner uid/gid. It means that we can't apply vfsid
> mapping to caller fsuid/fsgid, but instead we have to introduce
> a new fields to store inode owner uid/gid which will be appropriately
> transformed.

Does fsuid/fsgid have any meaning to the server?

Shouldn't this just set in.h.uid/in.h.gid to the mapped ids?

Thanks,
Miklos

