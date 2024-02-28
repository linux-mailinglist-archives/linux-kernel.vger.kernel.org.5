Return-Path: <linux-kernel+bounces-84617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACFA86A90C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 08:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7B4D1F25363
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 07:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50DD24B47;
	Wed, 28 Feb 2024 07:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="WIrHd9bW"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A97E21353
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 07:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709105844; cv=none; b=HOrIAfhUPKL3xJyYwV089ZP5n/9OyxR7GPXZixtdJ+GBwLdKOTY5aVbv6lfI2jBOOw/KCBgVv5I8GFVxz6lT/Yt+Blgrq56jXF/iLU5nSmNSQHFUir4IoOF6i5kUy3+xn0UmvK8opqCny1i0e2tyqGuldOIWn2o9IhAPtSBmhUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709105844; c=relaxed/simple;
	bh=/CEatFhajZaIrXQmG319mzOFBTaRIt71MhDwqBzf0N8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aHAjDB3WPZPrS9yNgYir3S9cxA9jMrYMxW900NsIZLl3QlGNvel9RjNcpwXJdRWR+Pwbiv6GEP0nrT1bmiBaNvgRl0o/hn022O+z0SCqF42ivCeFmmQhNws3XFNeg3FtK2MyxPoEhJkp618ia6xDHtCv9ry1uEwuHa9KAPq06pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=WIrHd9bW; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56647babfe6so1860838a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 23:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1709105840; x=1709710640; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/CEatFhajZaIrXQmG319mzOFBTaRIt71MhDwqBzf0N8=;
        b=WIrHd9bWhDhQQDSbIbleHHdz7Teqdv8Ntpr2VMc0Hx/z0vbKawFNRPqw9S1ViyAGZF
         i86nQyXon4OsP8ayZmCUOkZXWYXWfYiNYIOU+q4nsX3tjcKjzAoRy4bAhENP/EdoJhbV
         vM4AtNmWaZxJ/O6Xg6sLx7PwlM4QTNwjXl9CY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709105840; x=1709710640;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/CEatFhajZaIrXQmG319mzOFBTaRIt71MhDwqBzf0N8=;
        b=fy3JaNsES/BUHSnqOyHgEib1v0/HoXSN/qN8sWgOX8dX8KJ93U9KJwBYbeVciiY8l2
         Z+L+hVVz6AHS2m2TH36Qcj9lSQqK07P488a+6Z6D8Ya5vj81Lz5mng7+CTl5Q6h0z2Hf
         cHcmByZGOjdwOYBkcoyll/Uttby692gm3whXrech259oknOWdnrm6xYNo+7i7Ru5QUzW
         cHKZZGEBEy2sHDqFpd1pJyhivAnAAit0OBAOoRacPxG2MCs4XHXaCV8BryA9oJVzgFKz
         4q8QcqDH2f1uYb8tfxILRD8k1Xz453zct35B4b7RjDDRzJMGuF4TT/m4v1IqDsT0wsAk
         VmJw==
X-Forwarded-Encrypted: i=1; AJvYcCVlx793zPPxcncrFUKFpeSKnkRHwNc2VQZGHNNqbUHuES2f3IM1Wbs4a1KSXzsBVOPmibs65rgfFUPfXoCfaxOdBU0E/wAqDpr7k2xC
X-Gm-Message-State: AOJu0YxHMwtTBISCFTWj45YIlzLObs6CMiODuN+6TOKzK/v+QpSTbRtv
	X41mvOGxL3UmeR8X/rlSmRVobrtTLPXKk45Mm69PvQ55zCqPlibSVJKRySL6f9tWQ+JoOVVPzrU
	n2aAiJHabXsArEzpLCd2Hjh0f85ZcuGB4NcT0uA==
X-Google-Smtp-Source: AGHT+IHAm2fBmrQhHV7d9pkXTo1TXF52TvZmasaotKHPoqJb1i0QzR+yphqcCbHgfWNJf0aQVhCvB7tHGxAWY2zM63Q=
X-Received: by 2002:a17:907:9953:b0:a3e:526b:1bc2 with SMTP id
 kl19-20020a170907995300b00a3e526b1bc2mr7332615ejc.40.1709105840265; Tue, 27
 Feb 2024 23:37:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227155756.420944-1-stefanha@redhat.com> <aa41ac4e-c29d-4025-b1c3-8cdc9830b5f7@infradead.org>
In-Reply-To: <aa41ac4e-c29d-4025-b1c3-8cdc9830b5f7@infradead.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 28 Feb 2024 08:37:08 +0100
Message-ID: <CAJfpegsjcZ-dnZYft3B5GBGCntmDR6R1n8PM5YCLmW9FJy1DEw@mail.gmail.com>
Subject: Re: [PATCH] virtiofs: drop __exit from virtio_fs_sysfs_exit()
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 27 Feb 2024 at 23:31, Randy Dunlap <rdunlap@infradead.org> wrote:
>
>
>
> On 2/27/24 07:57, Stefan Hajnoczi wrote:
> > virtio_fs_sysfs_exit() is called by:
> > - static int __init virtio_fs_init(void)
> > - static void __exit virtio_fs_exit(void)
> >
> > Remove __exit from virtio_fs_sysfs_exit() since virtio_fs_init() is not
> > an __exit function.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202402270649.GYjNX0yw-lkp@intel.com/
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>
>
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Applied, thanks.

Miklos

