Return-Path: <linux-kernel+bounces-85469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F5086B675
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39D51B24850
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7079415E5A8;
	Wed, 28 Feb 2024 17:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjrF+WcI"
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C407208D2;
	Wed, 28 Feb 2024 17:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709142823; cv=none; b=hcXJq5vde6fpkHcjeLftzupt0EhFsDXu/TfNdIJ+ZCz/IwR9KEiujxa3ZBhtJg5HI0b8JLiIPY0yFFkCsTWlHl6U9SslMHLizChoEjbiVl0lq4+PiHUV1IhE3cTwTajGX6MQSjU+uF859fUQWfh2jmz1ayHN4mkmeDAJlb8NNOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709142823; c=relaxed/simple;
	bh=LXfHA3dCGDNxmUPr2jMG1cF0psgm9mzwYPfFa63rcSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d5ifZ6BMpi7c46rjYjCT4K0BJJ7LBaqTAQTxmh01N7Bq+B7ZIJny/LhqnNGUbuPbj/MsCd+4f4ZZ4ttbKuGXy1l+V44n/DYaQhogVAgv5g3DMtADAfeVBS1Kq+j3CiZP4iifR7HoDJG4a6JTfd9JDsh2WsSJlF870981WsyFfQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WjrF+WcI; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5a0919f2022so2707eaf.1;
        Wed, 28 Feb 2024 09:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709142821; x=1709747621; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YTms7y6gBlfM5rqkqnuoQOJmNRtZZ8spMxgJ/p47Svk=;
        b=WjrF+WcIXhu5oQhpTDaOBjDQJItvDQPzu9NfUIKRsx73ifJp8lVdauRya235Cw7MQg
         gWuD6vgEhobMwzmXrZthR9flcVd4+91xSN5G1OTfiF1SEooKPLNQrS0SvWuLS/TQS+v4
         Ppw8/PLZLA4RwlqoiHp43+BiqnOPTQC5oHQ6z0dX0RenbZ84CjKHIofEFOLn9zLMosBT
         d5+wSgOXECDlcOTZjg/JUNlXhiRPDWB3P8l8C5UMTHSeKwE/X97xbVxwr5odFWc3/3fp
         y/MQD7GLUYPw766FGpOxUgmKqHngRDZKJt8X+sqWTDAqqzeV7si8uU7hGEEBZVIFGSsQ
         +kXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709142821; x=1709747621;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YTms7y6gBlfM5rqkqnuoQOJmNRtZZ8spMxgJ/p47Svk=;
        b=L5HXMQSR0/T53EmApYW+yZtQsKz8ZjxSRTxT706MFLcsngRPYcK5qJG4Bden02BBWv
         oCKpv4r6Ki3HrAnU3NTyeZxGlyWSak5GysKcuDn3FhIWpKfkt69asefGeB7gn3Woo3pS
         um693uCHpEnPJhV2LhupcV2sj90FC/pq+xDNyhmVNI/ZXspIPKgU1rx04sKCKVq32FMe
         00HxA7v6s7tMYm18Osw6PjXg58zz8gRGFwWknlb+pL4zZWSrYMFOWm3Wh27K9nTUQTAH
         D8iAsmdnMIVyrs/nm8zPZF7G/6tDqizUBpg3tnTmypjG6aPXVVTVLgmWuYVOcKy40ERh
         Vt6Q==
X-Forwarded-Encrypted: i=1; AJvYcCW2a8az9JDYs6zMoUZF4MT+csu1hu8TLoCgi393tXS7AfChgQU/UhONsFNK+mNofZKw01mPJ8zF9Pm50YzX8Zzl4bwe6HuppsSHnwjVDjElD5gV71ALOplIMjjtcyx97AeYCEDLbc8TAn0IrBTE
X-Gm-Message-State: AOJu0YxsFBxrT/RJPDl0LTdrPpqOfqx3TFIUigZOA/uleLyzG3psrUe0
	yLIA502/VPTjQ7lqnfmFeoezczq+hV9k0cYjUhkMygcdDT/k1WmrfQMb36c/FuKNBTIXeGcsLuA
	c72eG2wv8teba1UZLO0MYKu9T14s=
X-Google-Smtp-Source: AGHT+IHkShvoS3j34PpGZRdJpuildkNUMYe35bZWqGOxz31gFD0leWwH221mlvIRgK4ri/3cGJzWg3ZL+/JJmI+oCpE=
X-Received: by 2002:a05:6820:d8e:b0:5a0:e1c1:5014 with SMTP id
 ek14-20020a0568200d8e00b005a0e1c15014mr216278oob.0.1709142820730; Wed, 28 Feb
 2024 09:53:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e2361611-e8e3-4c6a-9f71-30e81a65f793@moroto.mountain>
In-Reply-To: <e2361611-e8e3-4c6a-9f71-30e81a65f793@moroto.mountain>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 28 Feb 2024 12:53:28 -0500
Message-ID: <CAJSP0QVYUrkbk6beMB6nW1q9G3jMqeDzGwMagyXh1B1skFdHjQ@mail.gmail.com>
Subject: Re: [PATCH v2] vduse: Fix off by one in vduse_dev_mmap()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Xie Yongji <xieyongji@bytedance.com>, 
	Maxime Coquelin <maxime.coquelin@redhat.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Christian Brauner <brauner@kernel.org>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 Feb 2024 at 12:44, Dan Carpenter <dan.carpenter@linaro.org> wrote:
>
> The dev->vqs[] array has "dev->vq_num" elements.  It's allocated in
> vduse_dev_init_vqs().  Thus, this > comparison needs to be >= to avoid
> reading one element beyond the end of the array.
>
> Add an array_index_nospec() as well to prevent speculation issues.
>
> Fixes: 316ecd1346b0 ("vduse: Add file operation for mmap")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> v2: add array_index_nospec().

Did you forget to update the patch, I don't see array_index_nospec()?

>
>  drivers/vdpa/vdpa_user/vduse_dev.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index b7a1fb88c506..eb914084c650 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -1532,9 +1532,10 @@ static int vduse_dev_mmap(struct file *file, struct vm_area_struct *vma)
>         if ((vma->vm_flags & VM_SHARED) == 0)
>                 return -EINVAL;
>
> -       if (index > dev->vq_num)
> +       if (index >= dev->vq_num)
>                 return -EINVAL;
>
>         vq = dev->vqs[index];
>         vaddr = vq->vdpa_reconnect_vaddr;
>         if (vaddr == 0)
> --
> 2.43.0
>
>

