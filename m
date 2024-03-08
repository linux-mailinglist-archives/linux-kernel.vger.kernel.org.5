Return-Path: <linux-kernel+bounces-96583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34BBE875E8A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9A4EB22A42
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 07:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061EA4F208;
	Fri,  8 Mar 2024 07:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PPlmHBSD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B404EB5E
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 07:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709883033; cv=none; b=kcO6UZTCBFMKyhUWYhC20P3mIuMoxKCupnM4HpVH2WwAKCSb7jb2Ni2yV/+KEipGCcZmZNO496q8xBbWFAmsyhjaDKQhX6ih2NGEzTToND6oGMrL5L14vGbKi19xMecWNGDzu5NuyZjWASRX+jRGoHfQDpilo3ONQOfSP3Z7wV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709883033; c=relaxed/simple;
	bh=JI6X/1oxXKRGzaqJiYWzImYR7bDVfeSGg2lv8f47Iu0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O031xmFfMJ9P7+2WV355+0KHPykhelUbmC0ZMgJRMaoJ/u9GgqKFdZFfV94jicXBBIaIacPJ6lBjuF4q6nUTj12Au4xYua4m68SW1+Fn4NYWGyURjgPuGSSlVwgSzoNNprbS/wrfgw7SlWw3G5GzevoVK/IzIylJ0hbii12Ak0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PPlmHBSD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709883030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gGQKkU6/UygYoUdjgKbHFdVwK+i8/6tQW3le6JZfFdM=;
	b=PPlmHBSD8Rtwu1ltFh1XtRYQwgEM26N/1idfG27t6BFbp3pP9F1XyU+kAp63mSgNLXtPww
	ZlMBqOWcHh5jiE0e/2Nlh2nTqXEeSZEsc8B2kCz8EzP2CHgtZ9Q0fkhZjan5S6RzwmSPYQ
	eAZ5l2UN6cJNrkvoVRtsUAEfoySOce4=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-VVWyvklZNIOS4IQjK4u0qg-1; Fri, 08 Mar 2024 02:30:28 -0500
X-MC-Unique: VVWyvklZNIOS4IQjK4u0qg-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-5135cb04b9fso2140227e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 23:30:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709883027; x=1710487827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gGQKkU6/UygYoUdjgKbHFdVwK+i8/6tQW3le6JZfFdM=;
        b=HOEjRF763bHR0PgdNsEdDbQq8oBhvsLY0Jeb5qor+Kb1kLnzVyihSyTGHKDq3obmip
         a/uS7wmciuhFitsN+EHI1/WQEx8pnYg1JXvmImAkjmK5nnnwo+R/neCv8aBI+8/4HUo8
         vTeECiuwshOwPeYmpxyk9hvfe3yAPH/+j/BHtJGEqXWGwREswOACQjZjgCw7IWUAUO9v
         DYCRDU2Q3jtB8B+dh5XZdilATqmrRMxnsYVcOc0VnDFWDvZzo2YMNFZ2GbOGJ8CrynWm
         ylA0kt2k9BQ8fumotmX0C1sRpDhXLGxbgNGf8r7HyBxpjTSvGjp3cztVy902p3U/AYN2
         CR6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWOZ6JMi2v1aP/7kZ1Scz+++BE5sB9sE+cXd5i5XiaGHNwFQr9oaqYBgwM0toiOLd3GSli7BmVHRgvPRtMLAG9ruSHgpogC4SKpYsbt
X-Gm-Message-State: AOJu0YyuewmPK+LxQ0y58t3P7chtbzLjtDSwYfX5MJe4EGLVwzKWsgYn
	VKEcfmYVUypVolarKNhL0jG35szQZsiYQQPr47BlS32K2OZ+rmc2RRzaDWy+logm4gwAqBJULRh
	dTmlAcIyI4SDBxUOOnevOR9er6TbK/kUSoAzYI66wPwuiB8bGa7Et+ntFM34rC05BvdhsTLZr9z
	nob/oV7EURkjc+Fcqj+jiwihuvdBPw6REBdJTj
