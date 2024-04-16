Return-Path: <linux-kernel+bounces-146186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 057CF8A61CB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 05:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 891941F23A59
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 03:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3261AACC;
	Tue, 16 Apr 2024 03:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UH/TkX03"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28C515AF6
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 03:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713239190; cv=none; b=n67d1MuoYEpmmcbn86fFR0vbRj8x6r0DewuSW1AVFDAMluGh5E6qmyMmXJ5qnkLi8+EnDeZqoNhPA5u4YbRCvUVm7mcujPQyXynumR/oWBN8/YFqwzFeeq6q5EO3Ui67WiolWzG+0tCSZSwj7BD6WhgmlumXKeIqIt5PDWdGP2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713239190; c=relaxed/simple;
	bh=5AHDPoNYz6OYyTQyPh89LCxQ98eQH/ZTlnsO1SaMREA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dQb/ktuoxgc4VIiboIaCtGCUsOq2VsKScTmyGwDhH//XMlbMNEUbhBXnbB7IgbxRCfPps4yHbh5DwcwMD1ONldfukxrP9cmhUiI1/YQmN7jTv7wr8i9kzlBloaN9yEk1P7QJxLdUF1Ys6NzH7Bl0bvCFnGKBbtbMNx2uysm26oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UH/TkX03; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713239187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZZDbR0tmZA4tU6Egi/VdC3qpLsZIOkOjLEJ7+EXDz74=;
	b=UH/TkX03E7QYDcRz+oQ530VqRLQVaZWHux/9TYZKwb5CkHFlIeQX3biBvf8+uRwiKRd0c8
	sOOwcCPRUGcPZVLuYXLCyTF2SLbhMQVvU529ntfo1z7ZSxS78H5yUr8zu0u6U5McZZw5nv
	LGydW33Z7EI+iNLqR849hMsMFoeW1to=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-bY-cuf55NQSxXfO8i3kVrA-1; Mon, 15 Apr 2024 23:46:26 -0400
X-MC-Unique: bY-cuf55NQSxXfO8i3kVrA-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6ed663aa4a7so2500429b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 20:46:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713239185; x=1713843985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZZDbR0tmZA4tU6Egi/VdC3qpLsZIOkOjLEJ7+EXDz74=;
        b=XvcnFwsiq0FD8Gd7jc7UmijaJtBvcm9uHroNqq1DAYpF8UM4cIlC/zLEXQqyBXKJeM
         /UQ6vRqjN0HISHIM0W6xRQePeN20y7/GkRaPJzkQa8gfmCree/fsyuNn6sDWbvo1D+dJ
         dy1YiuAgRz4bwIwJwFSfkroXMlM1kBkyUz6I3FouuErFQItfIWBoDaEKptaDXZ5Df/xk
         aURoD4440OHdWr5ZRAM4mavqXn8wRe+DW7U6RCp6kh+yAbxQLFc4UQKvPX7meCA9gWEi
         FuThPp2K0k/VSkdq0STj0/1VvkNCP9bRD6lv7VWKoDmMsHYSgJ6uTZokrwXXVIBNbVTg
         aglA==
X-Forwarded-Encrypted: i=1; AJvYcCVxY1rc2fpcbRuK3Fk/ATjmIU8lC/BFpUBv61/6bF2Q89GwX9RjSJedNidQ65XXrHcOiiCVIHrsgDVLPbDKSC0ADfeeWvtMWqeKxj4I
X-Gm-Message-State: AOJu0Yz1yZtqSK2Zq2uKDK/rZWk086v27Wmn7CWElG4zs7uSUSO43I3u
	xUt9eetNq7y+gg1iAliw3eEnM38KXCVrZdUdBHNA7RORBgoORpm9wwtqYOghcXNNgWSDr3pkTUw
	3Z6DO2Rn98XmhcgM0UG6w1/2Rj/YuVOcVb+iYn+xoRCgAPmxIeOKspzufjHoZUDioT+tPSTMAXx
	FLjFGqSiIlR5TYustspeDlxM12hUyrbFQHCBA2
X-Received: by 2002:a05:6a20:9794:b0:1a7:bb6d:6589 with SMTP id hx20-20020a056a20979400b001a7bb6d6589mr9991417pzc.29.1713239185036;
        Mon, 15 Apr 2024 20:46:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECsgVpj59BkwFlZnMgbtejU9EUN4yHlVQ2ayU0ha7t4veTjEQGaado8SRmWHQWczu46plU8EdMhF53J+KNXtw=
