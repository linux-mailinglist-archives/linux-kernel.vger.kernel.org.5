Return-Path: <linux-kernel+bounces-91844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 883AB871769
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FB1A1F21FE8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0904B7EEEA;
	Tue,  5 Mar 2024 07:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="StM5oCsF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7AE7E795
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 07:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709625099; cv=none; b=q4lucMHtYL0TTliH8/Ei2gkf6smjin+v7vVmv1jQuKLJIsb/D3klrurLalzIJn6kITOe6PfG1m13jPWZkLRbLKm4ZXaDZ0J49sQpNm6M1rtRa42bBgi/Wbdbj5Jt8GSv8by1i8Hw2G5+sACljnB69ivS9kQWgLEXevxk3GaJh4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709625099; c=relaxed/simple;
	bh=x08LgkVUawYHuvJncaZ6caIrY6xZWC+MMA34jx+NI6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HKC3q+9deuWE6KykSpL2PNp6v1Py8PsV58Svi6j4CPLhGhgI4IxlKrZd2HVKgqX8Rw1QLB8EtmW3lHE/y8hw66JN+nrlEKVOHTzuVMp2BGN03ifJm1U1HvkucC+4UdecMcoB5CUh6Z5ryE3z7otHZTbTTqXNeSB1oVIpl0e/wik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=StM5oCsF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709625096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2oilryYyA0UsfnyVs26oEp0ZJuIY1r4NF1S3796uXeM=;
	b=StM5oCsFqO+HAiNiP+bIt/Q4+iMMz/jmF6gTGk1DkOX1KaSNwVAvn0N7rH7bta67IVwtaO
	89FywX6+TbjXSHsCdemhhXnDOLN3OKNrvbu3jIZwVMIGXYfimUgBYKHoD++nX0ZdDqshyF
	b8PfFvFKVfJDBKwZSgdqeIMndtLp7S0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-_0aIpUNpN1iSK6XvBb-qgg-1; Tue, 05 Mar 2024 02:51:34 -0500
X-MC-Unique: _0aIpUNpN1iSK6XvBb-qgg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a44143c8908so505215266b.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 23:51:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709625093; x=1710229893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2oilryYyA0UsfnyVs26oEp0ZJuIY1r4NF1S3796uXeM=;
        b=aJxT9Lrms9SdsDwfIU7ixePV+finOkMTCxVyGJd5CssGMnPbGyI+4I36cfLxahCtgl
         u1xVtVHiiLkDem7igAAxJZwxElfKl/lTu/YYMwpLxD7uKcmpjoue+s4YrJYlwnJIOFJq
         jPP7+TCRgcFQMMP6eocQgYMLDHF5r0EJWET1q27Xhk6d2ClxKzSbfpFRWlQg1fLYOQBq
         eaXzo8Xn/HnnhwslUD26xhyzpQZpihJbEaI0kyVUork5krI5yeAe5E466vlIHuy9gskC
         LU60EAQm58mnqqIAtWkrikUE4lZ6xo7rUpEVIUG+AY+217cFF55AEt5aWHq5WNxxmEgT
         5fXw==
X-Forwarded-Encrypted: i=1; AJvYcCXY4T0Rw9CI+29rNe9iJvQ/JUdMmbcDBOCEaxaXzFHV0ea0+v65fqaRvJccdpNC9KhCE7Gef4p1KF/TZE6uPX6LFXP+nNsyOB/3AFNY
X-Gm-Message-State: AOJu0YxH215QFAlEvFxnu6Gv6td3RttNqzIv6vIHJqp+uxTSYQyvH0NW
	APyfM+m6xJVd7YIN6YcLBOWFa5h0LKlpWbgiU8Si6EA/MkWr/+n+OfAyRApd2Ow0TjhKyMj7WMM
	vodzg0AbDIziqLDz4U0nbhdPW81ObOBK3mz37ddJk+VPlN6Y2KlEdLN8Y3FbbVBTRokHF2bsAlM
	EJFERSD6TzB9JEy/8X3kRsYUWvCLl+iJDGoOe7uaWcZiw8
X-Received: by 2002:a17:906:1d54:b0:a44:b96:2809 with SMTP id o20-20020a1709061d5400b00a440b962809mr2015373ejh.24.1709625093082;
        Mon, 04 Mar 2024 23:51:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFSdbM62+giiRe+gBLNNvCvd5K5cjZhfGIJSvuqjAwoA835pS4kkSb6olg0/axk0t5bglfRZGXISMHPUA0smw=
