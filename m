Return-Path: <linux-kernel+bounces-90053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF31E86F968
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 06:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F15D1F218F5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 05:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C916ABF;
	Mon,  4 Mar 2024 05:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TliRnDVd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E589728FC
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 05:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709529079; cv=none; b=LGHK0nnnBJmUE2frFYF64jwghkFEC8m7fgwEnd5L66ceDLyBZLv7+L8MZpgyxfzDsqByPt1Y0nw9vPJeabhuS7Bziqi1AhGScJXF2Blg2fqBW1nBFHMpYCwa8uAYUnDzsw7XTY6YUMnIV8sZ5/komMpZEoEtik4AESgjw2lMWp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709529079; c=relaxed/simple;
	bh=ZOYW8UTMBYJQ6axlQIR7e8zg+0bO/l0sGmvwj+Klrdg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AmjnwKWgryelyOXNNWgTKKzAEvc1gkawEJF1YtNHZj+KjEL735YbX2kOqmFdVGoTyfpJDGg+2K9WkG27wjCnM5mxTTVYqnZ6jmayDpXsjsYNixNDdN8R444dPFt441eovRKp5oxQwDtr2+nhXc3falKFbaxRAGX88hMIJHzf/k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TliRnDVd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709529076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VNtSjcwA+rZxPvjqQS2ZPVR3ZuvVQM7xXjlLPshD5do=;
	b=TliRnDVdj340WlTdhj5zqOxFgRvvLIqBxX0aj6T12MJgQ0KAuBIOQCkjo7IgS0T7NB47fL
	JtqW/WYb8DJ/IGO0RVMjgxohT3s8FMa28BUyb2AjVCiNRb5O5F0blIq9Rc1kXCmDyCWto/
	1Y4HTOOd9BVEp+CXT1Db6Pl6WEagH+4=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-poOAT-8KNDWO-auA0ze_1w-1; Mon, 04 Mar 2024 00:11:14 -0500
X-MC-Unique: poOAT-8KNDWO-auA0ze_1w-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-29954faf16dso3179833a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 21:11:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709529073; x=1710133873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VNtSjcwA+rZxPvjqQS2ZPVR3ZuvVQM7xXjlLPshD5do=;
        b=CWp75gMUnMtzM1kkMKOlPJa1M1YZGc5nFe46LfI1L6A5mMmj3zbjDT+naAcyua7wPl
         U6IAsh3G81G8bfNEBKz1PIqTBLksLUWQ6Le/EUYn7RJ5ef9jBSSraGmVZX2Fu7Iec4uc
         aWwMnkWXSHGcwUfJhvP/KU/FxvA6pQeBOGsCcqG0YLTUIfIa4F0EexJG63n9g47Qv+Fn
         XIp2hEQMY9083Bk0b6R0aXFjTlT1IPeMOmbogwKDxAbkqGHHrwq9ZhwBTg1yFNGC4JmV
         QI73ax+XbvW3G2OU0KkFaAUdHQ1FLJphQstIo535AVwR0unm/2BKvkUoUfec8eTaYzoE
         ekkw==
X-Forwarded-Encrypted: i=1; AJvYcCUGXAJqclY/HwjW2CsrSO/6vj/TCONTCV/GmHG/E72/+DgMTMpFtI0yvY+Oa4T7QCj4lNG9FzwN+FidE4nZdSSI+Z3n4MX2oKIMyIZu
X-Gm-Message-State: AOJu0Yz91+pZcB8kcQBUvZ42jl2MrrR0+9ZuhIL/PQVBlo3Nzs3/oJfz
	4gpuFc0etDTyh32Gj/WD8AvHqFc5ndnnixtOKd+nfW4JCf4jqDvTcTZVRmeIxrdzgACbZ2rC6t0
	sVkm9o1cEAdHkgeBAbMwjuzRTxLPATyB6/xfeHAMAdnxP8hFua8iydY8w8lb/4KYegxn7kKDTxC
	EB+vFID+vwKizU0NbLwFmwwVxhsA9p+WssrDEY