X-Received: by 2002:a2e:93d7:0:b0:2d2:748a:58a4 with SMTP id p23-20020a2e93d7000000b002d2748a58a4mr2822375ljh.27.1709883027559;
        Thu, 07 Mar 2024 23:30:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEed/sRz3FrBnvSU/lQCVfYBJNcCsQeCfT9j446hNYUGdmFqahS2Lpn5cRhj2eFmp4fIFL4DV57IHvT0mNZHbw=
X-Received: by 2002:a2e:93d7:0:b0:2d2:748a:58a4 with SMTP id
 p23-20020a2e93d7000000b002d2748a58a4mr2822361ljh.27.1709883027233; Thu, 07
 Mar 2024 23:30:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207054701.616094-1-lulu@redhat.com> <20240222141559-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240222141559-mutt-send-email-mst@kernel.org>
From: Cindy Lu <lulu@redhat.com>
Date: Fri, 8 Mar 2024 15:29:50 +0800
Message-ID: <CACLfguXQ3c91-Xpb3rzpoF9kxwnah=CJa_igk5j5p93_0JnRAQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] vduse: Add support for reconnection
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, xieyongji@bytedance.com, linux-kernel@vger.kernel.org, 
	maxime.coquelin@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 3:18=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, Feb 07, 2024 at 01:43:27PM +0800, Cindy Lu wrote:
> > Here is the reconnect support in vduse,
> >
> > Kernel will allocate pages for reconnection.
> > Userspace needs to use mmap to map the memory to userspace and use thes=
e pages to
> > save the reconnect information.
>
> What is "reconnect"? Not really clear from documentation - it seems to
> be assumed that reader has an idea but most don't.
>
> Also what's with all the typos? reconnect with 3 nnn s, sutiable and so
> on. Can you pls run a speller?
>
Thanks a lot, Micheal. I will fix these and also update the speller
thanks
Cindy
> > test passd in vduse+dpdk-testpmd
> >
> > change in V2
> > 1. Address the comments from v1
> > 2. Add the document for reconnect process
> >
> > change in V3
> > 1. Move the vdpa_vq_state to the uAPI.  vduse will use this to synchron=
ize the vq info between the kernel and userspace app.
> > 2. Add a new ioctl VDUSE_DEV_GET_CONFIG. userspace app use this to get =
config space
> > 3. Rewrite the commit message.
> > 4. Only save the address for the page address and remove the index.
> > 5. remove the ioctl VDUSE_GET_RECONNECT_INFO, userspace app will use uA=
PI VDUSE_RECONNCT_MMAP_SIZE to mmap
> > 6. Rewrite the document for the reconnect process to make it clearer.
> >
> > change in v4
> > 1. Change the number of map pages to VQ numbers. UserSpace APP can defi=
ne and maintain the structure for saving reconnection information in usersp=
ace. The kernel will not maintain this information.
> > 2. Rewrite the document for the reconnect process to make it clearer.
> > 3. add the new ioctl for VDUSE_DEV_GET_CONFIG/VDUSE_DEV_GET_STATUS
> >
> > Cindy Lu (5):
> >   vduse: Add new ioctl VDUSE_DEV_GET_CONFIG
> >   vduse: Add new ioctl VDUSE_DEV_GET_STATUS
> >   vduse: Add function to get/free the pages for reconnection
> >   vduse: Add file operation for mmap
> >   Documentation: Add reconnect process for VDUSE
> >
> >  Documentation/userspace-api/vduse.rst |  32 +++++++
> >  drivers/vdpa/vdpa_user/vduse_dev.c    | 125 ++++++++++++++++++++++++++
> >  include/uapi/linux/vduse.h            |   5 ++
> >  3 files changed, 162 insertions(+)
> >
> > --
> > 2.43.0
>