X-Received: by 2002:a17:906:1d54:b0:a44:b96:2809 with SMTP id
 o20-20020a1709061d5400b00a440b962809mr2015359ejh.24.1709625092767; Mon, 04
 Mar 2024 23:51:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207054701.616094-1-lulu@redhat.com> <20240207054701.616094-6-lulu@redhat.com>
 <CACGkMEuGwVwstzCGyYs90YjtE-QZGs1ztDKF4-gqFM_JZhSjmQ@mail.gmail.com>
In-Reply-To: <CACGkMEuGwVwstzCGyYs90YjtE-QZGs1ztDKF4-gqFM_JZhSjmQ@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 5 Mar 2024 15:50:55 +0800
Message-ID: <CACLfguW1So+TtB9V04CB21jo_BTACZSX23S+_tASHsoM=_btVg@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] Documentation: Add reconnect process for VDUSE
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xieyongji@bytedance.com, linux-kernel@vger.kernel.org, 
	maxime.coquelin@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 1:11=E2=80=AFPM Jason Wang <jasowang@redhat.com> wro=
te:
>
> On Wed, Feb 7, 2024 at 1:47=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
> >
> > Add a document explaining the reconnect process, including what the
> > Userspace App needs to do and how it works with the kernel.
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  Documentation/userspace-api/vduse.rst | 32 +++++++++++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> >
> > diff --git a/Documentation/userspace-api/vduse.rst b/Documentation/user=
space-api/vduse.rst
> > index bdb880e01132..a2be85e0e516 100644
> > --- a/Documentation/userspace-api/vduse.rst
> > +++ b/Documentation/userspace-api/vduse.rst
> > @@ -231,3 +231,35 @@ able to start the dataplane processing as follows:
> >     after the used ring is filled.
> >
> >  For more details on the uAPI, please see include/uapi/linux/vduse.h.
> > +
> > +HOW VDUSE devices reconnectoin works
>
> Typos, let's use a spell checker.
>
> > +----------------
> > +0. Userspace APP checks if the device /dev/vduse/vduse_name exists.
> > +   If it does not exist, need to create the instance.goto step 1
> > +   If it does exist, it means this is a reconnect and goto step 3.
> > +
> > +1. Create a new VDUSE instance with ioctl(VDUSE_CREATE_DEV) on
> > +   /dev/vduse/control.
> > +
> > +2. When the ioctl(VDUSE_CREATE_DEV) function is called, the kernel all=
ocates memory
> > +   to save the reconnect information.
> > +
> > +3. Userspace App need to mmap the pages to userspace
>
> Need to describe what kind of pages need to be mapped. And what's more:
>
> Does this require cooperation from the disconnected application? If
> yes, how to distinguish from the one that is not cooperative (doesn't
> support reconnection)?
>
> > +   Userspace App need to map Pages 0 to vq_number for vq status,
> > +   Users can define the structure for saving the reconnect information=
 themselves
> > +   in the userspace.
> > +
> > +4. Check if the infomatin sutiable for reconnect
>
> Typos again.
>
> > +   If this is reconnect:
> > +   Before attempting to reconnect, The userspace application need to t=
he
> > +   ioctl VDUSE_DEV_GET_CONFIG,VDUSE_DEV_GET_STATUS,VDUSE_DEV_GET_FEATU=
RES...
>
> "..." is not good, let's describe the steps in detail.
>
> > +   to get the and confirm if these information are suitable for reconn=
ecting.
> > +
> > +5. Start the userspace App.
>
> I had a hard time understanding this, does it mean the application
> needs to restart itself?
>
> > +   While running, the application should store the relevant informatio=
n about
> > +   reconnections in mapped pages.
> > +   When calling ioctl VDUSE_VQ_GET_INFO from the userspace APP
>
> Abbrev is not good here. Let's use "application" for consistency.
>
> > to get vq information, it is necessary
> > +   to check if this is a reconnection.
>
> How to check whether or not it is reconnected?
>
> > If a reconnection has occurred, the vq-related information
> > +   must be get from the mapped pages.
> > +
> > +6. When the Userspace App exits, it is necessary to unmap all the reco=
nnect pages.
> > --
> > 2.43.0
> >
>
> Thanks
Thanks Jason, I will rewrite this part and send the new version soon

Thanks
cindy
>


