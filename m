Return-Path: <linux-kernel+bounces-148169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF158A7E9E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 186101F223A6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1B22744B;
	Wed, 17 Apr 2024 08:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ecxweKRO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DAA5D8F6
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 08:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713343650; cv=none; b=diKohfEvjH9bPX/8iJ3ZyeTiFLabHzpZpXmVYcutAn9bb9zwXM4jRlv5NHZMDIO+OCNgrmYbOs+Wezzmlo0vfMSmdropNs3hPRgVx3hFsEweldntlI0epDBRLCLzWoREsGgWH6q9m+o9C8eRplXuHL7L5qcqjL0m88dfvMQ2avQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713343650; c=relaxed/simple;
	bh=2B5PS/6d09LZj1e+zLCuQV4GCMrqEJtQcCFNgI2Utb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g5uX31cfxEp2g7v1beic8AbKKme9cO2vwxUaOR4URz1jyRaz966Y8aRE4LbmhI5zeOc2deLOldP3qVvwBN9sO5Ms8UQ2dxPzaiiRari/99MwGo96RskLnMm+j1zCHs1A7mdOnmYbiA3PeGLugc90omAoTKpTdu98L2oHeA8HBCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ecxweKRO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713343646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X6wF7/7+EUHH57/t9RpDsNBwadh/aqSlofB+nlzD4Zs=;
	b=ecxweKROmCs40McK8tWTU7uEEOKWtxPW9OatVLmFoKc2sk8f0lg+Q0fr+Ue1ZZEp7qIyoy
	rZIixc87TZswbc1gJj0syE4KBcNg/XiDz+dy8RAJ9FTVUzwiP84n29qNtZGftzblux1fDz
	WFZX+IoJbjq+FiDyCDbwAOhdfzwhH7g=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-Cl7ILyyiM_GhV5p-XuqTjg-1; Wed, 17 Apr 2024 04:47:25 -0400
X-MC-Unique: Cl7ILyyiM_GhV5p-XuqTjg-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-518b4b45e91so3850450e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 01:47:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713343643; x=1713948443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X6wF7/7+EUHH57/t9RpDsNBwadh/aqSlofB+nlzD4Zs=;
        b=aJQoaDXXQOA8R9C1vcWeBGQvKUUlX1bmUjIqY6d1OTsuXUG7Xdt7mPI8zSb7ABGTTR
         qlznG5spogfnphyUaUvIoBnn/aE0qHyAx5R5XiiTKzizEmbF6FrXnnq2Er0IYJs06VoZ
         a4aXyLEm3HHjDUZLwdjfhT8dEdfIE0/8l67DF6AhcRzB4/BCSGdGVZXpujeniwnC5rfG
         EClEqgKDKleXxrn+iPYjCaRKM9YzJDBeK8JRPNtMgpCTgc3i/KxoXgVu3AEkxlLwulVa
         GqgtAcoUWWCKMl2rcS2jc7YntSl1kMzKTgXLyV62JFXo8ezdMO2Otlqg/DqqjLZOjEQp
         Jkqw==
X-Forwarded-Encrypted: i=1; AJvYcCUpscb6j99XU+YwYZ8hPHORjOJuT0aiZg9wWgojQ9BSySnqIuZ37YHiLttbdQGQNCgRgIeqlAHlfebJGNhKKNScGJTUdC7QSYDFMy5K
X-Gm-Message-State: AOJu0YzVY56fEGVhazteF6k6EeuojkNOE+0E2wJBPTZcgSaDwpg5Ghdh
	cu3f/PbuWMwCVSCBYzE9KTfByXrmN5kEUucupveZiwq8g+BES7k+KLuYskW1Phzow5dMQSGF+Uy
	+AATjYTRPhSyjuu/PykouVyJNW7KKYwdVtRpko877nubDBO4kuExV5wreVwesZIkqIml7G1Heo4
	Nq/GjMjR65GCkkSa49v6B+Clwxhjt2enh7ES56
X-Received: by 2002:ac2:4644:0:b0:518:6e71:13be with SMTP id s4-20020ac24644000000b005186e7113bemr11623238lfo.51.1713343643608;
        Wed, 17 Apr 2024 01:47:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEnbNAaG2pgLH1zH3tK8yuWdjHVWpGGrmPm1B0xt/ug9cB1g+OElPTMbQN4sBuo3dA12Dh5KtBsnQn45/ZBc8=