X-Received: by 2002:a05:6a20:9794:b0:1a7:bb6d:6589 with SMTP id
 hx20-20020a056a20979400b001a7bb6d6589mr9991405pzc.29.1713239184690; Mon, 15
 Apr 2024 20:46:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412133017.483407-1-lulu@redhat.com> <20240412133017.483407-6-lulu@redhat.com>
In-Reply-To: <20240412133017.483407-6-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 16 Apr 2024 11:46:13 +0800
Message-ID: <CACGkMEt3qpm=3Y=CDeA1Kyd7te-Wm-gk3j5iR96=_CaP0PrVtQ@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] Documentation: Add reconnect process for VDUSE
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 9:31=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> Add a document explaining the reconnect process, including what the
> Userspace App needs to do and how it works with the kernel.
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  Documentation/userspace-api/vduse.rst | 41 +++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>
> diff --git a/Documentation/userspace-api/vduse.rst b/Documentation/usersp=
ace-api/vduse.rst
> index bdb880e01132..7faa83462e78 100644
> --- a/Documentation/userspace-api/vduse.rst
> +++ b/Documentation/userspace-api/vduse.rst
> @@ -231,3 +231,44 @@ able to start the dataplane processing as follows:
>     after the used ring is filled.
>
>  For more details on the uAPI, please see include/uapi/linux/vduse.h.
> +
> +HOW VDUSE devices reconnection works
> +------------------------------------
> +1. What is reconnection?
> +
> +   When the userspace application loads, it should establish a connectio=
n
> +   to the vduse kernel device. Sometimes,the userspace application exist=
s,

I guess you meant "exists"? If yes, it should be better to say "exits
unexpectedly"

> +   and we want to support its restart and connect to the kernel device a=
gain
> +
> +2. How can I support reconnection in a userspace application?

Better to say "How reconnection is supported"?

> +
> +2.1 During initialization, the userspace application should first verify=
 the
> +    existence of the device "/dev/vduse/vduse_name".
> +    If it doesn't exist, it means this is the first-time for connection.=
 goto step 2.2
> +    If it exists, it means this is a reconnection, and we should goto st=
ep 2.3
> +
> +2.2 Create a new VDUSE instance with ioctl(VDUSE_CREATE_DEV) on
> +    /dev/vduse/control.
> +    When ioctl(VDUSE_CREATE_DEV) is called, kernel allocates memory for
> +    the reconnect information. The total memory size is PAGE_SIZE*vq_mum=
ber.

I think we need to mention that this should be part of the previous
"VDUSE devices are created as follows"?

> +
> +2.3 Check if the information is suitable for reconnect
> +    If this is reconnection :
> +    Before attempting to reconnect, The userspace application needs to u=
se the
> +    ioctl(VDUSE_DEV_GET_CONFIG, VDUSE_DEV_GET_STATUS, VDUSE_DEV_GET_FEAT=
URES...)
> +    to get the information from kernel.
> +    Please review the information and confirm if it is suitable to recon=
nect.

Need to define "review" here and how to decide if it is not suitable
to reconnect.

> +
> +2.4 Userspace application needs to mmap the memory to userspace
> +    The userspace application requires mapping one page for every vq. Th=
ese pages
> +    should be used to save vq-related information during system running.

Not a native speaker, but it looks better with

"should be used by the userspace to store virtqueue specific information".

> Additionally,
> +    the application must define its own structure to store information f=
or reconnection.
> +
> +2.5 Completed the initialization and running the application.
> +    While the application is running, it is important to store relevant =
information
> +    about reconnections in mapped pages.

I think we need some link/code examples to demonstrate what needs to be sto=
red.

> When calling the ioctl VDUSE_VQ_GET_INFO to
> +    get vq information, it's necessary to check whether it's a reconnect=
ion.

Better with some examples of codes.

> If it is
> +    a reconnection, the vq-related information must be get from the mapp=
ed pages.
> +
> +2.6 When the Userspace application exits, it is necessary to unmap all t=
he
> +    pages for reconnection

This seems to be unnecessary, for example there could be an unexpected exit=
.

Thanks

> --
> 2.43.0
>