X-Received: by 2002:a17:90b:4d91:b0:296:f2d5:6567 with SMTP id oj17-20020a17090b4d9100b00296f2d56567mr10845344pjb.4.1709529073569;
        Sun, 03 Mar 2024 21:11:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGTvvRy71qBU2Sm7ohelOZtP1t+4VAgk6pSsu8CZIjm3Tj7+TC2Ap5yN47Wk/l6tTwscQQm97wyQISa0K29L+s=
X-Received: by 2002:a17:90b:4d91:b0:296:f2d5:6567 with SMTP id
 oj17-20020a17090b4d9100b00296f2d56567mr10845332pjb.4.1709529073243; Sun, 03
 Mar 2024 21:11:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207054701.616094-1-lulu@redhat.com> <20240207054701.616094-6-lulu@redhat.com>
In-Reply-To: <20240207054701.616094-6-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 4 Mar 2024 13:11:02 +0800
Message-ID: <CACGkMEuGwVwstzCGyYs90YjtE-QZGs1ztDKF4-gqFM_JZhSjmQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] Documentation: Add reconnect process for VDUSE
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, xieyongji@bytedance.com, linux-kernel@vger.kernel.org, 
	maxime.coquelin@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 1:47=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> Add a document explaining the reconnect process, including what the
> Userspace App needs to do and how it works with the kernel.
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  Documentation/userspace-api/vduse.rst | 32 +++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/Documentation/userspace-api/vduse.rst b/Documentation/usersp=
ace-api/vduse.rst
> index bdb880e01132..a2be85e0e516 100644
> --- a/Documentation/userspace-api/vduse.rst
> +++ b/Documentation/userspace-api/vduse.rst
> @@ -231,3 +231,35 @@ able to start the dataplane processing as follows:
>     after the used ring is filled.
>
>  For more details on the uAPI, please see include/uapi/linux/vduse.h.
> +
> +HOW VDUSE devices reconnectoin works

Typos, let's use a spell checker.

> +----------------
> +0. Userspace APP checks if the device /dev/vduse/vduse_name exists.
> +   If it does not exist, need to create the instance.goto step 1
> +   If it does exist, it means this is a reconnect and goto step 3.
> +
> +1. Create a new VDUSE instance with ioctl(VDUSE_CREATE_DEV) on
> +   /dev/vduse/control.
> +
> +2. When the ioctl(VDUSE_CREATE_DEV) function is called, the kernel alloc=
ates memory
> +   to save the reconnect information.
> +
> +3. Userspace App need to mmap the pages to userspace

Need to describe what kind of pages need to be mapped. And what's more:

Does this require cooperation from the disconnected application? If
yes, how to distinguish from the one that is not cooperative (doesn't
support reconnection)?

> +   Userspace App need to map Pages 0 to vq_number for vq status,
> +   Users can define the structure for saving the reconnect information t=
hemselves
> +   in the userspace.
> +
> +4. Check if the infomatin sutiable for reconnect

Typos again.

> +   If this is reconnect:
> +   Before attempting to reconnect, The userspace application need to the
> +   ioctl VDUSE_DEV_GET_CONFIG,VDUSE_DEV_GET_STATUS,VDUSE_DEV_GET_FEATURE=
S...

"..." is not good, let's describe the steps in detail.

> +   to get the and confirm if these information are suitable for reconnec=
ting.
> +
> +5. Start the userspace App.

I had a hard time understanding this, does it mean the application
needs to restart itself?

> +   While running, the application should store the relevant information =
about
> +   reconnections in mapped pages.
> +   When calling ioctl VDUSE_VQ_GET_INFO from the userspace APP

Abbrev is not good here. Let's use "application" for consistency.

> to get vq information, it is necessary
> +   to check if this is a reconnection.

How to check whether or not it is reconnected?

> If a reconnection has occurred, the vq-related information
> +   must be get from the mapped pages.
> +
> +6. When the Userspace App exits, it is necessary to unmap all the reconn=
ect pages.
> --
> 2.43.0
>

Thanks