X-Received: by 2002:ac2:4644:0:b0:518:6e71:13be with SMTP id
 s4-20020ac24644000000b005186e7113bemr11623220lfo.51.1713343643245; Wed, 17
 Apr 2024 01:47:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412133017.483407-1-lulu@redhat.com> <20240412133017.483407-6-lulu@redhat.com>
 <CACGkMEt3qpm=3Y=CDeA1Kyd7te-Wm-gk3j5iR96=_CaP0PrVtQ@mail.gmail.com>
In-Reply-To: <CACGkMEt3qpm=3Y=CDeA1Kyd7te-Wm-gk3j5iR96=_CaP0PrVtQ@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 17 Apr 2024 16:46:44 +0800
Message-ID: <CACLfguVnQV1qaZeOXi5=T7KbGNEPibmUOXv_r8HZpcU0CMbgGQ@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] Documentation: Add reconnect process for VDUSE
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 11:46=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
>
> On Fri, Apr 12, 2024 at 9:31=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
> >
> > Add a document explaining the reconnect process, including what the
> > Userspace App needs to do and how it works with the kernel.
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  Documentation/userspace-api/vduse.rst | 41 +++++++++++++++++++++++++++
> >  1 file changed, 41 insertions(+)
> >
> > diff --git a/Documentation/userspace-api/vduse.rst b/Documentation/user=
space-api/vduse.rst
> > index bdb880e01132..7faa83462e78 100644
> > --- a/Documentation/userspace-api/vduse.rst
> > +++ b/Documentation/userspace-api/vduse.rst
> > @@ -231,3 +231,44 @@ able to start the dataplane processing as follows:
> >     after the used ring is filled.
> >
> >  For more details on the uAPI, please see include/uapi/linux/vduse.h.
> > +
> > +HOW VDUSE devices reconnection works
> > +------------------------------------
> > +1. What is reconnection?
> > +
> > +   When the userspace application loads, it should establish a connect=
ion
> > +   to the vduse kernel device. Sometimes,the userspace application exi=
sts,
>
> I guess you meant "exists"? If yes, it should be better to say "exits
> unexpectedly"
>
> > +   and we want to support its restart and connect to the kernel device=
 again
> > +
> > +2. How can I support reconnection in a userspace application?
>
> Better to say "How reconnection is supported"?
>
> > +
> > +2.1 During initialization, the userspace application should first veri=
fy the
> > +    existence of the device "/dev/vduse/vduse_name".
> > +    If it doesn't exist, it means this is the first-time for connectio=
n. goto step 2.2
> > +    If it exists, it means this is a reconnection, and we should goto =
step 2.3
> > +
> > +2.2 Create a new VDUSE instance with ioctl(VDUSE_CREATE_DEV) on
> > +    /dev/vduse/control.
> > +    When ioctl(VDUSE_CREATE_DEV) is called, kernel allocates memory fo=
r
> > +    the reconnect information. The total memory size is PAGE_SIZE*vq_m=
umber.
>
> I think we need to mention that this should be part of the previous
> "VDUSE devices are created as follows"?
>
> > +
> > +2.3 Check if the information is suitable for reconnect
> > +    If this is reconnection :
> > +    Before attempting to reconnect, The userspace application needs to=
 use the
> > +    ioctl(VDUSE_DEV_GET_CONFIG, VDUSE_DEV_GET_STATUS, VDUSE_DEV_GET_FE=
ATURES...)
> > +    to get the information from kernel.
> > +    Please review the information and confirm if it is suitable to rec=
onnect.
>
> Need to define "review" here and how to decide if it is not suitable
> to reconnect.
>
> > +
> > +2.4 Userspace application needs to mmap the memory to userspace
> > +    The userspace application requires mapping one page for every vq. =
These pages
> > +    should be used to save vq-related information during system runnin=
g.
>
> Not a native speaker, but it looks better with
>
> "should be used by the userspace to store virtqueue specific information"=
.
>
> > Additionally,
> > +    the application must define its own structure to store information=
 for reconnection.
> > +
> > +2.5 Completed the initialization and running the application.
> > +    While the application is running, it is important to store relevan=
t information
> > +    about reconnections in mapped pages.
>
> I think we need some link/code examples to demonstrate what needs to be s=
tored.
>
> > When calling the ioctl VDUSE_VQ_GET_INFO to
> > +    get vq information, it's necessary to check whether it's a reconne=
ction.
>
> Better with some examples of codes.
>
> > If it is
> > +    a reconnection, the vq-related information must be get from the ma=
pped pages.
> > +
> > +2.6 When the Userspace application exits, it is necessary to unmap all=
 the
> > +    pages for reconnection
>
> This seems to be unnecessary, for example there could be an unexpected ex=
it.
>
> Thanks
>
Thanks Jason, I will send a new version
Thanks
Cindy
> > --
> > 2.43.0
> >
>


