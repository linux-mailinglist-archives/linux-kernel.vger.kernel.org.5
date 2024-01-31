Return-Path: <linux-kernel+bounces-47370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1DC844D7F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7842B38EF0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53BC140778;
	Wed, 31 Jan 2024 23:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HRYF17wF"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9938014076C
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 23:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706743402; cv=none; b=hOLfJktbvjvUj/DbzQYcFSjUsZcmiecZ6wKNT0Z85GnTZIl5XymsWZPzgr8vW9zI9/Dc+ArcGukPAHXnkaxm8V5qqBXIPry+UalnwTiEff/DjPPOsO+uabn1Vd2Ndtfliu1ZB7u/aeHxfOMFD3aH12uR4IP/hGXrzk8YGGCmlZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706743402; c=relaxed/simple;
	bh=4kOEYxrGPDYpj74t/Dr6ptlV84Pcyv8vDPPU8FTcONw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o0+evf6cOq/1i8UpCGHABaKB2LB3nPQOQZyhnWXANOwL2CY775M457YR2+Ug2rHnuEGcbUA+MLrqCwh8Qly+8yCUIcBMVTlzQ8g9CopyKrnlYCvQiGaLILWdH8d6efXzTOvIPQO/jCgdAi6wd7iCfhzX5nGGBioQRYmbMDzl8nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HRYF17wF; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7bade847536so13775339f.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 15:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706743399; x=1707348199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NIqzn8dNu/FH5Kv4haHfL0VhyfOrJMls78tDXECIvAo=;
        b=HRYF17wFVEozty8YzgGY482tEgr/ga8QqCJPl2wCbA8xE4MEdQKeJtq/7EkJHoQr+I
         3vimQEW/3q3sSXrQTo67hR4KoWcw99IXS48U/0Xmro4Z/B3AfeX2iNXdj17wYOLrQXHC
         wLTWss+I7HuU+Lzjyog4Zqk3R9VddMIdgsczz+oe1xYdDEYeWB47ZhDklnMhZbwC09o1
         O5GK7MHs6xR4rM9YYjkrj+OFg1Hx6rEndYzhZQ8wQL33aRvQgeV567UQ2EHc7BNJjOgy
         +YKysITDOCWQFwtzFJnPGOx7W7AKFtt6Zi4XsQUEEch79cYyHVZKBf9zNqRxDRQQUkL5
         v+Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706743399; x=1707348199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NIqzn8dNu/FH5Kv4haHfL0VhyfOrJMls78tDXECIvAo=;
        b=ASs88vULS1nbL0dXlMzDkKW4AC7XTsHRp9n1lGSBwxAyUN8g0sA3aNT0CknPencHop
         X+7AFEwgSj08kXDHS2bydUKRHvYWnS/IuK5RBnJG7oIJ6UU86cRkAJMxQfnxZknKXgLG
         2WspCmfbi/Z0Z+P+0ZmUHWIf3QuVRwp/SJ52q5BgRXgd++i7cfOlf0FOQtwhGnLTMhlo
         vVKSm2cHeCvpOZXQtoYkY/IaKpbAKZl84+lr20Mz9GJxEPHPzX+fEmnVGzuqiW2C1q3H
         G9cvErYtKL9KfDsFhIlVcRmf4QaSGGgxu8niF/3ur10/pJ2sJqfDHq/4vUO6+vqSmzSo
         VxCw==
X-Gm-Message-State: AOJu0YzQqD0k79rv4o0t6qsgexkiCPXFgXxhM9DWGjC8oOGXyut/3IqU
	AWLME0/KCZXBCUDgU256qtYhecne9Q9OXsciEP3i2voQaLjnbRY6jfkcJ5Wy+DTudp5lX55iBzJ
	I37ELNf7ZuuMzTjfA03XGeLY05Uo=
X-Google-Smtp-Source: AGHT+IFedKuiqobmCaj28zu9qIblviQv611nhWW8X6T5VGVjVtFrrmXsbKQVdPqr48kOdETRMVDMpB/Y85UUzyavAGI=
X-Received: by 2002:a05:6602:1215:b0:7bf:97a7:5da8 with SMTP id
 y21-20020a056602121500b007bf97a75da8mr3691067iot.8.1706743399465; Wed, 31 Jan
 2024 15:23:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130014208.565554-1-hannes@cmpxchg.org> <20240130014208.565554-12-hannes@cmpxchg.org>
 <CAKEwX=PN3vFZO1VkFVoRJGOnwgRdfuyOrFPA6DvfkM761o1B9g@mail.gmail.com> <20240131112311.GA1227330@cmpxchg.org>
In-Reply-To: <20240131112311.GA1227330@cmpxchg.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 31 Jan 2024 15:23:08 -0800
Message-ID: <CAKEwX=P6YqKzVMzZiTry8UafSFnpnvLxJekeP3B03oy3uDyg0w@mail.gmail.com>
Subject: Re: [PATCH 11/20] mm: zswap: function ordering: pool refcounting
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 3:23=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Tue, Jan 30, 2024 at 12:13:30PM -0800, Nhat Pham wrote:
> > On Mon, Jan 29, 2024 at 5:42=E2=80=AFPM Johannes Weiner <hannes@cmpxchg=
org> wrote:
> > >
> > > Move pool refcounting functions into the pool section. First the
> > > destroy functions, then the get and put which uses them.
> > >
> > > __zswap_pool_empty() has an upward reference to the global
> > > zswap_pools, to sanity check it's not the currently active pool that'=
s
> > > being freed. That gets the forward decl for zswap_pool_cuyrrent().
> >
> > nit: zswap_pool_cuyrrent() -> zswap_pool_current() :-)
>
> Whoops, my bad.
>
> Andrew, would you mind removing that typo inside your copy?
>
> > Also, would it make sense to move zswap_pool_current() above
> > __zswap_pool_empty() to get rid of the forward declaration? I guess
> > it's now grouped with current_get() etc. - those don't seem to use the
> > empty check, so maybe they can also go above __zswap_pool_empty()?
>
> There is a grouping to these functions:
>
> - low-level functions that create and destroy individual struct zswap_poo=
l
>   (create, destroy, get, release, empty, put)
> - high-level functions that operate on pool collections, i.e. zswap_pools
>   (current, last, find)
>
> They were actually already grouped like that, just in the reverse
> order. The only way to avoid ALL forward decls would be to interleave
> the layers, but I think the grouping makes sense so I wanted to
> preserve that. I went with low to high ordering, and forward decl the
> odd one where a low-level function does one high-level sanity check.
>
> Does that make sense?

Makes sense to me - just double checking :)
Reviewed-by: Nhat Pham <nphamcs@gmail.com>

